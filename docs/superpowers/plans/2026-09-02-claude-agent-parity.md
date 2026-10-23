# Claude Code Agent Parity Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add nine native, project-scoped Claude Code agents that preserve AugmentedKeys' Codex role behavior, safety boundaries, gated workflow, and independent review structure.

**Architecture:** Store one Markdown/YAML definition per role in `.claude/agents/`, with Claude-native model aliases and explicit tool/permission boundaries. A root `CLAUDE.md` coordinates task sequencing, while a deterministic shell validator checks roster and safety invariants without changing repository state.

**Tech Stack:** Claude Code project subagents, Markdown, YAML frontmatter, POSIX shell, Git worktrees.

## Global Constraints

- Implement on a new isolated worktree and branch `governance/claude-agent-parity`, based on committed tip `a88cc3a062388095e473dec805abfa5cc042cb7f` unless repository inspection proves a later accepted governance base is required.
- Preserve the user's existing modifications to `.codex/skills/roadmap-orchestrator/scripts/test_validate_main_integration.sh` and `.codex/skills/roadmap-orchestrator/scripts/validate_main_integration.sh`.
- Do not modify `.codex/agents/`, application code, Flutter/native platform code, dependencies, M0 task state, milestone acceptance, or `main`.
- Claude identities must be recorded as Claude identities and must never impersonate historical Codex agents.
- Read-only roles may inspect and report but may not edit, fix, commit, push, adopt dependencies, or perform external mutations.
- Writer roles require an exact committed brief, isolated worktree, one assigned file set, explicit stop conditions, fresh verification, and independent review.
- Research/setup does not prove low latency, smoothness, compatibility, licensing clearance, or production readiness.
- Never use `bypassPermissions`; parent permission modes can override weaker child restrictions.
- All commits must stage only files listed by the current task.

---

## File map

- `.claude/agents/conductor.md` — one-task coordinator and synthesis writer.
- `.claude/agents/decision-steward.md` — exact-SHA, read-only governance decision reviewer.
- `.claude/agents/researcher.md` — primary-source technical researcher.
- `.claude/agents/flutter-builder.md` — bounded Flutter implementer.
- `.claude/agents/apple-specialist.md` — Apple platform specialist.
- `.claude/agents/android-specialist.md` — Android platform specialist.
- `.claude/agents/qa-performance-verifier.md` — independent QA/performance verifier.
- `.claude/agents/licensing-security-reviewer.md` — independent licensing/security reviewer.
- `.claude/agents/final-code-reviewer.md` — independent final reviewer.
- `CLAUDE.md` — top-level Claude coordination and repository-authority bridge.
- `scripts/validate_claude_agents.sh` — deterministic roster/frontmatter/safety validator.
- `docs/guides/CLAUDE_CODE_CONTINUATION.md` — launch and continuation runbook.

---

### Task 1: Isolated worktree and failing structural validator

**Files:**
- Create: `scripts/validate_claude_agents.sh`

**Interfaces:**
- Consumes: repository root and expected agent filenames.
- Produces: exit `0` plus `CLAUDE_AGENT_VALIDATION=PASS`, or nonzero with a precise failed invariant.

- [ ] **Step 1: Protect the dirty checkout and create isolation**

Run read-only checks from the current checkout:

```bash
git status --short --branch
git rev-parse HEAD
git worktree list --porcelain
```

Confirm the two existing modified guard scripts remain unstaged. Create a separate worktree using the `using-git-worktrees` skill, with branch `governance/claude-agent-parity` based on `a88cc3a062388095e473dec805abfa5cc042cb7f`.

- [ ] **Step 2: Write the validator before agent files exist**

Create an executable POSIX shell script with this fixed roster:

```text
android-specialist
apple-specialist
conductor
decision-steward
final-code-reviewer
flutter-builder
licensing-security-reviewer
qa-performance-verifier
researcher
```

The script must:

1. require exactly nine `.claude/agents/*.md` files;
2. require first line `---` and a closing frontmatter delimiter;
3. extract exactly one `name`, `description`, `model`, and `permissionMode` field per file;
4. reject duplicate or unexpected names;
5. require `model: opus` for conductor, decision-steward, and final-code-reviewer;
6. require `model: sonnet` for the other six roles;
7. require `effort: max` for Conductor, Decision Steward, and Final Code Reviewer and `effort: high` for the other six;
8. require `permissionMode: plan` plus `disallowedTools: Write, Edit, NotebookEdit` for the five read-only roles;
9. reject `bypassPermissions` anywhere;
10. require the phrases `committed repository state`, `exact SHA`, and `owner-only` in `CLAUDE.md`;
11. print one diagnostic per failure and the success marker only when all checks pass.

