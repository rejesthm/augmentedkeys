# R01 correction round 1 — raw static verification output

- Execution timestamp: `2026-09-02T11:23:40+08:00`.
- Responsible recorder/reviewer: Roadmap Orchestrator (`/root`).
- Command working directory: `/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-r01-audio-architecture`.
- Candidate: `ef640cf0644b41de99302441ff539d7293443b57`.
- This is static documentary verification only. Empty-output checks are labelled explicitly.

## Environment command

```sh
date -Iseconds
uname -m
sw_vers
git --version
rg --version | head -1
shasum --version 2>&1 | head -1
/Applications/ChatGPT.app/Contents/Resources/codex --version
```

```text
2026-09-02T11:23:40+08:00
arm64
ProductName: macOS
ProductVersion: 26.6.1
BuildVersion: 25G76
git version 2.50.1 (Apple Git-155)
ripgrep 15.2.0 (rev e89fff89ac)
6.02
codex-cli 0.150.0-alpha.12.2
```

## Git identity and cleanliness commands

```sh
git rev-parse HEAD
git rev-parse HEAD^
git rev-parse b8d245683170a3f4961ca89e9cbf3a2d1d4cdfdb
git status --short --branch
git rev-parse main
git rev-parse origin/main
```

```text
ef640cf0644b41de99302441ff539d7293443b57
c94abe038f9c7bad224246bbc2a5a8bf2b61974f
b8d245683170a3f4961ca89e9cbf3a2d1d4cdfdb
## task/m0-r01-audio-architecture
b1b0c1edd5e42d3ea791f665c22954834e962d05
b1b0c1edd5e42d3ea791f665c22954834e962d05
```

The status output contains only the branch header and no changed path.

## Full candidate commands

```sh
git diff --check b8d245683170a3f4961ca89e9cbf3a2d1d4cdfdb..ef640cf0644b41de99302441ff539d7293443b57
git diff --name-status b8d245683170a3f4961ca89e9cbf3a2d1d4cdfdb..ef640cf0644b41de99302441ff539d7293443b57
git diff --numstat b8d245683170a3f4961ca89e9cbf3a2d1d4cdfdb..ef640cf0644b41de99302441ff539d7293443b57
```

```text
[git diff --check: empty output; exit 0]
A docs/research/LOW_LATENCY_RESEARCH.md
A docs/research/MOBILE_AUDIO_ARCHITECTURE.md
483 0 docs/research/LOW_LATENCY_RESEARCH.md
318 0 docs/research/MOBILE_AUDIO_ARCHITECTURE.md
```

## Round-1 correction commands

```sh
git diff --name-status c94abe038f9c7bad224246bbc2a5a8bf2b61974f..ef640cf0644b41de99302441ff539d7293443b57
git diff --numstat c94abe038f9c7bad224246bbc2a5a8bf2b61974f..ef640cf0644b41de99302441ff539d7293443b57
```

```text
M docs/research/LOW_LATENCY_RESEARCH.md
M docs/research/MOBILE_AUDIO_ARCHITECTURE.md
54 3 docs/research/LOW_LATENCY_RESEARCH.md
47 30 docs/research/MOBILE_AUDIO_ARCHITECTURE.md
```

## Protected-path command

```sh
git diff --name-only b8d245683170a3f4961ca89e9cbf3a2d1d4cdfdb..ef640cf0644b41de99302441ff539d7293443b57 -- lib android ios pubspec.yaml pubspec.lock AGENTS.md APP_SPEC.md ARCHITECTURE.md ROADMAP.md docs/adr gate.yaml loop-budget.md
```

```text
[empty output; exit 0]
```

## Hash and line-count commands

```sh
shasum -a 256 docs/research/MOBILE_AUDIO_ARCHITECTURE.md docs/research/LOW_LATENCY_RESEARCH.md
wc -l docs/research/MOBILE_AUDIO_ARCHITECTURE.md docs/research/LOW_LATENCY_RESEARCH.md
```

