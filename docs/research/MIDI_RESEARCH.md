# MIDI standards and mobile-platform research

## Status and decision boundary

This is the R05 documentary report under brief `f30f02a5c76d5f08e07c45627b023819d811e289`. Sources were accessed on 2026-10-23. The source capture records 70 requests: 68 HTTP 200 bodies and two retained failures. The app remains a Flutter shell; it has no implemented or verified MIDI behavior. This report does not choose an architecture, protocol, minimum OS, target SDK, package, asset, permission policy, transport, or panic policy. It does not establish conformance, certification, controller compatibility, latency, reliability, or physical-device behavior. No account, terms acceptance, SDK/package installation, build, simulator, device, controller, or hardware action occurred.

The intended user outcome is reliable offline playing of the future built-in worship instrument from a supported wired controller. Basic MIDI 1 note, velocity, sustain, connection state, recovery, and a visible Stop Sound action come first. MIDI 2, UMP breadth, MIDI-CI, MPE, BLE, network MIDI, virtual endpoints, and plug-in hosting remain later work.

Evidence labels used below are:

- **Fact:** directly supported by an inspected source body.
- **Inference:** a bounded engineering implication of one or more facts.
- **Recommendation:** proposed future work; not adopted.
- **Disagreement:** sources or API surfaces require care before they can be reconciled.
- **Missing evidence:** a claim the inspected sources cannot establish.
- **Owner decision:** a future choice outside this report.

## Source identity and access limits

The canonical request, status, byte-count, and SHA-256 catalog is `docs/orchestration/milestones/m0/evidence/r05-sources.md`. Raw captured bodies remain outside the repository report in the controller evidence directory. HTML-derived text and PDF-extracted text were navigation aids; raw bodies are authoritative. No standards prose, diagram, sample code, or asset is copied into this report.

### Standards and explanatory sources

| ID | Source inspected | Edition or status | Use and limit |
| --- | --- | --- | --- |
| M01 | https://midi.org/specs | Public collection page | Catalog context; not proof that every listed specification body was inspected. |
| M02 | https://midi.org/midi-2-0 | Public overview | MIDI 2 and MIDI-CI overview; explanatory, not conformance text. |
| M03 | https://midi.org/details-about-midi-2-0-midi-ci-profiles-and-property-exchange-updated-june-2023 | Updated June 2023 | Historical explanatory detail; not latest-edition proof. |
| M17 | https://midi.org/summary-of-midi-1-0-messages | Public summary, revision not shown | MIDI 1 layouts and channel modes; page says it is incomplete. |
| M20 | https://midi.org/midi-ci-specification | Public listing/overview | Identifies MIDI-CI capabilities; normative text was not inspected. |
| M21 | https://midi.org/mpe-midi-polyphonic-expression | Current MPE v1.1 listing | Current identity; v1.1 PDF was not retrieved. |
| M22 | https://midi.org/the-midi-association-announces-the-v1-1-update-to-the-midi-polyphonic-expression-mpe-specification | 2022-05-01 announcement | Says v1.1 changes are editorial rather than technical. |
| M34 | https://midi.org/midi-1-0-detailed-specification | Lists `M1_v4-2-1`, 1996 revision | Index inspected; original detailed MIDI 1 text unavailable. |
| M35 | https://midi.org/midi-2-0-core-specification-collection | Collection dated 2025-12-18 | Lists UMP/MIDI 2 v1.1.2 and MIDI-CI v1.2.1; archive not retrieved. |
| M36 | https://midi.org/terms-of-use | Current public terms page | Says site content is protected and ungranted rights are reserved; no legal conclusion follows. |
| M38 | https://midi.org/profiles | Public profile listing | Capability context; individual profile texts not inspected. |
| M44 | https://amei-music.github.io/midi2.0-docs/amei-pdf/M2-104-UM_v1-1-2_UMP_and_MIDI_2-0_Protocol_Specification.pdf | M2-104-UM v1.1.2; draft 2023-10-27; published 2023-11-10; 124 pages | Original UMP/MIDI 2 document; cited sections inspected. |
| M46 | https://support.roli.com/helpdesk/attachments/36006155617 | Historical MPE v1.0; 2018-03-12; 20 pages | Original attachment; use only for marked v1.0 facts. |
| M53 | https://midi.org/midi-1-0-control-change-messages | Public CC table | CC64 and channel-mode identities; detailed MIDI 1 text still missing. |

M44 and M46 state that their contents are all rights reserved. Public readability supports documentary inspection only. It does not establish permission to reproduce, redistribute, incorporate, or ship their contents. That is a licensing fact and risk marker, not a legal conclusion.

### Retrieval failures and resolved capture gaps

