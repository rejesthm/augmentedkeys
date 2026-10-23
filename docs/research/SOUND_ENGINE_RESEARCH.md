# Built-in sound engine and format research

## Status and decision boundary

This is the R06 documentary report under brief b5a85d4a36827d00d83ca727de2c6e72093b8861. Sources were accessed on 2026-10-23. The controller captured 50 requests, 50 HTTP 200 bodies, and no retained failures. The canonical URL, timestamp, byte-count, and full SHA-256 register is docs/orchestration/milestones/m0/evidence/r06-sources.md at controller milestone ce9d12a34ea19044d366cb5cdca6e3309389505b. The four immutable raw indexes are index-initial.json, index-tree.json, index-pinned.json, and index-supplement.json in the controller evidence area. This report compares three deliberately different documentary candidates:

- FluidSynth 2.6.1 as a featureful SoundFont 2 renderer.
- TinySoundFont commit 853a0a171759f1ddba0de1442133a75912bbeffa as a compact SoundFont 2 subset.
- sfizz 1.2.3 as an SFZ parser and sample renderer.

They are comparators, not a selection. The app remains a Flutter shell. No engine, format, native boundary, minimum OS, dependency, sound source, patch, sample, content, hardware, or performance budget is selected or adopted. No source archive, package, project, SDK, sample, patch, SoundFont binary, build, simulator, device, controller, audio path, benchmark, or profiler was used. A future delivered piano still requires an approved real piano source. A placeholder tone cannot satisfy that requirement. Evidence labels in this report are:

- Fact: directly supported by an inspected body.
- Inference: a bounded implication of one or more facts.
- Recommendation: proposed future work, not adopted.
- Disagreement: evidence that cannot be reconciled without later work.
- Missing evidence: a claim the corpus cannot establish.
- Owner decision: a choice outside R06 authority.

## Source authority and identity

| Candidate or format | Exact identity | Authority and limit |
| --- | --- | --- |
| FluidSynth | Release v2.6.1, commit 71e85b2ca6bf48641ba7e2261d8f2640ae473773 | S17 resolves the tag; S20–S28 are pinned bodies. S02 HEAD is a different revision. |
| sfizz | Release 1.2.3, commit 4e70dc0bef53b41f2853ed46e26f5911114c92d0 | S18 resolves the release; S29–S34 and S44–S45 are pinned. S05 develop HEAD is different. |
| TinySoundFont | Commit 853a0a171759f1ddba0de1442133a75912bbeffa; header says version 0.9 | S08 resolves current HEAD; S35–S37 are pinned. S09 contains no API releases, so 0.9 is not treated as a published release. |
| SoundFont | S42, 69-page SynthFont-hosted mirror | Cover says Version 2.04 dated 2006-02-03; revision table says 2.04 dated 2002-09-10; legacy footers say 2.01 printed 1996. Original publisher endpoint was not retrieved. |
| SFZ | S19/S43/S46–S50 community-maintained references | Useful for syntax and opcode descriptions, but not one exhaustive normative publisher specification. Exact engine support controls compatibility claims. |

S04 reports sfizz archived=true. The 2026-06-21 archive notice comes from S12 HTML, not an API archive-date field. Archive status does not prove abandonment, insecurity, incompatibility, or a successor. S03 identifies FluidSynth 2.6.1 publication on 2026-09-19. S06 reports the sfizz 1.2.3 GitHub release event on 2024-01-14. S40 reports the website announcement on 2024-01-15. Those are different events. S41 displays FluidSynth API documentation version 2.5.4 and is not silently treated as 2.6.1 evidence. S21 contains Android and iOS CI badge links. Badges establish repository configuration links only; they are not current build, runtime, device, latency, or support proof.

## Claim-to-source matrix

All URLs below were captured on 2026-10-23; full body hashes remain in the canonical register.

