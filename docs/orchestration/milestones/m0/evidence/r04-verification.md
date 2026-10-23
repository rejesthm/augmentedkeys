# R04 verification — correction round1

Candidate `26b6c2702d21704481969dc99fa51ee504aa9bb7`; prior rejected candidate `85fd1ae90b37ecf03032bc6c6028c560c8a36ade`; task base `55f9a9651d100007435bb8a4d96fc6eea828ed22`. Status: pending fresh affected QA/Security then Final; not Verified. Review source `5385671e0a9a3cabb09b3755483480196b188a96`; correction T02 `181018e34dc4ce0fae543ab5caed76ca1ed602fb`; separate In-progress state `9f506847420dbd74d4927913c3aa117664dafa7f`. Same Android writer and exact two-file authority; writer handback complete. Original review/candidate evidence preserved below and in Git.

Fresh controller checks at `2026-10-23T10:16:32.702260+00:00` UTC, same macOS26.6.2(25G83)/arm64/Git2.54.0/CodexCLI0.154.0-alpha.6.2 environment:

```text
git diff --check 55f9a9651d100007435bb8a4d96fc6eea828ed22 26b6c2702d21704481969dc99fa51ee504aa9bb7
exit0; no output
git diff --name-only 55f9a9651d100007435bb8a4d96fc6eea828ed22 26b6c2702d21704481969dc99fa51ee504aa9bb7
docs/research/ANDROID_AUDIO_RESEARCH.md
docs/research/PLUGIN_HOSTING_RESEARCH.md
git status --porcelain
exit0; empty
```

Exact two-report scope, entire24,521-byte Apple prefix unchanged once, SHA256 `2ebdfae97d82850928a00ac983a358014a1e84cefe2e12a994099ea77ee89c5f`. All54 raw source bodies rehashed against indexes:54matches/0mismatches, allHTTP200. Source catalog `8ae8c090f27d9cf9d27861cd1eeb1e4c246b320d` includes newC52–C54 official FGS rule bodies; original51 unchanged. No product/native/protected path, dependency/asset/permission/adoption change. No Flutter/build/device/runtime/performance command or result. Main preservation evidence remains the earlier baseline timestamp, not newly remeasured here.

## Finding-to-correction locations

- QA I1: Android section6 defines a proposed touch-trigger-to-audible quantity; exact trigger/endpoint boundaries; silent versus known audible signal; synchronized capture/clock calibration and uncertainty; marker continuity/glitch analysis; stepped workload/overload; disruption-to-recovered-marker timing; provisional repetitions/duration; raw capture/configuration/calibration/analysis/failure retention and proposed distributions/tails/outliers/censored trials. Hosting procedure explicitly carries the same method forward. All hypothetical/unperformed/unapproved, no numeric accepted budget or hardware action.
- Security I1: Android section4 separates runtimeOS/targetSDK, declarations/grants/FGS/while-in-use conditions, legacy Bluetooth and BOOT_COMPLETED details using C07/C13/C52–C54. No permissions adopted.
- Security I2: Android hosting appendix inventories pinned C35 core-library and C43/C44 host/plugin-template declarations, recording/FGS/notification/storage/location/Bluetooth/network/backup/exported-component surface and merge/access-control questions; explicitly not protocol/product requirements or R07 clearance.

This mapping is not closure; independent reviewers decide whether all findings close. Same writer completed alignment before this candidate commit. Required source references, exact pinned identities and Apple text remain preserved.

- `docs/research/ANDROID_AUDIO_RESEARCH.md` SHA256 `36442c988fc36fc5b18378e92afadac4135f28978d6d825780b1ed5b87c1eed3`.
- `docs/research/PLUGIN_HOSTING_RESEARCH.md` SHA256 `83bb1eb831dfa33baa4215b30d8cea86a4de1b08bc5a81200b1e34774bf82bc5`.