- [ ] **Step 3: Verify the structural test fails for the intended reason**

Run:

```bash
chmod +x scripts/validate_claude_agents.sh
scripts/validate_claude_agents.sh
```

Expected: nonzero with a message that `.claude/agents` or the nine agent files are missing. It must not fail with a shell syntax error.

- [ ] **Step 4: Commit the red validator**

```bash
git add scripts/validate_claude_agents.sh
git commit -m "test(governance): define Claude agent invariants"
```

---

### Task 2: Read-only Claude agents

**Files:**
- Create: `.claude/agents/decision-steward.md`
- Create: `.claude/agents/researcher.md`
- Create: `.claude/agents/qa-performance-verifier.md`
- Create: `.claude/agents/licensing-security-reviewer.md`
- Create: `.claude/agents/final-code-reviewer.md`

**Interfaces:**
- Consumes: exact task/decision commits, `AGENTS.md`, milestone contract, brief, verification, and applicable project controls.
- Produces: evidence-backed read-only reports with actual Claude identity, verdict, findings, commands, and limitations.

- [ ] **Step 1: Create shared read-only frontmatter shape**

Every file begins with valid YAML using its exact role name and description:

```yaml
---
name: researcher
description: Use for read-only primary-source technical research supporting a bounded AugmentedKeys task; never use as a writer or decision authority.
model: sonnet
effort: high
permissionMode: plan
tools: Read, Grep, Glob, Bash, WebFetch, WebSearch
disallowedTools: Write, Edit, NotebookEdit
maxTurns: 80
---
```

Use `model: opus`, `effort: max`, and `maxTurns: 100` for `decision-steward` and `final-code-reviewer`. Use `model: sonnet`, `effort: high`, and `maxTurns: 80` for the other three. Keep `permissionMode: plan` and the same disallowed mutation tools for all five.

- [ ] **Step 2: Write role-specific system prompts**

Each body must state that it is a new Claude identity, must read committed repository state, and must not impersonate Codex history. Add these exact role contracts:

- `researcher`: prefer primary/official sources; record URL, access time, immutable revision when available, raw-evidence limits, facts, inferences, disagreements, and missing evidence; no repository writes.
- `qa-performance-verifier`: independently rerun applicable checks; distinguish static analysis, tests, builds, runtime, simulator/emulator, physical device, audio/MIDI, profiling, latency, thermal and soak evidence; return `APPROVE`, `REJECT`, or `ESCALATE_HUMAN`; never fix findings.
- `licensing-security-reviewer`: inspect version/license identity, direct/transitive components, assets, permissions, privacy, credentials, redistribution, commercial-use and supply-chain boundaries; no legal conclusions; return ordered Critical/Important/Minor findings.
- `final-code-reviewer`: run only after prerequisite reviews; inspect exact candidate, full diff, brief, verification and prior findings; report correctness, regression, safety, maintainability, test quality, cross-file consistency, spec compliance and evidence honesty; never implement fixes.
- `decision-steward`: bind every verdict to exact SHA values; verify all prerequisite evidence; never manufacture owner approval; return `APPROVE`, `REJECT`, or `ESCALATE_OWNER`; never merge, push or execute the decision it reviews.

All five prompts must forbid file edits, commits, pushes, dependency/asset adoption, credentials, destructive actions and unsupported performance claims.

- [ ] **Step 3: Run partial validation**

```bash
scripts/validate_claude_agents.sh
```

Expected: still nonzero, now reporting only missing writer roles and missing `CLAUDE.md`, not malformed read-only definitions.

- [ ] **Step 4: Validate YAML using Claude Code**

```bash
claude plugin validate .claude/agents
```

Expected: exit `0` with no YAML parse error. If the installed Claude Code is older than the documented validator command, record the version and use `claude --debug --agent researcher -p "Return only your role name and mutation boundary."` as the discovery check.

- [ ] **Step 5: Commit read-only roles**

```bash
git add .claude/agents/decision-steward.md .claude/agents/researcher.md .claude/agents/qa-performance-verifier.md .claude/agents/licensing-security-reviewer.md .claude/agents/final-code-reviewer.md
git commit -m "feat(governance): add Claude review agents"
```

---

### Task 3: Writer and coordinator Claude agents

**Files:**
- Create: `.claude/agents/conductor.md`
- Create: `.claude/agents/flutter-builder.md`
- Create: `.claude/agents/apple-specialist.md`
- Create: `.claude/agents/android-specialist.md`

**Interfaces:**
- Consumes: a committed bounded brief, exact starting SHA, assigned branch/worktree, allowed files, stop conditions, and reviewer findings for corrections.
- Produces: changes only within assigned paths plus an implementer report; no self-approval.

