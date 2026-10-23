# iOS/iPadOS audio-session and engine research

**Status:** R03 documentary research; not an ADR, implementation approval, or
performance result. **Access date:** 2026-10-23 (Asia/Manila). This report was
prepared from public Apple primary documentation retrieved through its public
developer site. No device, simulator, SDK, sample, or audio route was operated.

## Scope and decision boundary

The future product’s first playable scope is offline built-in piano/pad/synth
playback and session/lifecycle handling. Third-party hosting is later scope and
is isolated in `PLUGIN_HOSTING_RESEARCH.md`. AVAudioEngine, lower-level Audio
Unit/Core Audio, category/mode/options, minimum OS, background capability,
entitlements, and engine ownership are **not selected** here.

## API availability is not a product baseline

The following is transcribed from the controller’s preserved Apple Markdown
metadata, not a support decision. `iPadOS` availability did not exist as a
separate platform name before iPadOS; it is shown exactly where Apple’s current
metadata supplies it. A dash/absent metadata field is **unknown**, never an
inferred minimum. The project has selected no minimum OS.

| API / sample | iOS | iPadOS | Other metadata relevant here | Source record |
| --- | ---: | ---: | --- | --- |
| `AVAudioSession` | 3.0 | 3.0 | macCatalyst 13.1 | S1 / controller source 01 |
| `AVAudioEngine` and `prepare()` | 8.0 | 8.0 | macCatalyst 13.1 | S6 / sources 07–08 |
| Apple hosting sample | 13.0 | Unknown | macCatalyst 13.0; macOS 10.15; Xcode 16.0 | P1 / source 12 |

Availability means only that Apple’s current documentation metadata lists the
symbol/sample for that platform/version. It does not establish route support,
usable latency, third-party component availability, toolchain choice, or a
product support commitment.

## Claim/source matrix