| Claim ID | Source and exact URL | Anchor | Supported claim |
| --- | --- | --- | --- |
| C01 | S17 https://api.github.com/repos/FluidSynth/fluidsynth/commits/v2.6.1 | tag resolution | FluidSynth v2.6.1 resolves to 71e85b2ca6bf48641ba7e2261d8f2640ae473773. |
| C02 | S18 https://api.github.com/repos/sfztools/sfizz/commits/1.2.3 | release resolution | sfizz 1.2.3 resolves to 4e70dc0bef53b41f2853ed46e26f5911114c92d0. |
| C03 | S08 https://api.github.com/repos/schellingb/TinySoundFont/commits/HEAD and S09 releases endpoint | commit and empty release list | TinySoundFont is pinned to the named commit; no API release exists in the capture. |
| C04 | S42 https://www.synthfont.com/sfspec24.pdf | pp. 7–15 and 20–40 | Historical SF2 RIFF, bank, preset, instrument, zone, sample, generator, modulator, loop, envelope, filter, and interpolation model. |
| C05 | S23 https://raw.githubusercontent.com/FluidSynth/fluidsynth/71e85b2ca6bf48641ba7e2261d8f2640ae473773/include/fluidsynth/synth.h | lines 69–100, 162–297, 350–387 | MIDI control, separate all-notes/all-sounds calls, effects, interpolation, sizing, and caller-buffer render APIs. |
| C06 | S24 https://raw.githubusercontent.com/FluidSynth/fluidsynth/71e85b2ca6bf48641ba7e2261d8f2640ae473773/doc/fluidsettings.xml | dynamic-sample-loading, polyphony, effects-groups, sample-rate, threadsafe-api | Dynamic loading, voice capacity, effects, rate, and locking settings. |
| C07 | S25 https://raw.githubusercontent.com/FluidSynth/fluidsynth/71e85b2ca6bf48641ba7e2261d8f2640ae473773/doc/usage/loading_soundfonts.txt and S28 https://raw.githubusercontent.com/FluidSynth/fluidsynth/71e85b2ca6bf48641ba7e2261d8f2640ae473773/src/synth/fluid_synth.c | sfload; fluid_synth_set_polyphony; fluid_synth_process; unload/reload paths | Stack-oriented SoundFont state, allocation, rendering, and lifecycle behavior. |
| C08 | S27 https://raw.githubusercontent.com/FluidSynth/fluidsynth/71e85b2ca6bf48641ba7e2261d8f2640ae473773/doc/android/README.md and S22 https://raw.githubusercontent.com/FluidSynth/fluidsynth/71e85b2ca6bf48641ba7e2261d8f2640ae473773/CMakeLists.txt | README lines 3–40; CMake options 88–89 and 704–760 | Documented Oboe/OpenSL ES and asset-loader surfaces at the release; no device proof. |
| C09 | S32 https://raw.githubusercontent.com/sfztools/sfizz/4e70dc0bef53b41f2853ed46e26f5911114c92d0/src/sfizz.h | lines 87–170, 330–460, 710–920, 1010–1090 | Creation, control-thread loading, ordered events, block limits, voice/preload controls, render, and recovery surfaces. |
| C10 | S33 https://raw.githubusercontent.com/sfztools/sfizz/4e70dc0bef53b41f2853ed46e26f5911114c92d0/src/sfizz/FilePool.cpp and S34 https://raw.githubusercontent.com/sfztools/sfizz/4e70dc0bef53b41f2853ed46e26f5911114c92d0/src/sfizz/Synth.cpp | FilePool lines 426–577; Synth render and voice paths 85–550, 1091–1245, 1302–1400 | Preload/stream/worker paths, effect buses, voices, stealing, and bounded render-path implementation evidence. |
| C11 | S39 https://www.sfz.tools/sfizz/development/status/ | coverage table | Reported SFZ v1/v2/ARIA coverage is 96%/44%/45%, so universal SFZ support is unsupported. |
| C12 | S44 https://raw.githubusercontent.com/sfztools/sfizz/4e70dc0bef53b41f2853ed46e26f5911114c92d0/cmake/SfizzDeps.cmake and S45 https://raw.githubusercontent.com/sfztools/sfizz/4e70dc0bef53b41f2853ed46e26f5911114c92d0/cmake/SfizzConfig.cmake | dependency declarations; C++14 and build-option summary | Toolchain and optional dependency surface; not a selected build graph. |
| C13 | S37 https://raw.githubusercontent.com/schellingb/TinySoundFont/853a0a171759f1ddba0de1442133a75912bbeffa/tsf.h | lines 1–150, 421–630, 760–850, 1005–1338, 1510–1660, 1915–2030 | MIT/SFZero notice, format subset, loaders, render precision, zones, loops, envelopes, filter, voices, sustain, and reset behavior. |
| C14 | S35 https://raw.githubusercontent.com/schellingb/TinySoundFont/853a0a171759f1ddba0de1442133a75912bbeffa/LICENSE and S36 https://raw.githubusercontent.com/schellingb/TinySoundFont/853a0a171759f1ddba0de1442133a75912bbeffa/README.md | complete license; README contribution policy | MIT root text and a separate no-LLM upstream contribution policy. |
| C15 | S29 https://raw.githubusercontent.com/sfztools/sfizz/4e70dc0bef53b41f2853ed46e26f5911114c92d0/LICENSE and pinned S30–S31/S44–S45 build bodies | complete license and build options | BSD 2-Clause root text and a material configurable dependency/tool surface. |
| C16 | S46–S50 https://sfzformat.com/opcodes/ and named opcode pages | opcode index; modulation tutorial; loop_mode, lokey, lovel | Community descriptions for regions, key/velocity zones, loops, envelopes, filters, modulation, and switching controls. |

