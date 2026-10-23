# R05 independent specialist reviews — correction round1

Exact candidate `00952ed4bd563446ef450ce375cb5ec89edb43de`. QA and Licensing/Security each APPROVE0Critical/0Important/1Minor and explicitly close both original Final Important findings. Their Minor is the same single issue: report line50 still says three indexes while four now exist; correct substantive totals, complete M71 catalog and source support remain intact. Preserve this nonblocking wording issue for fresh Final assessment and milestone triage; no claim of zero findings. Candidate remains unchanged and In review; Final still required. Original rejection `664aec80035ef44fad5d88d409d28f2bb8597805` and older approvals remain preserved.

## QA/Performance runtime and literal review

Independent read-only relay `01a16834-0b4b-7190-82b9-4c5f6ee12ba7` → configured child `01a16834-4222-7e43-b1f5-6a3c439280eb`; actual saved metadata/turn context confirms R05 cwd, child gpt-5.6-sol/high. Completed relay; no writer/reviewer shared edits. Controller alone records evidence.

- `qa-round1-runtime.json` SHA256 `04368982f923c3251a276061660c00ea082cbbc244d5783c60064cead7929c5c`.
- `qa-round1.final.txt` SHA256 `adf53806393b7177d0c454276752c1c2f5a2d3e0c638647a09756cbd8f15270b`.
- `qa-round1-relay.jsonl` SHA256 `3b46a0161a34a9d848bc4fc56a63eccdb17f1186e94d2a2061cdbc43119bf2a8`.
- `qa-round1-child.jsonl` SHA256 `303b1fa879f21bbf5d57f84478ea41f22a9279cc74975fa01562fac719541f2b`.

# R05 QA/Performance Correction-Round-1 Review

**Role:** configured QA/Performance Verifier, `gpt-5.6-sol`/high, effective read-only sandbox  
**Child UUID:** `01a16834-4222-7e43-b1f5-6a3c439280eb`  
**Candidate:** `00952ed4bd563446ef450ce375cb5ec89edb43de`  
**Original base:** `22afbe4c38e2f46a758cce7e744b4819e116c6ad`  
**Verdict:** **APPROVE**  
**Counts:** Critical 0 · Important 0 · Minor 1  
This is not a Decision Steward verdict.

## Prior Final-finding disposition

1. **Final I1 — CLOSED.**  
   `docs/research/MIDI_RESEARCH.md:96-105` now gives source-qualified positive effects for CC120, CC121, CC123, and CC124–127. Direct inspection of M17 confirms:

   - CC120 turns oscillators off and sets volume envelopes to zero as soon as possible.
   - CC121 resets controller values to defaults, with Recommended-Practice/value qualifications.
   - CC123 performs All Notes Off subject to the actual mode-command text.
   - CC124–127 select the stated Omni/Mono/Poly modes and also cause All Notes Off.

   The correction retains the decisive limits: M17 is an incomplete public summary; sustain, release envelopes, mode, and receiver behavior can alter audible results; M44 excludes MIDI 2 per-note controls/pitch from Reset All Controllers; no universal silence or panic ordering is claimed. The Stop Sound matrix and calibrated-silence method remain consistent at `:309` and `:402-418`.

2. **Final I2 — CLOSED.**  
   `MIDI_RESEARCH.md:205-220`, `:318`, `:446`, and `:480-481` now document Android virtual-service binding/export requirements without adopting them. Independent body inspection confirms:

   - M04 shows both byte-stream and UMP service forms with `android:permission="android.permission.BIND_MIDI_DEVICE_SERVICE"` and `android:exported="true"`.
   - M11/M12 confirm the virtual service classes, manifest declaration surfaces, and M12’s complete-UMP/equal-port conditions.
   - M71 records API 23, signature protection, and the requirement intended to ensure only the system binds.

   The report accurately distinguishes this component-binding guard from Bluetooth Nearby Devices runtime grants and leaves virtual MIDI, manifest configuration, lifecycle, and enforcement testing unselected.

## New finding

