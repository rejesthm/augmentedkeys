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
trap '[[ "${KEEP_CT04_FIXTURES:-0}" == 1 ]] || rm -rf -- "$fixture_root"' EXIT

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
hash_file() { shasum -a 256 "$1" | awk '{print $1}'; }

payload_hash_text() { printf '%s\n' "$1" | shasum -a 256 | awk '{print $1}'; }
payload_length_text() { printf '%s\n' "$1" | wc -c | tr -d ' '; }
payload_base64_text() { printf '%s\n' "$1" | base64 | tr -d '\n'; }
payload_hash_file() { shasum -a 256 "$1" | awk '{print $1}'; }
payload_length_file() { wc -c < "$1" | tr -d ' '; }
payload_base64_file() { base64 < "$1" | tr -d '\n'; }

prepare_review_payload() {
  local destination="$1" candidate="$2" role="$3" session="$4" verification="$5" verdict="$6" critical="$7" important="$8" minor="$9" body_text="${10}"
  if [[ -n "${REVIEW_FULL_PAYLOAD_FILE:-}" ]]; then
    cat "$REVIEW_FULL_PAYLOAD_FILE" > "$destination"
    return
  fi
  {
    printf 'AUGMENTEDKEYS REVIEW ATTESTATION v1\n'
    printf 'Reviewed candidate: %s\n' "${ATTESTATION_CANDIDATE_OVERRIDE:-$candidate}"
    printf 'Reviewer role: %s\n' "${ATTESTATION_ROLE_OVERRIDE:-$role}"
    printf 'Reviewer session: %s\n' "${ATTESTATION_SESSION_OVERRIDE:-$session}"
    printf 'Verification evidence commit: %s\n' "${ATTESTATION_VERIFICATION_OVERRIDE:-$verification}"
    printf 'Verdict: %s\n' "${ATTESTATION_VERDICT_OVERRIDE:-$verdict}"
    printf 'Critical findings: %s\n' "${ATTESTATION_CRITICAL_OVERRIDE:-$critical}"
    printf 'Important findings: %s\n' "${ATTESTATION_IMPORTANT_OVERRIDE:-$important}"
    printf 'Minor findings: %s\n' "${ATTESTATION_MINOR_OVERRIDE:-$minor}"
    printf '%s\n\n' "${ATTESTATION_END_OVERRIDE:-END AUGMENTEDKEYS REVIEW ATTESTATION v1}"
    if [[ -n "${REVIEW_RAW_FILE:-}" ]]; then cat "$REVIEW_RAW_FILE"; else printf '%s\n' "$body_text"; fi
    if [[ "${ATTESTATION_DUPLICATE_PREFIX:-no}" == yes ]]; then
      printf 'AUGMENTEDKEYS REVIEW ATTESTATION v1\n'
    fi
    if [[ "${ATTESTATION_DUPLICATE:-no}" == yes ]]; then
      printf 'AUGMENTEDKEYS REVIEW ATTESTATION v1\nReviewed candidate: %s\nReviewer role: %s\nReviewer session: %s\nVerification evidence commit: %s\nVerdict: %s\nCritical findings: %s\nImportant findings: %s\nMinor findings: %s\nEND AUGMENTEDKEYS REVIEW ATTESTATION v1\n' "${DUPLICATE_CANDIDATE_OVERRIDE:-$candidate}" "${DUPLICATE_ROLE_OVERRIDE:-$role}" "${DUPLICATE_SESSION_OVERRIDE:-$session}" "${DUPLICATE_VERIFICATION_OVERRIDE:-$verification}" "${DUPLICATE_VERDICT_OVERRIDE:-$verdict}" "${DUPLICATE_CRITICAL_OVERRIDE:-$critical}" "${DUPLICATE_IMPORTANT_OVERRIDE:-$important}" "${DUPLICATE_MINOR_OVERRIDE:-$minor}"
    fi
  } > "$destination"
}

mutate_fixture_field() {
  local file="$1" kind="$2" omit= override= value= next=
  case "$kind" in
    verdict)
      omit="${FIXTURE_VERDICT_OMIT_FIELD:-}"
      override="${FIXTURE_VERDICT_OVERRIDE_FIELD:-}"
      value="${FIXTURE_VERDICT_OVERRIDE_VALUE:-}"
      ;;
    binding)
      omit="${FIXTURE_BINDING_OMIT_FIELD:-}"
      override="${FIXTURE_BINDING_OVERRIDE_FIELD:-}"
      value="${FIXTURE_BINDING_OVERRIDE_VALUE:-}"
      ;;
    *) fail 'unknown fixture mutation kind' ;;
  esac
  if [[ -n "$omit" ]]; then
    sed -i '' "/^${omit}: /d" "$file"
  fi
  if [[ -n "$override" ]]; then
    next="$file.next"
    awk -v prefix="$override: " -v value="$value" 'index($0,prefix)==1 {print prefix value; changed++; next} {print} END {if(changed>1) exit 42}' "$file" > "$next"
    mv "$next" "$file"
  fi
}

