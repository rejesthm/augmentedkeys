# G01 Role-Isolated Dispatch Correction Brief

Status: `Implemented and runtime-validated; independent correction re-review pending`
Authority: OD-004 at `82dc35ac2042ab4697b322dabd1fb03c61a5ae5a`
Owner: Roadmap Orchestrator controller (`/root`)

## Objective

Replace only the failed nested mixed-permission dispatch rule with root-mediated top-level sessions so the configured workspace-write Conductor and configured read-only Researcher/reviewers can retain their required effective sandboxes. Preserve the M0 research contract, queue, safety gates, branch/publication rules, paused milestone state, and blocked R01 state until runtime proof and independent review pass.

## Allowed files

- `AGENTS.md`
- `.codex/agents/conductor.toml`
- `.codex/skills/roadmap-orchestrator/SKILL.md`
- `docs/orchestration/milestones/M0_CONTRACT.md`
- `docs/orchestration/milestones/m0/evidence/g01-role-isolated-validation.md`
- `docs/orchestration/milestones/m0/evidence/g01-role-isolated-review.md`
- this brief, only for an accurate final status line if needed

No other path is authorized by this correction task. Shared milestone state files are reserved to the controller for later evidence-backed transitions.

## Required topology

```text
Roadmap Orchestrator controller (sole shared-state writer and handoff mediator)
├── independent top-level workspace-write relay
│   └── exactly one same-sandbox configured Conductor child
└── one independent top-level read-only relay per required role
    └── exactly one same-sandbox configured Researcher, QA/Performance,
        Licensing/Security, or Final Code Reviewer child
```

The Conductor selects only the roles materially needed for one bounded task and returns exact dispatch requests to the controller. Because Codex CLI 0.150.0-alpha.12.2 cannot invoke a project custom agent directly, the controller launches one project-rooted top-level relay per role with the same effective sandbox required by that role; each relay may spawn exactly one actual configured child of that same permission class. The controller binds the outer spawn record to the child's saved runtime context and relays only committed briefs, exact commits, evidence paths, and bounded findings. The Conductor must not spawn a read-only specialist from its workspace-write session. A read-only relay or role must not spawn a write-capable role. No relay may dispatch task work itself.

## Required governance changes

1. `AGENTS.md` must define the controller-mediated topology and preserve the one-writer and three-specialist limits.
2. `.codex/agents/conductor.toml` must select roles and return dispatch requests instead of directly launching mixed-permission specialists. Its configured model, reasoning effort, and workspace-write sandbox must not change.
3. `.codex/skills/roadmap-orchestrator/SKILL.md` must make the controller the top-level launcher/relay and prohibit mixed-permission nesting while keeping the existing task briefs, transition barriers, verification, correction, integration, publication, and owner gates unchanged.
4. `docs/orchestration/milestones/M0_CONTRACT.md` must increment to version 2, bind OD-004, authorize only this dispatch correction, and make successful runtime proof plus independent approval an entry condition for reactivation. It must not alter the objective, queue, outputs, dependencies, definition of done, allowed research paths, publication authority, or non-goals.

## Runtime verification requirements

Use separate top-level project-rooted Codex relay sessions, with relay and configured child in the same permission class. Each probe must be diagnostic-only and must not edit, commit, publish, perform research-body work, use hardware, or change permissions.

Committed validation evidence must identify:

- Codex CLI version and exact command shape;
- project root and source session identifier;
- resolved configured role name;
- actual model and reasoning effort from runtime context;
- actual effective sandbox from runtime context;
- whether a prohibited write was refused or a permitted Conductor-only diagnostic boundary was present;
- exit/result status and literal output provenance;
- limitations, including that configuration validation is not product, latency, audio, MIDI, simulator, emulator, or physical-device evidence.

Required roles:

- `conductor`: `gpt-5.6-sol`, `high`, effective `workspace-write`;
- `researcher`: `gpt-5.6-terra`, `high`, effective `read-only`;
- `qa_performance_verifier`: `gpt-5.6-sol`, `high`, effective `read-only`;
- `licensing_security_reviewer`: `gpt-5.6-sol`, `high`, effective `read-only`;
- `final_code_reviewer`: `gpt-5.6-sol`, `xhigh`, effective `read-only`.

Do not infer effective permissions from TOML text or an agent's claim. Capture the runtime turn context or equivalent source-backed context supplied by the trusted Codex session. A probe that cannot expose authoritative effective context does not pass.

## Independent review

A fresh read-only reviewer must inspect the exact correction commit, all runtime provenance, and repository state. Approval requires:

- no Critical or Important finding;
- all five roles proven with the required effective context;
- no mixed-permission nested launch;
- no probe-authored repository change;
- M0 still `Paused for owner decision` and R01 still `Blocked`;
- `main` and `origin/main` unchanged at the accepted foundation;
- no product, dependency, asset, hardware, release, automation, or publication change.

## Stop conditions

Stop without reactivation if any runtime role has the wrong model, effort, or effective sandbox; authoritative runtime context is missing; a probe writes or changes repository state; review has a Critical or Important finding; the contract objective/queue/safety gates would change; or any path outside the allowlist is needed.

After verified approval, the controller must first commit the exact reactivation decision artifact bound to the corrected contract and validation/review commits. Separate later commits transition M0 and R01. No research may execute between those commits.
