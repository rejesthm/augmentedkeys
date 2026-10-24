# CT04 correction verification — round 0 candidate

Candidate: `aabd1b2ba3d26c35343b9c0bdb5fbf17de62ceb5`. Implementation parent: `a4bf5add0f41bea8b18c2f6b946ebc83362b743b`; original task base: `bfc5b04aa388e99380c2ab135fe036236175859d`; authority/brief: `8be352c653084d47929ffecdf6e3dca0c5cb5c3e`. Candidate is an isolated proposal, independently unreviewed. M0 remains paused. No main or canonical evidence publication has occurred.

Controller materialized the ten exact proposed byte streams after checking the Conductor handoff manifest2da5698bb6f283b564a5d929790e10e9d52718efcce5bf8b968c9163ce209c0e. Actual working bytes match the preserved proposal and materialized-audit-round0.json. Scope, syntax, whitespace, modes, original owner hashes, local/live main, archived evidence tip and absent canonical evidence branch passed. Original .codex write restriction is preserved in the assignment and raw runtime; no sandbox was relaxed.

## Fresh controller commands

- `bash .codex/skills/roadmap-orchestrator/scripts/test_validate_decision_evidence.sh`: exit 0; full output materialized-round0-decision_evidence.txt; SHA256 `f69cd97287871f37ee564528ad55e9c3c5cf7f66a840349f0b00648330741e24`.
- `bash .codex/skills/roadmap-orchestrator/scripts/test_validate_main_integration.sh`: exit 0; full output materialized-round0-main_integration.txt; SHA256 `18cbcbfbbabb7243e87ad2d394f4480543bb142d5ec47eac014147aa5f864c8b`.

Results:18 decision-evidence scenarios and34 main-integration scenarios. Both ran against disposable local repositories/remotes only. Environment:

```text
{'os': 'ProductName:\t\tmacOS\nProductVersion:\t\t26.6.2\nBuildVersion:\t\t25G83', 'architecture': 'arm64', 'git': 'git version 2.54.0 (Apple Git-157)', 'bash': 'GNU bash, version 3.2.57(1)-release (arm64-apple-darwin25)\nCopyright (C) 2007 Free Software Foundation, Inc.'}
```

## Evidence and limits

Private root: .git/decision-team-continuation/2026-10-23/governance-correction. proposal-round0 preserves all ten original proposed files, file/evidence manifests, RED/GREEN logs, intermediate failures and author pressure traces. conductor-proposal.final.txt preserves full handoff; conductor-proposal-runtime.json and immutable raw relay/child snapshots prove runtime identity. qa-protocol-baseline.final.txt is the independent frozen-old-control scenario exercise. The author new-skill traces/string checks are not independent validation. Fresh independent revised-protocol QA remains required.

Controller observations CP1–CP5 in controller-pre-review-observations.json and addendum remain unresolved, for independent verification: task acceptance/delta completeness and modes; misleading snapshot-retention path; negative decisions/review output completeness; ignored-state snapshot safety; conflicting old/new controls. Passing fixtures do not close those observations. Original advisory QA/Security rejections and all source/failure histories remain preserved.

Require independent QA/Performance and Licensing/Security review of this exact candidate, then Final only after both approve the unchanged candidate. No approval, adoption, M0 reactivation, main integration, successor, product/device/performance claim is made.
