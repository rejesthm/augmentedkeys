# G01 Role-Isolated Dispatch Validation

Status: `Passed; independent correction review still required`
Date: 2026-09-02 (Asia/Manila)
Authority: OD-004 at `82dc35ac2042ab4697b322dabd1fb03c61a5ae5a`
Correction brief: `bfea19d02f4a5998c33f37fcea4477eb47bb2a0a`
Correction candidate: `13b864f09ca083d10910bcffa4432b81c040bda9`
Controller task: `01a04c45-76d8-7ef0-9cb4-101dbe82a224`

## Purpose and boundary

This artifact validates only the OD-004 role-isolated dispatch correction. Five probes used separate project-rooted top-level relays. Each relay spawned exactly one actual configured project child with the same effective sandbox class. The probes were diagnostic-only: no research-body work, edit, commit, publication, hardware action, dependency or asset action, permission change, or external mutation was authorized.

The saved relay and child rollouts are the authority for role identity, parent/child binding, model, reasoning effort, sandbox, working directory, tool calls, and literal final response. Agent self-report was not used to infer runtime configuration.

## Environment and invocation

- Codex executable: `/Applications/ChatGPT.app/Contents/Resources/codex`
- Codex CLI: `0.150.0-alpha.12.2`
- Project root: `/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-research`
- Probe starting and ending milestone tip: `13b864f09ca083d10910bcffa4432b81c040bda9`
- Relay model and effort: `gpt-5.6-terra`, `low`, intentionally different from configured children so child overrides are observable
- Approval mode: `never`
- Execution: sequential; all five relay processes exited 0

Exact command shape, with the role-specific substitutions in the table below:

```bash
/Applications/ChatGPT.app/Contents/Resources/codex \
  -C /Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-research \
  --strict-config \
  --sandbox ROLE_SANDBOX \
  --ask-for-approval never \
  --model gpt-5.6-terra \
  --config 'model_reasoning_effort="low"' \
  exec --json \
  'OD-004 G01 diagnostic relay only. M0 remains paused and R01 blocked. Spawn exactly one actual configured agent with agent_type=ROLE, task_name=TASK_NAME, and fork_turns=none. Perform no research-body work, edit, commit, publication, hardware action, permission change, external mutation, or further dispatch. Return the child final response unchanged.'
```

| Role substitution | `ROLE_SANDBOX` | `TASK_NAME` |
|---|---|---|
| `conductor` | `workspace-write` | `g01_v2_conductor_probe` |
| `researcher` | `read-only` | `g01_v2_researcher_probe` |
| `qa_performance_verifier` | `read-only` | `g01_v2_qa_probe` |
| `licensing_security_reviewer` | `read-only` | `g01_v2_security_probe` |
| `final_code_reviewer` | `read-only` | `g01_v2_final_probe` |

## Source-backed runtime results

All child `session_meta` records bind the actual configured role to its relay through `source.subagent.thread_spawn.parent_thread_id` and `agent_role`. All first child `turn_context` records use the project root above.

| Configured role | Relay ID / sandbox | Child ID | Child runtime context | Child rollout SHA-256 / lines | Result summary |
|---|---|---|---|---|---|
| `conductor` | `01a05fe0-b0a1-7070-bade-ee9a87f31b48` / `workspace-write` | `01a05fe0-f399-7302-8942-ad7c75783589` | `gpt-5.6-sol`; `high`; `workspace-write` | `86d16a787de8f7b1b5e0abb4a0c943e64f0d06dded0e60a0be8afc58a972fb27` / 68 | Returned one bounded controller dispatch request; performed no task work |
| `researcher` | `01a05fe2-8f58-7e92-a8e5-1723124ddea7` / `read-only` | `01a05fe2-bf16-7d43-87ee-178698f634e7` | `gpt-5.6-terra`; `high`; `read-only` | `daf4a38431f0485520e2bfb8b7781a3d54e3b087c214e4833a1d4a3631fa1203` / 16 | `I cannot perform R01 research because M0 is paused and R01 remains blocked.` |
| `qa_performance_verifier` | `01a05fe3-034f-7580-a184-9dad9398a282` / `read-only` | `01a05fe3-2f0c-7432-a96e-20cb11695c45` | `gpt-5.6-sol`; `high`; `read-only` | `6ee1c2844f65e873d28965acb83ff16560e02f8b65421c23c77692f254653261` / 22 | `Setup/runtime permission evidence does not prove product latency or device performance.` |
| `licensing_security_reviewer` | `01a05fe3-818c-73f2-9e84-3fc5a2f8de61` / `read-only` | `01a05fe3-aeae-7861-8544-f7f3528c040a` | `gpt-5.6-sol`; `high`; `read-only` | `57bf0bf505513bc45234187bb4905da42bd13a6e6f9a8785c48f20855e2a627b` / 16 | `No dependency, asset, credential, license conclusion, or external action is authorized by this permission probe.` |
| `final_code_reviewer` | `01a05fe3-ee08-7521-93fc-cd002739a037` / `read-only` | `01a05fe4-1f46-7552-b3ac-6c506bca6a89` | `gpt-5.6-sol`; `xhigh`; `read-only` | `2f1cbb49fd2eff0d01b56688531bd8243c7d19bd4e74e5e368d4238feef2e9e7` / 22 | `Runtime role discovery is not final approval of the G01 correction.` |

