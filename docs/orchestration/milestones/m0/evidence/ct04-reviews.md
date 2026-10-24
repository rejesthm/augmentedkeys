# CT04 independent reviews

## Round0 — rejected candidate aabd1b2ba3d26c35343b9c0bdb5fbf17de62ceb5

QA and Security independently REJECT: each0Critical/5Important/0Minor, Spec Compliance FAIL, Evidence Honesty FAIL. Their five finding groups overlap; no finding is waived or downgraded. Final was not dispatched. Complete literal outputs follow, with private raw/runtime snapshots retained.

### qa provenance

Output SHA256 `b7cb46c14877373c338fdac5eafab7ac89a66d69c9ca535aa8776ed2085d4d42`; child 01a16834-4222-7e43-b1f5-6a3c439280eb; relay 01a16834-0b4b-7190-82b9-4c5f6ee12ba7; actual child sol/high/read-only in exact CT04 cwd. Raw child snapshot SHA256 `41b3052772a86bdb38798dac88564ee8763741ee06414cfda5bcd3e22f16bb35`; relay `50498a8a2d0377ef07d32c11751007f45750f8c3b46cc020083a15d016535cde`. Controller is recorder, not reviewer.

# CT04 QA/Performance Review — Round 0

**Verdict: REJECT**  
**Candidate:** `aabd1b2ba3d26c35343b9c0bdb5fbf17de62ceb5`  
**Findings:** Critical 0 · Important 5 · Minor 0  
**Spec Compliance:** FAIL  
**Evidence Honesty:** FAIL

## Identity and scope

- Role: QA/Performance Verifier
- UUID: `01a16834-4222-7e43-b1f5-6a3c439280eb`
- Model/effort/sandbox: `gpt-5.6-sol` / high / effective read-only
- CWD: `/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/ct04-governance-correction`
- Independent read-only child through a read-only relay; no mixed-permission nesting, agents, writes, Git mutation, network, devices, or Flutter/product work.

Read candidate-bound app documents in required order, including blobs `APP_SPEC 0aa1d325…`, `ARCHITECTURE aa28fca2…`, `ROADMAP 2824afff…`, `STATE 65d2447f…`, progress `45c124d0…`, Charter `f4ce7892…`, and App Context `9a46725a…`; QA role `cf2e5472…`; test/device/realtime controls; brief `8be352c…`; proposals `8138cf…`/`5a23e281…`; assignment `5a624497…`; accepted contract `eb0d55bc…`; verification `59464ede…`; In-review barrier `a9f77438…`; full original-base and ten-file implementation diffs; private RED/GREEN, runtime, audit, CP1–CP5, baseline A/B/C, and preserved advisory evidence.

## Important findings

1. **The guard accepts an incomplete and semantically conflicting Accepted-state delta.**  
   [`validate_main_integration.sh:243`](/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/ct04-governance-correction/.codex/skills/roadmap-orchestrator/scripts/validate_main_integration.sh:243)–256 uses optional first-match substitutions. It does not require the acceptance-binding or accepted-tip placeholders, verify `100644` modes, preserve trailing newlines, or transition R01–R10 from `Verified` to `Accepted`. CP1’s disposable fixture confirms authorization succeeds with no binding field and Verified task rows. This conflicts with Roadmap skill lines 42/63 and M0 contract line 66. Require every expected field exactly once, exact modes/bytes, and one unified task-transition rule; test complete real state shapes, missing fields, mode-only changes, and newline changes.

2. **A `PARTIAL` path deletes the snapshot it reports as retained.**  
   At [`validate_main_integration.sh:422`](/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/ct04-governance-correction/.codex/skills/roadmap-orchestrator/scripts/validate_main_integration.sh:422)–425, successful local restoration sets `snapshot_cleanup=yes` before classifying an externally moved remote as `PARTIAL`. The EXIT trap then deletes the reported path. CP2 reproduced this exactly. Cleanup must occur only after proved success or complete restoration with an ordinary rejection; add the moved-remote/local-restored retention regression.

3. **Decision publication cannot truthfully preserve negative decisions and does not authenticate full review/decision content.**  
   [`validate_decision_evidence.sh:65`](/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/ct04-governance-correction/.codex/skills/roadmap-orchestrator/scripts/validate_decision_evidence.sh:65)–114 unconditionally requires `APPROVE/0/0` for every package, blocking required `CORRECT`/`PAUSE_HUMAN` sequences with actual findings. It only format-checks the full-output hash, while lines 195–213 do not validate verdict or binding fields. The passing fixture itself supplies arbitrary hashes and skeletal verdict/binding content at test lines 41–69. Add decision-kind-specific schemas, negative finding preservation, literal full-output/hash verification, and complete verdict/binding validation.

