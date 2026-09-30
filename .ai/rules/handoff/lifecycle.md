# Conversation continuity rules

These rules define chapter continuity and handoff context preservation.

## 1. Conversations are finite workspaces

A chat conversation is working context, not the durable memory of the project.

The repository is the durable project memory.

Important discoveries, decisions, specifications, implementation state, and handoff context MUST be captured in repository files.

## 2. Chapter naming

Each specialization uses a letter identity followed by a three-digit chapter number.

The Chapter Identifier Format is:

    [A-Z][0-9]{3}

The specialization is the uppercase letter. The chapter number is the three-digit numeric component.

Bootstrap runtime inputs keep these components separate:

    CURRENT_CHAPTER = 034
    SPECIALIZATION = C

The full identifier is derived as SPECIALIZATION + CURRENT_CHAPTER.

## 3. Handoff purpose

A handoff is a persistent conversation-context snapshot for a chapter.

It exists because a conversation may end, become too large, or otherwise cease to provide reliable working context.

A handoff MUST preserve enough information for the next chapter to continue without guessing.

Where applicable, record objective, completed work, implementation state, decisions, open questions, relevant files and references, constraints, assumptions, unresolved risks, last completed task, immediate next task, things that MUST NOT be redone, and recommended starting context.

A handoff MUST distinguish Confirmed / observed, Inferred, Assumed / unverified, and Open.

A handoff MUST NOT silently promote an inference or assumption into a confirmed project fact.

## 4. Handoff location

Conversation handoffs belong under .ai/handoffs/. Use one file per chapter:

    .ai/handoffs/<specialization>/<chapter>-<short-name>.md

The filename uses the full chapter identifier.

Handoffs remain in the repository as historical context. No handoff state transition is required.

## 5. Handoff continuity

The receiving chapter creates its own handoff at the beginning of a new conversation.

The previous chapter MUST NOT create the receiving chapter handoff in advance.

The receiving chapter reads the predecessor handoff when one exists. Reading the predecessor does not require modifying it.

A current chapter SHOULD update its own handoff whenever meaningful durable context accumulates.

There is no required final handoff operation before a conversation ends. Conversation termination may be abrupt.

Handoff freshness is maintained by meaningful content updates, not by lifecycle transitions.

## 6. Checkpoints and migration

A handoff update is a normal content operation.

When the user requests a handoff checkpoint, update the current handoff with durable state that matters for future continuation and commit the update.

When the user requests migration: update the current handoff, commit that update, generate the bootstrap instruction for the future receiving chapter, and do not modify the future receiving handoff or predecessor merely to mark it consumed.

The current conversation remains the current chapter until a new conversation actually executes bootstrap.

## 7. Contextual risk

There is no reliable user-visible counter for remaining context. Do not claim a precise percentage or message count.

Monitor conversation length, technical-state accumulation, distant-context reliance, chat-only decisions, and risk of reconstructing details from incomplete context.

When contextual risk becomes significant, warn the user and recommend updating the handoff.

## 8. Keep handoffs useful and lightweight

Do not create a handoff for every ordinary message. Do not copy the entire conversation. Do not duplicate stable project documentation unnecessarily.

Record concrete state and decisions that future work actually needs.

The handoff is durable context, not a second project documentation system.
