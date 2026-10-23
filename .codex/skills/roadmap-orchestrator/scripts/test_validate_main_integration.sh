#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
guard="$script_dir/validate_main_integration.sh"
[[ -x "$guard" ]] || { printf 'FAIL: guard is missing or not executable: %s\n' "$guard" >&2; exit 1; }

export GIT_CONFIG_GLOBAL=/dev/null
export GIT_CONFIG_SYSTEM=/dev/null
fixture_root="$(mktemp -d "${TMPDIR:-/tmp}/augmentedkeys-main-guard.XXXXXX")"
trap 'rm -rf -- "$fixture_root"' EXIT

tests_run=0 work_repo= remote_repo= base_sha= candidate_sha=
acceptance_package_sha= acceptance_verdict_sha= acceptance_binding_sha= package_sha= decision_sha= binding_sha=
contract_path='docs/orchestration/milestones/M0_CONTRACT.md'
completion_path='docs/orchestration/milestones/m0/evidence/completion-package.md'
qa_path='docs/orchestration/reviews/m0/qa-performance.md'
license_path='docs/orchestration/reviews/m0/licensing-security.md'
final_path='docs/orchestration/reviews/m0/final-code-review.md'
acceptance_package_path='docs/orchestration/decisions/m0/packages/milestone-acceptance-001.md'
acceptance_verdict_path='docs/orchestration/decisions/m0/verdicts/milestone-acceptance-001.md'
acceptance_binding_path='docs/orchestration/decisions/m0/bindings/milestone-acceptance.md'
binding_path='docs/orchestration/decisions/m0/bindings/main-integration.md'

fail() { printf 'FAIL: %s\n' "$1" >&2; exit 1; }
refresh_sequence_shas() {
  binding_sha="$(git -C "$work_repo" rev-parse refs/heads/governance/decision-evidence)"
  decision_sha="$(git -C "$work_repo" rev-parse "$binding_sha^")"
  package_sha="$(git -C "$work_repo" rev-parse "$decision_sha^")"
}

write_acceptance_package() {
  mkdir -p "$(dirname "$acceptance_package_path")"
  {
    printf 'Milestone: M0\nContract commit: %s\nContract path: %s\n' "$base_sha" "$contract_path"
    printf 'Reviewed candidate: %s\nCompletion package commit: %s\nCompletion package path: %s\n' "$acceptance_package_candidate" "$candidate_sha" "$completion_path"
    printf 'QA review commit: %s\nQA review path: %s\n' "$candidate_sha" "$qa_path"
    printf 'Licensing review commit: %s\nLicensing review path: %s\n' "$candidate_sha" "$license_path"
    printf 'Final review commit: %s\nFinal review path: %s\n' "$candidate_sha" "$final_path"
    printf 'Target main commit: %s\nCritical findings: 0\nImportant findings: 0\n' "$base_sha"
    printf 'Limitations: Temporary repository fixture only.\nRecovery: Stop without replay when state is uncertain.\n'
  } > "$acceptance_package_path"
}

append_acceptance_sequence() {
  local sequence="$1"
  acceptance_package_path="docs/orchestration/decisions/m0/packages/milestone-acceptance-$sequence.md"
  acceptance_verdict_path="docs/orchestration/decisions/m0/verdicts/milestone-acceptance-$sequence.md"
  write_acceptance_package && git add "$acceptance_package_path" && git commit --quiet -m "acceptance-package-$sequence"
  acceptance_package_sha="$(git rev-parse HEAD)"
  write_acceptance_verdict && git add "$acceptance_verdict_path" && git commit --quiet -m "acceptance-verdict-$sequence"
  acceptance_verdict_sha="$(git rev-parse HEAD)"
  write_acceptance_binding && git add "$acceptance_binding_path" && git commit --quiet -m "acceptance-binding-$sequence"
  acceptance_binding_sha="$(git rev-parse HEAD)"
}

