#!/usr/bin/env bash
set -euo pipefail

usage() {
  printf 'usage: %s authorize <milestone-branch> <accepted-tip> <recorded-main-base> <evidence-binding-commit>\n' "$0" >&2
  printf '   or: %s integrate <milestone-branch> <accepted-tip> <recorded-main-base> <evidence-binding-commit>\n' "$0" >&2
  printf '   or: %s verify <milestone-branch> <accepted-tip> <recorded-main-base> <evidence-binding-commit>\n' "$0" >&2
  exit 64
}
refuse() { printf 'refused: %s\n' "$1" >&2; exit "$2"; }
partial() { printf 'partial: %s\n' "$1" >&2; exit 75; }

resolve_exact_commit() {
  local supplied="$1" label="$2" resolved
  if [[ ! "$supplied" =~ ^[0-9a-f]{40}$ ]] || ! resolved="$(git rev-parse --verify "$supplied^{commit}" 2>/dev/null)" || [[ "$resolved" != "$supplied" ]]; then
    refuse "$label is not an exact commit" 69
  fi
}
field() {
  local name="$1"
  awk -v prefix="$name: " 'index($0,prefix)==1 {count++; value=substr($0,length(prefix)+1)} END {if(count!=1 || value=="") exit 1; print value}' <<< "$artifact_text"
}
require_regular_blob() {
  local commit="$1" path="$2" label="$3" entry
  entry="$(git ls-tree "$commit" -- "$path" 2>/dev/null)"
  [[ "$entry" == 100644\ blob\ *$'\t'"$path" ]] || refuse "$label is not a regular file" 74
}
load_artifact() {
  local commit="$1" path="$2" label="$3"
  require_regular_blob "$commit" "$path" "$label"
  if ! artifact_text="$(git show "$commit:$path" 2>/dev/null)"; then refuse "$label is unreadable" 74; fi
}
latest_path_commit() {
  git log -1 --format=%H "$1" -- "$2" 2>/dev/null
}
require_exact_commit_change() {
  local commit="$1" expected_path="$2" allowed_status="$3" label="$4"
  local count=0 actual_status= actual_path=
  while IFS= read -r -d '' change_status && IFS= read -r -d '' change_path; do
    count=$((count + 1))
    actual_status="$change_status"
    actual_path="$change_path"
  done < <(git diff-tree --no-commit-id --name-status -r -z "$commit")
  [[ "$count" -eq 1 && "$actual_path" == "$expected_path" && "$allowed_status" == *"$actual_status"* ]] || refuse "$label commit changes unexpected paths" 74
}
valid_utc_timestamp() {
  local value="$1" year month day hour minute second max_day
  [[ "$value" =~ ^([0-9]{4})-([0-9]{2})-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})Z$ ]] || return 1
  year=$((10#${BASH_REMATCH[1]})); month=$((10#${BASH_REMATCH[2]})); day=$((10#${BASH_REMATCH[3]}))
  hour=$((10#${BASH_REMATCH[4]})); minute=$((10#${BASH_REMATCH[5]})); second=$((10#${BASH_REMATCH[6]}))
  (( year >= 1970 && month >= 1 && month <= 12 && day >= 1 && hour <= 23 && minute <= 59 && second <= 59 )) || return 1
  case "$month" in
    2) max_day=28; (( year % 4 != 0 || (year % 100 == 0 && year % 400 != 0) )) || max_day=29 ;;
    4|6|9|11) max_day=30 ;;
    *) max_day=31 ;;
  esac
  (( day <= max_day ))
}
resolve_remote_ref() {
  local ref="$1" output
  if ! output="$(git ls-remote --exit-code -- "$remote_endpoint" "$ref" 2>/dev/null)" || [[ -z "$output" || "$output" == *$'\n'* ]]; then return 1; fi
  printf '%s\n' "${output%%[[:space:]]*}"
}

