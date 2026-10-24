#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
guard="$script_dir/validate_decision_evidence.sh"

if [[ ! -x "$guard" ]]; then
  printf 'FAIL: evidence guard is missing or not executable: %s\n' "$guard" >&2
  exit 1
fi

export GIT_CONFIG_GLOBAL=/dev/null
export GIT_CONFIG_SYSTEM=/dev/null

fixture_root="$(mktemp -d "${TMPDIR:-/tmp}/augmentedkeys-evidence-guard.XXXXXX")"
trap 'rm -rf -- "$fixture_root"' EXIT

tests_run=0
work_repo=
remote_repo=
base_sha=
control_sha=
candidate_sha=

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

append_evidence_sequence() {
  local sequence="$1"
  local reviewed qa_path security_path final_path qa_commit security_commit final_commit package_commit verdict_commit
  reviewed="$(git rev-parse refs/heads/main)"
  qa_path="docs/orchestration/decisions/m0/reviews/qa-$sequence.md"
  security_path="docs/orchestration/decisions/m0/reviews/security-$sequence.md"
  final_path="docs/orchestration/decisions/m0/reviews/final-$sequence.md"
  mkdir -p docs/orchestration/decisions/m0/{packages,verdicts,bindings,reviews}
  for spec in "qa_performance_verifier:$qa_path" "licensing_security_reviewer:$security_path" "final_code_reviewer:$final_path"; do
    role="${spec%%:*}"; path="${spec#*:}"
    {
      printf 'Controller recorder: program-controller\nReviewer role: %s\nReviewer session: %s-%s\n' "$role" "$role" "$sequence"
      printf 'Recorded timestamp: 2026-10-24T01:02:03Z\nReviewed candidate: %s\nVerification evidence commit: %s\n' "$reviewed" "$reviewed"
      printf 'Runtime evidence SHA-256: %064d\nFull review output SHA-256: %064d\n' 1 2
      printf 'Verdict: APPROVE\nCritical findings: 0\nImportant findings: 0\nMinor findings: 0\n'
    } > "$path"
    git add "$path" && git commit --quiet -m "review-$role-$sequence"
    case "$role" in qa_*) qa_commit="$(git rev-parse HEAD)";; licensing_*) security_commit="$(git rev-parse HEAD)";; final_*) final_commit="$(git rev-parse HEAD)";; esac
  done
  {
    printf 'Milestone: M0\nDecision kind: milestone-acceptance\nContract commit: %s\nContract path: docs/orchestration/milestones/M0_CONTRACT.md\n' "$reviewed"
    printf 'Reviewed candidate: %s\nCompletion package commit: %s\nCompletion package path: docs/orchestration/milestones/m0/evidence/completion-package.md\n' "$reviewed" "$reviewed"
    printf 'QA review commit: %s\nQA review path: %s\n' "$qa_commit" "$qa_path"
    printf 'Licensing review commit: %s\nLicensing review path: %s\n' "$security_commit" "$security_path"
    printf 'Final review commit: %s\nFinal review path: %s\n' "$final_commit" "$final_path"
    printf 'Target main commit: %s\nCritical findings: 0\nImportant findings: 0\nLimitations: Fixture.\nRecovery: Stop.\n' "$reviewed"
  } > "docs/orchestration/decisions/m0/packages/mi-$sequence.md"
  git add "docs/orchestration/decisions/m0/packages/mi-$sequence.md" && git commit --quiet -m "package-$sequence"
  package_commit="$(git rev-parse HEAD)"
  {
    printf 'Controller recorder: program-controller\nSteward role: decision_steward\nSteward session: steward-%s\nRecorded timestamp: 2026-10-24T02:03:04Z\n' "$sequence"
    printf 'Evidence package commit: %s\nEvidence package path: docs/orchestration/decisions/m0/packages/mi-%s.md\nVerdict: APPROVE_MILESTONE\n' "$package_commit" "$sequence"
  } > "docs/orchestration/decisions/m0/verdicts/mi-$sequence.md"
  git add "docs/orchestration/decisions/m0/verdicts/mi-$sequence.md" && git commit --quiet -m "verdict-$sequence"
  verdict_commit="$(git rev-parse HEAD)"
  {
    printf 'Binding status: Current\nPackage commit: %s\nPackage path: docs/orchestration/decisions/m0/packages/mi-%s.md\n' "$package_commit" "$sequence"
    printf 'Verdict commit: %s\nVerdict path: docs/orchestration/decisions/m0/verdicts/mi-%s.md\n' "$verdict_commit" "$sequence"
  } > docs/orchestration/decisions/m0/bindings/main-integration.md
  git add docs/orchestration/decisions/m0/bindings/main-integration.md && git commit --quiet -m "binding-$sequence"
}