| ID | Fact (not a product claim) | Primary Apple source / retrieval | Availability / limitation |
| --- | --- | --- | --- |
| S1 | `AVAudioSession` is the app’s singleton intermediary for category, mode, options, activation, routing, and hardware properties. | [AVAudioSession](https://developer.apple.com/documentation/avfaudio/avaudiosession) — public API reference, retrieved 2026-10-23 | Current iOS/iPadOS reference; no product support baseline chosen. |
| S2 | Preferred sample rate and I/O duration are requests; activated-session values must be checked as actual values. | [QA1631 (archived)](https://developer.apple.com/library/archive/qa/qa1631/_index.html), corroborated by [setPreferredIOBufferDuration](https://developer.apple.com/documentation/avfaudio/avaudiosession/setpreferrediobufferduration%28_%3A%29?language=objc) — public references, retrieved 2026-10-23 | QA1631 is historical; it is used only for the preference/actual distinction. |
| S3 | Route changes add/remove inputs or outputs and produce a session notification. | [Responding to audio route changes](https://developer.apple.com/documentation/avfaudio/responding-to-audio-route-changes?changes=_9) — public article, retrieved 2026-10-23 | Route-specific recovery is unmeasured. |
| S4 | Interruption notifications identify begin/end; an ended interruption can carry `shouldResume`. | [Handling audio interruptions](https://developer.apple.com/documentation/AVFAudio/handling-audio-interruptions) — public article, retrieved 2026-10-23 | `shouldResume` informs policy; it is not a promise that this app should resume. |
| S5 | A media-services reset calls for reinitializing audio objects and resetting session configuration; Apple says not to restart processing until user action. | [mediaServicesWereResetNotification](https://developer.apple.com/documentation/avfaudio/avaudiosession/mediaserviceswereresetnotification?language=objc) — public API reference, retrieved 2026-10-23 | Reset/loss recovery has not been exercised. |
| S6 | `AVAudioEngine` manages an attached-node graph; `prepare()` preallocates many start resources; `start()` may fail. | [AVAudioEngine](https://developer.apple.com/documentation/avfaudio/avaudioengine), [prepare](https://developer.apple.com/documentation/avfaudio/avaudioengine/prepare%28%29?changes=__3) — public API references, retrieved 2026-10-23 | No assertion that all graph or framework calls are callback-safe. |
| S7 | UIKit scene lifecycle is per scene; scenes can be foreground/background/suspended independently. | [Managing your app’s life cycle](https://developer.apple.com/documentation/uikit/managing-your-app-s-life-cycle?changes=l__4_8) — public article, retrieved 2026-10-23 | Product lifecycle ownership remains undecided. |
| S8 | Background audio requires an adopted background execution mode; ordinary background apps are normally suspended. | [Configuring background execution modes](https://developer.apple.com/documentation/xcode/configuring-background-execution-modes?changes=__7), [media playback](https://developer.apple.com/documentation/avfoundation/configuring-your-app-for-media-playback?changes=_2.&language=objc) — public articles, retrieved 2026-10-23 | No capability, entitlement, or background behavior is adopted. |
| S9 | An archived Apple route guide says a route change can alter sample rate, I/O duration, channel counts, or other hardware values; query them after the change when material. | [Audio Session Programming Guide: Responding to Route Changes](https://developer.apple.com/library/archive/documentation/Audio/Conceptual/AudioSessionProgrammingGuide/HandlingAudioHardwareRouteChanges/HandlingAudioHardwareRouteChanges.html) — historical Apple guide, retrieved 2026-10-23 | Historical context only; corroborates, but does not replace, current route-notification evidence in S3. |

## 1. Session ownership, configuration, and observed hardware

### Facts

- The shared `AVAudioSession` expresses the app’s broad audio intent to the
  operating system rather than directly prescribing hardware behavior [S1].
- The current API provides `setCategory(_:mode:policy:options:)`, category-only
  and mode setters, and activation through `setActive` [S1]. Categories,
  modes, route-sharing policy, and category options are distinct inputs; a
  category does not by itself establish every requested behavior.
- `setPreferredSampleRate` and `setPreferredIOBufferDuration` express
  preferences. Apple’s archived QA and current buffer API say actual values may
  differ and should be inspected after activation [S2]. The current buffer API
  describes I/O duration as one input/output cycle, not end-to-end latency.
- Current session APIs expose route, available inputs, input/output channel
  counts, sample rate, I/O buffer duration, and port/data-source concepts [S1].
  Compatibility is therefore route- and device-dependent, not implied by API
  availability.

### Documentary responsibility for a future control plane

1. Keep a single explicitly owned session coordinator outside the render
   callback. It records requested category/mode/options and requested preferred
   values, then reads actual route, sample rate, duration, and channel layout
   after activation or route change.
2. Serialize configuration, activation/deactivation, engine graph work, and
   UI-state publication on a defined non-real-time control plane. This is a
   recommendation from the project’s real-time baseline, not an Apple
   thread-safety guarantee.
3. Treat every failed configuration/activation call and every observed mismatch
   as a recoverable state requiring a documented user-facing policy; none can
   be silently translated into a latency or compatibility claim.

### Unknowns and owner decisions

- Playback-only versus input-capable category, mode, options, route policy,
  Bluetooth/AirPlay treatment, minimum OS, and multi-scene session arbitration
  are undecided.
- No route has been tested for actual sample rate, duration, input/output
  channels, interruption policy, audio continuity, or usable latency.
- No numeric buffer, latency, CPU, or callback deadline budget is approved.

## 2. Lifecycle, interruption, route, and media-service recovery

### Facts

- An interruption notification carries a begin/end type. On end, its options
  can include `shouldResume` [S4]. Apple’s article presents this as information
  for the app’s resume decision, not an unconditional auto-resume directive.
- A route change follows added/removed audio I/O and carries details for
  observers [S3]. Apple identifies USB audio-interface removal as one example.
  The [archived route guide](https://developer.apple.com/library/archive/documentation/Audio/Conceptual/AudioSessionProgrammingGuide/HandlingAudioHardwareRouteChanges/HandlingAudioHardwareRouteChanges.html)
  additionally warns that sample rate, I/O duration, and channel count can
  change [S9]; it is corroborative historical context, not current performance
  evidence.
- Current session documentation lists both media-services-lost and
  media-services-reset notifications [S1]. For reset, Apple directs
  reinitialization of audio objects and resetting category/options/mode, and
  says not to restart processing until user action [S5].
- UIKit’s lifecycle is separate from audio-session events. With scenes, each
  scene has its own lifecycle, and background/suspended scenes may be
  disconnected to reclaim resources [S7].

### Future state-machine questions (recommendation, unperformed)

| Event | Proposed documentary safe state | What must be observed in a future spike |
| --- | --- | --- |
| Interruption begins | Stop accepting new musical intent, establish a clearly labeled interrupted state, and preserve only bounded control-plane state. | Notes, sustain, tails, session activation, engine state, callback health. |
| Interruption ends | Consult the option and explicit product/user policy before any reactivation attempt. | Whether explicit user action is required and any failure mode. |
| Route add/remove | Re-read actual route, rate, duration, channels, and graph compatibility before resuming. | Disconnect, reconnect, output privacy behavior, route negotiation, recovery continuity. |
| Media services lost/reset | Mark audio unavailable; recreate objects/session configuration only outside the callback. | Partial initialization, repeated reset, user-action gating, stale-resource handling. |
| Scene/app background or foreground | Coordinate UI visibility independently from session ownership; do not infer playback entitlement. | Multi-scene arbitration, suspension, reconnect/recovery, saved control state. |

**Stop Sound / sustain investigation:** Future tests must declare what happens
to held notes, queued note-offs, sustain-pedal state, release tails, and any
panic/Stop Sound command for every interruption, route, reset, and app-state
transition. No behavior is implemented or verified today.

## 3. AVAudioEngine and lower-level boundary candidates

### Facts

- `AVAudioEngine` owns an audio-node graph with input, output, and main mixer
  nodes. Nodes are attached and connected with formats supplied at connection
  points [S6]. Apple notes graph changes have limitations, including potential
  graph breakage when removing mixers or nodes with differing channel counts.
- `prepare()` preallocates many resources required to start; `stop()` releases
  previously prepared resources [S6]. This supports a future preparation
  investigation, but does not prove a complete path allocation-free.
- The engine supports real-time device rendering by default and manual/offline
  rendering when explicitly enabled; manual rendering disconnects it from audio
  devices [S6]. Offline/manual APIs do not establish live performance latency.
- Lower-level Audio Unit/Core Audio APIs expose explicit formats, busses,
  render blocks, resource allocation, and event boundaries (detailed in the
  hosting report). They remain candidates, not selected architecture.

### Candidate comparison for a later spike

| Boundary | What Apple documents | Open evidence required before selection |
| --- | --- | --- |
| AVAudioEngine | Managed node graph, connection formats, prepare/start/stop and device/manual rendering [S6]. | Route renegotiation, graph mutation/recovery, Flutter/native boundary, callback call graph, overload and device evidence. |
| Audio Unit/Core Audio layer | More explicit busses, formats, render/resource/event interfaces (see hosting sources). | Which ownership model preserves bounded work; conversion/mixing costs; actual route and lifecycle results. |

### Hard real-time boundary

Project policy prohibits I/O, UI, parsing, allocation, arbitrary locks, and
potentially blocking logs in a future render callback. Flutter remains outside
that callback. Apple API documentation cited here does **not** certify any
arbitrary framework call, notification handler, graph mutation, session call,
plugin interaction, or Dart/Flutter crossing as callback-safe. Discovery,
configuration, graph changes, persistence, telemetry, and teardown remain
control-plane work pending code-path evidence.

## 4. Bounded future spike and measurement plan

All procedures below are **unperformed**. Hardware, interfaces, controllers,
budgets, and operating authority are unapproved.

1. **Built-in/session first:** On each owner-selected iPhone and iPad category,
   execute **a proposed 30 repetitions** each of activation/deactivation, interruption
   begin/end, wired/USB connect-disconnect, and foreground/background return.
   Record actual route, rate, I/O duration, channels, activation result, engine
   state, note/sustain cleanup state, and bounded callback counters.
2. **Continuity/latency:** Use an owner-approved, calibrated electrical or
   acoustic method with a declared start/end boundary. Run 100 event trials per
   declared configuration and report raw samples, tails, underruns, callback
   duration/deadline misses, and uncertainty. Do not substitute preferred or
   nominal I/O duration for measured end-to-end latency.
3. **Workload/soak:** After an approved built-in workload definition, run one
   declared maximum configuration for an owner-approved duration, retaining
   CPU/memory/thermal/callback/underrun and recovery traces. No maximum
   supported workload is known now.
4. **Hosting later:** Use separate procedures for instantiation failure,
   extension crash/termination, state restore failure, format incompatibility,
   route recovery, and plugin UI absence. Those procedures are detailed in the
   companion report and must not block built-in-session exploration.

Each future evidence record must name commit, device model, OS/build, simulator
or physical status, audio interface and firmware, controller, route, requested
and observed configuration, measurement method, run duration, artifacts, and
reviewer. Simulator evidence cannot establish physical-device latency,
callback safety, background behavior, or hardware route compatibility.

The fixed 30 and 100 counts above are this report’s proposed study design—not
approved test procedures, measurement budgets, acceptance thresholds, or a
claim of a known maximum workload. A future approved manifest may change them.

## Risks, recommendation, and missing evidence

**Strengths (fact):** Apple provides semantic session control, notifications,
actual hardware-property inspection, and managed engine graph APIs [S1–S6].
**Risks (fact/inference):** those APIs leave requested-versus-actual
negotiation, lifecycle policy, route compatibility, graph recovery, and
deadline behavior to application evidence; that follows from S2–S7 and the
absence of measurements. **Recommendation:** approve one built-in playback and
session-lifecycle spike before scoping any engine ADR or third-party hosting.

**Retrieval provenance and limitations:** The writer’s initial research used
four public web searches and returned search excerpts; it did not successfully
open full Apple pages. The controller subsequently retrieved every cited source
directly from Apple Markdown endpoints or original HTML with HTTP 200, access
timestamps, SHA-256 hashes, and saved responses. The controller-owned source
catalog is to be recorded as
`docs/orchestration/milestones/m0/evidence/r03-source-evidence.md`; the raw
records currently reside in the shared Git evidence area. API metadata supplies
the availability table above but does not select a product minimum OS. The
project has no device, route, source-code, benchmark, signing, entitlement, or
background-capability evidence. These gaps are intentional, not negative
findings.
