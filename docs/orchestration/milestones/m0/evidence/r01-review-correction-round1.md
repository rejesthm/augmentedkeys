# R01 fresh specialist review — corrected candidate round 1

Status: `REJECTED; correction round 2 required`

- Corrected candidate reviewed: `ef640cf0644b41de99302441ff539d7293443b57`.
- Correction Researcher evidence: `efd3a124137e98c10072ff21af582cca2ac908c9`.
- Verification evidence: `dca892713555f229887fd8522e47e3533fe1d10c`.
- In-review state: `e2deead1a5bc36de3a9aadd97d4e9314ffab1964`.
- Final Code Review: not dispatched because Important findings remain.

## Runtime provenance

- QA relay `01a06028-4a8c-7941-8fdb-b1cc8c10143c`: read-only; rollout SHA-256 `5aa558d0dfdd4df9b6df75b9e20da7bb3d02075ce8b439be4854033bf6c594c3` (129 lines).
- Configured QA/Performance Verifier `/root/r01_qa_review_round1_fresh`, child `01a06028-bfa5-7c33-86cb-6f8ba50f0a8f`, nickname `James`, `gpt-5.6-sol` / `high` / `read-only`; rollout SHA-256 `e19dd60ce4c629e626b4a9a69b8e13d0d486423d1ce8321c6f4aba7a9958a05d` (238 lines; 34 read-only `exec` calls).
- Security relay `01a06028-4a8c-7873-a56e-2d148d630ab8`: read-only; rollout SHA-256 `c6dd079ae91a3338dce45aa78d50355eceabbb7411e8a222b30e547ebba0660f` (91 lines).
- Configured Licensing/Security Reviewer `/root/r01_security_review_round1_fresh`, child `01a06028-9cdf-7903-a839-21c6483e7e75`, nickname `Epicurus`, `gpt-5.6-sol` / `high` / `read-only`; rollout SHA-256 `a7ab5e8fe0a706e801c40cb4ea2a161eb54b8a62311e7baa3e58246100cd9ddf` (160 lines; 20 read-only `exec` calls).
- The full literal replies remain byte-authoritative in the hashed saved rollouts. No reviewer had write authority. QA recorded one denied filesystem operation; repository state remained unchanged.

## Verdicts and combined findings

- QA/Performance: REJECT — Critical 0, Important 5, Minor 0; acceptance criteria 1, 4 and 5 failed; evidence honesty failed.
- Licensing/Security: REJECT — Critical 0, Important 2, Minor 0; all ten research criteria substantively passed, but provenance/state control failed; evidence honesty failed.
- The two Security findings duplicate QA finding 1 and add the stale state-mirror finding; all are preserved below.

### Blocking findings

1. The recorded prior review SHA `60be283266f50c64799973f64fa920ab57b190a6` is invalid. The actual commit is `60be2835790681859c8b38a8762ea20ac0f3c72c`. Preserve history, append the correction mapping, update current references, regenerate dependent evidence and re-review.
2. Verification names only `Roadmap Orchestrator (/root)`, not a named reviewer. Record the named configured reviewer, role, exact commit, timestamp, configuration, raw artifact and hash without representing the owner as having performed work they did not perform.
3. `MOBILE_AUDIO_ARCHITECTURE.md` weakens the binding callback prohibition by saying only blocking I/O and unbounded/avoidable allocation. Restore the constitution exactly: no blocking work, I/O, UI work, parsing, allocation, arbitrary lock waiting or potentially blocking logging in the callback or anything it invokes; any narrower rule requires later evidence-backed approval.
4. Preserve the complete corrected-candidate implementer report or an immutable final rollout locator with exact hash, line count, effective configuration and report ordinal.
5. QA's restricted network could not reopen GitHub. Retain bounded, content-hashed primary-source metadata and excerpts from a network-enabled read-only controller pass so the cited object identities and lines can be independently audited without source execution or adoption.
6. `.loop/progress.md` still points to rejected candidate `c94abe…`, preliminary evidence `6364a0…`, and stale next actions. Synchronize it through the correction/state barrier.

## Substantive passes retained

- All four repository claims have structurally valid full SHA-pinned URLs.
- CPAL historical/current identity and Oboe post-access-date conflict are corrected.
- The future measurement privacy/security gate contains every requested control.
- Verification timestamp, exact commands/refs, tool configuration, raw artifact path/hash, output hashes/lines and 16-occurrence/14-unique URL counts pass.
- Candidate scope is exactly the two contracted reports. No dependency, lockfile, code, platform configuration, asset, permission, entitlement or network configuration changed.
- No secrets or credential-bearing links were found. R07 remains unpreempted; no adoption or legal conclusion was made.
- No build, device, audio/MIDI, benchmark, latency, thermal, soak, performance or hardware work occurred.
