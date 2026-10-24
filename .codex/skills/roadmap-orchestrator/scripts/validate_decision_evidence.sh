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

metadata_before_marker() {
  local text_value="$1" marker="$2"
  awk -v marker="$marker" '$0==marker {found++; exit} {print} END {if(found!=1) exit 1}' <<< "$text_value"
}

decode_base64() {
  if base64 --decode </dev/null >/dev/null 2>&1; then
    base64 --decode
  elif base64 -D </dev/null >/dev/null 2>&1; then
    base64 -D
  else
    return 1
  fi
}

encoded_payload_from_blob() {
  local commit="$1" path="$2" begin="$3" end="$4"
  git show "$commit:$path" | awk -v begin="$begin" -v end="$end" '
    $0==begin {if(state!=0) exit 42; state=1; next}
    $0==end {if(state!=1 || lines!=1) exit 42; state=2; next}
    state==1 {lines++; if(lines!=1 || $0=="" || $0 !~ /^[A-Za-z0-9+\/]*={0,2}$/) exit 42; print; next}
    state==2 {exit 42}
    END {if(state!=2) exit 42}
  '
}

literal_stats_from_blob() {
  local commit="$1" path="$2" begin="$3" end="$4" encoded canonical hash bytes
  encoded="$(encoded_payload_from_blob "$commit" "$path" "$begin" "$end")" || return 1
  canonical="$(printf '%s' "$encoded" | decode_base64 | base64 | tr -d '\n')" || return 1
  [[ "$canonical" == "$encoded" ]] || return 1
  hash="$(printf '%s' "$encoded" | decode_base64 | shasum -a 256 | awk '{print $1}')" || return 1
  bytes="$(printf '%s' "$encoded" | decode_base64 | wc -c | tr -d ' ')" || return 1
  printf '%s\t%s\n' "$hash" "$bytes"
}

review_attestation_from_blob() {
  local commit="$1" path="$2" encoded
  encoded="$(encoded_payload_from_blob "$commit" "$path" '--- BEGIN REVIEW OUTPUT ---' '--- END REVIEW OUTPUT ---')" || return 1
  printf '%s' "$encoded" | decode_base64 | awk '
    NR==1 {if($0!="AUGMENTEDKEYS REVIEW ATTESTATION v1") exit 42; begin++ ; next}
    NR==2 {if(index($0,"Reviewed candidate: ")!=1) exit 42; candidate=substr($0,21); next}
    NR==3 {if(index($0,"Reviewer role: ")!=1) exit 42; role=substr($0,16); next}
    NR==4 {if(index($0,"Reviewer session: ")!=1) exit 42; session=substr($0,19); next}
    NR==5 {if(index($0,"Verification evidence commit: ")!=1) exit 42; verification=substr($0,31); next}
    NR==6 {if(index($0,"Verdict: ")!=1) exit 42; verdict=substr($0,10); next}
    NR==7 {if(index($0,"Critical findings: ")!=1) exit 42; critical=substr($0,20); next}
    NR==8 {if(index($0,"Important findings: ")!=1) exit 42; important=substr($0,21); next}
    NR==9 {if(index($0,"Minor findings: ")!=1) exit 42; minor=substr($0,17); next}
    NR==10 {if($0!="END AUGMENTEDKEYS REVIEW ATTESTATION v1") exit 42; end++; next}
    NR==11 {if($0!="") exit 42; framed=1; next}
    NR>11 {
      if($0=="AUGMENTEDKEYS REVIEW ATTESTATION v1") {dupstate=1; next}
      if(dupstate==0) next
      if(dupstate==1) {dupstate=(index($0,"Reviewed candidate: ")==1)?2:0; next}
      if(dupstate==2) {dupstate=(index($0,"Reviewer role: ")==1)?3:0; next}
      if(dupstate==3) {dupstate=(index($0,"Reviewer session: ")==1)?4:0; next}
      if(dupstate==4) {dupstate=(index($0,"Verification evidence commit: ")==1)?5:0; next}
      if(dupstate==5) {dupstate=(index($0,"Verdict: ")==1)?6:0; next}
      if(dupstate==6) {dupstate=(index($0,"Critical findings: ")==1)?7:0; next}
      if(dupstate==7) {dupstate=(index($0,"Important findings: ")==1)?8:0; next}
      if(dupstate==8) {dupstate=(index($0,"Minor findings: ")==1)?9:0; next}
      if(dupstate==9) {if($0=="END AUGMENTEDKEYS REVIEW ATTESTATION v1") duplicate=1; dupstate=0; next}
    }
    END {
      if(!framed || begin!=1 || end!=1 || duplicate || candidate=="" || role=="" || session=="" || verification=="" || verdict=="" || critical=="" || important=="" || minor=="") exit 42
      printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n",candidate,role,session,verification,verdict,critical,important,minor
    }'
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
require_executable_blob() {
  local commit="$1" path="$2" label="$3" entry
  entry="$(git ls-tree "$commit" -- "$path" 2>/dev/null)"
  [[ "$entry" == 100755\ blob\ *$'\t'"$path" ]] || refuse "$label is not an executable file" 74
}

require_exact_single_change() {
  local commit="$1" expected="$2" label="$3" count=0 status= path= actual_status= actual_path=
  while IFS= read -r -d '' status && IFS= read -r -d '' path; do
    count=$((count + 1)); actual_status="$status"; actual_path="$path"
  done < <(git diff-tree --no-commit-id --name-status -r -z "$commit")
  [[ "$count" -eq 1 && "$actual_status" == A && "$actual_path" == "$expected" ]] || refuse "$label commit changes unexpected paths" 74
}

validate_sequence_path() {
  local path="$1" stage="$2" expected_action="$3" milestone="$4" action_error="$5"
  local milestone_key prefix leaf stage_label
  milestone_key="$(printf '%s' "$milestone" | tr '[:upper:]' '[:lower:]')"
  prefix="docs/orchestration/decisions/$milestone_key/$stage/"
  case "$stage" in packages) stage_label=package ;; verdicts) stage_label=verdict ;; results) stage_label=result ;; *) stage_label="$stage" ;; esac
  [[ "$path" == "$prefix"*.md ]] || {
    [[ "$path" =~ ^docs/orchestration/decisions/m[0-9]+/ ]] && refuse "$stage_label path milestone conflicts with artifact milestone" 74
    refuse "$action_error" 74
  }
  leaf="${path#"$prefix"}"; leaf="${leaf%.md}"
  [[ "$leaf" == "$expected_action-"* && "${leaf#"$expected_action-"}" =~ ^[a-z0-9][a-z0-9-]*$ ]] || refuse "$action_error" 74
  sequence_path_action="$expected_action"
  sequence_path_id="${leaf#"$expected_action-"}"
}

validate_binding_path() {
  local path="$1" expected_action="$2" milestone="$3" milestone_key
  milestone_key="$(printf '%s' "$milestone" | tr '[:upper:]' '[:lower:]')"
  [[ "$path" == "docs/orchestration/decisions/$milestone_key/bindings/$expected_action.md" ]] || refuse 'binding action differs from package' 74
}