- M16, `https://amei.or.jp/midistandardcommittee/MIDI2.0.html`, returned HTTP 404.
- M45, `https://support.roli.com/en/support/solutions/articles/36000027933-what-is-mpe-`, failed in a redirect loop; later access redirected toward sign-in.
- No sign-in or account action was attempted.
- M43, `https://amei-music.github.io/midi2.0-docs/ja/`, was captured and indexes the AMEI-hosted material.
- M44 was captured and inspected; it is not a remaining retrieval gap.
- All three request indexes are complete; they are not a remaining gap.
- M46 was captured and inspected, but it is MPE v1.0 rather than current v1.1.
- Original detailed MIDI 1 and MIDI-CI normative texts remain unseen.

## Standards model: keep the layers separate

| Layer | Evidence-backed meaning | What it does not establish |
| --- | --- | --- |
| Physical transport | Cable, USB, BLE, network, or virtual/inter-app connection. | Encoding, protocol, API availability, or device support. |
| MIDI 1 byte stream | Status/data bytes; Channel Voice addresses 16 channels. | Packet boundaries, UMP support, or MIDI 2 features. |
| UMP | Container of 32-bit words with 32-, 64-, 96-, or 128-bit formats. | That every packet is MIDI 2 Channel Voice. |
| MIDI 1 over UMP | MIDI 1 protocol messages represented in UMP. | MIDI 2 semantics or lossless conversion. |
| MIDI 2 protocol | Higher-resolution Channel Voice, attributes, and per-note mechanisms in UMP. | Support by a controller, OS route, or destination. |
| MIDI-CI | Bidirectional discovery/configuration: Profiles, Property Exchange, Process Inquiry. | Presence or trustworthiness of a desired capability. |
| MPE | MIDI 1 channel-allocation convention for per-note expression. | MIDI 2 per-note controls or unlimited independent notes. |

**Fact:** M44 defines UMP message types, and only types containing a Group field use Groups. Utility type `0x0` and UMP Stream type `0xF` have no Group field. Therefore “every UMP has a Group” is false.

**Fact:** UMP can carry MIDI 1 as well as MIDI 2 protocol messages. Therefore “UMP means MIDI 2” is false.

**Fact:** M44 uses UMP Endpoint Discovery and Stream Configuration Request/Notification to select protocol and Jitter Reduction behavior. It says earlier MIDI-CI Protocol Negotiation was deprecated from MIDI-CI. An implementation must not treat an older MIDI-CI protocol-negotiation description as current M44 behavior.

**Disagreement:** Android API 33 retains `PROTOCOL_UMP_USE_MIDI_CI` as a default-protocol value. That constant describes an Android device/default negotiation path. It does not prove older generic MIDI-CI Protocol Negotiation remains current in M44.

## MIDI 1 messages needed for the basic workflow

| Message | Relevant fields | Basic-workflow relevance |
| --- | --- | --- |
| Note Off | channel, 7-bit key, 7-bit release velocity | Ends a note, subject to sustain/release. |
| Note On | channel, 7-bit key, 7-bit attack velocity | Starts a note. |
| Polyphonic Key Pressure | channel, key, 7-bit pressure | Later expression. |
| Control Change | channel, 7-bit controller, 7-bit value | Sustain and other controllers. |
| Program Change | channel, 7-bit program | Future mapping question. |
| Channel Pressure | channel, 7-bit pressure | Later expression; distinct from poly pressure. |
| Pitch Bend | channel, 14-bit value, LSB then MSB | Later expression; center `0x2000`. |

**Fact:** M44’s translation appendix says MIDI 1 Note On velocity `0x00` is equivalent to Note Off. Historical MPE v1.0 recommends treating that shorthand as Note Off velocity 64 for compatibility.

**Fact:** MIDI 2 Note On velocity ranges from `0x0000` to `0xFFFF`. M44 explicitly says MIDI 2 Note On velocity zero is not Note Off. When a MIDI 2 Note On would quantize to MIDI 1 velocity zero, M44 requires substituting one.

**Inference:** parsing and conversion must apply the rule for the active protocol.

**Fact:** the MIDI 1 summary describes pitch bend as 14 bits, LSB plus MSB, centered at `0x2000`. Pitch range belongs to receiver state and may be configured through RPN 0.

**Fact:** M53 identifies CC64 as Damper Pedal/Sustain: 0–63 off and 64–127 on. This does not choose sustain-state ownership or recovery policy.

The public tables distinguish:

- CC120: All Sound Off.
- CC121: Reset All Controllers.
- CC123: All Notes Off.
- CC124–127: channel-mode controls with mode effects.

These commands are not interchangeable. M44 says Reset All Controllers does not reset MIDI 2 per-note controllers or per-note pitch bend. Android warns that flush can discard Note Off events and recommends All Notes Off afterward. That supports a recovery test, not a universal panic recipe.

Historical MPE v1.0 defines a Released Note as a note that received Note Off but may continue because of an envelope, sustain, or sostenuto. Therefore CC123 or Note Off cannot be equated with immediate audible silence for every receiver and state. Stop Sound must later verify bounded internal state and captured audible silence.