[[ $# -eq 5 ]] || usage
mode="$1" milestone_branch="$2" accepted_tip="$3" recorded_main_base="$4" binding_commit="$5"
case "$mode" in authorize|integrate|verify) ;; *) usage ;; esac
if [[ ! "$milestone_branch" =~ ^milestone/(m[0-9]+)-[a-z0-9][a-z0-9-]*$ ]]; then refuse 'candidate branch is not a canonical milestone branch' 65; fi
milestone_key="${BASH_REMATCH[1]}"
milestone_id="$(printf '%s' "$milestone_key" | tr '[:lower:]' '[:upper:]')"
resolve_exact_commit "$accepted_tip" 'accepted tip'
resolve_exact_commit "$recorded_main_base" 'recorded main base'
resolve_exact_commit "$binding_commit" 'evidence binding commit'

milestone_ref="refs/heads/$milestone_branch"
main_ref='refs/heads/main'
main_refspec="$main_ref:$main_ref"
evidence_ref='refs/heads/governance/decision-evidence'
binding_path="docs/orchestration/decisions/$milestone_key/bindings/main-integration.md"
contract_path="docs/orchestration/milestones/${milestone_id}_CONTRACT.md"
completion_path="docs/orchestration/milestones/$milestone_key/evidence/completion-package.md"
acceptance_binding_path="docs/orchestration/decisions/$milestone_key/bindings/milestone-acceptance.md"

if ! milestone_sha="$(git rev-parse --verify "$milestone_ref^{commit}" 2>/dev/null)" || [[ "$milestone_sha" != "$accepted_tip" ]]; then refuse 'milestone branch tip differs from accepted tip' 67; fi
if ! git merge-base --is-ancestor "$recorded_main_base" "$accepted_tip"; then refuse 'accepted tip is not a fast-forward from recorded main' 69; fi
if ! evidence_sha="$(git rev-parse --verify "$evidence_ref^{commit}" 2>/dev/null)" || [[ "$evidence_sha" != "$binding_commit" ]]; then refuse 'local or remote evidence tip differs from binding commit' 67; fi

if ! fetch_endpoints="$(git remote get-url --all origin 2>/dev/null)" || ! push_endpoints="$(git remote get-url --push --all origin 2>/dev/null)"; then refuse 'origin endpoints cannot be resolved' 73; fi
if [[ -z "$fetch_endpoints" || "$fetch_endpoints" == *$'\n'* || -z "$push_endpoints" || "$push_endpoints" == *$'\n'* || "$fetch_endpoints" != "$push_endpoints" ]]; then refuse 'origin must have one identical fetch and push endpoint' 73; fi
remote_endpoint="$push_endpoints"
if git remote get-url -- "$remote_endpoint" >/dev/null 2>&1; then refuse 'resolved endpoint is also a configured remote name' 73; fi
while IFS= read -r -d '' rewrite; do
  rewrite_prefix="${rewrite#*$'\n'}"
  [[ "$remote_endpoint" != "$rewrite_prefix"* ]] || refuse 'resolved endpoint can be rewritten again' 73
done < <(git config --null --get-regexp '^url\..*\.(insteadof|pushinsteadof)$')
if ! remote_evidence_sha="$(resolve_remote_ref "$evidence_ref")" || [[ "$remote_evidence_sha" != "$binding_commit" ]]; then refuse 'local or remote evidence tip differs from binding commit' 67; fi
if [[ "$(latest_path_commit "$binding_commit" "$binding_path")" != "$binding_commit" ]]; then refuse 'binding commit is not the latest canonical binding change' 74; fi

load_artifact "$binding_commit" "$binding_path" 'canonical main-integration binding'
if ! binding_status="$(field 'Binding status')" || ! binding_milestone="$(field 'Milestone')" || ! binding_milestone_state="$(field 'Milestone state')" ||
   ! binding_integration_state="$(field 'Integration state')" || ! package_commit="$(field 'Package commit')" || ! package_path="$(field 'Package path')" ||
   ! verdict_commit="$(field 'Verdict commit')" || ! verdict_path="$(field 'Verdict path')" || ! binding_candidate="$(field 'Accepted milestone tip')" ||
   ! binding_main="$(field 'Target main commit')" || ! binding_critical="$(field 'Critical findings')" || ! binding_important="$(field 'Important findings')"; then
  refuse 'binding is missing required fields' 74