write_acceptance_verdict() {
  mkdir -p "$(dirname "$acceptance_verdict_path")"
  {
    [[ "$acceptance_include_provenance" == yes ]] && {
      printf 'Controller recorder: program-controller\nSteward role: %s\n' "$acceptance_steward_role"
      printf 'Steward session: acceptance-session-%s\nRecorded timestamp: 2026-09-01T10:00:00Z\n' "${acceptance_verdict_path##*-}"
    }
    printf 'Evidence package commit: %s\nEvidence package path: %s\n' "$acceptance_package_sha" "$acceptance_package_path"
    printf 'Verdict: APPROVE_MILESTONE\nMilestone: M0\n'
    printf 'Contract commit: %s\nReviewed candidate: %s\n' "$base_sha" "$candidate_sha"
    printf 'Completion package commit: %s\nTarget main commit: %s\n' "$candidate_sha" "$base_sha"
    printf 'Successor contract commit: Not applicable\nCritical findings: 0\nImportant findings: 0\n'
    printf 'Decision: Accept the exact reviewed milestone.\n'
  } > "$acceptance_verdict_path"
}

write_acceptance_binding() {
  mkdir -p "$(dirname "$acceptance_binding_path")"
  {
    printf 'Binding status: Current\nMilestone: M0\nMilestone state: Accepted\n'
    printf 'Package commit: %s\nPackage path: %s\n' "$acceptance_package_sha" "$acceptance_package_path"
    printf 'Accepted milestone tip: %s\nTarget main commit: %s\n' "$candidate_sha" "$base_sha"
    printf 'Verdict commit: %s\nVerdict path: %s\n' "$acceptance_verdict_sha" "$acceptance_verdict_path"
    printf 'Critical findings: 0\nImportant findings: 0\n'
  } > "$acceptance_binding_path"
}

reset_sequence_options() {
  package_acceptance_path="$acceptance_binding_path" package_qa_path="$qa_path"
  package_candidate="$candidate_sha" package_target="$base_sha"
  verdict_kind='APPROVE_MAIN_INTEGRATION' verdict_candidate="$candidate_sha" verdict_target="$base_sha"
  verdict_include_target=yes verdict_include_provenance=yes verdict_steward_role=decision_steward verdict_timestamp=2026-09-01T11:00:00Z
  binding_candidate="$candidate_sha" binding_target="$base_sha" binding_state='Pending' binding_extra_decision=no
}

append_main_sequence() {
  local sequence="$1"
  local package_path="docs/orchestration/decisions/m0/packages/main-integration-$sequence.md"
  local verdict_path="docs/orchestration/decisions/m0/verdicts/main-integration-$sequence.md"
  mkdir -p "$(dirname "$package_path")"
  {
    printf 'Milestone: M0\nContract commit: %s\nContract path: %s\n' "$base_sha" "$contract_path"
    printf 'Reviewed candidate: %s\nCompletion package commit: %s\nCompletion package path: %s\n' "$package_candidate" "$candidate_sha" "$completion_path"
    printf 'QA review commit: %s\nQA review path: %s\n' "$candidate_sha" "$package_qa_path"
    printf 'Licensing review commit: %s\nLicensing review path: %s\n' "$candidate_sha" "$license_path"
    printf 'Final review commit: %s\nFinal review path: %s\n' "$candidate_sha" "$final_path"
    printf 'Milestone acceptance binding commit: %s\nMilestone acceptance binding path: %s\n' "$acceptance_binding_sha" "$package_acceptance_path"
    printf 'Target main commit: %s\nCritical findings: 0\nImportant findings: 0\n' "$package_target"
    printf 'Limitations: Temporary repository fixture only.\nRecovery: Stop without replay when state is uncertain.\n'
  } > "$package_path"
  git add "$package_path" && git commit --quiet -m "package-$sequence"
  package_sha="$(git rev-parse HEAD)"
  mkdir -p "$(dirname "$verdict_path")"
  {
    [[ "$verdict_include_provenance" == yes ]] && {
      printf 'Controller recorder: program-controller\nSteward role: %s\n' "$verdict_steward_role"
      printf 'Steward session: main-session-%s\nRecorded timestamp: %s\n' "$sequence" "$verdict_timestamp"
    }
    printf 'Evidence package commit: %s\nEvidence package path: %s\n' "$package_sha" "$package_path"
    printf 'Verdict: %s\nMilestone: M0\nContract commit: %s\n' "$verdict_kind" "$base_sha"
    printf 'Reviewed candidate: %s\nCompletion package commit: %s\n' "$verdict_candidate" "$candidate_sha"
    [[ "$verdict_include_target" == yes ]] && printf 'Target main commit: %s\n' "$verdict_target"
    printf 'Successor contract commit: Not applicable\nCritical findings: 0\nImportant findings: 0\n'
    printf 'Decision: Decide the exact guarded integration.\n'
  } > "$verdict_path"
  git add "$verdict_path" && git commit --quiet -m "verdict-$sequence"
  decision_sha="$(git rev-parse HEAD)"
  mkdir -p "$(dirname "$binding_path")"
  {
    printf 'Binding status: Current\nMilestone: M0\nMilestone state: Accepted\nIntegration state: %s\n' "$binding_state"
    printf 'Package commit: %s\nPackage path: %s\nVerdict commit: %s\nVerdict path: %s\n' "$package_sha" "$package_path" "$decision_sha" "$verdict_path"
    printf 'Accepted milestone tip: %s\nTarget main commit: %s\n' "$binding_candidate" "$binding_target"
    printf 'Critical findings: 0\nImportant findings: 0\n'
  } > "$binding_path"
  git add "$binding_path"
  if [[ "$binding_extra_decision" == yes ]]; then
    printf 'Verdict: PAUSE_HUMAN\n' > "docs/orchestration/decisions/m0/verdicts/co-committed-pause-$sequence.md"
    git add "docs/orchestration/decisions/m0/verdicts/co-committed-pause-$sequence.md"
  fi
  git commit --quiet -m "binding-$sequence"
  binding_sha="$(git rev-parse HEAD)"
}

