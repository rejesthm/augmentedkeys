# M0 Main Integration Evidence

This milestone-branch file is the status and recovery index for future guarded M0 integration activity. Canonical runtime packages, verdicts, bindings, attempts, and result bindings live only under `docs/orchestration/decisions/m0/` on the dedicated append-only `governance/decision-evidence` branch. Existing status entries, refusals, partial results, and recovery facts must not be rewritten or deleted.

## Initial status at creation

- Decision-evidence branch: `Not created`
- Main-integration binding commit: `Not yet decided`
- Integration status: `Not yet integrated`
- Accepted milestone tip: `Not yet decided`
- Original `main` base: `Not yet decided`
- `APPROVE_MAIN_INTEGRATION` decision commit: `Not yet decided`
- Integrated local `main` SHA: `Not yet integrated`
- Integrated remote `main` SHA: `Not yet integrated`
- Guard verification result: `Not yet integrated`
- Result commit: `Not yet integrated`
- Result binding commit: `Not yet integrated`
- Recovery state: `Not required; no attempt exists`
- Successor contract commit: `Not yet decided`
- Successor activation result: `Not yet decided`
- Reason: M0 is still `Paused for owner decision`; no milestone acceptance or main-integration approval exists and no integration has been attempted.

Future status entries are appended as numbered `MI-NNN` sections after their canonical result and current result binding are published. Each records the exact milestone branch, accepted tip, original local and remote `main` SHA, decision binding, guard arguments and outputs for `authorize`, `integrate`, and `verify`, resulting local and remote SHA, environment, limitations, interruption state, recovery action, result commit, result binding, and local/remote evidence tip. A confirmed rejection records refusal after full local restoration; proved equality records success; ambiguity or external movement records non-replayable `PARTIAL` and requires `PAUSE_HUMAN`. Never retry an approval after a bound result.