4. **Ignored-state capture is not path-safe and crosses the unresolved secret boundary.**  
   [`validate_main_integration.sh:324`](/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/ct04-governance-correction/.codex/skills/roadmap-orchestrator/scripts/validate_main_integration.sh:324)–374 converts NUL-delimited Git paths into tab/newline records, then uses parsed values in `rm -rf`; valid filenames containing tabs/newlines can be misparsed or target another path. It also copies every ignored regular file—including possible credentials—into temporary storage despite secrets remaining owner-only. Use a binary/NUL-safe representation, refuse unsupported special entries, and establish an authorized sterile-worktree or secret-safe boundary with adversarial path tests.

5. **The revised controls remain mutually contradictory, so scenario B is not executable.**  
   M0 contract lines 99/125 and decisions README line 9 still exclude `reviews/` from publication despite the new lane. Roadmap skill line 140 still requires recording the integration binding, candidate, and base in shared state before integration; that commit moves the milestone tip beyond reviewed `I`, while the guard requires the branch tip equal unchanged `I`. Task-row acceptance also conflicts with “preserve every task row.” Replace—not append around—the superseded clauses and define one executable chronology and field schema.

## Revised-control A/B/C traces

- **A:** Current lawful action remains stop within CT04: the controls are unapproved, M0 paused, and owner has not accepted repaired commits or reactivated M0. Abstractly, after reactivation, exact-C QA/Security/Final review commits can precede acceptance package → Steward verdict → binding without moving C. Publication can then precede the separate Accepted-state `I`; however finding 1 prevents lawful completion of that state transition.
- **B:** I reviews can be recorded, followed by a package binding C, I, B, exact delta/hash, M, and I-review commits; then verdict and binding. Exact controls nevertheless demand a later shared-state commit before guard invocation, moving the branch beyond I. Stop with `PAUSE_HUMAN`; a C review cannot substitute for I.
- **C:** Inspect and preserve B, P, C-old/C-new, and all failure history. Do not push partial P or replay B. Unequal tips plus an incomplete sequence require `PAUSE_HUMAN` without mutation. C-new requires fresh verification/reviews/package/verdict/binding after correction.

## Fresh checks and limits

`HEAD` and branch equal the candidate; worktree status is empty. Parent-to-candidate diff is exactly the ten authorized implementation files; original-base diff additionally contains the four controller task/evidence files. `git diff --check` passed. All four scripts passed fresh `bash -n`; modes are `100755` for scripts and `100644` for documents; candidate hashes match the preserved manifest. Controller logs rehash correctly and report PASS 18/PASS 34. The “33” narrative is stale/non-authoritative; fresh materialized evidence is 34, so no separate finding.

I did not rerun write-requiring disposable-repository suites. Network was prohibited, so live remote state was not independently refreshed. No build, runtime, simulator/emulator, physical-device, audio/MIDI, profiling, latency, or long-run evidence was applicable or inferred.

**User outcome:** immutable exact-SHA review/decision chronology without moving C/I, stale replay, or recovery-evidence loss.  
**Decision scope:** CT04 correction candidate only; no M0 acceptance, control adoption, reactivation, integration, or Steward verdict.  
**Next action:** return all five findings to the same writer for correction round 1, add the bounded regressions above, rerun both complete suites, freeze a new candidate, and obtain fresh QA/Security review.

### security provenance

Output SHA256 `aa245f60278cadffdff64651e5c321696366face19bd798bcf9f39eb268ce3af`; child 01a16834-5a7d-72a1-aa47-30cc726da361; relay 01a16834-0fcb-7732-a416-e0b934b5bf11; actual child sol/high/read-only in exact CT04 cwd. Raw child snapshot SHA256 `21de01bbefbc17369063f5b022e0b43b8a90feaddc20c8d7a77498dbea800a3d`; relay `b9cb469dd4a626680408f00dfb9d4ce634240fd6eacb28ba5d3dca8c4949e862`. Controller is recorder, not reviewer.

REJECT — exact candidate `aabd1b2ba3d26c35343b9c0bdb5fbf17de62ceb5`

Critical: 0 · Important: 5 · Minor: 0  
Spec Compliance: FAIL  
Evidence Honesty: FAIL

Identity: configured Licensing/Security Reviewer, UUID `01a16834-5a7d-72a1-aa47-30cc726da361`, read-only sandbox. No writes, Git mutation, network, agents, device, build, dependency, or permission changes.

Scope binding: implementation parent `a4bf5add0f41bea8b18c2f6b946ebc83362b743b`; original base `bfc5b04aa388e99380c2ab135fe036236175859d`; brief `8be352c653084d47929ffecdf6e3dca0c5cb5c3e`; verification `59464ede90cbb6db21523b74d8372fc90ec58ec4`; In-review barrier `a9f77438c2ad4f69bedee4577418be02d6a46e79`. The parent-to-candidate diff is exactly the authorized ten files. Guard hashes match verification: decision evidence `467dce48…06a2c6`; main integration `05c34929…f6cab`.

## Important findings

