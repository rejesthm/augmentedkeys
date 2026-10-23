# AugmentedKeys Decision Steward Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a policy-bound Decision Steward that accepts verified milestones, authorizes guarded fast-forward integration into `main`, and activates the next reviewed milestone contract without routine owner approval.

**Architecture:** The read-only Steward evaluates immutable decision packages while the program controller remains the sole shared-state writer and launches read-only and workspace-write roles in separate top-level sessions. The controller records ordered package, verdict, and current-binding commits on the dedicated append-only `governance/decision-evidence` branch. One deterministic guard publishes only that evidence branch, and a separate guard consumes its exact local/remote-equal binding tip before performing one clean fast-forward `main` integration.

**Tech Stack:** Codex project-agent TOML, project-local Codex skills, Markdown governance contracts, Bash/Git guards and fixture tests, Flutter repository verification.

## Global Constraints

- Do not change product code, native hosts, dependencies, packages, assets, audio/MIDI behavior, or UI.
- Preserve every existing G01 failure and rollback artifact.
- Keep the Decision Steward read-only and independent from implementation and final review.
- Never nest mixed-permission roles; use separate top-level read-only and workspace-write sessions.
- Human approval remains mandatory for credentials/secrets, spending/legal commitments, public releases/store submissions, destructive or irreversible external actions, missing evidence, unresolved Critical/Important findings, out-of-scope work, and safety-policy changes.
- Permit only clean, exact-SHA, fast-forward `main` integration; never force, rebase, auto-resolve, delete, sign, release, or deploy.
- Every Steward verdict becomes stale when any bound SHA changes.
- A successor milestone requires a committed, independently reviewed contract with satisfied entry conditions.
- `governance/decision-evidence` is controller-owned, append-only, isolated from product and milestone work, published only through its dedicated guard, and never rebased, force-pushed, rewritten, or deleted.

## File map

| Path | Responsibility |
| --- | --- |
| `.codex/agents/decision-steward.toml` | Read-only decision role and concise invocation contract. |
| `.codex/skills/decision-steward/SKILL.md` | Durable evidence checklist, verdict schema, and hard stops. |
| `docs/orchestration/DECISION_POLICY.md` | Human-readable delegated authority and recovery policy. |
| `AGENTS.md` | Repository-wide authority chain and role-isolated runtime rule. |
| `.codex/agents/conductor.toml` | Root-mediated handoff requirement for mixed permissions. |
| `.codex/skills/roadmap-orchestrator/SKILL.md` | Steward acceptance, integration, and successor activation flow. |
| `.codex/skills/roadmap-orchestrator/scripts/validate_main_integration.sh` | Deterministic main integration guard. |
| `.codex/skills/roadmap-orchestrator/scripts/test_validate_main_integration.sh` | Temporary-repository refusal and success tests. |
| `.codex/skills/roadmap-orchestrator/scripts/validate_decision_evidence.sh` | Deterministic create-once and fast-forward-only evidence-branch publisher. |
| `.codex/skills/roadmap-orchestrator/scripts/test_validate_decision_evidence.sh` | Temporary-repository evidence-publication tests. |
| `docs/orchestration/decisions/README.md` | Canonical decision sequence, immutability, binding, result, and recovery schema. |
| `ROADMAP.md` | Policy-bound continuous milestone progression. |
| `docs/orchestration/milestones/M0_CONTRACT.md` | Superseding M0 authority and canonical Steward evidence paths. |
| `docs/orchestration/milestones/M0_LEDGER.md` | Steward, integration, and successor-contract recovery fields. |
| `docs/orchestration/milestones/m0/evidence/decision-steward-decisions.md` | Append-only milestone-branch status/recovery index for canonical Steward evidence. |
| `docs/orchestration/milestones/m0/evidence/main-integration.md` | Append-only milestone-branch status/recovery index for canonical integration evidence. |
| `STATE.md`, `.loop/progress.md` | Current redesign and G01 recovery state. |

