# Claude Code Agent Parity Design

Date: 2026-09-02
Status: Approved design; implementation not started

## Objective

Add project-native Claude Code equivalents of AugmentedKeys' nine Codex agents so Claude Code can continue the same gated milestone workflow with recognizable role behavior, safety boundaries, and review independence.

The Claude agents will be new runtime identities. They must never claim to be, resume, or reproduce the identity of a prior Codex agent. Existing Codex definitions and historical provenance remain unchanged.

## Success criteria

1. Claude Code discovers exactly nine project agents from `.claude/agents/`.
2. Each agent preserves the corresponding Codex role's purpose, tone, authority, non-goals, stop conditions, and handoff rules.
3. Writer roles and read-only reviewer roles remain distinct.
4. The Conductor selects the minimum necessary specialists and cannot replace required independent review.
5. The Decision Steward remains read-only and cannot manufacture owner approval.
6. The top-level Claude session follows the committed milestone contract and state rather than relying on a continuation prompt or chat memory.
7. A local validator checks roster completeness, unique names, required frontmatter, role classes, and critical safety language.
8. Existing `.codex/agents/`, milestone evidence, application files, dependencies, and unrelated current changes remain untouched by this setup.

## Chosen approach

Use native, project-scoped Claude Code subagents stored as Markdown files with YAML frontmatter under `.claude/agents/`. Add a root `CLAUDE.md` coordination bridge and a read-only validation script.

This is preferred over user-global agents because these roles are specific to AugmentedKeys and should be version controlled with the project. It is preferred over a Claude plugin because cross-project distribution is not currently required.

Implementation will occur on a new isolated governance branch/worktree based on the selected committed governance tip. Existing uncommittedable guard-script modifications in the current checkout will not be staged, overwritten, or reformatted.

## Agent roster and model routing

| Claude agent | Responsibility | Model class | Authority |
|---|---|---|---|
| `conductor` | Coordinate one bounded task, choose minimum specialists, synthesize evidence, enforce gates | Opus | Workspace writer only for explicitly assigned paths |
| `decision-steward` | Review exact-SHA milestone acceptance/integration decisions and escalate owner-only gates | Opus | Read-only; no owner impersonation |
| `researcher` | Collect current primary-source technical evidence and separate fact from inference | Sonnet | Read-only |
| `flutter-builder` | Implement one approved Flutter task with tests and narrow scope | Sonnet | Workspace writer only for assigned task paths |
| `apple-specialist` | Handle approved iOS/iPadOS, Core Audio, AUv3, lifecycle and Apple MIDI work | Sonnet | Writer only when explicitly assigned; otherwise research-only |
| `android-specialist` | Handle approved Android, AAudio/Oboe, AAP, lifecycle and Android MIDI work | Sonnet | Writer only when explicitly assigned; otherwise research-only |
| `qa-performance-verifier` | Independently verify requirements, tests, devices, latency and performance evidence | Sonnet | Read-only; never fixes findings |
| `licensing-security-reviewer` | Independently review licensing, dependencies, assets, permissions, privacy and secrets | Sonnet | Read-only; no legal conclusions or fixes |
| `final-code-reviewer` | Final independent correctness, regression, safety and consistency review | Opus | Read-only; never implements fixes |

Exact Claude model aliases will use supported Claude Code names rather than Codex model identifiers. Configuration will favor explicit effort settings where supported. Model selection does not change authority.

## Native agent format

Each `.claude/agents/<name>.md` file will contain:

- a unique `name`;
- a precise `description` explaining when Claude should delegate to it;
- an explicit `model` and effort setting when supported;
- a constrained tool list and/or disallowed mutation tools;
- an appropriate permission mode;
- optional worktree isolation for writer roles where supported;
- a Markdown system prompt containing role behavior, required reading, evidence format, authority boundaries, stop conditions and handoff contract.

Read-only roles will exclude file-edit tools and explicitly prohibit mutation through shell commands, commits, pushes, external writes, dependency actions and hidden fixes. Writer roles will be bounded by committed briefs, isolated branches/worktrees and exact file ownership.

## Coordination bridge

The root `CLAUDE.md` will instruct the main Claude Code session to:

