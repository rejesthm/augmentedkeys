# Android audio research

**Status:** R04 documentary research, Android findings only. This report does
not select an engine, backend, minimum API level, dependency, permission,
device, or product behavior. It contains no build, emulator, simulator,
physical-device, audio, MIDI, latency, callback, or long-run measurement.

**Access date:** 2026-10-23 (Asia/Manila). The writer opened current public
Android/NDK documentation and original repository pages only. No repository
was cloned; no SDK, archive, package, or sample was downloaded, installed,
executed, or incorporated. Reading documentation and source pages is not code
adoption or license clearance.

## Scope, source identity, and limits

| Source | Inspected identity | What was inspected | Limitation |
| --- | --- | --- | --- |
| Android NDK AAudio guide/reference | Current official pages C02/C05, captured 2026-10-23; displayed revisions 2026-03-06 UTC / 2026-08-27 UTC | Stream, callback, lifecycle, format, timestamp, and API-availability entries | Web content is moving; this is not an Android-version/product baseline. |
| Android Oboe guide | Official C50; related low-latency guide C04 displayed last updated 2026-02-26 UTC, captured 2026-10-23 | API/backend statement and low-latency guidance | Guidance is not a device measurement or suitability proof. |
| `google/oboe` | current `main` `4468344c8fdfdd7df068d5abefe2d8615fd6b431` (C15); latest release `1.11.0` (C16) | Pinned README/LICENSE/full guide/callback sources C19–21/C45–47 | No source checkout, build, or source-call-graph review occurred. |
| `atsushieno/aap-core` | current `main` `682e7a6871a6c1414619dc483c1e234cb44e3ec3` (C17) | Pinned README/LICENSE/tree and Developers Guide C22–24/C48 | Exact capture does not establish a stable interface or adoption. |
| `atsushieno/aap-juce` | current `main` `07b99087c3675b7fa41c0bae61525d8d0bc4b3d4` (C18) | Pinned README/LICENSE/tree and GUI guide C25–27/C49 | Exact capture does not establish a stable interface or adoption. |

Controller first captured 51 HTTP-200 bodies, then added three Android
foreground-service bodies C52–C54 (54 total), with URLs, SHA-256, and access
times. This report cites and the writer inspected only its relevant subset;
capture alone does not establish review of every body. The earlier Oboe SHA
`2a45aa2d9e94d209c4636eec4014dd83cda110f4` is historical (2026-08-13), not
the observed current main; no source is adopted.

## Claim-to-source matrix

