# R06 independent specialist reviews — round0

Exact candidate `8a7145825db8588ee4a4dd8cf4e87e584f6a54da` rejected: QA0Critical/1Important/0Minor; Licensing/Security0Critical/2Important/0Minor. Three distinct blocking findings. No Final review or integration authorized. Same-writer correction round1 requires T02 then separate In-review→In-progress barrier. Original candidate, sources and literal reports preserved. Below is the full review text with Markdown trailing spaces and final blank lines normalized only; exact original replies and their hashes remain in the immutable local evidence.

## qa actual runtime and literal review

Independent read-only relay `01a16834-0b4b-7190-82b9-4c5f6ee12ba7` → configured child `01a16834-4222-7e43-b1f5-6a3c439280eb`, actual child gpt-5.6-sol/high/read-only, exact R06 cwd verified from saved runtime. Both CLI sessions completed. Controller alone records evidence.

- `qa-review-runtime.json` SHA256 `f848aa5b587236d35b4fb9d0ca08e1203a8d58b156bb7435e40335d17707d140`.
- `qa-review-relay.jsonl` SHA256 `94d21160bf341c17bf858de41b5777d22fca5f9384401cd46b64eabe4a5bc803`.
- `qa-review-child.jsonl` SHA256 `6fe28b8f43579796e9d3338ba6337ba2c97b5d2feecedffcdcc6edc73f38bc4d`.
- `qa-review.final.txt` SHA256 `4c5e5a92958d9ecbceeba0d6058892477c9dfa59a9b391ec933f2d453538485e`.

R06 QA/PERFORMANCE DOCUMENTARY REVIEW — **REJECT**

**Role/runtime:** Independent read-only QA/Performance Verifier
**UUID:** `01a16834-4222-7e43-b1f5-6a3c439280eb`
**Candidate:** `8a7145825db8588ee4a4dd8cf4e87e584f6a54da`
**Base:** `131fff075db2b89cd35abf714b3590e0c8b22029`
**Counts:** Critical 0 / Important 1 / Minor 0
This is not a Steward verdict.

## Important finding

**I1 — `docs/research/SOUND_ENGINE_RESEARCH.md:211`: load-latency and recovery boundaries are not equalized across synchronous and streaming engines.**

“Cold and warm parse/load time” does not define cold/warm cache/reset preconditions or the completion endpoint. An sfizz load call can return while preload/background streaming and worker activity remain relevant, while another candidate may materialize its assets synchronously. API-return timing would therefore not be comparable and could support a misleading ranking. “Worker lifetime” and generic “recovery markers” do not resolve when the declared fixture is render-ready.

Before approval, define separate comparable intervals:

- load-call start → API return;
- load-call start → declared render-ready state, including required preload/stream readiness and background-work disposition;
- failed load/unload/restart trigger → declared safe state and first conforming rendered/audible marker;
- cold/warm cache, process, engine, and fixture reset conditions.

Correlate file-I/O and worker events to those markers and retain incomplete/non-recovering cases. R01’s future manifest requirement does not replace this R06-specific semantic boundary.

## Criterion and source review

1. **Bounded identities:** Pass. Three differentiated candidates are exactly pinned; FluidSynth and sfizz release commits are separated from HEAD, and TinySoundFont’s header version is not misrepresented as a release.
2. **Formats:** Pass. SF2 structure and mixed S42 edition/provenance are accurately bounded. SFZ community authority, dialect limitations, zones, loops, envelopes, filters, modulation, and content separation are honest.
3. **Embedding:** Pass. Caller-render APIs, channels, precision, event ordering, toolchain surfaces, optional drivers, and absent mobile proof are distinguished.
4. **Real-time/memory/lifecycle:** Pass. FluidSynth dynamic allocation/mutex behavior, TinySoundFont preallocation/race caveat, and sfizz control/render/FilePool hazards remain unresolved rather than promoted to safety claims.
5. **Product fit:** Pass. Notes, sustain, panic distinctions, layers, controls, persistence, switching and tails remain host/product questions.
6. **Licensing/security handoff:** Pass for QA scope; exact root-license identities, configurable dependency surface, content separation and parser/path/resource risks are recorded without clearance.
7. **Traceability:** Pass. Claim URLs, pins, access date, authority limits and hashes are present.
8. **Experiment:** **Open because of I1.** Workloads, callback/deadline evidence, clocks, calibration, repetitions, 30-minute provisional soak and artifacts are otherwise documented; CPU/memory time-series controls are inherited from the exact R01 Gates 1–8 reference.