append_evidence_sequence() {
  local sequence="$1"
  local reviewed qa_path security_path final_path qa_commit security_commit final_commit package_commit verdict_commit output output_hash output_length output_encoded payload_file
  local acceptance_binding_commit delta_hash actual_delta_paths
  local milestone_key acceptance_action acceptance_verdict_action acceptance_verdict_sequence acceptance_binding_action
  local main_action main_verdict_action main_verdict_sequence main_binding_action
  local acceptance_package_path acceptance_verdict_path acceptance_binding_path main_package_path main_verdict_path main_binding_path
  milestone_key="${EVIDENCE_MILESTONE_KEY_OVERRIDE:-m0}"
  acceptance_action="${ACCEPTANCE_ACTION_OVERRIDE:-milestone-acceptance}"
  acceptance_verdict_action="${ACCEPTANCE_VERDICT_ACTION_OVERRIDE:-$acceptance_action}"
  acceptance_verdict_sequence="${ACCEPTANCE_VERDICT_SEQUENCE_OVERRIDE:-$sequence}"
  acceptance_binding_action="${ACCEPTANCE_BINDING_ACTION_OVERRIDE:-milestone-acceptance}"
  main_action="${MAIN_ACTION_OVERRIDE:-main-integration}"
  main_verdict_action="${MAIN_VERDICT_ACTION_OVERRIDE:-$main_action}"
  main_verdict_sequence="${MAIN_VERDICT_SEQUENCE_OVERRIDE:-$sequence}"
  main_binding_action="${MAIN_BINDING_ACTION_OVERRIDE:-main-integration}"
  acceptance_package_path="docs/orchestration/decisions/$milestone_key/packages/$acceptance_action-$sequence.md"
  acceptance_verdict_path="docs/orchestration/decisions/$milestone_key/verdicts/$acceptance_verdict_action-$acceptance_verdict_sequence.md"
  acceptance_binding_path="docs/orchestration/decisions/$milestone_key/bindings/$acceptance_binding_action.md"
  main_package_path="docs/orchestration/decisions/$milestone_key/packages/$main_action-$sequence.md"
  main_verdict_path="docs/orchestration/decisions/$milestone_key/verdicts/$main_verdict_action-$main_verdict_sequence.md"
  main_binding_path="docs/orchestration/decisions/$milestone_key/bindings/$main_binding_action.md"
  publisher_phase="${CT04_PUBLISHER_PHASE:-both}"
  if [[ "$publisher_phase" != main ]]; then
  reviewed="$acceptance_sha"
  qa_path="${ACCEPTANCE_QA_PATH_OVERRIDE:-docs/orchestration/decisions/m0/reviews/qa-$sequence.md}"
  security_path="${ACCEPTANCE_SECURITY_PATH_OVERRIDE:-docs/orchestration/decisions/m0/reviews/security-$sequence.md}"
  final_path="${ACCEPTANCE_FINAL_PATH_OVERRIDE:-docs/orchestration/decisions/m0/reviews/final-$sequence.md}"
  mkdir -p "docs/orchestration/decisions/$milestone_key/packages" "docs/orchestration/decisions/$milestone_key/verdicts" "docs/orchestration/decisions/$milestone_key/bindings" "$(dirname "$qa_path")" "$(dirname "$security_path")" "$(dirname "$final_path")"
  for spec in "qa_performance_verifier:$qa_path" "licensing_security_reviewer:$security_path" "final_code_reviewer:$final_path"; do
    role="${spec%%:*}"; path="${spec#*:}"
    output="APPROVE $role review for $sequence.
Verdict: APPROVE
Critical findings: 0
Important findings: 0
Metadata-looking review prose remains literal output."
    payload_file="$(mktemp "$fixture_root/review-payload.XXXXXX")"
    prepare_review_payload "$payload_file" "$reviewed" "$role" "$role-$sequence" "$reviewed" APPROVE 0 0 0 "$output"
    output_hash="$(payload_hash_file "$payload_file")"; output_length="$(payload_length_file "$payload_file")"; output_encoded="$(payload_base64_file "$payload_file")"
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
    printf 'Reviewed candidate: %s\nResulting milestone state: Accepted\nAccepted milestone tip: %s\nCompletion package commit: %s\nCompletion package path: docs/orchestration/milestones/m0/evidence/completion-package.md\n' "$acceptance_sha" "$acceptance_sha" "$acceptance_sha"
    printf 'QA review commit: %s\nQA review path: %s\n' "$qa_commit" "$qa_path"
    printf 'Licensing review commit: %s\nLicensing review path: %s\n' "$security_commit" "$security_path"
    printf 'Final review commit: %s\nFinal review path: %s\n' "$final_commit" "$final_path"
    printf 'Target main commit: %s\nCritical findings: 0\nImportant findings: 0\nLimitations: Fixture.\nRecovery: Stop.\n' "$base_sha"
  } > "$acceptance_package_path"
  git add "$acceptance_package_path" && git commit --quiet -m "acceptance-package-$sequence"
  package_commit="$(git rev-parse HEAD)"
  {
    printf 'Controller recorder: program-controller\nSteward role: decision_steward\nSteward session: steward-%s\nRecorded timestamp: 2026-10-24T02:03:04Z\n' "$sequence"
    printf 'Evidence package commit: %s\nEvidence package path: %s\nVerdict: APPROVE_MILESTONE\n' "$package_commit" "$acceptance_package_path"
    printf 'Milestone: M0\nContract commit: %s\nContract path: docs/orchestration/milestones/M0_CONTRACT.md\nReviewed candidate: %s\nResulting milestone state: Accepted\nAccepted milestone tip: %s\nCompletion package commit: %s\nCompletion package path: docs/orchestration/milestones/m0/evidence/completion-package.md\nTarget main commit: %s\n' "$base_sha" "$acceptance_sha" "$acceptance_sha" "$acceptance_sha" "$base_sha"
    printf 'Critical findings: 0\nImportant findings: 0\nDecision: Approve exact fixture milestone.\n'
  } > "$acceptance_verdict_path"
  mutate_fixture_field "$acceptance_verdict_path" verdict
  git add "$acceptance_verdict_path" && git commit --quiet -m "acceptance-verdict-$sequence"
  verdict_commit="$(git rev-parse HEAD)"
  {
    printf 'Binding status: Current\nMilestone: M0\nContract commit: %s\nContract path: docs/orchestration/milestones/M0_CONTRACT.md\nPackage commit: %s\nPackage path: %s\n' "$base_sha" "$package_commit" "$acceptance_package_path"
    printf 'Verdict commit: %s\nVerdict path: %s\n' "$verdict_commit" "$acceptance_verdict_path"
    printf 'Decision kind: APPROVE_MILESTONE\nReviewed candidate: %s\nResulting milestone state: Accepted\nAccepted milestone tip: %s\nCompletion package commit: %s\nCompletion package path: docs/orchestration/milestones/m0/evidence/completion-package.md\nTarget main commit: %s\nAuthorization: GRANTED\nCritical findings: 0\nImportant findings: 0\n' "$acceptance_sha" "$acceptance_sha" "$acceptance_sha" "$base_sha"
  } > "$acceptance_binding_path"
  mutate_fixture_field "$acceptance_binding_path" binding
  git add "$acceptance_binding_path" && git commit --quiet -m "acceptance-binding-$sequence"
  acceptance_binding_commit="$(git rev-parse HEAD)"
  fi
  if [[ "$publisher_phase" == acceptance ]]; then
    printf '%s\n' "$acceptance_binding_commit"
    return
  fi
  if [[ "$publisher_phase" == main ]]; then
    acceptance_binding_commit="${CT04_ACCEPTANCE_BINDING_COMMIT:?publisher main phase requires acceptance binding commit}"
  fi

  reviewed="$integration_sha"
  qa_path="${MAIN_QA_PATH_OVERRIDE:-docs/orchestration/decisions/m0/reviews/qa-main-$sequence.md}"
  security_path="${MAIN_SECURITY_PATH_OVERRIDE:-docs/orchestration/decisions/m0/reviews/security-main-$sequence.md}"
  final_path="${MAIN_FINAL_PATH_OVERRIDE:-docs/orchestration/decisions/m0/reviews/final-main-$sequence.md}"
  mkdir -p "$(dirname "$qa_path")" "$(dirname "$security_path")" "$(dirname "$final_path")"
  for spec in "qa_performance_verifier:$qa_path" "licensing_security_reviewer:$security_path" "final_code_reviewer:$final_path"; do
    role="${spec%%:*}"; path="${spec#*:}"
    output="APPROVE $role main review for $sequence.
Verdict: APPROVE
Critical findings: 0
Important findings: 0
Metadata-looking review prose remains literal output."
    payload_file="$(mktemp "$fixture_root/review-payload.XXXXXX")"
    prepare_review_payload "$payload_file" "$reviewed" "$role" "$role-main-$sequence" "$reviewed" APPROVE 0 0 0 "$output"
    output_hash="$(payload_hash_file "$payload_file")"; output_length="$(payload_length_file "$payload_file")"; output_encoded="$(payload_base64_file "$payload_file")"
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
  actual_delta_paths="$(git diff --name-only "$acceptance_sha..$integration_sha" | LC_ALL=C sort | paste -sd, -)"
  {
    printf 'Milestone: M0\nDecision kind: main-integration\nDecision disposition: APPROVAL\nContract commit: %s\nContract path: docs/orchestration/milestones/M0_CONTRACT.md\n' "$base_sha"
    printf 'Reviewed candidate: %s\nResulting milestone state: Accepted\nIntegration state: Pending\nAcceptance candidate: %s\nIntegration candidate: %s\n' "$integration_sha" "$acceptance_sha" "$integration_sha"
    printf 'Milestone branch: milestone/m0-research\n'
    printf 'Administrative delta paths: %s\nAdministrative delta SHA-256: %s\nAdministrative transition date: 2026-10-24\n' "$actual_delta_paths" "$delta_hash"
    printf 'Reviewed guard commit: %s\nReviewed guard path: .codex/skills/roadmap-orchestrator/scripts/validate_main_integration.sh\nReviewed guard SHA-256: %s\n' "$control_sha" "$(hash_file "$script_dir/validate_main_integration.sh")"
    printf 'Completion package commit: %s\nCompletion package path: docs/orchestration/milestones/m0/evidence/completion-package.md\n' "$acceptance_sha"
    printf 'Milestone acceptance binding commit: %s\nMilestone acceptance binding path: %s\n' "$acceptance_binding_commit" "$acceptance_binding_path"
    printf 'QA review commit: %s\nQA review path: %s\n' "$qa_commit" "$qa_path"
    printf 'Licensing review commit: %s\nLicensing review path: %s\n' "$security_commit" "$security_path"
    printf 'Final review commit: %s\nFinal review path: %s\n' "$final_commit" "$final_path"
    printf 'Target main commit: %s\nCritical findings: 0\nImportant findings: 0\nLimitations: Fixture.\nRecovery: Stop.\n' "$base_sha"
  } > "$main_package_path"
  git add "$main_package_path" && git commit --quiet -m "package-$sequence"
  package_commit="$(git rev-parse HEAD)"
  {
    printf 'Controller recorder: program-controller\nSteward role: decision_steward\nSteward session: steward-main-%s\nRecorded timestamp: 2026-10-24T02:13:14Z\n' "$sequence"
    printf 'Evidence package commit: %s\nEvidence package path: %s\nVerdict: APPROVE_MAIN_INTEGRATION\n' "$package_commit" "$main_package_path"
    printf 'Milestone: M0\nContract commit: %s\n' "$base_sha"
    [[ "${OMIT_MAIN_VERDICT_CONTRACT_PATH:-no}" == yes ]] || printf 'Contract path: docs/orchestration/milestones/M0_CONTRACT.md\n'
    printf 'Reviewed candidate: %s\nResulting milestone state: Accepted\nIntegration state: Pending\nAcceptance candidate: %s\nIntegration candidate: %s\n' "$integration_sha" "$acceptance_sha" "$integration_sha"
    printf 'Milestone branch: milestone/m0-research\n'
    printf 'Administrative delta paths: %s\nAdministrative delta SHA-256: %s\nAdministrative transition date: 2026-10-24\n' "$actual_delta_paths" "$delta_hash"
    printf 'Reviewed guard commit: %s\nReviewed guard path: .codex/skills/roadmap-orchestrator/scripts/validate_main_integration.sh\nReviewed guard SHA-256: %s\n' "$control_sha" "$(hash_file "$script_dir/validate_main_integration.sh")"
    printf 'Completion package commit: %s\nCompletion package path: docs/orchestration/milestones/m0/evidence/completion-package.md\nMilestone acceptance binding commit: %s\nMilestone acceptance binding path: %s\nTarget main commit: %s\n' "$acceptance_sha" "$acceptance_binding_commit" "$acceptance_binding_path" "$base_sha"
    printf 'Critical findings: 0\nImportant findings: 0\nDecision: Approve exact fixture main integration.\n'
  } > "$main_verdict_path"
  mutate_fixture_field "$main_verdict_path" verdict
  git add "$main_verdict_path" && git commit --quiet -m "verdict-$sequence"
  verdict_commit="$(git rev-parse HEAD)"
  {
    printf 'Binding status: Current\nMilestone: M0\nContract commit: %s\nContract path: docs/orchestration/milestones/M0_CONTRACT.md\nPackage commit: %s\nPackage path: %s\n' "$base_sha" "$package_commit" "$main_package_path"
    printf 'Verdict commit: %s\nVerdict path: %s\n' "$verdict_commit" "$main_verdict_path"
    printf 'Decision kind: APPROVE_MAIN_INTEGRATION\nReviewed candidate: %s\nResulting milestone state: Accepted\nIntegration state: Pending\nAcceptance candidate: %s\nIntegration candidate: %s\n' "$integration_sha" "$acceptance_sha" "$integration_sha"
    printf 'Milestone branch: milestone/m0-research\n'
    printf 'Administrative delta paths: %s\nAdministrative delta SHA-256: %s\nAdministrative transition date: 2026-10-24\n' "$actual_delta_paths" "$delta_hash"
    printf 'Reviewed guard commit: %s\nReviewed guard path: .codex/skills/roadmap-orchestrator/scripts/validate_main_integration.sh\nReviewed guard SHA-256: %s\n' "$control_sha" "$(hash_file "$script_dir/validate_main_integration.sh")"
    printf 'Completion package commit: %s\nCompletion package path: docs/orchestration/milestones/m0/evidence/completion-package.md\nMilestone acceptance binding commit: %s\nMilestone acceptance binding path: %s\nTarget main commit: %s\nAuthorization: GRANTED\nCritical findings: 0\nImportant findings: 0\n' "$acceptance_sha" "$acceptance_binding_commit" "$acceptance_binding_path" "$base_sha"
  } > "$main_binding_path"
  mutate_fixture_field "$main_binding_path" binding
  git add "$main_binding_path" && git commit --quiet -m "binding-$sequence"
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
    case "${CONTRACT_FIXTURE_KIND:-regular}" in
      regular) printf '# M0 Contract\n' > docs/orchestration/milestones/M0_CONTRACT.md ;;
      missing) : ;;
      symlink) ln -s ../../../governance.txt docs/orchestration/milestones/M0_CONTRACT.md ;;
      directory) mkdir docs/orchestration/milestones/M0_CONTRACT.md; printf 'nested\n' > docs/orchestration/milestones/M0_CONTRACT.md/entry.md ;;
      executable) printf '# M0 Contract\n' > docs/orchestration/milestones/M0_CONTRACT.md; chmod 0755 docs/orchestration/milestones/M0_CONTRACT.md ;;
      *) fail 'unknown contract fixture kind' ;;
    esac
    mkdir -p .codex/skills/roadmap-orchestrator/scripts
    cp "$guard" .codex/skills/roadmap-orchestrator/scripts/validate_decision_evidence.sh
    cp "$script_dir/validate_main_integration.sh" .codex/skills/roadmap-orchestrator/scripts/validate_main_integration.sh
    chmod 0755 .codex/skills/roadmap-orchestrator/scripts/validate_decision_evidence.sh
    chmod 0755 .codex/skills/roadmap-orchestrator/scripts/validate_main_integration.sh
    git add governance.txt
    if [[ -e docs/orchestration/milestones/M0_CONTRACT.md || -L docs/orchestration/milestones/M0_CONTRACT.md ]]; then
      git add docs/orchestration/milestones/M0_CONTRACT.md
    fi
    git add .codex/skills/roadmap-orchestrator/scripts/validate_decision_evidence.sh
    git add .codex/skills/roadmap-orchestrator/scripts/validate_main_integration.sh
    git commit --quiet -m governance-base
    control_sha="$(git rev-parse HEAD)"
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
  grep -F "$expected" "$output_file" >/dev/null || { cat "$output_file" >&2; fail "$expected: refusal message was not observed"; }
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
    git rm --quiet docs/orchestration/decisions/m0/packages/main-integration-001.md
    git commit --quiet -m deleted-evidence
  )
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'evidence history deletes canonical evidence' authorize "$candidate_sha" "$base_sha"
}

