# R05 independent specialist reviews — round0

Exact candidate `5b7390d91fd074479d1144d76233320999f3161e`, base `22afbe4c38e2f46a758cce7e744b4819e116c6ad`. Both configured independent read-only roles APPROVE with0Critical/0Important/0Minor. No candidate or source changed during reviews. Final review is still required; task remains In review. Controller records literal output below; reviewers neither authored this artifact nor mutated shared state.

## QA/Performance runtime and literal output

Relay `01a16834-0b4b-7190-82b9-4c5f6ee12ba7` → configured child `01a16834-4222-7e43-b1f5-6a3c439280eb`. Actual saved session metadata and final turn contexts show independent read-only execution at the R05 task cwd; child gpt-5.6-sol/high. Completed CLI relay; literal review is the child completion output.

- `qa-round0-runtime.json` SHA256 `2c23e8e2b911698c9a7369a6a1b41e639b56ba2dfd76c21f405edb869dd623bb`.
- `qa-round0.final.txt` SHA256 `bf444895a70cf2cd35470ea165deae1f2c4634b565a78f43a54c496d04301c63`.
- `qa-round0-relay.jsonl` SHA256 `54037dca8656287eb2d4d7a94f1c5a1848f51b3b89c945fc3e73165ae1b0bef6`.
- `qa-round0-child.jsonl` SHA256 `36b42bbbeb877cb7a5c1368c816953e2b01c1a693edfc1f786222492307a01d4`.

# R05 QA/Performance Documentary Review

**Role:** configured QA/Performance Verifier, read-only  
**Child UUID:** `01a16834-4222-7e43-b1f5-6a3c439280eb`  
**Candidate:** `5b7390d91fd074479d1144d76233320999f3161e`  
**Task base:** `22afbe4c38e2f46a758cce7e744b4819e116c6ad`  
**Result:** **APPROVE**  
**Counts:** Critical 0 · Important 0 · Minor 0  
This is not a Decision Steward verdict.

## Scope and governing evidence

I read `APP_SPEC.md`, `ARCHITECTURE.md`, `ROADMAP.md`, task-worktree `STATE.md`, and `.loop/progress.md` in the required order, followed by `CONTINUATION_CHARTER.md`, `APP_CONTEXT.md`, `TEST_STRATEGY.md`, `DEVICE_MATRIX.md`, `REALTIME_SAFETY.md`, the complete candidate diff/report, and applicable control evidence. Task-worktree documents were evaluated at candidate HEAD; the historical Eligible snapshot was superseded by current shared state `216698a726b4ae0f3f24a693deaa97b4963588a6`. Governing versions were brief `f30f02a5c76d5f08e07c45627b023819d811e289`, assignment `c433ba2b0260afd8319e10e56f151ce8980239ba`, verification `bad1afb95bb59135ebf92bc5314e7112c979cfc2`, source reconciliation `77852bf9640ce1885be146de65b091b8b9ce5f72`, runtime `0fb4ae5ebc702965ddbd8e59a8618622a66e64d0`, OD006 `c9c0f9349bd69c7bc7b975b78000361f7a8956d4`, and accepted contract `eb0d55bc7e10b219996fdb7ab69a546b1e350e3a`.

**User outcome:** establish a source-bounded foundation for reliable future wired MIDI 1 note, velocity, sustain, connection/recovery, and Stop Sound behavior without claiming implementation or adopting architecture.

**Decision scope:** documentary sufficiency of the exact candidate only. No finding applies.

## Criterion coverage

1. Standards identity, versions, layer separation, access limits, and unseen normative-text gaps are explicit at `docs/research/MIDI_RESEARCH.md:18-72`.
2. MIDI 1 messages, zero-velocity distinctions, channels/groups, sustain, CC120/121/123, MPE versus MIDI 2 per-note behavior, conversion loss, and unresolved policies are covered at `:74-132`.
3. Apple API availability, discovery, callbacks, timestamps, lifecycle, transports, privacy, and unknowns are bounded at `:134-186`.
4. Android API 23/33/35 surfaces, enumeration/open/port direction, transports, OS-versus-target-SDK permission conditions, lifecycle, and unsupported parity claims are covered at `:188-247`.
5. Clock domains, ordering, render prohibition, bounded-queue questions, malformed/SysEx handling, and note/sustain/recovery obligations appear at `:249-299`.
6. Licensing/access, privacy, identity, Property Exchange, BLE/network trust, and no-clearance limits are explicit at `:20-52` and `:288-298`.
7. Source matrices, classifications, retained failures, provenance, capability unknowns, and missing evidence are traceable at `:18-53`, `:300-335`, and `:436-480`.
8. The proposed, explicitly unapproved spike provides physical/receipt/render/output boundaries, clock calibration, integrity/overflow/silence/recovery/overload/soak methods, configuration capture, and raw artifacts at `:336-434`.

