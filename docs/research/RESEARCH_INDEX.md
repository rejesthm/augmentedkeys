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
- **Status:** `Verified` — correction round 3
- **Findings:** Candidate `09266fdc17e137db44495d85c6b42cf296efb89c` passed QA/Performance, Licensing/Security, and Final Code Review with zero Critical/Important through finalized verification `1c3d4618b1cbf2c583f2c4950800edaab58ee185`; integrated at milestone tip `63081f5f50b03c9337f9f10032a94373f214aaa0`. One nonblocking provenance-label Minor is deferred for milestone triage. Documentary result only; not an architecture or dependency adoption.

## 2. UAPMD objective evaluation

- **Question:** Does UAPMD satisfy the documented AugmentedKeys requirements and constraints when assessed against alternatives with reproducible evidence?
- **Why it matters:** UAPMD is an undecided candidate and must not be adopted or rejected from assumption, familiarity, or name recognition.
- **Required source quality:** The original UAPMD repository and documentation, maintainer material, relevant specifications, issue history where material, and reproducible spikes or measurements against predeclared criteria.
- **Expected output:** `UAPMD_EVALUATION.md`.
- **Decision it unlocks:** Evidence-backed inclusion or exclusion of UAPMD in a later architecture ADR.
- **Status:** `Verified` — correction round 1
- **Findings:** Corrected candidate `8b39e5572f481af21d5fba598c1abf0fe8dc5dec` passed fresh QA/Performance, Licensing/Security and Final Code Review with zero findings through finalized verification `c7952ea12d19a6c42abc3d19425a694448256b76`; integrated at milestone tip `f7e2670ee7c9d12d47467e13139420a347b8cc29`. Disposition remains `retain for later spike comparison`; no adoption, build, benchmark, device, architecture or licensing-clearance authority exists.

## 3. iOS/iPadOS audio and AUv3 hosting

- **Question:** What current iOS and iPadOS audio APIs, lifecycle constraints, routing behavior, and AUv3-hosting requirements are relevant to the planned product?
- **Why it matters:** Apple audio and plugin behavior must be understood independently before native boundaries, hosting scope, or user promises are chosen.
- **Required source quality:** Current Apple developer documentation and API references, applicable specifications, official sample code, original project documentation, and reproducible iPhone/iPad experiments where required.
- **Expected output:** `IOS_AUDIO_RESEARCH.md` and `PLUGIN_HOSTING_RESEARCH.md`.
- **Decision it unlocks:** Approval to scope Apple-specific audio and AUv3 technical spikes and later ADRs.
- **Status:** `Verified` — correction round 1; candidate `b3eb533c41993c7b236d47a8d347329e9dca6fae`, finalized verification `1e0a5ff7562b71c6306a4459e154f49e5cc41986`; required reviews approve with zero findings
- **Findings:** No findings recorded

## 4. Android audio, Oboe/AAudio, AAP/AAP-JUCE

- **Question:** What current Android audio APIs, device constraints, Oboe/AAudio behavior, and AAP/AAP-JUCE hosting considerations are relevant to the planned product?
- **Why it matters:** Android performance and plugin options vary by platform and device and must not be inferred from the Apple ecosystem.
- **Required source quality:** Current Android and Android NDK documentation, Oboe/AAudio documentation and original repositories, AAP/AAP-JUCE maintainer material, relevant specifications, and reproducible physical-device experiments where required.
- **Expected output:** `ANDROID_AUDIO_RESEARCH.md` and `PLUGIN_HOSTING_RESEARCH.md`.
- **Decision it unlocks:** Approval to scope Android-specific audio and plugin-hosting spikes and later ADRs.
- **Status:** `Verified` — correction1; candidate `26b6c2702d21704481969dc99fa51ee504aa9bb7`; finalized verification `d9bd4a428e1d1c44f87cf965dde5b61887d7a1cc`; all required reviews approve0/0/0
- **Findings:** All3 original Important findings closed in independent round1 reviews; rejection retained at `5385671e0a9a3cabb09b3755483480196b188a96`.

## 5. MIDI 1.0/2.0, Core MIDI, Android MIDI, MPE

- **Question:** Which MIDI standards and platform APIs are required for the intended controller, routing, timing, mapping, and expressive-performance workflows?
- **Why it matters:** The supported MIDI surface determines protocol boundaries, test hardware needs, timing evidence, and future compatibility commitments.
- **Required source quality:** Published MIDI specifications available for legitimate use, current Apple Core MIDI and Android MIDI documentation, official platform samples, original library documentation, and reproducible controller/device tests where required.
- **Expected output:** `MIDI_RESEARCH.md`.
- **Decision it unlocks:** An evidence-backed MIDI scope, compatibility matrix, spike plan, and later architecture ADR.
- **Status:** `Verified` — correction1; candidate `00952ed4bd563446ef450ce375cb5ec89edb43de`; finalized verification `96a82baa49cb561084585115cde4e4658498307b`; required approvals0/0/1, both Important findings closed; shared index-count wording Minor carried
- **Findings:** No findings recorded

