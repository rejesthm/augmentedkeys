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
| Android NDK AAudio guide/reference | Current official web documentation, accessed 2026-10-23 | Stream, callback, lifecycle, format, timestamp, and API-availability entries | Web content is moving; this is not an Android-version/product baseline. |
| Android Oboe guide | Current official web documentation, last updated 2026-02-26 UTC, accessed 2026-10-23 | API/backend statement and low-latency guidance | Guidance is not a device measurement or suitability proof. |
| `google/oboe` | `main` commit `2a45aa2d9e94d209c4636eec4014dd83cda110f4`, shown by GitHub commits page, accessed 2026-10-23 | Commit identity and repository license page | No source checkout, build, or source-call-graph review occurred. |
| `atsushieno/aap-core` | Moving `main` branch, accessed 2026-10-23 | README, LICENSE, Developers Guide | Browser did not expose a full commit object for this repository; immutable revision capture is a controller evidence gap. |
| `atsushieno/aap-juce` | Moving `main` branch, accessed 2026-10-23 | README, GUI support, porting surface, LICENSE | Browser did not expose a full commit object; this is not a stable interface claim. |

The two unpinned AAP branch identities are deliberately not represented as
immutable revisions. Before any future experiment relies on either, the
controller must capture the full commit SHA, exact bodies, and content hashes.
The Oboe short GitHub history link was expanded to the full SHA above; all
other repository conclusions below remain tied to the accessed `main` pages.

## Claim-to-source matrix