setup_fixture() {
  local name="$1"
  local fixture="$fixture_root/$name"
  remote_repo="$fixture/origin.git"
  work_repo="$fixture/work"
  mkdir -p "$fixture"
  git init --quiet --bare "$remote_repo"
  git init --quiet --initial-branch=main "$work_repo"
  (
    cd "$work_repo"
    git config user.name 'Evidence Guard Test'
    git config user.email 'evidence-guard@example.invalid'
    printf 'governance base\n' > governance.txt
    mkdir -p .codex/skills/roadmap-orchestrator/scripts
    cp "$guard" .codex/skills/roadmap-orchestrator/scripts/validate_decision_evidence.sh
    chmod 0755 .codex/skills/roadmap-orchestrator/scripts/validate_decision_evidence.sh
    git add governance.txt
    git add .codex/skills/roadmap-orchestrator/scripts/validate_decision_evidence.sh
    git commit --quiet -m governance-base
    git remote add origin "$remote_repo"
    git push --quiet origin refs/heads/main:refs/heads/main
    git switch --quiet -c governance/decision-evidence
    mkdir -p docs/orchestration/decisions
    printf 'Governance base: %s\n' "$(git rev-parse refs/heads/main)" > docs/orchestration/decisions/governance-base.md
    git add docs/orchestration/decisions/governance-base.md && git commit --quiet -m evidence-base-binding
    append_evidence_sequence 001
  )
  base_sha="$(git -C "$work_repo" rev-parse refs/heads/main)"
  control_sha="$base_sha"
  candidate_sha="$(git -C "$work_repo" rev-parse refs/heads/governance/decision-evidence)"
}

run_guard() {
  (
    cd "$work_repo"
    AUGMENTEDKEYS_REVIEWED_GUARD_COMMIT="$control_sha" \
    AUGMENTEDKEYS_REVIEWED_GUARD_SHA256="$(shasum -a 256 "$guard" | awk '{print $1}')" \
    "$guard" "$@"
  )
}

snapshot_local() {
  {
    git -C "$work_repo" rev-parse HEAD
    git -C "$work_repo" show-ref
    git -C "$work_repo" status --porcelain=v1 --untracked-files=all
    git -C "$work_repo" diff --binary
    git -C "$work_repo" diff --cached --binary
  }
}

snapshot_remote() {
  git ls-remote -- "$remote_repo"
}

assert_refusal_without_mutation() {
  local expected="$1"
  shift
  local before_local before_remote output_file
  before_local="$(snapshot_local)"
  before_remote="$(snapshot_remote)"
  output_file="$fixture_root/evidence-refusal-output"
  if run_guard "$@" >"$output_file" 2>&1; then
    fail "$expected: evidence guard unexpectedly succeeded"
  fi
  grep -F "$expected" "$output_file" >/dev/null || fail "$expected: refusal message was not observed"
  [[ "$(snapshot_local)" == "$before_local" ]] || fail "$expected: local repository mutated"
  [[ "$(snapshot_remote)" == "$before_remote" ]] || fail "$expected: remote repository mutated"
  tests_run=$((tests_run + 1))
}

