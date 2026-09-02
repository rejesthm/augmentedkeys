# R01 Researcher correction evidence — round 1

Status: `READ-ONLY, NON-ADOPTING`
Access date: 2026-09-02

## Authority and runtime

- Brief: `b50e58e187f60b20ab9f12c7306af63a3cba3a9e`.
- Rejected candidate: `c94abe038f9c7bad224246bbc2a5a8bf2b61974f`.
- Round-1 review: `60be2835790681859c8b38a8762ea20ac0f3c72c`. Earlier current evidence transcribed this SHA incorrectly; the append-only mapping and proof are recorded in `r01-correction-round2-provenance.md`.
- Correction transition T07: `659f6aaf9e3a440403d4796518d668647759de93`.
- In-progress state: `0b5418a4f60dc447858119f7d3baba252d643c9e`.
- Read-only relay: `01a0601a-fb60-70c0-ae5e-fe99689cd10e`, `gpt-5.6-luna` / `low` / `read-only`; rollout SHA-256 `50f0b1d9c2deb2eb3d7edeeb90b30dbd8fb32832435a00456d3b7b19ba56f798` (88 lines).
- Configured Researcher: `/root/r01_researcher_correction_round1`, child `01a0601b-4948-7bc1-b325-99913adc84cb`, role `researcher`, `gpt-5.6-terra` / `high` / `read-only`; rollout SHA-256 `bf681c67e06f981b28c50a5c78816902320cbac53c105e88fb7efb8ebedce509` (180 lines; 25 read-only `exec` calls).
- The child performed no repository mutation, adoption, licensing conclusion, build, benchmark, or hardware action. Its byte-authoritative literal response remains in the hashed rollout.

## Immutable source register

The Researcher resolved CPAL `v0.18.2` fully and returned official short commit identities for the other three repositories. The controller completed those identities with read-only calls to GitHub's official commit API, then opened the SHA-pinned README content without writing files.