test_rewritten_package() {
  setup_fixture rewritten-package
  (
    cd "$work_repo"
    printf 'rewritten\n' >> docs/orchestration/decisions/m0/packages/main-integration-001.md
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
    printf 'merge rewrite\n' >> docs/orchestration/decisions/m0/packages/main-integration-001.md
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
  local output review_path literal literal_hash literal_length literal_encoded payload_file
  setup_fixture post-freeze-review
  review_path='docs/orchestration/decisions/m0/reviews/qa-integration-001.md'
  literal='APPROVE standalone post-freeze review.'
  payload_file="$(mktemp "$fixture_root/review-payload.XXXXXX")"
  prepare_review_payload "$payload_file" "$base_sha" qa_performance_verifier qa-session-001 "$base_sha" APPROVE 0 0 0 "$literal"
  literal_hash="$(payload_hash_file "$payload_file")"; literal_length="$(payload_length_file "$payload_file")"; literal_encoded="$(payload_base64_file "$payload_file")"
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
  local sequence="$1" verdict_kind="${2:-CORRECT}" reviewed role path literal literal_hash literal_length literal_encoded review_commit package_path package_commit verdict_path verdict_commit binding_path payload_file
  local action="${NEGATIVE_ACTION_OVERRIDE:-milestone-correction}"
  reviewed="${NEGATIVE_REVIEWED_OVERRIDE:-$(git rev-parse refs/heads/main)}"
  role="${NEGATIVE_ROLE_OVERRIDE:-qa_performance_verifier}"
  case "$role" in
    qa_performance_verifier) review_label=qa ;;
    licensing_security_reviewer) review_label=security ;;
    final_code_reviewer) review_label=final ;;
    *) fail 'unknown negative reviewer role override' ;;
  esac
  path="${NEGATIVE_REVIEW_PATH_OVERRIDE:-docs/orchestration/decisions/m0/reviews/$review_label-reject-$sequence.md}"
  literal="REJECT review for $sequence with one Important finding."
  payload_file="$(mktemp "$fixture_root/review-payload.XXXXXX")"
  prepare_review_payload "$payload_file" "$reviewed" "$role" "reject-$sequence" "$reviewed" REJECT 0 1 0 "$literal"
  literal_hash="$(payload_hash_file "$payload_file")"; literal_length="$(payload_length_file "$payload_file")"; literal_encoded="$(payload_base64_file "$payload_file")"
  mkdir -p "$(dirname "$path")"
  {
    printf 'Controller recorder: program-controller\nReviewer role: %s\nReviewer session: reject-%s\n' "$role" "$sequence"
    printf 'Recorded timestamp: 2026-10-24T03:04:05Z\nReviewed candidate: %s\nVerification evidence commit: %s\n' "$reviewed" "$reviewed"
    printf 'Runtime evidence SHA-256: %064d\nReview output encoding: base64\nReview output byte length: %s\nFull review output SHA-256: %s\n' 3 "$literal_length" "$literal_hash"
    printf 'Verdict: REJECT\nCritical findings: 0\nImportant findings: 1\nMinor findings: 0\n'
    printf '%s\n%s\n%s\n' '--- BEGIN REVIEW OUTPUT ---' "$literal_encoded" '--- END REVIEW OUTPUT ---'
  } > "$path"
  git add "$path" && git commit --quiet -m "reject-review-$sequence"; review_commit="$(git rev-parse HEAD)"
  package_path="docs/orchestration/decisions/m0/packages/$action-$sequence.md"
  {
    printf 'Milestone: M0\nDecision kind: milestone-correction\nDecision disposition: NEGATIVE\nResulting milestone state: Paused for owner decision\n'
    printf 'Contract commit: %s\nContract path: docs/orchestration/milestones/M0_CONTRACT.md\nReviewed candidate: %s\nTarget main commit: %s\n' "$base_sha" "$reviewed" "$base_sha"
    printf 'Blocking evidence status: REJECTED\nBlocking review commit: %s\nBlocking review path: %s\nBlocking reviewer role: %s\n' "$review_commit" "$path" "$role"
    printf 'Critical findings: 0\nImportant findings: 1\nLimitations: Rejected fixture.\nRecovery: Correct then review again.\n'
  } > "$package_path"
  git add "$package_path" && git commit --quiet -m "negative-package-$sequence"; package_commit="$(git rev-parse HEAD)"
  verdict_path="docs/orchestration/decisions/m0/verdicts/$action-$sequence.md"
  {
    printf 'Controller recorder: program-controller\nSteward role: decision_steward\nSteward session: correction-%s\nRecorded timestamp: 2026-10-24T04:05:06Z\n' "$sequence"
    printf 'Evidence package commit: %s\nEvidence package path: %s\nVerdict: %s\nMilestone: M0\nContract commit: %s\nContract path: docs/orchestration/milestones/M0_CONTRACT.md\nReviewed candidate: %s\nTarget main commit: %s\nResulting milestone state: Paused for owner decision\nBlocking evidence status: REJECTED\n' "$package_commit" "$package_path" "$verdict_kind" "$base_sha" "$reviewed" "$base_sha"
    printf 'Critical findings: 0\nImportant findings: 1\nDecision: Correct exact blocking finding.\n'
  } > "$verdict_path"
  mutate_fixture_field "$verdict_path" verdict
  git add "$verdict_path" && git commit --quiet -m "negative-verdict-$sequence"; verdict_commit="$(git rev-parse HEAD)"
  binding_path="docs/orchestration/decisions/m0/bindings/$action.md"
  {
    printf 'Binding status: Current\nMilestone: M0\nContract commit: %s\nContract path: docs/orchestration/milestones/M0_CONTRACT.md\nPackage commit: %s\nPackage path: %s\nVerdict commit: %s\nVerdict path: %s\n' "$base_sha" "$package_commit" "$package_path" "$verdict_commit" "$verdict_path"
    printf 'Decision kind: %s\nReviewed candidate: %s\nTarget main commit: %s\nResulting milestone state: Paused for owner decision\nBlocking evidence status: REJECTED\nAuthorization: DENIED\nCritical findings: 0\nImportant findings: 1\n' "$verdict_kind" "$reviewed" "$base_sha"
  } > "$binding_path"
  mutate_fixture_field "$binding_path" binding
  git add "$binding_path" && git commit --quiet -m "negative-binding-$sequence"
}