setup_fixture() {
  local fixture="$fixture_root/$1"
  local contract_kind="${2:-file}"
  remote_repo="$fixture/origin.git" work_repo="$fixture/work"
  mkdir -p "$fixture" && git init --quiet --bare "$remote_repo" && git init --quiet --initial-branch=main "$work_repo"
  (
    cd "$work_repo"
    git config user.name 'Main Guard Test' && git config user.email 'main-guard@example.invalid'
    printf 'base\n' > tracked.txt && mkdir -p "$(dirname "$contract_path")"
    case "$contract_kind" in
      file) printf '# M0 Contract\n' > "$contract_path" ;;
      directory) mkdir -p "$contract_path" && printf 'not an artifact\n' > "$contract_path/content.md" ;;
      symlink) printf '# target\n' > docs/orchestration/milestones/contract-target.md && ln -s contract-target.md "$contract_path" ;;
      *) fail 'unknown contract fixture kind' ;;
    esac
    git add tracked.txt "$contract_path" docs/orchestration/milestones/contract-target.md 2>/dev/null || git add tracked.txt "$contract_path"
    git commit --quiet -m base
    git remote add origin "$remote_repo" && git push --quiet origin refs/heads/main:refs/heads/main
    git switch --quiet -c milestone/m0-research && printf 'candidate\n' >> tracked.txt && printf 'candidate-only\n' > candidate-only.txt
    mkdir -p "$(dirname "$completion_path")" "$(dirname "$qa_path")"
    printf '# Completion Package\n' > "$completion_path" && printf 'QA review\n' > "$qa_path"
    printf 'Licensing review\n' > "$license_path" && printf 'Final review\n' > "$final_path"
    git add tracked.txt candidate-only.txt "$completion_path" "$qa_path" "$license_path" "$final_path" && git commit --quiet -m candidate
    git push --quiet origin refs/heads/milestone/m0-research:refs/heads/milestone/m0-research
  )
  base_sha="$(git -C "$work_repo" rev-parse refs/heads/main)" candidate_sha="$(git -C "$work_repo" rev-parse refs/heads/milestone/m0-research)"
  acceptance_include_provenance=yes acceptance_steward_role=decision_steward
  acceptance_package_candidate="$candidate_sha"
  (
    cd "$work_repo" && git switch --quiet -c governance/decision-evidence main
    write_acceptance_package && git add "$acceptance_package_path" && git commit --quiet -m acceptance-package
  )
  acceptance_package_sha="$(git -C "$work_repo" rev-parse HEAD)"
  (cd "$work_repo" && write_acceptance_verdict && git add "$acceptance_verdict_path" && git commit --quiet -m acceptance-verdict)
  acceptance_verdict_sha="$(git -C "$work_repo" rev-parse HEAD)"
  (cd "$work_repo" && write_acceptance_binding && git add "$acceptance_binding_path" && git commit --quiet -m acceptance-binding)
  acceptance_binding_sha="$(git -C "$work_repo" rev-parse HEAD)"
  (
    cd "$work_repo" && reset_sequence_options && append_main_sequence 001
    git push --quiet origin refs/heads/governance/decision-evidence:refs/heads/governance/decision-evidence
    git switch --quiet main
  )
  refresh_sequence_shas
}

