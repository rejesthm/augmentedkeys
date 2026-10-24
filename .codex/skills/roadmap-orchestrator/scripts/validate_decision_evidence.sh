#!/usr/bin/env bash
set -euo pipefail

usage() {
  printf 'usage: %s authorize <candidate-tip> <recorded-governance-base>\n' "$0" >&2
  printf '   or: %s push <candidate-tip> <recorded-governance-base>\n' "$0" >&2
  printf '   or: %s verify <candidate-tip> <recorded-governance-base>\n' "$0" >&2
  exit 64
}

refuse() {
  printf 'refused: %s\n' "$1" >&2
  exit "$2"
}

partial() {
  printf 'partial: %s\n' "$1" >&2
  exit 75
}

resolve_exact_commit() {
  local supplied="$1"
  local label="$2"
  local resolved
  if [[ ! "$supplied" =~ ^[0-9a-f]{40}$ ]] ||
     ! resolved="$(git rev-parse --verify "$supplied^{commit}" 2>/dev/null)" ||
     [[ "$resolved" != "$supplied" ]]; then
    refuse "$label is not an exact commit" 69
  fi
}

field_from_text() {
  local text_value="$1" name="$2"
  awk -v prefix="$name: " 'index($0,prefix)==1 {count++; value=substr($0,length(prefix)+1)} END {if(count!=1 || value=="") exit 1; print value}' <<< "$text_value"
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

require_regular_blob() {
  local commit="$1" path="$2" label="$3" entry
  entry="$(git ls-tree "$commit" -- "$path" 2>/dev/null)"
  [[ "$entry" == 100644\ blob\ *$'\t'"$path" ]] || refuse "$label is not a regular file" 74
}

require_exact_single_change() {
  local commit="$1" expected="$2" label="$3" count=0 status= path= actual_status= actual_path=
  while IFS= read -r -d '' status && IFS= read -r -d '' path; do
    count=$((count + 1)); actual_status="$status"; actual_path="$path"
  done < <(git diff-tree --no-commit-id --name-status -r -z "$commit")
  [[ "$count" -eq 1 && "$actual_status" == A && "$actual_path" == "$expected" ]] || refuse "$label commit changes unexpected paths" 74
}

validate_review() {
  local review_commit="$1" review_path="$2" expected_role="$3" expected_candidate="$4"
  local text controller role session timestamp candidate verification runtime_hash output_hash verdict critical important minor
  resolve_exact_commit "$review_commit" 'review commit'
  [[ "$review_path" =~ ^docs/orchestration/decisions/m[0-9]+/reviews/[a-z0-9][a-z0-9-]*\.md$ ]] || refuse 'review path is not canonical' 74
  require_exact_single_change "$review_commit" "$review_path" 'review'
  require_regular_blob "$review_commit" "$review_path" 'review artifact'
  git merge-base --is-ancestor "$base_binding_commit" "$review_commit" || refuse 'review commit is outside evidence history' 74
  git merge-base --is-ancestor "$review_commit" "$current_package_commit" || refuse 'review commit does not precede consuming package' 74
  if git merge-base --is-ancestor "$review_commit" "$expected_candidate"; then refuse 'review commit is an ancestor of reviewed candidate' 74; fi
  text="$(git show "$review_commit:$review_path" 2>/dev/null)" || refuse 'review artifact is unreadable' 74
  controller="$(field_from_text "$text" 'Controller recorder')" || refuse 'review provenance is invalid' 74
  role="$(field_from_text "$text" 'Reviewer role')" || refuse 'review provenance is invalid' 74
  session="$(field_from_text "$text" 'Reviewer session')" || refuse 'review provenance is invalid' 74
  timestamp="$(field_from_text "$text" 'Recorded timestamp')" || refuse 'review provenance is invalid' 74
  candidate="$(field_from_text "$text" 'Reviewed candidate')" || refuse 'review provenance is invalid' 74
  verification="$(field_from_text "$text" 'Verification evidence commit')" || refuse 'review provenance is invalid' 74
  runtime_hash="$(field_from_text "$text" 'Runtime evidence SHA-256')" || refuse 'review provenance is invalid' 74
  output_hash="$(field_from_text "$text" 'Full review output SHA-256')" || refuse 'review provenance is invalid' 74
  verdict="$(field_from_text "$text" 'Verdict')" || refuse 'review provenance is invalid' 74
  critical="$(field_from_text "$text" 'Critical findings')" || refuse 'review provenance is invalid' 74
  important="$(field_from_text "$text" 'Important findings')" || refuse 'review provenance is invalid' 74
  minor="$(field_from_text "$text" 'Minor findings')" || refuse 'review provenance is invalid' 74
  [[ "$controller" == program-controller && "$role" == "$expected_role" && "$session" =~ ^[A-Za-z0-9][A-Za-z0-9._:-]*$ ]] || refuse 'review provenance is invalid' 74
  valid_utc_timestamp "$timestamp" || refuse 'review provenance is invalid' 74
  [[ "$runtime_hash" =~ ^[0-9a-f]{64}$ && "$output_hash" =~ ^[0-9a-f]{64}$ ]] || refuse 'review provenance is invalid' 74
  resolve_exact_commit "$candidate" 'reviewed candidate'
  resolve_exact_commit "$verification" 'verification evidence commit'
  [[ "$candidate" == "$expected_candidate" ]] || refuse 'review candidate differs from package candidate' 74
  [[ "$verdict" == APPROVE && "$critical" == 0 && "$important" == 0 && "$minor" =~ ^[0-9]+$ ]] || refuse 'review does not approve without blocking findings' 74
}

validate_package_reviews() {
  local commit="$1" path="$2" text reviewed
  local qa_commit qa_path security_commit security_path final_commit final_path
  current_package_commit="$commit"
  text="$(git show "$commit:$path" 2>/dev/null)" || refuse 'package artifact is unreadable' 74
  reviewed="$(field_from_text "$text" 'Reviewed candidate')" || refuse 'package is missing reviewed candidate' 74
  qa_commit="$(field_from_text "$text" 'QA review commit')" || refuse 'package is missing review bindings' 74
  qa_path="$(field_from_text "$text" 'QA review path')" || refuse 'package is missing review bindings' 74
  security_commit="$(field_from_text "$text" 'Licensing review commit')" || refuse 'package is missing review bindings' 74
  security_path="$(field_from_text "$text" 'Licensing review path')" || refuse 'package is missing review bindings' 74
  final_commit="$(field_from_text "$text" 'Final review commit')" || refuse 'package is missing review bindings' 74
  final_path="$(field_from_text "$text" 'Final review path')" || refuse 'package is missing review bindings' 74
  resolve_exact_commit "$reviewed" 'package reviewed candidate'
  if git merge-base --is-ancestor "$commit" "$reviewed"; then refuse 'package commit is an ancestor of reviewed candidate' 74; fi
  validate_review "$qa_commit" "$qa_path" qa_performance_verifier "$reviewed"
  validate_review "$security_commit" "$security_path" licensing_security_reviewer "$reviewed"
  validate_review "$final_commit" "$final_path" final_code_reviewer "$reviewed"
}

if [[ $# -ne 3 ]]; then
  usage
fi

mode="$1"
candidate_tip="$2"
governance_base="$3"

reviewed_guard_commit="${AUGMENTEDKEYS_REVIEWED_GUARD_COMMIT:-}"
reviewed_guard_sha="${AUGMENTEDKEYS_REVIEWED_GUARD_SHA256:-}"
resolve_exact_commit "$reviewed_guard_commit" 'reviewed guard commit'
[[ "$reviewed_guard_sha" =~ ^[0-9a-f]{64}$ ]] || refuse 'reviewed guard SHA-256 is invalid' 74
guard_path='.codex/skills/roadmap-orchestrator/scripts/validate_decision_evidence.sh'
guard_entry="$(git ls-tree "$reviewed_guard_commit" -- "$guard_path" 2>/dev/null)"
[[ "$guard_entry" == 100755\ blob\ *$'\t'"$guard_path" ]] || refuse 'reviewed guard artifact is missing or non-executable' 74
guard_object_sha="$(git show "$reviewed_guard_commit:$guard_path" | shasum -a 256 | awk '{print $1}')"
guard_runtime_sha="$(shasum -a 256 "${BASH_SOURCE[0]}" | awk '{print $1}')"
[[ "$guard_object_sha" == "$reviewed_guard_sha" && "$guard_runtime_sha" == "$reviewed_guard_sha" ]] || refuse 'executed guard differs from reviewed guard artifact' 74

case "$mode" in
  authorize|push|verify) ;;
  *) usage ;;
esac

branch='governance/decision-evidence'
local_ref="refs/heads/$branch"
refspec="$local_ref:$local_ref"
base_binding_path='docs/orchestration/decisions/governance-base.md'

resolve_exact_commit "$candidate_tip" 'candidate tip'
resolve_exact_commit "$governance_base" 'recorded governance base'
if ! local_sha="$(git rev-parse --verify "$local_ref^{commit}" 2>/dev/null)" || [[ "$local_sha" != "$candidate_tip" ]]; then
  refuse 'local evidence branch tip differs from candidate tip' 67
fi
if ! git merge-base --is-ancestor "$governance_base" "$candidate_tip"; then
  refuse 'evidence candidate does not descend from recorded governance base' 69
fi
base_entry="$(git ls-tree "$candidate_tip" -- "$base_binding_path")"
[[ "$base_entry" == 100644\ blob\ *$'\t'"$base_binding_path" ]] || refuse 'governance base binding is not a regular canonical file' 74
base_binding_text="$(git show "$candidate_tip:$base_binding_path" 2>/dev/null)" || refuse 'governance base binding is unreadable' 74
bound_governance_base="$(awk 'index($0,"Governance base: ")==1 {count++; value=substr($0,18)} END {if(count!=1 || value=="") exit 1; print value}' <<< "$base_binding_text")" || refuse 'governance base binding is missing its exact base' 74
[[ "$bound_governance_base" == "$governance_base" ]] || refuse 'governance base binding differs from recorded base' 74
base_binding_commit="$(git log --diff-filter=A --format=%H --reverse "$candidate_tip" -- "$base_binding_path" | head -n 1)"
resolve_exact_commit "$base_binding_commit" 'governance base binding commit'
[[ "$(git rev-list --parents -n 1 "$base_binding_commit")" == "$base_binding_commit $governance_base" ]] || refuse 'governance base binding is not the direct child of recorded base' 74
[[ "$(git log -1 --format=%H "$candidate_tip" -- "$base_binding_path")" == "$base_binding_commit" ]] || refuse 'governance base binding was rewritten' 74
[[ -z "$(git rev-list --min-parents=2 "$governance_base..$candidate_tip")" ]] || refuse 'evidence history contains a merge commit' 74
sequence_stage=anchor
while IFS= read -r evidence_commit; do
  change_count=0
  commit_status=
  commit_path=
  while IFS= read -r -d '' change_status && IFS= read -r -d '' historical_path; do
    change_count=$((change_count + 1))
    commit_status="$change_status"
    commit_path="$historical_path"
    case "$historical_path" in
      docs/orchestration/decisions/*) ;;
      *) refuse 'evidence history contains a path outside docs/orchestration/decisions' 74 ;;
    esac
    [[ "$change_status" != D* ]] || refuse 'evidence history deletes canonical evidence' 74
    historical_entry="$(git ls-tree "$evidence_commit" -- "$historical_path")"
    [[ "$historical_entry" == 100644\ blob\ *$'\t'"$historical_path" ]] || refuse 'evidence history contains a non-regular evidence file' 74
    if [[ "$historical_path" == "$base_binding_path" ]]; then
      [[ "$change_status" == A && "$evidence_commit" == "$base_binding_commit" ]] || refuse 'governance base binding is not immutable' 74
    elif [[ "$historical_path" =~ ^docs/orchestration/decisions/m[0-9]+/(packages|verdicts|results|reviews)/[a-z0-9][a-z0-9-]*\.md$ ]]; then
      [[ "$change_status" == A ]] || refuse 'immutable evidence file is not add-only' 74
    elif [[ "$historical_path" =~ ^docs/orchestration/decisions/m[0-9]+/bindings/[a-z0-9][a-z0-9-]*\.md$ ]]; then
      [[ "$change_status" == A || "$change_status" == M ]] || refuse 'binding history is not append-only' 74
    else
      refuse 'evidence history contains a noncanonical evidence path' 74
    fi
  done < <(git diff-tree --no-commit-id --name-status -r -z "$evidence_commit")
  [[ "$change_count" -eq 1 ]] || refuse 'evidence commit must change exactly one canonical path' 74
  case "$sequence_stage" in
    anchor)
      [[ "$evidence_commit" == "$base_binding_commit" && "$commit_status" == A && "$commit_path" == "$base_binding_path" ]] || refuse 'governance base binding commit changes unexpected paths' 74
      sequence_stage=package
      ;;
    package)
      if [[ "$commit_status" == A && "$commit_path" =~ ^docs/orchestration/decisions/m[0-9]+/reviews/[a-z0-9][a-z0-9-]*\.md$ ]]; then
        sequence_stage=package
      elif [[ "$commit_status" == A && "$commit_path" =~ ^docs/orchestration/decisions/m[0-9]+/packages/[a-z0-9][a-z0-9-]*\.md$ ]]; then
        validate_package_reviews "$evidence_commit" "$commit_path"
        sequence_stage=verdict
      elif [[ "$commit_status" == A && "$commit_path" =~ ^docs/orchestration/decisions/m[0-9]+/results/[a-z0-9][a-z0-9-]*\.md$ ]]; then
        sequence_stage=result_binding
      else
        refuse 'evidence sequence expected one package or result commit' 74
      fi
      ;;
    verdict)
      [[ "$commit_status" == A && "$commit_path" =~ ^docs/orchestration/decisions/m[0-9]+/verdicts/[a-z0-9][a-z0-9-]*\.md$ ]] || refuse 'evidence sequence expected one verdict commit' 74
      sequence_stage=binding
      ;;
    binding|result_binding)
      [[ ( "$commit_status" == A || "$commit_status" == M ) && "$commit_path" =~ ^docs/orchestration/decisions/m[0-9]+/bindings/[a-z0-9][a-z0-9-]*\.md$ ]] || refuse 'evidence sequence expected one binding commit' 74
      sequence_stage=package
      ;;
  esac
done < <(git rev-list --reverse "$governance_base..$candidate_tip")
[[ "$sequence_stage" == package ]] || refuse 'evidence branch ends with an incomplete decision sequence' 74
while IFS= read -r -d '' changed_path; do
  case "$changed_path" in
    docs/orchestration/decisions/*) ;;
    *) refuse 'evidence branch contains a path outside docs/orchestration/decisions' 74 ;;
  esac
  entry="$(git ls-tree "$candidate_tip" -- "$changed_path")"
  if [[ "$entry" != 100644\ blob\ * ]]; then
    refuse 'evidence branch contains a non-regular evidence file' 74
  fi
done < <(git diff --name-only -z "$governance_base..$candidate_tip")
if ! checked_out="$(git symbolic-ref --quiet --short HEAD 2>/dev/null)" || [[ "$checked_out" != "$branch" ]]; then
  refuse 'checked-out branch is not governance/decision-evidence' 71
fi
if [[ -n "$(git status --porcelain)" ]]; then
  refuse 'worktree is not clean' 70
fi

if ! fetch_endpoints="$(git remote get-url --all origin 2>/dev/null)" ||
   ! push_endpoints="$(git remote get-url --push --all origin 2>/dev/null)"; then
  refuse 'origin endpoints cannot be resolved' 73
fi
if [[ -z "$fetch_endpoints" || "$fetch_endpoints" == *$'\n'* ||
      -z "$push_endpoints" || "$push_endpoints" == *$'\n'* ||
      "$fetch_endpoints" != "$push_endpoints" ]]; then
  refuse 'origin must have one identical fetch and push endpoint' 73
fi
remote_endpoint="$push_endpoints"
if git remote get-url -- "$remote_endpoint" >/dev/null 2>&1; then
  refuse 'resolved endpoint is also a configured remote name' 73
fi
while IFS= read -r -d '' rewrite; do
  rewrite_prefix="${rewrite#*$'\n'}"
  if [[ "$remote_endpoint" == "$rewrite_prefix"* ]]; then
    refuse 'resolved endpoint can be rewritten again' 73
  fi
done < <(git config --null --get-regexp '^url\..*\.(insteadof|pushinsteadof)$')

resolve_remote_ref() {
  local ref="$1"
  local output
  if ! output="$(git ls-remote --refs -- "$remote_endpoint" "$ref" 2>/dev/null)"; then
    return 1
  fi
  [[ -n "$output" ]] || return 2
  [[ "$output" != *$'\n'* ]] || return 1
  printf '%s\n' "${output%%[[:space:]]*}"
}

remote_sha=
remote_status=0
remote_sha="$(resolve_remote_ref "$local_ref")" || remote_status=$?
pre_push_remote_status="$remote_status"
pre_push_remote_sha="$remote_sha"
if [[ "$remote_status" -eq 0 ]]; then
  if [[ ! "$remote_sha" =~ ^[0-9a-f]{40}$ ]]; then
    refuse 'remote evidence branch is invalid' 68
  fi
  if ! git merge-base --is-ancestor "$governance_base" "$remote_sha" ||
     ! git merge-base --is-ancestor "$remote_sha" "$candidate_tip"; then
    refuse 'remote evidence branch is not a fast-forward ancestor of candidate' 67
  fi
else
  [[ "$remote_status" -eq 2 ]] || refuse 'remote evidence branch state is unverifiable' 68
  if [[ "$mode" == verify ]]; then
    refuse 'remote evidence branch does not exist' 68
  fi
  if ! remote_base="$(resolve_remote_ref refs/heads/main)" || [[ "$remote_base" != "$governance_base" ]]; then
    refuse 'remote governance base does not match recorded base for branch creation' 67
  fi
fi

case "$mode" in
  authorize)
    printf 'authorized:%s:%s:%s\n' "$branch" "$candidate_tip" "$refspec"
    ;;
  push)
    if ! git -c core.hooksPath=/dev/null push --no-follow-tags --no-signed -- "$remote_endpoint" "$refspec"; then
      remote_status=0
      remote_sha="$(resolve_remote_ref "$local_ref")" || remote_status=$?
      if [[ "$remote_status" -eq 0 ]]; then
        if [[ "$remote_sha" == "$candidate_tip" ]]; then
          printf 'pushed:%s:%s:%s\n' "$branch" "$candidate_tip" "$refspec"
          exit 0
        fi
        if [[ "$pre_push_remote_status" -eq 0 && "$remote_sha" == "$pre_push_remote_sha" ]]; then
          refuse 'constrained evidence push failed without remote mutation' 72
        fi
        partial 'evidence push failed and remote evidence branch moved; recovery required'
      fi
      if [[ "$remote_status" -eq 2 && "$pre_push_remote_status" -eq 2 ]]; then
        refuse 'constrained evidence push failed without remote mutation' 72
      fi
      partial 'constrained evidence push result is unverifiable; recovery required'
    fi
    if ! remote_sha="$(resolve_remote_ref "$local_ref")" || [[ "$remote_sha" != "$candidate_tip" ]]; then
      partial 'remote evidence branch differs from candidate after push; recovery required'
    fi
    printf 'pushed:%s:%s:%s\n' "$branch" "$candidate_tip" "$refspec"
    ;;
  verify)
    if [[ "$remote_sha" != "$candidate_tip" ]]; then
      refuse 'local and remote evidence branch tips differ' 67
    fi
    printf 'verified:%s:%s:%s\n' "$branch" "$candidate_tip" "$refspec"
    ;;
esac