**Minor — stale index cardinality.**  
`docs/research/MIDI_RESEARCH.md:50` says “All three request indexes are complete,” but correction round 1 has four indexes, including `index-correction1.json`. Change this to “All four request indexes” or explicitly distinguish the original three plus the correction-round index. This does not obscure M71: totals at `:5`, the exact M71 URL/access date at `:207`, and the canonical source catalog are correct.

## Acceptance and source checks

All eight brief criteria pass. In particular, AC2 and AC4/AC6 now pass through the closed findings; AC7 remains traceable despite the nonblocking wording Minor. The unchanged measurement plan still separates physical source, receipt, render, digital output, and audible onset; specifies clock calibration/uncertainty, event loss/order/overflow, stuck-note/sustain, recovery/overload, three 60-minute soaks, and raw artifacts at `:339-437`. No performance result or runtime/device guarantee is inferred.

Fresh source verification found four indexes covering M01–M71: 71 requests, 69 bodies, two preserved failures, no duplicate IDs. All 69 indexed body sizes and SHA-256 values matched; the original 68 bodies remained unchanged. M71 matched SHA-256 `1b2f8939b7f3e0df1e3ba8ec1df2baa6cabf9d5c14dafea7a9790309b3503bf4`; its index matched `d08e4a2c69a082e31acd4233d89babb28d749bc71b73ddbf12c134454ca52eec`.

## Fresh repository checks

- `git rev-parse HEAD` returned `00952ed4bd563446ef450ce375cb5ec89edb43de`.
- Base ancestry passed; worktree status was clean on `task/m0-r05-midi`.
- `git diff --check <base>..<candidate>` exited 0.
- Base-to-candidate scope was exactly `A docs/research/MIDI_RESEARCH.md`; no protected path changed.
- Prior-to-candidate correction was 17 insertions/12 deletions.
- Report is 489 lines, 42,838 bytes, SHA-256 `034ad9cc008dbc836ca73301de26f725046f754c9b6e526b708a518e2c93b078`.
- No conflict or work markers were found.

Read-only sandbox cache-denial warnings appeared during Apple Git startup, but all cited commands completed successfully and no file or Git state was changed.

## Limitations and next action

This was documentary/static review only: no build, analyzer, test, simulator/emulator, runtime, device/controller, MIDI/audio test, profiling, latency measurement, or soak execution occurred. Current detailed MIDI 1, MIDI-CI v1.2.1, and MPE v1.1 originals remain unseen as disclosed. No implementation, adoption, conformance, legal-clearance, reliability, or performance conclusion follows.

**Next action:** record this exact-SHA QA approval with the nonblocking index-cardinality Minor preserved for subsequent review.

## Licensing/Security runtime and literal review

Independent read-only relay `01a16834-0fcb-7732-a416-e0b934b5bf11` → configured child `01a16834-5a7d-72a1-aa47-30cc726da361`; actual saved metadata/turn context confirms R05 cwd, child gpt-5.6-sol/high. Completed relay; no writer/reviewer shared edits. Controller alone records evidence.

- `security-round1-runtime.json` SHA256 `452d6d77538c309186c972baf534a1c509c93cba11095ff988ff0ef6246c6d22`.
- `security-round1.final.txt` SHA256 `0da9e150febbf817b55657e2e5250e6a413612c69096910bbf6408952e72158c`.
- `security-round1-relay.jsonl` SHA256 `fad91093469162c3b391e153c1bda4b7cdc46149ed68d660dc244c5d8c294694`.
- `security-round1-child.jsonl` SHA256 `3f44c67e90be5f7e0005f343e36333ca6c0f2f776d06de26b9046829f72a5c8d`.

# R05 Licensing/Security Review — correction round 1

**Verdict: APPROVE — exact candidate `00952ed4bd563446ef450ce375cb5ec89edb43de`**

**Counts:** Critical 0 · Important 0 · Minor 1  
**Reviewer:** configured Licensing/Security Reviewer, `gpt-5.6-sol` / high, effective read-only sandbox  
**Child UUID:** `01a16834-5a7d-72a1-aa47-30cc726da361`

## Findings

### Critical

None.

### Important

None.

### Minor

