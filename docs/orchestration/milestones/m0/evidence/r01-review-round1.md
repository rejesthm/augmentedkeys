# R01 specialist review — round 1

Status: `REJECTED; correction required`

- Candidate: `c94abe038f9c7bad224246bbc2a5a8bf2b61974f`
- Candidate parent / Researcher evidence: `b8d245683170a3f4961ca89e9cbf3a2d1d4cdfdb`
- Preliminary verification: `6364a055c52bb0eae5b11f75992b4d830e29219e`
- In-review state: `5fe715e5de2d47aa0a02b9802e313b34307aaa8d`
- Final Code Review: not dispatched because specialist reviews contain Important findings.

## Runtime provenance

QA/Performance used read-only relay `01a0600f-588f-71b2-8e6e-7f155ccb4859` and configured child `/root/r01_qa_review_v1`, ID `01a0600f-a326-7a23-82fb-fbd4495818fb`, role `qa_performance_verifier`, effective `gpt-5.6-sol` / `high` / `read-only`. Relay rollout SHA-256: `eaaf616102ca4f12a37228b0608e6a9397bc84743dc3e530f7ad10174f056ffd` (100 lines). Child rollout SHA-256: `00d5821675e9380f9256c740127673df5e87c3ae7018e96e78910447848304a1` (270 lines); its call inventory is 38 read-only `exec` calls.

Licensing/Security used read-only relay `01a0600f-5899-7ec1-993e-0afcf9f68b75` and configured child `/root/r01_security_review_v1`, ID `01a0600f-c03f-73d2-a07a-3049be720100`, role `licensing_security_reviewer`, effective `gpt-5.6-sol` / `high` / `read-only`. Relay rollout SHA-256: `fb6175c86b890d26e3e4cff1f1ca01786d29462eb8d2a9eb16e28463aaa06522` (116 lines). Child rollout SHA-256: `11f3017c465bbd01e85b4137d07b1b0a023a82b4429a3d8a65b7c64b4933857c` (152 lines); its call inventory is 16 read-only `exec` calls.

Both children ran at the milestone worktree. Neither had write authority. The byte-authoritative original replies remain in the hashed saved rollouts above; the decision-relevant text is preserved below without changing any finding, count, verdict, acceptance result, or limitation.

## Combined disposition

- Critical: 0.
- Important: 4 findings as independently reported; the QA immutable-revision finding and Security CPAL identity finding overlap but are both preserved.
- Minor: 1.
- QA/Performance: REJECT.
- Licensing/Security: REJECT.
- Scope boundaries: passed; no product code, dependency, asset, permission, architecture selection, benchmark, device result, or performance claim was introduced.
- Evidence honesty: failed until source identity, verification reproducibility, URL counting, and future measurement privacy/security controls are corrected.

Required correction round 1:

1. Pin Oboe, JUCE, CPAL and miniaudio to exact full commit SHAs and immutable blob/revision URLs; record access dates and re-audit associated claims.
2. Correct CPAL's stale `0.17.3` association by identifying the exact reviewed revision and reconciling it with the official release record current on the access date. Preserve historical Researcher evidence unchanged.
3. Make any future capture/measurement execution blocked until its manifest defines classification, synthetic/non-personal input preference, consent, least privilege, secret/identifier redaction, approved access-controlled storage, encryption where applicable, explicit network-transfer authority, retention/deletion, and prohibition of public or credential-bearing links.
4. Replace the preliminary verification record with an exact timestamp, fully resolved commands and refs, relevant tool versions/configuration, durable raw-output path and hash, and named reviewer.
5. Report URL counts accurately as file-URL occurrences versus normalized unique URLs.

## QA/Performance reply — decision-preserving repository copy