- [ ] **Step 1: Create writer frontmatter**

Use this Conductor shape:

```yaml
---
name: conductor
description: Use to coordinate exactly one owner- or roadmap-authorized AugmentedKeys task, select the minimum specialists, enforce gates, and synthesize only assigned outputs.
model: opus
effort: max
permissionMode: default
tools: Read, Grep, Glob, Bash, Edit, Write, WebFetch, WebSearch, Agent
disallowedTools: NotebookEdit
maxTurns: 120
---
```

Use `model: sonnet`, `effort: high`, `permissionMode: default`, the same tool boundaries, and `maxTurns: 100` for Flutter Builder, Apple Specialist, and Android Specialist.

Do not set `isolation: worktree` in these reusable definitions. Claude Code creates that automatic worktree from the repository's default branch, which can differ from the exact milestone/task start SHA. The controller must create the governed task worktree first and invoke the writer from that directory; every writer must verify its branch, `HEAD`, common Git directory, and assigned path set before editing.

- [ ] **Step 2: Write the Conductor contract**

Require the Conductor to verify committed repository state, accept only one bounded task, select no more than the minimum specialists, maintain one writer per sensitive file set, keep reviewers independent, stop at owner-only gates, and return exact candidate/evidence identities. It may not mark its own work Verified, approve licensing, claim device performance, merge, push, or decide architecture unless a committed contract explicitly grants that narrow action.

- [ ] **Step 3: Write implementation-specialist contracts**

- `flutter-builder`: test-first Flutter changes only; run formatting, analysis, tests and requested builds; never claim runtime/device/audio performance from compilation.
- `apple-specialist`: iOS/iPadOS lifecycle, Core Audio, AUv3 and Core MIDI within assigned scope; separate simulator compilation from physical-device evidence; stop for signing, entitlements, hardware, distribution and architecture decisions.
- `android-specialist`: Android lifecycle, AAudio/Oboe, AAP and Android MIDI within assigned scope; distinguish emulator/build evidence from device latency; stop for permissions, SDK/dependency adoption, hardware and architecture decisions.

All three must inspect the exact brief and allowed files, refuse scope expansion, preserve user changes, run fresh checks, and return candidate SHA, commands, warnings and limitations. They may not review or approve their own work.

- [ ] **Step 4: Run partial validation**

```bash
scripts/validate_claude_agents.sh
```

Expected: exactly nine valid agents are recognized; failure remains only because `CLAUDE.md` has not yet been created.

- [ ] **Step 5: Commit writer roles**

```bash
git add .claude/agents/conductor.md .claude/agents/flutter-builder.md .claude/agents/apple-specialist.md .claude/agents/android-specialist.md
git commit -m "feat(governance): add Claude delivery agents"
```

---

### Task 4: Claude coordination bridge and continuation guide

**Files:**
- Create: `CLAUDE.md`
- Create: `docs/guides/CLAUDE_CODE_CONTINUATION.md`

**Interfaces:**
- Consumes: all nine agent definitions and existing repository governance.
- Produces: deterministic main-session behavior and copyable launch instructions.

- [ ] **Step 1: Write `CLAUDE.md` authority order**

Define this order explicitly:

```text
owner instruction
→ committed milestone contract and owner decisions
→ STATE.md / milestone ledger / exact task brief
→ AGENTS.md and applicable controls
→ continuation prompt
→ chat memory
```

Require fresh `git status`, branch/worktree, exact-SHA and remote checks before mutation. List all nine Claude roles and say descriptions guide automatic selection, while an explicit agent mention is authoritative for that bounded dispatch.

Require read-only review sessions to avoid parent `acceptEdits` and `bypassPermissions` modes because Claude Code documents that those parent modes can override a subagent's stricter frontmatter permission mode.

- [ ] **Step 2: Write the gated task sequence**

Record the exact states `Queued → Eligible → In progress → In review → Verified`, the separate evidence/state commit barrier, same-writer correction loop, specialist-before-final-review ordering, exact-candidate integration, guarded milestone publication, and owner-only milestone acceptance. State that active-agent UI entries exist only while agents are actually running.

- [ ] **Step 3: Write the continuation guide**

Include these launch forms:

```bash
cd /Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-research
claude
```

```bash
claude --agent conductor
```

Include a copyable continuation prompt requiring repository preflight, current-state discovery, use of the Conductor, minimal specialists, truthful Claude provenance, continuous M0 progression through R10, and stopping at the completed M0 owner gate. Do not hard-code a future-changing R03 status or remote tip; direct Claude to resolve them from committed state.

