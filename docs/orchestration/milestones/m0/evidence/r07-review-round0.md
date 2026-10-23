# R07 independent reviews — rejected round0

Exact candidate `73622d81785f40c2cd46a42bddc4e2bf5286a8df`. QA REJECT0Critical/1Important/0Minor; Licensing/Security REJECT0Critical/2Important/0Minor. Three distinct Important findings remain: exact engine identity/current package-use scopes; vector_math composite BSD plus zlib-style license; JUCE exact-pin bundled/optional SPDX branches. No Final review or integration. Full review wording below has only trailing whitespace/final blank lines normalized; exact replies are immutable and hash-bound.

## qa-review

Independent read-only relay `01a16834-0b4b-7190-82b9-4c5f6ee12ba7` → child `01a16834-4222-7e43-b1f5-6a3c439280eb`, actual child sol/high/read-only and R07 cwd verified. CLI terminal. Controller records only.

- `qa-review.final.txt` SHA256 `bcb2f069d66b1ece46316aa86cb2b214b76096ed341d5313eed0899eaa29e702`.
- `qa-review-runtime.json` SHA256 `f3f72211af5dcc3fc6c132d2d37063595532a8b178c069b5d84abf74d6f89b2c`.
- `qa-review-relay.jsonl` SHA256 `c9544b76e0efb93b31a21201abd3d165c93f4648341e5d87d1e28aed56e37cf0`.
- `qa-review-child.jsonl` SHA256 `fe30aa79fbd40882d7c7ed85bc61e52981bf080fde0fdcd0f4f48e9dba006ae3`.

# R07 QA/Performance documentary review

**Role/runtime:** Configured QA/Performance Verifier, `gpt-5.6-sol`/high, effective read-only sandbox
**UUID:** `01a16834-4222-7e43-b1f5-6a3c439280eb`
**Candidate:** `73622d81785f40c2cd46a42bddc4e2bf5286a8df`
**Verdict:** **REJECT** — exact SHA only; not a Steward verdict
**Findings:** Critical **0** / Important **1** / Minor **0**

## Important finding

**I1 — Foundation SDK identity and dependency-use classification are incomplete or incorrect.**

- `docs/research/LICENSE_LEDGER.md:41` correctly says the `flutter`, `flutter_test`, and `sky_engine` lock versions `0.0.0` are labels, but it does not map `sky_engine` to the exact available Flutter engine identity. Captured L03 contains engine revision `0cd610717bde95fd88343c64f81c11ba4e5c0010` and engine content hash `13ffd72b2f9a5ca4db2a74ea52d5353ec2e8f939`; neither appears in the ledger. This leaves criterion 1’s exact SDK inventory incomplete.
- `docs/research/LICENSE_LEDGER.md:52,58,60,68-69,77` classifies `characters`, `collection`, `material_color_utilities`, `meta`, and `vector_math` as a “transitive development/test/tooling graph.” At the exact Flutter 3.44.8 installation, `/Users/jestherjordanminor/development/flutter/packages/flutter/pubspec.yaml:15-19` lists all five as regular dependencies of the direct-main Flutter SDK package. Several are also used by `flutter_test`, but that does not make their current dependency path exclusively development/test/tooling. The future shipped artifact remains unknown, yet the present dependency scope can and must be stated accurately.

**Required correction:** Explicitly map all three `0.0.0` SDK labels to the applicable pinned Flutter/Dart/engine identities, and classify hosted packages by evidenced current path—at minimum direct-main Flutter transitives versus test/dev/tooling transitives—while retaining the separate statement that actual shipped inclusion requires a future artifact graph.

## Criterion assessment

1. **Exact foundation inventory/use scopes: FAIL** due to I1. Versions, lock hashes, Flutter 3.44.8, Dart 3.12.2, and loop-tool provenance otherwise reconcile.
2. **Version-specific rights sources: PASS.** Exact pins, source URLs, dates, root/embedded/optional distinctions, and source limitations are present.
3. **Qualified conditions without legal conclusion: PASS.** Permissive, Apache, LGPL, AGPL, commercial, SDK, and content branches remain source-qualified and unapproved.
4. **Known candidate risks: PASS.** UAPMD/ARA, AAP/AAP-JUCE, JUCE, Oboe, CPAL, miniaudio, FluidSynth, sfizz, and TinySoundFont distinctions are carried.
5. **Code/content separation: PASS.** Samples, recordings, performance/composition, presets, patches, SF2/SFZ references, fonts/icons, and artwork remain separate and uncleared.
6. **Actionable gaps/security/privacy: PASS.** Provenance, graph, acquisition, parser/input, metadata, credentials, copyleft, content, platform, and drift gaps are explicit without vulnerability claims.
7. **Item ledger/status honesty: PASS except criterion-1 scope defect.** All entries remain **Not approved**; fact/inference/recommendation/open-question/owner-decision sections are separated.
8. **Future adoption checklist: PASS.** The 23-step procedure is exact-candidate/build/content/distribution-bound, unperformed, unapproved, and ends before separately authorized implementation.