| ID | Fact supported by source | Primary source |
| --- | --- | --- |
| A1 | AAudio is an Android O C API; it transfers stream data and is deliberately not device enumeration, routing, file I/O, decoding, or automatic stream aggregation. | [AAudio guide](https://developer.android.com/ndk/guides/audio/aaudio/aaudio) |
| A2 | AAudio stream properties include one directional device, sharing mode, sample format, channels, and sample rate; requested values must be queried after open. | [AAudio guide](https://developer.android.com/ndk/guides/audio/aaudio/aaudio) |
| A3 | The callback is real-time; Android explicitly prohibits allocation, file/network work, mutexes, sleep, stop/close, and read/write on its stream. | [AAudio NDK reference](https://developer.android.com/ndk/reference/group/audio) |
| A4 | AAudio data callbacks start after start and stop after pause/stop; callbacks are not simultaneous across multiple threads. | [AAudio NDK reference](https://developer.android.com/ndk/reference/group/audio) |
| A5 | A disconnected stream must be stopped and closed; callback-mode disconnection uses an error callback and closure from that callback thread can deadlock. | [AAudio guide](https://developer.android.com/ndk/guides/audio/aaudio/aaudio) |
| A6 | `getTimestamp` reports a played/recorded frame time; frames written are monotonic application/endpoint counters. | [AAudio NDK reference](https://developer.android.com/ndk/reference/group/audio) |
| A7 | Oboe exposes one native C++ API from Android 4.1/API 16; its documented backend is AAudio on API 27+ and OpenSL ES below that. | [Android Oboe guide](https://developer.android.com/games/sdk/oboe) |
| A8 | The Android low-latency guide recommends requests for low-latency/exclusive modes, device rate, data callbacks, and buffer tuning; requests may not be granted. | [Low-latency audio guide](https://developer.android.com/games/sdk/oboe/low-latency-audio) |
| A9 | Focus behavior changes by Android version; target-35 focus needs top-app or foreground-service status. | [Manage audio focus](https://developer.android.com/media/optimize/audio-focus) |
| A10 | Foreground-service, microphone, connected-device, USB, and Bluetooth rules have version- and use-case-specific declarations/prerequisites. | [Foreground service types](https://developer.android.com/develop/background-work/services/fgs/service-types), [USB host](https://developer.android.com/develop/connectivity/usb/host), [Bluetooth permissions](https://developer.android.com/develop/connectivity/bluetooth/bt-permissions) |
| A11 | AAP packages plugins as apps/services; hosts query intent services and metadata, then use Binder/shared-memory-oriented machinery. | [AAP Developers Guide](https://github.com/atsushieno/aap-core/blob/main/docs/DEVELOPERS.md) |
| A12 | AAP describes its host-facing C++/Kotlin APIs as unstable/reference-oriented and documents separate processes, MIDI 2 messaging, and AAPXS extensions. | [AAP README](https://github.com/atsushieno/aap-core), [AAP Developers Guide](https://github.com/atsushieno/aap-core/blob/main/docs/DEVELOPERS.md) |
| A13 | AAP-JUCE documents breaking AAP API/ABI change risk, local patches, mobile UI limits, and a simple host able to enumerate/instantiate installed AAP plugins. | [AAP-JUCE README](https://github.com/atsushieno/aap-juce/blob/main/README.md) |
| A14 | Original repository license pages identify Oboe as Apache-2.0, AAP core as MIT, and AAP-JUCE as AGPLv3. | [Oboe LICENSE](https://github.com/google/oboe/blob/main/LICENSE), [AAP core LICENSE](https://github.com/atsushieno/aap-core/blob/main/LICENSE), [AAP-JUCE LICENSE](https://github.com/atsushieno/aap-juce/blob/main/LICENSE) |

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
  stream read/write on that same stream [A3]. Output fills at most `numFrames`;
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
  `getTimestamp` as an exception to otherwise thread-safe getters [A1].

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

No source here supplies the product's note/sustain policy, restart UX, retry
budget, shutdown deadline, or failure presentation. Those are open product and
spike questions. A stream pointer is invalid after close; closure while another
thread uses it is expressly unsafe [A1].

## 3. Timing, counters, and measurement limits

`AAudioStream_getTimestamp` gives a frame position/time for when audio was
played or recorded and can align audio with video or MIDI [A6].
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
  behavior; Android 15/API 35 target behavior rejects focus unless top app or
  foreground service [A9].
- A media playback foreground service is documented as a background-playback
  facility; Android 14/API 34+ foreground services require declared type and
  permission. Android 15 target restrictions include `BOOT_COMPLETED` cases
  [A10]. Background playback is deliberately deferred and unadopted here.
- A microphone foreground service needs `RECORD_AUDIO` granted and has
  while-in-use/start restrictions [A10]. Recording is not in the stated
  built-in playback scope, so no microphone permission is selected.

### Route/device-change facts and questions

AAudio disconnection already covers removal or default-route change [A5]. USB
host capability is device-dependent; API support starts at Android 3.1/API 12
and the manifest feature is not guaranteed across Android devices [A10]. USB
communication requires user permission before connection and permission ends
when the device disconnects [A10]. Android 12/API 31+ Bluetooth scan,
advertise, and connect are runtime “Nearby devices” permissions for their
respective actions [A10].

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

The first proposed spike is one built-in generated/silent test path—no plugin
host, no third-party plugin, no microphone, and no background claim. On each
owner-approved physical device category—flagship Android tablet, mainstream
Android tablet, flagship Android phone, and mainstream Android phone in the
device matrix—record exact model, OS, app commit, AAudio/Oboe revision if used,
API level, route, sample rate, actual format, channels, sharing/performance
mode, capacity/size/burst, and focus result. Categories are coverage planning
labels, not selected devices.

Proposed methods, not accepted procedures:

- Measure callback interval/duration and underrun/error counters with
  preallocated counters drained outside the callback; specify clock source,
  warm-up, repetitions, duration, and raw-log retention before testing.
- Exercise foreground ↔ background transition, focus loss/gain, route
  disconnect/reconnect, stop/close/reopen, and process/lifecycle restart only
  under an approved device procedure.
- Capture actual pre/post-reopen properties, recovery time boundary, audible
  continuity observation method, and every failure. Do not treat the outcome
  as a product guarantee beyond the recorded configuration.
- For study design only, use a proposed 30 focus/lifecycle/route recovery
  cycles per declared configuration and one proposed 60-minute sustained run
  after a stated warm-up. Record overload stimulus, callback/deadline and
  underrun counters, route disconnection/reconnection, recovery transition,
  and raw artifacts. These quantities are neither a hardware request nor an
  approved duration, workload, test procedure, or acceptance budget.

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
callback call-graph; no AAP immutable revision capture; no route, background,
Bluetooth, USB, microphone, MIDI, UI, privacy, sandbox, or performance
validation. Owner decisions remain required for architecture, dependencies,
permissions, hardware, product policy, legal conclusions, and adoption.

**Retrieval limitation:** Browser-opened original AAP pages did not expose the
full branch-tip commit SHA. A read-only `git ls-remote` attempt for AAP core,
AAP-JUCE, and Oboe failed locally on 2026-10-23 with `Could not resolve host:
github.com`; it performed no clone or write. The Oboe full SHA is therefore
from the browser's GitHub commit link; full immutable AAP identities remain
explicitly missing until controller capture.