test_create_once_and_fast_forward() {
  local output next_sha
  setup_fixture valid
  output="$(run_guard authorize "$candidate_sha" "$base_sha")"
  [[ "$output" == "authorized:governance/decision-evidence:$candidate_sha:refs/heads/governance/decision-evidence:refs/heads/governance/decision-evidence" ]] || fail 'evidence authorize output differs'
  output="$(run_guard push "$candidate_sha" "$base_sha")"
  [[ "$output" == *"pushed:governance/decision-evidence:$candidate_sha:refs/heads/governance/decision-evidence:refs/heads/governance/decision-evidence"* ]] || fail 'initial evidence push output differs'
  output="$(run_guard verify "$candidate_sha" "$base_sha")"
  [[ "$output" == "verified:governance/decision-evidence:$candidate_sha:refs/heads/governance/decision-evidence:refs/heads/governance/decision-evidence" ]] || fail 'initial evidence verify output differs'

  (
    cd "$work_repo"
    append_evidence_sequence 002
  )
  next_sha="$(git -C "$work_repo" rev-parse HEAD)"
  run_guard authorize "$next_sha" "$base_sha" >/dev/null
  run_guard push "$next_sha" "$base_sha" >/dev/null
  run_guard verify "$next_sha" "$base_sha" >/dev/null
  [[ "$(git ls-remote --exit-code -- "$remote_repo" refs/heads/governance/decision-evidence | awk '{print $1}')" == "$next_sha" ]] || fail 'evidence branch did not fast-forward'
  tests_run=$((tests_run + 1))
}

test_wrong_branch() {
  setup_fixture wrong-branch
  git -C "$work_repo" switch --quiet main
  assert_refusal_without_mutation 'checked-out branch is not governance/decision-evidence' authorize "$candidate_sha" "$base_sha"
}

test_dirty_tree() {
  setup_fixture dirty
  printf 'dirty\n' >> "$work_repo/governance.txt"
  assert_refusal_without_mutation 'worktree is not clean' authorize "$candidate_sha" "$base_sha"
}

test_divergent_remote() {
  local divergent_sha
  setup_fixture divergent
  (
    cd "$work_repo"
    git switch --quiet -c divergent-evidence "$base_sha"
    printf 'divergent\n' > divergent.txt
    git add divergent.txt
    git commit --quiet -m divergent
  )
  divergent_sha="$(git -C "$work_repo" rev-parse HEAD)"
  git -C "$work_repo" push --quiet origin "$divergent_sha":refs/heads/governance/decision-evidence
  git -C "$work_repo" switch --quiet governance/decision-evidence
  assert_refusal_without_mutation 'remote evidence branch is not a fast-forward ancestor of candidate' authorize "$candidate_sha" "$base_sha"
}

test_ambiguous_remote() {
  setup_fixture ambiguous-remote
  git -C "$work_repo" remote set-url --add --push origin "$fixture_root/unused-evidence-origin.git"
  assert_refusal_without_mutation 'origin must have one identical fetch and push endpoint' authorize "$candidate_sha" "$base_sha"
}

test_direct_mode_refused() {
  setup_fixture direct-mode
  assert_refusal_without_mutation 'usage:' integrate "$candidate_sha" "$base_sha"
}

test_disallowed_content() {
  setup_fixture disallowed-content
  (
    cd "$work_repo"
    printf 'product-like change\n' >> governance.txt
    git commit --quiet -am disallowed
  )
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'evidence history contains a path outside docs/orchestration/decisions' authorize "$candidate_sha" "$base_sha"
}

test_hidden_intermediate_content() {
  setup_fixture hidden-intermediate
  (
    cd "$work_repo"
    printf 'temporary product change\n' >> governance.txt
    git commit --quiet -am disallowed-intermediate
    git restore --source="$base_sha" -- governance.txt
    git commit --quiet -am restored-intermediate
  )
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'evidence history contains a path outside docs/orchestration/decisions' authorize "$candidate_sha" "$base_sha"
}

