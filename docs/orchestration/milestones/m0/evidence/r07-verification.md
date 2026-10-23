# R07 rejected round0 — correction required

Candidate `73622d81785f40c2cd46a42bddc4e2bf5286a8df` has QA REJECT0/1/0 and Licensing/Security REJECT0/2/0. Full outputs/runtime are in r07-review-round0.md. No Final or integration. Three Important findings require same-writer correction and fresh independent review. Preserved verification follows.

---

# R07 verification — review candidate

Exact candidate `73622d81785f40c2cd46a42bddc4e2bf5286a8df`, task base `a8b8f78c52d40ab03728073c2692ca6edb9a8d20`, brief `2580cd495ef218c94f488f1622263e4cd61ff6ae`, T01 `08fbaf1f9078989813d32dcf17a940b142a5a3e4`, In-progress `d522a2a1a015956046c7a0cc15daa16d0c07e613`, runtime `bed49b3bf54840ae94da192838a762da50e55b21`. Sources `f6eeb1edda840a2ca01ecf59809bb3462a89a81b` reconciled at `fe4c937535677e69bec8922e149698dfdc9306bb`. Sole assigned Conductor completed synthesis and relinquished writing; controller alone froze the candidate. Required independent QA/Performance, Licensing/Security and Final reviews are pending; this is not Verified or Accepted.

## Fresh controller verification

UTC `2026-10-23T13:12:26.626745+00:00`; ProductName:		macOS; ProductVersion:		26.6.2; BuildVersion:		25G83, arm64; git version 2.54.0 (Apple Git-157). Only `docs/research/LICENSE_LEDGER.md` differs from base; task clean. Report 347lines, SHA256 `1b1575b591a6c6bd377ed92b337ee122a63111d35fe6075b8271f4c6e7b34a1d`. All77 public bodies across five request indexes,56 local bodies and25 reused body hashes match;23 package version/lockhash/license-text comparisons recomputed. One JUCE commercial-terms HTTP403 remains preserved, with no inferred terms. Local/live remote main unchanged at `b1b0c1edd5e42d3ea791f665c22954834e962d05`; both excluded owner main-guard edit hashes match preserved originals. No product/protected/native/manifest or dependency/asset change; all license-adoption states remain Not approved.

```text
git diff --check a8b8f78c52d40ab03728073c2692ca6edb9a8d20 73622d81785f40c2cd46a42bddc4e2bf5286a8df
exit0; no output
git diff --name-only a8b8f78c52d40ab03728073c2692ca6edb9a8d20 73622d81785f40c2cd46a42bddc4e2bf5286a8df
docs/research/LICENSE_LEDGER.md
git status --porcelain
exit0; empty
```

These are documentary/static scope, whitespace and provenance checks. No Flutter/build/device/audio/MIDI/performance or conformance evidence was produced. No engine, format, platform API, architecture, content, budget or legal conclusion is adopted. Package metadata/license-text comparisons do not authenticate archives, cached package contents or a shipping graph; sources and handoffs are not substitutes for independent claim review.

## Local immutable evidence

- `candidate-verification.json` SHA256 `98c2fec5ab4d26ced95bd733e5db346060c8fa0e9e23d9e9ba9de95c0163f37b`.
- `conductor-synthesis-runtime.json` SHA256 `889dcd159dd4345a7768b2055b868aacfb9b792a359e270b5d1be8f46c31ae93`.
- `conductor-synthesis.final.txt` SHA256 `54dd6e72fa543b2120f972f0a37a1c31dcbeb1dbc72f57262b34ef2ebed2b751`.

## Writer handback (trailing whitespace normalized; exact original hash above)

R07 synthesis is complete.

- **Identity:** Conductor, `gpt-5.6-sol`, high, workspace-write; UUID `01a1672e-2573-7cf2-990e-310ef956eca3`.
- **Authority read:** required app/context/control documents at task base `a8b8f78c52d40ab03728073c2692ca6edb9a8d20`; brief `2580cd495ef218c94f488f1622263e4cd61ff6ae`; T01 `08fbaf1f9078989813d32dcf17a940b142a5a3e4`; In-progress state `d522a2a1a015956046c7a0cc15daa16d0c07e613`; runtime proof `bed49b3bf54840ae94da192838a762da50e55b21`; canonical evidence at milestone `fe4c937535677e69bec8922e149698dfdc9306bb`.
- **Changed path:** `docs/research/LICENSE_LEDGER.md`
- **Final SHA-256:** `1b1575b591a6c6bd377ed92b337ee122a63111d35fe6075b8271f4c6e7b34a1d`
- **Size:** 347 lines, 49,703 bytes.

Evidence incorporated: five public indexes with 78 requests, 77 HTTP 200 bodies and one preserved JUCE HTTP 403; two local indexes with 56 bodies; 25 reused R04–R06 bodies. The ledger cross-links the canonical hash register and records exact source IDs, URLs, access-date handling, pins, all 23 hosted package versions and lock/archive hashes, Flutter 3.44.8, Dart 3.12.2, loop-process provenance, material-font surfaces, candidate license branches, platform terms, and content risks.

All eight criteria are covered:

1. Existing SDK/package/tool inventory and use classification.
2. Exact rights-source identities, pins, URLs, notices, and evidence limits.
3. Source-qualified permissive, Apache, LGPL, AGPL, commercial, SDK, and content conditions.
4. Known UAPMD, AAP, JUCE, Oboe, CPAL, miniaudio, FluidSynth, sfizz, and TinySoundFont branches.
5. Separation of code/specification rights from samples, recordings, performances, presets, fonts, artwork, and exports.
6. Actionable provenance, supply-chain, security, privacy, account, and distribution gaps.
7. Item-specific reviewer/date/status entries with all states remaining **Not approved**.
8. An unperformed exact-candidate/build/content/distribution evidence checklist.

Validation passed:

- Only `docs/research/LICENSE_LEDGER.md` differs.
- HEAD remains `a8b8f78c52d40ab03728073c2692ca6edb9a8d20` on `task/m0-r07-licensing`.
- No staged paths or Git metadata changes.
- `git diff --check` passed.
- UTF-8, final newline, no CR, and no trailing whitespace passed.
- The probe marker is absent.
- All 23 package rows, versions, hashes, and source-ID links passed automated checks.
- Source counts, SDK pins, candidate pins, platform-term sections, preserved generic gates, and all eight criterion markers passed.
- “Not approved” appears 64 times; no row was approved.

The first in-memory generation attempt failed before writing because `Path.write_text()` received an unsupported `newline` argument. The ledger remained at the verified probe state; the corrected byte-write then succeeded.

Known limits remain explicit: no archive/content authentication, selected shipping graph, account-accepted terms, cleared piano/factory content, legal opinion, adoption, build, device evidence, or store/distribution conclusion exists. P75 remains a preserved HTTP 403.

I relinquish sole ownership of `docs/research/LICENSE_LEDGER.md` and am idle.

**Next action:** the controller should freeze and commit this exact candidate, establish the separate In-review barrier, then request fresh independent QA/Performance and Licensing/Security reviews followed by Final Code Review.
