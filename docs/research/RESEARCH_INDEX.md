# M0 Research Index

This index is the prioritized queue for evidence needed before AugmentedKeys selects or implements product-core architecture. An entry records a question and an expected decision artifact; it is not evidence that the research has started or that any approach is suitable.

## Status vocabulary

- `Queued`: contracted backlog item with no active investigation.
- `Eligible`: dependencies, inputs, path authority, and evidence requirements are satisfied, and a bounded brief is committed.
- `In progress`: investigation is active and its assigned writer, branch, and brief are recorded.
- `In review`: candidate evidence and its verification artifact are committed for assigned review.
- `Verified`: required checks and independent review passed with no Critical or Important finding.
- `Blocked`: investigation cannot continue until a named blocker or owner decision is resolved.
- `Deferred`: the task remains in the contract but cannot proceed in the current sequence for a recorded reason.
- `Accepted`: the product owner accepted the verified outcome during milestone review.

Changing a status requires a dated transition in `docs/orchestration/milestones/M0_LEDGER.md` with task identifier, responsible role, source commit, evidence location, and reason. `Accepted` is owner-only and applies only to the reviewed question; it does not by itself approve implementation, dependency adoption, architecture adoption, or distribution.

## 1. Mobile low-latency audio architecture

- **Question:** Which mobile audio architecture candidates and platform boundaries should be evaluated for reliable, low-latency operation on supported Android and Apple phones and tablets?
- **Why it matters:** The answer will shape future technical spikes, native boundaries, measurement methods, and the feasibility of later audio work.
- **Required source quality:** Current official Apple, Android, Flutter, and candidate-project documentation; relevant platform specifications; original repositories and maintainer material; reproducible technical spikes and physical-device measurements where required.
- **Expected output:** `MOBILE_AUDIO_ARCHITECTURE.md` and `LOW_LATENCY_RESEARCH.md`.
- **Decision it unlocks:** Approval to define and benchmark a narrow audio-architecture spike; it does not select an engine by itself.
- **Status:** `In progress` — correction round 1
- **Findings:** Round-1 specialist review requires immutable revisions for Oboe/JUCE/CPAL/miniaudio, corrected CPAL identity, a future-measurement privacy/security gate, and reproducible canonical verification. Prior candidate `c94abe038f9c7bad224246bbc2a5a8bf2b61974f` remains rejected and unintegrated.

## 2. UAPMD objective evaluation

- **Question:** Does UAPMD satisfy the documented AugmentedKeys requirements and constraints when assessed against alternatives with reproducible evidence?
- **Why it matters:** UAPMD is an undecided candidate and must not be adopted or rejected from assumption, familiarity, or name recognition.
- **Required source quality:** The original UAPMD repository and documentation, maintainer material, relevant specifications, issue history where material, and reproducible spikes or measurements against predeclared criteria.
- **Expected output:** `UAPMD_EVALUATION.md`.
- **Decision it unlocks:** Evidence-backed inclusion or exclusion of UAPMD in a later architecture ADR.
- **Status:** `Queued`
- **Findings:** No findings recorded

## 3. iOS/iPadOS audio and AUv3 hosting

- **Question:** What current iOS and iPadOS audio APIs, lifecycle constraints, routing behavior, and AUv3-hosting requirements are relevant to the planned product?
- **Why it matters:** Apple audio and plugin behavior must be understood independently before native boundaries, hosting scope, or user promises are chosen.
- **Required source quality:** Current Apple developer documentation and API references, applicable specifications, official sample code, original project documentation, and reproducible iPhone/iPad experiments where required.
- **Expected output:** `IOS_AUDIO_RESEARCH.md` and `PLUGIN_HOSTING_RESEARCH.md`.
- **Decision it unlocks:** Approval to scope Apple-specific audio and AUv3 technical spikes and later ADRs.
- **Status:** `Queued`
- **Findings:** No findings recorded

## 4. Android audio, Oboe/AAudio, AAP/AAP-JUCE

- **Question:** What current Android audio APIs, device constraints, Oboe/AAudio behavior, and AAP/AAP-JUCE hosting considerations are relevant to the planned product?
- **Why it matters:** Android performance and plugin options vary by platform and device and must not be inferred from the Apple ecosystem.
- **Required source quality:** Current Android and Android NDK documentation, Oboe/AAudio documentation and original repositories, AAP/AAP-JUCE maintainer material, relevant specifications, and reproducible physical-device experiments where required.
- **Expected output:** `ANDROID_AUDIO_RESEARCH.md` and `PLUGIN_HOSTING_RESEARCH.md`.
- **Decision it unlocks:** Approval to scope Android-specific audio and plugin-hosting spikes and later ADRs.
- **Status:** `Queued`
- **Findings:** No findings recorded