validate_review() {
  local review_commit="$1" review_path="$2" expected_role="$3" expected_candidate="$4" expected_verdict="${5:-APPROVE}" expected_milestone="${6:-}"
  local text header controller role session timestamp candidate verification runtime_hash output_encoding output_length output_hash verdict critical important minor computed_output_hash computed_output_length stats attestation att_candidate att_role att_session att_verification att_verdict att_critical att_important att_minor expected_milestone_key
  resolve_exact_commit "$review_commit" 'review commit'
  [[ "$review_path" =~ ^docs/orchestration/decisions/m[0-9]+/reviews/[a-z0-9][a-z0-9-]*\.md$ ]] || refuse 'review path is not canonical' 74
  if [[ -n "$expected_milestone" ]]; then
    expected_milestone_key="$(printf '%s' "$expected_milestone" | tr '[:upper:]' '[:lower:]')"
    [[ "$review_path" =~ ^docs/orchestration/decisions/$expected_milestone_key/reviews/[a-z0-9][a-z0-9-]*\.md$ ]] || refuse 'review path milestone differs from consuming package' 74
  fi
  require_exact_single_change "$review_commit" "$review_path" 'review'
  require_regular_blob "$review_commit" "$review_path" 'review artifact'
  git merge-base --is-ancestor "$base_binding_commit" "$review_commit" || refuse 'review commit is outside evidence history' 74
  git merge-base --is-ancestor "$review_commit" "$current_package_commit" || refuse 'review commit does not precede consuming package' 74
  if git merge-base --is-ancestor "$review_commit" "$expected_candidate"; then refuse 'review commit is an ancestor of reviewed candidate' 74; fi
  text="$(git show "$review_commit:$review_path" 2>/dev/null)" || refuse 'review artifact is unreadable' 74
  header="$(metadata_before_marker "$text" '--- BEGIN REVIEW OUTPUT ---')" || refuse 'review literal output framing is invalid' 74
  controller="$(field_from_text "$header" 'Controller recorder')" || refuse 'review provenance is invalid' 74
  role="$(field_from_text "$header" 'Reviewer role')" || refuse 'review provenance is invalid' 74
  session="$(field_from_text "$header" 'Reviewer session')" || refuse 'review provenance is invalid' 74
  timestamp="$(field_from_text "$header" 'Recorded timestamp')" || refuse 'review provenance is invalid' 74
  candidate="$(field_from_text "$header" 'Reviewed candidate')" || refuse 'review provenance is invalid' 74
  verification="$(field_from_text "$header" 'Verification evidence commit')" || refuse 'review provenance is invalid' 74
  runtime_hash="$(field_from_text "$header" 'Runtime evidence SHA-256')" || refuse 'review provenance is invalid' 74
  output_encoding="$(field_from_text "$header" 'Review output encoding')" || refuse 'review provenance is invalid' 74
  output_length="$(field_from_text "$header" 'Review output byte length')" || refuse 'review provenance is invalid' 74
  output_hash="$(field_from_text "$header" 'Full review output SHA-256')" || refuse 'review provenance is invalid' 74
  verdict="$(field_from_text "$header" 'Verdict')" || refuse 'review provenance is invalid' 74
  critical="$(field_from_text "$header" 'Critical findings')" || refuse 'review provenance is invalid' 74
  important="$(field_from_text "$header" 'Important findings')" || refuse 'review provenance is invalid' 74
  minor="$(field_from_text "$header" 'Minor findings')" || refuse 'review provenance is invalid' 74
  [[ "$controller" == program-controller && "$role" == "$expected_role" && "$session" =~ ^[A-Za-z0-9][A-Za-z0-9._:-]*$ ]] || refuse 'review provenance is invalid' 74
  valid_utc_timestamp "$timestamp" || refuse 'review provenance is invalid' 74
  [[ "$runtime_hash" =~ ^[0-9a-f]{64}$ && "$output_hash" =~ ^[0-9a-f]{64}$ && "$output_encoding" == base64 && "$output_length" =~ ^(0|[1-9][0-9]*)$ ]] || refuse 'review provenance is invalid' 74
  [[ "$(grep -Fc -- '--- BEGIN REVIEW OUTPUT ---' <<< "$text")" == 1 && "$(grep -Fc -- '--- END REVIEW OUTPUT ---' <<< "$text")" == 1 ]] || refuse 'review literal output markers are invalid' 74
  stats="$(literal_stats_from_blob "$review_commit" "$review_path" '--- BEGIN REVIEW OUTPUT ---' '--- END REVIEW OUTPUT ---')" || refuse 'review literal output is invalid' 74
  IFS=$'\t' read -r computed_output_hash computed_output_length <<< "$stats"
  [[ "$computed_output_length" == "$output_length" ]] || refuse 'review output byte length differs from decoded bytes' 74
  [[ "$computed_output_hash" == "$output_hash" ]] || refuse 'review full output hash differs from literal bytes' 74
  attestation="$(review_attestation_from_blob "$review_commit" "$review_path")" || refuse 'review attestation is invalid' 74
  IFS=$'\t' read -r att_candidate att_role att_session att_verification att_verdict att_critical att_important att_minor <<< "$attestation"
  [[ "$att_candidate" == "$candidate" && "$att_role" == "$role" && "$att_session" == "$session" && "$att_verification" == "$verification" && "$att_verdict" == "$verdict" && "$att_critical" == "$critical" && "$att_important" == "$important" && "$att_minor" == "$minor" ]] || refuse 'review attestation differs from recorder metadata' 74
  resolve_exact_commit "$candidate" 'reviewed candidate'
  resolve_exact_commit "$verification" 'verification evidence commit'
  [[ "$candidate" == "$expected_candidate" ]] || refuse 'review candidate differs from package candidate' 74
  [[ "$critical" =~ ^[0-9]+$ && "$important" =~ ^[0-9]+$ && "$minor" =~ ^[0-9]+$ ]] || refuse 'review finding counts are invalid' 74
  if [[ "$expected_verdict" == APPROVE ]]; then
    [[ "$verdict" == APPROVE && "$critical" == 0 && "$important" == 0 ]] || refuse 'review does not approve without blocking findings' 74
  else
    [[ "$verdict" == REJECT && $((critical + important)) -gt 0 ]] || refuse 'negative review does not preserve blocking findings' 74
  fi
  last_review_critical="$critical"; last_review_important="$important"
}