append_human_gate_sequence() {
  local sequence="$1" reviewed role path literal literal_hash literal_length literal_encoded qa_commit security_commit final_commit package_path package_commit verdict_path verdict_commit binding_path payload_file
  local action="${HUMAN_ACTION_OVERRIDE:-human-gate}"
  reviewed="${HUMAN_REVIEWED_OVERRIDE:-$(git rev-parse refs/heads/main)}"
  for spec in "qa_performance_verifier:qa" "licensing_security_reviewer:security" "final_code_reviewer:final"; do
    role="${spec%%:*}"; label="${spec#*:}"
    case "$label" in
      qa) path="${HUMAN_QA_PATH_OVERRIDE:-docs/orchestration/decisions/m0/reviews/qa-human-$sequence.md}" ;;
      security) path="${HUMAN_SECURITY_PATH_OVERRIDE:-docs/orchestration/decisions/m0/reviews/security-human-$sequence.md}" ;;
      final) path="${HUMAN_FINAL_PATH_OVERRIDE:-docs/orchestration/decisions/m0/reviews/final-human-$sequence.md}" ;;
    esac
    literal="APPROVE $role technical review; owner-only boundary remains.
Verdict: APPROVE
Critical findings: 0
Important findings: 0"
    payload_file="$(mktemp "$fixture_root/review-payload.XXXXXX")"
    prepare_review_payload "$payload_file" "$reviewed" "$role" "human-$label-$sequence" "$reviewed" APPROVE 0 0 0 "$literal"
    literal_hash="$(payload_hash_file "$payload_file")"; literal_length="$(payload_length_file "$payload_file")"; literal_encoded="$(payload_base64_file "$payload_file")"
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
  package_path="docs/orchestration/decisions/m0/packages/$action-$sequence.md"
  {
    printf 'Milestone: M0\nDecision kind: human-gate\nDecision disposition: NEGATIVE\nResulting milestone state: Paused for owner decision\nContract commit: %s\nContract path: docs/orchestration/milestones/M0_CONTRACT.md\n' "$base_sha"
    printf 'Reviewed candidate: %s\nTarget main commit: %s\nBlocking evidence status: HUMAN_GATE\n' "$reviewed" "$base_sha"
    printf 'Human gate reason: Paused governance and repaired contract require explicit owner acceptance before reactivation.\n'
    printf 'QA review commit: %s\nQA review path: %s\nLicensing review commit: %s\nLicensing review path: %s\nFinal review commit: %s\nFinal review path: %s\n' "$qa_commit" "$qa_path" "$security_commit" "$security_path" "$final_commit" "$final_path"
    printf 'Critical findings: 0\nImportant findings: 0\nLimitations: Technical reviews do not cross the owner-only gate.\nRecovery: Preserve pause and request exact owner decision.\n'
  } > "$package_path"
  git add "$package_path" && git commit --quiet -m "human-package-$sequence"; package_commit="$(git rev-parse HEAD)"
  verdict_path="docs/orchestration/decisions/m0/verdicts/$action-$sequence.md"
  {
    printf 'Controller recorder: program-controller\nSteward role: decision_steward\nSteward session: human-gate-%s\nRecorded timestamp: 2026-10-24T07:08:09Z\n' "$sequence"
    printf 'Evidence package commit: %s\nEvidence package path: %s\nVerdict: PAUSE_HUMAN\nMilestone: M0\nContract commit: %s\nContract path: docs/orchestration/milestones/M0_CONTRACT.md\nReviewed candidate: %s\nTarget main commit: %s\nResulting milestone state: Paused for owner decision\nBlocking evidence status: HUMAN_GATE\n' "$package_commit" "$package_path" "$base_sha" "$reviewed" "$base_sha"
    printf 'Critical findings: 0\nImportant findings: 0\nDecision: Preserve owner-only activation boundary.\n'
  } > "$verdict_path"
  mutate_fixture_field "$verdict_path" verdict
  git add "$verdict_path" && git commit --quiet -m "human-verdict-$sequence"; verdict_commit="$(git rev-parse HEAD)"
  binding_path="docs/orchestration/decisions/m0/bindings/$action.md"
  {
    printf 'Binding status: Current\nMilestone: M0\nContract commit: %s\nContract path: docs/orchestration/milestones/M0_CONTRACT.md\nPackage commit: %s\nPackage path: %s\nVerdict commit: %s\nVerdict path: %s\n' "$base_sha" "$package_commit" "$package_path" "$verdict_commit" "$verdict_path"
    printf 'Decision kind: PAUSE_HUMAN\nReviewed candidate: %s\nTarget main commit: %s\nResulting milestone state: Paused for owner decision\nBlocking evidence status: HUMAN_GATE\nAuthorization: DENIED\nCritical findings: 0\nImportant findings: 0\n' "$reviewed" "$base_sha"
  } > "$binding_path"
  mutate_fixture_field "$binding_path" binding
  git add "$binding_path" && git commit --quiet -m "human-binding-$sequence"
}

append_result_sequence() {
  local sequence="$1" status="$2" approval="$3" approval_path="$4" literal payload hash length encoded result_path result_commit binding_path recovery snapshot replay post_local post_remote post_evidence result_candidate result_target result_branch result_guard_commit result_guard_path result_guard_hash result_approval_path result_argv
  local action="${RESULT_ACTION_OVERRIDE:-main-integration-result}"
  literal="$status guard output for $sequence.
Result status: REJECTED
Critical findings: 0
Guard-output control-like text remains literal output."
  result_candidate="${RESULT_CANDIDATE_OVERRIDE:-$integration_sha}"
  result_target="${RESULT_TARGET_OVERRIDE:-$base_sha}"
  result_branch="${RESULT_BRANCH_OVERRIDE:-milestone/m0-research}"
  result_guard_commit="${RESULT_GUARD_COMMIT_OVERRIDE:-$control_sha}"
  result_guard_path="${RESULT_GUARD_PATH_OVERRIDE:-.codex/skills/roadmap-orchestrator/scripts/validate_main_integration.sh}"
  result_guard_hash="${RESULT_GUARD_HASH_OVERRIDE:-$(hash_file "$script_dir/validate_main_integration.sh")}"
  result_approval_path="${RESULT_APPROVAL_PATH_OVERRIDE:-$approval_path}"
  result_argv="${RESULT_ARGV_OVERRIDE:-validate_main_integration.sh|integrate|$result_branch|$result_candidate|$result_target|$approval}"
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
  result_path="docs/orchestration/decisions/m0/results/$action-$sequence.md"
  mkdir -p "$(dirname "$result_path")"
  {
    printf 'Controller recorder: program-controller\nRecorded timestamp: 2026-10-24T05:06:07Z\nResult status: %s\n' "$status"
    printf 'Consumed approval commit: %s\nConsumed approval path: %s\nMilestone branch: %s\nIntegration candidate: %s\nTarget main commit: %s\n' "$approval" "$result_approval_path" "$result_branch" "$result_candidate" "$result_target"
    printf 'Guard argv: %s\nReviewed guard commit: %s\nReviewed guard path: %s\nReviewed guard SHA-256: %s\n' "$result_argv" "$result_guard_commit" "$result_guard_path" "$result_guard_hash"
    [[ "${RESULT_OMIT_ENVIRONMENT:-no}" == yes ]] || printf 'Execution environment: Disposable local test repository; no credentials.\n'
    printf 'Limitations: Synthetic result fixture only.\nInterruption point: None observed.\n'
    printf 'Guard output encoding: base64\nGuard output byte length: %s\nFull guard output SHA-256: %s\n' "${RESULT_LENGTH_OVERRIDE:-$length}" "$hash"
    printf 'Pre local main: %s\nPre remote main: %s\nPost local main: %s\nPost remote main: %s\nPre evidence tip: %s\nPost evidence tip: %s\n' "$base_sha" "$base_sha" "$post_local" "$post_remote" "$approval" "$post_evidence"
    [[ "${RESULT_OMIT_RECOVERY:-no}" == yes ]] || printf 'Recovery state: %s\n' "$recovery"
    printf 'Recovery snapshot path: %s\nReplay status: %s\n' "$snapshot" "$replay"
    printf '%s\n%s\n%s\n' '--- BEGIN GUARD OUTPUT ---' "${RESULT_ENCODED_OVERRIDE:-$encoded}" '--- END GUARD OUTPUT ---'
  } > "$result_path"
  git add "$result_path" && git commit --quiet -m "result-$sequence"; result_commit="$(git rev-parse HEAD)"
  binding_path="docs/orchestration/decisions/m0/bindings/$action.md"
  {
    printf 'Binding status: Current\nResult commit: %s\nResult path: %s\nResult status: %s\nConsumed approval commit: %s\nConsumed approval path: %s\nMilestone branch: %s\nIntegration candidate: %s\nTarget main commit: %s\n' "$result_commit" "$result_path" "$status" "$approval" "$result_approval_path" "$result_branch" "${RESULT_BINDING_CANDIDATE:-$result_candidate}" "$result_target"
    printf 'Guard argv: %s\nReviewed guard commit: %s\nReviewed guard path: %s\nReviewed guard SHA-256: %s\n' "$result_argv" "$result_guard_commit" "$result_guard_path" "$result_guard_hash"
    printf 'Execution environment: Disposable local test repository; no credentials.\nLimitations: Synthetic result fixture only.\nInterruption point: None observed.\n'
    [[ "${RESULT_BINDING_OMIT_ENCODING:-no}" == yes ]] || printf 'Guard output encoding: %s\n' "${RESULT_BINDING_ENCODING_OVERRIDE:-base64}"
    [[ "${RESULT_BINDING_OMIT_LENGTH:-no}" == yes ]] || printf 'Guard output byte length: %s\n' "${RESULT_BINDING_LENGTH_OVERRIDE:-$length}"
    printf 'Full guard output SHA-256: %s\nPre local main: %s\nPre remote main: %s\nPost local main: %s\nPost remote main: %s\nPre evidence tip: %s\nPost evidence tip: %s\nRecovery state: %s\nRecovery snapshot path: %s\nReplay status: %s\n'  "$hash" "$base_sha" "$base_sha" "$post_local" "$post_remote" "$approval" "$post_evidence" "$recovery" "$snapshot" "$replay"
  } > "$binding_path"
  mutate_fixture_field "$binding_path" binding
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
      docs/orchestration/decisions/m0/packages/main-integration-001.md > docs/orchestration/decisions/m0/packages/future-approval-001.md
    git add docs/orchestration/decisions/m0/packages/future-approval-001.md
    git commit --quiet -m unsupported-future-approval
  )
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'approval package decision kind is unsupported' authorize "$candidate_sha" "$base_sha"
}