## Fresh evidence

- `git rev-parse HEAD` → `73622d81785f40c2cd46a42bddc4e2bf5286a8df`; candidate is a commit and descends from base `a8b8f78c52d40ab03728073c2692ca6edb9a8d20`.
- Worktree clean; base diff contains only `M docs/research/LICENSE_LEDGER.md`.
- `git diff --check` → exit 0, no output.
- Ledger: 347 lines, 49,703 bytes; SHA-256 `1b1575b591a6c6bd377ed92b337ee122a63111d35fe6075b8271f4c6e7b34a1d`.
- Five public indexes: 78 unique requests, 77 HTTP 200 bodies, one preserved P75 HTTP 403. All 77 retained public hashes matched.
- Two local indexes: 56 unique bodies, all hashes matched.
- Reused evidence: 25 bodies—R04 9, R05 2, R06 14—all hashes matched.
- Independent lock/metadata recomputation: 23 hosted packages, zero version/archive-hash mismatches.
- Independent published-extract/cache-license comparison: 23 pairs, zero mismatches.
- `Not approved` occurs 64 times; zero approved rows; probe marker absent; zero trailing whitespace/CR bytes.
- Spot checks support UAPMD/ARA wording, JUCE AGPL/commercial and ISC-example branches, miniaudio alternatives, SDK-term limitations, and retained R04–R06 claims.

Git emitted read-only macOS `/tmp/xcrun_db` and cache-path warnings; requested Git results completed successfully.

## Context and limitations

Read the required app documents in order, continuation charter/context, OD006 `c9c0f9349bd69c7bc7b975b78000361f7a8956d4`, contract `eb0d55bc7e10b219996fdb7ab69a546b1e350e3a`, brief `2580cd495ef218c94f488f1622263e4cd61ff6ae`, assignment `08fbaf1f9078989813d32dcf17a940b142a5a3e4`, verification `d101b1e646a6784be4f687e951e1a37769dcd3bc`, source catalog `fe4c937535677e69bec8922e149698dfdc9306bb`, current state `0e308078d7779c6d54d4111ffdd5397725436e89`, complete ledger, and full base diff.

The user outcome is an accurate documentary adoption gate for later owner decisions. This review covers only that ledger. No package archive/content authentication, selected shipping graph, legal opinion, adoption, build, simulator/emulator, runtime, physical-device, audio/MIDI, profiling, latency, or long-run evidence exists or is claimed.

**One next action:** Correct I1 in the same ledger, freeze a new exact candidate, and request fresh affected QA review.

## security-review

Independent read-only relay `01a16834-0fcb-7732-a416-e0b934b5bf11` → child `01a16834-5a7d-72a1-aa47-30cc726da361`, actual child sol/high/read-only and R07 cwd verified. CLI terminal. Controller records only.

- `security-review.final.txt` SHA256 `5c6e631ac41c23be2fd5f6494e4accd46f2f52e153f047b2ac60bb753e7ac727`.
- `security-review-runtime.json` SHA256 `8ccfe63416f2da78031d7566f7ac6ddd895926345ee5d9586ed8a38adaabe5a4`.
- `security-review-relay.jsonl` SHA256 `b72d50075968194aeb4b9d77c925a41c949e688bc6804a2659dca76e29c1abf4`.
- `security-review-child.jsonl` SHA256 `08590d47b1d5e916d9a64693c81201d8455cd76c83fc26aa210514de8cd1c3e7`.

REJECT — exact candidate `73622d81785f40c2cd46a42bddc4e2bf5286a8df`

Critical: 0
Important: 2
Minor: 0

Identity: Licensing/Security Reviewer, child UUID `01a16834-5a7d-72a1-aa47-30cc726da361`, `gpt-5.6-sol`/high, read-only effective sandbox. No files, Git state, dependencies, permissions, accounts, or external systems were changed. This is not a Steward verdict.