validate_package_reviews() {
  local commit="$1" path="$2" text reviewed
  local qa_commit qa_path security_commit security_path final_commit final_path
  current_package_commit="$commit"
  text="$(git show "$commit:$path" 2>/dev/null)" || refuse 'package artifact is unreadable' 74
  package_milestone="$(field_from_text "$text" 'Milestone')" || refuse 'package is missing milestone' 74
  package_kind="$(field_from_text "$text" 'Decision kind')" || refuse 'package is missing decision kind' 74
  package_contract="$(field_from_text "$text" 'Contract commit')" || refuse 'package is missing contract' 74
  package_contract_path="$(field_from_text "$text" 'Contract path')" || refuse 'package is missing contract path' 74
  package_target="$(field_from_text "$text" 'Target main commit')" || refuse 'package is missing target main' 74
  field_from_text "$text" 'Limitations' >/dev/null || refuse 'package is missing limitations' 74
  field_from_text "$text" 'Recovery' >/dev/null || refuse 'package is missing recovery' 74
  [[ "$package_milestone" =~ ^M[0-9]+$ && "$package_kind" =~ ^[a-z0-9][a-z0-9-]*$ ]] || refuse 'package identity is invalid' 74
  resolve_exact_commit "$package_contract" 'package contract commit'
  resolve_exact_commit "$package_target" 'package target main'
  [[ "$package_contract_path" == docs/orchestration/milestones/M0_CONTRACT.md ]] || refuse 'package contract path is not canonical' 74
  require_regular_blob "$package_contract" "$package_contract_path" 'contract artifact'
  disposition="$(field_from_text "$text" 'Decision disposition')" || refuse 'package is missing decision disposition' 74
  reviewed="$(field_from_text "$text" 'Reviewed candidate')" || refuse 'package is missing reviewed candidate' 74
  resolve_exact_commit "$reviewed" 'package reviewed candidate'
  sequence_candidate="$reviewed"
  sequence_disposition="$disposition"
  sequence_critical="$(field_from_text "$text" 'Critical findings')" || refuse 'package is missing finding counts' 74
  sequence_important="$(field_from_text "$text" 'Important findings')" || refuse 'package is missing finding counts' 74
  sequence_package_kind="$package_kind"
  sequence_resulting_state="$(field_from_text "$text" 'Resulting milestone state')" || refuse "$package_kind package is missing resulting state" 74
  if [[ "$disposition" == NEGATIVE ]]; then
    [[ "$sequence_resulting_state" == 'Paused for owner decision' ]] || refuse 'negative package resulting state is invalid' 74
    blocking_status="$(field_from_text "$text" 'Blocking evidence status')" || refuse 'negative package is missing blocking evidence status' 74
    sequence_blocking_status="$blocking_status"
    case "$blocking_status" in
      HUMAN_GATE) [[ "$package_kind" == human-gate ]] || refuse 'negative package action conflicts with blocking evidence status' 74 ;;
      MISSING|REJECTED) [[ "$package_kind" == milestone-correction ]] || refuse 'negative package action conflicts with blocking evidence status' 74 ;;
    esac
    validate_sequence_path "$path" packages "$package_kind" "$package_milestone" 'package action conflicts with decision kind'
    sequence_package_action="$sequence_path_action"; sequence_sequence="$sequence_path_id"
    case "$blocking_status" in
      MISSING)
        field_from_text "$text" 'Missing evidence' >/dev/null || refuse 'negative package is missing evidence description' 74
        [[ ( "$sequence_critical" == Unknown && "$sequence_important" == Unknown ) || ( "$sequence_critical" =~ ^[0-9]+$ && "$sequence_important" =~ ^[0-9]+$ && $((sequence_critical + sequence_important)) -gt 0 ) ]] || refuse 'missing-evidence finding observations are invalid' 74
        ;;
      REJECTED)
        blocking_commit="$(field_from_text "$text" 'Blocking review commit')" || refuse 'negative package is missing rejected review binding' 74
        blocking_path="$(field_from_text "$text" 'Blocking review path')" || refuse 'negative package is missing rejected review binding' 74
        blocking_role="$(field_from_text "$text" 'Blocking reviewer role')" || refuse 'negative package is missing rejected reviewer role' 74
        case "$blocking_role" in qa_performance_verifier|licensing_security_reviewer|final_code_reviewer) ;; *) refuse 'negative package reviewer role is invalid' 74;; esac
        validate_review "$blocking_commit" "$blocking_path" "$blocking_role" "$reviewed" REJECT "$package_milestone"
        [[ "$sequence_critical" == "$last_review_critical" && "$sequence_important" == "$last_review_important" ]] || refuse 'negative package findings differ from rejected review' 74
        ;;
      HUMAN_GATE)
        field_from_text "$text" 'Human gate reason' >/dev/null || refuse 'human-gate package is missing its reason' 74
        [[ "$sequence_critical" == 0 && "$sequence_important" == 0 ]] || refuse 'human-gate package invents technical findings' 74
        qa_commit="$(field_from_text "$text" 'QA review commit')" || refuse 'human-gate package is missing approved review bindings' 74
        qa_path="$(field_from_text "$text" 'QA review path')" || refuse 'human-gate package is missing approved review bindings' 74
        security_commit="$(field_from_text "$text" 'Licensing review commit')" || refuse 'human-gate package is missing approved review bindings' 74
        security_path="$(field_from_text "$text" 'Licensing review path')" || refuse 'human-gate package is missing approved review bindings' 74
        final_commit="$(field_from_text "$text" 'Final review commit')" || refuse 'human-gate package is missing approved review bindings' 74
        final_path="$(field_from_text "$text" 'Final review path')" || refuse 'human-gate package is missing approved review bindings' 74
        resolve_exact_commit "$reviewed" 'package reviewed candidate'
        validate_review "$qa_commit" "$qa_path" qa_performance_verifier "$reviewed" APPROVE "$package_milestone"
        validate_review "$security_commit" "$security_path" licensing_security_reviewer "$reviewed" APPROVE "$package_milestone"
        validate_review "$final_commit" "$final_path" final_code_reviewer "$reviewed" APPROVE "$package_milestone"
        ;;
      *) refuse 'negative package blocking evidence status is invalid' 74 ;;
    esac
    return
  fi
  validate_sequence_path "$path" packages "$package_kind" "$package_milestone" 'package action conflicts with decision kind'
  sequence_package_action="$sequence_path_action"; sequence_sequence="$sequence_path_id"
  [[ "$disposition" == APPROVAL && "$sequence_critical" == 0 && "$sequence_important" == 0 ]] || refuse 'approval package disposition or findings are invalid' 74
  qa_commit="$(field_from_text "$text" 'QA review commit')" || refuse 'package is missing review bindings' 74
  qa_path="$(field_from_text "$text" 'QA review path')" || refuse 'package is missing review bindings' 74
  security_commit="$(field_from_text "$text" 'Licensing review commit')" || refuse 'package is missing review bindings' 74
  security_path="$(field_from_text "$text" 'Licensing review path')" || refuse 'package is missing review bindings' 74
  final_commit="$(field_from_text "$text" 'Final review commit')" || refuse 'package is missing review bindings' 74
  final_path="$(field_from_text "$text" 'Final review path')" || refuse 'package is missing review bindings' 74
  resolve_exact_commit "$reviewed" 'package reviewed candidate'
  if git merge-base --is-ancestor "$commit" "$reviewed"; then refuse 'package commit is an ancestor of reviewed candidate' 74; fi
  validate_review "$qa_commit" "$qa_path" qa_performance_verifier "$reviewed" APPROVE "$package_milestone"
  validate_review "$security_commit" "$security_path" licensing_security_reviewer "$reviewed" APPROVE "$package_milestone"
  validate_review "$final_commit" "$final_path" final_code_reviewer "$reviewed" APPROVE "$package_milestone"

  package_completion_commit= package_completion_path= package_acceptance_candidate= package_integration_candidate=
  package_acceptance_binding_commit= package_acceptance_binding_path= package_successor_commit= package_successor_path=
  package_entry_commit= package_entry_path=
  case "$package_kind" in
    milestone-acceptance)
      package_accepted_tip="$(field_from_text "$text" 'Accepted milestone tip')" || refuse 'milestone-acceptance package is missing accepted milestone tip' 74
      [[ "$sequence_resulting_state" == Accepted && "$package_accepted_tip" == "$reviewed" ]] || refuse 'milestone-acceptance package state or accepted tip is invalid' 74
      package_completion_commit="$(field_from_text "$text" 'Completion package commit')" || refuse 'milestone-acceptance package is missing completion evidence' 74
      package_completion_path="$(field_from_text "$text" 'Completion package path')" || refuse 'milestone-acceptance package is missing completion evidence' 74
      [[ "$package_completion_path" =~ ^docs/orchestration/milestones/m[0-9]+/evidence/[a-z0-9][a-z0-9-]*\.md$ ]] || refuse 'milestone-acceptance completion path is not canonical' 74
      resolve_exact_commit "$package_completion_commit" 'completion package commit'
      require_regular_blob "$package_completion_commit" "$package_completion_path" 'completion package artifact'
      git merge-base --is-ancestor "$package_contract" "$reviewed" || refuse 'contract is outside milestone candidate history' 74
      git merge-base --is-ancestor "$package_completion_commit" "$reviewed" || refuse 'completion evidence is outside milestone candidate history' 74
      ;;
    main-integration)
      package_integration_state="$(field_from_text "$text" 'Integration state')" || refuse 'main-integration package is missing integration state' 74
      [[ "$sequence_resulting_state" == Accepted && "$package_integration_state" == Pending ]] || refuse 'main-integration package state is invalid' 74
      package_acceptance_candidate="$(field_from_text "$text" 'Acceptance candidate')" || refuse 'main-integration package is missing acceptance candidate' 74
      package_integration_candidate="$(field_from_text "$text" 'Integration candidate')" || refuse 'main-integration package is missing integration candidate' 74
      package_milestone_branch="$(field_from_text "$text" 'Milestone branch')" || refuse 'main-integration package is missing milestone branch' 74
      package_completion_commit="$(field_from_text "$text" 'Completion package commit')" || refuse 'main-integration package is missing completion evidence' 74
      package_completion_path="$(field_from_text "$text" 'Completion package path')" || refuse 'main-integration package is missing completion evidence' 74
      package_acceptance_binding_commit="$(field_from_text "$text" 'Milestone acceptance binding commit')" || refuse 'main-integration package is missing acceptance binding' 74
      package_acceptance_binding_path="$(field_from_text "$text" 'Milestone acceptance binding path')" || refuse 'main-integration package is missing acceptance binding' 74
      delta_paths="$(field_from_text "$text" 'Administrative delta paths')" || refuse 'main-integration package is missing administrative delta' 74
      delta_hash="$(field_from_text "$text" 'Administrative delta SHA-256')" || refuse 'main-integration package is missing administrative delta' 74
      transition_date="$(field_from_text "$text" 'Administrative transition date')" || refuse 'main-integration package is missing administrative transition date' 74
      package_guard_commit="$(field_from_text "$text" 'Reviewed guard commit')" || refuse 'main-integration package is missing reviewed guard provenance' 74
      package_guard_path="$(field_from_text "$text" 'Reviewed guard path')" || refuse 'main-integration package is missing reviewed guard provenance' 74
      package_guard_hash="$(field_from_text "$text" 'Reviewed guard SHA-256')" || refuse 'main-integration package is missing reviewed guard provenance' 74
      [[ "$package_integration_candidate" == "$reviewed" && "$package_acceptance_candidate" != "$package_integration_candidate" ]] || refuse 'main-integration candidate bounds are invalid' 74
      [[ "$package_milestone_branch" =~ ^milestone/m[0-9]+-[a-z0-9][a-z0-9-]*$ ]] || refuse 'main-integration milestone branch is invalid' 74
      resolve_exact_commit "$package_acceptance_candidate" 'accepted milestone candidate'
      resolve_exact_commit "$package_integration_candidate" 'integration candidate'
      git merge-base --is-ancestor "$package_acceptance_candidate" "$package_integration_candidate" || refuse 'integration candidate does not descend from accepted milestone candidate' 74
      [[ "$delta_hash" =~ ^[0-9a-f]{64}$ ]] || refuse 'main-integration administrative delta hash is invalid' 74
      actual_delta_paths="$(git diff --name-only "$package_acceptance_candidate..$package_integration_candidate" | LC_ALL=C sort | paste -sd, -)"
      actual_delta_hash="$(git diff --binary "$package_acceptance_candidate..$package_integration_candidate" | shasum -a 256 | awk '{print $1}')"
      [[ -n "$actual_delta_paths" && "$delta_paths" == "$actual_delta_paths" && "$delta_hash" == "$actual_delta_hash" ]] || refuse 'main-integration administrative delta differs from candidate history' 74
      valid_utc_timestamp "${transition_date}T00:00:00Z" || refuse 'main-integration administrative transition date is invalid' 74
      resolve_exact_commit "$package_guard_commit" 'reviewed main guard commit'
      [[ "$package_guard_path" == .codex/skills/roadmap-orchestrator/scripts/validate_main_integration.sh && "$package_guard_hash" =~ ^[0-9a-f]{64}$ ]] || refuse 'main-integration reviewed guard provenance is invalid' 74
      require_executable_blob "$package_guard_commit" "$package_guard_path" 'reviewed main guard'
      [[ "$(git show "$package_guard_commit:$package_guard_path" | shasum -a 256 | awk '{print $1}')" == "$package_guard_hash" ]] || refuse 'main-integration reviewed guard hash differs from artifact' 74
      [[ "$package_completion_path" =~ ^docs/orchestration/milestones/m[0-9]+/evidence/[a-z0-9][a-z0-9-]*\.md$ ]] || refuse 'main-integration completion path is not canonical' 74
      [[ "$package_acceptance_binding_path" =~ ^docs/orchestration/decisions/m[0-9]+/bindings/milestone-acceptance\.md$ ]] || refuse 'main-integration acceptance binding path is not canonical' 74
      resolve_exact_commit "$package_completion_commit" 'completion package commit'
      resolve_exact_commit "$package_acceptance_binding_commit" 'milestone acceptance binding commit'
      require_regular_blob "$package_completion_commit" "$package_completion_path" 'completion package artifact'
      require_regular_blob "$package_acceptance_binding_commit" "$package_acceptance_binding_path" 'milestone acceptance binding artifact'
      git merge-base --is-ancestor "$package_contract" "$package_integration_candidate" || refuse 'contract is outside integration candidate history' 74
      git merge-base --is-ancestor "$package_completion_commit" "$package_acceptance_candidate" || refuse 'completion evidence is outside accepted milestone history' 74
      git merge-base --is-ancestor "$package_acceptance_binding_commit" "$commit" || refuse 'acceptance binding does not precede main-integration package' 74
      [[ "$(git log -1 --format=%H "$commit" -- "$package_acceptance_binding_path")" == "$package_acceptance_binding_commit" ]] || refuse 'main-integration acceptance binding is stale' 74
      acceptance_text="$(git show "$package_acceptance_binding_commit:$package_acceptance_binding_path")" || refuse 'milestone acceptance binding is unreadable' 74
      [[ "$(field_from_text "$acceptance_text" 'Binding status')" == Current && "$(field_from_text "$acceptance_text" 'Decision kind')" == APPROVE_MILESTONE && "$(field_from_text "$acceptance_text" 'Reviewed candidate')" == "$package_acceptance_candidate" && "$(field_from_text "$acceptance_text" 'Authorization')" == GRANTED && "$(field_from_text "$acceptance_text" 'Critical findings')" == 0 && "$(field_from_text "$acceptance_text" 'Important findings')" == 0 ]] || refuse 'main-integration acceptance binding does not authorize the accepted milestone candidate' 74
      ;;
    next-milestone)
      package_successor_state="$(field_from_text "$text" 'Successor state')" || refuse 'next-milestone package is missing successor state' 74
      [[ "$sequence_resulting_state" == Accepted && "$package_successor_state" == 'Approved for activation' ]] || refuse 'next-milestone package state is invalid' 74
      package_successor_commit="$(field_from_text "$text" 'Successor contract commit')" || refuse 'next-milestone package is missing successor contract evidence' 74
      package_successor_path="$(field_from_text "$text" 'Successor contract path')" || refuse 'next-milestone package is missing successor contract evidence' 74
      package_entry_commit="$(field_from_text "$text" 'Entry conditions evidence commit')" || refuse 'next-milestone package is missing entry-condition evidence' 74
      package_entry_path="$(field_from_text "$text" 'Entry conditions evidence path')" || refuse 'next-milestone package is missing entry-condition evidence' 74
      [[ "$package_successor_path" =~ ^docs/orchestration/milestones/[A-Z][A-Z0-9_-]*_CONTRACT\.md$ && "$package_entry_path" =~ ^docs/orchestration/milestones/[a-z0-9_-]+/evidence/[a-z0-9][a-z0-9-]*\.md$ ]] || refuse 'next-milestone evidence paths are not canonical' 74
      resolve_exact_commit "$package_successor_commit" 'successor contract commit'
      resolve_exact_commit "$package_entry_commit" 'entry conditions evidence commit'
      require_regular_blob "$package_successor_commit" "$package_successor_path" 'successor contract artifact'
      require_regular_blob "$package_entry_commit" "$package_entry_path" 'entry conditions evidence artifact'
      git merge-base --is-ancestor "$package_successor_commit" "$reviewed" || refuse 'successor contract is outside reviewed candidate history' 74
      git merge-base --is-ancestor "$package_entry_commit" "$reviewed" || refuse 'entry-condition evidence is outside reviewed candidate history' 74
      ;;
    *) refuse 'approval package decision kind is unsupported' 74 ;;
  esac
}