The configured-child call inventory is: Conductor, eight read-only `exec` calls; Researcher, no call; QA/Performance, one read-only `exec` call; Licensing/Security, no call; Final Code Reviewer, one read-only `exec` call. The raw rollouts show that these calls only read required controls or repository state. No child attempted an edit, network call, nested dispatch, or other repository mutation. Each relay rollout contains exactly one `spawn_agent` and one `wait_agent` call and no task-work call.

## Rollout provenance

| Session | Saved rollout | SHA-256 / lines |
|---|---|---|
| Conductor relay | `/Users/jestherjordanminor/.codex/sessions/2026/09/02/rollout-2026-09-02T10-09-15-01a05fe0-b0a1-7070-bade-ee9a87f31b48.jsonl` | `b84a1e0af7398507b17dfd76d20d811278cb720662eaa3dccb2577dd086a5bf9` / 54 |
| Conductor child | `/Users/jestherjordanminor/.codex/sessions/2026/09/02/rollout-2026-09-02T10-09-33-01a05fe0-f399-7302-8942-ad7c75783589.jsonl` | `86d16a787de8f7b1b5e0abb4a0c943e64f0d06dded0e60a0be8afc58a972fb27` / 68 |
| Researcher relay | `/Users/jestherjordanminor/.codex/sessions/2026/09/02/rollout-2026-09-02T10-11-18-01a05fe2-8f58-7e92-a8e5-1723124ddea7.jsonl` | `cedaf1ec49ec8dde2db3143c144f80e046999346a81cfcc37df310bfb0c3484c` / 38 |
| Researcher child | `/Users/jestherjordanminor/.codex/sessions/2026/09/02/rollout-2026-09-02T10-11-30-01a05fe2-bf16-7d43-87ee-178698f634e7.jsonl` | `daf4a38431f0485520e2bfb8b7781a3d54e3b087c214e4833a1d4a3631fa1203` / 16 |
| QA relay | `/Users/jestherjordanminor/.codex/sessions/2026/09/02/rollout-2026-09-02T10-11-48-01a05fe3-034f-7580-a184-9dad9398a282.jsonl` | `e6b7b75414049365ee36276020b3628c6eec827054265ed8639b84fe232a5d23` / 38 |
| QA child | `/Users/jestherjordanminor/.codex/sessions/2026/09/02/rollout-2026-09-02T10-11-59-01a05fe3-2f0c-7432-a96e-20cb11695c45.jsonl` | `6ee1c2844f65e873d28965acb83ff16560e02f8b65421c23c77692f254653261` / 22 |
| Security relay | `/Users/jestherjordanminor/.codex/sessions/2026/09/02/rollout-2026-09-02T10-12-20-01a05fe3-818c-73f2-9e84-3fc5a2f8de61.jsonl` | `649d8a70abebfec1d4fc61c0399af2dffe68223dda949b3657fbad142aed7372` / 38 |
| Security child | `/Users/jestherjordanminor/.codex/sessions/2026/09/02/rollout-2026-09-02T10-12-32-01a05fe3-aeae-7861-8544-f7f3528c040a.jsonl` | `57bf0bf505513bc45234187bb4905da42bd13a6e6f9a8785c48f20855e2a627b` / 16 |
| Final-role relay | `/Users/jestherjordanminor/.codex/sessions/2026/09/02/rollout-2026-09-02T10-12-48-01a05fe3-ee08-7521-93fc-cd002739a037.jsonl` | `0d243c95468b62db4d8616dead49a0f488f14d70eba2850b054c093ec5f48af5` / 40 |
| Final-role child | `/Users/jestherjordanminor/.codex/sessions/2026/09/02/rollout-2026-09-02T10-13-00-01a05fe4-1f46-7552-b3ac-6c506bca6a89.jsonl` | `2f1cbb49fd2eff0d01b56688531bd8243c7d19bd4e74e5e368d4238feef2e9e7` / 22 |

## Repository-state proof

After all five probes:

- `milestone/m0-research` was clean at `13b864f09ca083d10910bcffa4432b81c040bda9` before this evidence file was created.
- Preserved R01 worktree remained clean at `563700a839c627ff32ec2fa697e9810bc9b16a84`.
- Local `main` and `origin/main` remained identical at accepted foundation `b1b0c1edd5e42d3ea791f665c22954834e962d05`.
- The main checkout retained two unrelated pre-existing modifications in the main-integration guard scripts. The probes did not touch them; no clean-main claim is made about that checkout.
- M0 remained `Paused for owner decision`; R01 remained `Blocked`; R02-R10 remained `Queued`.

## Warnings and limitations

The CLI emitted known non-product warnings about interface icons and a duplicated Firestore tool registration. They did not change the saved runtime contexts or repository state and are not treated as product evidence.

This validation proves only the configured-agent dispatch boundary under this Codex CLI and local project configuration. It does not prove Flutter correctness, product behavior, audio or MIDI behavior, real-time safety, smoothness, reliability, latency, compatibility, simulator/emulator behavior, or physical-device performance. No device, controller, audio interface, benchmark, build, or Flutter test was used.

## Controller verdict

G01 runtime configuration boundary: `PASS`.

All five configured roles have source-backed required model, reasoning effort, effective sandbox, role identity, parent relay, and project root. Every relay and child permission class matches; no mixed-permission nested launch occurred; no probe-authored repository change occurred. This verdict does not reactivate M0. Fresh independent review of correction commit `13b864f09ca083d10910bcffa4432b81c040bda9` and this committed evidence is still required.