fi
if [[ "$binding_status" != Current || "$binding_milestone" != "$milestone_id" || "$binding_milestone_state" != Accepted || "$binding_integration_state" != Pending || "$binding_critical" != 0 || "$binding_important" != 0 ]]; then refuse 'binding does not authorize pending main integration' 74; fi
[[ "$binding_candidate" == "$accepted_tip" ]] || refuse 'binding accepted tip differs from requested tip' 74
[[ "$binding_main" == "$recorded_main_base" ]] || refuse 'binding target main differs from recorded base' 74
[[ "$package_path" =~ ^docs/orchestration/decisions/$milestone_key/packages/[a-z0-9][a-z0-9-]*\.md$ ]] || refuse 'package path is not canonical' 74
[[ "$verdict_path" =~ ^docs/orchestration/decisions/$milestone_key/verdicts/[a-z0-9][a-z0-9-]*\.md$ ]] || refuse 'verdict path is not canonical' 74
resolve_exact_commit "$package_commit" 'package commit'
resolve_exact_commit "$verdict_commit" 'verdict commit'
[[ "$(git rev-parse "$binding_commit^")" == "$verdict_commit" && "$(git rev-parse "$verdict_commit^")" == "$package_commit" ]] || refuse 'package, verdict, and binding are not three ordered commits' 74
require_exact_commit_change "$package_commit" "$package_path" A 'main-integration package'
require_exact_commit_change "$verdict_commit" "$verdict_path" A 'main-integration verdict'
require_exact_commit_change "$binding_commit" "$binding_path" AM 'main-integration binding'

load_artifact "$package_commit" "$package_path" 'canonical acceptance package'
if ! package_milestone="$(field 'Milestone')" || ! package_contract_commit="$(field 'Contract commit')" || ! package_contract_path="$(field 'Contract path')" ||
   ! package_candidate="$(field 'Reviewed candidate')" || ! package_completion_commit="$(field 'Completion package commit')" || ! package_completion_path="$(field 'Completion package path')" ||
   ! qa_commit="$(field 'QA review commit')" || ! qa_artifact_path="$(field 'QA review path')" || ! licensing_commit="$(field 'Licensing review commit')" ||
   ! licensing_path="$(field 'Licensing review path')" || ! final_commit="$(field 'Final review commit')" || ! final_artifact_path="$(field 'Final review path')" ||
   ! acceptance_binding_commit="$(field 'Milestone acceptance binding commit')" || ! package_acceptance_path="$(field 'Milestone acceptance binding path')" ||
   ! package_main="$(field 'Target main commit')" || ! package_critical="$(field 'Critical findings')" || ! package_important="$(field 'Important findings')" ||
   ! package_limitations="$(field 'Limitations')" || ! package_recovery="$(field 'Recovery')"; then refuse 'acceptance package is missing required fields' 74; fi
[[ "$package_milestone" == "$milestone_id" && "$package_candidate" == "$accepted_tip" && "$package_main" == "$recorded_main_base" && "$package_critical" == 0 && "$package_important" == 0 ]] || refuse 'acceptance package does not bind the requested integration' 74
[[ "$package_contract_path" == "$contract_path" && "$package_completion_path" == "$completion_path" ]] || refuse 'contract or completion package path is not canonical' 74
[[ "$package_acceptance_path" == "$acceptance_binding_path" ]] || refuse 'milestone acceptance binding path is not canonical' 74
[[ "$qa_artifact_path" =~ ^docs/orchestration/reviews/$milestone_key/[a-z0-9][a-z0-9-]*\.md$ && "$licensing_path" =~ ^docs/orchestration/reviews/$milestone_key/[a-z0-9][a-z0-9-]*\.md$ && "$final_artifact_path" =~ ^docs/orchestration/reviews/$milestone_key/[a-z0-9][a-z0-9-]*\.md$ ]] || refuse 'review path is not canonical' 74

for exact in "$package_contract_commit" "$package_completion_commit" "$qa_commit" "$licensing_commit" "$final_commit" "$acceptance_binding_commit"; do resolve_exact_commit "$exact" 'package evidence commit'; done
require_regular_blob "$package_contract_commit" "$package_contract_path" 'contract artifact'
require_regular_blob "$package_completion_commit" "$package_completion_path" 'completion package artifact'
require_regular_blob "$qa_commit" "$qa_artifact_path" 'QA review artifact'
require_regular_blob "$licensing_commit" "$licensing_path" 'Licensing review artifact'
require_regular_blob "$final_commit" "$final_artifact_path" 'Final review artifact'
for candidate_evidence_commit in "$package_contract_commit" "$package_completion_commit" "$qa_commit" "$licensing_commit" "$final_commit"; do
  git merge-base --is-ancestor "$candidate_evidence_commit" "$accepted_tip" || refuse 'canonical package artifact is outside accepted milestone history' 74