test_missing_action_specific_bound() {
  setup_fixture missing-action-bound
  (
    cd "$work_repo"
    sed '/^Acceptance candidate: /d' docs/orchestration/decisions/m0/packages/main-integration-001.md > docs/orchestration/decisions/m0/packages/main-integration-missing-bound.md
    git add docs/orchestration/decisions/m0/packages/main-integration-missing-bound.md
    git commit --quiet -m main-integration-missing-bound
  )
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'main-integration package is missing acceptance candidate' authorize "$candidate_sha" "$base_sha"
}

test_next_milestone_action_bounds() {
  local sequence=next qa_path security_path final_path qa_commit security_commit final_commit output output_hash output_length output_encoded package_path package_commit verdict_path verdict_commit binding_path
  setup_fixture "next-milestone-action-bounds-${NEXT_CASE_NAME:-valid}"
  (
    cd "$work_repo"
    qa_path="${NEXT_QA_PATH_OVERRIDE:-docs/orchestration/decisions/m0/reviews/qa-next.md}"
    security_path="${NEXT_SECURITY_PATH_OVERRIDE:-docs/orchestration/decisions/m0/reviews/security-next.md}"
    final_path="${NEXT_FINAL_PATH_OVERRIDE:-docs/orchestration/decisions/m0/reviews/final-next.md}"
    mkdir -p "$(dirname "$qa_path")" "$(dirname "$security_path")" "$(dirname "$final_path")"
    for spec in "qa_performance_verifier:$qa_path" "licensing_security_reviewer:$security_path" "final_code_reviewer:$final_path"; do
      role="${spec%%:*}"; path="${spec#*:}"
      output="APPROVE $role successor review."
      payload_file="$(mktemp "$fixture_root/review-payload.XXXXXX")"
      prepare_review_payload "$payload_file" "$integration_sha" "$role" "$role-next" "$integration_sha" APPROVE 0 0 0 "$output"
      output_hash="$(payload_hash_file "$payload_file")"; output_length="$(payload_length_file "$payload_file")"; output_encoded="$(payload_base64_file "$payload_file")"
      {
        printf 'Controller recorder: program-controller\nReviewer role: %s\nReviewer session: %s-next\n' "$role" "$role"
        printf 'Recorded timestamp: 2026-10-24T04:05:06Z\nReviewed candidate: %s\nVerification evidence commit: %s\n' "$integration_sha" "$integration_sha"
        printf 'Runtime evidence SHA-256: %064d\nReview output encoding: base64\nReview output byte length: %s\nFull review output SHA-256: %s\nVerdict: APPROVE\nCritical findings: 0\nImportant findings: 0\nMinor findings: 0\n' 3 "$output_length" "$output_hash"
        printf '%s\n%s\n%s\n' '--- BEGIN REVIEW OUTPUT ---' "$output_encoded" '--- END REVIEW OUTPUT ---'
      } > "$path"
      git add "$path" && git commit --quiet -m "next-review-$role"
      case "$role" in qa_*) qa_commit="$(git rev-parse HEAD)";; licensing_*) security_commit="$(git rev-parse HEAD)";; final_*) final_commit="$(git rev-parse HEAD)";; esac
    done
    package_path='docs/orchestration/decisions/m0/packages/next-milestone-001.md'
    {
      printf 'Milestone: M0\nDecision kind: next-milestone\nDecision disposition: APPROVAL\nResulting milestone state: Accepted\nSuccessor state: Approved for activation\nContract commit: %s\nContract path: docs/orchestration/milestones/M0_CONTRACT.md\nReviewed candidate: %s\n' "$base_sha" "$integration_sha"
      printf 'Successor contract commit: %s\nSuccessor contract path: docs/orchestration/milestones/M1_CONTRACT.md\nEntry conditions evidence commit: %s\nEntry conditions evidence path: docs/orchestration/milestones/m1/evidence/entry-conditions.md\n' "$integration_sha" "$integration_sha"
      printf 'QA review commit: %s\nQA review path: %s\nLicensing review commit: %s\nLicensing review path: %s\nFinal review commit: %s\nFinal review path: %s\n' "$qa_commit" "$qa_path" "$security_commit" "$security_path" "$final_commit" "$final_path"
      printf 'Target main commit: %s\nCritical findings: 0\nImportant findings: 0\nLimitations: Fixture.\nRecovery: Stop.\n' "$base_sha"
    } > "$package_path"
    git add "$package_path" && git commit --quiet -m next-package; package_commit="$(git rev-parse HEAD)"
    verdict_path='docs/orchestration/decisions/m0/verdicts/next-milestone-001.md'
    {
      printf 'Controller recorder: program-controller\nSteward role: decision_steward\nSteward session: steward-next\nRecorded timestamp: 2026-10-24T05:06:07Z\n'
      printf 'Evidence package commit: %s\nEvidence package path: %s\nVerdict: APPROVE_NEXT_MILESTONE\nMilestone: M0\nContract commit: %s\nContract path: docs/orchestration/milestones/M0_CONTRACT.md\nReviewed candidate: %s\nResulting milestone state: Accepted\nSuccessor state: Approved for activation\n' "$package_commit" "$package_path" "$base_sha" "$integration_sha"
      printf 'Successor contract commit: %s\nSuccessor contract path: docs/orchestration/milestones/M1_CONTRACT.md\nEntry conditions evidence commit: %s\nEntry conditions evidence path: docs/orchestration/milestones/m1/evidence/entry-conditions.md\nTarget main commit: %s\nCritical findings: 0\nImportant findings: 0\nDecision: Approve exact successor contract.\n' "$integration_sha" "$integration_sha" "$base_sha"
    } > "$verdict_path"
    mutate_fixture_field "$verdict_path" verdict
    git add "$verdict_path" && git commit --quiet -m next-verdict; verdict_commit="$(git rev-parse HEAD)"
    binding_path='docs/orchestration/decisions/m0/bindings/next-milestone.md'
    {
      printf 'Binding status: Current\nMilestone: M0\nContract commit: %s\nContract path: docs/orchestration/milestones/M0_CONTRACT.md\nPackage commit: %s\nPackage path: %s\nVerdict commit: %s\nVerdict path: %s\n' "$base_sha" "$package_commit" "$package_path" "$verdict_commit" "$verdict_path"
      printf 'Decision kind: APPROVE_NEXT_MILESTONE\nReviewed candidate: %s\nResulting milestone state: Accepted\nSuccessor state: Approved for activation\nSuccessor contract commit: %s\nSuccessor contract path: docs/orchestration/milestones/M1_CONTRACT.md\nEntry conditions evidence commit: %s\nEntry conditions evidence path: docs/orchestration/milestones/m1/evidence/entry-conditions.md\nTarget main commit: %s\nAuthorization: GRANTED\nCritical findings: 0\nImportant findings: 0\n' "$integration_sha" "$integration_sha" "$integration_sha" "$base_sha"
    } > "$binding_path"
    mutate_fixture_field "$binding_path" binding
    git add "$binding_path" && git commit --quiet -m next-binding
  )
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  if [[ -n "${NEXT_EXPECT_REFUSAL:-}" ]]; then
    assert_refusal_without_mutation "$NEXT_EXPECT_REFUSAL" authorize "$candidate_sha" "$base_sha"
  else
    run_guard authorize "$candidate_sha" "$base_sha" >/dev/null
    tests_run=$((tests_run + 1))
  fi
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

  setup_fixture result-wrong-candidate
  approval="$candidate_sha"
  (cd "$work_repo" && RESULT_CANDIDATE_OVERRIDE="$base_sha" append_result_sequence 017 REJECTED "$approval" "$approval_path")
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'result candidate or target differs from consumed approval' authorize "$candidate_sha" "$base_sha"

  setup_fixture result-wrong-target
  approval="$candidate_sha"
  (cd "$work_repo" && RESULT_TARGET_OVERRIDE="$integration_sha" append_result_sequence 018 REJECTED "$approval" "$approval_path")
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'result candidate or target differs from consumed approval' authorize "$candidate_sha" "$base_sha"

  setup_fixture result-wrong-branch
  approval="$candidate_sha"
  (cd "$work_repo" && RESULT_BRANCH_OVERRIDE=milestone/m0-wrong append_result_sequence 019 REJECTED "$approval" "$approval_path")
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'result invocation provenance differs from consumed approval' authorize "$candidate_sha" "$base_sha"

  setup_fixture result-wrong-guard-hash
  approval="$candidate_sha"
  (cd "$work_repo" && RESULT_GUARD_HASH_OVERRIDE=1111111111111111111111111111111111111111111111111111111111111111 append_result_sequence 020 REJECTED "$approval" "$approval_path")
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'result invocation provenance differs from consumed approval' authorize "$candidate_sha" "$base_sha"

  setup_fixture result-missing-environment
  approval="$candidate_sha"
  (cd "$work_repo" && RESULT_OMIT_ENVIRONMENT=yes append_result_sequence 021 REJECTED "$approval" "$approval_path")
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'result is missing execution environment' authorize "$candidate_sha" "$base_sha"
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
    REVIEW_FULL_PAYLOAD_FILE="$CT04_QA_RAW_OUTPUT" setup_fixture raw-preserved-qa-reject
    assert_refusal_without_mutation 'review attestation is invalid' authorize "$candidate_sha" "$base_sha"
  fi
}

