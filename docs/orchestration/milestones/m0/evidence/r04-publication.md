# R04 integration and guarded publication

Date2026-10-23 UTC, project Asia/Manila. Controller `01a1671a-5c1d-7ac2-b9a1-5b94d86ed845`. Documentary task; host macOS26.6.2(25G83)/arm64, Git2.54.0, CodexCLI0.154.0-alpha.6.2. No device/build/runtime measurement.

Exact reviewed candidate `26b6c2702d21704481969dc99fa51ee504aa9bb7`; finalized verification `d9bd4a428e1d1c44f87cf965dde5b61887d7a1cc`; separate Verified state `03a410ded59bd8abef1ee809cfd4b5b6ae51c06a`. Required QA/Security/Final each approve0/0/0, all3 original findings closed. Writer/reviewers idle before integration.

Hook-disabled non-fast-forward merge `ed966a7ff7952377109c810a7a8c901c5e4fdbf2` has exact parents Verified state and candidate; controller state and task reports diverged from `55f9a9651d100007435bb8a4d96fc6eea828ed22`. No conflict. Only two report paths changed during merge; both Git blob IDs equal reviewed candidate, whitespace check0, clean tracked tree. Entire Apple report remains preserved. Original failed/rejected drafts and review history retained.

Integration bookkeeping/published candidate `980a9576b2b37ac6a9364d1e5ad21f52c847db9f`. Guard commands ran from clean checked-out milestone/m0-research. Before each command, controller separately asserted HEAD and milestone ref equal this exact pinned SHA. Guard requires branch-name candidate argument, resolves that ref to the SHA, and publishes only contracted refspec. No raw push or task publication.

```text
.codex/skills/roadmap-orchestrator/scripts/validate_branch_action.sh authorize milestone/m0-research milestone/m0-research b1b0c1edd5e42d3ea791f665c22954834e962d05
exit0
authorized:milestone/m0-research:980a9576b2b37ac6a9364d1e5ad21f52c847db9f:refs/heads/milestone/m0-research:refs/heads/milestone/m0-research
```

```text
.codex/skills/roadmap-orchestrator/scripts/validate_branch_action.sh push milestone/m0-research milestone/m0-research b1b0c1edd5e42d3ea791f665c22954834e962d05
exit0
pushed:milestone/m0-research:980a9576b2b37ac6a9364d1e5ad21f52c847db9f:refs/heads/milestone/m0-research:refs/heads/milestone/m0-research
To github.com:rejesthm/augmentedkeys.git
   576fb7c..980a957  milestone/m0-research -> milestone/m0-research
```

```text
.codex/skills/roadmap-orchestrator/scripts/validate_branch_action.sh verify milestone/m0-research milestone/m0-research b1b0c1edd5e42d3ea791f665c22954834e962d05
exit0
verified:milestone/m0-research:980a9576b2b37ac6a9364d1e5ad21f52c847db9f:refs/heads/milestone/m0-research:refs/heads/milestone/m0-research
```

After all three modes, direct remote read proved milestone hash `980a9576b2b37ac6a9364d1e5ad21f52c847db9f` equal local; remote main remains `b1b0c1edd5e42d3ea791f665c22954834e962d05`. Root owner's excluded main-guard edits were freshly rehashed unchanged; no adoption/main attempt. Local main, product/native/manifests/ADRs/dependencies/permissions unchanged. This record's own commit is later bookkeeping and is not claimed to have been included in the preceding publication.

Raw `integration.json` SHA256 `5f1b76e079bbe7a8a947e1b38905ac601f10ce4ff4b3a1b1471dd22c42018b93`; `publication.json` SHA256 `2caaef1f6c4461c5a6f71f1f71b790dafbb8de5b2cf1f425aa64fd791ef9620b` under common Git `decision-team-continuation/2026-10-23/r04/`.

R01–R04 remain Verified, not Accepted. M0 remains Active; R05–R10 queued. Next: bind/commit R05 brief, separate eligibility, bounded Conductor intake and assignment before any MIDI research. No new owner approval needed for the unchanged eligible M0 scope. All architecture/adoption/hardware/legal/release/main/successor gates remain.
