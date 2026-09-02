# R01 correction round 3 provenance

Status: `official chronology correction; review pending`

## Official Oboe release record

Read-only official GitHub API retrieval timestamp: `2026-09-02T12:06:05+08:00`.

```text
release tag: 1.10.0
release name: 1.10.0
published_at: 2025-09-15T18:59:30Z
created_at: 2025-09-15T18:13:00Z
target_commitish: main
release URL: https://github.com/google/oboe/releases/tag/1.10.0
official tag commit: a81bb9f87d4105b84b682685d3bfbb5beca371d1
```

Exact commands:

```sh
curl -fsSL https://api.github.com/repos/google/oboe/releases/tags/1.10.0
curl -fsSL https://api.github.com/repos/google/oboe/git/ref/tags/1.10.0
```

Conclusion limited to chronology and identity: Oboe `1.10.0` was published 2025-09-15 and was available before the 2026-09-02 R01 access date. The release tag commit is not asserted to equal the separately audited README content commit `2a45aa2d9e94d209c4636eec4014dd83cda110f4`.

No suitability, adoption, compatibility, licensing or performance conclusion follows.

## Candidate and implementer provenance

- Candidate: `09266fdc17e137db44495d85c6b42cf296efb89c`.
- Parent: `60c619ed0f54c4008e5e64ff5771576bb6a3e095`.
- Exact changed path: `docs/research/MOBILE_AUDIO_ARCHITECTURE.md`.
- Configured Conductor: `/root/r01_conductor_v2`, child `01a05fff-3c57-73a3-a747-8cb5f8611940`, nickname `Copernicus`, `gpt-5.6-sol` / `high` / `workspace-write`, network disabled.
- Child rollout SHA-256 `3501bdeefeb645fd22b43b7f43c30e7c2d9445739cc45871bf12c274a45eac62`, 501 lines; final report at zero-based ordinal 500.
- Relay rollout SHA-256 `a9823c42e632e1ca7705d46a886f56d6af6a700d9a62c43d98a77cc4b7406d36`, 178 lines; relayed final report at zero-based ordinal 177.

Complete literal Conductor report:

```text
Paths:
- docs/research/MOBILE_AUDIO_ARCHITECTURE.md

Checks:
- Base: 60c619ed0f54c4008e5e64ff5771576bb6a3e095
- git diff --check: PASS
- Single-path scope: PASS
- Oboe 1.10.0 publication timestamp 2025-09-15T18:59:30Z: PASS
- Official tag commit a81bb9f87d4105b84b682685d3bfbb5beca371d1: PASS
- Separate README content commit 2a45aa2d9e94d209c4636eec4014dd83cda110f4: PASS
- No release-tag/content-commit equivalence claim: PASS
- Stale Oboe chronology removed: PASS
- Binding callback boundary preserved: PASS
- LOW_LATENCY_RESEARCH.md unchanged: PASS
- Diff: 14 insertions, 4 deletions

Hash: SHA-256 55fcb9ba3f4e2256b6df4b5aab74f42f3536d624dc62f68dcabb5d0959640fd4
Lines: 323

Commit: not created because the worktree index.lock was outside the Conductor sandbox. Controller commit message requested: docs(m0): correct Oboe chronology.

Limitations: controller-owned evidence/state/provenance/review artifacts were not edited. No adoption, licensing, build, benchmark, hardware/device, audio/MIDI, latency, or performance conclusion occurred.
```

The controller independently inspected the one-path diff and created `09266fdc17e137db44495d85c6b42cf296efb89c` without content changes.