test_deleted_evidence() {
  setup_fixture deleted-evidence
  (
    cd "$work_repo"
    git rm --quiet docs/orchestration/decisions/m0/packages/mi-001.md
    git commit --quiet -m deleted-evidence
  )
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'evidence history deletes canonical evidence' authorize "$candidate_sha" "$base_sha"
}

test_rewritten_package() {
  setup_fixture rewritten-package
  (
    cd "$work_repo"
    printf 'rewritten\n' >> docs/orchestration/decisions/m0/packages/mi-001.md
    git commit --quiet -am rewritten-package
  )
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'immutable evidence file is not add-only' authorize "$candidate_sha" "$base_sha"
}

test_historical_nonregular_binding() {
  setup_fixture historical-nonregular-binding
  (
    cd "$work_repo"
    append_evidence_sequence 002
    chmod 0755 docs/orchestration/decisions/m0/bindings/main-integration.md
    git add docs/orchestration/decisions/m0/bindings/main-integration.md
    git commit --quiet --amend --no-edit
    append_evidence_sequence 003
  )
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'evidence history contains a non-regular evidence file' authorize "$candidate_sha" "$base_sha"
}

test_co_committed_decision_artifacts() {
  setup_fixture co-committed
  (
    cd "$work_repo"
    printf 'package\n' > docs/orchestration/decisions/m0/packages/co-committed.md
    printf 'Verdict: PAUSE_HUMAN\n' > docs/orchestration/decisions/m0/verdicts/co-committed.md
    git add docs/orchestration/decisions/m0/packages/co-committed.md docs/orchestration/decisions/m0/verdicts/co-committed.md
    git commit --quiet -m co-committed-decision
  )
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'evidence commit must change exactly one canonical path' authorize "$candidate_sha" "$base_sha"
}

test_wrong_later_base() {
  setup_fixture wrong-later-base
  assert_refusal_without_mutation 'governance base binding differs from recorded base' authorize "$candidate_sha" "$candidate_sha"
}

test_merge_rewrite() {
  setup_fixture merge-rewrite
  (
    cd "$work_repo"
    git switch --quiet -c evidence-side
    printf 'merge rewrite\n' >> docs/orchestration/decisions/m0/packages/mi-001.md
    git commit --quiet -am merge-rewrite-side
    git switch --quiet governance/decision-evidence
    mkdir -p docs/orchestration/decisions/m0/bindings
    printf 'binding\n' > docs/orchestration/decisions/m0/bindings/advance.md
    git add docs/orchestration/decisions/m0/bindings/advance.md
    git commit --quiet -m binding-advance
    git merge --quiet --no-ff evidence-side -m merge-rewrite
  )
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'evidence history contains a merge commit' authorize "$candidate_sha" "$base_sha"
}

test_hostile_push_hook() {
  local hooks output
  setup_fixture hostile-hook
  hooks="$work_repo/.git/test-hooks"
  mkdir -p "$hooks"
  { printf '#!/usr/bin/env bash\nprintf hook-ran > pre-push-ran\n'; } > "$hooks/pre-push"
  chmod +x "$hooks/pre-push"
  git -C "$work_repo" config core.hooksPath "$hooks"
  output="$(run_guard push "$candidate_sha" "$base_sha")"
  [[ "$output" == *"pushed:governance/decision-evidence:$candidate_sha:"* && ! -e "$work_repo/pre-push-ran" ]] || fail 'configured evidence pre-push hook executed'
  tests_run=$((tests_run + 1))
}

test_confirmed_push_rejection() {
  setup_fixture confirmed-rejection
  { printf '#!/usr/bin/env bash\nexit 1\n'; } > "$remote_repo/hooks/pre-receive"
  chmod +x "$remote_repo/hooks/pre-receive"
  assert_refusal_without_mutation 'constrained evidence push failed without remote mutation' push "$candidate_sha" "$base_sha"
}