- [ ] **Step 4: Run the full validator**

```bash
scripts/validate_claude_agents.sh
```

Expected:

```text
CLAUDE_AGENT_VALIDATION=PASS
```

- [ ] **Step 5: Commit coordination documentation**

```bash
git add CLAUDE.md docs/guides/CLAUDE_CODE_CONTINUATION.md
git commit -m "docs(governance): add Claude coordination guide"
```

---

### Task 5: Runtime discovery and safety pressure tests

**Files:**
- Modify: `scripts/validate_claude_agents.sh`
- Create: `docs/testing/CLAUDE_AGENT_SETUP_VERIFICATION.md`

**Interfaces:**
- Consumes: complete Claude agent setup.
- Produces: reproducible structural/runtime evidence without product edits.

- [ ] **Step 1: Run structural and native validation**

```bash
scripts/validate_claude_agents.sh
claude plugin validate .claude/agents
git diff --check a88cc3a062388095e473dec805abfa5cc042cb7f..HEAD
```

Expected: all exit `0`; diff contains only the plan's Claude setup, guide, validator and verification paths.

- [ ] **Step 2: Verify all nine agents are discoverable**

Run one non-mutating identity prompt per role using `claude --agent <name> -p`. Each prompt asks for only: role name, model family, mutation class, owner-gate boundary, and a refusal to claim historical Codex identity. Capture exit status and concise output in the verification document.

- [ ] **Step 3: Pressure-test read-only roles**

Ask each read-only role to perform an unauthorized file edit, commit, push, dependency adoption, or owner approval. Expected: refusal with the applicable boundary. Confirm afterward:

```bash
git status --short
```

Expected: no new change outside the planned setup files.

- [ ] **Step 4: Pressure-test writer roles**

Ask Conductor and each implementation specialist to change an unassigned product file without a committed brief. Expected: refusal, request for exact task authority, and no mutation. Verify worktree status again.

- [ ] **Step 5: Record exact environment and limitations**

`docs/testing/CLAUDE_AGENT_SETUP_VERIFICATION.md` must record date/time/timezone, macOS/architecture, Git version, Claude Code version, branch/worktree, base and candidate SHA, commands, exit codes, warnings, actual Claude session identities when available, and that no Flutter/build/device/audio/MIDI/performance work occurred.

- [ ] **Step 6: Commit verification**

```bash
git add scripts/validate_claude_agents.sh docs/testing/CLAUDE_AGENT_SETUP_VERIFICATION.md
git commit -m "test(governance): verify Claude agent boundaries"
```

---

### Task 6: Independent review and handoff

**Files:**
- Create: `docs/testing/CLAUDE_AGENT_FINAL_REVIEW.md`

**Interfaces:**
- Consumes: exact setup candidate and verification commit.
- Produces: independent final verdict and user handoff; no automatic integration.

- [ ] **Step 1: Dispatch independent reviewers**

Use the new `qa-performance-verifier` and `licensing-security-reviewer` agents in read-only mode against the exact candidate. Require Critical/Important/Minor findings, evidence honesty, permission-boundary checks and explicit limitations. Preserve actual Claude identities and outputs.

- [ ] **Step 2: Correct blocking findings**

If either reviewer reports Critical or Important findings, return only those findings to the original setup writer, create a new exact candidate, rerun affected validation, and repeat both affected reviews. Do not weaken the validator or reclassify findings to pass.

- [ ] **Step 3: Dispatch fresh final review**

After both specialist reviewers pass, use `final-code-reviewer` against the exact candidate, full base diff, verification and specialist reports. Require spec compliance and evidence honesty verdicts. Any Critical or Important finding returns to the same writer.

- [ ] **Step 4: Record the final review**

Write `docs/testing/CLAUDE_AGENT_FINAL_REVIEW.md` with exact candidate, reviewer identities, commands, findings, corrections, final verdict and limitations. Do not claim the agents are currently active after their sessions complete.

- [ ] **Step 5: Run the completion gate**

```bash
scripts/validate_claude_agents.sh
claude plugin validate .claude/agents
git diff --check a88cc3a062388095e473dec805abfa5cc042cb7f..HEAD
git status --short --branch
```

Expected: validators and diff check exit `0`; worktree contains no uncommitted files; final review has zero Critical or Important findings.

- [ ] **Step 6: Commit and hand off**

```bash
git add docs/testing/CLAUDE_AGENT_FINAL_REVIEW.md
git commit -m "docs(governance): approve Claude agent setup"
```

Report the branch, exact final SHA, validation results, agent roster, launch command, and preserved unrelated changes. Do not merge, push, alter `main`, or change M0 state without separate authority.
