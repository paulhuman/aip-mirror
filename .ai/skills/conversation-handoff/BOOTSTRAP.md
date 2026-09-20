# Conversation handoff bootstrap

This file is a static procedural template for initializing a new AIP Mirror conversation chapter.

It must not contain the identity of a specific current or next chapter. Actual chapter values are supplied by the bootstrap message that invokes this procedure.

## Bootstrap inputs

The bootstrap message supplies:

    CURRENT_CHAPTER = <current chapter>
    NEXT_CHAPTER = <next chapter>
    SPECIALIZATION = <specialization>

These values are runtime context for the current migration. Do not write them into this template.

## Canonical repository identity and path resolution

Bootstrap operates on the canonical AIP Mirror repository:

    REPOSITORY_ROOT = https://github.com/paulhuman/aip-mirror

The canonical project branch is:

    main

All repository-relative paths used by this bootstrap procedure MUST be resolved from REPOSITORY_ROOT on main unless the path is explicitly given as an absolute filesystem path, URL, or qualified repository reference.

For an internal canonical reference, use:

    paulhuman/aip-mirror@main:/.ai/rules/workflow.md

For historical or reproducibility-sensitive references, the branch, tag, or commit MUST be explicit, for example:

    paulhuman/aip-mirror@<commit-sha>:/docs/handoffs/03AK-Architecture-Research.md

The bootstrap AI MUST NOT resolve .ai/..., docs/..., or other unqualified repository paths from its current working directory, another repository, an attachment, or conversational context.

**Bootstrap ordering requirement:** this repository identity/path rule MUST be established before the AI attempts to read any .ai/... path. The first repository-controlled document read after this bootstrap template must therefore be docs/PROJECT-INSTRUCTIONS.md from REPOSITORY_ROOT, followed by the applicable .ai/... rules and skills.

If a referenced repository-relative path cannot be resolved from REPOSITORY_ROOT, bootstrap MUST stop and report the unresolved reference rather than guessing.

## Repository write-capability self-check

Before executing the repository-mutating parts of bootstrap, the AI MUST determine which capability branch applies:

- **WRITE-CAPABLE AI** — the AI has a working mechanism that can create/update repository files and create commits in the target repository.
- **READ-ONLY AI** — the AI can inspect repository contents but cannot create/update repository files or create commits.
- **UNCERTAIN** — if the AI cannot reliably establish that repository writes and commits are available and working, it MUST treat itself as **READ-ONLY AI** for this bootstrap.

After this self-check:

- Follow **exactly one** capability branch below.
- A WRITE-CAPABLE AI MUST follow the WRITE-CAPABLE branch and MUST ignore the READ-ONLY branch.
- A READ-ONLY AI MUST follow the READ-ONLY branch and MUST ignore all repository-write instructions in the WRITE-CAPABLE branch.
- An AI MUST NOT claim that a repository write, lifecycle transition, commit, or bootstrap completion occurred unless it actually performed and verified that operation.

## Required procedure

### Shared bootstrap steps — all AI

When a new chapter is initialized, all AI MUST:

1. Confirm the new chapter identity and specialization from the bootstrap message.
2. Read this file.
3. Read the applicable project rules, especially `.ai/rules/conversation-lifecycle.md`, `.ai/rules/workflow.md`, and `.ai/rules/handoff-references.md`.
4. Read the previous chapter's handoff under `docs/handoffs/`.
5. Inspect the current implementation files and references identified by that handoff.
6. Confirm that the new chapter can continue from the recorded state without guessing.

### Branch A — WRITE-CAPABLE AI

**A WRITE-CAPABLE AI MUST read and execute this branch and MUST ignore Branch B.**

7. Immediately create the new chapter's handoff under `docs/handoffs/` with status `DRAFT` **if it does not already exist**.
8. Commit that initial `DRAFT` handoff as part of bootstrap; this is a pre-authorized procedural commit and does not require a separate approval step **when normal initial creation is applicable**.
9. Update the previous chapter's handoff from `READY_FOR_HANDOFF` to `HANDED_OFF`.
10. Commit that lifecycle transition.
11. Perform the mandatory post-bootstrap consistency verification described below.
12. Only after bootstrap is complete, proceed with new implementation or other chapter work.

If the receiving handoff already exists when bootstrap begins, do **not** recreate it or pretend that normal initial creation occurred. Determine whether the existing state represents a qualifying pre-existing lifecycle violation. If so, bootstrap must be treated as blocked and the receiving chapter must wait for explicit user authorization before performing Lifecycle Recovery.

### Branch B — READ-ONLY AI