## MPE and MIDI 2 expression

### Historical MPE v1.0 facts

- A Zone has one Master Channel and contiguous Member Channels.
- Lower Zone master is channel 1; members rise from channel 2.
- Upper Zone master is channel 16; members descend from channel 15.
- Where possible, each sounding note receives its own Member Channel.
- Shared Member Channels lose independent channel-message control for those notes.
- The Master Channel carries zone-wide pedal data and overall pitch bend.
- Pitch Bend and Channel Pressure can operate at zone and note level.
- CC74 is the third per-note dimension in v1.0.
- Zone setup uses a registered-parameter exchange and has reset behavior.
- These are v1.0 facts; v1.1 is listed as editorially revised, but its PDF was not inspected.

### MIDI 2 distinctions

- M44 defines registered and assignable per-note controllers.
- It defines per-note management and per-note pitch bend.
- Note On/Off may carry attribute type and attribute data.
- Relevant messages use 16-bit note velocity and 32-bit controller values.
- These mechanisms do not require one MIDI 1 channel per note.
- Conversion to ordinary MIDI 1 can quantize, lose attributes, or lose per-note state.
- Conversion to MPE depends on zone setup and available Member Channels.

No mapping, learn, split, layer, transpose, snapshot, program-change, zone, pitch-range, or conversion policy is selected.

## Apple Core MIDI

### API and availability matrix

| API/source | Captured availability | Documentary fact and limit |
| --- | --- | --- |
| M23 `https://developer.apple.com/documentation/coremidi.md` | iOS/iPadOS 4.2+ | Framework for MIDI hardware; overview lists dock/network, BLE, setup, messages, and MIDI-CI topics. |
| M24 `MIDIClientCreateWithBlock` — `https://developer.apple.com/documentation/coremidi/midiclientcreatewithblock%28_%3A_%3A_%3A%29.md` | iOS/iPadOS 9.0+ | Creates a client; notification block runs on an arbitrary thread. |
| M58 `MIDIGetNumberOfSources` — `https://developer.apple.com/documentation/coremidi/midigetnumberofsources().md` | iOS/iPadOS 4.2+ | Returns source count, or zero on error. |
| M59 `MIDIGetSource` — `https://developer.apple.com/documentation/coremidi/midigetsource(_:).md` | iOS/iPadOS 4.2+ | Returns source by index, or null on error. |
| M61 `https://developer.apple.com/documentation/coremidi/midiinputportcreate(_:_:_:_:_:).md` | iOS/iPadOS 4.2–27.2 metadata range | Legacy packet-list input; high-priority Core MIDI thread. Range end does not prove removal. |
| M25 `MIDIInputPortCreateWithProtocol` — `https://developer.apple.com/documentation/coremidi/midiinputportcreatewithprotocol%28_%3A_%3A_%3A_%3A_%3A%29.md` | iOS/iPadOS 14.0+ | Protocol-specific input; system conversion; high-priority Core MIDI thread. |
| M62 `https://developer.apple.com/documentation/coremidi/midioutputportcreate(_:_:_:).md` | iOS/iPadOS 4.2+ | Output port for sending to destinations. |
| M63 `https://developer.apple.com/documentation/coremidi/midiportconnectsource(_:_:_:).md` | iOS/iPadOS 4.2+ | Connects a source; multiple sources may connect. |
| M64 `https://developer.apple.com/documentation/coremidi/midiportdisconnectsource(_:_:).md` | iOS/iPadOS 4.2+ | Disconnects a source from a port. |
| M65 `https://developer.apple.com/documentation/coremidi/midiportdispose(_:).md` | iOS/iPadOS 4.2+ | Disposes a port. |
| M60 `https://developer.apple.com/documentation/coremidi/midiclientdispose(_:).md` | iOS/iPadOS 4.2+ | Disposes a client; warns about disposing the app’s last client. |
| M39 `https://developer.apple.com/documentation/coremidi/midisourcecreatewithprotocol%28_%3A_%3A_%3A_%3A%29.md` | iOS/iPadOS 14.0+ | Client-owned virtual source with protocol conversion. |
| M67 `https://developer.apple.com/documentation/coremidi/mididestinationcreatewithprotocol(_:_:_:_:_:).md` | iOS/iPadOS 14.0+ | Protocol-specific virtual destination and receive block. |
| M66 `https://developer.apple.com/documentation/coremidi/midiendpointdispose(_:).md` | iOS/iPadOS 4.2+ | Disposes a client-owned virtual endpoint. |
| M69 `https://developer.apple.com/documentation/coremidi/midisend(_:_:_:).md` | iOS/iPadOS 4.2–27.2 metadata range | Sends a packet list; range end does not prove removal. |
| M68 `MIDISendEventList` — `https://developer.apple.com/documentation/coremidi/midisendeventlist(_:_:_:).md` | iOS/iPadOS 14.0+ | Sends a protocol-bearing event list. |
| M70 `MIDIEventListInit` — `https://developer.apple.com/documentation/coremidi/midieventlistinit(_:_:).md` | iOS/iPadOS 14.0+ | Initializes an event list for a protocol. |
| M26 `https://developer.apple.com/documentation/coremidi/midipacketlist.md` | Blank fields | Packet-list structure; availability unknown from capture. |
| M28 `https://developer.apple.com/documentation/coremidi/midipacketlistadd%28_%3A_%3A_%3A_%3A_%3A_%3A%29.md` | iOS/iPadOS 4.2–27.2 metadata range | Adds packet data; documents 65,536-byte packet-list capacity and SysEx splitting; range end does not prove removal. |
| M50 `MIDIEventList` — `https://developer.apple.com/documentation/coremidi/midieventlist.md` | Blank fields; exact introduction unknown from capture | UMP event-list structure with protocol field; M70 function availability does not establish this structure’s earliest availability. |
| M51 `MIDIProtocolID` — `https://developer.apple.com/documentation/coremidi/midiprotocolid.md` | Blank fields; exact introduction unknown from capture | MIDI 1 and MIDI 2 protocol identifiers; no framework-baseline inference is made. |
| M47 `https://developer.apple.com/documentation/coremidi/miditimestamp.md` | Blank fields | Based on `mach_absolute_time()`; availability unknown. |
| M48 `https://developer.apple.com/documentation/coremidi/midireceiveblock.md` | Blank fields | High-priority receive thread; availability unknown. |
| M27 `https://developer.apple.com/documentation/coremidi/midieventpacket/timestamp.md` | Blank fields | Input occurrence/output desired-play time; zero means now. |
| M31 `https://developer.apple.com/documentation/coremidi/midicisession.md` | iOS/iPadOS 12.0–18.0 metadata range | Bidirectional MIDI-CI-discovered session; captured body does not label it removed/deprecated. |