```text
a7842780cf1ae82327dd565fb2023a3b565ec4738badbc520b4dddf76ff6ad77 docs/research/MOBILE_AUDIO_ARCHITECTURE.md
bf7ede0c45db30d5cd6efd99b88b9908d40c61efebae04a14505838ffd9e2216 docs/research/LOW_LATENCY_RESEARCH.md
318 docs/research/MOBILE_AUDIO_ARCHITECTURE.md
483 docs/research/LOW_LATENCY_RESEARCH.md
801 total
```

## URL-count commands

```sh
rg -o 'https://[^)> ]+' docs/research/MOBILE_AUDIO_ARCHITECTURE.md docs/research/LOW_LATENCY_RESEARCH.md | wc -l
rg -o --no-filename 'https://[^)> ]+' docs/research/MOBILE_AUDIO_ARCHITECTURE.md docs/research/LOW_LATENCY_RESEARCH.md | sort -u | wc -l
rg -o --no-filename 'https://[^)> ]+' docs/research/MOBILE_AUDIO_ARCHITECTURE.md docs/research/LOW_LATENCY_RESEARCH.md | sort -u
```

```text
16
14
https://developer.android.com/games/sdk/oboe/low-latency-audio
https://developer.android.com/ndk/guides/audio/aaudio/aaudio
https://developer.android.com/ndk/guides/audio/audio-latency
https://developer.apple.com/documentation/AVFAudio/handling-audio-interruptions
https://developer.apple.com/documentation/avfaudio/avaudioengine
https://developer.apple.com/documentation/avfaudio/avaudiosession/setpreferrediobufferduration%28_%3A%29
https://developer.apple.com/documentation/avfaudio/responding-to-audio-route-changes
https://docs.flutter.dev/platform-integration/bind-native-code
https://docs.flutter.dev/platform-integration/platform-channels
https://github.com/RustAudio/cpal/blob/e1612d5d98152f8dc2a62e1b51ef7cbf4f7f26b7/README.md
https://github.com/google/oboe/blob/2a45aa2d9e94d209c4636eec4014dd83cda110f4/README.md
https://github.com/juce-framework/JUCE/blob/7aae7d8e8deb8413bb01633d2795ef9974a181c5/README.md
https://github.com/mackron/miniaudio/blob/9634bedb5b5a2ca38c1ee7108a9358a4e233f14d/README.md
https://source.android.com/docs/core/audio/latency/measure
```

## Correction-presence commands

```sh
rg -n '2a45aa2d9e94d209c4636eec4014dd83cda110f4|7aae7d8e8deb8413bb01633d2795ef9974a181c5|e1612d5d98152f8dc2a62e1b51ef7cbf4f7f26b7|9634bedb5b5a2ca38c1ee7108a9358a4e233f14d|v0.17.3|v0.18.2|2026-09-15' docs/research/MOBILE_AUDIO_ARCHITECTURE.md
rg -n 'Future capture or measurement execution is \*\*Blocked\*\*|data classification|synthetic and non-personal|informed consent|least-privilege|redaction|access-controlled storage|encryption|network transfer|retention|public artifact links|credential-bearing' docs/research/LOW_LATENCY_RESEARCH.md
```

Result: all four full SHAs and pinned sources were found; CPAL `v0.17.3`/`v0.18.2` reconciliation and the Oboe 2026-09-15 post-access conflict were found. The hard `Blocked` gate and every required privacy/security control were found at lines 151–171, with retention/link enforcement repeated at lines 289–292 and record fields at lines 369–387.

## Manual static audit

- All eleven `TEST_STRATEGY.md` evidence fields appear under `Identity and required TEST_STRATEGY fields`: command/procedure, date, commit, environment, device, OS, simulator/physical status, configuration, result, artifact/log location, reviewer.
- Eight planning device categories remain present: Modern iPad Pro, Mainstream iPad, Older supported iPad, iPhone, Flagship Android tablet, Mainstream Android tablet, Flagship Android phone, Mainstream Android phone.
- Built-in, wired, wired/USB audio, wired/USB MIDI, and wireless route classes remain present.
- No app build, Flutter command, simulator/emulator, physical-device, audio, MIDI, profiling, latency, thermal, soak, or long-run run was performed. No measured-performance claim is supported or made.