done
git merge-base --is-ancestor "$acceptance_binding_commit" "$package_commit" || refuse 'milestone acceptance binding is not an ancestor of package' 74
[[ "$(latest_path_commit "$binding_commit" "$acceptance_binding_path")" == "$acceptance_binding_commit" ]] || refuse 'milestone acceptance binding is not current at final evidence tip' 74

load_artifact "$acceptance_binding_commit" "$acceptance_binding_path" 'milestone acceptance binding'
if ! acceptance_status="$(field 'Binding status')" || ! acceptance_milestone="$(field 'Milestone')" || ! acceptance_state="$(field 'Milestone state')" ||
   ! acceptance_package_commit="$(field 'Package commit')" || ! acceptance_package_path="$(field 'Package path')" ||
   ! acceptance_candidate="$(field 'Accepted milestone tip')" || ! acceptance_main="$(field 'Target main commit')" || ! acceptance_verdict_commit="$(field 'Verdict commit')" ||
   ! acceptance_verdict_path_value="$(field 'Verdict path')" || ! acceptance_critical="$(field 'Critical findings')" || ! acceptance_important="$(field 'Important findings')"; then refuse 'milestone acceptance binding is missing fields' 74; fi
[[ "$acceptance_status" == Current && "$acceptance_milestone" == "$milestone_id" && "$acceptance_state" == Accepted && "$acceptance_candidate" == "$accepted_tip" && "$acceptance_main" == "$recorded_main_base" && "$acceptance_critical" == 0 && "$acceptance_important" == 0 ]] || refuse 'milestone acceptance binding does not accept requested tip' 74
[[ "$acceptance_package_path" =~ ^docs/orchestration/decisions/$milestone_key/packages/milestone-acceptance-[a-z0-9-]+\.md$ ]] || refuse 'milestone acceptance package path is not canonical' 74
[[ "$acceptance_verdict_path_value" =~ ^docs/orchestration/decisions/$milestone_key/verdicts/milestone-acceptance-[a-z0-9-]+\.md$ ]] || refuse 'milestone acceptance verdict path is not canonical' 74
resolve_exact_commit "$acceptance_package_commit" 'milestone acceptance package commit'
resolve_exact_commit "$acceptance_verdict_commit" 'milestone acceptance verdict commit'
[[ "$(git rev-parse "$acceptance_binding_commit^")" == "$acceptance_verdict_commit" && "$(git rev-parse "$acceptance_verdict_commit^")" == "$acceptance_package_commit" ]] || refuse 'milestone acceptance package, verdict, and binding are not three ordered commits' 74
require_exact_commit_change "$acceptance_package_commit" "$acceptance_package_path" A 'milestone acceptance package'
require_exact_commit_change "$acceptance_verdict_commit" "$acceptance_verdict_path_value" A 'milestone acceptance verdict'
require_exact_commit_change "$acceptance_binding_commit" "$acceptance_binding_path" AM 'milestone acceptance binding'

load_artifact "$acceptance_package_commit" "$acceptance_package_path" 'milestone acceptance package'
if ! acceptance_package_milestone="$(field 'Milestone')" || ! acceptance_package_contract_commit="$(field 'Contract commit')" || ! acceptance_package_contract_path="$(field 'Contract path')" ||
   ! acceptance_package_candidate="$(field 'Reviewed candidate')" || ! acceptance_package_completion_commit="$(field 'Completion package commit')" || ! acceptance_package_completion_path="$(field 'Completion package path')" ||
   ! acceptance_package_qa_commit="$(field 'QA review commit')" || ! acceptance_package_qa_path="$(field 'QA review path')" || ! acceptance_package_licensing_commit="$(field 'Licensing review commit')" ||
   ! acceptance_package_licensing_path="$(field 'Licensing review path')" || ! acceptance_package_final_commit="$(field 'Final review commit')" || ! acceptance_package_final_path="$(field 'Final review path')" ||
   ! acceptance_package_main="$(field 'Target main commit')" || ! acceptance_package_critical="$(field 'Critical findings')" || ! acceptance_package_important="$(field 'Important findings')" ||
   ! acceptance_package_limitations="$(field 'Limitations')" || ! acceptance_package_recovery="$(field 'Recovery')"; then refuse 'milestone acceptance package is missing required fields' 74; fi