**A READ-ONLY AI MUST read and execute this branch and MUST ignore Branch A.**

7. Do **not** create, update, or commit any repository file.
8. If the receiving handoff already exists, do **not** overwrite or normalize it.
9. Prepare the complete proposed receiving handoff with status `DRAFT`, using the standard handoff structure and all information that can be verified from the repository and current conversation.
10. Return the **entire handoff file content** to the user as plain Markdown so the user can place it in `docs/handoffs/` manually.
11. Provide the exact commit message that should be used for the manual initial-DRAFT commit.
12. Do **not** provide the separate bootstrap instruction for the next chat in the same response. A read-only AI MUST keep its response focused on the complete handoff file and its manual commit message so that constrained interfaces are not unnecessarily burdened by a second long artifact.
13. Do not claim `DRAFT` creation, `HANDED_OFF`, a commit, post-bootstrap verification, or `BOOTSTRAP = COMPLETE` because those repository operations were not performed by the AI.
14. The user is responsible for applying the supplied handoff file and completing the required repository lifecycle writes manually before treating bootstrap as complete.

For a READ-ONLY AI, the supplied handoff is a proposed repository state, not evidence that the repository already contains that state.

If the previous handoff is `READY_FOR_HANDOFF`, the READ-ONLY AI may state that the manual bootstrap must subsequently perform the corresponding `READY_FOR_HANDOFF` → `HANDED_OFF` lifecycle update, but it MUST NOT present that transition as completed.

If the receiving handoff already exists and indicates a qualifying pre-existing lifecycle violation, the READ-ONLY AI must report the blocked condition and MUST NOT attempt Lifecycle Recovery.

If the new chapter is the first chapter of a specialization, there is no previous handoff to mark `HANDED_OFF`.

For a WRITE-CAPABLE AI, the first chapter of a specialization still requires immediate creation and commit of the new chapter's `DRAFT` handoff, followed by the applicable post-bootstrap consistency verification.

For a READ-ONLY AI, the first chapter case follows Branch B: prepare and return the complete proposed `DRAFT` handoff and its manual initial-DRAFT commit message, without performing repository writes.

If the receiving handoff already exists when bootstrap begins, no AI may recreate it or pretend that normal initial creation occurred. Determine whether the existing state represents a qualifying pre-existing lifecycle violation. A WRITE-CAPABLE AI must block and wait for explicit user authorization before performing Lifecycle Recovery. A READ-ONLY AI must report the blocked condition and must not attempt Lifecycle Recovery.

## Why handoffs exist

A conversation is a finite AI working context, not a durable execution environment. Handoffs exist to preserve project continuity when work moves from one bounded conversation to another.

A chapter may need to continue in a new conversation because of:

- a large accumulation of conversation history;
- approaching context limits;
- degradation of reasoning quality as context becomes large or distant;
- increasing risk of hallucination or reconstruction from incomplete context;
- browser or conversation instability;
- the need for a clean new conversation context;
- the need to preserve durable project state independently of the health or availability of the old conversation.

The repository handoff state must therefore outlive the conversation that created it. No old conversation or specialization is required to remain available in order for a later chapter to reconstruct or correct canonical handoff state.

## Lifecycle Recovery

`Lifecycle Recovery` is a bounded procedure for a receiving chapter whose bootstrap is blocked by a pre-existing lifecycle violation.

The governing principle is:

> **Detection does not imply authorization.**

The receiving chapter must stop when it detects a qualifying violation and report the inconsistency. It must not infer permission to repair the repository merely because the correct repair appears obvious.

Recovery is permitted only when all of these conditions are satisfied:

1. the current conversation is the receiving chapter;
2. bootstrap is not complete;
3. the violation was detected before the current chapter performed any lifecycle transition;
4. the violation existed in the repository before the current chapter's bootstrap began;
5. the violation directly concerns the handoff/lifecycle state of the current migration;
6. the required recovery is unambiguous under the canonical lifecycle rules;
7. the user explicitly authorizes recovery with the temporary compatibility command:

       Пора восстановить handoff

If any condition is not satisfied, RECOVERY is prohibited.

The command is valid only in this blocked recovery context. It is not a general-purpose handoff repair command.

### Recovery invariants

RECOVERY is not an ordinary lifecycle transition. It may change only the minimum repository state required to restore canonical bootstrap preconditions for the current receiving chapter.

RECOVERY must:

