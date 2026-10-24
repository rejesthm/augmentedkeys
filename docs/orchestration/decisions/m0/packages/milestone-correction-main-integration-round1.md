# M0 main-integration correction — round 1 rejection

Milestone: M0
Decision kind: milestone-correction
Decision disposition: NEGATIVE
Resulting milestone state: Paused for owner decision
Contract commit: 552413198ae9ed488f70b3d3db656469292b89a4
Contract path: docs/orchestration/milestones/M0_CONTRACT.md
Reviewed candidate: 4c8a005767ed48e745b2b11b74ad77b63394f83a
Target main commit: b1b0c1edd5e42d3ea791f665c22954834e962d05
Blocking evidence status: REJECTED
Blocking review commit: 68f2dca34b02b4c2997f189ca14f4838ff5cd55a
Blocking review path: docs/orchestration/decisions/m0/reviews/main-integration-round1-final.md
Blocking reviewer role: final_code_reviewer
QA review commit: 14664941480430508eeb981c5cb8927a66e195ae
QA review path: docs/orchestration/decisions/m0/reviews/main-integration-round1-qa.md
Licensing review commit: a3114c6f69de96935ae8494cf2f18f2235a05866
Licensing review path: docs/orchestration/decisions/m0/reviews/main-integration-round1-security.md
Final review commit: 68f2dca34b02b4c2997f189ca14f4838ff5cd55a
Final review path: docs/orchestration/decisions/m0/reviews/main-integration-round1-final.md
Critical findings: 0
Important findings: 1
Limitations: Candidate I1 is an administrative five-file descendant of accepted completion candidate C. QA and Final independently rejected I1 because current-state prose still contradicts the accepted status and cites a superseded binding; Licensing/Security approved its narrower remit while explicitly observing the stale prose. No main integration was attempted. The app remains the Flutter shell; this package proves no audio, MIDI, patch, device, latency, performance, release, or successor capability.
Recovery: Preserve accepted completion candidate C, published rejected I1, all three review artifacts, the unchanged main base, and the append-only evidence history. Correction requires the owner-authorized bounded governance/control change, an append-only replacement I2, fresh affected verification and independent reviews, renewed milestone acceptance under the corrected controls, and a fresh main-integration decision. Do not replay I1 or the prior acceptance binding as main-integration authority.

## Blocking finding

The five administrative files contain present-tense statements that still describe the pre-acceptance state, including the superseded human-gate binding, Verified rather than Accepted task states, and already-completed publication/review instructions. The accepted main-integration guard requires those contradictory bytes to remain unchanged. Correcting I1 alone would therefore violate the reviewed guard. The smallest safe recovery changes the governance controls and deterministic transform, preserves I1 as the rejected attempt, and produces a separately reviewed replacement I2.

The independent correction audit classifies this as a bounded governance safety-control defect rather than product scope or architecture. Because the recovery changes safety controls and one Important finding remains unresolved, only the owner can authorize the exact correction design and allowlist. This negative package requests a Decision Steward verdict at that boundary; it grants no correction, integration, product, or release authority.
