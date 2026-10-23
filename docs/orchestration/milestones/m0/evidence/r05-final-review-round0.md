# R05 Final review — round0 rejection

Candidate `5b7390d91fd074479d1144d76233320999f3161e` remains unverified. Configured independent Final Reviewer REJECT:0Critical/2Important/0Minor; spec compliance FAIL, evidence honesty PASS. Earlier QA/Security approvals `68ab17c2e22168d41b2116e329986699cfb35816` remain preserved but do not override these findings. No integration or further task execution; formal same-writer correction round1 and fresh affected reviews are required.

Actual independent read-only relay `01a16849-6b83-7ea2-a178-69b31769b1a3` → configured Final child `01a16849-b045-7441-88bc-0b8b08e0b156`; saved metadata/last turn context show read-only R05 task cwd, child gpt-5.6-sol/xhigh. Controller records this artifact; reviewer made no shared writes.

- `final-round0-runtime.json` SHA256 `77f234e9ca471962fbaf83f320fbc09fd533d2886f5108d0d7f274bbcda6279b`.
- `final-round0.final.txt` SHA256 `ed199f927b8479e469f2932547c8c865db506ddefb4a0abfc3626210c0ab1e8c`.
- `final-round0-relay.jsonl` SHA256 `cf2d0c234334d5f097ea9ac4b4b80544d5b1257ca2740ad9a5b25f93b25d81bd`.
- `final-round0-child.jsonl` SHA256 `7bf83021114c9d57e6b2dae0387cc6aa50ba23be24e831703dcaad5cb3cd4a9d`.

## Literal review

# R05 Final Code Review

**Verdict: REJECT — exact candidate `5b7390d91fd074479d1144d76233320999f3161e`**

**Counts:** Critical 0 · Important 2 · Minor 0  
**Spec compliance:** FAIL  
**Evidence honesty:** PASS  
**Reviewer:** configured Final Code Reviewer, `gpt-5.6-sol` / xhigh, effective read-only sandbox  
**Child UUID:** `01a16849-b045-7441-88bc-0b8b08e0b156`

## Findings

1. **Important — required CC120/121/123 semantics are named but not explained.**  
   [MIDI_RESEARCH.md:96](/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-r05-midi/docs/research/MIDI_RESEARCH.md:96) lists All Sound Off, Reset All Controllers, and All Notes Off, then gives conversion/recovery caveats, but never states their supported positive MIDI 1 semantics. The inspected M17 body states that CC120 turns oscillators off and drives envelopes to zero as soon as possible, CC121 resets controller values to defaults, and CC123 performs All Notes Off, subject to the source’s mode qualifications ([M17-derived.txt:90](/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.git/decision-team-continuation/2026-10-23/r05/primary-sources/M17-derived.txt:90)). Brief acceptance criterion 2 explicitly requires these semantics “where supported.” Impact: the report does not provide the decision-useful distinction needed for later Stop Sound/recovery design. Correction: add source-qualified effects for all three, retain the sustain/envelope/receiver caveats, and continue to leave panic ordering/policy unselected.

2. **Important — known Android virtual-service security requirements are omitted.**  
   [MIDI_RESEARCH.md:205](/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-r05-midi/docs/research/MIDI_RESEARCH.md:205) says only “manifest declaration,” while lines 217 and 315 leave virtual-service security/manifest policy generally unresolved. The inspected Android package body explicitly requires the MIDI service to be guarded by `android.permission.BIND_MIDI_DEVICE_SERVICE` and shows `android:exported="true"` for both byte-stream and UMP virtual services ([M04-derived.txt:8351](/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.git/decision-team-continuation/2026-10-23/r05/primary-sources/M04-derived.txt:8351), [M04-derived.txt:8451](/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.git/decision-team-continuation/2026-10-23/r05/primary-sources/M04-derived.txt:8451)). Impact: Android service/permission and exported-component coverage is incomplete under criteria 4 and 6, despite the source already being captured. Correction: record the documented bind permission and exported-service form, distinguish this platform binding permission from user-granted runtime permissions, and keep product adoption and manifest policy open.

## Acceptance-criteria result

- AC1 standards identities, editions, layer separation, and gaps: PASS.
- AC2 messages/expression/recovery semantics: FAIL for finding 1.
- AC3 Apple APIs, availability, lifecycle, transports, and privacy limits: PASS.
- AC4 Android APIs, availability, lifecycle, transports, and permissions: FAIL for finding 2.
- AC5 clocks, callback boundaries, queues, malformed input, and recovery: PASS.
- AC6 licensing/privacy/security characterization: FAIL only for finding 2; other coverage passes.
- AC7 traceability, matrices, classifications, and retained failures: PASS.
- AC8 proposed unperformed measurement method: PASS.

## Fresh checks and source coverage

The candidate descends from base `22afbe4c38e2f46a758cce7e744b4819e116c6ad`; the worktree is clean. The complete diff is exactly one addition, `docs/research/MIDI_RESEARCH.md`, with 484 lines and 40,368 bytes. Working-tree and committed hashes both equal `8af0a9e4fc1f7668d3f2bba767e5841a1c7d56dbd0e3475a1b921c66b08b9a84`. `git diff --check` passed; no protected path, conflict marker, work marker, or credential-shaped text was found.

All three source indexes were checked: M01–M70, 68 successful bodies and two preserved failures. All 68 successful bodies rehashed without mismatch; index hashes matched the catalog. Original M44 UMP/MIDI 2 v1.1.2 and historical M46 MPE v1.0 identities/hashes and relevant rendered/extracted sections were inspected. Material Apple availability/callback, Android API/permission/framing, MIDI/MPE/UMP, timing, and licensing claims were checked against captured primary bodies rather than approval labels.

Evidence honesty passes: the report consistently separates fact, inference, recommendation, and missing evidence; it makes no implementation, adoption, conformance, device, latency, reliability, or legal-clearance claim.

## Context and limitations

I read the required app documents in prescribed order, continuation/context controls, contract `eb0d55…`, OD006 `c9c0f9…`, brief `f30f02…`, assignment `c433ba…`, runtime `0fb4ae…`, source reconciliation `77852b…`, initial verification `bad1af…`, QA/Security package `68ab17…`, and current In-review state `216698…`, plus the complete candidate and diff. This was documentary/static review only: no network re-fetch, build, Flutter command, simulator, device, controller, audio test, measurement, or legal assessment occurred. Current detailed MIDI 1, MIDI-CI v1.2.1, and MPE v1.1 originals remain unseen as disclosed.

**Next action:** start formal correction round 1 with the same sole writer, limited to the two passages above and their summary/matrix consistency, then rerun affected exact-SHA reviews.

This is not a Decision Steward verdict; R05 remains unverified.

## Controller receipt

Controller independently checked the retained M17 channel-mode summary and M04 virtual byte/UMP service sections. Both findings are supported by existing bodies; no gate or criterion is waived. An additional public Android permission-reference body may clarify bind-permission classification without any product/manifest adoption. Preserve candidate and all approvals/rejection.
