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
7. Immediately create the new chapter's handoff under `docs/handoffs/` with status `DRAFT`.
8. Commit that initial `DRAFT` handoff as part of bootstrap; this is a pre-authorized procedural commit and does not require a separate approval step.
9. Update the previous chapter's handoff from `READY_FOR_HANDOFF` to `HANDED_OFF`.
10. Commit that lifecycle transition.
11. Perform the mandatory post-bootstrap consistency verification described below.
12. Only after bootstrap is complete, proceed with new implementation or other chapter work.

If the new chapter is the first chapter of a specialization, there is no previous handoff to mark `HANDED_OFF`; still create and commit the new chapter's `DRAFT` handoff immediately, then perform the applicable post-bootstrap consistency verification.

## Post-bootstrap consistency verification

Bootstrap is not complete merely because the receiving handoff was created and the previous handoff was transitioned to `HANDED_OFF`.

Before beginning substantive chapter work, the receiving chapter must verify the resulting lifecycle state as a coherent pair:

1. Read back the receiving chapter's own handoff after creation.
2. Confirm that its own handoff still has `Status: DRAFT`.
3. Confirm that its `Previous chapter` identifies the handoff from which it actually started.
4. Confirm that its `Immediate next task` describes the first real task after bootstrap, not an action already completed as part of bootstrap.
5. If a previous handoff exists, read it back after the `READY_FOR_HANDOFF` → `HANDED_OFF` transition.
6. Confirm that the previous handoff is now `HANDED_OFF`.
7. Confirm that the previous and receiving handoffs form a consistent lifecycle pair.
8. If any check fails, treat bootstrap as incomplete. Correct the receiving chapter's own handoff, re-read it, and repeat the verification before beginning substantive work.

The receiving chapter owns correction of its own handoff. Another specialization may detect and report an inconsistency, but must not edit the receiving chapter's handoff on its behalf.

## Initial DRAFT handoff

The initial handoff should use the standard handoff structure from the `conversation-handoff` skill and should contain, at minimum:

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
