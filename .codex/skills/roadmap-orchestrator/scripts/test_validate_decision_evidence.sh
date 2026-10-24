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
acceptance_sha=
integration_sha=

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

payload_hash_text() { printf '%s\n' "$1" | shasum -a 256 | awk '{print $1}'; }
payload_length_text() { printf '%s\n' "$1" | wc -c | tr -d ' '; }
payload_base64_text() { printf '%s\n' "$1" | base64 | tr -d '\n'; }
payload_hash_file() { shasum -a 256 "$1" | awk '{print $1}'; }
payload_length_file() { wc -c < "$1" | tr -d ' '; }
payload_base64_file() { base64 < "$1" | tr -d '\n'; }

append_evidence_sequence() {
  local sequence="$1"
  local reviewed qa_path security_path final_path qa_commit security_commit final_commit package_commit verdict_commit output output_hash output_length output_encoded
  local acceptance_binding_commit delta_hash
  reviewed="$acceptance_sha"
  qa_path="docs/orchestration/decisions/m0/reviews/qa-$sequence.md"
  security_path="docs/orchestration/decisions/m0/reviews/security-$sequence.md"
  final_path="docs/orchestration/decisions/m0/reviews/final-$sequence.md"
  mkdir -p docs/orchestration/decisions/m0/{packages,verdicts,bindings,reviews}
  for spec in "qa_performance_verifier:$qa_path" "licensing_security_reviewer:$security_path" "final_code_reviewer:$final_path"; do
    role="${spec%%:*}"; path="${spec#*:}"
    output="APPROVE $role review for $sequence.
Verdict: APPROVE
Critical findings: 0
Important findings: 0
Metadata-looking review prose remains literal output."
    if [[ -n "${REVIEW_RAW_FILE:-}" ]]; then
      output_hash="$(payload_hash_file "$REVIEW_RAW_FILE")"; output_length="$(payload_length_file "$REVIEW_RAW_FILE")"; output_encoded="$(payload_base64_file "$REVIEW_RAW_FILE")"
    else
      output_hash="$(payload_hash_text "$output")"; output_length="$(payload_length_text "$output")"; output_encoded="$(payload_base64_text "$output")"
    fi
    {
      printf 'Controller recorder: program-controller\nReviewer role: %s\nReviewer session: %s-%s\n' "$role" "$role" "$sequence"
      printf 'Recorded timestamp: 2026-10-24T01:02:03Z\nReviewed candidate: %s\nVerification evidence commit: %s\n' "$reviewed" "$reviewed"
      printf 'Runtime evidence SHA-256: %064d\nReview output encoding: base64\nReview output byte length: %s\nFull review output SHA-256: %s\n' 1 "${REVIEW_LENGTH_OVERRIDE:-$output_length}" "$output_hash"
      printf 'Verdict: APPROVE\nCritical findings: 0\nImportant findings: 0\nMinor findings: 0\n'
      printf '%s\n%s\n%s\n' '--- BEGIN REVIEW OUTPUT ---' "${REVIEW_ENCODED_OVERRIDE:-$output_encoded}" '--- END REVIEW OUTPUT ---'
    } > "$path"
    git add "$path" && git commit --quiet -m "review-$role-$sequence"
    case "$role" in qa_*) qa_commit="$(git rev-parse HEAD)";; licensing_*) security_commit="$(git rev-parse HEAD)";; final_*) final_commit="$(git rev-parse HEAD)";; esac
  done
  {
    printf 'Milestone: M0\nDecision kind: milestone-acceptance\nDecision disposition: APPROVAL\nContract commit: %s\nContract path: docs/orchestration/milestones/M0_CONTRACT.md\n' "$base_sha"
    printf 'Reviewed candidate: %s\nCompletion package commit: %s\nCompletion package path: docs/orchestration/milestones/m0/evidence/completion-package.md\n' "$acceptance_sha" "$acceptance_sha"
    printf 'QA review commit: %s\nQA review path: %s\n' "$qa_commit" "$qa_path"
    printf 'Licensing review commit: %s\nLicensing review path: %s\n' "$security_commit" "$security_path"
    printf 'Final review commit: %s\nFinal review path: %s\n' "$final_commit" "$final_path"
    printf 'Target main commit: %s\nCritical findings: 0\nImportant findings: 0\nLimitations: Fixture.\nRecovery: Stop.\n' "$base_sha"
  } > "docs/orchestration/decisions/m0/packages/acceptance-$sequence.md"
  git add "docs/orchestration/decisions/m0/packages/acceptance-$sequence.md" && git commit --quiet -m "acceptance-package-$sequence"
  package_commit="$(git rev-parse HEAD)"
  {
    printf 'Controller recorder: program-controller\nSteward role: decision_steward\nSteward session: steward-%s\nRecorded timestamp: 2026-10-24T02:03:04Z\n' "$sequence"
    printf 'Evidence package commit: %s\nEvidence package path: docs/orchestration/decisions/m0/packages/acceptance-%s.md\nVerdict: APPROVE_MILESTONE\n' "$package_commit" "$sequence"
    printf 'Milestone: M0\nContract commit: %s\nReviewed candidate: %s\nCompletion package commit: %s\nTarget main commit: %s\n' "$base_sha" "$acceptance_sha" "$acceptance_sha" "$base_sha"
    printf 'Critical findings: 0\nImportant findings: 0\nDecision: Approve exact fixture milestone.\n'
  } > "docs/orchestration/decisions/m0/verdicts/acceptance-$sequence.md"
  git add "docs/orchestration/decisions/m0/verdicts/acceptance-$sequence.md" && git commit --quiet -m "acceptance-verdict-$sequence"
  verdict_commit="$(git rev-parse HEAD)"
  {
    printf 'Binding status: Current\nMilestone: M0\nContract commit: %s\nPackage commit: %s\nPackage path: docs/orchestration/decisions/m0/packages/acceptance-%s.md\n' "$base_sha" "$package_commit" "$sequence"
    printf 'Verdict commit: %s\nVerdict path: docs/orchestration/decisions/m0/verdicts/acceptance-%s.md\n' "$verdict_commit" "$sequence"
    printf 'Decision kind: APPROVE_MILESTONE\nReviewed candidate: %s\nCompletion package commit: %s\nTarget main commit: %s\nAuthorization: GRANTED\nCritical findings: 0\nImportant findings: 0\n' "$acceptance_sha" "$acceptance_sha" "$base_sha"
  } > docs/orchestration/decisions/m0/bindings/milestone-acceptance.md
  git add docs/orchestration/decisions/m0/bindings/milestone-acceptance.md && git commit --quiet -m "acceptance-binding-$sequence"
  acceptance_binding_commit="$(git rev-parse HEAD)"

  reviewed="$integration_sha"
  qa_path="docs/orchestration/decisions/m0/reviews/qa-main-$sequence.md"
  security_path="docs/orchestration/decisions/m0/reviews/security-main-$sequence.md"
  final_path="docs/orchestration/decisions/m0/reviews/final-main-$sequence.md"
  for spec in "qa_performance_verifier:$qa_path" "licensing_security_reviewer:$security_path" "final_code_reviewer:$final_path"; do
    role="${spec%%:*}"; path="${spec#*:}"
    output="APPROVE $role main review for $sequence.