test_unverifiable_push_rejection() {
  local wrapper_dir real_git marker output_file before_local before_remote
  setup_fixture unverifiable-rejection
  { printf '#!/usr/bin/env bash\nexit 1\n'; } > "$remote_repo/hooks/pre-receive"
  chmod +x "$remote_repo/hooks/pre-receive"
  wrapper_dir="$fixture_root/git-wrapper"
  marker="$fixture_root/push-failed"
  real_git="$(command -v git)"
  mkdir -p "$wrapper_dir"
  {
    printf '#!/usr/bin/env bash\n'
    printf 'is_push=no\nfor arg in "$@"; do [[ "$arg" == push ]] && is_push=yes; done\n'
    printf '[[ "$1" == ls-remote && -e "$FAIL_MARKER" ]] && exit 128\n'
    printf '"$REAL_GIT" "$@"\nstatus=$?\n'
    printf '[[ "$is_push" == yes && "$status" -ne 0 ]] && : > "$FAIL_MARKER"\nexit "$status"\n'
  } > "$wrapper_dir/git"
  chmod +x "$wrapper_dir/git"
  before_local="$(snapshot_local)"
  before_remote="$(snapshot_remote)"
  output_file="$fixture_root/unverifiable-rejection-output"
  if (cd "$work_repo" && PATH="$wrapper_dir:$PATH" REAL_GIT="$real_git" FAIL_MARKER="$marker" \
      AUGMENTEDKEYS_REVIEWED_GUARD_COMMIT="$control_sha" AUGMENTEDKEYS_REVIEWED_GUARD_SHA256="$(shasum -a 256 "$guard" | awk '{print $1}')" \
      "$guard" push "$candidate_sha" "$base_sha") >"$output_file" 2>&1; then
    fail 'unverifiable rejected evidence push unexpectedly succeeded'
  fi
  grep -F 'partial: constrained evidence push result is unverifiable; recovery required' "$output_file" >/dev/null || { sed -n '1,120p' "$output_file" >&2; fail 'unverifiable evidence PARTIAL absent'; }
  [[ "$(snapshot_local)" == "$before_local" && "$(snapshot_remote)" == "$before_remote" ]] || fail 'unverifiable rejected evidence push mutated repository'
  tests_run=$((tests_run + 1))
}

test_post_freeze_review_lane() {
  local output review_path
  setup_fixture post-freeze-review
  review_path='docs/orchestration/decisions/m0/reviews/qa-integration-001.md'
  (
    cd "$work_repo"
    mkdir -p "$(dirname "$review_path")"
    {
      printf 'Controller recorder: program-controller\n'
      printf 'Reviewer role: qa_performance_verifier\n'
      printf 'Reviewer session: qa-session-001\n'
      printf 'Recorded timestamp: 2026-10-24T01:02:03Z\n'
      printf 'Reviewed candidate: %s\n' "$base_sha"
      printf 'Verification evidence commit: %s\n' "$base_sha"
      printf 'Runtime evidence SHA-256: %064d\n' 1
      printf 'Full review output SHA-256: %064d\n' 2
      printf 'Verdict: APPROVE\nCritical findings: 0\nImportant findings: 0\nMinor findings: 0\n'
    } > "$review_path"
    git add "$review_path"
    git commit --quiet -m post-freeze-review
  )
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  output="$(run_guard authorize "$candidate_sha" "$base_sha")"
  [[ "$output" == "authorized:governance/decision-evidence:$candidate_sha:refs/heads/governance/decision-evidence:refs/heads/governance/decision-evidence" ]] || fail 'post-freeze review lane authorize output differs'
  tests_run=$((tests_run + 1))
}

test_post_freeze_review_lane
test_create_once_and_fast_forward
test_wrong_branch
test_dirty_tree
test_divergent_remote
test_ambiguous_remote
test_direct_mode_refused
test_disallowed_content
test_hidden_intermediate_content
test_deleted_evidence
test_rewritten_package
test_historical_nonregular_binding
test_co_committed_decision_artifacts
test_wrong_later_base
test_merge_rewrite
test_hostile_push_hook
test_confirmed_push_rejection
test_unverifiable_push_rejection

printf 'PASS: %d decision-evidence guard scenarios\n' "$tests_run"
