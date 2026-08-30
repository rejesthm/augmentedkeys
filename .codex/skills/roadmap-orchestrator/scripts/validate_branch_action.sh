#!/usr/bin/env bash
set -euo pipefail

usage() {
  printf 'usage: %s authorize <candidate> <approved> <accepted-base>\n' "$0" >&2
  printf '   or: %s push <candidate> <approved> <accepted-base>\n' "$0" >&2
  printf '   or: %s verify <candidate> <approved> <accepted-base>\n' "$0" >&2
  exit 64
}

refuse() {
  printf 'refused: %s\n' "$1" >&2
  exit "$2"
}

if [[ $# -ne 4 ]]; then
  usage
fi

mode="$1"
candidate="$2"
approved="$3"
accepted_base="$4"

case "$approved" in
  milestone/*) ;;
  *) refuse 'approved branch is not a milestone branch' 65 ;;
esac

case "$candidate" in
  main|refs/heads/main|task/*|refs/heads/task/*)
    refuse 'candidate branch is prohibited' 65
    ;;
esac

if [[ "$candidate" != "$approved" ]]; then
  refuse 'candidate does not match the approved milestone branch' 66
fi

local_ref="refs/heads/$approved"
refspec="$local_ref:$local_ref"
if ! local_sha="$(git rev-parse --verify "$local_ref^{commit}" 2>/dev/null)"; then
  refuse 'local milestone branch does not resolve to a commit' 68
fi
if [[ ! "$accepted_base" =~ ^[0-9a-f]{40}$ ]] || ! base_sha="$(git rev-parse --verify "$accepted_base^{commit}" 2>/dev/null)"; then
  refuse 'accepted base is not an exact commit' 69
fi
if [[ "$base_sha" != "$accepted_base" ]] || ! git merge-base --is-ancestor "$accepted_base" "$local_sha"; then
  refuse 'milestone branch does not descend from the accepted base' 69
fi
if ! checked_out="$(git symbolic-ref --quiet --short HEAD 2>/dev/null)" || [[ "$checked_out" != "$approved" ]]; then
  refuse 'approved milestone branch is not checked out' 71
fi
if [[ -n "$(git status --porcelain)" ]]; then
  refuse 'worktree is not clean' 70
fi
if [[ ! "$local_sha" =~ ^[0-9a-f]{40}$ ]]; then
  refuse 'resolved local SHA is invalid' 68
fi

resolve_remote_sha() {
  local remote_output
  if ! remote_output="$(git ls-remote --exit-code origin "$local_ref" 2>/dev/null)"; then
    return 1
  fi
  printf '%s\n' "${remote_output%%[[:space:]]*}"
}

case "$mode" in
  authorize)
    printf 'authorized:%s:%s:%s\n' "$candidate" "$local_sha" "$refspec"
    ;;
  push)
    if ! git push origin "$refspec"; then
      refuse 'constrained milestone push failed' 72
    fi
    if ! remote_sha="$(resolve_remote_sha)"; then
      refuse 'remote milestone branch does not resolve to a commit' 68
    fi
    if [[ "$remote_sha" != "$local_sha" ]]; then
      refuse 'pushed remote hash differs from authorized local hash' 67
    fi
    printf 'pushed:%s:%s:%s\n' "$candidate" "$local_sha" "$refspec"
    ;;
  verify)
    if ! remote_sha="$(resolve_remote_sha)"; then
      refuse 'remote milestone branch does not resolve to a commit' 68
    fi
    if [[ ! "$remote_sha" =~ ^[0-9a-f]{40}$ ]]; then
      refuse 'resolved remote SHA is invalid' 68
    fi
    if [[ "$local_sha" != "$remote_sha" ]]; then
      refuse 'local and remote milestone hashes differ' 67
    fi
    printf 'verified:%s:%s:%s\n' "$candidate" "$local_sha" "$refspec"
    ;;
  *) usage ;;
esac
