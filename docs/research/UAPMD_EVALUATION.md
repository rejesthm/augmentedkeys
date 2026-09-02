# UAPMD objective evaluation

## Scope, status, and disposition

This report evaluates UAPMD only as a documentary candidate against the
AugmentedKeys M0 requirements and the verified R01 boundaries. It does not
adopt or reject an engine, approve a dependency, clear a license, select an
architecture, or establish behavior on a simulator, emulator, or physical
device.

The inspected public release identity was UAPMD `0.5.6`. The Researcher could
not resolve `github.com` with `git ls-remote` in the read-only sandbox, so the
full upstream commit, tag-object identity, submodule revisions, and raw-file
hashes were not established. GitHub displayed short commit `93c25a7` and the
rendered release label `18 Aug 12:41`, without a complete timestamp or timezone
in the retrieved text. Claims below are therefore bounded to the rendered
maintainer material available during the recorded access window, not to a
source audit of a frozen revision.

The U1 platform-format table is explicitly qualified by the maintainer's note
that a handful of formats are experimental. The retrieved text does not name
which formats carry that status, so format-by-format maturity is unavailable
and no listed format is classified as production-ready here. [U1]

**Disposition: `retain for later spike comparison`.**

This means only that the documented modularity and stated mobile/plugin paths
justify preserving UAPMD as one input to later, separately authorized
comparison. It is not architecture selection, implementation authorization,
dependency approval, distribution or license clearance, or evidence of
reliability, compatibility, continuity, real-time safety, or low latency.

## Inputs and method

- Bounded brief: `8652877b5d87706739076da4bdc69a72fd9c01ba`.
- R02 in-progress state: `28bad9934dd6591e578692a14215f0b51d5d5e2c`.
- Researcher evidence: `2c263e8b71acd26fa4d8e115fe87e7f166bc4b05`.
- Verified R01 candidate: `09266fdc17e137db44495d85c6b42cf296efb89c`.
- Finalized R01 verification: `1c3d4618b1cbf2c583f2c4950800edaab58ee185`.
- Research environment: macOS `26.6.1` (`25G76`), arm64, Git `2.50.1`.
- Device and simulator status: `Not applicable`; none was operated.
- Primary-source access window: `2026-09-02T14:46:52+0800` through
  `2026-09-02T14:46:56+0800`, with earlier corroborating retrieval on the same
  date.

The evaluation is deliberately unweighted. Numeric scoring would manufacture
precision while the exact source revision, resolved component graph, callback
behavior, lifecycle contracts, build reproducibility, and device results are
unknown. Each conclusion is instead classified as fact, inference,
recommendation, disagreement, missing evidence, or owner decision.

## Source register and retrieval limits