Verdict: APPROVE
Critical findings: 0
Important findings: 0
Metadata-looking review prose remains literal output."
    if [[ -n "${REVIEW_RAW_FILE:-}" ]]; then
      output_hash="$(payload_hash_file "$REVIEW_RAW_FILE")"; output_length="$(payload_length_file "$REVIEW_RAW_FILE")"; output_encoded="$(payload_base64_file "$REVIEW_RAW_FILE")"
    else
      output_hash="$(payload_hash_text "$output")"; output_length="$(payload_length_text "$output")"; output_encoded="$(payload_base64_text "$output")"
    fi
    {
      printf 'Controller recorder: program-controller\nReviewer role: %s\nReviewer session: %s-main-%s\n' "$role" "$role" "$sequence"
      printf 'Recorded timestamp: 2026-10-24T01:12:13Z\nReviewed candidate: %s\nVerification evidence commit: %s\n' "$reviewed" "$reviewed"
      printf 'Runtime evidence SHA-256: %064d\nReview output encoding: base64\nReview output byte length: %s\nFull review output SHA-256: %s\n' 2 "${REVIEW_LENGTH_OVERRIDE:-$output_length}" "$output_hash"
      printf 'Verdict: APPROVE\nCritical findings: 0\nImportant findings: 0\nMinor findings: 0\n'
      printf '%s\n%s\n%s\n' '--- BEGIN REVIEW OUTPUT ---' "${REVIEW_ENCODED_OVERRIDE:-$output_encoded}" '--- END REVIEW OUTPUT ---'
    } > "$path"
    git add "$path" && git commit --quiet -m "main-review-$role-$sequence"
    case "$role" in qa_*) qa_commit="$(git rev-parse HEAD)";; licensing_*) security_commit="$(git rev-parse HEAD)";; final_*) final_commit="$(git rev-parse HEAD)";; esac
  done
  delta_hash="$(git diff --binary "$acceptance_sha..$integration_sha" | shasum -a 256 | awk '{print $1}')"
  {
    printf 'Milestone: M0\nDecision kind: main-integration\nDecision disposition: APPROVAL\nContract commit: %s\nContract path: docs/orchestration/milestones/M0_CONTRACT.md\n' "$base_sha"
    printf 'Reviewed candidate: %s\nAcceptance candidate: %s\nIntegration candidate: %s\n' "$integration_sha" "$acceptance_sha" "$integration_sha"
    printf 'Administrative delta paths: STATE.md\nAdministrative delta SHA-256: %s\nAdministrative transition date: 2026-10-24\n' "$delta_hash"
    printf 'Completion package commit: %s\nCompletion package path: docs/orchestration/milestones/m0/evidence/completion-package.md\n' "$acceptance_sha"
    printf 'Milestone acceptance binding commit: %s\nMilestone acceptance binding path: docs/orchestration/decisions/m0/bindings/milestone-acceptance.md\n' "$acceptance_binding_commit"
    printf 'QA review commit: %s\nQA review path: %s\n' "$qa_commit" "$qa_path"
    printf 'Licensing review commit: %s\nLicensing review path: %s\n' "$security_commit" "$security_path"
    printf 'Final review commit: %s\nFinal review path: %s\n' "$final_commit" "$final_path"
    printf 'Target main commit: %s\nCritical findings: 0\nImportant findings: 0\nLimitations: Fixture.\nRecovery: Stop.\n' "$base_sha"
  } > "docs/orchestration/decisions/m0/packages/mi-$sequence.md"
  git add "docs/orchestration/decisions/m0/packages/mi-$sequence.md" && git commit --quiet -m "package-$sequence"
  package_commit="$(git rev-parse HEAD)"
  {
    printf 'Controller recorder: program-controller\nSteward role: decision_steward\nSteward session: steward-main-%s\nRecorded timestamp: 2026-10-24T02:13:14Z\n' "$sequence"
    printf 'Evidence package commit: %s\nEvidence package path: docs/orchestration/decisions/m0/packages/mi-%s.md\nVerdict: APPROVE_MAIN_INTEGRATION\n' "$package_commit" "$sequence"
    printf 'Milestone: M0\nContract commit: %s\nReviewed candidate: %s\nAcceptance candidate: %s\nIntegration candidate: %s\n' "$base_sha" "$integration_sha" "$acceptance_sha" "$integration_sha"
    printf 'Completion package commit: %s\nMilestone acceptance binding commit: %s\nTarget main commit: %s\n' "$acceptance_sha" "$acceptance_binding_commit" "$base_sha"
    printf 'Critical findings: 0\nImportant findings: 0\nDecision: Approve exact fixture main integration.\n'
  } > "docs/orchestration/decisions/m0/verdicts/mi-$sequence.md"
  git add "docs/orchestration/decisions/m0/verdicts/mi-$sequence.md" && git commit --quiet -m "verdict-$sequence"
  verdict_commit="$(git rev-parse HEAD)"
  {
    printf 'Binding status: Current\nMilestone: M0\nContract commit: %s\nPackage commit: %s\nPackage path: docs/orchestration/decisions/m0/packages/mi-%s.md\n' "$base_sha" "$package_commit" "$sequence"
    printf 'Verdict commit: %s\nVerdict path: docs/orchestration/decisions/m0/verdicts/mi-%s.md\n' "$verdict_commit" "$sequence"
    printf 'Decision kind: APPROVE_MAIN_INTEGRATION\nReviewed candidate: %s\nAcceptance candidate: %s\nIntegration candidate: %s\n' "$integration_sha" "$acceptance_sha" "$integration_sha"
    printf 'Completion package commit: %s\nMilestone acceptance binding commit: %s\nTarget main commit: %s\nAuthorization: GRANTED\nCritical findings: 0\nImportant findings: 0\n' "$acceptance_sha" "$acceptance_binding_commit" "$base_sha"
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
    mkdir -p docs/orchestration/milestones
    printf '# M0 Contract\n' > docs/orchestration/milestones/M0_CONTRACT.md
    mkdir -p .codex/skills/roadmap-orchestrator/scripts
    cp "$guard" .codex/skills/roadmap-orchestrator/scripts/validate_decision_evidence.sh
    chmod 0755 .codex/skills/roadmap-orchestrator/scripts/validate_decision_evidence.sh
    git add governance.txt docs/orchestration/milestones/M0_CONTRACT.md
    git add .codex/skills/roadmap-orchestrator/scripts/validate_decision_evidence.sh
    git commit --quiet -m governance-base
    git remote add origin "$remote_repo"
    git push --quiet origin refs/heads/main:refs/heads/main
    git switch --quiet -c milestone/m0-research
    mkdir -p docs/orchestration/milestones/m0/evidence docs/orchestration/milestones/m1/evidence
    printf '# Completion package\n' > docs/orchestration/milestones/m0/evidence/completion-package.md
    printf '# M1 Contract\n' > docs/orchestration/milestones/M1_CONTRACT.md
    printf '# M1 entry conditions\n' > docs/orchestration/milestones/m1/evidence/entry-conditions.md
    git add docs/orchestration/milestones/m0/evidence/completion-package.md docs/orchestration/milestones/M1_CONTRACT.md docs/orchestration/milestones/m1/evidence/entry-conditions.md && git commit --quiet -m acceptance-candidate
    git tag fixture-acceptance
    printf 'Milestone state: Accepted\n' > STATE.md
    git add STATE.md && git commit --quiet -m integration-candidate
    git tag fixture-integration
    git switch --quiet main
    base_sha="$(git rev-parse refs/heads/main)"
    acceptance_sha="$(git rev-parse refs/tags/fixture-acceptance)"
    integration_sha="$(git rev-parse refs/tags/fixture-integration)"
    git switch --quiet -c governance/decision-evidence
    mkdir -p docs/orchestration/decisions
    printf 'Governance base: %s\n' "$(git rev-parse refs/heads/main)" > docs/orchestration/decisions/governance-base.md
    git add docs/orchestration/decisions/governance-base.md && git commit --quiet -m evidence-base-binding
    append_evidence_sequence 001
  )
  base_sha="$(git -C "$work_repo" rev-parse refs/heads/main)"
  acceptance_sha="$(git -C "$work_repo" rev-parse refs/tags/fixture-acceptance)"
  integration_sha="$(git -C "$work_repo" rev-parse refs/tags/fixture-integration)"
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
  local output review_path literal literal_hash literal_length literal_encoded
  setup_fixture post-freeze-review
  review_path='docs/orchestration/decisions/m0/reviews/qa-integration-001.md'
  literal='APPROVE standalone post-freeze review.'
  literal_hash="$(payload_hash_text "$literal")"; literal_length="$(payload_length_text "$literal")"; literal_encoded="$(payload_base64_text "$literal")"
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
      printf 'Review output encoding: base64\nReview output byte length: %s\n' "$literal_length"
      printf 'Full review output SHA-256: %s\n' "$literal_hash"
      printf 'Verdict: APPROVE\nCritical findings: 0\nImportant findings: 0\nMinor findings: 0\n'
      printf '%s\n%s\n%s\n' '--- BEGIN REVIEW OUTPUT ---' "$literal_encoded" '--- END REVIEW OUTPUT ---'
    } > "$review_path"
    git add "$review_path"
    git commit --quiet -m post-freeze-review
  )
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  output="$(run_guard authorize "$candidate_sha" "$base_sha")"
  [[ "$output" == "authorized:governance/decision-evidence:$candidate_sha:refs/heads/governance/decision-evidence:refs/heads/governance/decision-evidence" ]] || fail 'post-freeze review lane authorize output differs'
  tests_run=$((tests_run + 1))
}