[[ "$acceptance_package_milestone" == "$milestone_id" && "$acceptance_package_candidate" == "$accepted_tip" && "$acceptance_package_main" == "$recorded_main_base" && "$acceptance_package_critical" == 0 && "$acceptance_package_important" == 0 ]] || refuse 'milestone acceptance package does not bind requested tip' 74
[[ "$acceptance_package_contract_commit" == "$package_contract_commit" && "$acceptance_package_contract_path" == "$contract_path" && "$acceptance_package_completion_commit" == "$package_completion_commit" && "$acceptance_package_completion_path" == "$completion_path" ]] || refuse 'milestone acceptance package conflicts with contract or completion evidence' 74
[[ "$acceptance_package_qa_commit" == "$qa_commit" && "$acceptance_package_qa_path" == "$qa_artifact_path" && "$acceptance_package_licensing_commit" == "$licensing_commit" && "$acceptance_package_licensing_path" == "$licensing_path" && "$acceptance_package_final_commit" == "$final_commit" && "$acceptance_package_final_path" == "$final_artifact_path" ]] || refuse 'milestone acceptance package conflicts with review evidence' 74

load_artifact "$acceptance_verdict_commit" "$acceptance_verdict_path_value" 'milestone acceptance verdict'
if ! acceptance_controller="$(field 'Controller recorder')" || ! acceptance_role="$(field 'Steward role')" || ! acceptance_session="$(field 'Steward session')" || ! acceptance_timestamp="$(field 'Recorded timestamp')" ||
   ! acceptance_verdict_package_commit="$(field 'Evidence package commit')" || ! acceptance_verdict_package_path="$(field 'Evidence package path')" || ! acceptance_verdict="$(field 'Verdict')" || ! acceptance_verdict_candidate="$(field 'Reviewed candidate')" || ! acceptance_verdict_main="$(field 'Target main commit')" || ! acceptance_verdict_critical="$(field 'Critical findings')" || ! acceptance_verdict_important="$(field 'Important findings')"; then refuse 'milestone acceptance verdict is missing fields' 74; fi
[[ "$acceptance_controller" == program-controller && "$acceptance_role" == decision_steward && "$acceptance_session" =~ ^[A-Za-z0-9][A-Za-z0-9._:-]*$ ]] && valid_utc_timestamp "$acceptance_timestamp" || refuse 'milestone acceptance Steward provenance is invalid' 74
[[ "$acceptance_verdict_package_commit" == "$acceptance_package_commit" && "$acceptance_verdict_package_path" == "$acceptance_package_path" ]] || refuse 'milestone acceptance verdict does not bind canonical package' 74
[[ "$acceptance_verdict" == APPROVE_MILESTONE && "$acceptance_verdict_candidate" == "$accepted_tip" && "$acceptance_verdict_main" == "$recorded_main_base" && "$acceptance_verdict_critical" == 0 && "$acceptance_verdict_important" == 0 ]] || refuse 'milestone acceptance verdict does not accept requested tip' 74

load_artifact "$verdict_commit" "$verdict_path" 'canonical main-integration verdict'
if ! verdict_controller="$(field 'Controller recorder')" || ! verdict_role="$(field 'Steward role')" || ! verdict_session="$(field 'Steward session')" || ! verdict_timestamp="$(field 'Recorded timestamp')" ||
   ! verdict_package_commit="$(field 'Evidence package commit')" || ! verdict_package_path="$(field 'Evidence package path')" || ! verdict="$(field 'Verdict')" ||
   ! verdict_milestone="$(field 'Milestone')" || ! verdict_contract="$(field 'Contract commit')" || ! verdict_candidate="$(field 'Reviewed candidate')" ||
   ! verdict_completion="$(field 'Completion package commit')" || ! verdict_main="$(field 'Target main commit')" || ! verdict_critical="$(field 'Critical findings')" || ! verdict_important="$(field 'Important findings')"; then refuse 'verdict is missing required approval fields' 74; fi