| Project | Repository | Full content commit SHA | SHA-pinned evidence | Default branch | Relevant release/tag as of access date | Commit date | Access date |
|---|---|---|---|---|---|---|---|
| Oboe | `google/oboe` | `2a45aa2d9e94d209c4636eec4014dd83cda110f4` | [README](https://github.com/google/oboe/blob/2a45aa2d9e94d209c4636eec4014dd83cda110f4/README.md) | `main` | Researcher found `1.9.3` as the last release verifiably before the access date; the rendered `1.10.0` record was dated 2026-09-15 and is not used as an as-of-2026-09-02 release | 2026-08-13T19:59:52Z | 2026-09-02 |
| JUCE | `juce-framework/JUCE` | `7aae7d8e8deb8413bb01633d2795ef9974a181c5` | [README](https://github.com/juce-framework/JUCE/blob/7aae7d8e8deb8413bb01633d2795ef9974a181c5/README.md) | `master` | `9.0.1`, release date 2026-08-10; the content commit is later and is not asserted to be the release tag | 2026-08-20T15:09:27Z | 2026-09-02 |
| CPAL | `RustAudio/cpal` | `e1612d5d98152f8dc2a62e1b51ef7cbf4f7f26b7` | [README](https://github.com/RustAudio/cpal/blob/e1612d5d98152f8dc2a62e1b51ef7cbf4f7f26b7/README.md) | `master` | `v0.18.2`, 2026-08-16; prior `v0.17.3`, 2026-02-18 | 2026-08-16 | 2026-09-02 |
| miniaudio | `mackron/miniaudio` | `9634bedb5b5a2ca38c1ee7108a9358a4e233f14d` | [README](https://github.com/mackron/miniaudio/blob/9634bedb5b5a2ca38c1ee7108a9358a4e233f14d/README.md) | `master` | `0.11.25`, release date 2026-03-04; content commit message `Version 0.11.25` | 2026-03-03T20:25:00Z | 2026-09-02 |

Official GitHub commit-API resolution:

- `google/oboe@2a45aa2` → `2a45aa2d9e94d209c4636eec4014dd83cda110f4`.
- `juce-framework/JUCE@7aae7d8` → `7aae7d8e8deb8413bb01633d2795ef9974a181c5`.
- `mackron/miniaudio@9634bed` → `9634bedb5b5a2ca38c1ee7108a9358a4e233f14d`.
- `RustAudio/cpal@fd3b945` → `fd3b945bffcaa493fa7cb5ceddf9db1f9330fd30` for the historical `v0.17.3`-period commit record.

These calls establish commit identity, not suitability or release-tag equivalence unless separately stated.

## Claim audit

| Project claim | Verdict | Immutable source location | Bounded explanation |
|---|---|---|---|
| Oboe is a C++ library for Android. | `SUPPORTED` | Oboe README lines 5–9 at `2a45aa2d…` | The README identifies Android C++ scope. |
| Oboe chooses OpenSL ES on API 16+ or AAudio on API 27+. | `SUPPORTED` | Oboe README lines 7–11 at `2a45aa2d…` | Preserve the explicit API-16 floor; this is documentary behavior, not device/performance proof. |
| JUCE is a cross-platform C++ application framework for desktop/mobile applications. | `SUPPORTED` | JUCE README lines 3–9 at `7aae7d8e…` | Identity only; no product adoption or parity conclusion. |
| JUCE supports Xcode iOS and Android Studio project exports. | `SUPPORTED` | JUCE README lines 3–9 at `7aae7d8e…` | Does not establish AugmentedKeys device/OS support or runtime behavior. |
| JUCE describes audio plug-ins and plug-in hosts. | `SUPPORTED` | JUCE README lines 3–5 at `7aae7d8e…` | Does not establish mobile-host feasibility, distribution, lifecycle, or real-time suitability. |
| CPAL is low-level Rust audio input/output. | `SUPPORTED` | CPAL README at `e1612d5d…`, title/opening | Documentary identity only. |
| CPAL lists Android/AAudio and iOS/CoreAudio backends. | `SUPPORTED` | CPAL README at `e1612d5d…`, Supported Platforms | Backend listing only; no Flutter, latency, lifecycle, or device proof. |
| miniaudio is a C playback and capture library. | `SUPPORTED` | miniaudio README line 6 at `9634bedb…` | Documentary identity only. |
| miniaudio lists iOS and Android support. | `SUPPORTED` | miniaudio README lines 173–184 at `9634bedb…` | Does not prove route, interruption, latency, or device behavior. |

## CPAL reconciliation

- Verified fact: official `v0.17.3` history is dated 2026-02-18; full related commit identity returned by the official commit API is `fd3b945bffcaa493fa7cb5ceddf9db1f9330fd30`.
- Verified fact: official `v0.18.2` was dated 2026-08-16 and existed before the 2026-09-02 access date; immutable content commit is `e1612d5d98152f8dc2a62e1b51ef7cbf4f7f26b7`.
- Reconciliation: the rejected candidate's `0.17.3` date is a valid historical release fact but is stale as the current release identity on 2026-09-02. Candidate claims should be re-audited and pinned to `v0.18.2` content while retaining the historical discrepancy transparently.
- No license, adoption, compatibility, or performance conclusion follows.

## Candidate correction targets

1. Source register D3: replace the inconsistent Oboe `1.10.0 dated 2025-09-15` entry; bind documentary claims to `2a45aa2d9e94d209c4636eec4014dd83cda110f4` and keep release-date uncertainty separate.
2. Source register C1: pin JUCE to `7aae7d8e8deb8413bb01633d2795ef9974a181c5` and its immutable README.
3. Source register C2: state that CPAL `0.17.3` is historical/stale on the access date; pin current audited claims to `v0.18.2` / `e1612d5d98152f8dc2a62e1b51ef7cbf4f7f26b7`.
4. Source register C3: pin miniaudio to `9634bedb5b5a2ca38c1ee7108a9358a4e233f14d` and its immutable README.
5. Split combined candidate identities into per-project statements with exact immutable evidence and retain non-suitability caveats.
6. Update the candidate-to-evidence matrix and missing-evidence section so immutable revisions are no longer listed as missing for these audited documentary claims.

## Disagreements, limits and stop boundaries

- The rejected Oboe `1.10.0 dated 2025-09-15` statement conflicts with the Researcher's official release rendering, which dated it 2026-09-15. It must not be used as evidence available on 2026-09-02.
- GitHub's commit API supplied the full identities behind the official abbreviated commit links. Tag-to-commit identity was not inferred for Oboe or JUCE.
- No source establishes callback safety, interruption/route recovery, Flutter integration, mobile plug-in-host feasibility, latency, hardware behavior, compatibility, or adoption suitability.
- No candidate source was downloaded or executed. No benchmark, build, simulator/emulator, physical-device, MIDI, or audio work occurred.
