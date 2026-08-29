# AugmentedKeys Product Specification

## Approved direction

AugmentedKeys is planned as an original, reliable live keyboard instrument experience, not a desktop DAW clone. It is intended for performing keyboard players using Android phones or tablets, iPhone, or iPad with MIDI controllers and optional audio interfaces.

The future core workflow is: connect a controller, choose a setlist or song, load a patch, play, switch snapshots or patches, and control the experience through touch or MIDI.

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