| ID | Primary or maintainer source | Observed identity or purpose | Access and limitation |
| --- | --- | --- | --- |
| U1 | UAPMD maintainer, [repository](https://github.com/atsushieno/uapmd) | Project identity, platform/component tables, build and license descriptions | Accessed 2026-09-02; rendered text was 427 lines; live and moving; no frozen full SHA or raw-file hash |
| U2 | UAPMD maintainer, [release `0.5.6`](https://github.com/atsushieno/uapmd/releases/tag/0.5.6) | Displayed release identity and real-time, graph, document, and shutdown fixes | Accessed 2026-09-02; rendered text was 208 lines; only short commit `93c25a7` and incomplete rendered date were available |
| U3 | UAPMD maintainer, [release history](https://github.com/atsushieno/uapmd/releases) | Earlier compatibility and AAP dependency statements | Accessed 2026-09-02; live release index |
| U4 | UAPMD maintainer, [Actions](https://github.com/atsushieno/uapmd/actions) | Visible workflow names and activity signals | Accessed 2026-09-02; rendered text was 396 lines; presence is not proof of passing builds or reproducibility |
| AAP1 | AAP maintainer, [aap-core](https://github.com/atsushieno/aap-core) | Binder/shared-memory hosting description and maturity caveats | Accessed 2026-09-02; rendered text was 328 lines; AAP statements are not proof of UAPMD behavior |
| A1 | Apple, [Audio Unit v3 plug-ins](https://developer.apple.com/documentation/audiotoolbox/audio-unit-v3-plug-ins) | Official AUv3 app-extension model | Accessed 2026-09-02; live documentation |
| A2 | Apple, [`AVAudioUnit` asynchronous instantiation](https://developer.apple.com/documentation/avfaudio/avaudiounit/instantiate(with:options:completionhandler:)) | Official asynchronous instantiation boundary | Accessed 2026-09-02; live documentation |
| A3 | Apple, [AVAudioEngine](https://developer.apple.com/documentation/avfaudio/avaudioengine) | R01 platform-native graph baseline | Accessed 2026-09-02; live and unversioned |
| A4 | Apple, [Responding to audio route changes](https://developer.apple.com/documentation/avfaudio/responding-to-audio-route-changes) | R01 lifecycle baseline | Accessed 2026-09-02; live and unversioned |
| D1 | Android Developers, [AAudio](https://developer.android.com/ndk/guides/audio/aaudio/aaudio) | R01 platform-native stream/lifecycle baseline | Accessed 2026-09-02; live guidance |
| D2 | Google, [Oboe README at `2a45aa2d9e94d209c4636eec4014dd83cda110f4`](https://github.com/google/oboe/blob/2a45aa2d9e94d209c4636eec4014dd83cda110f4/README.md) | Immutable Android abstraction baseline | Accessed 2026-09-02; content commit is not asserted to equal a release tag |
| C1 | JUCE maintainers, [README at `7aae7d8e8deb8413bb01633d2795ef9974a181c5`](https://github.com/juce-framework/JUCE/blob/7aae7d8e8deb8413bb01633d2795ef9974a181c5/README.md) | Portable framework/hosting comparison carried from R01 | Accessed 2026-09-02; immutable content commit, not asserted to be release `9.0.1` |
| C2 | RustAudio, [CPAL `v0.18.2` README](https://github.com/RustAudio/cpal/blob/e1612d5d98152f8dc2a62e1b51ef7cbf4f7f26b7/README.md) | Lower-level portable I/O comparison carried from R01 | Accessed 2026-09-02; immutable content |
| C3 | miniaudio maintainer, [README at `9634bedb5b5a2ca38c1ee7108a9358a4e233f14d`](https://github.com/mackron/miniaudio/blob/9634bedb5b5a2ca38c1ee7108a9358a4e233f14d/README.md) | Lower-level portable I/O comparison carried from R01 | Accessed 2026-09-02; immutable `0.11.25` content |

No repository was cloned, no submodule was initialized, no package was
resolved, and no source, build, test, benchmark, simulator, emulator, or device
procedure was run for UAPMD. Source absence is recorded as a gap, never as proof
that a capability is safe, unsafe, supported, or unsupported.

## Evaluation boundary derived from AugmentedKeys and R01

The decision-relevant boundary is a reliable, offline live-keyboard playing
path on Android phones/tablets and iPhone/iPad. Reliability precedes latency,
audio continuity, usability, and features. A future audio callback must not do
blocking work, I/O, UI work, parsing, allocation, arbitrary lock waiting, or
potentially blocking logging. Control transfer must be bounded, with prepared
state and explicit lifetime ownership. Platform adapters must own routing,
interruption, disconnection, restart, teardown, and error recovery rather than
assuming Apple and Android equivalence.

R01 retained a platform-native ownership baseline: Apple session/graph and
lifecycle responsibilities on Apple; Android stream/device/lifecycle
responsibilities on Android; and a possible portable native DSP/control
boundary behind explicit control-plane and real-time-plane separation. R01 did
not select that architecture. It requires later callback audits, bounded queue
proof, repeated lifecycle tests, and reproducible physical-device measurement
before any adoption or performance conclusion.

### Requirements matrix

| Requirement | Documentary observation for UAPMD `0.5.6` | Evaluation | Evidence still required |
| --- | --- | --- | --- |
| Android phones and tablets | UAPMD lists Android with AAP and a Gradle build command; Android virtual MIDI 2.0 devices are described as missing while AAP has static support. [U1] | Stated platform path, not device coverage or production readiness | Frozen source/build, API/NDK range, exact devices/OS versions, routes, lifecycle, service/process failure, continuity, and measurement |
| iPhone and iPad | UAPMD lists iOS with AUv3 and an iOS simulator build script. [U1] | Stated platform path, not proof of phone/tablet parity, runtime success, or store viability | Minimum OS and device matrix, AUv3 discovery/instantiation/UI/process behavior, session/route/interruption ownership, teardown, distribution, and device evidence |
| Offline core playing | The documented project includes local engine, project/file, plugin, scanning, and state functions; it also documents JavaScript, MCP, remote scanning, and other broad surfaces. [U1] | Local components suggest offline operation is possible, but no source/runtime evidence proves the playing path has no network dependency | Frozen dependency graph, startup/playback trace, network isolation audit, failure behavior with network absent, and explicit offline contract |
| Reliability before features | Release `0.5.6` reports fixes for real-time-thread DFT work, snapshot publication, shutdown crash, and graph defects. [U2] | Evidence of active defect correction and of reliability-sensitive defects in the release line; not a reliability result | Reproducible tests, failure injection, lifecycle/recovery matrix, soak evidence, defect-regression evidence, and supported configuration contract |
| Hard real-time callback prohibitions | The release reports replacing a non-real-time-safe snapshot publisher and moving document mutations asynchronously. [U2] | Attention to relevant hazards; no complete callback call graph or prohibition audit | Allocation, lock, I/O, logging, destruction, parsing, plugin-call, graph-mutation, queue-bound, and overload audit at an immutable revision |
| Lifecycle, routing, and error ownership | Apple AUv3 and Android AAP paths are named, but the retrieved UAPMD material did not establish session/route/interruption/disconnect/restart ownership or recovery policy. [U1][A1][A2][AAP1] | Material gap on a primary product requirement | Platform-specific contracts, repeated transition tests, plugin failure containment, teardown ordering, and observable error propagation |
| Bounded control transfer | UAPMD documents UMP-oriented events and parameters; `0.5.6` refers to snapshot publication and asynchronous document mutations. [U1][U2] | Potentially relevant design signals, but no capacity, overflow, ordering, lifetime, or worst-case proof | Queue/command schema, capacities, overflow policy, prepare/swap/retire protocol, ownership proof, and deterministic stress tests |
| Future measurable latency | UAPMD describes graph and latency-compensation capabilities. [U1] | Graph compensation is not end-to-end latency evidence | R01-approved measurement budgets and method, callback timing, underruns, MIDI/touch-to-audible distributions, routes, workloads, and physical devices |
| Future audio continuity | No run or measurement was performed; recent shutdown/graph fixes are not continuity evidence. [U2] | Unknown | Route/interruption/restart/overload/teardown scenarios, artifacted glitches/dropouts/underruns, and approved soak duration |
| Maintainable bounded integration | Modular components are described, but the system also spans hosting, sequencing, persistence, scripting, remote scanning, MCP, SDKs, fonts, submodules, and fetched dependencies. [U1] | Modularity is a strength; breadth increases integration, supply-chain, lifecycle, and ownership cost | Exact component subset, stable API/ABI boundary, build/toolchain reproduction, dependency/license graph, update policy, and diagnostics contract |

No row establishes a documented mismatch with a named requirement. The gaps are
material enough to prevent adoption, but not enough to conclude technical
unsuitability.

## Documented components and data-flow boundaries

### Observed facts

- `remidy` is described as a plugin API abstraction with UMP-oriented event and
  parameter handling. [U1]
- `remidy-tooling` is described as providing plugin scanning and instancing.
  [U1]
- `uapmd` and `uapmd-engine` are described as virtual MIDI 2.0 and graph/engine
  foundations. [U1]
- `uapmd-data` is described as track, clip, project, and real-time data
  provision. [U1]
- `uapmd-file` is described as file and document APIs. [U1]
- `uapmd-app` is described as coordinating scanning, instancing, control,
  virtual devices, and state persistence. [U1]
- Maintainer material describes project save/load, plugin binary state, a
  directed acyclic graph, latency compensation, remote scanning, offline
  rendering, JavaScript, and MCP surfaces. [U1]

U1 explicitly documents JavaScript and MCP as access surfaces, but it does not
provide a UAPMD implementation-language inventory; the rendered GitHub
`Languages` section was unavailable in the retained response. CMake, Gradle,
and platform build scripts are documented build interfaces, not evidence of
the implementation languages behind each UAPMD module. AAP1 separately
documents a C public plugin API and reference-purpose C++ and Kotlin hosting
APIs, but those AAP language surfaces are not attributed to UAPMD itself.
[U1][AAP1]

### Inferred documentary flow

A plausible documentary flow is UMP/MIDI input through event and parameter
abstractions into instantiated plugins and an audio graph, with sequencer or
project data providing prepared state and application/file layers handling
persistence. This inference connects module descriptions; it is not a traced
call graph and says nothing about thread, ownership, deadline, or failure
behavior.

The split may allow a future subset to be evaluated independently, but no
retrieved evidence established that `uapmd-engine` can be isolated from the app,
file, scanner, scripting, network-facing, or plugin-host surfaces with a stable
mobile ABI. The exact module subset and every transitive dependency remain
unknown.

### Boundary questions

- Which module owns the hardware audio callback on each platform?
- Which plugin APIs can execute on that callback, and with what allocation,
  locking, I/O, logging, reentrancy, and lifetime guarantees?
- Where are UMP events timestamped, queued, transformed, and dropped under
  pressure?
- Where are graphs, documents, plugin instances, and binary state prepared,
  published, retired, and destroyed?
- Which errors cross the engine/app boundary, and which component owns retry,
  silence, bypass, restart, quarantine, and user-visible diagnostics?
- Can all file, scan, persistence, JavaScript, MCP, remote, and UI work be proven
  unreachable from the playing callback?

## Apple evaluation: iOS/iPadOS and AUv3

### Facts

UAPMD's platform table lists iOS with AUv3 and documents an iOS simulator build
script. [U1] Apple documents AUv3 as an app-extension model and documents
asynchronous `AVAudioUnit` instantiation, with options involving in-process or
extension-process behavior. [A1][A2]

### Inferences and gaps

The named AUv3 path suggests potential access to Apple's plugin ecosystem. It
does not prove that UAPMD correctly owns `AVAudioSession`, graph activation,
route changes, interruptions, media-services resets, background transitions,
extension discovery, asynchronous failure, UI containment, process death,
state restoration, or teardown. It also does not establish iPhone/iPad
equivalence, supported OS versions, device compatibility, App Store viability,
continuity, or performance.

The simulator build script is documentary build guidance only. A simulator
build would not substitute for runtime or physical-device evidence even if it
had been run; it was not run here.

### Smallest later Apple spike

If separately authorized, freeze an exact UAPMD/component revision and one AUv3
test plugin, then exercise discovery, asynchronous instantiation, render,
state save/restore, plugin failure, interruption, route change, restart, and
teardown behind a declared session/graph owner. Record callback and lifecycle
artifacts, but make no latency or continuity decision until the approved R01
physical-device method and budgets are supplied.

## Android evaluation: AAP and AAP-JUCE boundary

### Facts

UAPMD's platform table lists Android with AAP and a Gradle build command. It
states that Android virtual MIDI 2.0 devices are missing while AAP has static
support. [U1] Release `0.5.0` describes an incompatible AudioPluginService V4
transition, and `0.5.1` says it requires AAP `0.11.1`, not `0.11.0`. [U3] This
does not identify the exact AAP revision resolved by `0.5.6`.

The AAP maintainer describes a host boundary using Binder IPC and shared memory
and characterizes hosting APIs as reference-level or unstable, with
documentation that may be obsolete or ahead of implementation. [AAP1] Those
are AAP facts, not verified UAPMD behavior. No separate source-backed claim for
the exact AAP-JUCE revision or integration behavior was available in the R02
packet.

### Inferences and gaps

The AAP path offers a stated Android plugin-host route but adds process,
shared-memory, service, protocol-version, and failure-recovery boundaries that
do not mirror AUv3. The compatibility change and documentation caveat increase
the need to pin every revision and protocol. They do not prove that UAPMD or AAP
is unsuitable.

Unknowns include API/NDK ranges, vendor and device coverage, AAP/AAP-JUCE
versions, Binder and shared-memory deadline behavior, service/UI lifecycle,
permissions, plugin crash/stall containment, disconnect and reopen policy,
buffer negotiation, teardown, store/distribution constraints, and physical
device performance.

### Smallest later Android spike

If separately authorized, freeze UAPMD, AAP, AAP-JUCE, one host, and one test
plugin revision; declare the service/process topology; then exercise scan,
instance, render, state, plugin crash/stall, service restart, stream disconnect,
reopen, and teardown. Record bounded IPC/shared-memory behavior and failure
artifacts. Apply the R01 physical-device method only after devices, routes,
workloads, and numeric budgets are owner-approved.

Apple and Android must remain separate evaluations. Neither platform statement
establishes parity with the other.

## Deliberately small comparison baseline

| Dimension | Platform-native ownership plus portable DSP/control boundary | UAPMD `0.5.6` documentary candidate | JUCE documentary candidate | CPAL/miniaudio lower-level candidates |
| --- | --- | --- | --- | --- |
| Intended breadth | Narrow inferred live-instrument boundary with platform lifecycle adapters | Sequencer, graph, plugin host, MIDI 2.0, persistence, scanning, scripting/remote surfaces | Broad cross-platform application/plugin framework | Primarily portable audio I/O foundations |
| Mobile platform claim | Native APIs are platform-specific by definition; proposed portable core remains unimplemented | States iOS/AUv3 and Android/AAP support [U1] | R01 immutable README states mobile project and plugin/host scope [C1] | R01 immutable READMEs state iOS/Android backend coverage [C2][C3] |
| Plugin hosting | Would require separate platform-specific host research | Central documented capability through AUv3/AAP and abstraction layers | Documented framework scope includes plugins/hosting | Not the principal documentary scope |
| MIDI/sequencing | Must be separately designed and evaluated | UMP/MIDI 2.0, tracks, clips, projects, virtual devices are documented | Requires later version-specific evaluation | Requires separate MIDI/sequencer layer |
| Lifecycle ownership | Explicit platform ownership is the baseline question | Not established by retrieved material | Not established for AugmentedKeys | Backend coverage does not establish full app lifecycle ownership |
| Real-time proof | None; R01 defines required future audit/measurement | Relevant fixes are documented, but full proof is absent [U2] | None for AugmentedKeys | None for AugmentedKeys |
| Integration surface | Potentially narrow but would require new ABI and ownership design | Modular, but broad component/dependency/security surface | Broad framework/toolchain surface | Smaller audio layer, with language/FFI/backend costs |
| License status | No implementation or dependency selected | Maintainer-stated MIT/Apache split; graph not cleared | Version-specific review required | Version-specific review required |
| Decision status | Inferred baseline, not selected | Retained for later comparison | Documentary candidate from R01 | Documentary candidates from R01 |

UAPMD's decision-relevant strengths are its stated cross-platform plugin paths,
modular decomposition, UMP/MIDI 2.0 orientation, graph/sequencer foundations,
and explicit attention in recent release notes to snapshot, graph, shutdown, and
real-time-thread defects. Its decision-relevant risks are breadth beyond the
minimum playing core, a sub-1.0 and changing hosting line, unknown lifecycle and
callback contracts, unpinned source/dependencies, and a large licensing and
security surface.

## Real-time, threading, lifecycle, and recovery audit

### Facts from the inspected release material

Release `0.5.6` reports fixes involving discrete Fourier transform work on the
real-time thread, a non-real-time-safe snapshot publication mechanism, a
shutdown crash, graph defects, a replacement snapshot publisher, and
asynchronous document mutations. [U2]

### Inference

The release notes show that maintainers recognize real-time and lifetime
hazards and have changed the design in response. They also show that such
hazards existed in the release line. Neither observation establishes that the
replacement path satisfies AugmentedKeys' stricter callback prohibitions or
that all affected paths were found.

### Missing evidence checklist

- Complete callback entry points and transitive call graph.
- Allocation, deallocation, final-reference release, and destructor behavior.
- Locking, atomics, retry bounds, queue capacity, overflow, and backpressure.
- File, device, database, network, parsing, logging, diagnostics, and UI reachability.
- Graph mutation, snapshot publication, resource swap, and retirement ownership.
- Plugin calls, reentrancy, exception/error behavior, stalls, crashes, and bypass.
- MIDI/UMP timestamp, ordering, capacity, late-event, and drop behavior.
- Startup, repeated start/stop, interruption, route change, disconnect, restart,
  background/foreground, teardown, and partial-failure behavior.
- Deadline, underrun, overload, silence, maximum-workload, and soak evidence.
- Bounded diagnostics drained away from the callback.

Absence of this evidence is neither proof of safety nor proof of unsafety.

## Documentary maturity and maintainability

### Observed signals

At access, GitHub displayed release `0.5.6`, 1,686 commits, 12 visible issues,
workflows including `build android` and `build dist`, and 1,208 workflow runs.
[U1][U4] The project supplies component descriptions, platform/build guidance,
release notes, examples of broad host/sequencer responsibilities, and recent
defect history.

U2 names added undo integration tests, project-file identity tests, and a
considerably expanded sequencer-engine output test suite. These are documentary
release-note signals only: none of those tests was executed in R02, and no
passing result or coverage claim follows from their names. [U2]

### Assessment

These signals show visible maintenance activity and documentary breadth. They
do not establish that any workflow passed for the inspected release, that a
clean build is reproducible, that tests cover decision-relevant paths, or that
the APIs are stable. The sub-1.0 release identity, incompatible AAP transition,
dependency-version correction, recent real-time/shutdown fixes, and AAP's own
documentation warning leave stability and integration cost uncertain.

Still missing are exact supported toolchain and OS ranges, immutable build
instructions, dependency lock/revision data, test inventory and results,
coverage of mobile lifecycle/failure paths, API/ABI stability policy, bus and
format negotiation contracts, error taxonomy, diagnostics guarantees, release
support policy, and evidence for every maintained module needed by a bounded
AugmentedKeys subset.

## Licensing, dependency, security, and supply-chain boundary

### Documentary license facts

The maintainer documentation characterizes most UAPMD code as MIT and identifies
Apache-2.0 modules including `uapmd-ara` and `uapmd-mir`. Release notes state
that enabling ARA changes the whole application's stated license to
Apache-2.0. [U1][U2] These are maintainer statements, not legal advice,
item-by-item verification, commercial-use approval, or redistribution
clearance.

### Known surface and open questions

The project documentation identifies submodules, CMake `FetchContent`, directly
included libraries, optional ML/model features, plugin SDKs, queues/logging
libraries, and fonts across multiple license families. It also describes
JavaScript, MCP, remote scanning, plugin binaries and binary state, listeners,
and Android process boundaries. [U1]

R07 must freeze and audit the complete selected graph: direct and transitive
source revisions, downloads, optional features, generated or bundled material,
license texts, notices, attribution/source obligations, commercial use,
redistribution, SDK terms, plugin and font licenses, model provenance,
trademark/patent questions, and the application-level effect of ARA. No item is
adopted in R02.

Security review must separately cover untrusted plugin code and state,
scanner/process isolation, Binder/shared-memory validation, file/project input,
JavaScript and MCP execution, remote listeners and authentication, networking,
permissions, privacy, credentials/tokens, local paths and device identifiers,
retention, update/provenance controls, denial of service, crash recovery, and
diagnostic redaction. The retrieved material does not clear these questions.

## Classified findings

### Facts

- The official maintainer repository identifies UAPMD as “Ubiquitous Audio
  Plugin MIDI Device” and describes a modular sequencer/plugin-host engine.
  [U1]
- The displayed inspected release was `0.5.6`; only short commit `93c25a7` and
  an incomplete rendered publication label were available. [U2]
- Maintainer tables state iOS/AUv3 and Android/AAP paths and describe modular
  engine, data, file, tooling, application, MIDI 2.0, graph, scanning, and state
  responsibilities. [U1]
- Release notes record real-time-thread, snapshot, graph, asynchronous document,
  and shutdown changes. [U2]
- Maintainer material states a mostly-MIT/selected-Apache-2.0 license split and
  an ARA-related application-license effect. [U1][U2]

### Inferences

- The documented modules suggest a UMP/MIDI-to-plugin-event-to-audio-graph flow
  with sequencer/project data and persistence, but this has not been traced.
- The modular structure could support a bounded subset, while the complete
  application breadth may impose unnecessary lifecycle, security, licensing,
  and maintenance cost for a live instrument.
- Recent fixes indicate active attention to real-time and lifetime risks and
  justify deeper audit; they do not prove safety or instability of `0.5.6` as a
  whole.

### Recommendations for later authorized work

1. Freeze full immutable revisions for UAPMD and every selected submodule,
   fetched component, plugin SDK, AAP/AAP-JUCE component, and optional feature.
2. Define the smallest candidate module subset and a stable ownership/ABI
   boundary before any build or spike.
3. Audit the complete callback and lifecycle paths before using performance
   language.
4. Run separate Apple AUv3 and Android AAP failure/recovery spikes; do not infer
   ecosystem parity.
5. Apply R07 licensing/security review before adoption and the R01 physical-
   device procedure only after its method, devices, routes, workloads, and
   budgets are approved.

These recommendations describe future evidence gathering, not current authority.

### Disagreements

No direct contradiction between primary sources was established. AAP's warning
that hosting APIs/documentation may be reference-level, unstable, obsolete, or
ahead of implementation limits confidence in broad Android support statements;
it does not directly contradict UAPMD's platform table.

### Missing evidence

- Full release/tag commit and raw source/document hashes.
- Exact submodule, fetched dependency, optional-feature, AAP, and AAP-JUCE graph.
- Successful reproducible builds, test inventory/results, examples, and CI result
  for the exact revision and toolchains.
- Supported Apple/Android OS versions, devices, routes, plugin formats, buses,
  sample formats, channel layouts, and failure contracts.
- Complete callback/threading/lifetime audit and bounded-control proof.
- Lifecycle, interruption, route, service, plugin failure, teardown, and recovery
  behavior.
- Offline-path and network-isolation proof.
- Permission, privacy, credential, security, supply-chain, and license clearance.
- Simulator, emulator, physical-device, audio, MIDI, latency, continuity,
  callback, underrun, overload, thermal, battery, or soak evidence.

### Owner decisions

Before any further UAPMD work, the owner must decide whether to authorize a
bounded source audit or spike; the exact immutable module/version scope; whether
plugin hosting belongs in that spike; separate Apple and Android procedures;
approved devices, OS versions, routes, controllers, interfaces, workloads, and
numeric budgets; licensing/security review scope; and, only after evidence,
whether UAPMD enters an ADR comparison. R02 makes none of those decisions.

## Acceptance-criteria trace

| Criterion | Coverage in this report |
| ---: | --- |
| 1 | Inspected identity, displayed release/short commit, access window, license statements, activity, and immutable-identity limitations |
| 2 | Requirements and evaluation matrix derived from AugmentedKeys and verified R01 boundaries |
| 3 | Component facts, inferred data flow, ownership questions, and fact/inference separation |
| 4 | Independent Apple/AUv3 and Android/AAP evaluations with no parity inference |
| 5 | Deliberately small unweighted comparison against platform-native/portable boundary, JUCE, CPAL, and miniaudio |
| 6 | Real-time, threading, allocation, lock, I/O, logging, graph, lifecycle, plugin failure, teardown, and recovery evidence audit |
| 7 | Release/activity/build-document signals and explicit maturity, stability, diagnostics, contract, and reproducibility gaps |
| 8 | License, dependency, asset, permission, privacy, credential, redistribution, commercial-use, trademark/patent, and supply-chain questions without legal advice |
| 9 | Classified facts, inferences, recommendations, disagreement, missing evidence, strengths/risks, disqualifier hypotheses, smallest spikes, measurements, and owner decisions |
| 10 | Documentary, non-adoptive `retain for later spike comparison` disposition |

## Disqualifier hypotheses for later testing

The following are hypotheses, not findings. A later exact-revision audit or
spike should reject the evaluated subset if it demonstrates an unavoidable
named-requirement conflict, such as callback-reachable allocation/blocking/I/O;
unbounded or unsafe state transfer; inability to isolate network, scan, script,
or persistence work from playing; uncontainable plugin/process failure;
unowned platform lifecycle and recovery; an irreconcilable license or
redistribution constraint; or failure against approved physical-device
continuity and latency budgets. No such disqualifier was proven in R02.

## Final limitations

This report is a documentary synthesis of the committed Researcher packet and
verified repository controls. It contains no cloned or executed UAPMD source,
resolved dependency graph, build, test, benchmark, simulator/emulator run,
physical-device run, audio or MIDI path, callback trace, latency sample,
continuity result, license clearance, security approval, architecture decision,
or implementation. Moving web material may change after the recorded access
window. The retained disposition must be revisited against immutable evidence
before any spike or ADR comparison.