append_negative_sequence() {
  local sequence="$1" verdict_kind="${2:-CORRECT}" reviewed role path literal literal_hash literal_length literal_encoded review_commit package_path package_commit verdict_path verdict_commit binding_path
  reviewed="$(git rev-parse refs/heads/main)"
  role=qa_performance_verifier
  path="docs/orchestration/decisions/m0/reviews/qa-reject-$sequence.md"
  literal="REJECT review for $sequence with one Important finding."
  literal_hash="$(payload_hash_text "$literal")"; literal_length="$(payload_length_text "$literal")"; literal_encoded="$(payload_base64_text "$literal")"
  mkdir -p "$(dirname "$path")"
  {
    printf 'Controller recorder: program-controller\nReviewer role: %s\nReviewer session: reject-%s\n' "$role" "$sequence"
    printf 'Recorded timestamp: 2026-10-24T03:04:05Z\nReviewed candidate: %s\nVerification evidence commit: %s\n' "$reviewed" "$reviewed"
    printf 'Runtime evidence SHA-256: %064d\nReview output encoding: base64\nReview output byte length: %s\nFull review output SHA-256: %s\n' 3 "$literal_length" "$literal_hash"
    printf 'Verdict: REJECT\nCritical findings: 0\nImportant findings: 1\nMinor findings: 0\n'
    printf '%s\n%s\n%s\n' '--- BEGIN REVIEW OUTPUT ---' "$literal_encoded" '--- END REVIEW OUTPUT ---'
  } > "$path"
  git add "$path" && git commit --quiet -m "reject-review-$sequence"; review_commit="$(git rev-parse HEAD)"
  package_path="docs/orchestration/decisions/m0/packages/correction-$sequence.md"
  {
    printf 'Milestone: M0\nDecision kind: milestone-correction\nDecision disposition: NEGATIVE\n'
    printf 'Contract commit: %s\nContract path: docs/orchestration/milestones/M0_CONTRACT.md\nReviewed candidate: %s\nTarget main commit: %s\n' "$reviewed" "$reviewed" "$reviewed"
    printf 'Blocking evidence status: REJECTED\nBlocking review commit: %s\nBlocking review path: %s\nBlocking reviewer role: %s\n' "$review_commit" "$path" "$role"
    printf 'Critical findings: 0\nImportant findings: 1\nLimitations: Rejected fixture.\nRecovery: Correct then review again.\n'
  } > "$package_path"
  git add "$package_path" && git commit --quiet -m "negative-package-$sequence"; package_commit="$(git rev-parse HEAD)"
  verdict_path="docs/orchestration/decisions/m0/verdicts/correction-$sequence.md"
  {
    printf 'Controller recorder: program-controller\nSteward role: decision_steward\nSteward session: correction-%s\nRecorded timestamp: 2026-10-24T04:05:06Z\n' "$sequence"
    printf 'Evidence package commit: %s\nEvidence package path: %s\nVerdict: %s\nMilestone: M0\nContract commit: %s\nReviewed candidate: %s\nTarget main commit: %s\n' "$package_commit" "$package_path" "$verdict_kind" "$reviewed" "$reviewed" "$reviewed"
    printf 'Critical findings: 0\nImportant findings: 1\nDecision: Correct exact blocking finding.\n'
  } > "$verdict_path"
  git add "$verdict_path" && git commit --quiet -m "negative-verdict-$sequence"; verdict_commit="$(git rev-parse HEAD)"
  binding_path="docs/orchestration/decisions/m0/bindings/correction.md"
  {
    printf 'Binding status: Current\nMilestone: M0\nContract commit: %s\nPackage commit: %s\nPackage path: %s\nVerdict commit: %s\nVerdict path: %s\n' "$reviewed" "$package_commit" "$package_path" "$verdict_commit" "$verdict_path"
    printf 'Decision kind: %s\nReviewed candidate: %s\nTarget main commit: %s\nAuthorization: DENIED\nCritical findings: 0\nImportant findings: 1\n' "$verdict_kind" "$reviewed" "$reviewed"
  } > "$binding_path"
  git add "$binding_path" && git commit --quiet -m "negative-binding-$sequence"
}