run_guard() { (cd "$work_repo" && "$guard" "$@"); }
capture_head_state() {
  local symbolic commit
  if symbolic="$(git -C "$work_repo" symbolic-ref --quiet HEAD 2>/dev/null)"; then
    printf 'symbolic:%s\n' "$symbolic"
  elif commit="$(git -C "$work_repo" rev-parse --verify HEAD 2>/dev/null)"; then
    printf 'detached:%s\n' "$commit"
  else
    printf 'unresolved\n'
  fi
}
snapshot_local() {
  {
    capture_head_state
    git -C "$work_repo" show-ref
    for pseudoref in ORIG_HEAD MERGE_HEAD CHERRY_PICK_HEAD REVERT_HEAD; do
      printf '%s=' "$pseudoref"
      git -C "$work_repo" rev-parse --verify "$pseudoref" 2>/dev/null || printf 'absent\n'
    done
    git -C "$work_repo" status --porcelain=v1 --untracked-files=all
    git -C "$work_repo" diff --binary
    git -C "$work_repo" diff --cached --binary
  }
}
snapshot_remote() { git ls-remote -- "$remote_repo"; }
assert_refusal_without_mutation() {
  local expected="$1"; shift
  local before_local="$(snapshot_local)" before_remote="$(snapshot_remote)" output_file="$fixture_root/main-refusal-output"
  if run_guard "$@" >"$output_file" 2>&1; then fail "$expected: guard unexpectedly succeeded"; fi
  grep -F "$expected" "$output_file" >/dev/null || { sed -n '1,120p' "$output_file" >&2; fail "$expected: refusal absent"; }
  [[ "$(snapshot_local)" == "$before_local" ]] || fail "$expected: local repository mutated"
  [[ "$(snapshot_remote)" == "$before_remote" ]] || fail "$expected: remote repository mutated"
  tests_run=$((tests_run + 1))
}
append_and_publish() {
  local sequence="$1"
  (cd "$work_repo" && git switch --quiet governance/decision-evidence && append_main_sequence "$sequence" && git push --quiet origin refs/heads/governance/decision-evidence:refs/heads/governance/decision-evidence && git switch --quiet main)
}

