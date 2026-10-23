# AugmentedKeys Product Specification

## Approved direction

AugmentedKeys is planned as an original, reliable live keyboard instrument experience, not a desktop DAW clone. It is intended for performing keyboard players using Android phones or tablets, iPhone, or iPad with MIDI controllers and optional audio interfaces.

The future core workflow is: connect a controller, choose a setlist or song, load a patch, play, switch snapshots or patches, and control the experience through touch or MIDI.

## Worship patch builder priority

On 2026-10-23 the owner approved revising the delivery plan to prioritize a playable worship patch builder. The first-version design is [Worship Patch Builder](docs/superpowers/specs/2026-10-23-worship-patch-builder-design.md). This is product-planning authority; implementation still requires the applicable research, architecture, license, milestone, and device gates.

A patch is a saved combination of instruments, layers, and effects. The intended first-version workflow is: choose a starter sound, play it, blend up to four layers, adjust the sound, save the patch, recall verse/chorus/bridge variations, and arrange patches into an offline setlist. A beginner must be able to start from a piano-and-pad template without programming a synthesizer.

The target first-version content is a small original collection covering piano, ambient pad, and warm synth, with six editable starter patches. Piano content requires an approved sound source; a placeholder tone does not satisfy the piano requirement. The owner's Elevation Worship reference describes musical direction, not a requirement to copy or bundle another artist's recordings, commercial presets, branding, or artwork.

Bring the minimum built-in sound collection into the first playable milestone. Broader sound-library expansion, plugin hosting, advanced MIDI, and cloud workflows follow the core playable release. Every visible sound control must affect real playback, and saved edits must survive an application restart. Routine review of the detailed written design is delegated to the decision team and remains pending until that team returns its exact-candidate acceptance; no capability is implemented by this documentation change.

## Planned capabilities

The following are planned capability groups, not implemented features: audio and MIDI foundations; multi-layer patches; patch editing and switching; songs and setlists; professional MIDI control; plugin hosting; a built-in sound library; advanced performance controls; persistence and cloud-related workflows; and production hardening.

## Product requirements

Prioritize non-functional requirements in this order: reliability, latency, audio continuity, usability, then features. Core playing must work offline. Any future network service must remain isolated from and unable to block the playing path.

Create original product work and do not reproduce competitor designs, code, sounds, patches, or assets. Adopt dependencies, code, fonts, icons, DSP, samples, patches, and instrument assets only after licensing review in `docs/research/LICENSE_LEDGER.md`.

Design future touch workflows with accessibility in mind, including large touch targets and usable controls for live performance.

## M0 exclusions

M0 is Research & Architecture only. It excludes implementation of audio, MIDI, patches, layers, splits, snapshots, songs, setlists, plugin hosting, instruments, cloud services, and deployment. It also excludes selecting an audio, MIDI, plugin, or state-management architecture; adding third-party Flutter packages; enabling web or desktop hosts; and claiming unperformed research, benchmarks, builds, simulator checks, or device checks.

## Release evidence

No capability is feature complete without objective evidence and relevant device coverage. Evidence must identify whether it came from a simulator or a physical device and must not overstate what was tested.