## Important findings

1. `docs/research/LICENSE_LEDGER.md:51,77` misclassifies `vector_math` 2.2.0 as BSD-3-Clause-style only. Both captured published and cached bodies are identical, but `L49.txt:30-46` / P58 also contain Andrew Magill’s distinct zlib-style grant: commercial use is permitted, altered source must be marked, origin must not be misrepresented, and the notice cannot be removed from source distributions. Omitting this embedded license and its separate duties defeats the item-specific obligation record required by criteria 2, 3, and 7.

   Action: revise line 51 to distinguish 3 Apache packages, 19 BSD-only packages, and one composite BSD-3-Clause plus zlib-style package; revise the line-77 row to record both notices and both condition sets without implying archive or shipping clearance.

2. `docs/research/LICENSE_LEDGER.md:111` cites P74 only as an unspecified “SPDX inventory,” then defers everything to a future app graph. P74 is exact-pin evidence, not merely a generic unknown: it identifies JUCE 9.0.1 and its AGPL/commercial branch (`P74.txt:5-23`), ISC examples (`315-324`), bundled permissive/Apache families including zlib, HarfBuzz, SheenBidi, LunaSVG/PlutoVG, libpng, IJG, FLAC and Oboe, plus materially different optional/vendor branches—ASIO SDK 2.3 under `LicenseRef-Steinberg-ASIO OR GPL-3.0-only` (`614-623`), AAX SDK 2.9 under `LicenseRef-Avid-AAX OR GPL-3.0-only` (`766-775`), and AudioUnitSDK Apache-2.0 (`785-794`). Criterion 4 explicitly says an unknown future graph is not a reason to omit already-known branch distinctions; criterion 7 requires source-qualified implications.

   Action: add a compact exact-pin JUCE subinventory identifying material bundled and optional families, especially ASIO/AAX proprietary-or-GPL branches, while stating that applicability awaits a selected module/build graph. Preserve P75’s 403, the unchosen AGPL/commercial branch, and **Not approved** status.

## Criterion coverage

1. PASS — committed SDK/tool and 23-hosted-package inventory matches `pubspec.yaml`/lock; loop is separately scoped.
2. FAIL — `vector_math` composite identity and JUCE exact-pin component distinctions are incomplete.
3. FAIL — known `vector_math` source-distribution duties and JUCE optional-branch implications are omitted.
4. FAIL — UAPMD/ARA, AAP/AAP-JUCE, Oboe, CPAL/miniaudio, FluidSynth, sfizz and TinySoundFont are carried; JUCE’s known SPDX branches are not.
5. PASS — code/specification rights remain separate from recordings, compositions, performances, presets, patches, fonts/icons and exports; approved-piano gap remains.
6. PASS — provenance, supply-chain, malformed-input, privacy, credentials, platform and distribution questions are framed as gaps, not vulnerabilities.
7. FAIL — all rows remain **Not approved**, but the two item-specific records above are materially incomplete.
8. PASS — the future exact-candidate/build/content/distribution checklist is explicit, unperformed and unapproved.

## Fresh checks and sources

Read required app documents in mandated order plus continuation/app context at base `a8b8f78c52d40ab03728073c2692ca6edb9a8d20`; brief `2580cd…`, assignment `08fbaf…`, In-review `0e3080…`, verification `d101b1…`, source catalog `fe4c93…`, runtime `bed49b…`, OD006 and contract `eb0d55…`.

Fresh commands confirmed HEAD/candidate equality, base merge-base, empty status/staging, sole diff `docs/research/LICENSE_LEDGER.md`, and clean `git diff --check`. Ledger is 347 lines/49,703 bytes, SHA-256 `1b1575b591a6c6bd377ed92b337ee122a63111d35fe6075b8271f4c6e7b34a1d`; protected-path and secret-pattern scans were empty. All 77 public, 56 local, and 25 reused body hashes/lengths matched; all 23 version, lock-hash, and published/cache comparisons recomputed true. Actual bodies checked included P06/P09/P63–P65/P70–P74, L49/L54–L56, and reused AAP/Oboe/FluidSynth/sfizz/TinySoundFont sources. Current Android/iOS manifests add no sensitive permissions or entitlements.

Limitations: no archives or cached package contents were authenticated; no selected shipping graph, build, device, content, account-accepted terms, distribution scenario, or legal opinion exists. P75 remains HTTP 403.

Next action: correct the two ledger records, freeze a new exact candidate, and request fresh affected review.
