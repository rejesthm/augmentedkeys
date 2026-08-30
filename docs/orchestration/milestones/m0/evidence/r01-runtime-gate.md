# R01 runtime permission gate — G01

## Outcome and scope

R01 cannot continue through the approved mixed-permission team until the agent-launch permission mismatch is corrected and independently validated with owner authorization. No research candidate was written or committed. This is a workflow-permission failure, not an audio test failure or evidence of a malicious agent.

- Date: 2026-08-30, Asia/Manila.
- Responsible recorder: Roadmap Orchestrator, who supplied the parent launch option.
- Milestone source tip at detection: `98385e8cc9a8b01d0b6d2e079c83a3360d774662`.
- Task execution base and preserved task tip: `563700a839c627ff32ec2fa697e9810bc9b16a84`.
- Brief: `b50e58e187f60b20ab9f12c7306af63a3cba3a9e`.
- Assignment: `590e2bb984a01032a77154eb2152383e2a2864c6`; identity evidence: `cdddb1aa9a0d9a765b02ba366c551289264f71db`.
- Environment: arm64 macOS 26.6.1 (25G76), codex-cli 0.150.0-alpha.12.2.
- Device/simulator/emulator/audio interface/MIDI controller/build mode/sample rate/buffer/workload: Not applicable; repository/session inspection only.
- Reviewer: Roadmap Orchestrator (diagnostic recorder); no task QA/final review or independent approval of a recovery has occurred.

## Observed mismatch and documented explanation

The unchanged `.codex/agents/researcher.toml` sets `sandbox_mode = "read-only"`, `gpt-5.6-terra` and `high`. The actual configured Researcher was dispatched at Conductor source ordinal 69, with its child start at 70. Its effective own turn context is ordinal 15: terra/high, but `workspace-write`. Ordinal 6 is inherited Conductor context and is not the Researcher's effective context.

The relay invocation explicitly supplied `-s workspace-write` so that the Conductor could prepare the two allowed reports. The Conductor's own workspace-write context is expected; reapplying that override to the Researcher is not the intended read-only execution boundary. Model/role loading alone did not establish the required sandbox.