## Format and authoring facts

### SoundFont structure and limits

Fact: S42 describes a RIFF sfbk file with INFO, sample-data sdta, and articulation pdta lists. Fact: its bank contains presets; presets reference instruments; instruments reference samples through zones. Fact: preset and instrument zones can constrain key and velocity ranges. Fact: the documented sample pool uses 16-bit PCM with an sm24 extension for additional precision. Fact: sample headers hold loop locations and continuity rules. Fact: generator lists carry synthesis parameters. Fact: modulator lists connect sources such as velocity or controllers to destinations. Fact: its terminology includes amplitude and modulation envelopes with attack, decay, sustain, and release. Fact: it describes low-pass filtering, pitch, attenuation, interpolation, reverb, and chorus concepts. Fact: it treats several malformed structures as rejectable. Missing evidence: S42 is a historical mirror with mixed edition labels and incomplete publisher provenance. Its formal content does not prove current normative authority. Its limited specification-copying language and rights disclaimers do not clear engine code, a bank, samples, patches, preset names, trademarks, or redistribution. An SF2 format capability also does not prove an implementation supports it. TinySoundFont explicitly omits SoundFont modulators and chorus/reverb-send generators [C13].

### SFZ structure and limits

Fact: S43 describes SFZ as text that arranges referenced samples into an instrument. Fact: the community opcode material groups behavior into headers and regions. Fact: lokey/hikey and lovel/hivel describe key and velocity bounds [C16]. Fact: loop_mode describes loop behavior [C16]. Fact: the opcode and modulation material describes envelope, filter, pitch, amplitude, controller, sequence, trigger, and switching surfaces [C16]. Inference: these surfaces could describe sampled piano, pad, or synth mappings. Missing evidence: S19/S43/S46–S50 are community references rather than one retrieved normative publisher specification. Fact: sfizz reports partial dialect coverage, including only 44% of SFZ v2 and 45% of ARIA [C11]. Therefore an SFZ file, parser, and renderer must be paired by exact dialect and opcode support. A text file's readability does not make its samples, names, or recipe rights transferable.

### Separate artifacts and rights

The following remain distinct:

- format specification;
- parser;
- renderer;
- platform wrapper;
- authoring tool;
- SF2 or SFZ document;
- sample recordings;
- preset and patch metadata;
- product state and persistence schema.

No inspected engine supplies or clears the required future piano, ambient pad, warm synth, or six starter patches.

