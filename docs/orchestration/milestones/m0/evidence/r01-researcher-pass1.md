# R01 Researcher Pass 1 Evidence

Status: `Unreviewed specialist evidence; candidate not created`
Date: 2026-09-02 (Asia/Manila)
Handoff target: configured Conductor `/root/r01_conductor_v2`

## Source-backed dispatch provenance

- Top-level relay ID: `01a06002-c72f-7381-b490-5c346dc7b6e1`
- Relay effective sandbox: `read-only`
- Relay rollout: `/Users/jestherjordanminor/.codex/sessions/2026/09/02/rollout-2026-09-02T10-46-29-01a06002-c72f-7381-b490-5c346dc7b6e1.jsonl`
- Relay rollout SHA-256 / lines: `510e2fb37a386189bfd257cb48c69ab399ca9a3acac11317d4838e0653701535` / 81
- Configured child ID: `01a06003-2761-74d2-a3a9-3effc86d82df`
- Configured child role: `researcher`; nickname `Hypatia`
- Child runtime: `gpt-5.6-terra`; reasoning `high`; effective sandbox `read-only`
- Child project root: `/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-r01-audio-architecture`
- Child rollout: `/Users/jestherjordanminor/.codex/sessions/2026/09/02/rollout-2026-09-02T10-46-54-01a06003-2761-74d2-a3a9-3effc86d82df.jsonl`
- Child rollout SHA-256 / lines: `14fea53e162ac315790366013d894c3155f3659099d9dbffe0443b3962534760` / 118
- Child call inventory: 14 read-only `exec` orchestration calls; no edit, patch, commit, nested dispatch, publication, installation, hardware, permission-change or external-mutation call
- Repository result: task and milestone worktrees remained clean; no candidate or verification artifact was created by this specialist

## Preserved configured Researcher final reply

The content below preserves the complete reply; the raw rollout and its SHA-256 above are authoritative for byte-level formatting.

R01 PASS-1 RESEARCHER EVIDENCE — NON-ADOPTING, DOCUMENTARY ONLY

## Scope confirmation

R01 is active under the recorded corrected contract, eligibility, writer assignment, state barrier, and Conductor runtime evidence. This pass is read-only public-source research; it creates no candidate, makes no architecture choice, and reports no device, simulator, benchmark, compatibility, continuity, callback-safety, or latency result. [P01]

## Source register

