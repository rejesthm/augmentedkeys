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

if [[ $# -ne 3 ]]; then
  usage
fi

mode="$1"
candidate_tip="$2"
governance_base="$3"

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
    elif [[ "$historical_path" =~ ^docs/orchestration/decisions/m[0-9]+/(packages|verdicts|results)/[a-z0-9][a-z0-9-]*\.md$ ]]; then
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
      if [[ "$commit_status" == A && "$commit_path" =~ ^docs/orchestration/decisions/m[0-9]+/packages/[a-z0-9][a-z0-9-]*\.md$ ]]; then
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