## Candidate comparison

| Area | FluidSynth 2.6.1 | TinySoundFont pinned commit | sfizz 1.2.3 |
| --- | --- | --- | --- |
| Core form | C library and SoundFont renderer with optional drivers | Single-header C/C++ SoundFont renderer | C++ SFZ library with C API and separate tools/clients |
| Format claim | SoundFont 2 based; exact asset behavior still needs tests | Identified SF2 subset; modulators and effect sends omitted | Partial SFZ v1/v2/ARIA coverage |
| Caller render | s16, s24, s32, float, and process APIs [C05] | float/short; mono, interleaved, or unweaved stereo [C13] | caller-provided stereo buffers [C09] |
| Output sizing | internal buffer query; caller chooses render length | caller chooses sample count | configured maximum frames; render count cannot exceed it |
| Event timing | concurrent sound-affecting calls have unspecified placement for large render requests [C05] | caller owns synchronization and sequencing | input delays must be ordered before each block or behavior is undefined [C09] |
| Sample rate | set in synth settings; old setter deprecated | caller sets output rate | defaults 48 kHz; configurable outside render |
| Precision | integer 16/24/32 and float surfaces | 16-bit short or 32-bit float output | float render buffers; standard and high-precision event APIs |
| Effects | reverb and chorus groups; filter and interpolation controls | no SF2 chorus/reverb-send generator support | effect buses and SFZ-driven controls; oversampling API is an inactive stub |
| Platform material | optional drivers; pinned Android Oboe/OpenSL ES material | no platform driver evidence in inspected header | standalone/plugin/tool material is separate from core library |
| Mobile result | no build/device/lifecycle evidence | no build/device/lifecycle evidence | no build/device/lifecycle evidence |

Caller-driven rendering makes each candidate eligible for a later bounded comparison. It does not establish a safe mobile embedding boundary. The project callback still prohibits blocking, I/O, UI work, parsing, allocation, arbitrary locks, and potentially blocking logs.

## Loading, memory, voices, and ownership

### FluidSynth

Fact: sfload and related state use a filename and a stack of SoundFonts [C07]. Fact: load may refresh program selection; unload/reload use SoundFont IDs and can defer release while voices retain samples [C07]. Fact: Dynamic sample loading allocates and is expressly documented as not real-time safe [C06]. Fact: increasing polyphony can reallocate and create voices; reducing it turns off excess voices [C07]. Fact: when capacity is exhausted, settings documentation says lower-priority voices can be terminated [C06]. Fact: the default public API thread-safety setting uses a mutex boundary [C06/C07]. Fact: interpolation choices include a highest setting described as effectively unusable for real-time rendering [C05]. Fact: multiple effects groups can significantly increase CPU according to the settings documentation [C06]. Fact: reverb engine selection occurs at synth creation and availability depends on compiled components [C06]. Inference: load, dynamic sample activation, capacity changes, engine creation, mutable global settings, and destruction belong to preparation/control work. Disagreement: a mutex-protected API conflicts with the project's prohibition on arbitrary callback lock waiting unless a later complete call graph proves the exact render path does not wait.

### TinySoundFont

Fact: filename, memory, and caller-stream loaders exist [C13]. Fact: loading parses and allocates font, preset, region, and sample-related structures [C13]. Fact: rendering uses caller buffers and linear interpolation, envelopes, LFOs, and a low-pass filter [C13]. Fact: set_max_voices preallocates capacity [C13]. Fact: without a cap, note-on can grow the voice array. Fact: with a cap, it prefers a voice already in release; if none exists, another note may not start [C13]. Fact: channel initialization may allocate. Fact: the header says separate render/note threads normally need synchronization. Fact: its alternative with preallocated voices is described only as mostly thread-safe, with a theoretical race and limited testing. Inference: one owner or a bounded control-to-render event transfer would need evaluation. Missing evidence: no general streaming/cache subsystem or callback-safety guarantee is supported.

### sfizz