1. Treat committed repository state and contracts as authoritative.
2. Read the current milestone contract, ledger, task brief and applicable controls before action.
3. Use the `conductor` for one bounded task at a time.
4. Dispatch only the minimum necessary specialists.
5. Preserve single-writer ownership and use isolated worktrees.
6. Require QA/Performance and Licensing/Security review when specified by the task.
7. Require a fresh Final Code Review only after specialist gates pass.
8. Return rejected work to the same writer for bounded correction and fresh affected review.
9. Preserve exact Claude agent/session provenance without relabeling it as Codex provenance.
10. Keep owner-only gates owner-only, including milestone acceptance and any authority explicitly reserved by the committed contract.
11. Never push `main` or a task branch when the contract authorizes only guarded milestone-branch publication.
12. Never interpret research or setup as proof of low latency, smoothness, compatibility, licensing clearance or production readiness.

The bridge will reference, not duplicate or silently replace, the detailed repository governance sources.

## Workflow

For a normal roadmap task:

1. Main Claude session verifies repository, branch, worktree and state.
2. The committed brief and separate eligibility transition are created by the authorized controller.
3. A Conductor receives exact commit identities and file ownership.
4. The Conductor requests only necessary specialists.
5. One assigned writer creates the candidate in an isolated task worktree.
6. Controller-owned verification is committed separately.
7. Required read-only specialist reviewers independently assess the exact candidate.
8. A fresh Final Code Reviewer runs only after prerequisite reviews pass.
9. Blocking findings return to the same writer; evidence and state transitions remain separate.
10. Only an exact Verified candidate may be integrated into the milestone branch.
11. Publication and owner gates follow the committed contract and guard scripts.

## Decision Steward boundary

The Decision Steward may assess whether evidence supports a proposed milestone decision, integration into `main`, or successor activation. It may approve only actions that the committed governance explicitly delegates to it.

It must escalate whenever owner authority is required. It cannot invent owner approval, weaken a gate, approve unresolved Critical/Important findings, alter evidence, merge, push, or execute the action it reviews. Its verdict must bind to exact SHAs and record limitations.

## Validation

`scripts/validate_claude_agents.sh` will be read-only and deterministic. It will verify:

- exactly nine expected Markdown agent definitions;
- unique, expected frontmatter names;
- required description, model and permission/tool fields;
- expected writer versus read-only classification;
- mutation tools absent or denied for reviewers;
- mandatory owner-gate, evidence-honesty, no-impersonation and no-unsupported-performance language;
- `CLAUDE.md` references all nine roles and the gated review sequence;
- existing Codex agent definitions are unchanged by the implementation diff.

Validation will also use Claude Code's available agent listing or diagnostic interface when the installed CLI exposes a reliable noninteractive check. Manual `/agents` discovery will be documented as a final runtime check if no stable machine-readable command exists.

## Testing and review

Verification will include:

1. Markdown/frontmatter structural checks.
2. The repository-local validation script.
3. A diff-scope check proving only approved Claude setup, documentation and validation paths changed.
4. Claude Code project-agent discovery.
5. Read-only pressure prompts for Decision Steward and reviewers.
6. Writer-boundary pressure prompts for Conductor/build specialists without product edits.
7. Independent final review of the setup.

No product implementation, dependency resolution, Flutter build, simulator, emulator, device, audio, MIDI, latency or performance test is justified by this configuration-only task.

## Error handling and rollback

- Invalid frontmatter or undiscovered agents: stop, preserve output, correct only the affected agent definition, and rerun full validation.
- Permission boundary failure: reject the setup; do not rely on prompt wording alone if configuration grants unintended authority.
- Duplicate agent name: stop because Claude may silently discard one definition.
- Existing dirty-file overlap: stop rather than overwrite or stage the user's changes.
- Unsupported Claude field: replace it with a documented supported field or an explicit prompt/tool restriction, then revalidate.
- Rollback consists of reverting only the new Claude-agent setup commits; existing Codex configuration and evidence remain intact.

## Deliverables

- Nine files under `.claude/agents/`.
- Root `CLAUDE.md` coordination bridge.
- `scripts/validate_claude_agents.sh`.
- A concise Claude continuation prompt or runbook showing normal launch and explicit `claude --agent conductor` use.
- Verification and independent review evidence appropriate to the governance branch.

## Non-goals

- Replacing or editing Codex agents.
- Reusing Codex session identities as Claude identities.
- Changing the M0 research state or accepting a milestone.
- Modifying application, Flutter, Android or Apple product code.
- Selecting architecture or dependencies.
- Enabling automatic `main` integration, deployment or release.
- Claiming that agent configuration proves application quality, smoothness or low latency.