test_raw_byte_framing_tamper() {
  REVIEW_LENGTH_OVERRIDE=1 setup_fixture raw-length-tamper-fixture
  assert_refusal_without_mutation 'review output byte length differs from decoded bytes' authorize "$candidate_sha" "$base_sha"

  REVIEW_ENCODED_OVERRIDE=$'YWJj\nZGVm' setup_fixture raw-multiline-frame
  assert_refusal_without_mutation 'review literal output is invalid' authorize "$candidate_sha" "$base_sha"
}

test_reviewer_attestation_required() {
  local rejected_output="${CT04_REJECTED_REVIEW_OUTPUT:-${CT04_QA_RAW_OUTPUT:-}}"
  [[ -n "$rejected_output" && -f "$rejected_output" ]] || fail 'rejected review fixture is unavailable'
  REVIEW_FULL_PAYLOAD_FILE="$rejected_output" setup_fixture reviewer-attestation-missing
  assert_refusal_without_mutation 'review attestation is invalid' authorize "$candidate_sha" "$base_sha"

  if [[ -n "${CT04_ATTESTED_REJECT_OUTPUT:-}" && -f "$CT04_ATTESTED_REJECT_OUTPUT" ]]; then
    REVIEW_FULL_PAYLOAD_FILE="$CT04_ATTESTED_REJECT_OUTPUT" setup_fixture reviewer-attested-reject
    assert_refusal_without_mutation 'review attestation differs from recorder metadata' authorize "$candidate_sha" "$base_sha"
  fi

  ATTESTATION_ROLE_OVERRIDE=final_code_reviewer setup_fixture reviewer-attestation-role-mismatch
  assert_refusal_without_mutation 'review attestation differs from recorder metadata' authorize "$candidate_sha" "$base_sha"

  ATTESTATION_CANDIDATE_OVERRIDE=1111111111111111111111111111111111111111 setup_fixture reviewer-attestation-candidate-mismatch
  assert_refusal_without_mutation 'review attestation differs from recorder metadata' authorize "$candidate_sha" "$base_sha"

  ATTESTATION_SESSION_OVERRIDE=other-session setup_fixture reviewer-attestation-session-mismatch
  assert_refusal_without_mutation 'review attestation differs from recorder metadata' authorize "$candidate_sha" "$base_sha"

  ATTESTATION_VERIFICATION_OVERRIDE=1111111111111111111111111111111111111111 setup_fixture reviewer-attestation-verification-mismatch
  assert_refusal_without_mutation 'review attestation differs from recorder metadata' authorize "$candidate_sha" "$base_sha"

  ATTESTATION_VERDICT_OVERRIDE=REJECT ATTESTATION_IMPORTANT_OVERRIDE=5 setup_fixture reviewer-attestation-verdict-mismatch
  assert_refusal_without_mutation 'review attestation differs from recorder metadata' authorize "$candidate_sha" "$base_sha"

  ATTESTATION_CRITICAL_OVERRIDE=1 setup_fixture reviewer-attestation-critical-mismatch
  assert_refusal_without_mutation 'review attestation differs from recorder metadata' authorize "$candidate_sha" "$base_sha"
  ATTESTATION_IMPORTANT_OVERRIDE=1 setup_fixture reviewer-attestation-important-mismatch
  assert_refusal_without_mutation 'review attestation differs from recorder metadata' authorize "$candidate_sha" "$base_sha"
  ATTESTATION_MINOR_OVERRIDE=1 setup_fixture reviewer-attestation-minor-mismatch
  assert_refusal_without_mutation 'review attestation differs from recorder metadata' authorize "$candidate_sha" "$base_sha"

  ATTESTATION_END_OVERRIDE='END AUGMENTEDKEYS REVIEW ATTESTATION v2' setup_fixture reviewer-attestation-malformed
  assert_refusal_without_mutation 'review attestation is invalid' authorize "$candidate_sha" "$base_sha"
  ATTESTATION_DUPLICATE=yes setup_fixture reviewer-attestation-duplicate
  assert_refusal_without_mutation 'review attestation is invalid' authorize "$candidate_sha" "$base_sha"
}

append_missing_evidence_sequence() {
  local sequence="$1" reviewed="$2" package_path package_commit verdict_path verdict_commit binding_path
  local action="${MISSING_ACTION_OVERRIDE:-milestone-correction}"
  package_path="docs/orchestration/decisions/m0/packages/$action-$sequence.md"
  verdict_path="docs/orchestration/decisions/m0/verdicts/$action-$sequence.md"
  binding_path="docs/orchestration/decisions/m0/bindings/$action.md"
  mkdir -p docs/orchestration/decisions/m0/{packages,verdicts,bindings}
  {
    printf 'Milestone: M0\nDecision kind: milestone-correction\nDecision disposition: NEGATIVE\nResulting milestone state: Paused for owner decision\n'
    printf 'Contract commit: %s\nContract path: docs/orchestration/milestones/M0_CONTRACT.md\nReviewed candidate: %s\nTarget main commit: %s\n' "$base_sha" "$reviewed" "$base_sha"
    printf 'Blocking evidence status: MISSING\nMissing evidence: Exact reviewer output is unavailable.\nCritical findings: Unknown\nImportant findings: Unknown\nLimitations: Missing fixture.\nRecovery: Preserve pause.\n'
  } > "$package_path"
  git add "$package_path" && git commit --quiet -m "missing-package-$sequence"; package_commit="$(git rev-parse HEAD)"
  {
    printf 'Controller recorder: program-controller\nSteward role: decision_steward\nSteward session: missing-%s\nRecorded timestamp: 2026-10-24T08:09:10Z\n' "$sequence"
    printf 'Evidence package commit: %s\nEvidence package path: %s\nVerdict: CORRECT\nMilestone: M0\nContract commit: %s\nContract path: docs/orchestration/milestones/M0_CONTRACT.md\nReviewed candidate: %s\nTarget main commit: %s\nResulting milestone state: Paused for owner decision\nBlocking evidence status: MISSING\nCritical findings: Unknown\nImportant findings: Unknown\nDecision: Preserve pause for missing evidence.\n' "$package_commit" "$package_path" "$base_sha" "$reviewed" "$base_sha"
  } > "$verdict_path"
  mutate_fixture_field "$verdict_path" verdict
  git add "$verdict_path" && git commit --quiet -m "missing-verdict-$sequence"; verdict_commit="$(git rev-parse HEAD)"
  {
    printf 'Binding status: Current\nMilestone: M0\nContract commit: %s\nContract path: docs/orchestration/milestones/M0_CONTRACT.md\nPackage commit: %s\nPackage path: %s\nVerdict commit: %s\nVerdict path: %s\nDecision kind: CORRECT\nReviewed candidate: %s\nTarget main commit: %s\nResulting milestone state: Paused for owner decision\nBlocking evidence status: MISSING\nAuthorization: DENIED\nCritical findings: Unknown\nImportant findings: Unknown\n' "$base_sha" "$package_commit" "$package_path" "$verdict_commit" "$verdict_path" "$reviewed" "$base_sha"
  } > "$binding_path"
  mutate_fixture_field "$binding_path" binding
  git add "$binding_path" && git commit --quiet -m "missing-binding-$sequence"
}