Blank metadata does not mean “present since baseline.” M70’s iOS/iPadOS 14.0+ function metadata does not establish the exact introduction of M50 `MIDIEventList` or M51 `MIDIProtocolID`. A range end does not by itself mean an API was removed. M18, `https://developer.apple.com/documentation/coremidi/incorporating-midi-2-into-your-apps.md`, lists iOS 14.0+, Mac Catalyst 14.0+, and Xcode 16.2+ but not iPadOS in metadata. That omission is unknown, not evidence that iPadOS lacks the feature. No minimum deployment target follows.

### Discovery, callbacks, timing, and lifecycle

**Fact:** client system-change notifications run on an arbitrary thread. **Fact:** protocol and legacy input callbacks run on a high-priority Core MIDI-owned thread. **Fact:** sources can be enumerated, connected, disconnected, and disposed. **Fact:** Core MIDI differentiates packet lists and protocol-bearing event lists and may convert for a destination. **Fact:** event timestamps denote input occurrence or requested output play time; zero requests “now.”

**Inference:** system notification, MIDI receive, UI, control-state, and audio-render contexts need separate ownership. No source proves parsing, allocation, locks, logging, I/O, or UI work is safe in a MIDI callback. No MIDI callback evidence weakens the project’s stricter audio-render callback boundary.

M57, `https://developer.apple.com/documentation/uikit/managing-your-app-s-life-cycle.md`, says scenes/apps move through foreground, background, suspended, disconnected, and terminated states. A background or suspended scene can be disconnected to reclaim resources. That general evidence does not specify Core MIDI endpoint survival, callback delivery, reconnection, or audible recovery. Those require later physical-platform evidence.

### Apple transports, privacy, and background

- M29, `https://developer.apple.com/documentation/coremidi/midi-bluetooth.md`, documents BLE MIDI and iOS 16+ paired-peripheral reconnection behavior.
- M30, `https://developer.apple.com/documentation/coremidi/midinetworksession.md`, documents network MIDI session APIs.
- M54, `NSBluetoothAlwaysUsageDescription`, `https://developer.apple.com/documentation/bundleresources/information-property-list/nsbluetoothalwaysusagedescription.md`, has iOS/iPadOS 13.0+ metadata and is required when an app uses Bluetooth; for a deployment target earlier than iOS 13, the source says to add `NSBluetoothPeripheralUsageDescription` as well.
- M55, `NSLocalNetworkUsageDescription`, `https://developer.apple.com/documentation/bundleresources/information-property-list/nslocalnetworkusagedescription.md`, has iOS/iPadOS 14.0+ metadata and says any app using the local network directly or indirectly should include the explanation, including Bonjour-based services and direct unicast or multicast connections.
- M56, `https://developer.apple.com/documentation/bundleresources/information-property-list/uibackgroundmodes.md`, identifies background modes as an enabled capability.
- These sources do not prove every wired route needs a permission or that no wired route needs one.
- No entitlement, plist key, background mode, or minimum OS is selected.