Fact: create_synth defaults to 48 kHz and 1,024 maximum frames; the caller frees it [C09]. Fact: load_file and load_string are control-thread operations and cannot overlap real-time calls [C09]. Fact: relative or virtual paths control later sample lookup [C09]. Fact: set_preload_size is control-thread only, takes a lock, disables callbacks during load, and can take a long time [C09]. Fact: FilePool source includes preload, queue, worker-thread, file-streaming, locking, and background-job paths [C10]. Fact: set_num_voices is control-thread only. Fact: source includes region/group polyphony and voice-stealing selection [C10]. Fact: render source includes buffer pools, file-pool interaction, effect buses, timing, garbage collection, and voice-reset paths [C10]. Fact: active-voice reporting is documented as a basic racing indicator. Inference: parsing, file lookup, preload, reload, capacity changes, and free operations remain outside the callback. Missing evidence: bounded source reading neither proves nor disproves that every callback-reachable path satisfies the project hard real-time rules.

## Notes, controls, and recovery

| Need | FluidSynth | TinySoundFont | sfizz | Remaining host question |
| --- | --- | --- | --- | --- |
| Note and velocity | noteon/noteoff APIs | note-on selects matching key/velocity regions; velocity zero invokes note-off | ordered note APIs, including high-precision forms | event ownership, duplicate notes, late events, and queue bounds |
| Sustain | CC interface and SF2/MIDI model | CC64 holds released voices until sustain clears | CC event surface; exact asset/opcode behavior varies | state reconciliation after loss, switch, interruption, or overflow |
| Split/zone | SF2 key/velocity zones | exact parser filters key/velocity regions | SFZ key/velocity opcodes and regions | whether host uses one engine, channels, or instances |
| Transpose | MIDI/pitch/generator surfaces | channel tuning and pitch controls | pitch and SFZ opcode surfaces | saved unit/range, smoothing, ownership, and audible validation |
| All Notes Off | distinct public call [C05] | releases channel voices, ignoring sustain in the inspected path | note/recovery calls exist | release tails can remain audible |
| All Sound Off | distinct public call [C05] | uses quick voice ending [C13] | all_sound_off clears buffers and resets voices [C09] | internal state, effects, and captured silence still require proof |
| Reset | system/program APIs | controller reset has its own path | external definitions persist until explicitly cleared | exact bounded Stop Sound policy remains unselected |

All Notes Off and All Sound Off are not interchangeable. R05 candidate 00952ed4bd563446ef450ce375cb5ec89edb43de documents the MIDI distinction and the need to verify bounded state plus audible silence. This report does not adopt a panic sequence.

## Product-fit matrix

| Planned need | Documentary support | Gap before any claim |
| --- | --- | --- |
| Cleared piano | SF2/SFZ represent sampled instruments and zones | exact cleared content, provenance, rights, format compatibility, memory, listening, and device evidence |
| Ambient pad | loops, envelopes, filters, modulation, and effects exist across formats/candidates in different subsets | approved original content and proof that mapped brightness/effects produce the intended result |
| Warm synth | sample-based or hybrid control surfaces could represent a warm-synth recipe | synthesis/content design, control mapping, quality, CPU, continuity, and rights |
| Up to four layers | engines expose channels, presets, voices, instances, or regions | architecture, routing, shared effects, per-layer limits, mixing, smoothing, and measured worst case |
| Six editable patches | engines expose render/control state, not the product document model | patch schema, validation, immutable factory content, save/copy/delete, migrations, and recovery |
| Brightness | filter/generator/opcode surfaces exist | one approved audible mapping per candidate/content pair |
| Reverb and delay sends | FluidSynth has reverb/chorus rather than the complete planned host effect model; sfizz has effect buses; TinySoundFont omits SF2 sends | host effects architecture, delay implementation, send routing, bypass, smoothing, tails, and workload |
| Save across restart | no candidate proves AugmentedKeys persistence | versioned product documents, stable instrument IDs, atomic save, restore, corruption handling |
| Variations/snapshots | event/control APIs can change values | safe settings publication, smoothing, held-note policy, validation, and continuity |
| Patch switching | load/unload APIs exist | prepare/swap/retire ownership, old-patch retention, memory peaks, failures, and tail policy |
| Offline use | local bundled assets are consistent with offline operation as an inference | packaging, storage, install/update rollback, content rights, corruption, and lifecycle |
| Basic wired MIDI | engines accept note/control events | platform route, queue, timing, lifecycle, controller, and physical-device evidence from later work |