---

### Task 1: Add the Decision Steward role and policy

**Files:**
- Create: `docs/superpowers/specs/2026-09-01-augmentedkeys-decision-steward-design.md` (approved prerequisite governance artifact)
- Create: `docs/superpowers/plans/2026-09-01-augmentedkeys-decision-steward.md` (approved prerequisite governance artifact)
- Create: `.codex/agents/decision-steward.toml`
- Create: `.codex/skills/decision-steward/SKILL.md`
- Create: `docs/orchestration/DECISION_POLICY.md`
- Modify: `.codex/agents/conductor.toml`
- Modify: `AGENTS.md`

**Interfaces:**
- Consumes: exact milestone candidate, completion package, independent review artifacts, target `main` SHA, and successor contract.
- Produces: one of `APPROVE_MILESTONE`, `APPROVE_MAIN_INTEGRATION`, `APPROVE_NEXT_MILESTONE`, `CORRECT`, or `PAUSE_HUMAN`, bound to exact SHAs.

- [ ] **Step 1: Run the RED role check**

```bash
test -f .codex/agents/decision-steward.toml &&
test -f .codex/skills/decision-steward/SKILL.md &&
test "$(find .codex/agents -maxdepth 1 -name '*.toml' | wc -l | tr -d ' ')" -eq 9
```

Expected: non-zero because the Steward files do not exist and only eight agent files exist.

- [ ] **Step 2: Create the read-only agent**

Create `.codex/agents/decision-steward.toml` with `name = "decision_steward"`, `model = "gpt-5.6-sol"`, `model_reasoning_effort = "xhigh"`, `sandbox_mode = "read-only"`, and instructions requiring the project-local Decision Steward skill, exact-SHA evidence, independent reviews, and the five-verdict vocabulary.

- [ ] **Step 3: Create the durable policy skill and policy document**

Write the complete required-reading order, evidence fields, verdict format, hard stops, staleness rule, role independence, and recovery behavior. Include this verdict skeleton:

```text
Verdict: APPROVE_MILESTONE | APPROVE_MAIN_INTEGRATION | APPROVE_NEXT_MILESTONE | CORRECT | PAUSE_HUMAN
Milestone: <exact id>
Contract commit: <40-hex SHA>
Reviewed candidate: <40-hex SHA>
Completion package commit: <40-hex SHA>
Target main commit: <40-hex SHA>
Successor contract commit: <40-hex SHA or Not applicable>
Critical findings: 0
Important findings: 0
Decision: <bounded rationale>
```

- [ ] **Step 4: Update the constitution and Conductor handoff rule**

Record the ninth role, delegated milestone/main/successor authority, human-only boundaries, and this required topology:

```text
program controller -> independent read-only role session
program controller -> independent workspace-write role session
```

The Conductor may select roles but must return a dispatch request to the controller instead of nesting a read-only child beneath its workspace-write session.

- [ ] **Step 5: Run GREEN role checks**

```bash
test "$(find .codex/agents -maxdepth 1 -name '*.toml' | wc -l | tr -d ' ')" -eq 9
rg -n '^name = "decision_steward"$|^model_reasoning_effort = "xhigh"$|^sandbox_mode = "read-only"$' .codex/agents/decision-steward.toml
rg -n 'APPROVE_MILESTONE|APPROVE_MAIN_INTEGRATION|APPROVE_NEXT_MILESTONE|CORRECT|PAUSE_HUMAN' .codex/skills/decision-steward/SKILL.md
rg -n 'credentials|spending|legal|public release|destructive|Critical|Important|out-of-scope' docs/orchestration/DECISION_POLICY.md
git diff --check
```

Expected: all checks exit 0.

### Task 2: Add guarded continuous milestone integration