The Core MIDI dock/MFi reference does not establish USB hardware parity across adapters, controllers, phones, or tablets. Physical transport, power, adapter compatibility, OS routing, and API protocol are separate facts.

## Android MIDI

### API-level and transport matrix

| Surface | API level | Documentary fact and limit |
| --- | --- | --- |
| M04 `https://developer.android.com/reference/android/media/midi/package-summary` | 23 | Package covers USB, BLE, and virtual/inter-app MIDI; byte input may be partial, combined, and interleaved. |
| `MidiManager.getDevices()` | 23; deprecated 33 | Enumerates devices not defaulting to UMP; API 33 directs transport-specific use. |
| M05 `https://developer.android.com/reference/android/media/midi/MidiManager` `getDevicesForTransport()` | 33 | Separates byte-stream and UMP devices. |
| `registerDeviceCallback(callback, handler)` | 23; deprecated 33 | MIDI 1 changes; thread unspecified if handler null. |
| `registerDeviceCallback(transport, executor, callback)` | 33 | Add/remove/status for requested byte-stream or UMP class. |
| `openDevice()` | 23 | Opens asynchronously; listener may receive null. |
| M06 `https://developer.android.com/reference/android/media/midi/MidiDeviceInfo` | 23 / protocol constants 33 | Device/ports/properties; MIDI 1-UP, MIDI 2, JRTS, MIDI-CI, unknown defaults. |
| M07 `https://developer.android.com/reference/android/media/midi/MidiReceiver` | 23 | Timestamped byte receive contract, bounded callback-buffer lifetime, send/flush surface. |
| M08–M10 `https://developer.android.com/reference/android/media/midi/MidiDevice`, `https://developer.android.com/reference/android/media/midi/MidiInputPort`, `https://developer.android.com/reference/android/media/midi/MidiOutputPort` | 23 | Async-opened device ports, device-perspective direction, close/connect/disconnect surfaces. |
| `TRANSPORT_MIDI_BYTE_STREAM` | 33 | MIDI 1 byte-stream class; most common; not UMP by default. |
| `TRANSPORT_UNIVERSAL_MIDI_PACKETS` | 33 | UMP class; data multiples of four bytes. |
| M11 `https://developer.android.com/reference/android/media/midi/MidiDeviceService` | 23 | Virtual byte-stream service with manifest declaration. |
| M12 `https://developer.android.com/reference/android/media/midi/MidiUmpDeviceService` | 35 | Virtual UMP service; complete UMPs, equal input/output counts, manifest declaration. |
| M33 `https://developer.android.com/ndk/reference/group/midi` | Current reference | Native timestamped send/receive; no NDK adoption. |

API 35 for `MidiUmpDeviceService` is not a baseline for ordinary controller input. It is one virtual UMP service’s introduction level. API 33 metadata does not prove a device implements MIDI 2. `PROTOCOL_UNKNOWN` is explicitly not an error. `PROTOCOL_UMP_USE_MIDI_CI` is not successful-negotiation evidence.

### Device and port lifecycle

**Fact:** `MidiDeviceInfo` exposes ID, type, ports, and properties that may include name, manufacturer, product, version, serial, USB device, or Bluetooth device. **Fact:** M32, `https://developer.android.com/reference/android/media/midi/MidiDeviceInfo.PortInfo`, exposes port direction, number, and name. **Fact:** direction is from the device perspective. An app opens a device input port to send to the device and output port to receive from it. **Fact:** device input-port access can be exclusive. **Fact:** device open is asynchronous and may fail. **Fact:** ports/devices/callbacks expose close, disconnect, and unregister operations.

**Inference:** selection state must not rely on a mutable display name alone. A future design must re-resolve identity without assuming IDs, names, serials, or USB objects survive reconnect or process recreation. No identity policy is selected.

M11/M12 are Android `Service` subclasses for virtual endpoints; their existence does not select a service or prove app/process survival. No source proves hot-unplug recovery, process-death recovery, background delivery, OEM consistency, or long-run USB stability. Package-level USB support is not parity across devices, controllers, hubs, cables, or power topologies.

### Android byte ownership and clocks

Android byte-stream input is raw and not aligned to message boundaries. A callback may contain several messages, part of one, and interleaved System Real-Time bytes. The callback byte array is valid only during the callback and needs defined ownership if retained. Timestamps are based on `System.nanoTime()`. M52, `https://developer.android.com/reference/android/os/SystemClock`, describes that clock as monotonic and suitable for intervals not spanning deep sleep.

These facts do not establish:

- a shared clock with audio rendering;
- a shared clock with an external trigger/capture;
- accuracy at the physical controller edge;
- callback latency or ordering under overload;
- future-scheduling accuracy;
- audible latency.

### Feature and permission conditions