test_missing_evidence_candidate_resolution() {
  local label reviewed
  for label in nonexistent malformed; do
    [[ "$label" == nonexistent ]] && reviewed=1111111111111111111111111111111111111111 || reviewed=not-a-sha
    setup_fixture "missing-evidence-$label-candidate"
    (cd "$work_repo" && append_missing_evidence_sequence 001 "$reviewed")
    candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
    assert_refusal_without_mutation 'package reviewed candidate is not an exact commit' authorize "$candidate_sha" "$base_sha"
  done
}

test_all_negative_candidate_resolution() {
  local label reviewed
  for label in nonexistent malformed; do
    [[ "$label" == nonexistent ]] && reviewed=1111111111111111111111111111111111111111 || reviewed=not-a-sha
    setup_fixture "rejected-$label-candidate"
    (cd "$work_repo" && NEGATIVE_REVIEWED_OVERRIDE="$reviewed" append_negative_sequence 811)
    candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
    assert_refusal_without_mutation 'reviewed candidate is not an exact commit' authorize "$candidate_sha" "$base_sha"

    setup_fixture "human-gate-$label-candidate"
    (cd "$work_repo" && HUMAN_REVIEWED_OVERRIDE="$reviewed" append_human_gate_sequence 812)
    candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
    assert_refusal_without_mutation 'reviewed candidate is not an exact commit' authorize "$candidate_sha" "$base_sha"
  done
}

test_result_substring_command_refused() {
  local approval approval_path
  setup_fixture result-substring-command
  approval="$candidate_sha"; approval_path='docs/orchestration/decisions/m0/bindings/main-integration.md'
  (cd "$work_repo" && RESULT_ARGV_OVERRIDE='validate_main_integration.sh|integrate-ish|wrong|candidate|base|approval' append_result_sequence 901 REJECTED "$approval" "$approval_path")
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'result guard invocation is invalid' authorize "$candidate_sha" "$base_sha"
}

test_action_schema_required() {
  setup_fixture action-schema-missing
  (
    cd "$work_repo"
    sed '/^Resulting milestone state: /d' docs/orchestration/decisions/m0/packages/main-integration-001.md > docs/orchestration/decisions/m0/packages/action-schema-missing.md
    git add docs/orchestration/decisions/m0/packages/action-schema-missing.md
    git commit --quiet -m action-schema-missing
  )
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'main-integration package is missing resulting state' authorize "$candidate_sha" "$base_sha"
}

test_round3_path_matrix() {
  local spec field wrong expected missing
  for spec in     'Contract path|docs/orchestration/milestones/WRONG.md|verdict bounds differ from package|verdict is missing contract path'     'Completion package path|docs/orchestration/milestones/m0/evidence/WRONG.md|milestone-acceptance verdict bounds differ from package|milestone-acceptance verdict is missing completion evidence path'     'Milestone acceptance binding path|docs/orchestration/decisions/m0/bindings/WRONG.md|main-integration verdict bounds differ from package|main-integration verdict is missing acceptance binding path'; do
    IFS='|' read -r field wrong expected missing <<< "$spec"
    FIXTURE_VERDICT_OMIT_FIELD="$field" setup_fixture "round3-verdict-missing-${field// /-}"
    assert_refusal_without_mutation "$missing" authorize "$candidate_sha" "$base_sha"
    FIXTURE_VERDICT_OVERRIDE_FIELD="$field" FIXTURE_VERDICT_OVERRIDE_VALUE="$wrong" setup_fixture "round3-verdict-wrong-${field// /-}"
    assert_refusal_without_mutation "$expected" authorize "$candidate_sha" "$base_sha"
  done
  for spec in     'Contract path|docs/orchestration/milestones/WRONG.md|binding does not bind current package and verdict|binding is missing contract path'     'Completion package path|docs/orchestration/milestones/m0/evidence/WRONG.md|milestone-acceptance binding bounds differ from verdict|milestone-acceptance binding is missing completion evidence path'     'Milestone acceptance binding path|docs/orchestration/decisions/m0/bindings/WRONG.md|main-integration binding bounds differ from verdict|main-integration binding is missing acceptance binding path'; do
    IFS='|' read -r field wrong expected missing <<< "$spec"
    FIXTURE_BINDING_OMIT_FIELD="$field" setup_fixture "round3-binding-missing-${field// /-}"
    assert_refusal_without_mutation "$missing" authorize "$candidate_sha" "$base_sha"
    FIXTURE_BINDING_OVERRIDE_FIELD="$field" FIXTURE_BINDING_OVERRIDE_VALUE="$wrong" setup_fixture "round3-binding-wrong-${field// /-}"
    assert_refusal_without_mutation "$expected" authorize "$candidate_sha" "$base_sha"
  done
}

test_round3_successor_path_matrix() {
  FIXTURE_VERDICT_OMIT_FIELD='Successor contract path' NEXT_EXPECT_REFUSAL='next-milestone verdict is missing successor contract path' NEXT_CASE_NAME=round3-next-1 test_next_milestone_action_bounds
  FIXTURE_VERDICT_OVERRIDE_FIELD='Successor contract path' FIXTURE_VERDICT_OVERRIDE_VALUE='docs/orchestration/milestones/WRONG.md' NEXT_EXPECT_REFUSAL='next-milestone verdict bounds differ from package' NEXT_CASE_NAME=round3-next-2 test_next_milestone_action_bounds
  FIXTURE_VERDICT_OMIT_FIELD='Entry conditions evidence path' NEXT_EXPECT_REFUSAL='next-milestone verdict is missing entry-condition evidence path' NEXT_CASE_NAME=round3-next-3 test_next_milestone_action_bounds
  FIXTURE_VERDICT_OVERRIDE_FIELD='Entry conditions evidence path' FIXTURE_VERDICT_OVERRIDE_VALUE='docs/orchestration/milestones/m1/evidence/WRONG.md' NEXT_EXPECT_REFUSAL='next-milestone verdict bounds differ from package' NEXT_CASE_NAME=round3-next-4 test_next_milestone_action_bounds
  FIXTURE_BINDING_OMIT_FIELD='Successor contract path' NEXT_EXPECT_REFUSAL='next-milestone binding is missing successor contract path' NEXT_CASE_NAME=round3-next-5 test_next_milestone_action_bounds
  FIXTURE_BINDING_OVERRIDE_FIELD='Successor contract path' FIXTURE_BINDING_OVERRIDE_VALUE='docs/orchestration/milestones/WRONG.md' NEXT_EXPECT_REFUSAL='next-milestone binding bounds differ from verdict' NEXT_CASE_NAME=round3-next-6 test_next_milestone_action_bounds
  FIXTURE_BINDING_OMIT_FIELD='Entry conditions evidence path' NEXT_EXPECT_REFUSAL='next-milestone binding is missing entry-condition evidence path' NEXT_CASE_NAME=round3-next-7 test_next_milestone_action_bounds
  FIXTURE_BINDING_OVERRIDE_FIELD='Entry conditions evidence path' FIXTURE_BINDING_OVERRIDE_VALUE='docs/orchestration/milestones/m1/evidence/WRONG.md' NEXT_EXPECT_REFUSAL='next-milestone binding bounds differ from verdict' NEXT_CASE_NAME=round3-next-8 test_next_milestone_action_bounds
}

test_round3_result_binding_matrix() {
  local approval approval_path
  approval_path='docs/orchestration/decisions/m0/bindings/main-integration.md'
  setup_fixture round3-result-missing-encoding
  approval="$candidate_sha"
  (cd "$work_repo" && RESULT_BINDING_OMIT_ENCODING=yes append_result_sequence 991 SUCCEEDED "$approval" "$approval_path")
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'result binding is missing output encoding' authorize "$candidate_sha" "$base_sha"
  setup_fixture round3-result-wrong-encoding
  approval="$candidate_sha"
  (cd "$work_repo" && RESULT_BINDING_ENCODING_OVERRIDE=hex append_result_sequence 992 SUCCEEDED "$approval" "$approval_path")
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'result binding conflicts with result' authorize "$candidate_sha" "$base_sha"
  setup_fixture round3-result-missing-length
  approval="$candidate_sha"
  (cd "$work_repo" && RESULT_BINDING_OMIT_LENGTH=yes append_result_sequence 993 SUCCEEDED "$approval" "$approval_path")
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'result binding is missing output byte length' authorize "$candidate_sha" "$base_sha"
  setup_fixture round3-result-wrong-length
  approval="$candidate_sha"
  (cd "$work_repo" && RESULT_BINDING_LENGTH_OVERRIDE=1 append_result_sequence 994 SUCCEEDED "$approval" "$approval_path")
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'result binding conflicts with result' authorize "$candidate_sha" "$base_sha"
}