validate_verdict_artifact() {
  local commit="$1" path="$2" text controller role session timestamp package package_path verdict milestone contract contract_path candidate target critical important decision
  local completion completion_path acceptance integration acceptance_binding acceptance_binding_path successor successor_path entry entry_path resulting_state accepted_tip integration_state successor_state blocking_status verdict_delta_paths verdict_delta_hash verdict_transition_date verdict_guard_commit verdict_guard_path verdict_guard_hash verdict_milestone_branch
  text="$(git show "$commit:$path")" || refuse 'verdict artifact is unreadable' 74
  controller="$(field_from_text "$text" 'Controller recorder')" || refuse 'verdict provenance is invalid' 74
  role="$(field_from_text "$text" 'Steward role')" || refuse 'verdict provenance is invalid' 74
  session="$(field_from_text "$text" 'Steward session')" || refuse 'verdict provenance is invalid' 74
  timestamp="$(field_from_text "$text" 'Recorded timestamp')" || refuse 'verdict provenance is invalid' 74
  package="$(field_from_text "$text" 'Evidence package commit')" || refuse 'verdict is missing package binding' 74
  package_path="$(field_from_text "$text" 'Evidence package path')" || refuse 'verdict is missing package binding' 74
  verdict="$(field_from_text "$text" 'Verdict')" || refuse 'verdict is missing decision' 74
  milestone="$(field_from_text "$text" 'Milestone')" || refuse 'verdict is missing milestone' 74
  contract="$(field_from_text "$text" 'Contract commit')" || refuse 'verdict is missing contract' 74
  contract_path="$(field_from_text "$text" 'Contract path')" || refuse 'verdict is missing contract path' 74
  candidate="$(field_from_text "$text" 'Reviewed candidate')" || refuse 'verdict is missing candidate' 74
  target="$(field_from_text "$text" 'Target main commit')" || refuse 'verdict is missing target main' 74
  critical="$(field_from_text "$text" 'Critical findings')" || refuse 'verdict is missing finding counts' 74
  important="$(field_from_text "$text" 'Important findings')" || refuse 'verdict is missing finding counts' 74
  decision="$(field_from_text "$text" 'Decision')" || refuse 'verdict is missing decision text' 74
  resulting_state="$(field_from_text "$text" 'Resulting milestone state')" || refuse 'verdict is missing resulting state' 74
  [[ "$controller" == program-controller && "$role" == decision_steward && "$session" =~ ^[A-Za-z0-9][A-Za-z0-9._:-]*$ ]] || refuse 'verdict provenance is invalid' 74
  valid_utc_timestamp "$timestamp" || refuse 'verdict provenance is invalid' 74
  validate_sequence_path "$path" verdicts "$sequence_package_action" "$milestone" 'verdict action or sequence differs from package'
  [[ "$sequence_path_id" == "$sequence_sequence" ]] || refuse 'verdict action or sequence differs from package' 74
  [[ "$package" == "$sequence_package_commit" && "$package_path" == "$sequence_package_path" && "$candidate" == "$sequence_candidate" ]] || refuse 'verdict does not bind package candidate' 74
  [[ "$milestone" == "$package_milestone" && "$contract" == "$package_contract" && "$contract_path" == "$package_contract_path" && "$target" == "$package_target" ]] || refuse 'verdict bounds differ from package' 74
  [[ "$critical" == "$sequence_critical" && "$important" == "$sequence_important" ]] || refuse 'verdict findings differ from package' 74
  [[ "$resulting_state" == "$sequence_resulting_state" ]] || refuse 'verdict resulting state differs from package' 74
  if [[ "$sequence_disposition" == APPROVAL ]]; then
    case "$sequence_package_kind:$verdict" in milestone-acceptance:APPROVE_MILESTONE|main-integration:APPROVE_MAIN_INTEGRATION|next-milestone:APPROVE_NEXT_MILESTONE) ;; *) refuse 'approval package kind and verdict conflict' 74;; esac
    case "$sequence_package_kind" in
      milestone-acceptance)
        accepted_tip="$(field_from_text "$text" 'Accepted milestone tip')" || refuse 'milestone-acceptance verdict is missing accepted milestone tip' 74
        completion="$(field_from_text "$text" 'Completion package commit')" || refuse 'milestone-acceptance verdict is missing completion evidence' 74
        completion_path="$(field_from_text "$text" 'Completion package path')" || refuse 'milestone-acceptance verdict is missing completion evidence path' 74
        [[ "$accepted_tip" == "$package_accepted_tip" && "$completion" == "$package_completion_commit" && "$completion_path" == "$package_completion_path" ]] || refuse 'milestone-acceptance verdict bounds differ from package' 74
        ;;
      main-integration)
        integration_state="$(field_from_text "$text" 'Integration state')" || refuse 'main-integration verdict is missing integration state' 74
        verdict_milestone_branch="$(field_from_text "$text" 'Milestone branch')" || refuse 'main-integration verdict is missing milestone branch' 74
        verdict_delta_paths="$(field_from_text "$text" 'Administrative delta paths')" || refuse 'main-integration verdict is missing administrative delta' 74
        verdict_delta_hash="$(field_from_text "$text" 'Administrative delta SHA-256')" || refuse 'main-integration verdict is missing administrative delta' 74
        verdict_transition_date="$(field_from_text "$text" 'Administrative transition date')" || refuse 'main-integration verdict is missing administrative transition date' 74
        verdict_guard_commit="$(field_from_text "$text" 'Reviewed guard commit')" || refuse 'main-integration verdict is missing reviewed guard provenance' 74
        verdict_guard_path="$(field_from_text "$text" 'Reviewed guard path')" || refuse 'main-integration verdict is missing reviewed guard provenance' 74
        verdict_guard_hash="$(field_from_text "$text" 'Reviewed guard SHA-256')" || refuse 'main-integration verdict is missing reviewed guard provenance' 74
        acceptance="$(field_from_text "$text" 'Acceptance candidate')" || refuse 'main-integration verdict is missing candidate bounds' 74
        integration="$(field_from_text "$text" 'Integration candidate')" || refuse 'main-integration verdict is missing candidate bounds' 74
        completion="$(field_from_text "$text" 'Completion package commit')" || refuse 'main-integration verdict is missing completion evidence' 74
        completion_path="$(field_from_text "$text" 'Completion package path')" || refuse 'main-integration verdict is missing completion evidence path' 74
        acceptance_binding="$(field_from_text "$text" 'Milestone acceptance binding commit')" || refuse 'main-integration verdict is missing acceptance binding' 74
        acceptance_binding_path="$(field_from_text "$text" 'Milestone acceptance binding path')" || refuse 'main-integration verdict is missing acceptance binding path' 74
        [[ "$integration_state" == "$package_integration_state" && "$verdict_milestone_branch" == "$package_milestone_branch" && "$verdict_delta_paths" == "$delta_paths" && "$verdict_delta_hash" == "$delta_hash" && "$verdict_transition_date" == "$transition_date" && "$verdict_guard_commit" == "$package_guard_commit" && "$verdict_guard_path" == "$package_guard_path" && "$verdict_guard_hash" == "$package_guard_hash" && "$acceptance" == "$package_acceptance_candidate" && "$integration" == "$package_integration_candidate" && "$completion" == "$package_completion_commit" && "$completion_path" == "$package_completion_path" && "$acceptance_binding" == "$package_acceptance_binding_commit" && "$acceptance_binding_path" == "$package_acceptance_binding_path" ]] || refuse 'main-integration verdict bounds differ from package' 74
        ;;
      next-milestone)
        successor_state="$(field_from_text "$text" 'Successor state')" || refuse 'next-milestone verdict is missing successor state' 74
        successor="$(field_from_text "$text" 'Successor contract commit')" || refuse 'next-milestone verdict is missing successor contract' 74
        successor_path="$(field_from_text "$text" 'Successor contract path')" || refuse 'next-milestone verdict is missing successor contract path' 74
        entry="$(field_from_text "$text" 'Entry conditions evidence commit')" || refuse 'next-milestone verdict is missing entry-condition evidence' 74
        entry_path="$(field_from_text "$text" 'Entry conditions evidence path')" || refuse 'next-milestone verdict is missing entry-condition evidence path' 74
        [[ "$successor_state" == "$package_successor_state" && "$successor" == "$package_successor_commit" && "$successor_path" == "$package_successor_path" && "$entry" == "$package_entry_commit" && "$entry_path" == "$package_entry_path" ]] || refuse 'next-milestone verdict bounds differ from package' 74
        ;;
    esac
    sequence_authorization=GRANTED
  else
    blocking_status="$(field_from_text "$text" 'Blocking evidence status')" || refuse 'negative verdict is missing blocking evidence status' 74
    [[ "$blocking_status" == "$sequence_blocking_status" ]] || refuse 'negative verdict blocking status differs from package' 74
    if [[ "$sequence_blocking_status" == HUMAN_GATE ]]; then
      [[ "$verdict" == PAUSE_HUMAN ]] || refuse 'human-gate package must pause for the owner' 74
    else
      case "$verdict" in CORRECT|PAUSE_HUMAN) ;; *) refuse 'negative package has authorizing verdict' 74;; esac
    fi
    sequence_authorization=DENIED
  fi
  sequence_verdict_commit="$commit"; sequence_verdict_path="$path"; sequence_verdict="$verdict"; sequence_target="$target"; sequence_contract="$contract"
}