- `candidate-verification-round1.json` SHA256 `46933d3efd686811c19a40015d4e2b1b0cdad8d405c683aba0cfc47c4413e822`.

## Round1 writer handbacks

Formal correction round 1 complete; writer ownership returned.

Changed only:

- `docs/research/ANDROID_AUDIO_RESEARCH.md`
- Android section of `docs/research/PLUGIN_HOSTING_RESEARCH.md`

Finding mapping:

- QA I1: added an explicitly hypothetical measurement method: touch-trigger-to-audible boundaries; known audible marker distinct from generated/silent callback checks; common-clock electrical/acoustic capture or calibrated clock alignment; uncertainty, marker-based continuity/glitch analysis, stepped overload, recovery boundaries, warm-up/repetition/duration, and retained raw artifacts. The 30-cycle/60-minute values remain provisional.
- Security I1: added runtime-OS versus target-SDK ledger for FGS background start, media playback, microphone/while-in-use, and Bluetooth, including manifest, runtime-grant, and legacy conditions.
- Security I2: added C35/C43/C44 pinned-manifest inventory covering FGS/media/notifications, recording, legacy storage/location/Bluetooth, multicast/network, backup, exported activities/services/view service, merge/access-control, least-privilege, and R07 gaps.

Sources inspected include C52 [`FGS types`](https://developer.android.com/about/versions/14/changes/fgs-types-required), C53 [`background restrictions`](https://developer.android.com/develop/background-work/services/fgs/restrictions-bg-start), C54 [`FGS launch`](https://developer.android.com/develop/background-work/services/fgs/launch), C13, and pinned AAP core `682e7a…e3ec3` C35 / AAP-JUCE `07b990…4b3d4` C43–C44.

Verification passed:

- `git diff --check` against `85fd1ae90b37ecf03032bc6c6028c560c8a36ade`
- Exactly the two owned files changed.
- Apple prefix preserved contiguous; SHA-256 remains `2ebdfae97d82850928a00ac983a358014a1e84cefe2e12a994099ea77ee89c5f`.

No Git/staging/commit/state/evidence/ledger action, device action, permission change, code adoption, or external retrieval occurred. Historic DNS failure remains only historical. Remaining gaps are unperformed runtime/device/measurement results and R07/legal/product decisions.

Round-1 alignment refinements complete; writer ownership returned.

- Legacy Bluetooth: C13 now records target-SDK ≤30 conditions—`BLUETOOTH` for classic/BLE communication, runtime `ACCESS_FINE_LOCATION` for scans, `BLUETOOTH_ADMIN` for discovery/settings, and `ACCESS_BACKGROUND_LOCATION` for discovery by a service that can run on Android 10/11. It explicitly avoids adoption or universal-grant claims.
- `BOOT_COMPLETED`: retained C53’s target-34 general warning; C07’s specific target-35 prohibition for media playback (also data sync/media projection/phone call); and C07’s separate while-in-use microphone restriction without incorrectly assigning it target 35.
- QA raw analysis: added proposed latency distribution/tail/outlier/uncertainty outputs, continuity and recovery summaries, plus retention and separate reporting of invalid/censored trials. All remain hypothetical, unapproved, and unperformed.

Sources used: [C13 Bluetooth permissions](https://developer.android.com/develop/connectivity/bluetooth/bt-permissions), [C07 FGS types](https://developer.android.com/develop/background-work/services/fgs/service-types), [C52 FGS types required](https://developer.android.com/about/versions/14/changes/fgs-types-required), [C53 restrictions](https://developer.android.com/develop/background-work/services/fgs/restrictions-bg-start).

Verification passed:

- `git diff --check` against `85fd1ae90b37ecf03032bc6c6028c560c8a36ade`
- Exactly the two owned reports changed.
- Apple prefix remains contiguous with SHA-256 `2ebdfae97d82850928a00ac983a358014a1e84cefe2e12a994099ea77ee89c5f`.

No Git/staging/commit/shared-state/evidence/ledger, device, permission, dependency, adoption, or external action. Remaining gaps: no runtime/device measurement or R07/product/legal decision.

---

## Historical round0 verification

# R04 verification — candidate for independent review

Candidate `85fd1ae90b37ecf03032bc6c6028c560c8a36ade`; task base `55f9a9651d100007435bb8a4d96fc6eea828ed22`; brief `3f2eb3e9640de11104af4982ce94a695b4ccf4a3`; assignment `d342ce41a2b874f3dea19c2c0866f7c816a15247`; separate In-progress state `fb27f43dedf8e14c94a97ad8a92e4b4d93c6e5da`. OD-006 `c9c0f9349bd69c7bc7b975b78000361f7a8956d4`; contract `eb0d55bc7e10b219996fdb7ab69a546b1e350e3a`. Status pending independent QA/Performance, Licensing/Security then fresh Final review; not Verified. Correction round0.

Writer configured Android Specialist `01a16827-4c1c-7b81-aa06-bb9acccdce41` via independent workspace-write relay `01a16826-d04f-7732-bca3-b6101744e405`. Runtime evidence `d62c0ea95ed1bb107cfbba5a4667b2695911dd8b`; actual session metadata/turn contexts confirm role/model/sandbox. Sole two-report writer handed back before controller commits. Initial draft `439acf5381fd7c14da9eb6fa05b7c95743f16840` remains preserved; same-writer pre-review refinement pinned source identities, API/callback distinctions and traceability. No other writer active.

## Fresh static verification

At `2026-10-23T09:59:15.217593+00:00` UTC (project timezone Asia/Manila), macOS26.6.2(25G83), arm64, Git2.54.0(Apple Git-157), CodexCLI0.154.0-alpha.6.2. Device/emulator/simulator/build/audio/MIDI/sample-rate/buffer/workload: Not applicable. Controller checks, not runtime proof.

```text
git diff --check 55f9a9651d100007435bb8a4d96fc6eea828ed22 85fd1ae90b37ecf03032bc6c6028c560c8a36ade
exit0, no output
git diff --name-only 55f9a9651d100007435bb8a4d96fc6eea828ed22 85fd1ae90b37ecf03032bc6c6028c560c8a36ade
docs/research/ANDROID_AUDIO_RESEARCH.md
docs/research/PLUGIN_HOSTING_RESEARCH.md
git status --porcelain
exit0, empty
```

Exact two-file change; all product/native/manifests/ADRs/configuration/protected paths remain unchanged from task base. Python byte comparison found the entire prior Apple hosting report exactly once as an unchanged contiguous prefix; SHA256 `2ebdfae97d82850928a00ac983a358014a1e84cefe2e12a994099ea77ee89c5f`. All51 raw source bodies rehashed against retained indexes:51matches,0mismatches. Local main remains `b1b0c1edd5e42d3ea791f665c22954834e962d05`; live remote main last observed equal at2026-10-23T09:54:45.509513+00:00 in `baseline-preservation.json`; original root main-guard edit hashes unchanged. No dependency/asset/native permission/license-ledger adoption. No Flutter/build/device/runtime test was run or implied.

## Acceptance coverage to audit

| Brief criterion | Candidate locations / scope |
|---|---|
| 1 exact APIs/repositories/versions | Android identity/source matrices, section1; pinned Oboe/AAP/AAP-JUCE and individual availability; no support baseline |
| 2 requested/actual properties/routes/recovery | Android sections1–3; buffer/mode/rate/device and timestamp limits |
| 3 callback/control/lifetime/errors | Android section2, separate AAudio/Oboe error semantics; hosting lifecycle section; no safety inference |
| 4 lifecycle/focus/services/permissions | Android section4; Android hosting source register and UID/service boundaries; OS vs target-SDK and permission semantics require independent audit |
| 5 AAP protocol/process/UI/state/build | Android hosting appendix; pinned primary docs, concrete unknowns, no AUv3 parity |
| 6 license/data/supply chain | Both reports' licensing sections; exact root license identities and deferred component-specific R07 questions; no clearance |
| 7 source/classification/provenance | Both matrices and explicit fact/inference/recommendation/disagreement/gaps; source catalog and captured body evidence |
| 8 proposed built-in then hosting spikes | Android section6 and hosting experiment; quantities/methods/device categories/budgets unapproved and unperformed |

Coverage map is not an independent passing verdict. Reviewers must read actual sources and candidate text, including target-SDK conditions and proposed measurement sufficiency.

## Source and provenance evidence

Source catalog `r04-sources.md` at `2cb2e951bbcb81acadf0280c8e6fbe06ad7d8579` binds51 HTTP200 bodies, full URLs/hash/access dates and known displayed revision dates. Local originals and indexes under common Git `decision-team-continuation/2026-10-23/r04/primary-sources/`; derived HTML article text has separately bound hashes, original bytes authoritative. Reading original docs/source text is documentary retrieval; no repository clone, archive/project/package installation, code incorporation or execution. Specialist inspected relevant subset, not all51. Original writer DNS failures and historical Oboe commit mistaken for current head remain preserved in draft/transcripts; controller retrieval resolved pinning before review. Source capture is evidence availability, not verification of every claim or runtime behavior.

Raw role snapshots, literal handbacks, baseline-preservation and candidate-verification JSON are retained in the common Git r04 directory. Complete handback below. Review outputs and effective read-only runtime snapshots will be recorded separately. Excluded original main-guard recovery edits remain rejected/unadopted, unrelated to this documentary candidate.

- `docs/research/ANDROID_AUDIO_RESEARCH.md` SHA256 `91f7482203b23f5506fcddcce22545eff4338899ebcc6f201c25637ad729bdf6`.
- `docs/research/PLUGIN_HOSTING_RESEARCH.md` SHA256 `9d3cf1159fdc465cd58aa002a920bfaeff50f1a74a67149c4a1aad06dba9e889`.

- `candidate-verification.json` SHA256 `ef0b29d5aa51eb1184c36634f8fbb0bc4bd5c7aec99dba8018faf3804eb2ff2f`.

## Final writer handback

Consistency cleanup complete; writer ownership returned.

Edits:

- Removed stale “no AAP immutable revision capture” gap.
- Clarified controller provenance: 47 initial plus 4 reconciliation HTTP-200 bodies; this report cites/inspected only its relevant subset, not all 51.
- Linked Oboe error lifecycle directly to pinned C47 [`AudioStreamCallback.h`](https://raw.githubusercontent.com/google/oboe/4468344c8fdfdd7df068d5abefe2d8615fd6b431/include/oboe/AudioStreamCallback.h).
- Added Android hosting-source links and identities: C09 activity lifecycle (2026-10-19), C10 sandbox (2026-09-30), C11 bound services (2026-10-20), C12 permissions (2026-10-16), and pinned AAP-core `682e7a…e3ec3` C30/C31 source texts.

Verification:

- `git diff --check` passed.
- Exactly two owned files are modified.
- Apple prefix is contiguous and preserves SHA-256 `2ebdfae97d82850928a00ac983a358014a1e84cefe2e12a994099ea77ee89c5f`.
- New Android material is 497 lines, within the 500-line cap.

No Git/staging/commit/state/evidence/ledger actions. Historic writer DNS failure remains accurately recorded as resolved by controller capture. Remaining limits are documentary only: no device/runtime/performance/legal-clearance or architecture/adoption conclusion.

## Limits and next action

Separate In-review state barrier, independent QA/Security then Final required. No architecture/engine/minimum OS, dependency/asset, permissions, hardware, runtime/performance, legal conclusion, main integration or successor milestone is approved. Every Critical/Important finding blocks verification/integration and returns to same writer, maximum5 rounds.
