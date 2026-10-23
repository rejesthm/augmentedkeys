# CT03 baseline construction evidence

Status: constructed and locally verified; independent exact-candidate reviews pending. The combined M0 candidate remains `Paused for owner decision`. No source branch or executable milestone state has changed.

## Exact bindings

- Research parent: `8fdb7444ed80675269f38f90f84b362f90c9af23`.
- CT03 brief: `efdf3bbfee15d93e7b84fee867ae3d5429ca143d`, [BASELINE_CONSTRUCTION_BRIEF.md](BASELINE_CONSTRUCTION_BRIEF.md).
- Implementation: `eb0d55bc7e10b219996fdb7ab69a546b1e350e3a`.
- Reviewed CT02 proposal: `b996cd066da941181d5cf13ef4c7c01b2abe7d77`; acceptance evidence `b414edb4cb2bb5fde6a8d730ba008d156b98b96d`.
- Governing source: `4a9a4aa05f47935c7d997c5bbf4c19fc7c1a77a9`; retained contract content source `b0122f7030331d3e86af28a779075349fc9e74ff`.
- **Current contract-changing commit on the constructed branch: `eb0d55bc7e10b219996fdb7ab69a546b1e350e3a`.** Its contract blob equals the reviewed source, but the later activation package must bind this imported commit and the actual reviewed candidate. The older source commit alone is not a new owner activation binding.
- Isolated branch/worktree: `task/ct03-baseline-reconciliation`, `/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/ct03-baseline-reconciliation`.

The controller was the sole writer. The brief was committed before construction, and fresh eligibility/source checks passed. No specialist writer ran. The content commit imports 25 paths byte-for-byte with original modes, copies four exact CT02 artifacts, and synthesizes only STATE, progress and M0_LEDGER. Every original research task/transition/integration row remains unchanged. All 143 original files outside the allowlist retain their bytes and modes; research outputs, owner decisions, failures and correction artifacts remain intact. R01/R02 are Verified, R03-R10 Queued, and the combined candidate is paused. The research source branch remains at its original tip.

## Fresh verification

The source files tested in the worktree match implementation commit `eb0d55bc7e10b219996fdb7ab69a546b1e350e3a`. The two suites used disposable local repositories; their fixture pushes did not target the project remote. No actual guard integration or publication was performed.

```json
{
  "recorded_at_utc": "2026-10-23T06:38:14Z",
  "implementation": "eb0d55bc7e10b219996fdb7ab69a546b1e350e3a",
  "base": "8fdb7444ed80675269f38f90f84b362f90c9af23",
  "brief": "efdf3bbfee15d93e7b84fee867ae3d5429ca143d",
  "latest_contract_changing_commit": "eb0d55bc7e10b219996fdb7ab69a546b1e350e3a",
  "contract_content_source": "b0122f7030331d3e86af28a779075349fc9e74ff",
  "contract_blob": "411944af151d61b2fdf42e68241e318a259df275",
  "environment": {
    "os": "ProductName:\t\tmacOS\nProductVersion:\t\t26.6.2\nBuildVersion:\t\t25G83",
    "machine": "arm64",
    "git": "git version 2.54.0 (Apple Git-157)",
    "bash": "GNU bash, version 3.2.57(1)-release (arm64-apple-darwin25)"
  },
  "content_checks": {
    "exact_imports": 25,
    "unchanged_original_files": 143,
    "authorized_paths_present": 33,
    "content_allowlist": 28,
    "controller_artifact_allowlist": 6,
    "research_history_rows_preserved": true,
    "task_states": "R01/R02 Verified; R03-R10 Queued",
    "candidate_m0": "Paused for owner decision",
    "project_commit_references_resolve": 76,
    "historical_fixture_hashes_preserved_but_not_project_commits": [
      "1d829f3771afa8fe0ae803c78a1cec76f83b1ab0",
      "420cf110570a5c046f03d3f20ba6e8ebd40afb15",
      "7d3d0ca61d8941c067090d2eb7b75feb70fdeaf3",
      "9315c05f7cf50a4437c4b5cdb607cd472cd67004"
    ],
    "initial_verifier_failure": "Initial generic 40-hex scan incorrectly treated documented temporary-fixture hashes as project commits. Corrected classification proved all four labels exist unchanged in source history; all actual project commit references resolve.",
    "result": "PASS"
  },
  "local_markdown_links_checked": 46,
  "diff_check_exit": 0,
  "guard_tests": [
    {
      "command": "bash .codex/skills/roadmap-orchestrator/scripts/test_validate_decision_evidence.sh",
      "exit": 0,
      "result": "PASS: 17 decision-evidence guard scenarios",
      "output": "ct03-evidence-guard.txt",
      "sha256": "db3fae9f6e54e61b782f83f41d7175336a20f2627d4b67c36056bf0182a75d80"
    },
    {
      "command": "bash .codex/skills/roadmap-orchestrator/scripts/test_validate_main_integration.sh",
      "exit": 0,
      "result": "PASS: 28 main-integration guard scenarios",
      "output": "ct03-main-guard.txt",
      "sha256": "5624447765089aa0e905f4c97913bf9e39c489e3a1ec85e28e60a59c4b7354bd"
    }
  ]
}
```

