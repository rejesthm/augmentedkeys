# Decision Evidence Protocol

This directory is the only canonical content root for the dedicated `governance/decision-evidence` branch. That branch is an append-only governance journal, not a product branch. Only the program controller may write it, only from a dedicated isolated worktree. Decision Steward and review sessions are read-only.

## Branch invariant

- Record one exact governance-base commit in the milestone ledger before branch creation. The first evidence commit is its direct child and adds immutable `docs/orchestration/decisions/governance-base.md` with that same exact SHA; every publisher invocation must prove this anchor and may not trust a later CLI base.
- Create `governance/decision-evidence` once from that base through `validate_decision_evidence.sh`; thereafter publish only fast-forward descendants with the guard's explicit refspec.
- The direct-child anchor is a `100644 blob`. After that anchor, every path as changed in every new commit is a canonical `100644 blob` Markdown file under `docs/orchestration/decisions/m<digits>/{packages,verdicts,results,bindings}/`; a later corrected tip cannot sanitize an invalid historical mode or type. Packages, verdicts, and results are add-only; a binding may be added or updated to point at a later immutable sequence. Deletion is forbidden throughout history.
- Every commit after the governance base has exactly one parent. Never merge, rebase, force-push, rewrite, delete, merge product work, create or publish tags, sign, or use a direct raw push.
- Before consuming a decision, local and remote evidence tips must equal the exact current binding commit. Any later unconsumed commit or unequal tip requires `PAUSE_HUMAN`.

## Immutable review commits

Between complete package/verdict/binding or result/binding sequences, the controller may add one review at `docs/orchestration/decisions/m<digits>/reviews/<immutable-name>.md`. Each review commit is single-parent, add-only, changes exactly one canonical regular `100644` file, and records the exact candidate, role, session, runtime, full-output SHA-256, result, and finding counts. Reviews occur after candidate freeze, precede the consuming package, and are ancestors of that package. They are not ancestors of the candidate. Mutation, deletion, self-reference, candidate substitution, or reuse after a candidate change is invalid.

## Decision sequence

Every milestone acceptance, main integration approval, correction, human pause, or successor activation uses exactly three adjacent single-path commits. Each commit changes only the one path named for its stage; co-committed packages, verdicts, bindings, or other decision artifacts are invalid:

1. Immutable package: `docs/orchestration/decisions/<milestone>/packages/<action>-<sequence>.md`.
2. Verbatim read-only Steward verdict: `docs/orchestration/decisions/<milestone>/verdicts/<action>-<sequence>.md`.
3. Canonical current binding: `docs/orchestration/decisions/<milestone>/bindings/<action>.md`.

The package commit adds exactly one immutable package path. The verdict commit adds exactly one immutable verdict path. The binding commit adds or updates exactly one canonical binding path. The package records exact milestone, contract, reviewed candidate, completion package, QA/Performance review, Licensing/Security review, Final review, target `main`, optional successor contract and entry-condition evidence, zero Critical/Important findings, limitations, and recovery instructions. Every artifact has both a canonical path and exact readable commit.

The verdict records its evidence-package path and commit, the exact allowed verdict, all bound SHAs, finding counts, exclusions, `Controller recorder: program-controller`, `Steward role: decision_steward`, a nonempty canonical Steward session identifier, and a UTC `Recorded timestamp`. The controller metadata surrounds but does not alter the Steward's verbatim verdict. The binding records `Binding status: Current`, its package and verdict paths/commits, the resulting milestone or integration state, all decisive SHAs, and finding counts. Every referenced artifact must be a canonical readable `100644 blob`, never a directory or symlink. A later `CORRECT`, `PAUSE_HUMAN`, replacement approval, result, or binding supersedes the old binding; an old approval is never replayed.

## Acceptance and main-integration identities

The acceptance sequence binds frozen completion candidate `C`. The main-integration sequence binds both `C` and administrative descendant `I`, the exact semantic `C`-to-`I` delta, the current acceptance binding, fresh review commits for `I`, and the unchanged target-main base. The canonical binding repeats both identities. `C` and `I` must remain distinct and may not be substituted.

Every guard invocation supplies a reviewed guard commit and expected SHA-256. The executable runtime bytes must match the canonical `100755` blob at that commit before evidence publication or main mutation is authorized.

## Main integration result

Every attempted integration is followed by an immutable result and a current result binding on this branch. The result records the consumed approval binding, guard arguments and complete outputs, pre/post local and remote `main` SHAs, environment, limitations, interruption point, and recovery action.

- `SUCCEEDED`: local and remote `main` are proved equal to the accepted tip.
- `REJECTED`: the remote is proved unchanged at the recorded base and local `main`, index, and worktree are fully restored before refusal.
- `PARTIAL`: the result is ambiguous, externally moved, unverifiable, or not safely restored. It is non-replayable and requires `PAUSE_HUMAN`.

The controller publishes the result and binding through the evidence guard before updating the milestone ledger. Only `SUCCEEDED` may record integrated hashes. A prior approval cannot be retried after any bound result.

## Recovery

Main preflight rejects tracked, untracked, and ignored candidate collisions. The guard snapshots exact pre-integration state only into a validated private temporary directory: new, non-symlink, owned by the caller, mode `0700`, empty before capture, and under a standard private temporary root. It retains the directory whenever restoration or post-push state is unproved. Such an attempt is `PARTIAL`, cannot replay its approval, and requires a current result binding plus `PAUSE_HUMAN`. Only proved success or byte-for-byte restoration permits snapshot deletion.

On resume, inspect the ledger, the local and remote evidence tips, the branch-tip binding, and commits after the last consumed binding. Continue only when one ordered, current, unsuperseded sequence maps unambiguously from the recorded state to one permitted next state. A consumer must prove at the final evidence-binding tip that every prerequisite binding's latest change is still its recorded approval commit; checking only at an intermediate package commit is insufficient. Missing, conflicting, unreadable, internally inconsistent, or unverifiable evidence always requires `PAUSE_HUMAN` without mutation.