Official OpenAI documentation, accessed 2026-08-30, says parent live runtime sandbox/approval overrides are reapplied when spawning children even when a custom-agent file supplies different defaults. This explains the observed propagation; it does not prove a tested recovery or a Codex software defect. Source: [Subagents — Approvals and sandbox controls](https://learn.chatgpt.com/docs/agent-configuration/subagents#approvals-and-sandbox-controls). The controller has not changed configuration, removed an override and resumed, weakened the read-only requirement, or selected an untested alternate dispatch route.

## Containment and attempts

1. Read the unchanged Researcher definition and actual saved turn contexts; confirmed exact role/child, correct model/effort, and broader effective sandbox.
2. Tried to send a stop message to the exact Conductor ID through the current app's collaboration channel. It returned `agent with id 01a05194-6f43-7d11-9142-eb8fc9db2aba not found`; this channel does not control that separately saved CLI session. No successful delivery is claimed.
3. Read the process table and matched PID 49532 to the exact R01 relay command/worktree. Sent only `kill -INT 49532`; existing execution session 52640 returned exit 1 and `turn interrupted`. No file or branch was deleted.
4. Confirmed that PID no longer exists, the task checkout is clean at its unchanged execution base, accepted main/origin-main remain unchanged, and protected code/config/manifests/lockfile have no milestone diff.
5. Inspected the bounded saved tool-call records: no apply-patch/write-file/create-file tool mention was found in relay, Conductor or Researcher; researcher activity was documentary browsing/reads. A clean repository and this tool audit are not a comprehensive forensic guarantee about every filesystem location.
6. The Researcher returned source notes before termination; its literal final reply is retained in `r01-researcher-unreviewed.md`, explicitly unreviewed. The Conductor and relay have no final readiness reply. No candidate, verification artifact, task review, integration or task publication exists.
7. CLI output included connection-reset/idle-timeout retries and analytics/duplicate-tool warnings. These are not evidence of product failure or the permission cause. No unverified explanation of elapsed wall time is asserted.

## Bounded source metadata

Hashes below identify saved files after the stopped run. Source records are zero-based. The full unrelated session contents are not copied into this repository.

```json
[
  {
    "role": "relay",
    "path": "/Users/jestherjordanminor/.codex/sessions/2026/08/30/rollout-2026-08-30T15-31-01-01a05194-3147-7c51-994f-6c1f0fa4b33a.jsonl",
    "sha256": "081c991f0dd921940d1d66439893141e3274c3233c9ab921b681f30e237f051a",
    "records": 44,
    "contexts": [
      {
        "ordinal": 7,
        "model": "gpt-5.6-terra",
        "effort": "medium",
        "sandbox": {
          "type": "workspace-write",
          "network_access": false,
          "exclude_tmpdir_env_var": false,
          "exclude_slash_tmp": false
        }
      }
    ],
    "dispatches": [
      {
        "ordinal": 20,
        "role": "conductor",
        "task": "r01_conductor",
        "fork": "none"
      }
    ],
    "starts": [
      {
        "ordinal": 21,
        "child": "01a05194-6f43-7d11-9142-eb8fc9db2aba",
        "path": "/root/r01_conductor"
      }
    ],
    "finals": [],
    "editToolMentionOrdinals": []
  },
  {
    "role": "conductor",
    "path": "/Users/jestherjordanminor/.codex/sessions/2026/08/30/rollout-2026-08-30T15-31-17-01a05194-6f43-7d11-9142-eb8fc9db2aba.jsonl",
    "sha256": "2f94f8116ed99592e4e0c909a5bcc43b18e8a0cd7f47c888f3555fa33f273c3f",
    "records": 107,
    "contexts": [
      {
        "ordinal": 7,
        "model": "gpt-5.6-sol",
        "effort": "high",
        "sandbox": {
          "type": "workspace-write",
          "network_access": false,
          "exclude_tmpdir_env_var": false,
          "exclude_slash_tmp": false
        }
      }
    ],
    "dispatches": [
      {
        "ordinal": 69,
        "role": "researcher",
        "task": "r01_sources",
        "fork": "default"
      }
    ],
    "starts": [
      {
        "ordinal": 70,
        "child": "01a05195-0f7e-76d2-bafc-76f4f335b904",
        "path": "/root/r01_conductor/r01_sources"
      }
    ],
    "finals": [],
    "editToolMentionOrdinals": []
  },
  {
    "role": "researcher",
    "path": "/Users/jestherjordanminor/.codex/sessions/2026/08/30/rollout-2026-08-30T15-31-58-01a05195-0f7e-76d2-bafc-76f4f335b904.jsonl",
    "sha256": "5d183bc55736b46afdf2c27c4ceec3a13aac801d7d2fa07a3dc870ab448ba81b",
    "records": 132,
    "contexts": [
      {
        "ordinal": 6,
        "model": "gpt-5.6-sol",
        "effort": "high",
        "sandbox": {
          "type": "workspace-write",
          "network_access": false,
          "exclude_tmpdir_env_var": false,
          "exclude_slash_tmp": false
        }
      },
      {
        "ordinal": 15,
        "model": "gpt-5.6-terra",
        "effort": "high",
        "sandbox": {
          "type": "workspace-write",
          "network_access": false,
          "exclude_tmpdir_env_var": false,
          "exclude_slash_tmp": false
        }
      }
    ],
    "dispatches": [],
    "starts": [],
    "finals": [
      {
        "ordinal": 129,
        "retainedAt": "r01-researcher-unreviewed.md"
      }
    ],
    "editToolMentionOrdinals": []
  }
]
```

## Fresh stop/tree verification

Exact procedure, run from the milestone worktree:

```bash
set -euo pipefail
date '+%Y-%m-%dT%H:%M:%S%z'
/Applications/ChatGPT.app/Contents/Resources/codex --version
git -C /Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-r01-audio-architecture status --porcelain
git -C /Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-r01-audio-architecture rev-parse HEAD
test -z "$(git -C /Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-r01-audio-architecture status --porcelain)"
test "$(git -C /Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-r01-audio-architecture rev-parse HEAD)" = 563700a839c627ff32ec2fa697e9810bc9b16a84
test -z "$(git diff --name-only b1b0c1edd5e42d3ea791f665c22954834e962d05..HEAD -- lib android ios pubspec.yaml pubspec.lock .codex AGENTS.md APP_SPEC.md ARCHITECTURE.md docs/adr gate.yaml loop-budget.md)"
test "$(git rev-parse main)" = b1b0c1edd5e42d3ea791f665c22954834e962d05
test "$(git rev-parse origin/main)" = b1b0c1edd5e42d3ea791f665c22954834e962d05
if ps -p 49532 -o pid=,stat=,comm=; then exit 1; fi
printf 'STOPPED_R01_TREE_AUDIT=PASS\n'
```

Original tool result:

```json
{
  "chunk_id": "2ec127",
  "wall_time_seconds": 0.0000025,
  "exit_code": 0,
  "original_token_count": 31,
  "output": "2026-08-30T22:19:17+0800\ncodex-cli 0.150.0-alpha.12.2\n563700a839c627ff32ec2fa697e9810bc9b16a84\nSTOPPED_R01_TREE_AUDIT=PASS\n"
}
```

## Gate, dependency impact and proposed owner decision

R01 remains in the definition of done and must move to Blocked through its canonical transition barrier. R02/R06 depend on R01. No other task should be dispatched through the same unvalidated mixed-permission launch; independent queue topics do not resolve this shared safety gate. Preserve both milestone/task branches and worktrees. No remote milestone was published.

Request owner approval for a bounded agent-launch correction and validation, with no product work, global permission broadening, dependency adoption, hardware, or M1. Validate the effective Conductor and every read-only specialist's permissions before resuming the exact preserved R01 writer. Any necessary out-of-allowlist configuration/skill/contract change needs separately approved scope; do not make it under this research contract. Retaining the current pause is the safe alternative. An explicit committed owner decision must resolve G01 and reactivate M0 before research resumes.