append_human_gate_sequence() {
  local sequence="$1" reviewed role path literal literal_hash literal_length literal_encoded qa_commit security_commit final_commit package_path package_commit verdict_path verdict_commit binding_path
  reviewed="$(git rev-parse refs/heads/main)"
  for spec in "qa_performance_verifier:qa" "licensing_security_reviewer:security" "final_code_reviewer:final"; do
    role="${spec%%:*}"; label="${spec#*:}"; path="docs/orchestration/decisions/m0/reviews/$label-human-$sequence.md"
    literal="APPROVE $role technical review; owner-only boundary remains.
Verdict: APPROVE
Critical findings: 0
Important findings: 0"
    literal_hash="$(payload_hash_text "$literal")"; literal_length="$(payload_length_text "$literal")"; literal_encoded="$(payload_base64_text "$literal")"
    mkdir -p "$(dirname "$path")"
    {
      printf 'Controller recorder: program-controller\nReviewer role: %s\nReviewer session: human-%s-%s\n' "$role" "$label" "$sequence"
      printf 'Recorded timestamp: 2026-10-24T06:07:08Z\nReviewed candidate: %s\nVerification evidence commit: %s\n' "$reviewed" "$reviewed"
      printf 'Runtime evidence SHA-256: %064d\nReview output encoding: base64\nReview output byte length: %s\nFull review output SHA-256: %s\n' 4 "$literal_length" "$literal_hash"
      printf 'Verdict: APPROVE\nCritical findings: 0\nImportant findings: 0\nMinor findings: 0\n'
      printf '%s\n%s\n%s\n' '--- BEGIN REVIEW OUTPUT ---' "$literal_encoded" '--- END REVIEW OUTPUT ---'
    } > "$path"
    git add "$path" && git commit --quiet -m "human-review-$label-$sequence"
    case "$label" in qa) qa_commit="$(git rev-parse HEAD)"; qa_path="$path";; security) security_commit="$(git rev-parse HEAD)"; security_path="$path";; final) final_commit="$(git rev-parse HEAD)"; final_path="$path";; esac
  done
  package_path="docs/orchestration/decisions/m0/packages/human-gate-$sequence.md"
  {
    printf 'Milestone: M0\nDecision kind: human-gate\nDecision disposition: NEGATIVE\nContract commit: %s\nContract path: docs/orchestration/milestones/M0_CONTRACT.md\n' "$reviewed"
    printf 'Reviewed candidate: %s\nTarget main commit: %s\nBlocking evidence status: HUMAN_GATE\n' "$reviewed" "$reviewed"
    printf 'Human gate reason: Paused governance and repaired contract require explicit owner acceptance before reactivation.\n'
    printf 'QA review commit: %s\nQA review path: %s\nLicensing review commit: %s\nLicensing review path: %s\nFinal review commit: %s\nFinal review path: %s\n' "$qa_commit" "$qa_path" "$security_commit" "$security_path" "$final_commit" "$final_path"
    printf 'Critical findings: 0\nImportant findings: 0\nLimitations: Technical reviews do not cross the owner-only gate.\nRecovery: Preserve pause and request exact owner decision.\n'
  } > "$package_path"
  git add "$package_path" && git commit --quiet -m "human-package-$sequence"; package_commit="$(git rev-parse HEAD)"
  verdict_path="docs/orchestration/decisions/m0/verdicts/human-gate-$sequence.md"
  {
    printf 'Controller recorder: program-controller\nSteward role: decision_steward\nSteward session: human-gate-%s\nRecorded timestamp: 2026-10-24T07:08:09Z\n' "$sequence"
    printf 'Evidence package commit: %s\nEvidence package path: %s\nVerdict: PAUSE_HUMAN\nMilestone: M0\nContract commit: %s\nReviewed candidate: %s\nTarget main commit: %s\n' "$package_commit" "$package_path" "$reviewed" "$reviewed" "$reviewed"
    printf 'Critical findings: 0\nImportant findings: 0\nDecision: Preserve owner-only activation boundary.\n'
  } > "$verdict_path"
  git add "$verdict_path" && git commit --quiet -m "human-verdict-$sequence"; verdict_commit="$(git rev-parse HEAD)"
  binding_path='docs/orchestration/decisions/m0/bindings/human-gate.md'
  {
    printf 'Binding status: Current\nMilestone: M0\nContract commit: %s\nPackage commit: %s\nPackage path: %s\nVerdict commit: %s\nVerdict path: %s\n' "$reviewed" "$package_commit" "$package_path" "$verdict_commit" "$verdict_path"
    printf 'Decision kind: PAUSE_HUMAN\nReviewed candidate: %s\nTarget main commit: %s\nAuthorization: DENIED\nCritical findings: 0\nImportant findings: 0\n' "$reviewed" "$reviewed"
  } > "$binding_path"
  git add "$binding_path" && git commit --quiet -m "human-binding-$sequence"
}