[[ "$verdict_controller" == program-controller && "$verdict_role" == decision_steward && "$verdict_session" =~ ^[A-Za-z0-9][A-Za-z0-9._:-]*$ ]] && valid_utc_timestamp "$verdict_timestamp" || refuse 'main-integration Steward provenance is invalid' 74
[[ "$verdict_package_commit" == "$package_commit" && "$verdict_package_path" == "$package_path" ]] || refuse 'verdict does not bind canonical package' 74
[[ "$verdict" == APPROVE_MAIN_INTEGRATION ]] || refuse 'verdict does not approve main integration' 74
[[ "$verdict_milestone" == "$milestone_id" && "$verdict_contract" == "$package_contract_commit" && "$verdict_completion" == "$package_completion_commit" ]] || refuse 'verdict package fields conflict' 74
[[ "$verdict_candidate" == "$accepted_tip" ]] || refuse 'verdict reviewed candidate differs from accepted tip' 74
[[ "$verdict_main" == "$recorded_main_base" && "$verdict_critical" == 0 && "$verdict_important" == 0 ]] || refuse 'verdict target or findings do not authorize integration' 74

if ! checked_out="$(git symbolic-ref --quiet --short HEAD 2>/dev/null)" || [[ "$checked_out" != main ]]; then refuse 'checked-out branch is not main' 71; fi
[[ -z "$(git status --porcelain)" ]] || refuse 'worktree is not clean' 70
local_main_sha="$(git rev-parse --verify "$main_ref^{commit}" 2>/dev/null)" || refuse 'local main does not resolve to a commit' 68
remote_main_sha="$(resolve_remote_ref "$main_ref")" || refuse 'remote main does not resolve unambiguously to a commit' 68
case "$mode" in
  authorize|integrate)
    [[ "$local_main_sha" == "$recorded_main_base" ]] || refuse 'local main differs from recorded base' 67
    [[ "$remote_main_sha" == "$recorded_main_base" ]] || refuse 'remote main differs from recorded base' 67
    ;;
  verify)
    [[ "$local_main_sha" == "$accepted_tip" && "$remote_main_sha" == "$accepted_tip" ]] || refuse 'integrated local and remote main do not equal accepted tip' 67
    ;;
esac