The package says an app may declare `android.software.midi` when MIDI is required or check the feature at runtime. That manifest/product choice remains open.

M14, `https://developer.android.com/develop/connectivity/bluetooth/bt-permissions`, distinguishes OS from target SDK:

- If the app targets Android 12/API 31 or later, it declares `BLUETOOTH_SCAN` to look for devices, `BLUETOOTH_CONNECT` to communicate with already-paired devices, and `BLUETOOTH_ADVERTISE` only when making the device discoverable.
- On the relevant Android 12/API 31+ runtime, those operation-specific permissions are runtime Nearby Devices grants; each applicable operation requires user approval rather than one permission covering every Bluetooth use.
- If scan results derive physical location, `ACCESS_FINE_LOCATION` remains applicable. Otherwise `BLUETOOTH_SCAN` may use `neverForLocation`; M14 warns that this assertion can filter some BLE beacons.
- For a target SDK of Android 11/API 30 or lower, `BLUETOOTH` covers classic/BLE communication and `ACCESS_FINE_LOCATION` is required for scanning on Android 11 and lower, subject to the documented Companion Device Manager alternative.
- `BLUETOOTH_ADMIN` is required when initiating local-device discovery or manipulating Bluetooth settings under the legacy model.
- For an app supporting a service that can run on Android 10/API 29 or Android 11, M14 also requires `ACCESS_BACKGROUND_LOCATION` for background Bluetooth discovery.

BLE conditions do not prove a wired-only route needs Bluetooth permissions. They do not prove universal absence of wired permission or USB user-consent behavior. Target SDK, USB filters/consent, and BLE policy remain unselected.

The Android MIDI package names USB, BLE, and virtual/inter-app transports. It does not establish a built-in Android network MIDI transport. Network MIDI must not be inferred from Apple APIs.

## Timing, ordering, and real-time boundary

Three quantities must remain separate:

1. **Input transport/receipt latency:** physical controller trigger to application receipt.
2. **Scheduling/render contribution:** application receipt to audio frame consumption.
3. **End-to-end audible latency:** physical trigger to captured output onset.

A platform MIDI timestamp is not automatically physical-trigger or audible-output time. A software timestamp alone cannot prove physical latency.

M44 Jitter Reduction defines sender clock, clock messages, timestamp messages, and conversion into receiver time. That mechanism is not proof that the app, OS path, controller, or audio engine implements it correctly. MIDI 1 byte streams, Apple host time, Android `System.nanoTime()`, audio frame position, and external capture may be different clock domains.

The audio render callback remains a hard boundary:

- no blocking work;
- no I/O;
- no UI work;
- no parsing;
- no allocation;
- no arbitrary lock waiting;
- no potentially blocking logging.

Apple and Android MIDI callbacks are input/control boundaries, not the audio callback. Their API-specific behavior does not make arbitrary callback work audio-render safe.

Candidate questions for later architecture/spike work are:

- Where is raw MIDI framed and validated?
- Which context owns active-note and sustain state?
- How do platform timestamps map to an audio frame?
- What ordering applies to equal timestamps?
- What happens to late events?
- What fixed capacity exists between producer and renderer?
- What overflow policy applies by message class?
- How are drops, duplicates, inversions, and lateness counted without render-thread logging?
- How are removal, flush, route loss, suspend, and restart reconciled?
- How is a resource retired without blocking or use-after-free?

No queue size, late threshold, drop policy, converter, thread model, or ownership model is selected.

## Malformed input, SysEx, privacy, and trust

MIDI input is untrusted external data even from a local device. A future parser must handle partial/combined messages, running-status questions, interleaved real-time bytes, unsupported status, truncation, and repeated malformed input within fixed bounds.

SysEx and UMP data messages may span packets and carry arbitrary-length logical content. Apple’s packet-list add API documents a 65,536-byte packet-list limit and splitting large SysEx for that API. That API-specific capacity is not an accepted application maximum. No SysEx receive limit, buffering policy, timeout, trust model, or supported manufacturer message is selected.

MIDI-CI Property Exchange can expose structured resources through SysEx-based exchange. Device names, manufacturer/product fields, serials, SysEx, property data, profile claims, and network peers may be identifying, malformed, misleading, or large. The first wired spike should exclude Property Exchange and feature SysEx, apart from bounded rejection/test fixtures.

Network MIDI adds peer identity, discovery, local-network permission, unsolicited input, session lifecycle, and network trust. BLE adds nearby discovery, pairing, permissions, identity, and reconnect questions. Neither belongs in the first wired-controller claim.

Captured credentials, names, serials, properties, or streams should not enter logs/artifacts without approved minimization and redaction. This is a security/privacy recommendation, not adopted policy.

## Capability and unknown matrix