1. **A `PARTIAL` path falsely reports retention while deleting the recovery snapshot.**  
   `.codex/skills/roadmap-orchestrator/scripts/validate_main_integration.sh:422-425` sets `snapshot_cleanup=yes` immediately after local restoration, then returns `PARTIAL` when remote `main` moved while claiming the snapshot was retained. The EXIT trap at lines 319-323 deletes it. Controller reproduction `supplemental-round0/cp2-result.json` independently demonstrates exit 75 plus disappearance of the reported path.  
   **Fix:** set cleanup only inside outcomes that are fully restored and classified `REJECTED` or fully successful; add a regression proving the reported directory and original bytes survive this exact remote-moved branch.

2. **Ignored-state capture crosses the credentials boundary and is not pathname-safe.**  
   Main guard lines 324-354 copy every ignored object—including possible credentials—without explicit owner authorization or a sterile-worktree requirement. The tab/newline-delimited manifest cannot represent all Git-valid names or symlink targets; special files are classified but copied before later rejection. Recovery at lines 361-374 performs recursive removal through unvalidated path components. This can copy the wrong path, fail without the promised classification, or make unsafe recovery decisions after anomalous path changes.  
   **Fix:** require a sterile integration worktree or refuse ignored state; otherwise obtain explicit secret-copy authority and use NUL-safe records, reject special files before copying, validate every component, and test tab/newline names, symlinked ancestors, FIFOs/sockets, and directories.

3. **The accepted-state delta neither implements nor securely validates the required transition.**  
   Main guard lines 243-256 use command substitution, which discards trailing newlines, and do not require the four files to remain `100644` regular blobs. They also preserve every ledger task row, while `.codex/skills/roadmap-orchestrator/SKILL.md:42,63` requires `Verified` tasks to become `Accepted`; `M0_CONTRACT.md:66` instead requires every task row unchanged. Thus an integration candidate can pass with unauthorized mode/newline changes and with task state contrary to one binding control.  
   **Fix:** resolve the policy conflict explicitly, then validate exact blob modes, complete bytes including terminal newlines, ledger schema/required fields, and each authorized task transition.

4. **The evidence guard cannot faithfully record negative decisions and does not authenticate full review/result evidence.**  
   `validate_decision_evidence.sh:94,97-114` requires every package review to be `APPROVE` with zero blockers, making a `CORRECT`/`PAUSE_HUMAN` package based on failed or missing evidence unpublishable. Lines 90/94 only validate that output hashes look syntactically valid; fixtures use invented hashes without stored output. Lines 201-213 accept result/binding files by path and sequence without validating status, consumed approval, complete guard output/hash, refs, recovery, or binding linkage.  
   **Fix:** define and validate separate approval and negative-decision schemas; bind the literal full review output or an immutable readable artifact whose computed hash matches; fully validate `SUCCEEDED`/`REJECTED`/`PARTIAL` results and bindings.

5. **The proposed controls remain internally contradictory.**  
   `docs/orchestration/decisions/README.md:9` and `M0_CONTRACT.md:99,125` exclude `reviews/`, while README line 15 and the guard allow it. Orchestrator skill line 140 requires recording the main-integration binding in shared state before integration, but candidate `I` is already frozen/reviewed and its allowed delta contains only acceptance bookkeeping; another shared-state change would create an unreviewed candidate. These conflicts trigger the policy’s own `PAUSE_HUMAN` rule.  
   **Fix:** replace—not append around—the obsolete path/state rules and provide one executable chronology/schema.

Original advisory disposition: QA I1 and Security C1 are CLOSED by collision preflight, `--no-overwrite-ignore`, and pre-push ignored-state comparison. Security I1 and I2 remain OPEN through findings 1–2.

Fresh read-only checks: candidate/parent ancestry, ten-file scope and modes, SHA-256 manifest, `git diff --check`, four `bash -n` checks, clean status, verification and private evidence inspection. Controller evidence reports PASS 18/PASS 34 on macOS 26.6.2 arm64, Git 2.54.0, Bash 3.2; I did not rerun write-requiring fixtures. No dependency, asset, license, platform-permission, or product change exists; `LICENSE_LEDGER.md`, manifests, lockfile, Android debug/profile Internet permission, and iOS configuration are unchanged. No legal or adoption clearance is issued. I did not inspect ignored owner-file contents.

Next action: correct all five Important findings, add the bounded regressions above, freeze a new exact candidate, and obtain fresh affected reviews.

### Supplemental controller reproductions

CP1 and CP2 were reproduced against exact candidate guard SHA25605c34929c2b431fee5224ff461377f03f5f69b9ead1e88d17e60c516fa5f6cab in disposable local fixtures. CP1 authorize returned0 with missing ledger acceptance binding and Verified task rows. CP2 returned75 and reported a retained snapshot that EXIT removed after local restoration and remote movement. Scripts/output/results are immutable private supplemental-round0/. Reproduction exit0 confirms the expected defect, not a guard approval. Main and actual worktree remained untouched by fixtures.