## 6. Built-in sampler/synth engine and SF2/SFZ options

- **Question:** Which built-in sampler or synthesizer approaches and sound formats could meet product, performance, portability, authoring, and licensing requirements?
- **Why it matters:** Engine and format choices affect real-time safety, memory, content creation, redistribution, platform parity, and long-term maintenance.
- **Required source quality:** Format specifications, official or original engine documentation and repositories, maintainer material, license evidence, reproducible spikes, and measured physical-device behavior where required.
- **Expected output:** `SOUND_ENGINE_RESEARCH.md`.
- **Decision it unlocks:** Approval to compare narrowly scoped engine/format candidates in spikes and a later ADR.
- **Status:** `Verified` — candidate `446493053c94e5be336036bab212ca85ba61cc9c`; finalized verification `ef499f19643bcee06060198a98a8cfa40e442841`; allrequiredreviews0/0/0 and all3 original Important closed
- **Findings:** No findings recorded

## 7. Licensing risks for engines, plugins, samples, fonts, icons, and DSP

- **Question:** What commercial-use, redistribution, attribution, source-disclosure, patent, trademark, and content-rights obligations apply to every proposed dependency or asset?
- **Why it matters:** Public availability does not grant product adoption or redistribution rights, and licensing constraints can invalidate an otherwise suitable technical choice.
- **Required source quality:** Authoritative license texts, rights-holder or publisher terms, official distribution terms, source provenance, version-specific notices, and qualified legal review when required.
- **Expected output:** `LICENSE_LEDGER.md`.
- **Decision it unlocks:** Item-by-item approval or rejection before adoption or distribution; technical suitability remains a separate decision.
- **Status:** `Verified` — candidate `a1805e40b765d19f10e248186e147c1c27de68f2`; finalized verification `609231c5ab3e9c82717f269398158e6cb3ec7a21`; allrequiredreviews0/0/0,three original Important closed
- **Findings:** Existing foundation and candidate rights evidence documented; current package/engine identities, composite licenses and optional branches reconciled. All items remain Not approved; no content, legal or distribution clearance.

## 8. Sunday Keys public capability/workflow analysis

- **Question:** Which publicly documented user problems, capabilities, and live-performance workflows should inform original AugmentedKeys product requirements without copying protected expression, assets, content, or design?
- **Why it matters:** Understanding public workflow patterns can improve requirements while the project maintains original implementation and presentation.
- **Required source quality:** Public first-party product documentation, published support material, public demonstrations, and clearly attributed observations separated from inference.
- **Expected output:** `SUNDAY_KEYS_ANALYSIS.md`.
- **Decision it unlocks:** Review of original workflow requirements and explicit differentiation opportunities.
- **Status:** `Verified` — candidate `d1979355eabf5214f9b3a79eda4323e55164248a`; finalized verification `4a8a696e3ad116dc69309fc4451d931ecbb9203f`; allrequiredreviews0/0/0,no findings
- **Findings:** Public first-party Sunday Keys workflows and edition/date/tier distinctions documented; original mobile questions and future scenarios remain unadopted/unperformed. No runtime, content, legal or distribution clearance.

## 9. MainStage public capability/workflow analysis

- **Question:** Which publicly documented user problems, capabilities, and live-performance workflows should inform original AugmentedKeys requirements without treating a desktop application as the mobile architecture model?
- **Why it matters:** MainStage is relevant workflow context, but its desktop constraints and protected product expression must not be imported into the mobile design.
- **Required source quality:** Public first-party Apple documentation, published user guides, public demonstrations, and clearly attributed observations separated from inference.
- **Expected output:** `MAINSTAGE_ANALYSIS.md`.
- **Decision it unlocks:** Review of original mobile workflow requirements and deliberate non-goals.
- **Status:** `Verified` — candidate `266f263849c737adb1a9759b39967042cd69212b`; finalized verification `324c06e5302a9009753a884cedbe650a83bb5b13`; allrequiredreviews0/0/0,no findings
- **Findings:** Public first-party MainStage workflows and edition/date/compatibility/privacy distinctions documented; original mobile questions and future scenarios remain unadopted/unperformed. No runtime, content, legal or distribution clearance.

## 10. Competing mobile live-performance workflows

- **Question:** What recurring needs, limitations, and interaction patterns are publicly documented across current mobile live-keyboard and performance products?
- **Why it matters:** A broader comparison can expose user needs and platform expectations without equating competitors or reproducing their designs.
- **Required source quality:** Current first-party product and support documentation, public store information, documented platform requirements, and attributed observations; third-party reports may identify questions but cannot alone establish technical facts.
- **Expected output:** `COMPETITOR_MATRIX.md`.
- **Decision it unlocks:** Prioritization of original product workflows, differentiation questions, and research gaps.
- **Status:** `In review` — candidate `9cb5eebc3abe7ae4e54d95498863cd7363ddb051`; evidence `f75da999ee8bbec4d20cbcf43a2b618adab86f0f`; independent QA/Performance and Licensing/Security re-review shared I1 and all criteria, then Final; no integration before Verified
- **Findings:** No findings recorded