## 5. MIDI 1.0/2.0, Core MIDI, Android MIDI, MPE

- **Question:** Which MIDI standards and platform APIs are required for the intended controller, routing, timing, mapping, and expressive-performance workflows?
- **Why it matters:** The supported MIDI surface determines protocol boundaries, test hardware needs, timing evidence, and future compatibility commitments.
- **Required source quality:** Published MIDI specifications available for legitimate use, current Apple Core MIDI and Android MIDI documentation, official platform samples, original library documentation, and reproducible controller/device tests where required.
- **Expected output:** `MIDI_RESEARCH.md`.
- **Decision it unlocks:** An evidence-backed MIDI scope, compatibility matrix, spike plan, and later architecture ADR.
- **Status:** `Queued`
- **Findings:** No findings recorded

## 6. Built-in sampler/synth engine and SF2/SFZ options

- **Question:** Which built-in sampler or synthesizer approaches and sound formats could meet product, performance, portability, authoring, and licensing requirements?
- **Why it matters:** Engine and format choices affect real-time safety, memory, content creation, redistribution, platform parity, and long-term maintenance.
- **Required source quality:** Format specifications, official or original engine documentation and repositories, maintainer material, license evidence, reproducible spikes, and measured physical-device behavior where required.
- **Expected output:** `SOUND_ENGINE_RESEARCH.md`.
- **Decision it unlocks:** Approval to compare narrowly scoped engine/format candidates in spikes and a later ADR.
- **Status:** `Queued`
- **Findings:** No findings recorded

## 7. Licensing risks for engines, plugins, samples, fonts, icons, and DSP

- **Question:** What commercial-use, redistribution, attribution, source-disclosure, patent, trademark, and content-rights obligations apply to every proposed dependency or asset?
- **Why it matters:** Public availability does not grant product adoption or redistribution rights, and licensing constraints can invalidate an otherwise suitable technical choice.
- **Required source quality:** Authoritative license texts, rights-holder or publisher terms, official distribution terms, source provenance, version-specific notices, and qualified legal review when required.
- **Expected output:** `LICENSE_LEDGER.md`.
- **Decision it unlocks:** Item-by-item approval or rejection before adoption or distribution; technical suitability remains a separate decision.
- **Status:** `Queued`
- **Findings:** No findings recorded

## 8. Sunday Keys public capability/workflow analysis

- **Question:** Which publicly documented user problems, capabilities, and live-performance workflows should inform original AugmentedKeys product requirements without copying protected expression, assets, content, or design?
- **Why it matters:** Understanding public workflow patterns can improve requirements while the project maintains original implementation and presentation.
- **Required source quality:** Public first-party product documentation, published support material, public demonstrations, and clearly attributed observations separated from inference.
- **Expected output:** `SUNDAY_KEYS_ANALYSIS.md`.
- **Decision it unlocks:** Review of original workflow requirements and explicit differentiation opportunities.
- **Status:** `Queued`
- **Findings:** No findings recorded

## 9. MainStage public capability/workflow analysis

- **Question:** Which publicly documented user problems, capabilities, and live-performance workflows should inform original AugmentedKeys requirements without treating a desktop application as the mobile architecture model?
- **Why it matters:** MainStage is relevant workflow context, but its desktop constraints and protected product expression must not be imported into the mobile design.
- **Required source quality:** Public first-party Apple documentation, published user guides, public demonstrations, and clearly attributed observations separated from inference.
- **Expected output:** `MAINSTAGE_ANALYSIS.md`.
- **Decision it unlocks:** Review of original mobile workflow requirements and deliberate non-goals.
- **Status:** `Queued`
- **Findings:** No findings recorded

## 10. Competing mobile live-performance workflows

- **Question:** What recurring needs, limitations, and interaction patterns are publicly documented across current mobile live-keyboard and performance products?
- **Why it matters:** A broader comparison can expose user needs and platform expectations without equating competitors or reproducing their designs.
- **Required source quality:** Current first-party product and support documentation, public store information, documented platform requirements, and attributed observations; third-party reports may identify questions but cannot alone establish technical facts.
- **Expected output:** `COMPETITOR_MATRIX.md`.
- **Decision it unlocks:** Prioritization of original product workflows, differentiation questions, and research gaps.
- **Status:** `Queued`
- **Findings:** No findings recorded