| ID | Fact supported by source | Primary source |
| --- | --- | --- |
| A1 | AAudio is an Android O C API; it transfers stream data and is deliberately not device enumeration, routing, file I/O, decoding, or automatic stream aggregation. | [AAudio guide](https://developer.android.com/ndk/guides/audio/aaudio/aaudio) |
| A2 | AAudio stream properties include one directional device, sharing mode, sample format, channels, and sample rate; requested values must be queried after open. | [AAudio guide](https://developer.android.com/ndk/guides/audio/aaudio/aaudio) |
| A3 | The callback is real-time; Android explicitly prohibits allocation, file/network work, mutexes, sleep, stop/close, and read/write on its stream. | [AAudio NDK reference](https://developer.android.com/ndk/reference/group/audio) |
| A4 | AAudio data callbacks start after start and stop after pause/stop; callbacks are not simultaneous across multiple threads. | [AAudio NDK reference](https://developer.android.com/ndk/reference/group/audio) |
| A5 | A disconnected stream must be stopped and closed; callback-mode disconnection uses an error callback and closure from that callback thread can deadlock. | [AAudio guide](https://developer.android.com/ndk/guides/audio/aaudio/aaudio) |
| A6 | `getTimestamp` is API 26 and reports a played/recorded frame time; hardware channel/format/rate getters are API 34 and can expose conversion. | [AAudio NDK reference](https://developer.android.com/ndk/reference/group/audio) (C05) |
| A7 | Oboe exposes one native C++ API from Android 4.1/API 16; its documented backend is AAudio on API 27+ and OpenSL ES below that. | [Android Oboe guide](https://developer.android.com/games/sdk/oboe) (C50), [pinned full guide](https://raw.githubusercontent.com/google/oboe/4468344c8fdfdd7df068d5abefe2d8615fd6b431/docs/FullGuide.md) (C45) |
| A8 | The Android low-latency guide recommends requests for low-latency/exclusive modes, device rate, data callbacks, and buffer tuning; requests may not be granted. | [Low-latency audio guide](https://developer.android.com/games/sdk/oboe/low-latency-audio) (C04; displayed revision 2026-02-26 UTC) |
| A9 | Focus behavior changes by Android version; target-35 focus needs top-app or foreground-service status. | [Manage audio focus](https://developer.android.com/media/optimize/audio-focus) |
| A10 | Foreground-service, microphone, connected-device, USB, and Bluetooth rules have version- and use-case-specific declarations/prerequisites. | [Foreground service types](https://developer.android.com/develop/background-work/services/fgs/service-types), [USB host](https://developer.android.com/develop/connectivity/usb/host), [Bluetooth permissions](https://developer.android.com/develop/connectivity/bluetooth/bt-permissions) |
| A11 | AAP packages plugins as apps/services; hosts query intent services and metadata, then use Binder/shared-memory-oriented machinery. | [Pinned AAP Developers Guide](https://raw.githubusercontent.com/atsushieno/aap-core/682e7a6871a6c1414619dc483c1e234cb44e3ec3/docs/DEVELOPERS.md) (C48) |
| A12 | AAP describes its host-facing C++/Kotlin APIs as unstable/reference-oriented and documents separate processes, MIDI 2 messaging, and AAPXS extensions. | [Pinned AAP README](https://raw.githubusercontent.com/atsushieno/aap-core/682e7a6871a6c1414619dc483c1e234cb44e3ec3/README.md) (C22) |
| A13 | AAP-JUCE documents breaking AAP API/ABI change risk, local patches, mobile UI limits, and a simple host able to enumerate/instantiate installed AAP plugins. | [Pinned AAP-JUCE README](https://raw.githubusercontent.com/atsushieno/aap-juce/07b99087c3675b7fa41c0bae61525d8d0bc4b3d4/README.md) (C25) |
| A14 | Pinned repository LICENSE bodies identify Oboe as Apache-2.0, AAP core as MIT, and AAP-JUCE as AGPLv3. | [C20](https://raw.githubusercontent.com/google/oboe/4468344c8fdfdd7df068d5abefe2d8615fd6b431/LICENSE), [C23](https://raw.githubusercontent.com/atsushieno/aap-core/682e7a6871a6c1414619dc483c1e234cb44e3ec3/LICENSE), [C26](https://raw.githubusercontent.com/atsushieno/aap-juce/07b99087c3675b7fa41c0bae61525d8d0bc4b3d4/LICENSE) |
| A15 | Foreground-service background-start, type/permission, and launch rules are separately target-SDK and runtime-OS conditioned. | [C52 Android 14 FGS types](https://developer.android.com/about/versions/14/changes/fgs-types-required), [C53 Android 12 restrictions](https://developer.android.com/develop/background-work/services/fgs/restrictions-bg-start), [C54 launch guide](https://developer.android.com/develop/background-work/services/fgs/launch) (all captured 2026-10-23) |
| A16 | Bluetooth declarations and runtime grants differ for an app targeting Android 12/API 31+ and its legacy declarations. | [C13 Bluetooth permissions](https://developer.android.com/develop/connectivity/bluetooth/bt-permissions) (displayed revision 2026-10-16 UTC) |

## 1. Native API roles and availability

### Facts

- AAudio was introduced in Android O; official Android guidance describes it as
  a C API for high-performance/low-latency streams [A1]. Its API-reference
  symbols used here show individual availability, commonly API 26, rather
  than granting a product minimum OS.
- AAudio stream I/O can use read/write with a caller-selected timeout or a
  high-priority data callback [A1, A3]. Blocking I/O is a documented API mode,
  but is forbidden inside the future project rendering callback.
- Oboe is an open-source C++ wrapper, not an Android platform replacement. Its
  official guide says it uses AAudio on Android 8.1/API 27+ and OpenSL ES on
  lower versions [A7]. Thus AAudio availability and an Oboe-supported minimum
  are distinct facts.
- OpenSL ES is the older Oboe fallback stated by Android; no claim here ranks
  it, AAudio, or Oboe for this product. Any backend choice remains a future
  research → spike → benchmark → ADR → owner decision.

### Requested versus actual stream configuration

AAudio's builder accepts optional requested device ID, direction, sharing,
sample rate, channel count, format, and buffer capacity [A1]. A request is
not a negotiated result. After open, record at least actual device ID,
direction, sample rate, channel count, data format, performance/sharing mode,
buffer capacity, current buffer size, and frames-per-burst. The API reference
also exposes hardware channel/format values and warns that framework conversion
may occur [A6].

| Dimension | Documented distinction | What it cannot establish alone |
| --- | --- | --- |
| Rate/format/channels | An unspecified format lets AAudio choose; a requested format can be non-optimal and must be queried after opening [A2]. | Route quality, audible latency, clock accuracy, or controller compatibility. |
| Capacity/size/burst | Capacity is bounded by device allowance; actual capacity and size are queryable. Buffer tuning trades resilience against latency [A1]. | A numeric latency result without a preapproved physical-device procedure. |
| Performance mode | A request can differ from final mode; `getPerformanceMode` reports the final result [A3]. | Guaranteed fast path, safety, or portability. |
| Sharing mode | Exclusive may lower latency but can be unavailable and more prone to disconnection; shared is the default mixer path [A2]. | Exclusive acquisition on any particular route. |
| Device selection | Device IDs come from Java `AudioManager`; a stream is one-directional and attached to one device [A1]. | Stable routing or that a device remains present. |

The Android guide suggests not pinning a rate to obtain the device's natural
rate, and says 48 kHz is likely but not guaranteed [A8]. That is a guide
recommendation, not a selected rate. Likewise, a requested callback frame
count can vary unless requested, and a fixed request may add buffering [A3].

## 2. Callback, control plane, lifetime, and error boundary

### Facts

- In callback mode, supplied audio data is the transfer path: do not call
  stream read/write on that same stream [A3]. Output must fill `numFrames`;
  input processing must not mutate the supplied buffer directly [A3].
- Android calls the data callback on an AAudio-owned real-time thread; low
  latency streams may have higher priority. Calls do not arrive concurrently
  on multiple callback threads [A4].
- The NDK reference explicitly says the callback must avoid unbounded delay,
  allocation, file/network operations, mutexes/synchronization primitives,
  sleep, stream stop/close, and stream read/write [A3]. Project policy is at
  least as strict: no UI/Dart/Flutter work, parsing, I/O, logging that can
  block, arbitrary locks, or callback-visible teardown.
- AAudio stable states include Open, Started, Paused, Flushed, and Stopped.
  State-change requests are asynchronous; data flows only when Started [A1].
  `waitForStateChange` is not a wait for a named target state and must not race
  close [A1].
- AAudio is not wholly thread-safe. The guide says not to concurrently wait,
  read/write, or close the same stream from different threads; it calls out
  `getTimestamp` as an exception to otherwise thread-safe getters [A1]. This
  does not establish a blanket cross-stream/same-thread safety rule.

### Recommended ownership model (not an implementation)

1. A non-real-time control plane owns builder creation, focus/lifecycle
   coordination, device observation, stream open/start/stop/close, recovery,
   memory preparation, logging, and UI/Dart coordination.
2. The render callback owns only bounded use of preallocated buffers and a
   documented handoff snapshot. It neither binds a service nor opens/closes a
   stream, parses metadata, loads state, writes storage, or calls Flutter.
3. A bounded nonblocking handoff may carry control events; “atomic” or
   “lock-free” is not proof of correct ordering, lifetime, bounded retry, or
   real-time safety. These need a later complete call-graph review and device
   evidence.
4. A recovery worker serializes state transition and destruction after a
   callback/error signal. Callback-visible objects must remain valid until a
   documented quiescence/reclamation condition holds.

This is a project recommendation derived from [A3–A5] and
`REALTIME_SAFETY.md`, not an adopted architecture.

### Disconnection and safe shutdown

AAudio identifies unplugging, internal error, and primary-device change as
possible disconnection causes [A5]. It says to stop and close a disconnected
stream, and warns that a reopened stream can have different settings such as
frames-per-burst [A5]. In callback mode an error callback reports a disconnect;
the official guide requires stopping/closing from another thread to avoid a
deadlock [A5]. Therefore a future recovery procedure must re-query every actual
property before resume, rather than reusing prior negotiated values.

Oboe adds distinct `onError`, `onErrorBeforeClose`, and `onErrorAfterClose`
callbacks on an Oboe-created error thread: default `onError` false delegates
stop/close to Oboe; before-close may query but not close/delete; after-close
may query parameters but the underlying AAudio/OpenSL ES stream is closed
[C47 pinned callback header](https://raw.githubusercontent.com/google/oboe/4468344c8fdfdd7df068d5abefe2d8615fd6b431/include/oboe/AudioStreamCallback.h).
This is not the AAudio error-callback contract and does not make either path
callback-safe without a later call-graph and device review.

No source here supplies the product's note/sustain policy, restart UX, retry
budget, shutdown deadline, or failure presentation. Those are open product and
spike questions. A stream pointer is invalid after close; closure while another
thread uses it is expressly unsafe [A1].

## 3. Timing, counters, and measurement limits

`AAudioStream_getTimestamp` is API 26, valid only after Started, and gives a
frame position/time for when audio was played or recorded [A6]. Hardware
channel/format/rate getters are API 34 and disclose conversions, not latency.
`getFramesWritten` is a monotonically increasing count advanced by callback or
write for output [A6]. These properties can support a proposed clock-boundary
instrumentation design, but do not by themselves measure input-to-audible
latency, MIDI-to-sound latency, callback duration, underruns, jitter,
continuity, Bluetooth behavior, or end-to-end clock alignment.

No numeric latency, frame duration, underrun count, supported workload,
polyphony, battery/thermal result, or callback-safety result is claimed. A
successful open or an actual property query would establish only that recorded
configuration at that time, on that stated route/device/OS.

## 4. Activity, focus, process, routes, and permissions

### Lifecycle and audio focus facts

- The app/activity lifecycle must be treated as a control-plane signal; this
  report makes no claim that background or process death preserves audio.
- Android advises requesting focus immediately before playback and checking the
  result, then stopping/pausing/ducking on loss and abandoning it after
  playback ends [A9]. Android 12/API 31+ system-manages specified focus
  behavior; on Android 15/API 35, an app targeting 35 must be top app or a
  foreground service for focus [A9].

### Runtime-OS and target-SDK boundary ledger

This is a documentary rule map, not a manifest/permission selection. “Legacy”
means only that the cited newer rule is not the stated condition; it does not
establish behavior for an unselected target SDK or device OS.

| Rule | Device OS and target threshold | Manifest declaration | Runtime grant / start condition | Legacy distinction |
| --- | --- | --- | --- | --- |
| Start an FGS from background | Runtime OS: Android 12/API 31+; target SDK: 31+ [A15]. | No type declaration follows merely from this rule. | App must be visible or satisfy a documented exception; otherwise `ForegroundServiceStartNotAllowedException`. | C53/C54 frame this restriction at target 31+; no claim is made for a lower target. |
| Promote media-playback FGS | Runtime OS: Android 14/API 34+; target SDK: 34+ [A15]. | `FOREGROUND_SERVICE`, `FOREGROUND_SERVICE_MEDIA_PLAYBACK`, and matching `android:foregroundServiceType="mediaPlayback"` are the C52 example/type requirements. | C52 lists no user runtime prerequisite; its FGS permissions are normal/default-granted, but the type must be declared before promotion and the Android-12 background-start rule still applies. | C52's type-specific target-34 enforcement is not asserted below that condition. |
| Promote microphone FGS | Runtime OS: Android 14/API 34+; target SDK: 34+ for cited creation checks [A15]. | `FOREGROUND_SERVICE`, `FOREGROUND_SERVICE_MICROPHONE`, matching microphone type, and `RECORD_AUDIO` if this unselected capability is chosen. | `RECORD_AUDIO` is dangerous/user-granted; a while-in-use microphone service must be started/bound while visible unless a documented exemption applies. | On OS below Android 14, C53 says creation could succeed but later resource use could fail; no compatibility conclusion follows. |
| Bluetooth scan/advertise/connect | Runtime OS: Android 12/API 31+; target SDK: 31+ [A16]. | Declare only action-specific `BLUETOOTH_SCAN`, `BLUETOOTH_ADVERTISE`, and/or `BLUETOOTH_CONNECT`. | Each is a runtime Nearby-devices grant; location is separately relevant only if scan results derive physical location. No FGS is implied. | For target SDK 30 or lower, C13 says `BLUETOOTH` covers classic/BLE communication, `ACCESS_FINE_LOCATION` is needed for scans and is runtime-granted, and `BLUETOOTH_ADMIN` is needed for discovery/settings. For a service that can run on Android 10/API 29 or Android 11/API 30, C13 also says `ACCESS_BACKGROUND_LOCATION` is needed to discover devices. These are documented conditions, not adoption or a universal grant claim. |

`POST_NOTIFICATIONS` does not itself select an FGS, and an FGS notification
does not remove the separate type/start conditions above. Background playback,
recording, Bluetooth, and any service are deliberately deferred and unadopted.

**`BOOT_COMPLETED` distinction:** C53 gives a general target-34+ warning that
certain FGS types are restricted when launched from `BOOT_COMPLETED`. C07 then
names the specific target-35+ prohibition for media playback (and, outside the
proposed scope, data sync, media projection, and phone call). C07's microphone
type text instead says it cannot launch from `BOOT_COMPLETED` because its
`RECORD_AUDIO` prerequisite is while-in-use, with a few documented exceptions;
it does not attach the target-35 threshold to that microphone statement. None
of these conditions selects a boot receiver, service, or permission.

### Route/device-change facts and questions

AAudio disconnection already covers removal or default-route change [A5]. USB
host capability is device-dependent; API support starts at Android 3.1/API 12
and the manifest feature is not guaranteed across Android devices [A10]. USB
communication requires user permission before connection and permission ends
when the device disconnects [A10]. Bluetooth details are the separate
target-31/device-31 conditions in [A16], not an inferred audio-route rule.

Neither a transport permission nor an AAudio device ID proves audio support,
latency, usable channel layout, stable device enumeration, MIDI behavior, or
that permission is needed for a later selected product route. Wired USB,
Bluetooth, input/audio interface, and controller policy remain unselected.

## 5. Security, privacy, and licensing questions

The original Oboe repository license page is Apache License 2.0; AAP core's
LICENSE is MIT; AAP-JUCE's LICENSE/README identify AGPLv3 [A14]. Those are
source identities, not a finding that any component may be adopted or
redistributed. AAP core's README also names subcomponent origins/licenses
(including ISC, MIT, and Apache-2.0 examples), so a root-license label cannot
replace a version-specific dependency/transitive inventory.

R07 must assess the exact revision, provenance, notice obligations,
modification/distribution/commercial terms, JUCE relationship, patches,
generated artifacts, bundled native libraries, sample content, privacy/data
handling, Play policy, supply-chain state, and every eventual host/plugin.
No ledger entry is changed by this research.

For Android native input, Android documents `RECORD_AUDIO` as dangerous and
advises access only after grant [A10]. A future app must separately determine
whether it captures microphone data, what it stores/transmits, and what user
disclosure/retention policy applies. This report selects none.

## 6. Smallest later spikes (all unperformed and unapproved)

### First: built-in playback/lifecycle spike

The first proposed spike has two built-in modes—generated/silent callback-only
checks and a separate audible known-signal measurement—without a plugin host,
third-party plugin, microphone feature, or background claim. On each
owner-approved physical device category—flagship Android tablet, mainstream
Android tablet, flagship Android phone, and mainstream Android phone in the
device matrix—record exact model, OS, app commit, AAudio/Oboe revision if used,
API level, route, sample rate, actual format, channels, sharing/performance
mode, capacity/size/burst, and focus result. Categories are coverage planning
labels, not selected devices.

#### Proposed measurement method carried from R01

All of this is hypothetical, unapproved, and unperformed. It carries forward
R01 `LOW_LATENCY_RESEARCH.md`/`MOBILE_AUDIO_ARCHITECTURE.md` boundary,
calibration, overload, recovery, and raw-artifact rules. The proposed primary
quantity for an audible built-in spike is **touch-trigger-to-audible output**:
start at the common-acquisition-clock electrical edge of a repeatable actuator
that makes the declared test touch; end at the earliest predeclared
correlation/threshold detection of the matching known signal at the declared
electrical line-output endpoint or calibrated microphone position. It is not
nominal buffer duration, AAudio timestamp, callback duration, or round trip.

The generated/**silent** path is restricted to callback interval/duration and
bounded underrun/error-counter checks; it cannot establish audible continuity
or latency. A separate proposed audible path emits a fixed, known coded burst
or periodic marker. Capture trigger and endpoint on one synchronized
acquisition system where feasible; otherwise predeclare and validate clock
offset, drift correction, resolution, actuator delay, line/microphone/acoustic
path delay, correlation threshold, and uncertainty/error budget. A
synchronized full-duplex electrical loopback may separately measure declared
audio round trip; it cannot substitute for touch-trigger-to-audible output.

For continuity, compare each captured marker with its expected schedule and
record missing, duplicated, late, clipped, or unmatched markers; retain the
capture and matching analysis. Callback deadline/underrun/error counters are
corroboration only, not audible-continuity proof. Predeclare one known-signal
schedule and render workload, then apply controlled stepped overload escalation
(for example event/workload rate or declared render complexity) per trial;
record each level and stop condition, without treating any level as an accepted
budget. Exercise foreground/background, focus, route disconnect/reconnect,
stop/close/reopen, and lifecycle restart only under a separately approved
device procedure. For each recovery, start timing at the recorded disruption
or error signal and end only at the first matching post-recovery marker plus
recorded re-queried stream properties; retain all failures.

Before execution, an owner-approved manifest must state device/OS/route,
signal, acquisition hardware, calibration before/after run, warm-up,
repetitions, event count, duration, workload, cooldown/reset, numeric
acceptance budgets, and retention/access controls. The current study-design
values—30 focus/lifecycle/route recovery cycles and one 60-minute sustained
run after a stated warm-up—are **provisional only**, not an authorized device
action, procedure, duration, workload, or acceptance value. Retain
content-hashed raw multichannel captures, trigger/event series, callback and
platform counters, configuration/route manifest, calibration/error record,
analysis source/version, exclusions, and failed/inconclusive trials.

Proposed analysis outputs are a per-configuration latency distribution
(sample count, min/median and predeclared tails), explicit outlier list/rule,
clock/calibration uncertainty summary, marker-continuity summary
(missing/duplicate/late/clipped/unmatched), and recovery summary from each
declared disruption boundary to the first matching post-recovery marker. Invalid
or censored trials (for example lost capture, failed calibration, route change,
or incomplete recovery) must be retained, labeled with cause, excluded only by
a predeclared rule, and reported separately rather than silently discarded. No
numeric criterion, outlier rule, or acceptance budget is approved.

### Later: AAP hosting experiment

Only after the built-in/lifecycle evidence and R07 component clearance, use one
identified host/device/OS/route and one legally cleared AAP plugin. Predeclare
the host/plugin package names, signing identities, UIDs, service export and
intent visibility, metadata/unique ID, requested permissions, file/state
locations, Binder/shared-memory exchanges, UI path, MIDI/event boundary,
sample rate/block sizes, and stop/error procedure. The hosting report supplies
the remaining AAP-specific questions.

For both proposals, the missing acceptance budgets include numeric latency,
deadline, underrun, recovery, maximum workload/polyphony/plugin count,
long-run duration, CPU/memory/battery/thermal limits, and tolerated state/event
loss. The owner has not approved a procedure, hardware, configuration, or
budget; no test is authorized by this document.

## 7. Conclusions, inferences, and open questions

**Facts:** AAudio and Oboe document native stream/callback surfaces, API
availability, negotiated properties, error/disconnection mechanics, and strict
callback restrictions [A1–A8]. Android documents focus, foreground-service,
USB, Bluetooth, and recording rules that vary by platform version and actual
use [A9–A10].

**Inference:** A small built-in lifecycle investigation has fewer external
process, metadata, license, state, UI, and service-discovery variables than
third-party hosting. That makes it the appropriate first *proposed* spike, not
an architectural choice or implementation authorization.

**Recommendation:** Keep Flutter/UI and all discovery/lifecycle/persistence
outside the native rendering callback; test only bounded control-to-render
handoffs once a future implementation exists. Defer background and plugin
hosting behavior until separate policy, licensing, and device evidence exist.

**Missing evidence:** No actual Android device/OS/interface/controller result;
no Android minimum API or target SDK; no stream/property measurement; no
callback call-graph; no route, background, Bluetooth, USB, microphone, MIDI,
UI, privacy, sandbox, or performance validation. Owner decisions remain
required for architecture, dependencies, permissions, hardware, product
policy, legal conclusions, and adoption.

**Initial retrieval failure, resolved:** Browser-opened AAP pages did not
expose branch-tip SHAs, and the writer's read-only `git ls-remote` attempt for
AAP core, AAP-JUCE, and Oboe failed DNS on 2026-10-23 (`Could not resolve
host: github.com`); it performed no clone or write. Controller capture
C15–C27/C45–C50 then returned HTTP 200 and preserves URLs, SHA-256/access
times, and the immutable identities recorded above. This is historical, not a
current evidence gap.