Snapshot recall, tail continuity, product persistence, four-layer coordination, and six starter patches are host/product responsibilities. They are not established engine APIs.

## Mobile and toolchain evidence

FluidSynth's pinned Android README documents Oboe and OpenSL ES output choices, libfluidsynth.so, an asset-loader library, stream callbacks, and Android AssetManager initialization [C08]. Pinned CMake makes Oboe/OpenSL ES optional. This is release documentation and build-surface evidence. It is not an Android build, APK, resolved dependency graph, lifecycle result, callback audit, device result, or latency measurement. S27 also contains a historical Java-only Android MIDI statement. Verified R05 documents Android MIDI through API 35. The S27 sentence therefore cannot be repeated as current platform availability or as proof of a FluidSynth MIDI route. TinySoundFont's inspected artifact is a source header, not a platform wrapper or shipped mobile product. sfizz requires C++14 in S45. S31/S44/S45 expose configurable shared/static library, dr_libs versus libsndfile, JACK, renderer, testing, benchmark, system-library, LV2, VST3, and AU-related branches. S44 names material components including Abseil, atomic_queue, filesystem support, hiir, KISS FFT, Surge tuning, pugixml, cephes, cpuid, Faust-related libraries, and optional tool dependencies. Those declarations do not prove which components enter a future mobile build. No minimum iOS/iPadOS or Android version, native ABI, wrapper, audio API, or integration approach follows.

## Licensing and security handoff

| Item | Inspected fact | R07 or owner gap |
| --- | --- | --- |
| FluidSynth | S20 contains LGPL-2.1 text; S21 identifies LGPL; S26 is an upstream layperson FAQ that disclaims legal advice | exact static/dynamic link and distribution obligations, enabled components, notices, App Store implications, patents/trademarks |
| sfizz | S29 contains BSD 2-Clause | exact selected dependency graph, versions, licenses/notices, archived-project maintenance handling |
| TinySoundFont | S35 contains MIT; S37 repeats MIT and SFZero attribution | notice/provenance review and exact incorporation plan |
| TinySoundFont contributions | S36 states a no-LLM contribution policy | separate from MIT; no contribution or adoption is authorized |
| S42 | historical mirror includes limited specification-copying language and rights disclaimers | no legal conclusion, current authority, or content clearance |
| SF2/SFZ assets | no content was downloaded or inspected | piano/pad/synth source, recording and performer rights, preset metadata, trademarks, redistribution and commercial terms |

A root code license never clears sample content. Public readability does not establish redistribution permission. No legal conclusion is made. Future format inputs must be treated as untrusted even if bundled. Relevant risks include:

- malformed RIFF chunks, counts, offsets, loops, zones, and sample bounds;
- SFZ relative or virtual paths, traversal, symlinks, and references outside an approved asset root;
- excessive file size, sample count, decompressed memory, preload, polyphony, or effect state;
- integer, allocation, parse-failure, and partial-load behavior;
- worker, stream, callback, and object lifetimes during unload, route loss, or restart;
- mutable definitions, state, and configuration crossing threads;
- logs or artifacts containing filenames, device data, or proprietary content.

No vulnerability is asserted. A later security review must bind the exact version, build graph, input policy, limits, and fixtures.

## Smallest later comparison experiment

This is a recommendation only. It is unperformed, unapproved, requests no hardware, and adopts no numeric budget. It requires a future approved original or licensed fixture that includes a real piano plus bounded pad and synth material. A diagnostic oscillator cannot replace the piano condition.

### Existing method anchors