- never rewrite Git history;
- never use reset, force-push, or equivalent history rewriting to erase the violation;
- never change conversational identity;
- never recreate an already existing receiving handoff merely to simulate initial creation;
- never repeat a lifecycle transition that has already occurred;
- never introduce, remove, skip, or reinterpret lifecycle transitions except where this recovery procedure explicitly permits it;
- never repair unrelated or newly discovered violations;
- preserve correct existing repository state when no correction is necessary;
- use the minimum necessary repository changes;
- verify repository state and relevant Git history before changing anything;
- verify the resulting lifecycle state before declaring recovery complete.

If an existing repository state already satisfies the required final lifecycle condition, RECOVERY must not perform a redundant transition merely to establish or simulate ownership provenance.

For example, if the previous handoff is already `HANDED_OFF` because of a pre-existing violation, the receiving chapter must not repeat `READY_FOR_HANDOFF` → `HANDED_OFF`. If that terminal state is otherwise correct, it may be accepted as the existing state.

### Recovery procedure

After the explicit user recovery command, the receiving chapter must:

1. re-check repository state and relevant Git history before making changes;
2. confirm that the observed violation still matches the qualifying pre-existing recovery scenario;
3. stop and report a new inconsistency if the state changed or recovery is no longer unambiguous;
4. adopt and normalize its own pre-existing receiving handoff as the canonical `DRAFT` handoff rather than pretending that it was newly created during bootstrap;
5. preserve valid checkpoint and architectural context while making only minimum corrections required by the canonical handoff structure;
6. inspect the previous handoff's current status and do not repeat any lifecycle transition already performed;
7. accept an already-correct `HANDED_OFF` previous handoff without creating a redundant transition;
8. make only the minimum repository changes required for recovery;
9. verify every changed file, the diff, and changed-file scope before committing;
10. create only the recovery commit(s) actually required by the changes, using the commit-message rules and clearly identifying lifecycle recovery;
11. verify the resulting repository state and lifecycle pair;
12. declare `RECOVERY = COMPLETE` only after those checks succeed;
13. continue to the normal post-bootstrap consistency verification before declaring `BOOTSTRAP = COMPLETE` or beginning substantive work.

Recovery does not erase the original violation. Git history remains the authoritative record of what happened.

## Lifecycle Correction

`Lifecycle Correction` is a separate, explicitly authorized procedure for repairing an already-existing historical handoff inconsistency that is discovered after the normal lifecycle moment has passed.

The governing principle remains:

> **Detection does not imply authorization.**

A lifecycle correction is appropriate when all of the following are true:

1. the violation is already present in repository state;
2. the historical lifecycle event that should have caused the correction has already occurred;
3. the canonical correct state can be determined unambiguously;
4. the current active chapter/specialization is capable of performing a bounded correction without relying on the old conversation;
5. the correction does not require rewriting or erasing Git history;
6. the correction scope is limited to the identified lifecycle inconsistency and directly required audit/verification updates;
7. the user explicitly authorizes the correction with:

       Пора выполнить handoff lifecycle correction

If any condition is not satisfied, CORRECTION is prohibited.

The correction command is not a normal lifecycle transition and is not interchangeable with `Пора восстановить handoff`.

### Correction ownership

The current active chapter/specialization that discovers the violation and can determine and execute the bounded correction under the canonical lifecycle rules owns the correction.

The chapter that originally caused or failed to perform the historical transition does not automatically retain correction ownership. An old conversation is not required for correction and must not be treated as a prerequisite.

Detection does not grant permission. The detecting chapter must first report:

- the historical violation;
- the canonical state that should exist;
- why the correction is unambiguous;
- why the current chapter has ownership and capability to perform it;
- the exact bounded repository scope;
- how historical traceability will be preserved.

It must then wait for the explicit user correction command.

### Correction invariants

CORRECTION must:

- never rewrite, delete, reset, force-push, or otherwise conceal Git history;
- never pretend that the missed historical transition happened at its original historical time;
- never skip lifecycle states in the recorded history;
- preserve the fact that the original lifecycle violation occurred;
- change only the minimum repository state required to restore the canonical recorded state;
- be limited to the identified lifecycle inconsistency and directly necessary audit/verification information;
- never repair unrelated violations merely because they are discovered during correction;
- never require the original chapter or conversation to remain available;
- verify repository state and relevant Git history before changing anything;
- verify every changed file, the resulting diff, and changed-file scope before committing;
- verify the corrected lifecycle chain after the correction;
- create an explicit Git commit for the correction;
- use the project's commit-message rules and clearly identify the commit as a lifecycle correction;
- retain the original violating commits in Git history.

A correction restores the repository's current canonical state; it does not rewrite the historical sequence that led to the inconsistency.