| ID | Publisher / title | URL | Version / date status | Access |
|---|---|---|---|---|
| P01 | AugmentedKeys governing task evidence and controls | Local: `r01-brief.md` @ `b50e58e`; contract @ `13b864f`; eligibility @ `fa7091e`; assignment @ `f7b7388`; state @ `d1da638`; runtime @ `1e3af70` | Immutable repository commits; current task controls | 2026-09-02 |
| P02 | AugmentedKeys real-time, testing, device, and license controls | Local: `ARCHITECTURE.md`, `docs/architecture/REALTIME_SAFETY.md`, `docs/testing/TEST_STRATEGY.md`, `docs/testing/DEVICE_MATRIX.md`, `docs/research/LICENSE_LEDGER.md` | Local baseline; not performance evidence | 2026-09-02 |
| S01 | Apple — *AVAudioEngine* | [URL](https://developer.apple.com/documentation/avfaudio/avaudioengine) | Live, unversioned; publication date unavailable | 2026-09-02 |
| S02 | Apple — *setPreferredIOBufferDuration(_:)* | [URL](https://developer.apple.com/documentation/avfaudio/avaudiosession/setpreferrediobufferduration%28_%3A%29) | Live, unversioned; publication date unavailable | 2026-09-02 |
| S03 | Apple — *Responding to audio route changes* | [URL](https://developer.apple.com/documentation/avfaudio/responding-to-audio-route-changes) | Live, unversioned; publication date unavailable | 2026-09-02 |
| S04 | Apple — *Handling audio interruptions* | [URL](https://developer.apple.com/documentation/AVFAudio/handling-audio-interruptions) | Live, unversioned; publication date unavailable | 2026-09-02 |
| S05 | Android Developers — *AAudio* | [URL](https://developer.android.com/ndk/guides/audio/aaudio/aaudio) | Android NDK; last updated 2026-03-06 UTC | 2026-09-02 |
| S06 | Android Developers — *Low latency audio* | [URL](https://developer.android.com/games/sdk/oboe/low-latency-audio) | Live guidance; last updated 2026-02-26 UTC | 2026-09-02 |
| S07 | Android Developers — *Audio latency* | [URL](https://developer.android.com/ndk/guides/audio/audio-latency) | Live guidance; last updated 2024-01-03 UTC | 2026-09-02 |
| S08 | Android Open Source Project — *Measure audio latency* | [URL](https://source.android.com/docs/core/audio/latency/measure) | Live guidance; last updated 2026-06-17 UTC | 2026-09-02 |
| S09 | Flutter — *Writing custom platform-specific code* | [URL](https://docs.flutter.dev/platform-integration/platform-channels) | Flutter docs 3.44.7; updated 2026-08-24; live | 2026-09-02 |
| S10 | Flutter — *Bind to native code using FFI* | [URL](https://docs.flutter.dev/platform-integration/bind-native-code) | Flutter docs 3.44.7; updated 2026-06-08; live | 2026-09-02 |
| S11 | JUCE maintainers — repository README | [URL](https://github.com/juce-framework/JUCE/blob/master/README.md) | Moving `master`; exact SHA not captured | 2026-09-02 |
| S12 | RustAudio — CPAL repository README | [URL](https://github.com/RustAudio/cpal) | Moving `master`; repository listing reported CPAL 0.17.3 (2026-02-18) | 2026-09-02 |
| S13 | mackron — miniaudio repository README | [URL](https://github.com/mackron/miniaudio) | Moving `master`; exact SHA not captured | 2026-09-02 |
| S14 | Google — Oboe repository README | [URL](https://github.com/google/oboe) | Moving `main`; repository listing reported 1.10.0 (2025-09-15) | 2026-09-02 |

## Apple documentary facts

- `AVAudioEngine` is an Apple node graph: attached nodes form a processing chain, with input, output, and optional main-mixer nodes; its default mode renders to a connected device in real time. The documentation also warns that some runtime graph removals can break a graph. [S01]
- `AVAudioSession` mediates between app intent, OS behavior, and audio hardware. Apple directs apps to observe route-change notifications; its examples include wired headphones, Bluetooth LE headsets, and USB audio interfaces. [S03]
- Apple directs apps to observe interruption notifications and inspect the interruption end options before resuming. [S04]
- `setPreferredIOBufferDuration` requests, rather than guarantees, an I/O duration; Apple directs callers to inspect the actual `ioBufferDuration`. It defines this duration as one input/output I/O cycle and notes hardware dependence. [S02]

## Android documentary facts

- AAudio is a C stream API for high-performance audio. It deliberately does not provide automatic endpoint routing, file I/O, compressed decoding, or automatic presentation of all streams in one callback; each stream is attached to one audio device. This is materially different from Apple’s exposed node-graph model. [S05]
- AAudio supports asynchronous stream state requests, blocking or non-blocking read/write, and a higher-priority data callback. Android documents that ordinary-thread preemption/jitter can cause glitches and that larger buffers trade latency for protection. [S05]
- AAudio documentation requires lifecycle coordination: state requests are asynchronous; waiting for state changes can block; closing while another thread waits is prohibited; and stream-disconnect handling must avoid stopping/closing on the error-callback thread because that can deadlock. [S05]
- Google documents Oboe as an Android C++ wrapper that uses AAudio on Android 8.1/API 27+ and OpenSL ES on earlier supported versions. This is Android-only platform adaptation, not cross-platform engine evidence. [S06][S14]

## Flutter/native boundary facts

- Flutter platform channels exchange asynchronous messages between Dart and platform code, use automatic serialization/deserialization, and require a channel method invocation on the platform main thread. [S09]
- Flutter documents `dart:ffi` as a means to call native APIs and package native C sources/bindings; its current recommended package workflow uses build hooks. [S10]
- These facts establish integration mechanisms only. They do not establish a Flutter platform channel, Dart isolate, or FFI call as appropriate for an unmeasured hard-real-time callback. That boundary remains governed by the project’s stricter callback baseline. [P02][S09][S10]

## Portable and cross-platform candidate facts

- JUCE identifies itself as a cross-platform C++ application framework with mobile targets and audio plug-in/host capabilities; its README names Xcode/iOS and Android Studio project outputs. [S11]
- CPAL identifies itself as a low-level Rust audio I/O library; its repository documents AAudio for Android and CoreAudio for iOS. [S12]
- miniaudio identifies itself as a C playback/capture library and lists iOS and Android among supported platforms. [S13]
- These are identity and stated-platform facts only. No candidate’s latency, callback behavior, interruption recovery, lifecycle correctness, Flutter integration, commercial suitability, or hosting suitability was tested or established here. [P01][P02]

## Real-time and lifecycle evidence

- The project baseline prohibits blocking, I/O, UI work, parsing, allocation/deallocation pressure, arbitrary lock waits, and potentially blocking logging in the future audio callback. It requires bounded work, external preparation, explicit ownership, and safe overload degradation. [P02]
- Android’s low-latency guidance independently warns against allocation/freeing, file/network I/O, waiting on locks, sleep, and heavy one-time CPU work in a callback. [S06]
- Apple documents graph mutation limits, session interruption notices, and route-change notices, but the accessed material does not prove a complete safe prepare/swap/retire protocol for this product. [S01][S03][S04]
- Future questions: bounded command/event transfer; producer-overrun policy; callback-visible ownership; preparation outside the callback; atomicity and retirement of replacement resources; repeated start/stop; route/interruption recovery; Android disconnect/reopen behavior; overload/underrun behavior; and shutdown ordering. [P02][S05]

## Latency and future-measurement evidence

- Android defines output latency as app-generated sample to playback, input latency as received signal to app availability, round trip as input + app processing + output, and touch latency as touch to app receipt. [S07]
- For this project, “touch/MIDI-to-audible” should be a separately measured end-to-end quantity from touch or MIDI ingress to a declared acoustic or electrical output boundary. “Software scheduling/queue contribution” should be a separately instrumented segment within that path. Neither quantity is supplied by an audio round-trip measurement alone. This is a measurement definition, not an observed result.
- Android states that isolated input/output latency is difficult to measure and that round-trip latency varies by device model and Android build. AOSP describes an output-to-input loopback method using synchronized full-duplex capture and correlation. [S07][S08]
- `frames / sampleRate` is only nominal buffer duration. AAudio’s burst and buffer values, and Apple’s I/O-cycle duration, do not by themselves measure total, touch/MIDI-to-audible, or round-trip latency. [S02][S05]
- No procedure, hardware, owner-approved numeric budget, calibration, run, raw artifact, or result exists for the required Apple/iPad, iPhone, Android phone, or Android tablet categories. [P02]

## Candidate-to-evidence gap matrix

| Candidate / boundary | Documentary evidence | Future evidence gap |
|---|---|---|
| Apple `AVAudioEngine` + session | Node graph, route and interruption notification model, preferred-vs-actual I/O duration. [S01][S02][S03][S04] | Real-device lifecycle, graph replacement, route-specific latency, callback ownership, shutdown, overload. |
| Android AAudio | Stream/callback model, buffer trade-off, asynchronous lifecycle, disconnect coordination. [S05] | Device/build/route-specific behavior, underruns, reopen/reconfiguration, end-to-end latency. |
| Oboe | Android API wrapper/fallback identity and low-latency guidance. [S06][S14] | Version-specific behavior, device quirks, lifecycle outcomes, licensing review. |
| Flutter platform channels / FFI | Native integration and packaging paths. [S09][S10] | Bounded control-transfer design; proof that no render-time traffic crosses the boundary. |
| JUCE | Cross-platform C++ and stated mobile/hosting scope. [S11] | Mobile render/lifecycle/Flutter evidence; version-specific license and hosting assessment. |
| CPAL | Low-level cross-platform I/O identity; stated iOS/Android backends. [S12] | Mobile lifecycle, real-time, FFI, latency, and licensing evidence. |
| miniaudio | C playback/capture identity; stated iOS/Android support. [S13] | Backend selection, lifecycle, rendering/control model, latency, and licensing evidence. |

## Future bounded-spike questions

- Can a portable native DSP/control surface keep UI-originated commands bounded, ordered, observable, and outside the render deadline?
- Can prepared resources be exposed, replaced, and retired without callback-visible invalidation, allocation, lock waiting, or cleanup on the render path?
- Can Apple route/interruption transitions and Android disconnect/reopen transitions preserve a defined safe state under repeated and partial lifecycle events?
- Under declared maximum workload, which callback-duration, deadline-miss, underrun, event-drop, CPU, memory, thermal, and recovery counters can be captured outside the callback?
- For each built-in, wired/USB, and wireless route, what exact endpoint and instrumentation define touch/MIDI-to-audible, output, and round-trip latency?

## Inferences

- A portable DSP core, if later pursued, would still need platform-specific session/route/lifecycle adapters because the documented Apple graph/session model and Android stream model expose different responsibilities. This is an inference from the documented API shapes, not a selection. [S01][S03][S05]
- Flutter channels are better treated as ordinary control/integration traffic than render-time transport because they serialize data and invoke platform-channel methods on the main thread. This is an inference, not proof of unsuitability under every design. [S09]

## Recommendations for future evaluation

- Define an owner-approved physical-device spike before choosing among native, shared-native, or candidate-engine approaches; include one bounded lifecycle and overload scenario per platform.
- Predeclare measurement boundaries, calibration/error handling, repetitions, warm-up, run duration, raw-artifact retention, and numeric acceptance budgets before interpreting results. [P02][S08]
- Keep candidate versions/revisions and any dependency adoption behind the license ledger review; this pass does not assess or approve any candidate license. [P02]

## Disagreements

- No direct contradiction was found. Apple documents a node-graph/session model, while Android documents streams/callbacks and intentionally omits graph-like automatic presentation; these describe different platform boundaries, not conflicting facts. [S01][S05]

## Missing or unavailable evidence

- Apple’s direct `inputLatency`, `outputLatency`, `start()`, and `stop()` pages were reachable only as JavaScript-required shells in this read-only retrieval; their detailed current content was not treated as verified.
- No public documentation substitutes for product-specific physical-device measurements across the required device categories and route types. [P02]
- No exact immutable SHA was captured for the moving JUCE, CPAL, miniaudio, or Oboe repository branches; no version-specific licensing conclusion exists. [P02][S11][S12][S13][S14]

## Owner-gated questions

- Architecture selection or rejection; any ADR; dependency/asset adoption; a portable-engine language choice; required hardware/controllers/interfaces; exact supported devices/OSes; measurement budgets; and route-specific product commitments require owner-gated follow-up. [P01][P02]

## Limitations

This is documentary research only, based on public primary/maintainer material accessed 2026-09-02. Live documentation may change. No historical unreviewed repository notes were used as evidence, and no experiment, installation, device operation, benchmark, package adoption, or licensing decision occurred.