append_result_sequence() {
  local sequence="$1" status="$2" approval="$3" approval_path="$4" literal payload hash length encoded result_path result_commit binding_path recovery snapshot replay post_local post_remote post_evidence
  literal="$status guard output for $sequence.
Result status: REJECTED
Critical findings: 0
Guard-output control-like text remains literal output."
  if [[ -n "${RESULT_RAW_FILE:-}" ]]; then
    hash="$(payload_hash_file "$RESULT_RAW_FILE")"; length="$(payload_length_file "$RESULT_RAW_FILE")"; encoded="$(payload_base64_file "$RESULT_RAW_FILE")"
  else
    payload="${RESULT_LITERAL_OVERRIDE:-$literal}"
    hash="$(payload_hash_text "$literal")"; length="$(payload_length_text "$payload")"; encoded="$(payload_base64_text "$payload")"
  fi
  case "$status" in
    SUCCEEDED) recovery='Not required'; snapshot=None; replay=Consumed; post_local="$integration_sha"; post_remote="$integration_sha"; post_evidence="$approval" ;;
    REJECTED) recovery=Complete; snapshot=None; replay=Prohibited; post_local="$base_sha"; post_remote="$base_sha"; post_evidence="$approval" ;;
    PARTIAL) recovery=Unproved; snapshot="/private/tmp/recovery-$sequence/snapshot"; replay=Prohibited; post_local=Unknown; post_remote=Unknown; post_evidence=Unknown ;;
    *) recovery=Unknown; snapshot=Unknown; replay=Unknown; post_local=Unknown; post_remote=Unknown; post_evidence=Unknown ;;
  esac
  result_path="docs/orchestration/decisions/m0/results/main-$sequence.md"
  mkdir -p "$(dirname "$result_path")"
  {
    printf 'Controller recorder: program-controller\nRecorded timestamp: 2026-10-24T05:06:07Z\nResult status: %s\n' "$status"
    printf 'Consumed approval commit: %s\nConsumed approval path: %s\nIntegration candidate: %s\nTarget main commit: %s\nGuard command: validate_main_integration.sh integrate milestone/m0-research candidate base approval\n' "$approval" "$approval_path" "$integration_sha" "$base_sha"
    printf 'Guard output encoding: base64\nGuard output byte length: %s\nFull guard output SHA-256: %s\n' "${RESULT_LENGTH_OVERRIDE:-$length}" "$hash"
    printf 'Pre local main: %s\nPre remote main: %s\nPost local main: %s\nPost remote main: %s\nPre evidence tip: %s\nPost evidence tip: %s\n' "$base_sha" "$base_sha" "$post_local" "$post_remote" "$approval" "$post_evidence"
    [[ "${RESULT_OMIT_RECOVERY:-no}" == yes ]] || printf 'Recovery state: %s\n' "$recovery"
    printf 'Recovery snapshot path: %s\nReplay status: %s\n' "$snapshot" "$replay"
    printf '%s\n%s\n%s\n' '--- BEGIN GUARD OUTPUT ---' "${RESULT_ENCODED_OVERRIDE:-$encoded}" '--- END GUARD OUTPUT ---'
  } > "$result_path"
  git add "$result_path" && git commit --quiet -m "result-$sequence"; result_commit="$(git rev-parse HEAD)"
  binding_path="docs/orchestration/decisions/m0/bindings/result-$sequence.md"
  {
    printf 'Binding status: Current\nResult commit: %s\nResult path: %s\nResult status: %s\nConsumed approval commit: %s\nIntegration candidate: %s\nTarget main commit: %s\nReplay status: %s\n' "$result_commit" "$result_path" "$status" "$approval" "${RESULT_BINDING_CANDIDATE:-$integration_sha}" "$base_sha" "$replay"
  } > "$binding_path"
  git add "$binding_path" && git commit --quiet -m "result-binding-$sequence"
}