validate_binding_artifact() {
  local commit="$1" path="$2" text status milestone contract contract_path package package_path verdict verdict_path kind candidate target authorization critical important
  local completion completion_path acceptance integration acceptance_binding acceptance_binding_path successor successor_path entry entry_path resulting_state accepted_tip integration_state successor_state blocking_status binding_delta_paths binding_delta_hash binding_transition_date binding_guard_commit binding_guard_path binding_guard_hash binding_milestone_branch
  text="$(git show "$commit:$path")" || refuse 'binding artifact is unreadable' 74
  status="$(field_from_text "$text" 'Binding status')" || refuse 'binding is missing status' 74
  milestone="$(field_from_text "$text" 'Milestone')" || refuse 'binding is missing milestone' 74
  contract="$(field_from_text "$text" 'Contract commit')" || refuse 'binding is missing contract' 74
  contract_path="$(field_from_text "$text" 'Contract path')" || refuse 'binding is missing contract path' 74
  package="$(field_from_text "$text" 'Package commit')" || refuse 'binding is missing package' 74
  package_path="$(field_from_text "$text" 'Package path')" || refuse 'binding is missing package' 74
  verdict="$(field_from_text "$text" 'Verdict commit')" || refuse 'binding is missing verdict' 74
  verdict_path="$(field_from_text "$text" 'Verdict path')" || refuse 'binding is missing verdict' 74
  kind="$(field_from_text "$text" 'Decision kind')" || refuse 'binding is missing decision kind' 74
  candidate="$(field_from_text "$text" 'Reviewed candidate')" || refuse 'binding is missing candidate' 74
  target="$(field_from_text "$text" 'Target main commit')" || refuse 'binding is missing target main' 74
  authorization="$(field_from_text "$text" 'Authorization')" || refuse 'binding is missing authorization' 74
  critical="$(field_from_text "$text" 'Critical findings')" || refuse 'binding is missing finding counts' 74
  important="$(field_from_text "$text" 'Important findings')" || refuse 'binding is missing finding counts' 74
  resulting_state="$(field_from_text "$text" 'Resulting milestone state')" || refuse 'binding is missing resulting state' 74
  validate_binding_path "$path" "$sequence_package_action" "$milestone"
  [[ "$status" == Current && "$milestone" == "$package_milestone" && "$contract" == "$sequence_contract" && "$contract_path" == "$package_contract_path" && "$package" == "$sequence_package_commit" && "$package_path" == "$sequence_package_path" && "$verdict" == "$sequence_verdict_commit" && "$verdict_path" == "$sequence_verdict_path" ]] || refuse 'binding does not bind current package and verdict' 74
  [[ "$kind" == "$sequence_verdict" && "$candidate" == "$sequence_candidate" && "$target" == "$sequence_target" && "$authorization" == "$sequence_authorization" ]] || refuse 'binding decision fields conflict with verdict' 74
  [[ "$critical" == "$sequence_critical" && "$important" == "$sequence_important" ]] || refuse 'binding findings differ from verdict' 74
  [[ "$resulting_state" == "$sequence_resulting_state" ]] || refuse 'binding resulting state differs from verdict' 74
  if [[ "$sequence_authorization" == GRANTED ]]; then
    case "$sequence_package_kind" in
      milestone-acceptance)
        accepted_tip="$(field_from_text "$text" 'Accepted milestone tip')" || refuse 'milestone-acceptance binding is missing accepted milestone tip' 74
        completion="$(field_from_text "$text" 'Completion package commit')" || refuse 'milestone-acceptance binding is missing completion evidence' 74
        completion_path="$(field_from_text "$text" 'Completion package path')" || refuse 'milestone-acceptance binding is missing completion evidence path' 74
        [[ "$accepted_tip" == "$package_accepted_tip" && "$completion" == "$package_completion_commit" && "$completion_path" == "$package_completion_path" ]] || refuse 'milestone-acceptance binding bounds differ from verdict' 74
        ;;
      main-integration)
        integration_state="$(field_from_text "$text" 'Integration state')" || refuse 'main-integration binding is missing integration state' 74
        binding_milestone_branch="$(field_from_text "$text" 'Milestone branch')" || refuse 'main-integration binding is missing milestone branch' 74
        binding_delta_paths="$(field_from_text "$text" 'Administrative delta paths')" || refuse 'main-integration binding is missing administrative delta' 74
        binding_delta_hash="$(field_from_text "$text" 'Administrative delta SHA-256')" || refuse 'main-integration binding is missing administrative delta' 74
        binding_transition_date="$(field_from_text "$text" 'Administrative transition date')" || refuse 'main-integration binding is missing administrative transition date' 74
        binding_guard_commit="$(field_from_text "$text" 'Reviewed guard commit')" || refuse 'main-integration binding is missing reviewed guard provenance' 74
        binding_guard_path="$(field_from_text "$text" 'Reviewed guard path')" || refuse 'main-integration binding is missing reviewed guard provenance' 74
        binding_guard_hash="$(field_from_text "$text" 'Reviewed guard SHA-256')" || refuse 'main-integration binding is missing reviewed guard provenance' 74
        acceptance="$(field_from_text "$text" 'Acceptance candidate')" || refuse 'main-integration binding is missing candidate bounds' 74
        integration="$(field_from_text "$text" 'Integration candidate')" || refuse 'main-integration binding is missing candidate bounds' 74
        completion="$(field_from_text "$text" 'Completion package commit')" || refuse 'main-integration binding is missing completion evidence' 74
        completion_path="$(field_from_text "$text" 'Completion package path')" || refuse 'main-integration binding is missing completion evidence path' 74
        acceptance_binding="$(field_from_text "$text" 'Milestone acceptance binding commit')" || refuse 'main-integration binding is missing acceptance binding' 74
        acceptance_binding_path="$(field_from_text "$text" 'Milestone acceptance binding path')" || refuse 'main-integration binding is missing acceptance binding path' 74
        [[ "$integration_state" == "$package_integration_state" && "$binding_milestone_branch" == "$package_milestone_branch" && "$binding_delta_paths" == "$delta_paths" && "$binding_delta_hash" == "$delta_hash" && "$binding_transition_date" == "$transition_date" && "$binding_guard_commit" == "$package_guard_commit" && "$binding_guard_path" == "$package_guard_path" && "$binding_guard_hash" == "$package_guard_hash" && "$acceptance" == "$package_acceptance_candidate" && "$integration" == "$package_integration_candidate" && "$completion" == "$package_completion_commit" && "$completion_path" == "$package_completion_path" && "$acceptance_binding" == "$package_acceptance_binding_commit" && "$acceptance_binding_path" == "$package_acceptance_binding_path" ]] || refuse 'main-integration binding bounds differ from verdict' 74
        ;;
      next-milestone)
        successor_state="$(field_from_text "$text" 'Successor state')" || refuse 'next-milestone binding is missing successor state' 74
        successor="$(field_from_text "$text" 'Successor contract commit')" || refuse 'next-milestone binding is missing successor contract' 74
        successor_path="$(field_from_text "$text" 'Successor contract path')" || refuse 'next-milestone binding is missing successor contract path' 74
        entry="$(field_from_text "$text" 'Entry conditions evidence commit')" || refuse 'next-milestone binding is missing entry-condition evidence' 74
        entry_path="$(field_from_text "$text" 'Entry conditions evidence path')" || refuse 'next-milestone binding is missing entry-condition evidence path' 74
        [[ "$successor_state" == "$package_successor_state" && "$successor" == "$package_successor_commit" && "$successor_path" == "$package_successor_path" && "$entry" == "$package_entry_commit" && "$entry_path" == "$package_entry_path" ]] || refuse 'next-milestone binding bounds differ from verdict' 74
        ;;
    esac
  else
    blocking_status="$(field_from_text "$text" 'Blocking evidence status')" || refuse 'negative binding is missing blocking evidence status' 74
    [[ "$blocking_status" == "$sequence_blocking_status" ]] || refuse 'negative binding blocking status differs from verdict' 74
  fi
}