**Files:**
- Modify: `.codex/skills/roadmap-orchestrator/SKILL.md`
- Create: `.codex/skills/roadmap-orchestrator/scripts/validate_main_integration.sh`
- Create: `.codex/skills/roadmap-orchestrator/scripts/test_validate_main_integration.sh`
- Create: `.codex/skills/roadmap-orchestrator/scripts/validate_decision_evidence.sh`
- Create: `.codex/skills/roadmap-orchestrator/scripts/test_validate_decision_evidence.sh`
- Create: `docs/orchestration/decisions/README.md`
- Modify: `ROADMAP.md`
- Modify: `docs/orchestration/milestones/M0_CONTRACT.md`
- Modify: `docs/orchestration/milestones/M0_LEDGER.md`
- Create: `docs/orchestration/milestones/m0/evidence/decision-steward-decisions.md`
- Create: `docs/orchestration/milestones/m0/evidence/main-integration.md`
- Modify: `STATE.md`
- Modify: `.loop/progress.md`

**Interfaces:**
- Consumes: exact accepted milestone tip, recorded `main` base, and the exact local/remote-equal current binding tip of `governance/decision-evidence`, whose ordered package and Steward-verdict commits bind all required review evidence and any optional successor contract.
- Produces: guarded local and remote `main` equality at the accepted milestone SHA plus committed integration evidence; or a refusal with no mutation.

- [ ] **Step 1: Write and run guard RED tests**

Create tests in temporary Git repositories covering: valid create-once and later fast-forward evidence publication; valid clean main authorization/integration/verification; wrong branch; dirty tree; stale candidate; superseded or unconsumed decision; co-committed decision artifacts; moved remote `main`; non-fast-forward history; wrong substituted governance base; merge history; disallowed, deleted, or rewritten immutable evidence history; a historically invalid evidence mode corrected at the candidate tip; missing/invalid Steward provenance and calendar-invalid timestamps; missing, invalid, non-regular, or unreadable acceptance packages and completion/review artifacts; wrong binding; direct-push mode; hostile local merge and push hooks; confirmed push rejection with complete restoration including candidate-only files and distinct prior `ORIG_HEAD`; mutating merge failure classified `PARTIAL` unless exact restoration including symbolic-versus-detached `HEAD` state is proved; unverifiable evidence-push rejection; externally moved or ambiguous post-push recovery; full relevant-ref/pseudoref/worktree mutation snapshots; and ambiguous remotes. Run:

```bash
bash .codex/skills/roadmap-orchestrator/scripts/test_validate_main_integration.sh
bash .codex/skills/roadmap-orchestrator/scripts/test_validate_decision_evidence.sh
```

Expected before the guard exists: non-zero with the guard path missing.

- [ ] **Step 2: Implement the minimal deterministic guard**

The main guard accepts only:

```text
authorize|integrate|verify <milestone-branch> <accepted-tip> <recorded-main-base> <evidence-binding-commit>
```

It validates exact 40-hex commits, local/remote evidence-branch equality at the supplied binding tip, exact single-path ordered main-integration and milestone-acceptance package/verdict/binding sequences, final-tip acceptance-binding currentness, exact Steward provenance with calendar-valid UTC timestamps, canonical regular-blob contract/completion/review artifacts in accepted history, `APPROVE_MAIN_INTEGRATION`, clean checked-out `main`, one unambiguous `origin`, local and remote `main` equality with the recorded base, and fast-forward ancestry. `integrate` disables local hooks, performs `git merge --ff-only`, pushes only `refs/heads/main:refs/heads/main`, and proves remote/evidence equality. Merge/push failure refuses only after exact pre-state restoration; unproved, ambiguous, or externally moved results return non-replayable `PARTIAL` for controller evidence and `PAUSE_HUMAN`.

The evidence guard accepts only:

```text
authorize|push|verify <candidate-tip> <recorded-governance-base>
```