1. **Stale index count.** [MIDI_RESEARCH.md:50](/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-r05-midi/docs/research/MIDI_RESEARCH.md:50) says “all three request indexes,” but adding `index-correction1.json` makes four indexes. The report’s substantive totals—71 requests, 69 successful bodies, two failures—are correct, and M71 is fully cataloged, so this does not undermine claim support. Action: change “three” to “four” in a future permitted documentary correction.

## Original Final findings

- **Final I1 — CLOSED.** Lines 96–105 now state M17-qualified positive semantics for CC120, CC121, CC123, and CC124–127. The wording matches M17’s actual body: All Sound Off terminates oscillators and zeros envelopes as soon as possible; Reset All Controllers restores documented defaults; All Notes Off turns off oscillators subject to mode text. The report preserves M17’s incomplete-summary status, receiver/mode/sustain/release limitations, MIDI 2 per-note reset distinction, audible-silence uncertainty, and leaves panic ordering unselected.
- **Final I2 — CLOSED.** Lines 205–220, 318, 446, and 480–481 record M04’s guarded `android:exported="true"` manifest forms for byte-stream and UMP virtual services. M71 supports API 23, signature protection, and the stated system-only binding purpose. The report correctly distinguishes this component-binding restriction from Bluetooth Nearby Devices runtime grants and explicitly leaves virtual MIDI, manifest, target-SDK, permission, lifecycle, and enforcement adoption open.

## Licensing/security assessment

No dependency, SDK, standards text, code, asset, manifest, entitlement, permission, or privacy-key adoption occurs. `pubspec.yaml`, `pubspec.lock`, `LICENSE_LEDGER.md`, Android/iOS manifests, and protected paths are unchanged. Existing Android and iOS manifests contain no MIDI virtual service or newly proposed privacy permission.

M44/M46 remain identified as all-rights-reserved documentary sources; public access is not treated as incorporation or redistribution permission. Current detailed MIDI 1, MIDI-CI v1.2.1, and MPE v1.1 originals remain missing, and lines 475–485 preserve those limits plus the absence of legal clearance. R07 remains the gate before dependency, SDK, standards-content, or redistribution adoption.

Privacy/security boundaries remain appropriately prospective: device identifiers and names, serials, SysEx, Property Exchange, network peers, logs, malformed input, and bounded resource handling are documented without claiming adopted policy or implementation.

## Fresh checks and evidence

- Base ancestry passed: `22afbe4c38e2f46a758cce7e744b4819e116c6ad`.
- Complete base diff: exactly `docs/research/MIDI_RESEARCH.md`, 489 lines.
- Correction diff: 17 insertions, 12 deletions.
- Committed and working-tree SHA-256: `034ad9cc008dbc836ca73301de26f725046f754c9b6e526b708a518e2c93b078`.
- `git diff --check` passed; worktree status was empty.
- Four indexes contain 71 unique IDs: 69 successful bodies and failures M16/M45. All 69 successful body byte counts and SHA-256 values matched.
- Independently inspected actual M17, M04, M11, M12, and M71 bodies. Relevant hashes matched the catalog, including M71 `1b2f8939b7f3e0df1e3ba8ec1df2baa6cabf9d5c14dafea7a9790309b3503bf4`.
- No credential-shaped addition was found.

## Context and limitations

Read unchanged governing app documents and controls from the prior R05 review, then current brief `f30f02…`, contract `eb0d55…`, OD006 `c9c0f9…`, Final rejection `664aec…`, T02 `59ee0e…`, correction state `34f291…`, source update `c652fb…`, verification `8bc677…`, and In-review state `88e24e…`.

The user outcome remains a trustworthy documentary basis for future reliable basic wired MIDI 1 control, not implemented MIDI capability. This review covered only the exact correction and affected licensing/security evidence. No network re-fetch, build, device, MIDI/audio test, runtime measurement, adoption, or legal assessment occurred.

**Next action:** dispatch the required fresh independent Final review of exact candidate `00952ed4bd563446ef450ce375cb5ec89edb43de`, carrying the nonblocking index-count Minor.

This is not a Decision Steward verdict.