test_valid_flow() {
  local output
  setup_fixture valid
  output="$(run_guard authorize milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha")"
  [[ "$output" == "authorized:milestone/m0-research:$candidate_sha:refs/heads/main:refs/heads/main" ]] || fail 'valid authorize output differs'
  output="$(run_guard integrate milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha")"
  [[ "$output" == *"integrated:milestone/m0-research:$candidate_sha:refs/heads/main:refs/heads/main"* ]] || fail 'valid integrate output differs'
  output="$(run_guard verify milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha")"
  [[ "$output" == "verified:milestone/m0-research:$candidate_sha:refs/heads/main:refs/heads/main" ]] || fail 'valid verify output differs'
  tests_run=$((tests_run + 1))
}
test_wrong_branch() { setup_fixture wrong-branch; git -C "$work_repo" switch --quiet milestone/m0-research; assert_refusal_without_mutation 'checked-out branch is not main' authorize milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha"; }
test_dirty_tree() { setup_fixture dirty; printf 'dirty\n' >> "$work_repo/tracked.txt"; assert_refusal_without_mutation 'worktree is not clean' authorize milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha"; }
test_stale_candidate() { setup_fixture stale-candidate; git -C "$work_repo" branch --force milestone/m0-research "$base_sha"; assert_refusal_without_mutation 'milestone branch tip differs from accepted tip' authorize milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha"; }
test_unconsumed_decision() {
  local old_binding
  setup_fixture unconsumed && old_binding="$binding_sha"
  (cd "$work_repo" && git switch --quiet governance/decision-evidence && printf 'unconsumed\n' > docs/orchestration/decisions/m0/verdicts/unconsumed.md && git add docs/orchestration/decisions/m0/verdicts/unconsumed.md && git commit --quiet -m unconsumed && git push --quiet origin refs/heads/governance/decision-evidence:refs/heads/governance/decision-evidence && git switch --quiet main)
  assert_refusal_without_mutation 'local or remote evidence tip differs from binding commit' authorize milestone/m0-research "$candidate_sha" "$base_sha" "$old_binding"
}
test_superseded_decision() { setup_fixture superseded; (cd "$work_repo" && git switch --quiet governance/decision-evidence && reset_sequence_options && verdict_kind='PAUSE_HUMAN' && binding_state='PAUSE_HUMAN' && append_main_sequence 002 && git push --quiet origin refs/heads/governance/decision-evidence:refs/heads/governance/decision-evidence && git switch --quiet main); refresh_sequence_shas; assert_refusal_without_mutation 'binding does not authorize pending main integration' authorize milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha"; }
test_missing_acceptance() { setup_fixture missing-acceptance; (cd "$work_repo" && git switch --quiet governance/decision-evidence && reset_sequence_options && package_acceptance_path='docs/orchestration/decisions/m0/bindings/missing.md' && append_main_sequence 002 && git push --quiet origin refs/heads/governance/decision-evidence:refs/heads/governance/decision-evidence && git switch --quiet main); refresh_sequence_shas; assert_refusal_without_mutation 'milestone acceptance binding path is not canonical' authorize milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha"; }
test_invalid_acceptance_package() { setup_fixture invalid-acceptance-package; (cd "$work_repo" && git switch --quiet governance/decision-evidence && acceptance_package_candidate="$base_sha" && append_acceptance_sequence 002 && reset_sequence_options && append_main_sequence 002 && git push --quiet origin refs/heads/governance/decision-evidence:refs/heads/governance/decision-evidence && git switch --quiet main); refresh_sequence_shas; assert_refusal_without_mutation 'milestone acceptance package does not bind requested tip' authorize milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha"; }
test_missing_review() { setup_fixture missing-review; (cd "$work_repo" && git switch --quiet governance/decision-evidence && reset_sequence_options && package_qa_path='docs/orchestration/reviews/m0/missing.md' && append_main_sequence 002 && git push --quiet origin refs/heads/governance/decision-evidence:refs/heads/governance/decision-evidence && git switch --quiet main); refresh_sequence_shas; assert_refusal_without_mutation 'QA review artifact is not a regular file' authorize milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha"; }
test_wrong_binding() { setup_fixture wrong-binding; (cd "$work_repo" && git switch --quiet governance/decision-evidence && reset_sequence_options && binding_candidate="$base_sha" && append_main_sequence 002 && git push --quiet origin refs/heads/governance/decision-evidence:refs/heads/governance/decision-evidence && git switch --quiet main); refresh_sequence_shas; assert_refusal_without_mutation 'binding accepted tip differs from requested tip' authorize milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha"; }
test_stale_decision() { setup_fixture stale-decision; (cd "$work_repo" && git switch --quiet governance/decision-evidence && reset_sequence_options && verdict_candidate="$base_sha" && append_main_sequence 002 && git push --quiet origin refs/heads/governance/decision-evidence:refs/heads/governance/decision-evidence && git switch --quiet main); refresh_sequence_shas; assert_refusal_without_mutation 'verdict reviewed candidate differs from accepted tip' authorize milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha"; }
test_missing_fields() { setup_fixture missing-fields; (cd "$work_repo" && git switch --quiet governance/decision-evidence && reset_sequence_options && verdict_include_target=no && append_main_sequence 002 && git push --quiet origin refs/heads/governance/decision-evidence:refs/heads/governance/decision-evidence && git switch --quiet main); refresh_sequence_shas; assert_refusal_without_mutation 'verdict is missing required approval fields' authorize milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha"; }
test_co_committed_pause() { setup_fixture co-committed-pause; (cd "$work_repo" && git switch --quiet governance/decision-evidence && reset_sequence_options && binding_extra_decision=yes && append_main_sequence 002 && git push --quiet origin refs/heads/governance/decision-evidence:refs/heads/governance/decision-evidence && git switch --quiet main); refresh_sequence_shas; assert_refusal_without_mutation 'main-integration binding commit changes unexpected paths' authorize milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha"; }
test_missing_main_provenance() { setup_fixture missing-main-provenance; (cd "$work_repo" && git switch --quiet governance/decision-evidence && reset_sequence_options && verdict_include_provenance=no && append_main_sequence 002 && git push --quiet origin refs/heads/governance/decision-evidence:refs/heads/governance/decision-evidence && git switch --quiet main); refresh_sequence_shas; assert_refusal_without_mutation 'verdict is missing required approval fields' authorize milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha"; }
test_invalid_calendar_timestamp() { setup_fixture invalid-calendar; (cd "$work_repo" && git switch --quiet governance/decision-evidence && reset_sequence_options && verdict_timestamp=2026-02-30T11:00:00Z && append_main_sequence 002 && git push --quiet origin refs/heads/governance/decision-evidence:refs/heads/governance/decision-evidence && git switch --quiet main); refresh_sequence_shas; assert_refusal_without_mutation 'main-integration Steward provenance is invalid' authorize milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha"; }
test_invalid_acceptance_provenance() { setup_fixture invalid-acceptance-provenance; (cd "$work_repo" && git switch --quiet governance/decision-evidence && acceptance_steward_role=workspace_writer && append_acceptance_sequence 002 && reset_sequence_options && append_main_sequence 002 && git push --quiet origin refs/heads/governance/decision-evidence:refs/heads/governance/decision-evidence && git switch --quiet main); refresh_sequence_shas; assert_refusal_without_mutation 'milestone acceptance Steward provenance is invalid' authorize milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha"; }
test_directory_contract() { setup_fixture directory-contract directory; assert_refusal_without_mutation 'contract artifact is not a regular file' authorize milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha"; }
test_symlink_contract() { setup_fixture symlink-contract symlink; assert_refusal_without_mutation 'contract artifact is not a regular file' authorize milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha"; }
test_moved_remote_main() { setup_fixture moved-main; git -C "$work_repo" push --quiet origin "$candidate_sha":refs/heads/main; assert_refusal_without_mutation 'remote main differs from recorded base' authorize milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha"; }
test_non_fast_forward() { local tree unrelated; setup_fixture non-ff; tree="$(git -C "$work_repo" rev-parse "$candidate_sha^{tree}")"; unrelated="$(printf 'unrelated\n' | git -C "$work_repo" commit-tree "$tree")"; git -C "$work_repo" branch --force milestone/m0-research "$unrelated"; assert_refusal_without_mutation 'accepted tip is not a fast-forward from recorded main' authorize milestone/m0-research "$unrelated" "$base_sha" "$binding_sha"; }
test_ambiguous_remote() { setup_fixture ambiguous; git -C "$work_repo" remote set-url --add --push origin "$fixture_root/unused.git"; assert_refusal_without_mutation 'origin must have one identical fetch and push endpoint' authorize milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha"; }
test_direct_mode() { setup_fixture direct; assert_refusal_without_mutation 'usage:' push milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha"; }
test_rejected_push() {
  local before_local before_remote output_file
  setup_fixture rejected
  git -C "$work_repo" update-ref ORIG_HEAD "$binding_sha"
  before_local="$(snapshot_local)" && before_remote="$(snapshot_remote)" && output_file="$fixture_root/rejected-output"
  { printf '#!/usr/bin/env bash\n'; printf 'exit 1\n'; } > "$remote_repo/hooks/pre-receive" && chmod +x "$remote_repo/hooks/pre-receive"
  if run_guard integrate milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha" >"$output_file" 2>&1; then fail 'rejected push unexpectedly succeeded'; fi
  grep -F 'constrained main push failed; local main restored' "$output_file" >/dev/null || { sed -n '1,160p' "$output_file" >&2; fail 'restored refusal absent'; }
  [[ "$(snapshot_local)" == "$before_local" && "$(snapshot_remote)" == "$before_remote" ]] || fail 'rejected push mutated repository'
  tests_run=$((tests_run + 1))
}
test_merge_failure_partial() {
  local wrapper_dir real_git output_file before_remote
  setup_fixture merge-failure
  git -C "$work_repo" update-ref ORIG_HEAD "$binding_sha"
  before_remote="$(snapshot_remote)"
  wrapper_dir="$fixture_root/merge-git-wrapper"
  real_git="$(command -v git)"
  mkdir -p "$wrapper_dir"
  {
    printf '#!/usr/bin/env bash\n'
    printf 'is_merge=no\nfor arg in "$@"; do [[ "$arg" == merge ]] && is_merge=yes; done\n'
    printf 'if [[ "$is_merge" == yes ]]; then\n'
    printf '  printf "merge mutation\\n" > tracked.txt\n  printf "untracked\\n" > merge-untracked.txt\n'
    printf '  "$REAL_GIT" update-ref ORIG_HEAD "$ACCEPTED_SHA"\n'
    printf '  "$REAL_GIT" update-ref refs/heads/merge-side "$ACCEPTED_SHA"\n  exit 1\nfi\n'
    printf 'exec "$REAL_GIT" "$@"\n'
  } > "$wrapper_dir/git"
  chmod +x "$wrapper_dir/git"
  output_file="$fixture_root/merge-failure-output"
  if (cd "$work_repo" && PATH="$wrapper_dir:$PATH" REAL_GIT="$real_git" ACCEPTED_SHA="$candidate_sha" "$guard" integrate milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha") >"$output_file" 2>&1; then fail 'mutating merge failure unexpectedly succeeded'; fi
  grep -F 'partial: fast-forward merge failed and complete pre-integration state is unproved; recovery required' "$output_file" >/dev/null || { sed -n '1,160p' "$output_file" >&2; fail 'merge-failure PARTIAL absent'; }
  [[ "$(git -C "$work_repo" rev-parse main)" == "$base_sha" ]] || fail 'merge-failure did not restore main ref'
  [[ "$(git -C "$work_repo" rev-parse ORIG_HEAD)" == "$binding_sha" ]] || fail 'merge-failure did not restore prior ORIG_HEAD'
  [[ "$(snapshot_remote)" == "$before_remote" ]] || fail 'merge-failure mutated remote'
  [[ -e "$work_repo/merge-untracked.txt" && "$(git -C "$work_repo" rev-parse refs/heads/merge-side)" == "$candidate_sha" ]] || fail 'merge-failure mutation fixture did not persist unproved state'
  tests_run=$((tests_run + 1))
}
test_merge_failure_restores_symbolic_head() {
  local wrapper_dir real_git output_file before_local before_remote
  setup_fixture merge-failure-detached-head
  before_local="$(snapshot_local)"
  before_remote="$(snapshot_remote)"
  wrapper_dir="$fixture_root/merge-detach-git-wrapper"
  real_git="$(command -v git)"
  mkdir -p "$wrapper_dir"
  {
    printf '#!/usr/bin/env bash\n'
    printf 'is_merge=no\nfor arg in "$@"; do [[ "$arg" == merge ]] && is_merge=yes; done\n'
    printf 'if [[ "$is_merge" == yes ]]; then\n'
    printf '  "$REAL_GIT" checkout --quiet --detach "$BASE_SHA"\n  exit 1\nfi\n'
    printf 'exec "$REAL_GIT" "$@"\n'
  } > "$wrapper_dir/git"
  chmod +x "$wrapper_dir/git"
  output_file="$fixture_root/merge-detached-head-output"
  if (cd "$work_repo" && PATH="$wrapper_dir:$PATH" REAL_GIT="$real_git" BASE_SHA="$base_sha" "$guard" integrate milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha") >"$output_file" 2>&1; then
    fail 'detached-HEAD merge failure unexpectedly succeeded'
  fi
  grep -F 'refused: fast-forward merge failed; complete pre-integration state restored' "$output_file" >/dev/null || { sed -n '1,160p' "$output_file" >&2; fail 'detached-HEAD restored refusal absent'; }
  [[ "$(snapshot_local)" == "$before_local" ]] || fail 'merge failure did not restore exact symbolic HEAD state'
  [[ "$(snapshot_remote)" == "$before_remote" ]] || fail 'detached-HEAD merge failure mutated remote'
  tests_run=$((tests_run + 1))
}
test_hostile_hooks() {
  local hooks output
  setup_fixture hostile && hooks="$work_repo/.git/test-hooks" && mkdir -p "$hooks"
  { printf '#!/usr/bin/env bash\nprintf hook-ran > post-merge-ran\n'; } > "$hooks/post-merge"
  { printf '#!/usr/bin/env bash\nprintf hook-ran > pre-push-ran\n'; } > "$hooks/pre-push"
  chmod +x "$hooks/post-merge" "$hooks/pre-push" && git -C "$work_repo" config core.hooksPath "$hooks"
  output="$(run_guard integrate milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha")"
  [[ "$output" == *"integrated:"* && ! -e "$work_repo/post-merge-ran" && ! -e "$work_repo/pre-push-ran" ]] || fail 'configured local hook executed'
  tests_run=$((tests_run + 1))
}
test_external_move_partial() {
  local tree external output_file
  setup_fixture external-move && tree="$(git -C "$work_repo" rev-parse "$base_sha^{tree}")"
  external="$(printf 'external\n' | git -C "$work_repo" commit-tree "$tree" -p "$base_sha")"
  git -C "$work_repo" push --quiet origin "$external":refs/heads/external-move
  { printf '#!/usr/bin/env bash\ngit update-ref refs/heads/main %s\n' "$external"; } > "$remote_repo/hooks/post-receive" && chmod +x "$remote_repo/hooks/post-receive"
  output_file="$fixture_root/external-output"
  if run_guard integrate milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha" >"$output_file" 2>&1; then fail 'external move unexpectedly succeeded'; fi
  grep -F 'partial: remote main differs from accepted tip after push; recovery required' "$output_file" >/dev/null || { sed -n '1,120p' "$output_file" >&2; fail 'PARTIAL result absent'; }
  [[ "$(git -C "$work_repo" rev-parse main)" == "$candidate_sha" && -z "$(git -C "$work_repo" status --porcelain)" ]] || fail 'PARTIAL local main state is not the proved merged candidate'
  [[ "$(git ls-remote --exit-code -- "$remote_repo" refs/heads/main | awk '{print $1}')" == "$external" ]] || fail 'external remote move absent'
  tests_run=$((tests_run + 1))
}

test_evidence_move_partial() {
  local external_evidence output_file
  setup_fixture evidence-move
  (
    cd "$work_repo"
    git switch --quiet governance/decision-evidence
    mkdir -p docs/orchestration/decisions/m0/results
    printf 'external evidence move\n' > docs/orchestration/decisions/m0/results/external-evidence.md
    git add docs/orchestration/decisions/m0/results/external-evidence.md
    git commit --quiet -m external-evidence
    git branch external-evidence HEAD
    git push --quiet origin refs/heads/external-evidence:refs/heads/external-evidence
    git switch --quiet main
    git update-ref refs/heads/governance/decision-evidence "$binding_sha"
  )
  external_evidence="$(git -C "$work_repo" rev-parse refs/heads/external-evidence)"
  { printf '#!/usr/bin/env bash\ngit update-ref refs/heads/governance/decision-evidence %s\n' "$external_evidence"; } > "$remote_repo/hooks/post-receive"
  chmod +x "$remote_repo/hooks/post-receive"
  output_file="$fixture_root/evidence-move-output"
  if run_guard integrate milestone/m0-research "$candidate_sha" "$base_sha" "$binding_sha" >"$output_file" 2>&1; then fail 'evidence move unexpectedly succeeded'; fi
  grep -F 'partial: evidence binding changed during integration; recovery required' "$output_file" >/dev/null || { sed -n '1,120p' "$output_file" >&2; fail 'evidence-move PARTIAL result absent'; }
  [[ "$(git -C "$work_repo" rev-parse main)" == "$candidate_sha" && -z "$(git -C "$work_repo" status --porcelain)" ]] || fail 'evidence-move PARTIAL local main state differs from candidate'
  [[ "$(git ls-remote --exit-code -- "$remote_repo" refs/heads/main | awk '{print $1}')" == "$candidate_sha" ]] || fail 'evidence-move PARTIAL remote main differs from candidate'
  [[ "$(git ls-remote --exit-code -- "$remote_repo" refs/heads/governance/decision-evidence | awk '{print $1}')" == "$external_evidence" ]] || fail 'external evidence move absent'
  tests_run=$((tests_run + 1))
}

test_valid_flow; test_wrong_branch; test_dirty_tree; test_stale_candidate; test_unconsumed_decision; test_superseded_decision
test_missing_acceptance; test_invalid_acceptance_package; test_missing_review; test_wrong_binding; test_stale_decision; test_missing_fields
test_missing_main_provenance; test_invalid_calendar_timestamp; test_invalid_acceptance_provenance; test_directory_contract; test_symlink_contract; test_co_committed_pause
test_moved_remote_main; test_non_fast_forward; test_ambiguous_remote; test_direct_mode; test_rejected_push; test_merge_failure_partial; test_merge_failure_restores_symbolic_head; test_hostile_hooks; test_external_move_partial
test_evidence_move_partial
printf 'PASS: %d main-integration guard scenarios\n' "$tests_run"