Actual bodies inspected included S17/S18 identities; S23–S28 FluidSynth APIs/settings/source; S32–S34 sfizz control, render, streaming and recovery paths; S37 TinySoundFont; S42 extracted specification text; S43 and S46–S50 SFZ references. All 50 indexed bodies matched byte counts and SHA-256 values; IDs were unique and all statuses HTTP 200.

## Fresh command evidence

At `2026-10-23T12:15:33Z`:

- `git rev-parse HEAD` → exact candidate.
- `git cat-file -t <candidate>` → `commit`.
- `git merge-base --is-ancestor <base> <candidate>` → pass.
- `git status --short` → empty.
- `git diff --name-status <base>..<candidate>` → only `A docs/research/SOUND_ENGINE_RESEARCH.md`.
- `git diff --check <base>..<candidate>` → exit 0, no output.
- Candidate report → 310 lines, 33,676 bytes, SHA-256 `9da0f48bb96e09789a3c6f407657cb7068625c311db0a8de3bd300f082aa9a3b`.
- Four index hashes matched the catalog; body verification → `total=50 mismatches=0`.

Git emitted read-only macOS/Xcode cache warnings but each Git operation completed successfully.

## Context and limitations

Read AGENTS.md; APP_SPEC, ARCHITECTURE, ROADMAP, STATE, and `.loop/progress.md` in order; continuation charter/context; R06 brief `b5a85d…`, assignment `48c929…`, verification `0d2002…`, sources `ce9d12…`, runtime `757883…`, current In-review state `9d7051…`, OD-006 and accepted contract `eb0d55…`; TEST_STRATEGY, DEVICE_MATRIX, REALTIME_SAFETY, LICENSE_LEDGER, complete report/diff, and exact R01/R04/R05 method sections.

User outcome remains a future offline original piano/pad/warm-synth worship workflow with six patches and up to four layers. Decision scope was documentary QA only. No unit/widget tests, Flutter/build, simulator/emulator, runtime, device, audio/MIDI, profiling, latency, continuity, or long-run execution occurred; none can be inferred. No engine, content, architecture, dependency, budget, or legal conclusion is approved.

**Next action:** Return the report to the same writer for the narrow I1 protocol correction, then perform fresh affected review on the new exact candidate.

## security actual runtime and literal review

Independent read-only relay `01a16834-0fcb-7732-a416-e0b934b5bf11` → configured child `01a16834-5a7d-72a1-aa47-30cc726da361`, actual child gpt-5.6-sol/high/read-only, exact R06 cwd verified from saved runtime. Both CLI sessions completed. Controller alone records evidence.

- `security-review-runtime.json` SHA256 `3a08ab2d45bfaaab116648c3b4b3c5408b4e1fb652d3b5805e199d7a92bfd7a6`.
- `security-review-relay.jsonl` SHA256 `3980152717b2893f713ef0a5e6395548584ede0d03638798f5781755dc78aad0`.
- `security-review-child.jsonl` SHA256 `50575d2f492b47294e195f222fe96d7412ddd6b94ecc43dc67cc123930066cd0`.
- `security-review.final.txt` SHA256 `9e14f7727095ff36ac87966738e3901cde039ff6034d5de144721de6829330d8`.

REJECT — exact candidate `8a7145825db8588ee4a4dd8cf4e87e584f6a54da`

Counts: Critical 0 / Important 2 / Minor 0

Reviewer: configured Licensing/Security Reviewer, UUID `01a16834-5a7d-72a1-aa47-30cc726da361`, `gpt-5.6-sol`/high, effective read-only sandbox. This is an independent specialist review, not a Steward verdict or legal clearance.

## Important findings