## Fresh command evidence

At `2026-10-23T11:15:18Z`, macOS 26.6.2 build 25G83, arm64, Git 2.54.0:

- `git rev-parse HEAD` returned the exact candidate; `git merge-base --is-ancestor <base> <candidate>` exited 0.
- `git status --short --branch` returned only `## task/m0-r05-midi`.
- `git diff --check <base>..<candidate>` exited 0.
- `git diff --name-status` returned only `A docs/research/MIDI_RESEARCH.md`; no protected path matched.
- Committed report: 484 lines, 40,368 bytes, SHA-256 `8af0a9e4fc1f7668d3f2bba767e5841a1c7d56dbd0e3475a1b921c66b08b9a84`.
- No conflict marker or TODO/TBD/FIXME/WIP marker was found.
- The three indexes contain M01–M70: 68 successful bodies and two retained failures. All 68 body byte counts and SHA-256 values independently matched; zero mismatches.
- Index hashes matched the catalog: `172158…c1d84`, `eb68a5…cafe`, and `1eb6b2…6c9a`.
- M44 independently matched SHA-256 `fc9b04…9b05`, 124 pages, UMP/MIDI 2 v1.1.2; M46 matched `260215…15e`, 20 pages, historical MPE v1.0.
- Direct body checks supported the material zero-velocity/conversion, protocol-negotiation deprecation, MPE zone/released-note, Android framing/clock/permission, and Apple callback/timestamp/capacity claims.

Read-only sandbox-denied temporary Xcode cache writes produced warnings during Apple Git/Python startup, but the cited commands completed successfully and made no workspace change.

## Evidence limits

This review supplies documentary/static evidence only. No unit/widget test, static analyzer, build, simulator/emulator compilation, runtime execution, physical-device MIDI/audio test, profiling, latency measurement, or long-run run occurred. Current detailed MIDI 1, MIDI-CI v1.2.1, and MPE v1.1 normative texts remain unavailable and are correctly excluded from conformance claims. No product, device, timing, permission, reliability, legal-clearance, or adoption conclusion follows.

**Next action:** record this literal exact-SHA QA approval; if the independent Licensing/Security review also approves this unchanged candidate, proceed to fresh independent Final review.

## Licensing/Security runtime and literal output

Relay `01a16834-0fcb-7732-a416-e0b934b5bf11` → configured child `01a16834-5a7d-72a1-aa47-30cc726da361`. Actual saved session metadata and final turn contexts show independent read-only execution at the R05 task cwd; child gpt-5.6-sol/high. Completed CLI relay; literal review is the child completion output.

- `security-round0-runtime.json` SHA256 `ad5eb0ea71f54f02aed00d09b20c7807061daa0aa9f68d45f0a2b089b436dd7f`.
- `security-round0.final.txt` SHA256 `39d484b71f852bcc1dd688346f2f6e335544b788fef4a82a0790dce6e0ef00be`.
- `security-round0-relay.jsonl` SHA256 `56945c3b7e0bb236a48334f189dc35cca15023d44307fe4603b3a05802abcd1c`.
- `security-round0-child.jsonl` SHA256 `94b7b8dd4781dd8a5f76d06d662b9d087f35453ccfcd2943f26ce32a59a3bcf6`.

APPROVE — exact candidate `5b7390d91fd074479d1144d76233320999f3161e`

Critical: 0  
Important: 0  
Minor: 0

Reviewer identity: configured Licensing/Security Reviewer, UUID `01a16834-5a7d-72a1-aa47-30cc726da361`, `gpt-5.6-sol` / high reasoning / effective read-only sandbox. No files, Git state, permissions, dependencies, hardware, accounts, or external systems were changed.

Decision scope: independent licensing/security review of the complete one-file R05 documentary diff from base `22afbe4c38e2f46a758cce7e744b4819e116c6ad`. This is not a Steward verdict, legal clearance, standards-conformance decision, dependency approval, permission selection, or implementation authorization.

Findings: none.

Verified facts and risk assessment:

