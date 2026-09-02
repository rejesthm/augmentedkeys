# Mobile Audio Latency Research and Future Measurement Proposal

## Status and evidence boundary

This report defines latency quantities and proposes a reproducible future
physical-device evaluation procedure for R01. The procedure has not been
approved or executed. It records no measured result and establishes no device,
route, architecture, dependency, callback-safety, continuity, compatibility, or
low-latency claim.

Exact hardware, supported OS versions, workloads, routes, measurement
instruments, run parameters, and numeric acceptance budgets remain owner-gated
fields that must be filled before the proposal becomes an executable procedure.

## Source register

All web sources were accessed on 2026-09-02. Live documentation may change.

| ID | Publisher and source | Version or date status |
| --- | --- | --- |
| L1 | Apple, [setPreferredIOBufferDuration(_:)](https://developer.apple.com/documentation/avfaudio/avaudiosession/setpreferrediobufferduration%28_%3A%29) | Live, unversioned; publication date unavailable |
| L2 | Android Developers, [AAudio](https://developer.android.com/ndk/guides/audio/aaudio/aaudio) | Android NDK documentation; last updated 2026-03-06 UTC |
| L3 | Android Developers, [Audio latency](https://developer.android.com/ndk/guides/audio/audio-latency) | Live guidance; last updated 2024-01-03 UTC |
| L4 | Android Open Source Project, [Measure audio latency](https://source.android.com/docs/core/audio/latency/measure) | Live guidance; last updated 2026-06-17 UTC |

Repository controls applied to this proposal include
`docs/testing/TEST_STRATEGY.md`, `docs/testing/DEVICE_MATRIX.md`, and
`docs/architecture/REALTIME_SAFETY.md`, read from task state
`b8d245683170a3f4961ca89e9cbf3a2d1d4cdfdb` on 2026-09-02.

## Facts from current sources

Android defines output latency as the interval from an application generating a
sample until playback, input latency as the interval from a received signal
until application availability, round-trip latency as input plus application
processing plus output, and touch latency as touch until application receipt.
[L3]

Android states that isolated input and output latency are difficult to measure
and that round-trip latency varies by device model and Android build. [L3] AOSP
documents a loopback method that uses synchronized full-duplex capture and
correlation for round-trip measurement. [L4]

Apple documents preferred I/O buffer duration as a request and directs callers
to inspect the actual duration, which depends on the hardware. [L1] AAudio
documents frames-per-burst and buffer behavior, including the latency/protection
trade-off of larger buffers. [L2]

None of these values alone measures the complete AugmentedKeys interaction path.

## Measurement quantities

Every future result must name exactly one primary quantity and its start and end
boundaries. Results for different quantities must not be substituted for one
another.

### Touch-to-audible output

The interval from the declared physical touch event boundary to the declared
audible-output boundary. A candidate method is a repeatable actuator whose
electrical trigger and the resulting electrical line output or microphone signal
are captured on a common acquisition clock. The physical contact definition,
actuator delay, acoustic path, microphone delay, and output threshold or
correlation rule must be calibrated and recorded.

Touch-to-application receipt, display response, audio output latency, or nominal
buffer duration alone is not touch-to-audible latency.

### MIDI-to-audible output

The interval from a declared MIDI ingress event boundary to the declared
electrical or acoustic audio-output boundary. A candidate method is to split or
observe the MIDI event electrically while capturing the resulting audio on a
second channel of the same acquisition system. The connector and transport
(for example, wired DIN through an interface, wired USB, or wireless), timestamp
definition, controller/interface path, and any splitter or detector delay must
be recorded.

Controller timestamp, application receipt, software scheduling, audio output,
and acoustic propagation may be useful subsegments but do not independently
equal the end-to-end quantity.

### Software scheduling and queue contribution

The instrumented portion between declared application ingress and the point at
which prepared work becomes visible to the native render path. Candidate
timestamps include native ingress, validated-command enqueue, render-thread
dequeue or sequence observation, and first affected output frame. All clocks,
timestamp costs, queue semantics, and sequence gaps must be documented.

This contribution is not total latency and must not be added to separately
measured end-to-end values unless the boundaries and clocks are non-overlapping
and mathematically compatible.

### Output latency

The interval from the application or render boundary at which a known output
sample is generated to its declared electrical or acoustic output boundary.
The exact injection point, hardware path, route, capture threshold or correlation
method, and fixed delays must be recorded. Android's definition supports this
boundary, while also warning that isolated output latency is difficult to
measure. [L3]

### Audio round trip

The interval from a known physical or electrical input stimulus through input,
application processing, and output to the captured return. A candidate method
is synchronized full-duplex loopback and correlation following the measurement
shape documented by AOSP. [L4] The application processing inserted between
input and output must be declared.

Round trip is not a substitute for touch-to-audible or MIDI-to-audible latency.

### Nominal buffer duration

For a buffer containing `frames` frames at `sampleRate` frames per second:

```text
nominal buffer duration seconds = frames / sampleRate
nominal buffer duration milliseconds = 1000 * frames / sampleRate
```

This calculation describes only nominal buffer duration. It is never a measured
total, touch/MIDI-to-audible, output, or round-trip latency. Preferred or actual
I/O-cycle duration, frames-per-burst, and configured buffer capacity must also
not be relabeled as an end-to-end result. [L1][L2]

## Proposed future physical-device procedure

### Gate 1: approve the procedure manifest

Before hardware is requested or operated, the owner must approve a committed
manifest containing:

- candidate commit and build configuration;
- primary measurement quantity and exact start/end boundaries;
- exact instrument models, firmware, cabling, probes, splitter/detector,
  microphone or electrical loopback, and acquisition sample rate;
- exact device model and OS build from the device itself;
- exact audio route and endpoint, MIDI controller/interface/transport when
  applicable, permissions, and power/network conditions;
- sample rate, requested and observed audio-buffer settings, audio session or
  stream mode, workload, and feature flags;
- warm-up duration, measured run duration, repetitions, event count per
  repetition, inter-event schedule, and cooldown or reset sequence;
- numeric acceptance budgets for the primary distribution, tail, jitter,
  callback deadline, underrun, resource, thermal, soak, and lifecycle criteria;
- calibration procedure, error budget, clock-alignment method, artifact plan,
  and responsible operator/reviewer.

Future capture or measurement execution is **Blocked** unless that manifest
also defines and receives approval for all of the following privacy and security
controls:

- data classification for every audio/MIDI capture, trace, log, device or user
  identifier, environment record, local path, and derived report;
- synthetic and non-personal input signals wherever they can satisfy the
  measurement boundary;
- informed consent and a controlled environment for any ambient or microphone
  capture that could record a person or third-party content;
- least-privilege application, device, microphone, MIDI, file, trace, and tool
  permissions, with no permission broadened merely for convenience;
- secret, credential, token, account, personal, device-identifier, and local-path
  redaction before an artifact leaves its approved capture environment;
- an approved local or access-controlled storage location, named authorized
  readers, and encryption at rest or in transit where applicable;
- explicit separate authority for every network transfer or external upload;
- artifact-specific retention periods, review checkpoints, and verified deletion
  procedures for raw and derived data; and
- a prohibition on public artifact links and on URLs containing credentials,
  tokens, signed access parameters, or other reusable authorization material.

Unset fields make the run `Blocked`, not failed. This report supplies no values
for owner-gated hardware or numeric acceptance budgets. Missing any privacy or
security control above also keeps execution `Blocked`.

### Gate 2: calibrate instruments and clocks

1. Prefer a shared acquisition clock for the event reference and audio capture.
   Record its configured rate and stated or measured resolution.
2. Measure the acquisition path with a direct electrical loopback or another
   declared reference. Record fixed input/output, cable, detector, actuator, and
   acoustic-path delays separately where they can be isolated.
3. If independent clocks are unavoidable, emit synchronized markers at the
   beginning and end, estimate offset and drift, document the alignment model,
   and include residual error in the uncertainty budget.
4. Capture repeated calibration trials before and after the measured run. Do not
   subtract a correction that lacks traceable evidence.
5. Store raw calibration artifacts and a machine-readable file containing the
   correction, uncertainty, clock drift, sample rate, and analysis version.

Calibration failure makes the result `Inconclusive` or `Blocked`; it must not be
silently discarded.

### Gate 3: record the environment and establish idle baselines

1. Record host and device clocks, timezone, ambient conditions, power state,
   battery level or external power, thermal state, radios/network state, audio
   route, volume/gain, and background-process policy.
2. Record exact application commit, build mode, compiler/toolchain and dependency
   versions, device model, OS build, controller, interface, and firmware.
3. Confirm the configured and observed sample rate and buffer values. A preferred
   value must not be recorded as actual without observation. [L1]
4. Capture an idle trace long enough to apply the approved baseline criterion,
   including CPU, memory, thermal state, callback-duration counters, deadline
   misses, underruns, queue occupancy, and event drops where available.
5. Preserve failures, warnings, and route negotiation in the raw artifacts.

### Gate 4: warm up and execute the declared workload

1. Start from the manifest's declared clean or repeatable application/device
   state and run the exact warm-up duration.
2. Exercise the declared workload. It must identify patch/voice/effects/routing
   bounds or a deliberately minimal reference path; terms such as “typical” or
   “heavy” are insufficient without exact parameters.
3. Execute the declared number of events, repetitions, and run duration using
   the approved schedule. Retain every trial, including outliers and failures.
4. Capture the event reference and output simultaneously for touch/MIDI/output
   measurements, or synchronized input and output for round trip.
5. Collect bounded callback counters outside the callback: callback durations,
   deadline misses, underruns, queue high-water marks, event drops, and recovery
   transitions. Instrumentation must not perform prohibited work in the callback.
6. Collect CPU and memory time series, thermal state, and relevant platform
   traces with tool versions and sampling intervals. Record profiler overhead and
   do not assume an instrumented run represents production behavior.

### Gate 5: exercise lifecycle and route scenarios

Run each separately from steady-state measurements so its boundary is clear.
The manifest must predeclare repetitions and expected safe state for:

- interruption begin/end and permitted resume behavior;
- built-in route activation;
- wired or USB connect, disconnect, and replacement;
- wireless connect, disconnect, renegotiation, and recovery where approved;
- background/foreground transitions where in scope;
- partial initialization, repeated start/stop, engine restart, and shutdown;
- Android stream disconnect/reopen and Apple route/interruption handling; and
- overload, producer overrun, queue exhaustion, and declared degradation.

Record audible failures, event loss, state transitions, callback health, resource
cleanup, restart time, and whether the system reached the predeclared safe state.
No route is assumed equivalent to another.

### Gate 6: perform the soak

Run the exact owner-approved soak duration and workload. Retain time series for
latency samples, distribution drift, callback duration, deadline misses,
underruns, CPU, memory growth, thermal state, battery/power condition, event
drops, and lifecycle events. A shorter run cannot satisfy a longer approved soak
criterion.

### Gate 7: analyze without hiding tails

For every device, OS, route, configuration, workload, and repetition, retain the
raw sample series and report at least:

- sample count, missing/censored samples, minimum, maximum, median, and mean;
- standard deviation plus a robust spread statistic such as median absolute
  deviation or interquartile range;
- the owner-approved percentiles, including declared upper-tail percentiles;
- peak-to-peak and distribution-based jitter as defined in the manifest;
- count and proportion above each approved latency budget;
- callback-duration distribution and count above the callback deadline;
- deadline misses, underruns, queue high-water marks, event drops, and recovery;
- CPU and memory summaries and time series;
- initial, maximum, and final thermal state, plus throttling indicators;
- soak-duration trends and lifecycle-scenario outcomes; and
- calibration correction, uncertainty, clock drift, and analysis limitations.

Do not pool different devices, OS builds, routes, workloads, or configurations
unless the aggregation was predeclared and each underlying result remains
available. A nominal frames/sample-rate calculation must remain labeled nominal.

### Gate 8: preserve raw artifacts and review independently

Retain immutable or content-hashed copies of:

- raw multichannel audio or acquisition captures;
- MIDI/event reference captures and timestamp series;
- callback, underrun, queue, CPU, memory, thermal, and platform traces;
- calibration captures and error calculations;
- device/OS/route/controller/interface and environment manifests;
- application logs produced outside the callback;
- exact commands, scripts, analysis source/version, and generated tables/plots;
- warnings, failed and inconclusive trials, and operator notes; and
- the completed evidence record below.

Retention must use only the approved local or access-controlled storage and
retention/deletion rules from Gate 1. Public links, credential-bearing links,
and unapproved network transfers are prohibited. Artifact copies must preserve
the approved redaction and encryption controls; hashing does not itself make
sensitive content safe to retain or disclose.

An independent reviewer must confirm boundaries, calibration, commit,
environment, artifacts, computations, exclusions, and conclusion scope. A rerun
is a new evidence record; it does not replace the earlier result.

## Required device and route coverage carried forward

The categories below are planning labels only. No model, OS, support commitment,
or successful result is implied.

| Required category | Exact model and OS | Evidence status |
| --- | --- | --- |
| Modern iPad Pro | Owner selection required | Not tested — no evidence recorded |
| Mainstream iPad | Owner selection required | Not tested — no evidence recorded |
| Older supported iPad | Owner selection and support decision required | Not tested — no evidence recorded |
| iPhone | Owner selection required | Not tested — no evidence recorded |
| Flagship Android tablet | Owner selection required | Not tested — no evidence recorded |
| Mainstream Android tablet | Owner selection required | Not tested — no evidence recorded |
| Flagship Android phone | Owner selection required | Not tested — no evidence recorded |
| Mainstream Android phone | Owner selection required | Not tested — no evidence recorded |

For each selected category, the procedure must distinguish:

- built-in input/output routes;
- wired headphone, line, or other approved built-in-device connector paths;
- wired/USB audio interface paths, with exact interface and firmware;
- wired/USB MIDI paths, with exact controller/interface and firmware; and
- wireless audio or MIDI paths, transport and negotiated mode.

Not every combination is pre-approved or necessarily required. The owner must
approve the route matrix and rationale. Route-specific performance remains
unknown until measured.

## Evidence-record template

Every future record must complete every field. Unknown values must be written as
`Unknown`; fields irrelevant to the declared procedure must be `Not applicable`.
They must not be guessed.

### Identity and required TEST_STRATEGY fields

- **Record ID:**
- **Primary quantity and exact start/end boundary:**
- **Command/procedure:** Exact command or numbered reproducible procedure,
  including the measurement method.
- **Date:** Date and timestamp with timezone.
- **Commit:** Full Git commit SHA of the tested state.
- **Environment:** Toolchain, dependency versions, host conditions, power,
  ambient and network/radio state.
- **Device:** Exact hardware model, or `Not applicable`; source of model identity.
- **OS:** Exact operating-system name, version, and build.
- **Simulator/physical status:** `Physical device`, `Simulator`, `Emulator`, or
  `Not applicable`.
- **Configuration:** Build mode, sample rate, requested and observed buffer,
  workload, connections, permissions, feature flags, route, gain/volume and
  session/stream mode.
- **Result:** `Pass`, `Fail`, `Blocked`, or `Inconclusive` against the predeclared
  criteria, with measured values where required.
- **Artifact/log location:** Approved local or access-controlled location for
  raw captures, logs, traces, recordings, reports, and content hashes. Never a
  public or credential-bearing link.
- **Reviewer:** Named person responsible for checking that the evidence supports
  the claim.

### Hardware and route

- **Device category:**
- **Audio route and endpoint:** Built-in, wired, USB, wireless, or other declared
  route; exact endpoint identity.
- **Audio interface:** Exact model, firmware, connection, or `Not applicable`.
- **MIDI controller/interface:** Exact model, firmware, transport, or
  `Not applicable`.
- **Measurement instruments:** Exact models, firmware/software, acquisition rate,
  channels, probes, actuator/detector/microphone, and cabling.

### Privacy, security, and retention

- **Data classification:** Classification for every raw and derived artifact,
  identifier, environment record, and path.
- **Synthetic/non-personal input plan:** How personal or ambient data is avoided
  where possible.
- **Ambient-capture consent:** Responsible person, consent record, controlled
  environment, or `Not applicable` with reason.
- **Least-privilege permissions:** Exact approved application, device, capture,
  file, and tracing permissions.
- **Redaction:** Secrets, credentials, tokens, accounts, personal/device
  identifiers, and local paths removed or transformed before transfer.
- **Approved storage and access:** Local or access-controlled location, named
  readers, and applicable encryption at rest/in transit.
- **Network-transfer authority:** Exact separate approval and destination, or
  `No network transfer authorized`.
- **Retention and deletion:** Per-artifact retention period, review checkpoint,
  deletion owner, procedure, and verification evidence.
- **Link safety:** Confirmation that no public or credential-bearing artifact
  URL is used.

### Calibration, clocks, and error

- **Calibration procedure and raw artifacts:**
- **Clock source and alignment method:**
- **Measured offset, drift, resolution, fixed delays and correction:**
- **Uncertainty/error budget and limitations:**
- **Pre-run and post-run calibration result:**

### Workload and execution

- **Warm-up duration:**
- **Measured run duration:**
- **Soak duration:**
- **Repetitions and event count:**
- **Event schedule and reset/cooldown:**
- **Exact signal and workload:**
- **Lifecycle and route scenarios:**
- **Environmental controls and deviations:**

### Predeclared acceptance criteria

- **Primary latency distribution and tail budgets:**
- **Jitter definition and budget:**
- **Callback deadline and duration budget:**
- **Underrun, deadline-miss, queue and event-drop budgets:**
- **CPU and memory budgets:**
- **Thermal, battery/power and soak budgets:**
- **Lifecycle safe-state and recovery criteria:**

### Results and raw evidence

- **Raw sample count and exclusions:**
- **Minimum/maximum/mean/median:**
- **Spread, approved percentiles and tails:**
- **Jitter:**
- **Callback durations and deadline misses:**
- **Underruns, queue occupancy and event drops:**
- **CPU, memory, thermal and soak observations:**
- **Lifecycle and recovery observations:**
- **Calibration/error applied:**
- **Warnings, failures and inconclusive trials:**
- **Raw artifact hashes and analysis version:**
- **Conclusion limited to tested scope:**
- **Missing evidence and follow-up:**

## Inferences

- A shared capture clock is likely to reduce alignment ambiguity for
  touch/MIDI-to-audible measurements, but the final instrument and calibration
  method require approval and validation.
- Round-trip correlation can support an audio I/O path measurement, but it
  cannot establish touch-to-audible or MIDI-to-audible behavior because their
  ingress boundaries differ. This follows from the documented quantity
  definitions and proposed boundaries. [L3][L4]
- Route and device variation require results to remain configuration-specific;
  cross-device pooling could conceal tails or route failures.

## Future-evaluation recommendations

1. Approve the complete procedure manifest, exact physical hardware, and numeric
   budgets before any run.
2. Begin with electrical loopback where the target boundary permits it, then add
   acoustic measurement only where audible-output behavior is the declared end
   boundary.
3. Capture event reference and audio on a common clock when practical; otherwise
   predeclare and validate clock alignment and drift correction.
4. Keep steady-state, lifecycle, route-change, overload, and soak evidence
   separate and preserve all raw trials.
5. Require QA/Performance review of the approved method and actual artifacts
   before using results in an architecture decision.

These are future evaluation recommendations, not approved actions.

## Disagreement

No direct contradiction was established. The platform sources define related
but different quantities and configuration values. A preferred I/O duration,
AAudio buffer or burst value, isolated output latency, and round-trip latency
must remain separately labeled. [L1][L2][L3]

## Missing evidence and owner decisions

- No procedure manifest, hardware, controller, interface, route matrix,
  instrument, workload, run parameter, or numeric acceptance budget is approved.
- No physical device, simulator, emulator, audio path, or MIDI path was operated.
- No calibration, trace, recording, benchmark, latency sample, callback timing,
  underrun count, CPU/memory/thermal observation, soak, or lifecycle result
  exists.
- Exact supported device models and OS versions remain owner decisions.
- Architecture and dependency selection, candidate versions, licensing,
  commercial use, redistribution, and distribution remain outside this report.

Until those gates are resolved and the procedure is executed and reviewed, all
route-specific performance and suitability remain unknown.
