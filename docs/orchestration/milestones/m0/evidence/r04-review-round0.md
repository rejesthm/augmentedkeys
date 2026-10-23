# R04 independent review round0

Candidate `85fd1ae90b37ecf03032bc6c6028c560c8a36ade`, verification `3e571870622fdc8501df2d239a52fc8caa973753`, In-review state `6647fdeab154929735ce1d5c47e3830d094c1d62`, task base `55f9a9651d100007435bb8a4d96fc6eea828ed22`. Date2026-10-23. Both independent reviews REJECT; QA0Critical/1Important/0Minor, Security0Critical/2Important/0Minor. All3 findings retained; no Final review or integration. No candidate mutation during reviews.

QA relay `01a16834-0b4b-7190-82b9-4c5f6ee12ba7`, child `01a16834-4222-7e43-b1f5-6a3c439280eb`. Security relay `01a16834-0fcb-7732-a416-e0b934b5bf11`, child `01a16834-5a7d-72a1-aa47-30cc726da361`. Independent same-permission read-only sessions, both configured children sol/high; saved source metadata and actual turn contexts verified read-only. No nested writer/reviewer topology. Source bodies and candidate hashes unchanged.

Common Git raw `decision-team-continuation/2026-10-23/r04/` retains full relay/child snapshots, launch prompts, runtime JSON and literal replies. Security relay requested a follow-up UUID-only message after the actual review; latest completion is that identifier-only response, not the review. Canonical Security report below is exactly zero-based row322 task_complete at2026-10-23T10:07:27.738Z in `security-round0-child.jsonl`; row333 UUID-only follow-up is separately retained. No paraphrase substituted for review. QA latest completion is its full review.

- `qa-round0-runtime.json` SHA256 `593ab0536bdbed1869d48616f463d951bbe44e25788ae3fa1dfb744dedf6c206`.
- `qa-round0.final.txt` SHA256 `962096109ed4b4d3feaa7f58883f966c4a20b459f53761562060b1df97ebb0f4`.
- `security-round0-runtime.json` SHA256 `3d2fb0cb771ca7ecf2319d53bc770f5878b460568348e220b3f1265bba18bd60`.
- `security-round0-review.final.txt` SHA256 `e32e42feb2853dec738e8226e83fdd6131c33a9b4a0b3c87757108a254ed3287`.

## QA literal review

## R04 QA/Performance documentary review

**Child UUID:** `01a16834-4222-7e43-b1f5-6a3c439280eb`  
**Candidate:** `85fd1ae90b37ecf03032bc6c6028c560c8a36ade`  
**Verdict:** **REJECT**  
**Findings:** 0 Critical / 1 Important / 0 Minor

### Important finding

**I1 — Criterion 8 lacks a defined latency, continuity, and overload measurement method.**

[ANDROID_AUDIO_RESEARCH.md](/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-r04-android-audio/docs/research/ANDROID_AUDIO_RESEARCH.md:241) proposes callback timing/counters, lifecycle cycles, and a 60-minute run, but never defines a latency quantity with exact start/end boundaries, acquisition/calibration/clock method, or raw sample analysis. At line 249, “audible continuity observation method” is merely a field to capture later; at line 254, “overload stimulus” is similarly undeclared. The proposed “generated/silent” path at line 232 cannot by itself establish audible continuity or output latency. The hosting plan in [PLUGIN_HOSTING_RESEARCH.md](/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-r04-android-audio/docs/research/PLUGIN_HOSTING_RESEARCH.md:487) likewise records callback counters but supplies no latency/continuity acquisition method.

This fails brief criterion 8’s requirement to **define** latency, continuity, overload, disconnection/recovery, and long-run methods. Leaving numeric budgets, hardware, and execution unapproved is correct; leaving the measurement boundaries and method undefined is not.

**Required correction:** Explicitly carry forward and specialize the R01 measurement rules: select a proposed latency quantity and exact boundaries; define synchronized electrical/acoustic capture or loopback, calibration/clock alignment and uncertainty; define continuity/glitch detection; define workload and overload escalation; define recovery start/end events; and state warm-up, repetitions/duration, retained raw artifacts, and analysis outputs. Keep all execution and numeric budgets unapproved.

### Criterion coverage

1. **PASS:** Current official Android/NDK and original repositories; pinned Oboe/AAP/AAP-JUCE revisions, Oboe release identity, access date, moving-source limits, AAudio/Oboe/OpenSL ES availability distinctions.
2. **PASS:** Requested versus observed configuration, hardware conversion properties, buffers/bursts, modes, devices, disconnection/reopen, and timestamp limitations.
3. **PASS:** Callback prohibitions, Flutter exclusion, control-plane ownership, AAudio/Oboe error sequencing, lifetimes, shutdown, and clock questions.
4. **PASS:** Activity/process lifecycle, focus, target-SDK conditions, foreground/background services, USB/Bluetooth, recording permission, and deferred background policy.
5. **PASS:** AAP/AAP-JUCE package/service/process/IPC/shared-memory/state/UI/MIDI/render/toolchain boundaries and instability; no AUv3 parity or process-isolation safety inference.
6. **PASS:** Version-bound root license identities and adoption-only transitive, redistribution, privacy, and supply-chain questions.
7. **PASS:** Claim/source matrices, classifications, provenance limitations, and built-in-before-hosting priority.
8. **FAIL:** Smallest-spike ordering and unresolved budgets are present, but required measurement methods are incomplete as described in I1.

### Fresh command evidence

On macOS 26.6.2 (25G83), arm64, Git 2.54.0, 2026-10-23T18:06:46+0800:

