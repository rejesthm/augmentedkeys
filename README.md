# AugmentedKeys

AugmentedKeys is the planned foundation of an original, professional live keyboard performance application for Android and Apple phones and tablets.

## Current status

M0 — Research & Architecture. The repository contains a minimal Flutter shell and project controls. Audio, MIDI, patches, songs, setlists, instruments, and plugin hosting are not implemented.

## Supported project hosts

- Android phones and tablets
- iPhone and iPad
- No web or desktop hosts in the current scope

## Local verification

```bash
flutter pub get
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

## Project controls

Read `AGENTS.md`, `APP_SPEC.md`, `ARCHITECTURE.md`, `ROADMAP.md`, `LOOP.md`, and `STATE.md` before proposing work. Core engineering requires research, evidence, and explicit owner approval.

## Licensing

No project license has been granted in this phase. Dependencies and assets require review in `docs/research/LICENSE_LEDGER.md` before adoption.