test_negative_decision_sequence() {
  setup_fixture negative-decision
  (cd "$work_repo" && append_negative_sequence 002)
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  run_guard authorize "$candidate_sha" "$base_sha" >/dev/null
  tests_run=$((tests_run + 1))
}

test_human_gate_sequence() {
  setup_fixture human-gate
  (cd "$work_repo" && append_human_gate_sequence 003)
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  run_guard authorize "$candidate_sha" "$base_sha" >/dev/null
  tests_run=$((tests_run + 1))
}

test_tampered_literal_review_output() {
  setup_fixture tampered-review
  (
    cd "$work_repo"
    review='docs/orchestration/decisions/m0/reviews/tampered.md'
    printf 'Controller recorder: program-controller\nReviewer role: qa_performance_verifier\nReviewer session: tampered\nRecorded timestamp: 2026-10-24T01:02:03Z\nReviewed candidate: %s\nVerification evidence commit: %s\nRuntime evidence SHA-256: %064d\nReview output encoding: base64\nReview output byte length: 15\nFull review output SHA-256: %064d\nVerdict: APPROVE\nCritical findings: 0\nImportant findings: 0\nMinor findings: 0\n--- BEGIN REVIEW OUTPUT ---\ndGFtcGVyZWQgYnl0ZXMK\n--- END REVIEW OUTPUT ---\n' "$base_sha" "$base_sha" 1 2 > "$review"
    git add "$review" && git commit --quiet -m tampered-review
  )
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'review full output hash differs from literal bytes' authorize "$candidate_sha" "$base_sha"
}

test_unsupported_future_approval() {
  setup_fixture unsupported-future-approval
  (
    cd "$work_repo"
    sed 's/^Decision kind: main-integration$/Decision kind: future-approval/' \
      docs/orchestration/decisions/m0/packages/mi-001.md > docs/orchestration/decisions/m0/packages/future-approval.md
    git add docs/orchestration/decisions/m0/packages/future-approval.md
    git commit --quiet -m unsupported-future-approval
  )
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'approval package decision kind is unsupported' authorize "$candidate_sha" "$base_sha"
}

test_missing_action_specific_bound() {
  setup_fixture missing-action-bound
  (
    cd "$work_repo"
    sed '/^Acceptance candidate: /d' docs/orchestration/decisions/m0/packages/mi-001.md > docs/orchestration/decisions/m0/packages/main-integration-missing-bound.md
    git add docs/orchestration/decisions/m0/packages/main-integration-missing-bound.md
    git commit --quiet -m main-integration-missing-bound
  )
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'main-integration package is missing acceptance candidate' authorize "$candidate_sha" "$base_sha"
}

