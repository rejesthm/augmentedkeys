# Initial M0 Goals

M0 — Research & Architecture is active. These goals define the evidence required before product-core research begins; they do not claim completed research or implementation.

1. Maintain a prioritized research backlog covering the approved high-risk areas.
2. Define measurement methods before making performance claims.
3. Maintain a license adoption gate before packages, code, or assets are adopted.
4. Require research, spikes, and ADRs for high-risk decisions before implementation approval.
5. Keep the Flutter shell free of core product behavior.
6. Keep the manual L1 loop able to report state without editing product code.
7. Require owner review of the foundation before research starts.

## M0 non-goals

M0 does not implement audio, MIDI, patches, layers, splits, snapshots, songs, setlists, plugin hosting, instruments, cloud services, or deployment. It does not choose an audio, MIDI, plugin, or state-management architecture; add third-party Flutter packages; schedule automation; or make unsupported research, benchmark, build, simulator, or device claims.

## Success evidence by goal

| Goal | Required artifact/path | Objective pass condition/check | Owner-approval record |
| --- | --- | --- | --- |
| 1. Prioritized research backlog | `docs/research/RESEARCH_INDEX.md` | The file exists and lists the approved research streams in priority order without research conclusions. | `.loop/progress.md` → `Owner review` → `Research backlog approval` |
| 2. Measurement methods before claims | `docs/testing/TEST_STRATEGY.md` and `docs/testing/DEVICE_MATRIX.md` | Both files exist; the strategy names measurement methods and the matrix distinguishes simulator from physical-device evidence. | `.loop/progress.md` → `Owner review` → `Measurement-method approval` |
| 3. License adoption gate | `docs/research/LICENSE_LEDGER.md` | The file exists and requires an entry before a dependency, code, or asset is adopted. | `.loop/progress.md` → `Owner review` → `License-gate approval` |
| 4. ADRs and spikes for high-risk decisions | `docs/adr/ADR_TEMPLATE.md` and `docs/tasks/TASK_TEMPLATE.md` | Both files exist; the ADR template requires evidence and the task template requires a spike for a high-risk decision. | `.loop/progress.md` → `Owner review` → `ADR-and-spike process approval` |
| 5. Shell contains no core product behavior | `lib/main.dart` and `test/widget_test.dart` | `flutter test` exits 0, and `rg -n "Audio and MIDI features are not implemented" lib/main.dart test/widget_test.dart` returns the status copy and its widget assertion. | `.loop/progress.md` → `Owner review` → `Shell-scope approval` |
| 6. Manual L1 state reporting without product-code edits | `LOOP.md`, `.codex/skills/loop-conductor/SKILL.md`, `STATE.md`, `.loop/progress.md`, and `loop-run-log.md` | The loop instructions limit writable files to `STATE.md`, `.loop/progress.md`, and `loop-run-log.md`, and prohibit product-code edits. | `.loop/progress.md` → `Owner review` → `Manual-L1 approval` |
| 7. Owner reviews foundation before research | `.loop/progress.md` | The `Owner review` section records an explicit foundation-approval decision before any research task is marked active. | `.loop/progress.md` → `Owner review` → `Foundation approval` |

Until every required artifact exists, its pass condition is met, and the named owner-approval record is present, future work remains not started.