1. **The licensing handoff omits material, already-captured build-dependent obligations.**
   [SOUND_ENGINE_RESEARCH.md:147](/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-r06-sound-engine/docs/research/SOUND_ENGINE_RESEARCH.md:147), [line 153](/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-r06-sound-engine/docs/research/SOUND_ENGINE_RESEARCH.md:153), [line 154](/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-r06-sound-engine/docs/research/SOUND_ENGINE_RESEARCH.md:154), and [line 304](/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-r06-sound-engine/docs/research/SOUND_ENGINE_RESEARCH.md:304) reduce the evidence to FluidSynth’s LGPL root, sfizz’s BSD root, component names, and future questions. The pinned bodies already establish distinctions R06 criterion 6 requires recording:

   - S26 says FluidSynth replacement/relinking and modified-source availability matter; it separately warns that VST3/GPLv3-enabled binaries may become GPLv3 and describes unresolved iOS/App Store compatibility. S26 is explicitly lay guidance, so these are risk statements, not legal conclusions.
   - S30 identifies sfizz’s default `dr_libs` path as MIT-0 versus optional `libsndfile` LGPL-2.1, plus Apache-2.0, MIT, BSD-2/3, WTFPL-2, STK-4.3/permissive-LGPL, Boost, and other subproject license families.

   Merely deferring the “exact selected dependency graph” does not preserve these known branch-dependent limits and can leave R07 with the misleading shorthand “sfizz = BSD-2-Clause.” Amend the handoff to record these source-supported distinctions, root-versus-binary-graph limits, notice/source/relinking questions, and exact unresolved R07/legal review boundaries.

2. **TinySoundFont’s notice and example-content boundary is incomplete.**
   [SOUND_ENGINE_RESEARCH.md:155](/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-r06-sound-engine/docs/research/SOUND_ENGINE_RESEARCH.md:155), [line 158](/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-r06-sound-engine/docs/research/SOUND_ENGINE_RESEARCH.md:158), and [line 304](/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-r06-sound-engine/docs/research/SOUND_ENGINE_RESEARCH.md:304) do not identify two captured provenance questions:

   - S35’s root notice is copyright 2017–2023, while pinned `tsf.h` S37 carries 2017–2025 plus the SFZero attribution.
   - S36 says the examples include a sample SoundFont, and S16 identifies `examples/florestan-subset.sf2` and `examples/venture.mid`. Their presence in the repository and the code’s MIT license do not establish their content rights or redistribution terms.

   Record the differing notices and explicitly exclude those example assets from any code-license inference or future fixture/content adoption pending authoritative provenance and rights evidence.

## Coverage and verified facts

Criteria 1–5, 7, and 8 are adequately covered: exact release/commit identities, historical/community authority limits, format and content separation, embedding/build surfaces, conservative callback/lifetime treatment, product-fit non-adoption, traceable sources, and concrete unperformed experiment methods. Parser/path/resource/worker/lifetime risks are appropriately presented as risks rather than vulnerability findings. No adopted permission, security, architecture, engine, content, or distribution policy is claimed.

Fresh checks confirmed:

- HEAD equals candidate; base is an ancestor.
- Diff is exactly one new 310-line file; `git diff --check` passes.
- Worktree is clean; no protected path, manifest, dependency, permission, asset, or license-ledger change.
- Report SHA-256 is `9da0f48bb96e09789a3c6f407657cb7068625c311db0a8de3bd300f082aa9a3b`.
- Four source indexes and all 50 indexed bodies matched recorded hashes; 50 successes, zero failures.
- Actual bodies inspected included S20/S26, S29/S30, S35–S37, S42, S16 metadata, build surfaces S22/S31/S44/S45, and relevant parser/render sources.
- No credential/secret pattern was found in the candidate diff.

Read governing app documents in required order from the candidate task tree, then continuation/app context, brief `b5a85d…`, assignment `48c929b…`, contract `eb0d55b…`, OD006 `c9c0f93…`, verification `0d20028…`, source catalog `ce9d12a…`, runtime `757883f…`, current In-review state `9d7051f…`, research controls, manifests, platform permission files, and `LICENSE_LEDGER.md`.

Limitations: documentary review only; no complete source/callback audit, legal opinion, build, package resolution, device run, performance evidence, or asset inspection/adoption.

**Next action:** issue one bounded correction to the licensing/security handoff covering both findings, then perform fresh affected verification and Licensing/Security review on the new exact candidate.