test_next_milestone_action_bounds() {
  local sequence=next qa_path security_path final_path qa_commit security_commit final_commit output output_hash output_length output_encoded package_path package_commit verdict_path verdict_commit binding_path
  setup_fixture next-milestone-action-bounds
  (
    cd "$work_repo"
    qa_path='docs/orchestration/decisions/m0/reviews/qa-next.md'
    security_path='docs/orchestration/decisions/m0/reviews/security-next.md'
    final_path='docs/orchestration/decisions/m0/reviews/final-next.md'
    for spec in "qa_performance_verifier:$qa_path" "licensing_security_reviewer:$security_path" "final_code_reviewer:$final_path"; do
      role="${spec%%:*}"; path="${spec#*:}"
      output="APPROVE $role successor review."
      output_hash="$(payload_hash_text "$output")"; output_length="$(payload_length_text "$output")"; output_encoded="$(payload_base64_text "$output")"
      {
        printf 'Controller recorder: program-controller\nReviewer role: %s\nReviewer session: %s-next\n' "$role" "$role"
        printf 'Recorded timestamp: 2026-10-24T04:05:06Z\nReviewed candidate: %s\nVerification evidence commit: %s\n' "$integration_sha" "$integration_sha"
        printf 'Runtime evidence SHA-256: %064d\nReview output encoding: base64\nReview output byte length: %s\nFull review output SHA-256: %s\nVerdict: APPROVE\nCritical findings: 0\nImportant findings: 0\nMinor findings: 0\n' 3 "$output_length" "$output_hash"
        printf '%s\n%s\n%s\n' '--- BEGIN REVIEW OUTPUT ---' "$output_encoded" '--- END REVIEW OUTPUT ---'
      } > "$path"
      git add "$path" && git commit --quiet -m "next-review-$role"
      case "$role" in qa_*) qa_commit="$(git rev-parse HEAD)";; licensing_*) security_commit="$(git rev-parse HEAD)";; final_*) final_commit="$(git rev-parse HEAD)";; esac
    done
    package_path='docs/orchestration/decisions/m0/packages/next-milestone.md'
    {
      printf 'Milestone: M0\nDecision kind: next-milestone\nDecision disposition: APPROVAL\nContract commit: %s\nContract path: docs/orchestration/milestones/M0_CONTRACT.md\nReviewed candidate: %s\n' "$base_sha" "$integration_sha"
      printf 'Successor contract commit: %s\nSuccessor contract path: docs/orchestration/milestones/M1_CONTRACT.md\nEntry conditions evidence commit: %s\nEntry conditions evidence path: docs/orchestration/milestones/m1/evidence/entry-conditions.md\n' "$integration_sha" "$integration_sha"
      printf 'QA review commit: %s\nQA review path: %s\nLicensing review commit: %s\nLicensing review path: %s\nFinal review commit: %s\nFinal review path: %s\n' "$qa_commit" "$qa_path" "$security_commit" "$security_path" "$final_commit" "$final_path"
      printf 'Target main commit: %s\nCritical findings: 0\nImportant findings: 0\nLimitations: Fixture.\nRecovery: Stop.\n' "$base_sha"
    } > "$package_path"
    git add "$package_path" && git commit --quiet -m next-package; package_commit="$(git rev-parse HEAD)"
    verdict_path='docs/orchestration/decisions/m0/verdicts/next-milestone.md'
    {
      printf 'Controller recorder: program-controller\nSteward role: decision_steward\nSteward session: steward-next\nRecorded timestamp: 2026-10-24T05:06:07Z\n'
      printf 'Evidence package commit: %s\nEvidence package path: %s\nVerdict: APPROVE_NEXT_MILESTONE\nMilestone: M0\nContract commit: %s\nReviewed candidate: %s\n' "$package_commit" "$package_path" "$base_sha" "$integration_sha"
      printf 'Successor contract commit: %s\nEntry conditions evidence commit: %s\nTarget main commit: %s\nCritical findings: 0\nImportant findings: 0\nDecision: Approve exact successor contract.\n' "$integration_sha" "$integration_sha" "$base_sha"
    } > "$verdict_path"
    git add "$verdict_path" && git commit --quiet -m next-verdict; verdict_commit="$(git rev-parse HEAD)"
    binding_path='docs/orchestration/decisions/m0/bindings/next-milestone.md'
    {
      printf 'Binding status: Current\nMilestone: M0\nContract commit: %s\nPackage commit: %s\nPackage path: %s\nVerdict commit: %s\nVerdict path: %s\n' "$base_sha" "$package_commit" "$package_path" "$verdict_commit" "$verdict_path"
      printf 'Decision kind: APPROVE_NEXT_MILESTONE\nReviewed candidate: %s\nSuccessor contract commit: %s\nEntry conditions evidence commit: %s\nTarget main commit: %s\nAuthorization: GRANTED\nCritical findings: 0\nImportant findings: 0\n' "$integration_sha" "$integration_sha" "$integration_sha" "$base_sha"
    } > "$binding_path"
    git add "$binding_path" && git commit --quiet -m next-binding
  )
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  run_guard authorize "$candidate_sha" "$base_sha" >/dev/null
  tests_run=$((tests_run + 1))
}