- R01 candidate 09266fdc17e137db44495d85c6b42cf296efb89c: LOW_LATENCY_RESEARCH.md, Gates 1–8, for procedure manifest, clocks, calibration, warm-up, lifecycle, soak, raw artifacts, and independent review.
- R04 candidate 26b6c2702d21704481969dc99fa51ee504aa9bb7: ANDROID_AUDIO_RESEARCH.md, section 6 and Proposed measurement method carried from R01, for stream configuration, callback timing, counters, route/lifecycle, and Android evidence levels.
- R05 candidate 00952ed4bd563446ef450ce375cb5ec89edb43de: MIDI_RESEARCH.md, Exact boundaries, Clock alignment and calibration, Event integrity, Active-note/sustain/silence, Overload and recovery, and Statistics and retained artifacts.

### Freeze before execution

Record:

- engine tag/commit and source hashes;
- build toolchain, compiler, flags, link form, enabled and disabled modules;
- complete dependency and notice manifest;
- exact fixture files and hashes plus approved rights evidence;
- platform app commit, device, OS, route, sample rate, buffer size, and channel layout;
- engine settings, block size, voice cap, interpolation, preload/stream mode, and effects;
- approved numeric or objective acceptance conditions.

### Equalized workloads

Use the same declared musical fixture and equivalent documented settings where capabilities permit. Report every configuration that cannot be made equivalent. Exercise:

- one and four logical layers;
- 1, 8, 16, 32, and 64 simultaneous note-event positions, bounded by actual candidate capability;
- fixed note-on/off and velocity sequence;
- repeated notes and chords;
- CC64 sustain on/off with released-but-sustained notes;
- bounded CC120 All Sound Off and CC123 All Notes Off trials kept distinct;
- transpose and split-boundary notes;
- brightness and each enabled effect control at declared values;
- prepared patch switch, failed load, missing/corrupt fixture, unload, and restart;
- route/interruption and event-queue overload only under a separately approved platform procedure.

### Measurements and boundaries

Measure cold and warm parse/load time outside rendering. Measure decoded/preloaded asset memory, peak and resident process memory, file reads, bytes, failures, and worker lifetime. Record voice-cap preparation and peak active voices. For every callback record start, duration, deadline, miss/underrun, queue occupancy, overflow disposition, allocation/lock observations where feasible, engine errors, and recovery markers. Separate controller physical trigger, application receipt, validated event, render consumption, digital output onset, and audible onset. Use one capture clock when approved. Otherwise insert known common markers before and after each run and estimate offset, drift, calibration residual, detector uncertainty, and censored trials. Do not merge software event-to-render timing with physical input-to-audible latency. For audible controls and quality, retain level-matched raw captures and the exact signal/listening rubric. Do not infer quality from feature count.

### Provisional execution

Use a fixed warm-up before retained trials. Run ten retained repetitions for each short configuration. Run one 30-minute sustained four-layer soak per candidate/configuration. Repeat each recovery condition at least three times. Treat these counts and durations as provisional method inputs, not acceptance budgets. Keep failed, censored, overloaded, unrecovered, and unequivalent trials.

### Retained artifacts

Retain:

- exact source/build/content/configuration manifests;
- raw audio and synchronization markers;
- raw event sequence and queue traces;
- callback, deadline, underrun, voice, CPU, memory, I/O, thermal, and recovery counters;
- load/unload and lifecycle logs outside the callback;
- calibration inputs and outputs;
- deterministic analysis scripts and versions;
- every exclusion and failure reason;
- QA/Performance and Licensing/Security reviews.

No candidate can be ranked before the approved experiment is executed and independently reviewed.

## Findings by classification

### Facts

- The three pinned candidates expose caller-driven rendering.
- They differ materially in format coverage, effects, precision, capacity behavior, threading guidance, load model, and build surface.
- SF2 and SFZ can describe key/velocity zones, looping, envelopes, filters, and modulation, with implementation-specific gaps.
- FluidSynth and TinySoundFont distinguish All Notes Off from All Sound Off.
- sfizz exposes a separate all-sound-off path.
- FluidSynth has release-level Android driver and asset-loader documentation.
- sfizz is archived; the archive notice date is from S12.
- No candidate includes or clears the required musical content.

