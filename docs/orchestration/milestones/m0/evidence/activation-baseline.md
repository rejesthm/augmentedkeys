# Activation baseline — retained original output

This is the original host-side run cited in OD-001, not a rerun. Recovered on 2026-08-30 by the Roadmap Orchestrator after activation review round 0 found that the output lacked a durable repository artifact. It proves no physical-device, simulator-runtime, audio, MIDI, compatibility, smoothness, or latency result.

- Tested commit: `b1b0c1edd5e42d3ea791f665c22954834e962d05`.
- Working directory: `/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-research`.
- Shell: `/bin/bash`; start time, OS, architecture and toolchain are in the original output below.
- Device / simulator / emulator / audio interface / MIDI controller: Not applicable.
- Configuration: unchanged scaffold and existing dependency constraints; no builds, app launches or package upgrades.
- Result: shell exit 0 after all checks under `set -euo pipefail`; two files formatted, zero changed; no analysis issues; one passing widget test. All seven constrained-package notices retained.
- Recorder: Roadmap Orchestrator; independent correction review remains required.
- Original source: `/Users/jestherjordanminor/.codex/sessions/2026/08/29/rollout-2026-08-29T14-46-55-01a04c45-76d8-7ef0-9cb4-101dbe82a224.jsonl`.
- Source prefix: first 7,653 JSONL records, SHA-256 `87f7ef589adb7682430c35145e67d314085cf686d020fe40fcd8934639a4a991`. The live source may grow; this identifies only that fixed prefix.
- Zero-based source ordinals: command 7634; initial output 7636; poll command 7649 for session 48802; final output 7652. Only the relevant nested command results are retained; unrelated tool results are excluded.
- JSON strings preserve whitespace, line endings and complete output. Decoding each `output` string, then concatenating start and completion, reproduces the original command output. This is not a prose reconstruction.

## Original command

```bash
set -euo pipefail
date '+%Y-%m-%dT%H:%M:%S%z'
sw_vers
uname -m
flutter --version
flutter pub get
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
git diff --check
test -z "$(git status --porcelain)"
test "$(git rev-parse HEAD)" = b1b0c1edd5e42d3ea791f665c22954834e962d05
printf 'M0_WORKTREE_BASELINE=PASS\n'
```

## Initial command result — ordinal 7636

```json
{
  "chunk_id": "5151a4",
  "wall_time_seconds": 1.002066166,
  "session_id": 48802,
  "original_token_count": 220,
  "output": "2026-08-30T15:14:34+0800\nProductName:\t\tmacOS\nProductVersion:\t\t26.6.1\nBuildVersion:\t\t25G76\narm64\nFlutter 3.44.8 • channel stable • https://github.com/flutter/flutter.git\nFramework • revision 058e0af2c2 (5 weeks ago) • 2026-07-23 10:56:21 -0700\nEngine • hash 13ffd72b2f9a5ca4db2a74ea52d5353ec2e8f939 (revision 0cd610717b) (1 months ago) • 2026-07-23 16:11:34.000Z\nTools • Dart 3.12.2 • DevTools 2.57.0\nResolving dependencies...\nDownloading packages...\n  clock 1.1.2 (1.1.3 available)\n  matcher 0.12.19 (0.12.20 available)\n  material_color_utilities 0.13.0 (0.13.1 available)\n  meta 1.18.0 (1.19.0 available)\n  stack_trace 1.12.1 (1.12.2 available)\n  test_api 0.7.11 (0.7.13 available)\n  vector_math 2.2.0 (2.4.2 available)\nGot dependencies!\n7 packages have newer versions incompatible with dependency constraints.\nTry `flutter pub outdated` for more information.\n"
}
```

## Completion result — ordinal 7652

```json
{
  "chunk_id": "6fec9b",
  "wall_time_seconds": 0.000001916,
  "exit_code": 0,
  "original_token_count": 325,
  "output": "Formatted 2 files (0 changed) in 0.00 seconds.\nResolving dependencies...\nDownloading packages...\n  clock 1.1.2 (1.1.3 available)\n  matcher 0.12.19 (0.12.20 available)\n  material_color_utilities 0.13.0 (0.13.1 available)\n  meta 1.18.0 (1.19.0 available)\n  stack_trace 1.12.1 (1.12.2 available)\n  test_api 0.7.11 (0.7.13 available)\n  vector_math 2.2.0 (2.4.2 available)\nGot dependencies!\n7 packages have newer versions incompatible with dependency constraints.\nTry `flutter pub outdated` for more information.\nAnalyzing m0-research...                                        \nNo issues found! (ran in 0.7s)\nResolving dependencies...\nDownloading packages...\n  clock 1.1.2 (1.1.3 available)\n  matcher 0.12.19 (0.12.20 available)\n  material_color_utilities 0.13.0 (0.13.1 available)\n  meta 1.18.0 (1.19.0 available)\n  stack_trace 1.12.1 (1.12.2 available)\n  test_api 0.7.11 (0.7.13 available)\n  vector_math 2.2.0 (2.4.2 available)\nGot dependencies!\n7 packages have newer versions incompatible with dependency constraints.\nTry `flutter pub outdated` for more information.\n00:00 +0: loading /Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-research/test/widget_test.dart\n00:00 +0: shows the truthful M0 foundation status\n00:00 +1: All tests passed!\nM0_WORKTREE_BASELINE=PASS\n"
}
```