### Correction procedure

After explicit user authorization, the active correcting chapter must:

1. re-check the current repository state and relevant Git history;
2. confirm that the reported violation still exists and that the correction remains within the previously reported scope;
3. confirm the canonical expected state from the lifecycle rules and the historical evidence;
4. stop if the repository has changed in a way that makes the correction ambiguous or broader than the authorized scope;
5. modify only the handoff state and directly required audit/verification content within the approved correction scope;
6. read back every changed file from the repository;
7. verify that unrelated content was preserved;
8. inspect the resulting diff and changed-file scope;
9. verify the corrected lifecycle chain, including all relevant predecessor and successor handoffs, not merely the immediate pair;
10. create the correction commit with a clear lifecycle-correction message;
11. verify the resulting commit/ref and repository state;
12. declare `CORRECTION = COMPLETE` only after all checks succeed.

For a missed `HANDED_OFF` → `SUPERSEDED` transition, the correction must record the affected older handoff as `SUPERSEDED` while preserving the historical commits that show the transition was missed. The corrective commit is the audit trail of the later correction; it must not be presented as the original lifecycle transition.

## Post-bootstrap consistency verification

Bootstrap is not complete merely because the receiving handoff was created and the previous handoff was transitioned to `HANDED_OFF`.

Before beginning substantive chapter work, the receiving chapter must verify the resulting lifecycle state as a coherent chain, not only an immediate pair:

1. Read back the receiving chapter's own handoff after normal creation or authorized recovery.
2. Confirm that its own handoff still has `Status: DRAFT`.
3. Confirm that its `Previous chapter` identifies the handoff from which it actually started.
4. Confirm that its `Immediate next task` describes the first real task after bootstrap, not an action already completed as part of bootstrap or recovery.
5. If a previous handoff exists, read it back after the normal `READY_FOR_HANDOFF` → `HANDED_OFF` transition or authorized recovery.
6. Confirm that the previous handoff is now `HANDED_OFF`.
7. Confirm that the previous and receiving handoffs form a consistent lifecycle pair.
8. Inspect the relevant earlier handoff for the same specialization when one exists.
9. If a predecessor handoff is `HANDED_OFF` even though the current receiving handoff has already replaced it, treat that as a lifecycle-chain inconsistency and stop/report rather than silently repairing it.
10. If any check fails, treat bootstrap as incomplete. Correct only the receiving chapter's own handoff when the correction is within normal ownership or explicitly authorized recovery scope; otherwise stop and report the inconsistency.

The receiving chapter owns correction of its own handoff. Another specialization may detect and report an inconsistency, but must not edit the receiving chapter's handoff on its behalf.

Recovery completion is not itself bootstrap completion and does not by itself authorize substantive work.

## Initial DRAFT handoff

The initial handoff must use the standard handoff structure from the `conversation-handoff` skill unless a project-specific format requires otherwise and must contain, at minimum:

- conversation/chapter identity;
- specialization;
- previous chapter;
- `Status: DRAFT`;
- starting objective;
- known starting implementation state;
- relevant files and references;
- important constraints;
- confirmed versus inferred versus assumed information;
- immediate next task;
- recommended starting context.

The initial handoff is intentionally a live checkpoint document. It may be incomplete at bootstrap and must be updated during the chapter as meaningful state accumulates.

## Checkpoint command

During the chapter, the user may say:

    Пора обновить handoff

Treat this as a direct request to update the current handoff while keeping `Status: DRAFT`, verify it, and commit the checkpoint as part of the established handoff workflow.

These commits are **checkpoint commits**, not migration commits.

## Migration completion

When the user explicitly requests migration to `NEXT_CHAPTER`, the current chapter must:

1. finish the current work as appropriate;
2. update and finalize its handoff;
3. change `DRAFT` → `READY_FOR_HANDOFF`;
4. before declaring that transition complete, apply the `READY_FOR_HANDOFF supersession invariant` from the conversation lifecycle rules: if a previous same-specialization handoff is `HANDED_OFF`, change it to `SUPERSEDED` and physically verify both states;
5. verify the repository change and commit the transition;
6. generate the bootstrap message for the receiving chapter using this static procedure.

The receiving chapter later changes the previous handoff `READY_FOR_HANDOFF` → `HANDED_OFF` after successful bootstrap and post-bootstrap consistency verification.

When the receiving chapter's own handoff eventually reaches `READY_FOR_HANDOFF`, that later chapter must also change the older `HANDED_OFF` handoff for the same specialization to `SUPERSEDED` and commit that transition. This historical transition is mandatory when its condition is met.