- [MIDI_RESEARCH.md:18](/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-r05-midi/docs/research/MIDI_RESEARCH.md:18) identifies source editions, access limits, retained failures, and the distinction between listing/overview material and inspected normative bodies. M44 is the official MMA/AMEI M2-104-UM v1.1.2 document, draft 2023-10-27 and published 2023-11-10. M46 is expressly historical MPE v1.0 dated 2018-03-12; current MPE v1.1, detailed MIDI 1, and MIDI-CI v1.2.1 texts remain identified as unseen.
- Lines 41–52 accurately preserve the all-rights-reserved status and prohibit inferring reproduction, redistribution, incorporation, certification, or legal clearance from public retrieval. MIDI.org terms likewise reserve ungranted content rights. The local documentary copies and derivatives are not adopted product content and must not be published or incorporated without later rights review.
- Lines 54–72 correctly separate transport, MIDI 1 byte streams, UMP, MIDI 2, MIDI-CI, and MPE; no API or packet format is treated as device capability or transport parity.
- Lines 176–186 accurately state Apple Bluetooth and local-network usage-description conditions using the captured source wording, preserve deployment-target distinctions, and select no entitlement, plist key, background mode, or minimum OS.
- [MIDI_RESEARCH.md:232](/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-r05-midi/docs/research/MIDI_RESEARCH.md:232) correctly distinguishes Android target-31+ Bluetooth declarations/runtime Nearby Devices grants, location derivation and `neverForLocation`, target-30-or-lower legacy Bluetooth/location rules, and Android 10/11 background-discovery location requirements. Wired USB consent and manifest behavior remain explicit evidence gaps rather than unsupported permission guarantees.
- Lines 211–247 treat Android IDs, names, manufacturer/product/version, serial, USB/Bluetooth objects, ports, asynchronous open, services, and reconnect state as nonpersistent or unresolved inputs. Virtual service security/manifest policy remains unselected.
- [MIDI_RESEARCH.md:288](/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-r05-midi/docs/research/MIDI_RESEARCH.md:288) appropriately treats MIDI/SysEx/Property Exchange, endpoint metadata, serials, profile claims, and network peers as untrusted or potentially identifying. It requires bounded parsing, explicit size/timeout/overflow policy, and later minimization/redaction rather than adopting a logging or retention policy.
- The proposed spike excludes Property Exchange, feature SysEx, BLE, networking, virtual MIDI, MIDI-CI, MIDI 2, MPE, and hosting. Its retained-artifact proposal is conditioned on later approved minimization, redaction, procedure, and budgets.
- No package, SDK, code, standards text, asset, manifest declaration, platform permission, network feature, or dependency is adopted. `LICENSE_LEDGER.md` remains unchanged; R07 retains exact dependency/SDK/standards-content/commercial-use/redistribution review.

Fresh checks:

- `git rev-parse HEAD` → exact candidate.
- Worktree status is clean.
- Base-to-candidate scope is exactly `A docs/research/MIDI_RESEARCH.md`; no protected path changed.
- `git diff --check` returned no findings.
- Candidate report is 484 lines / 40,368 bytes; SHA-256 matches `8af0a9e4fc1f7668d3f2bba767e5841a1c7d56dbd0e3475a1b921c66b08b9a84`.
- Candidate descends from the declared base.
- Changed-text secret/credential-pattern scan found no actual credential or secret.
- All three source indexes match their recorded hashes. Independent rehash: 70 records, 68 successful bodies, two preserved failures, zero hash/byte/access-metadata mismatches.
- M44 and M46 original PDF hashes match the catalog. I independently inspected their rendered covers/version material and relevant extracted sections.
- Claim checks covered M14 Android permissions; M44 UMP edition, copyright, groups, negotiation, velocity, translation and reset semantics; M46 historical MPE identity/zone/release behavior; M54/M55 Apple privacy keys; Android device metadata/callback lifetime/framing; Property Exchange/SysEx sources; and MIDI.org terms.

Versions read: required app documents at candidate `5b7390d…`; accepted contract `eb0d55bc7e10b219996fdb7ab69a546b1e350e3a`; OD-006 `c9c0f9349bd69c7bc7b975b78000361f7a8956d4`; brief `f30f02a5c76d5f08e07c45627b023819d811e289`; assignment `c433ba2b0260afd8319e10e56f151ce8980239ba`; runtime `0fb4ae5ebc702965ddbd8e59a8618622a66e64d0`; source reconciliation `77852bf9640ce1885be146de65b091b8b9ce5f72`; verification `bad1afb95bb59135ebf92bc5314e7112c979cfc2`; In-review state `216698a726b4ae0f3f24a693deaa97b4963588a6`.

Known gaps: no current detailed MIDI 1, MIDI-CI v1.2.1, or MPE v1.1 normative inspection; no legal clearance; no selected permissions, manifest, minimum OS, target SDK, controller, transport, parser, queue, retention policy, or device evidence. These are explicitly recorded and do not block this non-adopting documentary report.

One next action: controller should record this literal exact-candidate approval, then proceed to fresh Final Code Review only after the independent QA/Performance result is available and no Critical or Important finding remains.