| Capability | Documentary status | Missing evidence before a claim |
| --- | --- | --- |
| MIDI 1 note/velocity | Layout and framing risks identified. | Bounded parser, corpus, malformed tests, devices. |
| Sustain CC64 | Number/threshold identified. | Ownership, repeats/late events, disconnect, audible result. |
| Stop Sound | CC120/121/123 distinction and flush risk identified. | Selected policy, state proof, receiver behavior, audible silence. |
| Apple wired input | Core MIDI surfaces documented. | Hardware/adapter route, permissions, lifecycle, clocks, physical tests. |
| Android wired input | API 23 USB package documented. | USB consent/manifest, OEM route, lifecycle, clocks, physical tests. |
| UMP | M44 and APIs documented. | Endpoint support, configuration, parser, conversion, conformance. |
| MIDI 2 | Selected M44 semantics documented. | Scope, endpoint support, conversion, devices. |
| MIDI-CI | Capability family documented. | Original v1.2.1, trust/limits, current workflow, conformance. |
| MPE | Historical v1.0 and current v1.1 identity documented. | Current v1.1 text, mapping/zone policy, devices. |
| BLE | Both platforms have surfaces. | Permission scope, pairing/reconnect, devices. |
| Network MIDI | Apple surface; no Android parity evidence. | Platform scope, permissions, trust, lifecycle, tests. |
| Virtual MIDI | Both platforms expose concepts. | Product need, lifecycle/security/manifest policy. |
| Timing/latency | Clock domains identified. | Approved method/budget, synchronization, captures, physical runs. |

## Decisions deliberately left open

- supported MIDI 1 message subset;
- repeated-note stack behavior;
- sustain ownership and debt reconciliation;
- Stop Sound and panic sequence;
- late-event and overflow policy;
- mapping, learn, splits, layers, transpose, and snapshots;
- program-change/controller mapping;
- device identity and reconnection policy;
- supported wired hardware/transport categories;
- minimum iOS/iPadOS and Android versions;
- Android target SDK, feature declarations, filters, and permissions;
- MIDI 2, MIDI-CI, MPE, BLE, network, virtual MIDI, and hosting scope;
- dependency, SDK, and native-boundary choices;
- device/measurement-data retention and redaction;
- numeric latency, loss, recovery, and soak budgets.

## Proposed later basic wired MIDI 1 spike

This is a recommendation for a separately approved procedure. It is unperformed and unapproved. It requests no hardware and adopts no numeric acceptance budget.

### Scope

- One approved Apple category and one Android category only if the later contract covers both.
- One approved wired MIDI 1 controller and required cable/adapter/interface per configuration.
- One built-in instrument path with an approved sound source.
- Note On, Note Off, velocity, CC64, connection status, removal, and Stop Sound.
- Basic playing first.
- Exclude BLE, network, virtual MIDI, feature SysEx, MIDI-CI, MIDI 2, MPE, hosting, recording, and architecture selection.

### Exact boundaries

Record separate markers for:

1. **Physical source:** electrical, optical, mechanical, or controller-generated marker tied to actuation.
2. **Application receipt:** first retained timestamp after platform delivery, naming its clock.
3. **Validated event:** sequence ID/disposition after bounded framing and validation.
4. **Render consumption:** exact callback/frame where the event changes synthesis state.
5. **Digital output onset:** output sample meeting a predeclared detector condition.
6. **Audible onset:** microphone or interface/loopback onset for the declared end-to-end boundary.

Do not substitute receipt for physical source time. Do not substitute render consumption for audible onset. Report source-to-receipt, receipt-to-render, render-to-output, and source-to-audible separately.

### Clock alignment and calibration

- Prefer one capture clock for source marker and audio output where approved.
- Otherwise record a known common marker before and after each run.
- Estimate offset, drift, and residual alignment uncertainty.
- Retain raw marker tracks and exact calibration calculation.
- Recalibrate after route, rate, controller, cable, device, sleep, or process changes.
- Include interface latency and detector uncertainty.
- Mark unresolved marker/onset trials censored or inconclusive rather than discarding them.

### Provisional workload

- Fixed declared warm-up before retained trials.
- Baseline: five repetitions of 100 isolated Note On/Off pairs at declared cadence.
- Normal: five 10-minute runs with chords, repeats, overlaps, velocity endpoints, sustain, and idle gaps.
- Burst: three 60-second runs at predeclared increasing rates and fixed payloads.
- Soak: three 60-minute sessions with periodic chord, sustain, release, and idle periods.
- Recovery: at least three repetitions each of unplug/replug, close/open, source removal, lifecycle transition, supported flush, and Stop Sound.
- Counts/durations are provisional method inputs, not pass budgets.

### Event integrity and queue evidence

Assign a monotonic test sequence at the controlled source or earliest measurable fixture. Retain source, receipt, validation, enqueue, render, and disposition records outside the audio callback. For each run report:

- sent and received counts;
- missing sequence IDs;
- duplicates and order inversions;
- timestamp regressions;
- late events against a future predeclared threshold;
- queue high-water mark;
- each overflow and disposition;
- malformed/truncated fixture disposition;
- callback/render deadline counters;
- interruption, disconnect, and reconnect transitions.

