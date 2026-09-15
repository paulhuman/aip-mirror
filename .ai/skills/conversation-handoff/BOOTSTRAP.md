# Conversation handoff bootstrap

This file is a static procedural template for initializing a new AIP Mirror conversation chapter.

It must not contain the identity of a specific current or next chapter. Actual chapter values are supplied by the bootstrap message that invokes this procedure.

## Bootstrap inputs

The bootstrap message supplies:

    CURRENT_CHAPTER = <current chapter>
    NEXT_CHAPTER = <next chapter>
    SPECIALIZATION = <specialization>

These values are runtime context for the current migration. Do not write them into this template.

## Required procedure

When a new chapter is initialized:

1. Confirm the new chapter identity and specialization from the bootstrap message.
2. Read this file.
3. Read the applicable project rules, especially `.ai/rules/conversation-lifecycle.md` and `.ai/rules/workflow.md`.
4. Read the previous chapter's handoff under `docs/handoffs/`.
5. Inspect the current implementation files and references identified by that handoff.
6. Confirm that the new chapter can continue from the recorded state without guessing.
7. Immediately create the new chapter's handoff under `docs/handoffs/` with status `DRAFT` **if it does not already exist**.
8. Commit that initial `DRAFT` handoff as part of bootstrap; this is a pre-authorized procedural commit and does not require a separate approval step **when normal initial creation is applicable**.
9. Update the previous chapter's handoff from `READY_FOR_HANDOFF` to `HANDED_OFF`.
10. Commit that lifecycle transition.
11. Perform the mandatory post-bootstrap consistency verification described below.
12. Only after bootstrap is complete, proceed with new implementation or other chapter work.

If the new chapter is the first chapter of a specialization, there is no previous handoff to mark `HANDED_OFF`; still create and commit the new chapter's `DRAFT` handoff immediately, then perform the applicable post-bootstrap consistency verification.

If the receiving handoff already exists when bootstrap begins, do **not** recreate it or pretend that normal initial creation occurred. Determine whether the existing state represents a qualifying pre-existing lifecycle violation. If so, bootstrap must be treated as blocked and the receiving chapter must wait for explicit user authorization before performing Lifecycle Recovery.

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

## Post-bootstrap consistency verification

Bootstrap is not complete merely because the receiving handoff was created and the previous handoff was transitioned to `HANDED_OFF`.

Before beginning substantive chapter work, the receiving chapter must verify the resulting lifecycle state as a coherent pair:

1. Read back the receiving chapter's own handoff after normal creation or authorized recovery.
2. Confirm that its own handoff still has `Status: DRAFT`.
3. Confirm that its `Previous chapter` identifies the handoff from which it actually started.
4. Confirm that its `Immediate next task` describes the first real task after bootstrap, not an action already completed as part of bootstrap or recovery.
5. If a previous handoff exists, read it back after the normal `READY_FOR_HANDOFF` → `HANDED_OFF` transition or authorized recovery.
6. Confirm that the previous handoff is now `HANDED_OFF`.
7. Confirm that the previous and receiving handoffs form a consistent lifecycle pair.
8. If any check fails, treat bootstrap as incomplete. Correct only the receiving chapter's own handoff when the correction is within normal ownership or explicitly authorized recovery scope; otherwise stop and report the inconsistency.

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
4. verify the repository change and commit the transition;
5. generate the bootstrap message for the receiving chapter using this static procedure.

The receiving chapter later changes the previous handoff `READY_FOR_HANDOFF` → `HANDED_OFF` after successful bootstrap and post-bootstrap consistency verification.

When the receiving chapter's own handoff eventually reaches `READY_FOR_HANDOFF`, that later chapter must also change the older `HANDED_OFF` handoff for the same specialization to `SUPERSEDED` and commit that transition. This historical transition is mandatory when its condition is met.