validate_result_artifact() {
  local commit="$1" path="$2" text header controller timestamp status approval approval_path approval_text approval_status approval_kind approval_candidate approval_target approval_auth approval_critical approval_important approval_branch approval_guard_commit approval_guard_path approval_guard_hash candidate target milestone_branch guard_argv guard_commit guard_path guard_hash environment limitations interruption output_encoding output_length output_hash computed computed_length stats pre_local pre_remote post_local post_remote pre_evidence post_evidence recovery snapshot replay expected_argv
  text="$(git show "$commit:$path")" || refuse 'result artifact is unreadable' 74
  header="$(metadata_before_marker "$text" '--- BEGIN GUARD OUTPUT ---')" || refuse 'result guard output framing is invalid' 74
  controller="$(field_from_text "$header" 'Controller recorder')" || refuse 'result provenance is invalid' 74
  timestamp="$(field_from_text "$header" 'Recorded timestamp')" || refuse 'result provenance is invalid' 74
  status="$(field_from_text "$header" 'Result status')" || refuse 'result is missing status' 74
  approval="$(field_from_text "$header" 'Consumed approval commit')" || refuse 'result is missing consumed approval' 74
  approval_path="$(field_from_text "$header" 'Consumed approval path')" || refuse 'result is missing consumed approval' 74
  milestone_branch="$(field_from_text "$header" 'Milestone branch')" || refuse 'result is missing milestone branch' 74
  [[ "$milestone_branch" =~ ^milestone/(m[0-9]+)-[a-z0-9][a-z0-9-]*$ ]] || refuse 'result reviewed guard provenance is invalid' 74
  result_milestone_key="${BASH_REMATCH[1]}"
  result_milestone="$(printf '%s' "$result_milestone_key" | tr '[:lower:]' '[:upper:]')"
  validate_sequence_path "$path" results main-integration-result "$result_milestone" 'result action is not canonical'
  sequence_result_action="$sequence_path_action"; sequence_result_sequence="$sequence_path_id"; sequence_result_milestone="$result_milestone"; sequence_result_milestone_key="$result_milestone_key"
  candidate="$(field_from_text "$header" 'Integration candidate')" || refuse 'result is missing integration candidate' 74
  target="$(field_from_text "$header" 'Target main commit')" || refuse 'result is missing target main' 74
  guard_argv="$(field_from_text "$header" 'Guard argv')" || refuse 'result is missing guard invocation' 74
  guard_commit="$(field_from_text "$header" 'Reviewed guard commit')" || refuse 'result is missing reviewed guard provenance' 74
  guard_path="$(field_from_text "$header" 'Reviewed guard path')" || refuse 'result is missing reviewed guard provenance' 74
  guard_hash="$(field_from_text "$header" 'Reviewed guard SHA-256')" || refuse 'result is missing reviewed guard provenance' 74
  environment="$(field_from_text "$header" 'Execution environment')" || refuse 'result is missing execution environment' 74
  limitations="$(field_from_text "$header" 'Limitations')" || refuse 'result is missing limitations' 74
  interruption="$(field_from_text "$header" 'Interruption point')" || refuse 'result is missing interruption point' 74
  output_encoding="$(field_from_text "$header" 'Guard output encoding')" || refuse 'result is missing guard output encoding' 74
  output_length="$(field_from_text "$header" 'Guard output byte length')" || refuse 'result is missing guard output byte length' 74
  output_hash="$(field_from_text "$header" 'Full guard output SHA-256')" || refuse 'result is missing guard output hash' 74
  pre_local="$(field_from_text "$header" 'Pre local main')" || refuse 'result is missing refs' 74
  pre_remote="$(field_from_text "$header" 'Pre remote main')" || refuse 'result is missing refs' 74
  post_local="$(field_from_text "$header" 'Post local main')" || refuse 'result is missing refs' 74
  post_remote="$(field_from_text "$header" 'Post remote main')" || refuse 'result is missing refs' 74
  pre_evidence="$(field_from_text "$header" 'Pre evidence tip')" || refuse 'result is missing refs' 74
  post_evidence="$(field_from_text "$header" 'Post evidence tip')" || refuse 'result is missing refs' 74
  recovery="$(field_from_text "$header" 'Recovery state')" || refuse 'result is missing recovery state' 74
  snapshot="$(field_from_text "$header" 'Recovery snapshot path')" || refuse 'result is missing recovery snapshot path' 74
  replay="$(field_from_text "$header" 'Replay status')" || refuse 'result is missing replay status' 74
  [[ "$controller" == program-controller ]] && valid_utc_timestamp "$timestamp" || refuse 'result provenance is invalid' 74
  resolve_exact_commit "$approval" 'consumed approval commit'
  case "$consumed_approvals" in *"|$approval|"*) refuse 'approval is replayed by multiple results' 74 ;; esac
  consumed_approvals="$consumed_approvals|$approval|"
  [[ "$approval_path" == "docs/orchestration/decisions/$result_milestone_key/bindings/main-integration.md" ]] || refuse 'consumed approval path is not canonical' 74
  require_regular_blob "$approval" "$approval_path" 'consumed approval'
  git merge-base --is-ancestor "$approval" "$commit" || refuse 'consumed approval does not precede result' 74
  [[ "$(git log -1 --format=%H "$commit" -- "$approval_path")" == "$approval" ]] || refuse 'consumed approval is not current at result' 74
  approval_text="$(git show "$approval:$approval_path")" || refuse 'consumed approval is unreadable' 74
  approval_status="$(field_from_text "$approval_text" 'Binding status')" || refuse 'consumed approval schema is invalid' 74
  approval_kind="$(field_from_text "$approval_text" 'Decision kind')" || refuse 'consumed approval schema is invalid' 74
  approval_candidate="$(field_from_text "$approval_text" 'Reviewed candidate')" || refuse 'consumed approval schema is invalid' 74
  approval_target="$(field_from_text "$approval_text" 'Target main commit')" || refuse 'consumed approval schema is invalid' 74
  approval_auth="$(field_from_text "$approval_text" 'Authorization')" || refuse 'consumed approval schema is invalid' 74
  approval_critical="$(field_from_text "$approval_text" 'Critical findings')" || refuse 'consumed approval schema is invalid' 74
  approval_important="$(field_from_text "$approval_text" 'Important findings')" || refuse 'consumed approval schema is invalid' 74
  approval_branch="$(field_from_text "$approval_text" 'Milestone branch')" || refuse 'consumed approval schema is invalid' 74
  approval_guard_commit="$(field_from_text "$approval_text" 'Reviewed guard commit')" || refuse 'consumed approval schema is invalid' 74
  approval_guard_path="$(field_from_text "$approval_text" 'Reviewed guard path')" || refuse 'consumed approval schema is invalid' 74
  approval_guard_hash="$(field_from_text "$approval_text" 'Reviewed guard SHA-256')" || refuse 'consumed approval schema is invalid' 74
  [[ "$approval_status" == Current && "$approval_kind" == APPROVE_MAIN_INTEGRATION && "$approval_auth" == GRANTED && "$approval_critical" == 0 && "$approval_important" == 0 ]] || refuse 'result does not consume a current main-integration approval' 74
  [[ "$candidate" == "$approval_candidate" && "$target" == "$approval_target" ]] || refuse 'result candidate or target differs from consumed approval' 74
  [[ "$milestone_branch" == "$approval_branch" && "$guard_commit" == "$approval_guard_commit" && "$guard_path" == "$approval_guard_path" && "$guard_hash" == "$approval_guard_hash" ]] || refuse 'result invocation provenance differs from consumed approval' 74
  resolve_exact_commit "$candidate" 'result integration candidate'
  resolve_exact_commit "$target" 'result target main'
  resolve_exact_commit "$guard_commit" 'result reviewed guard commit'
  [[ "$milestone_branch" =~ ^milestone/m[0-9]+-[a-z0-9][a-z0-9-]*$ && "$guard_path" == .codex/skills/roadmap-orchestrator/scripts/validate_main_integration.sh && "$guard_hash" =~ ^[0-9a-f]{64}$ ]] || refuse 'result reviewed guard provenance is invalid' 74
  require_executable_blob "$guard_commit" "$guard_path" 'result reviewed guard'
  [[ "$(git show "$guard_commit:$guard_path" | shasum -a 256 | awk '{print $1}')" == "$guard_hash" ]] || refuse 'result reviewed guard hash differs from artifact' 74
  expected_argv="validate_main_integration.sh|integrate|$milestone_branch|$candidate|$target|$approval"
  [[ "$guard_argv" == "$expected_argv" ]] || refuse 'result guard invocation is invalid' 74
  [[ "$output_encoding" == base64 && "$output_length" =~ ^(0|[1-9][0-9]*)$ && "$output_hash" =~ ^[0-9a-f]{64}$ ]] || refuse 'result guard evidence is invalid' 74
  [[ "$(grep -Fc -- '--- BEGIN GUARD OUTPUT ---' <<< "$text")" == 1 && "$(grep -Fc -- '--- END GUARD OUTPUT ---' <<< "$text")" == 1 ]] || refuse 'result guard output markers are invalid' 74
  stats="$(literal_stats_from_blob "$commit" "$path" '--- BEGIN GUARD OUTPUT ---' '--- END GUARD OUTPUT ---')" || refuse 'result guard output is invalid' 74
  IFS=$'\t' read -r computed computed_length <<< "$stats"
  [[ "$computed_length" == "$output_length" ]] || refuse 'result guard output byte length differs from decoded bytes' 74
  [[ "$computed" == "$output_hash" ]] || refuse 'result guard output hash differs from literal bytes' 74
  for exact in "$pre_local" "$pre_remote" "$pre_evidence"; do [[ "$exact" =~ ^[0-9a-f]{40}$ ]] || refuse 'result pre-attempt ref is invalid' 74; done
  [[ "$pre_local" == "$target" && "$pre_remote" == "$target" && "$pre_evidence" == "$approval" ]] || refuse 'result pre-attempt refs differ from approval' 74
  case "$status" in
    SUCCEEDED) [[ "$post_local" == "$candidate" && "$post_remote" == "$candidate" && "$post_evidence" == "$approval" && "$recovery" == 'Not required' && "$snapshot" == None && "$replay" == Consumed ]] || refuse 'successful result schema is inconsistent' 74 ;;
    REJECTED) [[ "$post_local" == "$target" && "$post_remote" == "$target" && "$post_evidence" == "$approval" && "$recovery" == Complete && "$snapshot" == None && "$replay" == Prohibited ]] || refuse 'rejected result schema is inconsistent' 74 ;;
    PARTIAL)
      for observation in "$post_local" "$post_remote" "$post_evidence"; do [[ "$observation" == Unknown || "$observation" =~ ^[0-9a-f]{40}$ ]] || refuse 'partial result observation is invalid' 74; done
      [[ "$recovery" == Unproved && "$snapshot" == /* && "$replay" == Prohibited ]] || refuse 'partial result schema is inconsistent' 74
      ;;
    *) refuse 'result status is invalid' 74 ;;
  esac
  sequence_result_commit="$commit"; sequence_result_path="$path"; sequence_result_status="$status"; sequence_result_approval="$approval"; sequence_result_approval_path="$approval_path"; sequence_result_branch="$milestone_branch"; sequence_result_candidate="$candidate"; sequence_result_target="$target"; sequence_result_argv="$guard_argv"; sequence_result_guard_commit="$guard_commit"; sequence_result_guard_path="$guard_path"; sequence_result_guard_hash="$guard_hash"; sequence_result_environment="$environment"; sequence_result_limitations="$limitations"; sequence_result_interruption="$interruption"; sequence_result_output_encoding="$output_encoding"; sequence_result_output_length="$output_length"; sequence_result_output_hash="$output_hash"; sequence_result_pre_local="$pre_local"; sequence_result_pre_remote="$pre_remote"; sequence_result_post_local="$post_local"; sequence_result_post_remote="$post_remote"; sequence_result_pre_evidence="$pre_evidence"; sequence_result_post_evidence="$post_evidence"; sequence_result_recovery="$recovery"; sequence_result_snapshot="$snapshot"; sequence_result_replay="$replay"
}

validate_result_binding_artifact() {
  local commit="$1" path="$2" text status result result_path result_status approval approval_path milestone_branch candidate target guard_argv guard_commit guard_path guard_hash environment limitations interruption output_encoding output_length output_hash pre_local pre_remote post_local post_remote pre_evidence post_evidence recovery snapshot replay
  text="$(git show "$commit:$path")" || refuse 'result binding is unreadable' 74
  status="$(field_from_text "$text" 'Binding status')" || refuse 'result binding is missing status' 74
  result="$(field_from_text "$text" 'Result commit')" || refuse 'result binding is missing result' 74
  result_path="$(field_from_text "$text" 'Result path')" || refuse 'result binding is missing result' 74
  result_status="$(field_from_text "$text" 'Result status')" || refuse 'result binding is missing status' 74
  approval="$(field_from_text "$text" 'Consumed approval commit')" || refuse 'result binding is missing approval' 74
  approval_path="$(field_from_text "$text" 'Consumed approval path')" || refuse 'result binding is missing approval' 74
  milestone_branch="$(field_from_text "$text" 'Milestone branch')" || refuse 'result binding is missing milestone branch' 74
  candidate="$(field_from_text "$text" 'Integration candidate')" || refuse 'result binding is missing candidate' 74
  target="$(field_from_text "$text" 'Target main commit')" || refuse 'result binding is missing target main' 74
  guard_argv="$(field_from_text "$text" 'Guard argv')" || refuse 'result binding is missing guard invocation' 74
  guard_commit="$(field_from_text "$text" 'Reviewed guard commit')" || refuse 'result binding is missing reviewed guard provenance' 74
  guard_path="$(field_from_text "$text" 'Reviewed guard path')" || refuse 'result binding is missing reviewed guard provenance' 74
  guard_hash="$(field_from_text "$text" 'Reviewed guard SHA-256')" || refuse 'result binding is missing reviewed guard provenance' 74
  environment="$(field_from_text "$text" 'Execution environment')" || refuse 'result binding is missing execution environment' 74
  limitations="$(field_from_text "$text" 'Limitations')" || refuse 'result binding is missing limitations' 74
  interruption="$(field_from_text "$text" 'Interruption point')" || refuse 'result binding is missing interruption point' 74
  output_encoding="$(field_from_text "$text" 'Guard output encoding')" || refuse 'result binding is missing output encoding' 74
  output_length="$(field_from_text "$text" 'Guard output byte length')" || refuse 'result binding is missing output byte length' 74
  output_hash="$(field_from_text "$text" 'Full guard output SHA-256')" || refuse 'result binding is missing guard output hash' 74
  pre_local="$(field_from_text "$text" 'Pre local main')" || refuse 'result binding is missing refs' 74
  pre_remote="$(field_from_text "$text" 'Pre remote main')" || refuse 'result binding is missing refs' 74
  post_local="$(field_from_text "$text" 'Post local main')" || refuse 'result binding is missing refs' 74
  post_remote="$(field_from_text "$text" 'Post remote main')" || refuse 'result binding is missing refs' 74
  pre_evidence="$(field_from_text "$text" 'Pre evidence tip')" || refuse 'result binding is missing refs' 74
  post_evidence="$(field_from_text "$text" 'Post evidence tip')" || refuse 'result binding is missing refs' 74
  recovery="$(field_from_text "$text" 'Recovery state')" || refuse 'result binding is missing recovery state' 74
  snapshot="$(field_from_text "$text" 'Recovery snapshot path')" || refuse 'result binding is missing recovery snapshot path' 74
  replay="$(field_from_text "$text" 'Replay status')" || refuse 'result binding is missing replay status' 74
  [[ "$path" == "docs/orchestration/decisions/$sequence_result_milestone_key/bindings/$sequence_result_action.md" ]] || refuse 'result action is not canonical' 74
  [[ "$status" == Current && "$result" == "$sequence_result_commit" && "$result_path" == "$sequence_result_path" && "$result_status" == "$sequence_result_status" && "$approval" == "$sequence_result_approval" && "$approval_path" == "$sequence_result_approval_path" && "$milestone_branch" == "$sequence_result_branch" && "$candidate" == "$sequence_result_candidate" && "$target" == "$sequence_result_target" && "$guard_argv" == "$sequence_result_argv" && "$guard_commit" == "$sequence_result_guard_commit" && "$guard_path" == "$sequence_result_guard_path" && "$guard_hash" == "$sequence_result_guard_hash" && "$environment" == "$sequence_result_environment" && "$limitations" == "$sequence_result_limitations" && "$interruption" == "$sequence_result_interruption" && "$output_encoding" == "$sequence_result_output_encoding" && "$output_length" == "$sequence_result_output_length" && "$output_hash" == "$sequence_result_output_hash" && "$pre_local" == "$sequence_result_pre_local" && "$pre_remote" == "$sequence_result_pre_remote" && "$post_local" == "$sequence_result_post_local" && "$post_remote" == "$sequence_result_post_remote" && "$pre_evidence" == "$sequence_result_pre_evidence" && "$post_evidence" == "$sequence_result_post_evidence" && "$recovery" == "$sequence_result_recovery" && "$snapshot" == "$sequence_result_snapshot" && "$replay" == "$sequence_result_replay" ]] || refuse 'result binding conflicts with result' 74
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
consumed_approvals=
validate_standalone_review() {
  local commit="$1" path="$2" text header role candidate verdict
  text="$(git show "$commit:$path")" || refuse 'review artifact is unreadable' 74
  header="$(metadata_before_marker "$text" '--- BEGIN REVIEW OUTPUT ---')" || refuse 'review literal output framing is invalid' 74
  role="$(field_from_text "$header" 'Reviewer role')" || refuse 'review provenance is invalid' 74
  candidate="$(field_from_text "$header" 'Reviewed candidate')" || refuse 'review provenance is invalid' 74
  verdict="$(field_from_text "$header" 'Verdict')" || refuse 'review provenance is invalid' 74
  case "$role" in qa_performance_verifier|licensing_security_reviewer|final_code_reviewer) ;; *) refuse 'review provenance is invalid' 74;; esac
  current_package_commit="$commit"
  case "$verdict" in APPROVE) validate_review "$commit" "$path" "$role" "$candidate" APPROVE ;; REJECT) validate_review "$commit" "$path" "$role" "$candidate" REJECT ;; *) refuse 'review verdict is invalid' 74;; esac
}
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
        validate_standalone_review "$evidence_commit" "$commit_path"
        sequence_stage=package
      elif [[ "$commit_status" == A && "$commit_path" =~ ^docs/orchestration/decisions/m[0-9]+/packages/[a-z0-9][a-z0-9-]*\.md$ ]]; then
        sequence_package_commit="$evidence_commit"; sequence_package_path="$commit_path"
        validate_package_reviews "$evidence_commit" "$commit_path"
        sequence_stage=verdict
      elif [[ "$commit_status" == A && "$commit_path" =~ ^docs/orchestration/decisions/m[0-9]+/results/[a-z0-9][a-z0-9-]*\.md$ ]]; then
        validate_result_artifact "$evidence_commit" "$commit_path"
        sequence_stage=result_binding
      else
        refuse 'evidence sequence expected one package or result commit' 74
      fi
      ;;
    verdict)
      [[ "$commit_status" == A && "$commit_path" =~ ^docs/orchestration/decisions/m[0-9]+/verdicts/[a-z0-9][a-z0-9-]*\.md$ ]] || refuse 'evidence sequence expected one verdict commit' 74
      validate_verdict_artifact "$evidence_commit" "$commit_path"
      sequence_stage=binding
      ;;
    binding)
      [[ ( "$commit_status" == A || "$commit_status" == M ) && "$commit_path" =~ ^docs/orchestration/decisions/m[0-9]+/bindings/[a-z0-9][a-z0-9-]*\.md$ ]] || refuse 'evidence sequence expected one binding commit' 74
      validate_binding_artifact "$evidence_commit" "$commit_path"
      sequence_stage=package
      ;;
    result_binding)
      [[ ( "$commit_status" == A || "$commit_status" == M ) && "$commit_path" =~ ^docs/orchestration/decisions/m[0-9]+/bindings/[a-z0-9][a-z0-9-]*\.md$ ]] || refuse 'evidence sequence expected one result binding commit' 74
      validate_result_binding_artifact "$evidence_commit" "$commit_path"
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