Overflow cannot be reported only as “audio seemed fine.” Evidence must identify accepted, rejected, coalesced, or dropped events and recovery.

### Active-note, sustain, and silence evidence

Maintain a bounded diagnostic ledger outside the renderer with:

- channel and key;
- note-on/off sequence;
- velocity;
- sustain state;
- released-but-sustained state;
- disconnect/flush generation;
- recovery action and disposition.

At recovery compare source events, diagnostic state, render counters, and captured audio. Define audible silence before the run using calibrated noise-floor/amplitude criteria and an observation window. Do not infer silence only from CC123, an empty note set, or UI state. Separate expected release tails from stuck-note failures.

### Overload and recovery measurement

Retain overload trigger, rate/payload trace, first overflow/deadline, last bad/missing event, recovery action, first valid resumed marker, and first conforming audible output. Report trigger-to-detection and trigger-to-resumed-marker separately. Keep runs that do not recover within the observation window.

### Statistics and retained artifacts

Retain every valid per-trial latency and every censored-trial reason. Report count, median, selected percentiles, minimum, maximum, outliers, and approved uncertainty. Do not hide warm-up, disconnect, overload, or tail failures in one average.

Retain:

- exact commit/build configuration;
- device, OS, controller, firmware if known, cable/adapter/interface, route, rate, buffer, power, thermal state;
- permission/feature configuration;
- raw audio and marker captures;
- raw MIDI/event traces;
- queue, deadline, underrun, loss, order, and recovery counters;
- calibration inputs/outputs;
- analysis script/version and deterministic command;
- all failed, censored, and excluded trials with reasons;
- independent reviewer and result.

No result can pass until a later task approves numeric budgets, device/controller/interface categories, workloads, method, and artifacts before execution. A simulator cannot establish physical-device latency or reliability.

## Findings by classification

### Facts

- MIDI 1 byte stream, MIDI 1 over UMP, MIDI 2 over UMP, MIDI-CI, and MPE are distinct.
- Apple and Android APIs have material symbol/API-level differences.
- Android basic MIDI is API 23; transport-specific UMP management is API 33; virtual UMP service is API 35.
- Captured protocol-aware functions M25, M68, and M70 have iOS/iPadOS 14.0+ metadata; exact M50 `MIDIEventList` and M51 `MIDIProtocolID` introduction dates remain unknown from their blank fields.
- MIDI callbacks have ownership/timing rules distinct from audio rendering.
- Note/sustain recovery needs more evidence than one All Notes Off.

### Inferences

- The smallest product-oriented experiment is wired MIDI 1 note/velocity/sustain into the built-in instrument.
- Advanced protocols/transports expand state, trust, compatibility, and tests before improving the first playable workflow.
- Note/sustain state, overflow, clock conversion, and disconnect recovery need explicit ownership.

### Recommendations

- Keep basic wired MIDI 1 first and advanced MIDI separately gated.
- Make Stop Sound observable through state and audible-silence evidence.
- Reject or bound unsupported SysEx/Property Exchange rather than buffer unbounded input.
- Preserve protocol, transport, device, OS, target SDK, permission, and hardware as separate dimensions.
- Obtain current original MIDI 1, MIDI-CI, and MPE v1.1 texts before current detailed conformance claims.

### Disagreements and cautions

- Platform conversion does not establish lossless semantic conversion.
- Android’s MIDI-CI-named constant does not override M44’s current stream-configuration account.
- Apple range metadata is not removal evidence without an explicit source.
- API availability is not a deployment target.
- OS transport support is not controller/device parity.

### Missing evidence

- Original current detailed MIDI 1 normative text.
- Original MIDI-CI v1.2.1 normative text.
- Original current MPE v1.1 text.
- Universal panic/reset ordering and other semantics absent from inspected originals.
- Apple blank availability and explicit replacement/deprecation evidence for ranged symbols.
- Wired permission/user-consent behavior for each selected route and target.
- Background, process-death, route-loss, hot-unplug, and reconnect evidence.
- Parser, queue, clock conversion, render, and lifecycle implementation evidence.
- Controller, adapter, device, OS, latency, loss, overload, and soak results.
- License clearance to incorporate or redistribute standards content.

## Conclusion

Evidence supports a narrow future wired MIDI 1 spike for the built-in instrument with note, velocity, sustain, connection lifecycle, bounded recovery, and measured audible output. It does not support declaring MIDI implemented, choosing architecture, promising controller parity, or enabling advanced MIDI scope. MIDI 2, MIDI-CI, MPE, BLE, network, virtual MIDI, and hosting remain separate later investigations with their own sources, threat boundaries, platform matrices, and device evidence. R07 retains dependency, SDK, standards-content, and redistribution review before adoption or incorporation.
