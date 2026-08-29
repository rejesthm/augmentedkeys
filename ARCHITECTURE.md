# AugmentedKeys Architecture Boundaries

## Current boundary

Flutter owns the current UI shell and future ordinary application coordination. It does not own hard real-time DSP responsibilities. The M0 shell establishes no product-core interfaces or engine selection.

A future native or shared-native engine may own evaluated real-time audio and related low-level responsibilities behind explicit boundaries. Its implementation language, framework, APIs, and integration approach remain undecided.

## Real-time and offline constraints

The future audio callback must not perform blocking work, I/O, UI work, parsing, allocation, arbitrary lock waiting, or potentially blocking logging. Offline core playing is required. Future network services must be isolated from the audio path and must not block it.

## Future domain concepts

The planned domain vocabulary is Library, Patch, Layer, Snapshot, Song, and Setlist. These are future concepts, not implemented models or interfaces.

## Decision process

Make any high-risk architecture decision in this sequence: research → spike → benchmark → ADR → owner approval → implementation. Record evidence and rejected alternatives; do not treat a proposal or experiment as an adopted architecture.

## Explicitly undecided

The following remain undecided: UAPMD, JUCE, C++, Rust, AVAudioEngine, AudioKit, Oboe, AAudio, AAP, AUv3, sound format, state management, persistence, and cloud sync.

Apple and Android plugin ecosystems must be researched and assessed independently. This document makes no claim that they are equivalent.