test_round3_regressions() {
  local raw
  case "${CT04_ROUND3_CASE:-all}" in
    duplicate|all)
      ATTESTATION_DUPLICATE_PREFIX=yes ATTESTATION_DUPLICATE=yes setup_fixture round3-overlapping-attestation
      assert_refusal_without_mutation 'review attestation is invalid' authorize "$candidate_sha" "$base_sha"
      ATTESTATION_DUPLICATE=yes DUPLICATE_CANDIDATE_OVERRIDE=1111111111111111111111111111111111111111 DUPLICATE_ROLE_OVERRIDE=licensing_security_reviewer DUPLICATE_VERDICT_OVERRIDE=REJECT DUPLICATE_IMPORTANT_OVERRIDE=3 setup_fixture round3-contradictory-duplicate
      assert_refusal_without_mutation 'review attestation is invalid' authorize "$candidate_sha" "$base_sha"
      raw="$fixture_root/marker-like-body.txt"
      printf 'AUGMENTEDKEYS REVIEW ATTESTATION v1\nexplanatory marker-like prose\nEND AUGMENTEDKEYS REVIEW ATTESTATION v1\n' > "$raw"
      REVIEW_RAW_FILE="$raw" setup_fixture round3-marker-like-body
      run_guard authorize "$candidate_sha" "$base_sha" >/dev/null
      tests_run=$((tests_run + 1))
      [[ "${CT04_ROUND3_CASE:-all}" == duplicate ]] && return
      ;;
  esac

  if [[ "${CT04_ROUND3_CASE:-all}" != framing ]]; then
    test_round3_path_matrix
    test_round3_successor_path_matrix
    [[ "${CT04_ROUND3_CASE:-all}" == paths ]] && return
  fi
  test_round3_result_binding_matrix
}

test_round4_package_review_milestone() {
  local role suffix approval_var main_var human_var next_var wrong_path sequence=950
  for role in qa security final; do
    case "$role" in
      qa) suffix=QA; negative_role=qa_performance_verifier ;;
      security) suffix=SECURITY; negative_role=licensing_security_reviewer ;;
      final) suffix=FINAL; negative_role=final_code_reviewer ;;
    esac
    approval_var="ACCEPTANCE_${suffix}_PATH_OVERRIDE"
    main_var="MAIN_${suffix}_PATH_OVERRIDE"
    human_var="HUMAN_${suffix}_PATH_OVERRIDE"
    next_var="NEXT_${suffix}_PATH_OVERRIDE"
    wrong_path="docs/orchestration/decisions/m1/reviews/$role-wrong-milestone.md"

    printf -v "$approval_var" '%s' "$wrong_path"
    setup_fixture "round4-acceptance-$role-wrong-review-milestone"
    unset "$approval_var"
    assert_refusal_without_mutation 'review path milestone differs from consuming package' authorize "$candidate_sha" "$base_sha"

    printf -v "$main_var" '%s' "$wrong_path"
    setup_fixture "round4-main-$role-wrong-review-milestone"
    unset "$main_var"
    assert_refusal_without_mutation 'review path milestone differs from consuming package' authorize "$candidate_sha" "$base_sha"

    setup_fixture "round4-rejected-$role-wrong-review-milestone"
    (cd "$work_repo" && NEGATIVE_ROLE_OVERRIDE="$negative_role" NEGATIVE_REVIEW_PATH_OVERRIDE="$wrong_path" append_negative_sequence "$sequence")
    candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
    assert_refusal_without_mutation 'review path milestone differs from consuming package' authorize "$candidate_sha" "$base_sha"

    setup_fixture "round4-human-$role-wrong-review-milestone"
    (cd "$work_repo" && printf -v "$human_var" '%s' "$wrong_path" && append_human_gate_sequence "$sequence")
    candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
    assert_refusal_without_mutation 'review path milestone differs from consuming package' authorize "$candidate_sha" "$base_sha"

    printf -v "$next_var" '%s' "$wrong_path"
    NEXT_EXPECT_REFUSAL='review path milestone differs from consuming package' NEXT_CASE_NAME="round4-next-$role-wrong-review-milestone" test_next_milestone_action_bounds
    unset "$next_var"
    sequence=$((sequence + 1))
  done
}

test_round4_action_path_parity() {
  ACCEPTANCE_ACTION_OVERRIDE=acceptance setup_fixture round4-acceptance-alias
  assert_refusal_without_mutation 'package action conflicts with decision kind' authorize "$candidate_sha" "$base_sha"

  MAIN_ACTION_OVERRIDE=mi setup_fixture round4-main-alias
  assert_refusal_without_mutation 'package action conflicts with decision kind' authorize "$candidate_sha" "$base_sha"

  EVIDENCE_MILESTONE_KEY_OVERRIDE=m1 setup_fixture round4-milestone-mismatch
  assert_refusal_without_mutation 'package path milestone conflicts with artifact milestone' authorize "$candidate_sha" "$base_sha"

  ACCEPTANCE_VERDICT_SEQUENCE_OVERRIDE=999 setup_fixture round4-sequence-mismatch
  assert_refusal_without_mutation 'verdict action or sequence differs from package' authorize "$candidate_sha" "$base_sha"

  ACCEPTANCE_BINDING_ACTION_OVERRIDE=other-acceptance setup_fixture round4-binding-action-mismatch
  assert_refusal_without_mutation 'binding action differs from package' authorize "$candidate_sha" "$base_sha"

  setup_fixture round4-negative-action-mismatch
  (cd "$work_repo" && NEGATIVE_ACTION_OVERRIDE=correction append_negative_sequence 941)
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'package action conflicts with decision kind' authorize "$candidate_sha" "$base_sha"

  setup_fixture round4-human-action-mismatch
  (cd "$work_repo" && HUMAN_ACTION_OVERRIDE=pause append_human_gate_sequence 942)
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'package action conflicts with decision kind' authorize "$candidate_sha" "$base_sha"

  setup_fixture round4-result-action-mismatch
  (cd "$work_repo" && RESULT_ACTION_OVERRIDE=main append_result_sequence 943 REJECTED "$candidate_sha" docs/orchestration/decisions/m0/bindings/main-integration.md)
  candidate_sha="$(git -C "$work_repo" rev-parse HEAD)"
  assert_refusal_without_mutation 'result action is not canonical' authorize "$candidate_sha" "$base_sha"
}

test_contract_artifact_types() {
  local kind
  for kind in missing symlink directory executable; do
    CONTRACT_FIXTURE_KIND="$kind" setup_fixture "contract-artifact-$kind"
    assert_refusal_without_mutation 'contract artifact is not a regular file' authorize "$candidate_sha" "$base_sha"
  done
}

if [[ "${CT04_FOCUSED_TEST:-}" == round4-review-milestone ]]; then
  test_round4_package_review_milestone
  printf 'PASS: %d focused round4 package-review-milestone scenarios\n' "$tests_run"
  exit 0
fi

if [[ "${CT04_FOCUSED_TEST:-}" == round4-paths ]]; then
  test_round4_action_path_parity
  printf 'PASS: %d focused round4 action-path scenarios\n' "$tests_run"
  exit 0
fi

if [[ "${CT04_FOCUSED_TEST:-}" == controller-schema ]]; then
  test_contract_artifact_types
  printf 'PASS: %d controller contract-artifact scenarios\n' "$tests_run"
  exit 0
fi

if [[ "${CT04_FOCUSED_TEST:-}" == round3 ]]; then
  test_round3_regressions
  printf 'PASS: %d focused round3 decision-evidence scenarios\n' "$tests_run"
  exit 0
fi

if [[ -n "${CT04_PUBLISHER_EXTERNAL_WORK_REPO:-}" ]]; then
  work_repo="$CT04_PUBLISHER_EXTERNAL_WORK_REPO"
  base_sha="${CT04_PUBLISHER_BASE_SHA:?missing publisher base}"
  acceptance_sha="${CT04_PUBLISHER_ACCEPTANCE_SHA:?missing publisher acceptance candidate}"
  integration_sha="${CT04_PUBLISHER_INTEGRATION_SHA:?missing publisher integration candidate}"
  control_sha="${CT04_PUBLISHER_CONTROL_SHA:?missing publisher control commit}"
  (cd "$work_repo" && append_evidence_sequence "${CT04_PUBLISHER_SEQUENCE:-001}")
  exit 0
fi

if [[ "${CT04_FOCUSED_TEST:-}" == reviewer-attestation ]]; then
  test_reviewer_attestation_required
  printf 'PASS: %d focused reviewer-attestation scenarios\n' "$tests_run"
  exit 0
fi
if [[ "${CT04_FOCUSED_TEST:-}" == missing-candidate ]]; then
  test_missing_evidence_candidate_resolution
  printf 'PASS: %d focused missing-candidate scenarios\n' "$tests_run"
  exit 0
fi
if [[ "${CT04_FOCUSED_TEST:-}" == result-invocation ]]; then
  test_result_substring_command_refused
  printf 'PASS: %d focused result-invocation scenarios\n' "$tests_run"
  exit 0
fi
if [[ "${CT04_FOCUSED_TEST:-}" == action-schema ]]; then
  test_action_schema_required
  printf 'PASS: %d focused action-schema scenarios\n' "$tests_run"
  exit 0
fi

test_contract_artifact_types
test_round3_regressions
test_round4_action_path_parity
test_round4_package_review_milestone
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
test_reviewer_attestation_required
test_missing_evidence_candidate_resolution
test_all_negative_candidate_resolution
test_result_substring_command_refused
test_action_schema_required
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