- `git rev-parse HEAD` → exact candidate.
- `git status --porcelain=v1` → empty.
- `git diff --check <base> <candidate>` → exit 0, no output.
- `git diff --name-status` → only new `ANDROID_AUDIO_RESEARCH.md` and modified `PLUGIN_HOSTING_RESEARCH.md`.
- Numstat → 306 + 191 = 497 added lines.
- Base is an ancestor of candidate.
- Apple blob SHA-256 → `2ebdfae97d82850928a00ac983a358014a1e84cefe2e12a994099ea77ee89c5f`; byte-prefix `cmp` passed for all 24,521 bytes.
- Candidate report hashes match verification: Android `91f748…bdf6`; hosting `9d3cf1…e889`.
- All 51 authoritative raw bodies and 14 derived article files rehashed successfully; zero non-200 indexed responses.

No Flutter, build, emulator, simulator, device, audio/MIDI, profiling, latency, or long-run execution was applicable or run.

### Source checks and context

Independently checked C02/C05, C06–C14, C15–C18, C22–C26, C30/C31, and C45/C47–C50 for stream negotiation, API availability, callback/error semantics, target-SDK rules, lifecycle, Oboe identity, and AAP boundaries. Claims checked were source-supported.

Read current required app/state records at In-review state `6647fdeab154929735ce1d5c47e3830d094c1d62`, accepted contract `eb0d55bc7e10b219996fdb7ab69a546b1e350e3a`, OD-006, brief `3f2eb3e…`, assignment `d342ce4…`, runtime `d62c0ea…`, source catalog `2cb2e95…`, and verification `3e57187…`. Historical Eligible/CT01/paused headings were not treated as current.

**Next action:** Return I1 to the same Android Specialist for a bounded criterion-8 correction, then rerun affected verification and fresh independent review.

## Security literal review

REJECT — exact candidate `85fd1ae90b37ecf03032bc6c6028c560c8a36ade` from base `55f9a9651d100007435bb8a4d96fc6eea828ed22`.

Critical: 0  
Important: 2  
Minor: 0

## Important findings

1. `docs/research/ANDROID_AUDIO_RESEARCH.md:183-200` conflates device OS/API levels with target-SDK-triggered behavior.

   The report correctly qualifies Android 15 audio-focus behavior as target-35-dependent, but then describes foreground-service declarations and Bluetooth permissions primarily as “Android 14/API 34+” and “Android 12/API 31+.” Preserved sources distinguish these conditions: C07 ties Play foreground-service declarations to apps targeting Android 14+, while C13 says the new Bluetooth declarations apply when the app targets Android 12+, alongside runtime OS availability. This distinction is explicitly required by the review brief and affects permission and lifecycle design.

   Action: state separately for each rule the device OS requirement, target SDK threshold, manifest declaration, runtime grant, foreground/background prerequisite, and legacy behavior.

2. `docs/research/PLUGIN_HOSTING_RESEARCH.md:438-470` does not characterize the material permission, storage, backup, networking, and exported-service surface present in the pinned AAP/AAP-JUCE manifests.

   The appendix records generic future questions, but inspected source bodies show concrete upstream declarations:

   - C35 adds foreground-service, media-playback foreground-service, and notification permissions to the AAP core Android library manifest.
   - C43’s host template declares recording, legacy external storage, location/Bluetooth, multicast, Internet, backup, and exported activity behavior.
   - C44’s plugin template additionally exposes plugin and view services, requests recording and foreground-service permissions, enables backup, and carries legacy storage/location/Bluetooth/Internet declarations.

   These are not necessarily product requirements and must not be adopted wholesale, but omitting them understates the actual inspected security/privacy and manifest-merging surface.

   Action: add a source-backed manifest inventory distinguishing library/template defaults from protocol requirements; identify target-SDK applicability, exported-component access-control questions, backup/state exposure, least-privilege removals, and which declarations require separate adoption.

## Coverage

Criteria 1–3 and 7–8 are adequately covered. Criteria 4–6 remain incomplete because of the two findings above. Root license identities were independently confirmed: Oboe Apache-2.0, AAP core MIT, and AAP-JUCE AGPLv3. The reports correctly avoid legal clearance and defer JUCE version, patches, copied components, transitives, notices, commercial implications, redistribution, and component-specific review to R07.

## Evidence and context

Read the required app/control documents, brief `3f2eb3e9640de11104af4982ce94a695b4ccf4a3`, assignment `d342ce41a2b874f3dea19c2c0866f7c816a15247`, accepted contract `eb0d55bc7e10b219996fdb7ab69a546b1e350e3a`, OD-006 `c9c0f9349bd69c7bc7b975b78000361f7a8956d4`, current In-review state `6647fdeab154929735ce1d5c47e3830d094c1d62`, verification `3e571870622fdc8501df2d239a52fc8caa973753`, source catalog `2cb2e951bbcb81acadf0280c8e6fbe06ad7d8579`, runtime evidence `d62c0ea95ed1bb107cfbba5a4667b2695911dd8b`, complete two-file diff, license ledger, dependency manifests, platform manifests, and relevant primary bodies.

Fresh read-only checks:

- `git diff --check`: pass.
- Scope: exactly the two contracted reports; 497 insertions.
- Protected-path changes: none.
- Worktree: clean.
- Apple prefix: contiguous and SHA-256 `2ebdfae97d82850928a00ac983a358014a1e84cefe2e12a994099ea77ee89c5f`.
- Primary bodies: 51 checked; 0 hash/status/size mismatches.
- Secret scan: no matches.
- No dependency, asset, permission, license-ledger, product, or native configuration change.

Limitations: documentary review only; no build, device, runtime, performance, adoption, distribution, or legal conclusion. Effective filesystem sandbox was read-only; no writes, Git mutation, external messaging, or further agents occurred.

Next action: return both findings to the same Android writer for one bounded correction, then rerun affected source/scope checks and fresh independent review.
