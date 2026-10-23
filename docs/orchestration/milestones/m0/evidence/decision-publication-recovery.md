# Decision-evidence publication refusal and proposed recovery

Status: Owner decision required. No recovery, branch rewrite, bypass or publication retry is authorized by this record.

## Actual result

The independent Decision Steward returned PAUSE_HUMAN,0Critical/2Important, for candidate `708aaa5968d557a09d3b9f9b207ff3fd77ffd315` and package `a17d2891250c4757218dd77753643ec260bf2f62`. Controller recorded its text verbatim at local verdict `819cb32709584c7f1e76ce8db336051c6ddc7bb6` and a separate local binding `0db258d158f1d212497ccfdf07675ec399e6f870`. Those commits are preserved but UNPUBLISHED and UNCONSUMED; they cannot authorize any state transition. M0 was already paused under MT-002 independently of this unpublished verdict.

Evidence guard `authorize 0db258d158f1d212497ccfdf07675ec399e6f870 8138cf965531ffd34a9dd967b1724c837409a1c8` returned67 with:

```text
refused: remote governance base does not match recorded base for branch creation
```

The controller selected milestone completion `8138cf965531ffd34a9dd967b1724c837409a1c8` as the governance base. The existing guard's initial-branch condition requires that recorded base to equal live remote main `b1b0c1edd5e42d3ea791f665c22954834e962d05`. The selected base is wrong for that condition. This is a controller setup error; no guard defect is inferred from this refusal. The guard stopped before push, and neither push nor verify was attempted. Its original authorize output is private evidence-publication-authorize.json, SHA256 `d0e523ccb26b2bd785a43b89991a01b497f1fe95625125786654bf3768fd3248`.

Fresh read-only checks after refusal: local evidence tip `0db258d158f1d212497ccfdf07675ec399e6f870` is clean; remote evidence branch absent; remote main unchanged at `b1b0c1edd5e42d3ea791f665c22954834e962d05`; remote milestone remains published pause `708aaa5968d557a09d3b9f9b207ff3fd77ffd315`. Existing package→verdict→binding and anchor commits remain intact. No reset, rebase, force-push, deletion, rename, replacement or retry occurred. Source/runtime/review evidence and excluded original owner edits remain preserved.

## Requested explicit recovery authorization

In addition to the governance-only correction proposal at `8138cf965531ffd34a9dd967b1724c837409a1c8` (`governance-correction-proposal.md`), authorize a bounded recovery that preserves the entire unpublished evidence history before creating a corrected canonical evidence branch from the exact guard-required base.

Proposed procedure for the owner-approved task, not executed:

1. Re-prove local evidence tip `0db258d158f1d212497ccfdf07675ec399e6f870`, remote evidence absence, remote main and all worktree/owner-file hashes. Stop on any changed or ambiguous value.
2. Preserve this complete local history and worktree under an explicit archive branch name, proposed `archive/m0-decision-evidence-base-error-20261024`. Any reference rename/replacement must be separately enumerated in the approved brief; do not delete commits, rewrite history or force-push. Keep the original worktree/evidence readable.
3. Record the corrected governance base in the milestone ledger before creating a new dedicated canonical evidence worktree/branch. Use the guard-required exact live main base unless an independently reviewed, owner-approved guard design explicitly changes that rule. Do not move main to accommodate the mistaken base.
4. Create a new direct-child immutable anchor and truthful review/decision sequence under the corrected, independently reviewed controls. Bind fresh exact candidate/package/review SHAs and obtain a NEW independent Steward verdict. The old verdict remains historical; never transplant or replay it as approval for new SHAs.
5. Run the authorized evidence guard sequence and prove local/live remote equality before consuming any binding. Preserve all failed attempts and restoration evidence. No main integration, successor activation, product implementation, credential, asset, hardware or public release follows from recovery approval.

The correction brief must enumerate the exact isolated worktree, affected control/state paths, preservation refs, tests and independent reviews before mutation. The original two protocol findings remain open and still require the proposed governance repair. This refusal adds a concrete recovery gate; it does not close, downgrade or waive either finding.

## Present boundary

The full app remains unfinished. All ten M0 research tasks are Verified, none Accepted. The last published milestone state is Paused for owner decision. Local refusal/status records may be ahead of that remote state; no further publication is attempted after this failed safety gate. Owner authorization is needed for the bounded correction plus the explicit preservation/recovery procedure above.
