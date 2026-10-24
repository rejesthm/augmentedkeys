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


## Round 1 interim controller evidence

This records the preserved temporary handoff only; no round1 candidate is materialized, frozen, independently reviewed or adopted. Assignment `d4e36ffe968df4561c23706eededd70c36be38da` and execution barrier `e4bfd2f949baf8100788716f9f1f03c2293182b9` remain current. The first handoff manifest `273669be49a3306272baf8c019343aed81be0c33ed3a7655523bdb1a6812a3c1` matches all ten saved file hashes, modes and lengths in private proposal-round1-handoff. Its narrative evidence-test hash and byte count were stale; the manifest and actual bytes are authoritative.

Fresh controller runs on macOS26.6.2 arm64 passed27 evidence-publication scenarios and45 integration scenarios, exits0, against disposable local repositories/remotes. The controller run exercised the Unix-socket case that the author sandbox skipped. Full command context and outputs remain in controller-handoff-round1-results.json and its named output files:

- `controller-handoff-round1-decision_evidence.txt`: SHA256 `c1147a41a5bb1d547834aee968ddba200698fd4be3bec346a368a946b3b43f3e`; test source SHA256 `2333621df274c1aac6a0d39500c45c79ecd3f89cbf9baf225beb132df33f41cb`.
- `controller-handoff-round1-main_integration.txt`: SHA256 `2c34e558a663709d92d18a1d2d21e59c893fabfdc877f2e909a2dbb2377a1514`; test source SHA256 `3b393550f2d4e7fec8ecf1027fe72bff1ba028b6c233f92f440dd04f1114d523`.

These passing suites do not close the independent round0 findings. Controller parser-only reproductions in supplemental-round1 each exit1 for a valid header plus literal review text with metadata-like lines. Both actual preserved independent reviewer outputs lack a final newline; literal-terminal-newline-observation.json records exact raw and altered hashes. The author is continuing correction1 before review, including exact payload handling, human-only pauses, calendar validation, full actual document shapes and a combined two-guard fixture. Intermediate failures and all prior source versions are preserved. No new independent verdict exists.

The task worktree remains clean at the execution barrier, root owner edits retain their recorded hashes, and main is unchanged. M0 remains paused; R01–R10 remain Verified, none Accepted. No product, device or performance evidence is created by this checkpoint.


## Round 1 final candidate verification

Candidate: `b468ac5aaac17197264dd12ac8759fb45db2eef1`; parent/execution checkpoint: `b2ea1ce498d92d4d135e4215704d8623e8162cb4`; final controller assignment: `a293320d0e605854a5073d187c30272c8b115e3b`; authority/brief: `8be352c653084d47929ffecdf6e3dca0c5cb5c3e`. This exact isolated candidate is awaiting independent review. M0 remains paused; R01–R10 remain Verified, none Accepted; main and the archived erroneous evidence history are unchanged. No canonical evidence branch was recreated or published.

The Conductor relinquished final temporary proposal manifest `ecf30e98048723dd3d3e6b10185708574ac3bc3d1aea6f7959463237b1fcf62f`, preserved as proposal-round1-rawbytes. Controller verified and materialized its exact ten file hashes, lengths and modes, then made the four-file fixture/prose delta explicitly assigned in the above commit. Both production guard hashes remain identical to the author manifest. controller-final-adjustments.json identifies every author/final hash difference. The fixture now initializes synthetic index data before copying actual inputs and asserts the real index reaches the source candidate unchanged. The prose names accepted candidate C in acceptance bookkeeping and separately approved integration candidate I in successful results, matching existing guard behavior.

### Fresh controller verification

- Command: `bash .codex/skills/roadmap-orchestrator/scripts/test_validate_decision_evidence.sh`; exit 0; full output `materialized-round1-decision_evidence.txt`; SHA256 `26fa331cdbcb17b4dd9bccc571e74b9fe023603b37905d79dd78f7caf5d3019c`.
- Command: `bash .codex/skills/roadmap-orchestrator/scripts/test_validate_main_integration.sh`; exit 0; full output `materialized-round1-main_integration.txt`; SHA256 `da1f91842841daf75917262c98a1e77e8c1e85e8b28edcca13fc6e0b1ca85cd1`.

Results:39 default evidence-publication scenarios and50 default main-integration scenarios, including the Unix-socket fixture that the author sandbox skipped. Counts differ from the author because actual raw-response and actual-document scenarios are optional environment inputs. Separate focused runs invoked the existing exact raw-review scenario functions with preserved QA/Security responses, three scenarios each, exits0. Exact function-definition prefixes and production guard copies were used without changing source semantics; the reduced dispatch, source and harness hashes, input hashes, commands and outputs are preserved in controller-real-payloads/results.json and its sibling scripts/logs. These focused scenarios overlap default synthetic cases and must not be summed as distinct new tests. Separate actual-document run used ACTUAL_SHAPES_ROOT pointing to the milestone worktree at `17161f5324c94b40a84c29900957214be8299974` and MAIN_GUARD_ACTUAL_SHAPES_ONLY=yes: exit0/PASS1. Its assertion first failed with exit1 and the intended replaced-index message, then passed after the setup correction. Full raw outputs: controller-real-index-red.txt and controller-real-index-green.txt. These checks used disposable local Git repositories and local bare remotes only. Environment: {'platform': 'macOS-26.6.2-arm64-arm-64bit', 'git': 'git version 2.54.0 (Apple Git-157)', 'bash': 'GNU bash, version 3.2.57(1)-release (arm64-apple-darwin25)'}.

The complete source hash manifest before and after both suites matched. Scope, modes, shell syntax, whitespace, original owner hashes, local/live main, preserved archive and absent canonical evidence branch passed materialized and prefreeze audits. Full artifacts are in private .git/decision-team-continuation/2026-10-23/governance-correction; no runtime evidence is inferred from configuration alone.

### Retained failures, corrections and limits

Round0 candidate/rejections remain unchanged at their exact commits. Pre-review round1 source proposals and all failed runs are preserved separately as proposal-round1-handoff, proposal-round1-continuation and proposal-round1-rawbytes. Their interim counts are not final-candidate verification. The prior author handoff overclaimed use of all five real documents because the index copy was overwritten by fixture data; the controller reproduced and corrected that fixture before this final verification. Actual raw QA/Security responses without terminal newlines exposed the literal-output hash defect; the final guards verify canonical base64 framing, exact decoded lengths and SHA256s without normalizing bytes. The full raw response/provenance, targeted RED/GREEN regressions and failure inventories remain in the saved manifests and runtime snapshots. The controller snapshot attempt with a mistyped child UUID failed without repository mutation, its partial relay file is retained, and the corrected snapshot proves the configured Conductor identity and unchanged permissions.

No original owner-edited guard was adopted. No package, asset, app behavior, Flutter/native code, hardware operation, latency claim or performance evidence is introduced. Author traces and controller tests do not substitute for independent QA/Security/Final approval. Require fresh QA/Performance and Licensing/Security reviews of this exact candidate, then Final only after both approve it unchanged. No adoption, M0 reactivation, milestone acceptance, main integration or successor authority is claimed.