```text
REJECT

Critical: 0
Important: 2
Minor: 1
Acceptance criteria: FAIL
Evidence honesty: FAIL overall; unperformed-performance disclosure itself is PASS.

Findings

1. Important — Required repository revisions are missing. Acceptance criterion 1 requires repository revisions when available, but MOBILE_AUDIO_ARCHITECTURE.md:43 records moving branches without immutable SHAs for Oboe, JUCE, CPAL, and miniaudio, reiterated at lines 284–285. These repositories expose commit revisions. Correction: pin each source to an immutable commit/blob URL, record its full SHA and access date, then re-audit the associated claims.

2. Important — The canonical verification record does not meet the brief's evidence-field requirements. r01-verification.md:4 has only a date/timezone, not the required execution time; lines 47 and 51 contain placeholders or ellipses instead of exact commands; and no explicit artifact/log location or named reviewer is recorded. Relevant tool versions are also incomplete. Correction: record the exact timestamp, fully resolved commands and refs, all relevant tool versions/configuration, durable raw-output location and hash, and responsible reviewer.

3. Minor — r01-verification.md:51 reports “16 unique” URLs. Fresh normalization produced 14 unique URL strings. The likely cause is filename-prefixed rg output treating the two URLs appearing in both reports as distinct. Correction: report 14 unique URLs, or explicitly distinguish 16 file-URL occurrences from 14 unique URLs.

Acceptance criteria

1. FAIL — Apple/Android/Flutter coverage and access dates pass; available repository revisions are missing.
2. PASS — Native platform boundaries, portable boundary, and documentary candidates compared without selection.
3. PASS — Platform channels and FFI are integration mechanisms only.
4. PASS — Callback prohibitions and bounded transfer/ownership/lifecycle questions are covered.
5. PASS — Facts, inference, recommendations, disagreement, missing evidence, and owner decisions are separated.
6. PASS — All latency quantities are distinct; frames / sampleRate is correctly limited to nominal buffer duration.
7. PASS — Future physical-device procedure covers boundaries, calibration, clocks/error, workload, repetitions, tails, callback health, resources, thermal behavior, soak, and lifecycle.
8. PASS — All eight device categories and built-in, wired/USB, and wireless routes are carried forward without invented models.
9. PASS — Gap matrix, spike questions, risks, owner decisions, and all 11 TEST_STRATEGY template fields are present.
10. PASS — No candidate adoption, rejection, benchmark, device result, or measured-performance claim is made.

Fresh evidence: diff check passed; exactly the two contracted reports changed; protected-path check passed; task branch was clean. Architecture: 301 lines, SHA-256 c66b7f0feb012400a3dc17ad9c81c51fd4e931a10deb0cb20c904f840e3e9be7. Latency: 432 lines, SHA-256 a3bb410ba20b4fdafc3ff838abfa171eb19673c319377645ed59aee88915067d. TEST_STRATEGY fields: 11/11. Device categories: 8/8.

Evidence levels and limitations: static/documentary inspection performed. Unit/widget/integration tests, builds, simulator/emulator runtime, physical-device, audio, MIDI, profiling, latency, thermal, soak and long-run testing were not run and are not claimed. Apple direct pages initially returned JavaScript shells; official indexed Apple content supported the core claims. Git emitted sandbox diagnostics while still returning successful results.
```

## Licensing/Security reply — decision-preserving repository copy

```text
R01 Licensing/Security Review — r01_security_review_v1

Critical: 0

Important: 2

1. MOBILE_AUDIO_ARCHITECTURE.md:47 does not establish reproducible CPAL source/version identity. It associates the moving default branch with CPAL 0.17.3 from 2026-02-18, while the official release record lists 0.18.2 as latest before the report's 2026-09-02 access date. The intervening releases include material API, timestamp, iOS lifecycle, permission-error, and dependency changes.

Risk: claims from an unpinned moving branch cannot be reliably attributed to 0.17.3, 0.18.2, or another revision. Correction: preserve historical Researcher evidence unchanged, correct the candidate source register with the exact full commit SHA or immutable tag actually reviewed, clarify that 0.17.3 came from stale retrieval if retained, recheck CPAL claims, and update verification evidence and candidate hashes.

2. LOW_LATENCY_RESEARCH.md:132-149,252-264,323-324 requires raw audio/MIDI captures, logs, traces, device/environment records, and repository paths or durable links without requiring a privacy and secure-storage plan. It lacks data classification, synthetic-signal preference, consent rules, identifier/secret redaction, approved storage and access controls, encryption expectations, external-upload authority, and retention/deletion policy.

Risk: a later owner could approve the proposed manifest while raw microphone audio, device identifiers, local paths, or trace data remain eligible for indefinite or externally linked retention. No collection occurred. Correction: make execution Blocked unless the manifest defines test-data sensitivity, synthetic/non-personal inputs where possible, consent for ambient capture, least-privilege permissions, secret and identifier redaction, approved local or access-controlled storage, encryption where applicable, explicit authority for any network transfer, and retention/deletion rules. Prohibit public or credential-bearing artifact links.

Minor: 0

Verified: candidate adds exactly two Markdown reports, 733 lines total, with matching hashes. No code, asset, manifest, lockfile, dependency, SDK, permission, entitlement, or configuration changed. No credential, secret, token, private key, or authorization material was found. Reports reject architecture selection, adoption, license approval, legal advice, and measured-performance claims. R07's detailed legal assessment is not preempted.

Legal uncertainty: no candidate has version-specific license, commercial-use, attribution, redistribution, privacy, permission, or supply-chain approval. No package/source adoption, build, device operation, hardware use, permission grant, external account, or publication occurred. This was a read-only documentary review; moving web sources may change after the review date.

Scope: PASS
Evidence honesty: FAIL
Final verdict: REJECT
```

The saved rollout messages are authoritative where markdown links and incidental formatting were normalized in this repository copy.
