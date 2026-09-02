# Mobile Audio Architecture Candidates

## Status and scope

This report is an M0 documentary comparison for R01. It does not select or
reject an audio architecture, adopt a dependency, approve a license, implement
an audio path, or establish performance on any device. Every candidate remains
subject to a bounded spike, physical-device measurement, licensing review, an
ADR, and owner approval before adoption.

The comparison covers Apple and Android phones and tablets, a possible portable
native DSP/control boundary, Flutter-to-native integration mechanisms, and a
small set of documentary cross-platform candidates. Detailed UAPMD evaluation,
platform plugin hosting, sound formats, and version-specific licensing remain
with R02, R03/R04, R06, and R07 respectively.

## Evidence classification

- **Fact** is supported by a cited primary, official, repository, or maintainer
  source.
- **Inference** connects documented facts but is not itself directly stated by
  a source.
- **Future-evaluation recommendation** proposes later evidence gathering; it is
  not an architecture decision.
- **Disagreement** is reserved for sources that actually conflict. Different API
  boundaries are not presented as disagreement.
- **Missing evidence** is recorded explicitly and is not treated as a negative
  result.
- **Owner decision** identifies a choice that this research cannot authorize.

## Source register

All web sources were accessed on 2026-09-02. Live documentation may change.

| ID | Publisher and source | Version or date status | Access date |
| --- | --- | --- | --- |
| A1 | Apple, [AVAudioEngine](https://developer.apple.com/documentation/avfaudio/avaudioengine) | Live, unversioned; publication date unavailable | 2026-09-02 |
| A2 | Apple, [setPreferredIOBufferDuration(_:)](https://developer.apple.com/documentation/avfaudio/avaudiosession/setpreferrediobufferduration%28_%3A%29) | Live, unversioned; publication date unavailable | 2026-09-02 |
| A3 | Apple, [Responding to audio route changes](https://developer.apple.com/documentation/avfaudio/responding-to-audio-route-changes) | Live, unversioned; publication date unavailable | 2026-09-02 |
| A4 | Apple, [Handling audio interruptions](https://developer.apple.com/documentation/AVFAudio/handling-audio-interruptions) | Live, unversioned; publication date unavailable | 2026-09-02 |
| D1 | Android Developers, [AAudio](https://developer.android.com/ndk/guides/audio/aaudio/aaudio) | Android NDK documentation; last updated 2026-03-06 UTC | 2026-09-02 |
| D2 | Android Developers, [Low latency audio](https://developer.android.com/games/sdk/oboe/low-latency-audio) | Live guidance; last updated 2026-02-26 UTC | 2026-09-02 |
| D3 | Google, [Oboe README at `2a45aa2d9e94d209c4636eec4014dd83cda110f4`](https://github.com/google/oboe/blob/2a45aa2d9e94d209c4636eec4014dd83cda110f4/README.md) | Immutable content commit dated 2026-08-13; not asserted to be a release tag. `1.9.3` was the last release verified before access; the `1.10.0` release record was dated 2026-09-15, after access, and is not used. | 2026-09-02 |
| F1 | Flutter, [Writing custom platform-specific code](https://docs.flutter.dev/platform-integration/platform-channels) | Flutter documentation 3.44.7; updated 2026-08-24; live | 2026-09-02 |
| F2 | Flutter, [Bind to native code using FFI](https://docs.flutter.dev/platform-integration/bind-native-code) | Flutter documentation 3.44.7; updated 2026-06-08; live | 2026-09-02 |
| C1 | JUCE maintainers, [JUCE README at `7aae7d8e8deb8413bb01633d2795ef9974a181c5`](https://github.com/juce-framework/JUCE/blob/7aae7d8e8deb8413bb01633d2795ef9974a181c5/README.md) | Immutable content commit dated 2026-08-20; not asserted to be the `9.0.1` release tag. `9.0.1` was released 2026-08-10. | 2026-09-02 |
| C2 | RustAudio, [CPAL README for `v0.18.2` at `e1612d5d98152f8dc2a62e1b51ef7cbf4f7f26b7`](https://github.com/RustAudio/cpal/blob/e1612d5d98152f8dc2a62e1b51ef7cbf4f7f26b7/README.md) | Immutable `v0.18.2` content dated 2026-08-16. `v0.17.3` dated 2026-02-18 is valid historical evidence but was stale as the current release identity on access. | 2026-09-02 |
| C3 | mackron, [miniaudio README at `9634bedb5b5a2ca38c1ee7108a9358a4e233f14d`](https://github.com/mackron/miniaudio/blob/9634bedb5b5a2ca38c1ee7108a9358a4e233f14d/README.md) | Immutable content commit dated 2026-03-03 with message `Version 0.11.25`; release `0.11.25` dated 2026-03-04. | 2026-09-02 |

Repository controls applied to this report include `ARCHITECTURE.md`,
`docs/architecture/REALTIME_SAFETY.md`, `docs/testing/TEST_STRATEGY.md`, and
`docs/testing/DEVICE_MATRIX.md`, all read from task state
`b8d245683170a3f4961ca89e9cbf3a2d1d4cdfdb` on 2026-09-02.

## Facts: platform-native rendering boundaries

### Apple phones and tablets

Apple documents `AVAudioEngine` as a node graph. Attached nodes form a
processing chain with input, output, and optional main-mixer nodes, and its
default mode renders to a connected device in real time. Apple also warns that
some graph removals while running can break the graph. [A1]

`AVAudioSession` mediates application intent, operating-system behavior, and
audio hardware. Apple directs applications to observe audio-route changes; its
examples include wired headphones, Bluetooth LE headsets, and USB audio
interfaces. [A3] Apple separately directs applications to observe interruption
notifications and inspect interruption-end options before resuming. [A4]

Apple describes `setPreferredIOBufferDuration` as a request, not a guarantee.
The actual `ioBufferDuration` must be inspected, and the I/O-cycle duration is
hardware-dependent. [A2] A requested or reported I/O duration is not an
end-to-end latency result.

These facts apply to Apple platform APIs used by iPhone and iPad applications.
They do not identify supported models or OS versions for AugmentedKeys, and no
iPhone or iPad was operated in R01.

### Android phones and tablets

Android documents AAudio as a C stream API for high-performance audio. It does
not automatically route endpoints, perform file I/O, decode compressed audio,
or combine all streams into one callback; each stream is attached to one audio
device. [D1] This is a different exposed boundary from Apple's node graph.

AAudio supports asynchronous stream-state requests, blocking or non-blocking
read/write, and a higher-priority data callback. Android warns that ordinary
thread preemption and jitter can cause glitches and that increasing buffer size
trades latency for greater protection. [D1]

Android also documents lifecycle constraints: state requests are asynchronous,
waiting for a state change can block, closing while another thread waits is
prohibited, and stream-disconnect handling must not stop or close the stream on
the error-callback thread because that can deadlock. [D1]

The immutable Oboe README identifies Oboe as a C++ library for Android and
states that it chooses OpenSL ES on API 16 and later or AAudio on API 27 and
later. [D3] Google's Android guidance separately describes Oboe's AAudio use on
Android 8.1/API 27 and later and OpenSL ES fallback on earlier supported
versions. [D2] These are documentary API-selection claims, not device or
performance results. Oboe is Android platform adaptation, not evidence of a
cross-platform engine.

These facts apply to Android platform APIs used by phone and tablet
applications. They do not establish behavior on any particular device, Android
build, vendor audio path, or route, and no Android device was operated in R01.

## Facts: Flutter integration mechanisms

Flutter platform channels exchange asynchronous messages between Dart and
platform code, serialize and deserialize values, and require channel method
invocation on the platform main thread. [F1] Flutter documents `dart:ffi` as a
mechanism for calling native APIs and packaging native C sources and bindings;
its current recommended package workflow uses build hooks. [F2]

These are control and integration mechanisms only. Neither source proves that
a platform channel, Dart isolate, or FFI invocation is suitable for a hard
real-time render callback. The project therefore keeps Flutter UI and ordinary
application coordination outside the future native render deadline. No final
message schema, ABI, queue, ownership model, or native language is selected.

## Inference: a possible portable native DSP/control boundary

A portable native core is one candidate boundary, not the selected design. In
that candidate shape:

- Flutter would own UI and ordinary application coordination.
- Platform-specific adapters would own Apple session/route/interruption behavior
  and Android stream/disconnect/reopen behavior.
- A portable native layer could own prepared DSP state and bounded render-time
  processing behind explicit C-compatible or otherwise audited boundaries.
- UI-originated configuration would be prepared on a non-real-time control
  plane, converted to bounded commands or immutable prepared resources, then
  made visible to the render path through a protocol proven by a later spike.
- Render-path counters or preallocated event records would be drained elsewhere;
  the callback would not format or write logs.

This boundary could reduce duplicate DSP work while retaining platform-specific
lifecycle responsibilities. Its costs could include ABI and ownership design,
language/toolchain integration, duplicated platform adapters, debugging across
boundaries, packaging, and additional lifecycle tests. These costs are
inferences to test, not measured outcomes.

## Facts and gaps: documentary cross-platform candidates

At the immutable revision in C1, JUCE identifies itself as a cross-platform C++
application framework for desktop and mobile applications. [C1] The same README
states that it supports Xcode projects for iOS and Android Studio projects for
Android. [C1] It separately describes audio plug-ins and plug-in hosts. [C1]
Those statements do not establish mobile hosting feasibility.

At `v0.18.2` and the immutable revision in C2, CPAL identifies itself as a
low-level Rust audio input/output library. [C2] Its supported-platform list
separately identifies Android/AAudio and iOS/CoreAudio backends. [C2] The prior
`v0.17.3` date of 2026-02-18 remains a valid historical release fact, but it was
stale as the current release identity on the 2026-09-02 access date; this report
therefore binds its CPAL claims to `v0.18.2`.

At the immutable revision in C3, miniaudio identifies itself as a C playback and
capture library. [C3] Its supported-platform list separately names iOS and
Android. [C3]

These are project-identity and stated-platform facts only. They do not establish
mobile latency, callback safety, lifecycle correctness, interruption or route
recovery, Flutter integration, hosting suitability, commercial suitability, or
maintenance fitness. Full immutable content revisions are now recorded for the
audited claims, but that does not establish release-tag equivalence where the
source register says none was asserted. No package or source was downloaded,
built, linked, benchmarked, or adopted.

Desktop capability must not be imported as mobile evidence. In particular,
stated plug-in or host support does not establish that a candidate meets Apple
or Android mobile lifecycle, distribution, or real-time requirements.

## Real-time constraints applied to every candidate

The binding rule is exact: the future audio callback and anything it invokes,
directly or indirectly, must not perform blocking work, I/O, UI work, parsing,
allocation, arbitrary lock waiting, or potentially blocking logging. The current
rule permits no exception for bounded allocation or nonblocking I/O. Any narrower
rule requires later evidence-backed approval through the project's decision
process.

Android's low-latency guidance independently warns against allocation/freeing,
file/network I/O, waiting on locks, sleeping, and heavy one-time CPU work in an
audio callback. [D2] This agreement does not prove any candidate safe; complete
call-graph, lifecycle, overload, and device evidence would still be required.

## Questions a bounded spike must answer

### Transfer and overload

- What is the fixed capacity of every command, event, and telemetry path?
- What happens when a producer outruns the callback or a consumer falls behind:
  reject newest, replace stale state, drop oldest, coalesce, or enter a declared
  safe state?
- Are ordering, visibility, and sequence gaps observable without callback-side
  blocking or log formatting?
- What workload bound covers the maximum approved layer, voice, routing, and
  effects configuration?

### Ownership and prepare/swap/retire

- Which thread allocates, prepares, validates, and destroys each graph, buffer,
  sample, and configuration object?
- How does prepared state become callback-visible atomically without exposing a
  partial object?
- How is replaced state retired only after no callback can reference it?
- Can the callback release a last reference, run a destructor/finalizer, wait
  for reclamation, or encounter an exhausted preallocated pool?

### Lifecycle and errors

- On Apple, what happens for repeated interruption begin/end, route changes,
  missing prior routes, graph replacement, backgrounding, restart, and partial
  initialization? [A1][A3][A4]
- On Android, what happens for asynchronous state changes, disconnect, reopen,
  device replacement, callback error handling, repeated start/stop, and close
  ordering? [D1]
- Can any error or shutdown path free callback-visible memory, wait on the
  callback, close from a prohibited thread, or block indefinitely?
- What safe audible behavior occurs under overload, starvation, missing data,
  deadline misses, underruns, and recovery?

### Measurement and observability

- Can callback duration, deadline misses, underruns, queue occupancy, event
  drops, and recovery be captured through bounded counters outside the callback?
- Which platform traces or counters corroborate the in-process evidence without
  changing the behavior being measured?
- Can the same declared workload and lifecycle sequence be reproduced across
  required Apple and Android device categories and routes?

## Candidate-to-evidence gap matrix

| Candidate or boundary | Documentary evidence | Portability or lifecycle cost to investigate | Required future evidence |
| --- | --- | --- | --- |
| Apple `AVAudioEngine` plus `AVAudioSession` | Node graph; route and interruption notification model; preferred versus actual I/O duration. [A1][A2][A3][A4] | Apple-specific graph, session, route, and interruption adapter | Physical-device lifecycle, graph replacement, route-specific latency, callback ownership, shutdown, overload |
| Android AAudio | Stream/callback model; asynchronous lifecycle; disconnect constraints; buffer trade-off. [D1] | Android-specific device, state, disconnect, and reopen adapter | Device/build/route variation, underruns, reconfiguration, end-to-end latency, lifecycle recovery |
| Android Oboe | Immutable README identifies Android C++ scope and API 16+ OpenSL ES/API 27+ AAudio selection. [D3] | Android-only abstraction and version/device behavior | Device behavior, callback/lifecycle audit, release/tag resolution if needed, license review |
| Flutter platform channels | Asynchronous serialized control integration on the platform main thread. [F1] | Message schema, copying/serialization, ordering, backpressure, lifecycle handoff | Proof that render-time traffic never depends on the channel; bounded control protocol |
| Flutter FFI | Native API and C-binding integration mechanism. [F2] | ABI, memory ownership, threading, packaging, error propagation | Audited call boundary and lifetime protocol; no assumption of callback suitability |
| Portable native DSP/control core | Inferred candidate boundary; no implementation exists | ABI/language/toolchain plus separate Apple and Android adapters | Bounded queues, prepare/swap/retire, full callback call graph, lifecycle and device benchmarks |
| JUCE | Immutable README states cross-platform C++, mobile project outputs, and plug-in/host scope. [C1] | Framework breadth, mobile adapters, packaging, update and hosting surface | Mobile render/lifecycle/Flutter evidence, mobile-host feasibility, version-specific license review |
| CPAL `v0.18.2` | Immutable README states low-level Rust I/O and Android/AAudio and iOS/CoreAudio backends. [C2] | Rust FFI/toolchain and platform lifecycle coverage | Callback/lifecycle audit, mobile device evidence, version-specific license review |
| miniaudio `0.11.25` content | Immutable README states C playback/capture and iOS/Android support. [C3] | Backend selection, session/routing integration, ownership | Callback/lifecycle audit, device evidence, version-specific license review |

## Risks

- **Evidence overreach:** Repository support statements can be mistaken for
  product suitability or measured performance.
- **Platform flattening:** An abstraction can hide materially different Apple
  graph/session and Android stream/lifecycle responsibilities.
- **Real-time leakage:** Convenience APIs, destructors, logging, control traffic,
  or hidden library behavior can introduce allocation, locks, or I/O into the
  render path.
- **Lifecycle invalidation:** Route, interruption, disconnect, restart, and
  shutdown paths can invalidate callback-visible state or deadlock cleanup.
- **Device and route variation:** Built-in, wired/USB, and wireless behavior can
  vary by exact device and OS; documentary support cannot establish performance.
- **Revision drift:** Live documentation and moving repository branches can
  change after the recorded access date.
- **Licensing and distribution:** No candidate version has passed the license
  ledger or distribution review.

## Future-evaluation recommendations

1. Define one narrow, reversible, owner-approved spike that exercises the same
   bounded control transfer, prepared-state replacement, overload, and repeated
   lifecycle scenarios behind each candidate boundary.
2. Freeze exact candidate versions or repository SHAs before reviewing code,
   licenses, callback call graphs, packaging, or measurements.
3. Keep Apple and Android lifecycle adapters independently observable and tested
   even if a portable DSP core is evaluated.
4. Use the procedure proposed in `LOW_LATENCY_RESEARCH.md`; approve exact
   hardware, routes, workloads, and numeric budgets before execution.
5. Require callback call-graph review, deterministic ownership/queue tests, and
   relevant physical-device evidence before an ADR can adopt a candidate.

These recommendations identify future evaluation work only.

## Disagreement

No direct source contradiction was established. Apple exposes a node graph and
session model, while Android exposes streams/callbacks and deliberately omits
some automatic presentation behavior. [A1][D1] They describe different platform
boundaries rather than conflicting facts.

## Missing evidence and open questions

- Direct Apple pages for `inputLatency`, `outputLatency`, `start()`, and `stop()`
  were available to the Researcher only as JavaScript-required shells; their
  detailed current content was not treated as verified.
- Full immutable content SHAs are recorded for the audited Oboe, JUCE, CPAL,
  and miniaudio claims. Oboe and JUCE release-tag-to-content equivalence was not
  established and is not asserted.
- No complete callback call graph, code audit, package, build, spike, simulator,
  emulator, physical-device run, controller, audio interface, trace, or benchmark
  exists for R01.
- No exact device model, supported OS range, route commitment, maximum workload,
  measurement instrument, or numeric acceptance budget is approved.
- No candidate has a version-specific license, commercial-use, redistribution,
  attribution, privacy, permission, or supply-chain conclusion.
- Route-specific behavior for built-in, wired/USB, and wireless paths remains
  unknown until measured on declared hardware.

## Owner decisions required before further action

The owner retains decisions on architecture inclusion or rejection, ADR scope,
portable-core language and ABI, dependency or SDK adoption, exact candidate
versions, hardware/controllers/interfaces, supported devices and OS versions,
routes, workloads, measurement methods, numeric acceptance budgets, and any
licensing or distribution action. R01 authorizes none of them.