The first reference-check harness treated every 40-hex string as a project commit and stopped on a temporary-fixture hash. A second classification attempt found two additional fixture hashes. Source inspection proved all four were already explicitly labeled as disposable local test results. The corrected check preserves them unchanged and resolves all 76 actual project commit references. These were verifier classification errors, not missing project evidence; the failed attempts remain in controller tool output and the content-verification record.

No Flutter, native build, simulator/emulator, physical-device, audio/MIDI, latency, workload or long-run check was run or claimed. No application, manifest, lockfile, dependency, asset, instrument, architecture or ADR change occurred. The app remains the existing shell.

## Retained original-checkout edits

Two original uncommitted main-guard files remain untouched and were not imported. Their observed changes add ignored-state recovery, temporary-path and evidence-movement protections. Their exact diff and hashes are retained in CT02 evidence. This task runs the exact committed source's 28-case suite; passing it does not review those newer edits or prove main-integration readiness. A separate bounded independent review must resolve them before main-integration readiness is claimed. No main integration is authorized here.

## Evidence locations and hashes

Controller raw evidence is retained under `/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.git/decision-team-continuation/2026-10-23/`.

| Artifact | SHA-256 |
| --- | --- |
| `ct03-eligibility.json` | `61491573b54f528e82c25d02c6be82a628c22526121b41f19c836b9dd78ce191` |
| `ct03-content-verification.json` | `43e141301b41efc2bd9045ce2ffdd70917e302b44f39f4298c869ba2866295f4` |
| `ct03-controller-verification.json` | `04404db51c9dcfc9e8304eb5a7800847d79f73d109e636f251c384bd61a14c90` |
| `ct03-evidence-guard.txt` | `db3fae9f6e54e61b782f83f41d7175336a20f2627d4b67c36056bf0182a75d80` |
| `ct03-main-guard.txt` | `5624447765089aa0e905f4c97913bf9e39c489e3a1ec85e28e60a59c4b7354bd` |
| `preexisting-main-guard-edits-observation.json` | `94bb05bcd0078ba8fe1053261544f66c521f51a4667c7ded11c73f06084795c8` |

## Review handoff and next gate

The exact review candidate includes this verification record in a later controller evidence commit. Independent QA and Security must review that full candidate against research parent `8fdb7444ed80675269f38f90f84b362f90c9af23`, exact import-source equivalence, synthesized state and these limitations. Final review follows their approvals. The controller records all literal verdicts and source-backed read-only runtime provenance after return; no implementer approves its own work.

Only after required reviews pass may the controller assemble the concrete activation package from CT02. All exact contract entry conditions and the required owner decision remain binding. There is no M0 reactivation, R03 execution, queue amendment, milestone acceptance, main integration, successor activation or publication authority in this record.