test_result_schemas_and_replay() {
  local approval approval_path raw
  setup_fixture result-success
  approval="$candidate_sha"; approval_path='docs/orchestration/decisions/m0/bindings/main-integration.md'
  (cd "$work_repo" && append_result_sequence 001 SUCCEEDED "$approval" "$approval_path")
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  run_guard authorize "$candidate_sha" "$base_sha" >/dev/null
  tests_run=$((tests_run + 1))

  setup_fixture result-partial
  approval="$candidate_sha"
  (cd "$work_repo" && append_result_sequence 002 PARTIAL "$approval" "$approval_path")
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  run_guard authorize "$candidate_sha" "$base_sha" >/dev/null
  tests_run=$((tests_run + 1))

  setup_fixture result-replay
  approval="$candidate_sha"
  (cd "$work_repo" && append_result_sequence 003 REJECTED "$approval" "$approval_path"; append_result_sequence 004 REJECTED "$approval" "$approval_path")
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'approval is replayed by multiple results' authorize "$candidate_sha" "$base_sha"

  raw="$fixture_root/guard-output-no-final-newline.txt"
  printf 'Result status: SUCCEEDED\n--- END GUARD OUTPUT ---' > "$raw"
  setup_fixture result-raw-no-final-newline
  approval="$candidate_sha"
  (cd "$work_repo" && RESULT_RAW_FILE="$raw" append_result_sequence 005 SUCCEEDED "$approval" "$approval_path")
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  run_guard authorize "$candidate_sha" "$base_sha" >/dev/null
  tests_run=$((tests_run + 1))

  raw="$fixture_root/guard-output-trailing-newlines.txt"
  printf 'Full guard output SHA-256: decoded body\n--- BEGIN GUARD OUTPUT ---\n\n\n' > "$raw"
  setup_fixture result-raw-trailing-newlines
  approval="$candidate_sha"
  (cd "$work_repo" && RESULT_RAW_FILE="$raw" append_result_sequence 006 SUCCEEDED "$approval" "$approval_path")
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  run_guard authorize "$candidate_sha" "$base_sha" >/dev/null
  tests_run=$((tests_run + 1))
}

test_result_negative_schemas() {
  local approval approval_path
  approval_path='docs/orchestration/decisions/m0/bindings/main-integration.md'

  setup_fixture result-tampered-output
  approval="$candidate_sha"
  (cd "$work_repo" && RESULT_LITERAL_OVERRIDE='tampered guard bytes' append_result_sequence 011 SUCCEEDED "$approval" "$approval_path")
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'result guard output hash differs from literal bytes' authorize "$candidate_sha" "$base_sha"

  setup_fixture result-missing-field
  approval="$candidate_sha"
  (cd "$work_repo" && RESULT_OMIT_RECOVERY=yes append_result_sequence 012 REJECTED "$approval" "$approval_path")
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'result is missing recovery state' authorize "$candidate_sha" "$base_sha"

  setup_fixture result-length-tamper
  approval="$candidate_sha"
  (cd "$work_repo" && RESULT_LENGTH_OVERRIDE=1 append_result_sequence 015 SUCCEEDED "$approval" "$approval_path")
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'result guard output byte length differs from decoded bytes' authorize "$candidate_sha" "$base_sha"

  setup_fixture result-frame-tamper
  approval="$candidate_sha"
  (cd "$work_repo" && RESULT_ENCODED_OVERRIDE=$'YWJj\nZGVm' append_result_sequence 016 SUCCEEDED "$approval" "$approval_path")
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'result guard output is invalid' authorize "$candidate_sha" "$base_sha"

  setup_fixture result-binding-linkage
  approval="$candidate_sha"
  (cd "$work_repo" && RESULT_BINDING_CANDIDATE=3333333333333333333333333333333333333333 append_result_sequence 013 REJECTED "$approval" "$approval_path")
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'result binding conflicts with result' authorize "$candidate_sha" "$base_sha"

  setup_fixture result-invalid-status
  approval="$candidate_sha"
  (cd "$work_repo" && append_result_sequence 014 UNKNOWN "$approval" "$approval_path")
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'result status is invalid' authorize "$candidate_sha" "$base_sha"
}

test_exact_raw_byte_framing() {
  local raw
  raw="$fixture_root/raw-no-final-newline.txt"
  printf 'Verdict: APPROVE\nCritical findings: 0\n--- END REVIEW OUTPUT ---' > "$raw"
  REVIEW_RAW_FILE="$raw" setup_fixture raw-no-final-newline
  run_guard authorize "$candidate_sha" "$base_sha" >/dev/null
  tests_run=$((tests_run + 1))

  raw="$fixture_root/raw-trailing-newlines.txt"
  printf 'Guard output SHA-256: body text\n--- BEGIN REVIEW OUTPUT ---\n\n\n' > "$raw"
  REVIEW_RAW_FILE="$raw" setup_fixture raw-trailing-newlines
  run_guard authorize "$candidate_sha" "$base_sha" >/dev/null
  tests_run=$((tests_run + 1))

  if [[ -n "${CT04_QA_RAW_OUTPUT:-}" && -f "$CT04_QA_RAW_OUTPUT" ]]; then
    REVIEW_RAW_FILE="$CT04_QA_RAW_OUTPUT" setup_fixture raw-preserved-qa
    run_guard authorize "$candidate_sha" "$base_sha" >/dev/null
    tests_run=$((tests_run + 1))
  fi
}

test_raw_byte_framing_tamper() {
  REVIEW_LENGTH_OVERRIDE=1 setup_fixture raw-length-tamper-fixture
  assert_refusal_without_mutation 'review output byte length differs from decoded bytes' authorize "$candidate_sha" "$base_sha"

  REVIEW_ENCODED_OVERRIDE=$'YWJj\nZGVm' setup_fixture raw-multiline-frame
  assert_refusal_without_mutation 'review literal output is invalid' authorize "$candidate_sha" "$base_sha"
}

test_post_freeze_review_lane
test_negative_decision_sequence
test_human_gate_sequence
test_tampered_literal_review_output
test_unsupported_future_approval
test_missing_action_specific_bound
test_next_milestone_action_bounds
test_result_schemas_and_replay
test_result_negative_schemas
test_exact_raw_byte_framing
test_raw_byte_framing_tamper
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