It operates only on clean checked-out `governance/decision-evidence`, proves an immutable single-path direct-child governance-base anchor, enforces complete exact single-path package→verdict→binding sequences (or result→binding), rejects merge history and noncanonical/deleted/rewritten/co-committed evidence, creates that exact remote ref once from the recorded base, then permits only linear fast-forward updates with its explicit refspec and proves local/remote equality. Failed pushes refuse only with proved no remote mutation and otherwise return `PARTIAL`. It never mutates or widens the milestone-branch guard.

- [ ] **Step 3: Update the orchestration state machine and contracts**

Permit `Ready for decision` to Steward-approved `Accepted`, then guarded integration, then successor activation. Preserve the two-commit evidence barrier and require fresh review after any SHA changes. Keep the current M0 pause until the redesigned setup and role-isolation runtime evidence pass.

- [ ] **Step 4: Add canonical append-only evidence files and recovery fields**

Define the canonical evidence schema and recovery protocol. Record explicit `Not created` / `Not yet decided` / `Not yet integrated` values for M0. Add ledger fields for the evidence branch/worktree/base/tips, acceptance and integration package/verdict/binding commits, accepted tip, original `main` base, integration result/recovery, integrated local/remote main SHA, successor contract and package/verdict/binding commits, and successor activation result. Do not erase OD-001 through OD-003 or G01 evidence.

- [ ] **Step 5: Run guard GREEN and governance consistency checks**

```bash
bash .codex/skills/roadmap-orchestrator/scripts/test_validate_main_integration.sh
bash .codex/skills/roadmap-orchestrator/scripts/test_validate_decision_evidence.sh
rg -n 'decision_steward|Decision Steward' AGENTS.md ROADMAP.md STATE.md .loop/progress.md docs/orchestration/milestones/M0_CONTRACT.md docs/orchestration/milestones/M0_LEDGER.md
rg -n 'APPROVE_MAIN_INTEGRATION|PAUSE_HUMAN' .codex/skills/roadmap-orchestrator/SKILL.md .codex/skills/decision-steward/SKILL.md
git diff --check
```

Expected: all checks exit 0 and the M0 state remains paused pending validated reactivation.

### Task 3: Verify independence, repository health, and review

**Files:**
- Modify after evidence: `STATE.md`
- Modify after evidence: `.loop/progress.md`

**Interfaces:**
- Consumes: Tasks 1–2 candidate commit and exact runtime session evidence.
- Produces: a reviewed governance candidate with no Critical or Important finding; it does not activate M0 or integrate `main` by itself.

- [ ] **Step 1: Validate schema and actual role discovery**

Run strict configuration loading and trusted project-root discovery for `decision_steward`. Record tool version, project root, resolved role, and actual sandbox from runtime context; TOML inspection alone is insufficient.

- [ ] **Step 2: Prove role-isolated topology**

Launch one top-level read-only role session and one separate top-level workspace-write Conductor session. Confirm the Steward is read-only and the Conductor is workspace-write. Run a negative mixed-nesting probe and require refusal before task work.

- [ ] **Step 3: Run full verification**

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
bash .codex/skills/roadmap-orchestrator/scripts/test_validate_main_integration.sh
git diff --check
git status --short
```

Expected: all commands pass; only approved governance, agent, skill, evidence, and state files differ.

- [ ] **Step 4: Obtain independent reviews**

Require QA/Performance evidence-honesty review, Licensing/Security review of the authority and publication boundary, and fresh Final Code Review of the complete diff. Any Critical or Important finding returns to the writer, reruns affected checks, and receives fresh review.

- [ ] **Step 5: Commit and publish only the governance branch**

```bash
git add AGENTS.md ROADMAP.md STATE.md .loop/progress.md .codex docs
git commit -m "feat(governance): add decision steward"
git push -u origin governance/decision-steward-m0
```

Expected: the exact governance branch is published; `main`, `milestone/m0-research`, and the preserved R01 task branch remain unchanged. M0 reactivation occurs only after the reviewed governance commit is integrated through the approved recovery procedure.