pre_refs="$(git show-ref)"
pre_status="$(git status --porcelain=v1 --untracked-files=all)"
pre_diff="$(git diff --binary)"
pre_cached_diff="$(git diff --cached --binary)"
capture_head_state() {
  local symbolic commit
  if symbolic="$(git symbolic-ref --quiet HEAD 2>/dev/null)"; then
    printf 'symbolic:%s\n' "$symbolic"
  elif commit="$(git rev-parse --verify HEAD 2>/dev/null)"; then
    printf 'detached:%s\n' "$commit"
  else
    printf 'unresolved\n'
  fi
}
pre_head_state="$(capture_head_state)"
capture_pseudoref() {
  local ref="$1" value
  if value="$(git rev-parse --verify "$ref" 2>/dev/null)"; then printf 'present:%s\n' "$value"; else printf 'absent\n'; fi
}
pre_orig_head="$(capture_pseudoref ORIG_HEAD)"
pre_merge_head="$(capture_pseudoref MERGE_HEAD)"
pre_cherry_pick_head="$(capture_pseudoref CHERRY_PICK_HEAD)"
pre_revert_head="$(capture_pseudoref REVERT_HEAD)"
restore_pseudoref() {
  local ref="$1" snapshot="$2" current
  current="$(capture_pseudoref "$ref")"
  [[ "$current" == "$snapshot" ]] && return 0
  case "$snapshot" in
    present:*) git update-ref "$ref" "${snapshot#present:}" ;;
    absent) git update-ref -d "$ref" ;;
    *) return 1 ;;
  esac
}
restore_head_state() {
  local snapshot="$1"
  [[ "$(capture_head_state)" == "$snapshot" ]] && return 0
  case "$snapshot" in
    symbolic:*) git symbolic-ref HEAD "${snapshot#symbolic:}" || return 1 ;;
    detached:*) git update-ref --no-deref HEAD "${snapshot#detached:}" || return 1 ;;
    *) return 1 ;;
  esac
  [[ "$(capture_head_state)" == "$snapshot" ]]
}
restore_local_main_base() {
  local current_main
  current_main="$(git rev-parse --verify "$main_ref^{commit}" 2>/dev/null)" || return 1
  git update-ref "$main_ref" "$recorded_main_base" "$current_main" || return 1
  git restore --source="$recorded_main_base" --staged --worktree -- :/ || return 1
  restore_head_state "$pre_head_state" || return 1
  restore_pseudoref ORIG_HEAD "$pre_orig_head" || return 1
  restore_pseudoref MERGE_HEAD "$pre_merge_head" || return 1
  restore_pseudoref CHERRY_PICK_HEAD "$pre_cherry_pick_head" || return 1
  restore_pseudoref REVERT_HEAD "$pre_revert_head" || return 1
  [[ "$(capture_head_state)" == "$pre_head_state" && "$(git rev-parse HEAD)" == "$recorded_main_base" && "$(git show-ref)" == "$pre_refs" && "$(git status --porcelain=v1 --untracked-files=all)" == "$pre_status" && "$(git diff --binary)" == "$pre_diff" && "$(git diff --cached --binary)" == "$pre_cached_diff" && "$(capture_pseudoref ORIG_HEAD)" == "$pre_orig_head" && "$(capture_pseudoref MERGE_HEAD)" == "$pre_merge_head" && "$(capture_pseudoref CHERRY_PICK_HEAD)" == "$pre_cherry_pick_head" && "$(capture_pseudoref REVERT_HEAD)" == "$pre_revert_head" ]]
}
evidence_tip_is_current() {
  [[ "$(git rev-parse --verify "$evidence_ref^{commit}" 2>/dev/null)" == "$binding_commit" ]] || return 1
  [[ "$(resolve_remote_ref "$evidence_ref")" == "$binding_commit" ]]
}
case "$mode" in
  authorize) printf 'authorized:%s:%s:%s\n' "$milestone_branch" "$accepted_tip" "$main_refspec" ;;
  integrate)
    evidence_tip_is_current || refuse 'evidence binding changed before integration' 67
    if ! git -c core.hooksPath=/dev/null merge --ff-only "$accepted_tip"; then
      if restore_local_main_base && [[ "$(resolve_remote_ref "$main_ref")" == "$recorded_main_base" ]] && evidence_tip_is_current; then
        refuse 'fast-forward merge failed; complete pre-integration state restored' 72
      fi
      partial 'fast-forward merge failed and complete pre-integration state is unproved; recovery required'
    fi
    [[ "$(git rev-parse "$main_ref")" == "$accepted_tip" ]] || partial 'local main differs from accepted tip after merge; recovery required'
    if ! git -c core.hooksPath=/dev/null push --no-follow-tags --no-signed -- "$remote_endpoint" "$main_refspec"; then
      if remote_main_sha="$(resolve_remote_ref "$main_ref")"; then
        if [[ "$remote_main_sha" == "$accepted_tip" ]]; then
          evidence_tip_is_current || partial 'evidence binding changed during integration; recovery required'
          printf 'integrated:%s:%s:%s\n' "$milestone_branch" "$accepted_tip" "$main_refspec"
          exit 0
        fi
        if restore_local_main_base; then
          [[ "$remote_main_sha" == "$recorded_main_base" ]] && refuse 'constrained main push failed; local main restored' 72
          partial 'constrained main push failed and remote main moved; local main restored'
        fi
        partial 'constrained main push failed and local main could not be restored'
      fi
      partial 'constrained main push result is unverifiable; local main remains at accepted tip'
    fi
    remote_main_sha="$(resolve_remote_ref "$main_ref")" || partial 'remote main is unverifiable after push; recovery required'
    [[ "$remote_main_sha" == "$accepted_tip" ]] || partial 'remote main differs from accepted tip after push; recovery required'
    evidence_tip_is_current || partial 'evidence binding changed during integration; recovery required'
    printf 'integrated:%s:%s:%s\n' "$milestone_branch" "$accepted_tip" "$main_refspec"
    ;;
  verify) printf 'verified:%s:%s:%s\n' "$milestone_branch" "$accepted_tip" "$main_refspec" ;;
esac