### Inferences

- Each candidate is narrow enough for a future controlled spike.
- Preparation, parsing, loading, capacity changes, and teardown belong outside the audio callback.
- Four-layer behavior is primarily a host ownership, routing, resource, and measurement question.
- Local bundled assets could support offline use after packaging and licensing are approved.

### Recommendations

- Preserve all three as documentary comparators.
- Require exact source and dependency manifests before a spike.
- Use one approved fixture and predeclared equalization rules.
- Trace the complete callback-reachable call graph before any real-time-safety claim.
- Treat musical content as a separate cleared workstream.
- Keep basic playing and recovery ahead of advanced format breadth.

### Disagreements

- FluidSynth mutex-protected public API behavior and TinySoundFont synchronization guidance conflict with the callback no-wait rule until exact call paths are proved.
- sfizz's long-running locked preload path is explicitly control-plane work, while its complete render safety remains unproved.
- S42 edition labels and publisher provenance cannot establish one current normative SF2 authority.
- Community SFZ documentation and partial engine dialects cannot establish universal SFZ compatibility.
- S27's historical Android MIDI statement conflicts with current platform evidence and is not used as current fact.

### Missing evidence

- Current authoritative SF2 publisher specification and one exhaustive normative SFZ specification.
- Full parser and callback/lifecycle audits.
- Exact future build graphs and platform integration.
- Cleared piano, pad, synth, and starter-patch content.
- Input bounds and security testing.
- Independent licensing review and any legal determination.
- Builds, simulators, devices, controllers, audio captures, measurements, or quality review.
- CPU, memory, I/O, thermal, deadline, latency, continuity, recovery, and soak results.
- Selected architecture, engine, format, native boundary, minimum OS, voice policy, effects, persistence, or numeric budgets.

### Owner decisions

The owner retains decisions on:

- engine or format inclusion;
- architecture and native boundary;
- dependency and build graph;
- content source and licensing;
- hardware and device procedure;
- supported platforms and OS versions;
- performance and quality budgets;
- any legal or distribution conclusion.

## Acceptance-criteria trace

| Criterion | Coverage |
| --- | --- |
| 1. Bounded identities | Three justified candidates with exact pins, release/HEAD separation, dates, and non-guarantees. |
| 2. Format and authoring | Historical SF2 model, community SFZ model, positive feature facts, dialect limits, and separate rights. |
| 3. Embedding and portability | Caller render, drivers, precision, sizing, events, toolchains, and unperformed mobile verification. |
| 4. Real-time, memory, lifecycle | Load/decode/parse boundaries, preload/streaming, voices/stealing, effects, locks, ownership, and unresolved callback risks. |
| 5. Product fit | MIDI basics, recovery, layers, controls, content, patch/snapshot/tail/persistence gaps, and no adoption. |
| 6. Licensing and security | Exact root licenses, build options, content separation, input/path/resource risks, and R07 questions. |
| 7. Traceable evidence | Claim IDs, exact URLs, pins, anchors, access date, authority limits, and canonical full-hash register. |
| 8. Later experiment | Exact prior-method anchors, equalized workload, calibration, trials, performance/resource evidence, recovery, soak, and artifacts. |

## Conclusion

The corpus supports retaining FluidSynth 2.6.1, pinned TinySoundFont, and sfizz 1.2.3 as three different candidates for a later controlled comparison. It does not support selecting any of them. It does not establish full SF2 or SFZ conformance, mobile suitability, callback safety, sound quality, four-layer capacity, continuity, or acceptable latency. It does not clear a piano, pad, synth, SoundFont, SFZ, sample, preset, or patch. The next technical decision still requires an approved fixture, exact build and license evidence, a bounded spike, objective measurements, independent reviews, an ADR, and the applicable owner approval.
