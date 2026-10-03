# Conversation continuity rules

These rules define chapter continuity and handoff context preservation.

## 1. Conversations are finite workspaces

A chat conversation is working context, not the durable memory of the project.

The repository is the durable project memory.

Important discoveries, decisions, specifications, implementation state, and handoff context MUST be captured in repository files.

## 2. Chapter naming

Each specialization uses a letter identity followed by a four-digit chapter number.

The Chapter Identifier Format is:

    [A-Z][0-9]{4}

Chapter numbering is one-based. The first chapter of a specialization is `0001`.
`0000` is not a valid chapter number. The sequence is `0001 → 0002 → 0003 ...`.

The specialization is the uppercase letter. The chapter number is the four-digit numeric component.

Bootstrap runtime inputs keep these components separate:

    CURRENT_CHAPTER = 0001
    SPECIALIZATION = A

The full identifier is derived as SPECIALIZATION + CURRENT_CHAPTER and is the canonical `CHAPTER_ID`.

    CHAPTER_ID = SPECIALIZATION + CURRENT_CHAPTER

`CHAPTER_ID` is the full chapter identifier and MUST be used wherever a chapter identifier is required. `CURRENT_CHAPTER` is only the numeric runtime component.

## 3. Handoff purpose

A handoff is a persistent conversation-context snapshot for a chapter.

It exists because a conversation may end, become too large, or otherwise cease to provide reliable working context.

A handoff MUST preserve enough information for the next chapter to continue without guessing.

Where applicable, record objective, completed work, implementation state, decisions, open questions, relevant files and references, constraints, assumptions, unresolved risks, last completed task, immediate next task, things that MUST NOT be redone, and recommended starting context.

A handoff MUST distinguish Confirmed / observed, Inferred, Assumed / unverified, and Open.

A handoff MUST NOT silently promote an inference or assumption into a confirmed project fact.

## 4. Handoff location

Conversation handoffs belong under .ai/handoffs/. Use one file per chapter:

    .ai/handoffs/<SPECIALIZATION>/<CHAPTER_ID>-<FILENAME_SHORT_NAME>.md

The filename uses the full `CHAPTER_ID`. `FILENAME_SHORT_NAME` is derived from `SHORT_NAME` by replacing every space with a hyphen. Handoff filenames MUST NOT be constructed from `CURRENT_CHAPTER` alone.

Example:

    SPECIALIZATION = A
    CURRENT_CHAPTER = 0001
    CHAPTER_ID = A0001
    SHORT_NAME = Project Workshop
    FILENAME_SHORT_NAME = Project-Workshop

    .ai/handoffs/A/A0001-Project-Workshop.md

Handoffs remain in the repository as historical context. No handoff state transition is required.

## 5. Recovery evidence and first-chapter rules

When repository evidence is required to recover `CURRENT_CHAPTER`, both of these locations are valid evidence sources:

    .ai/handoffs/<SPECIALIZATION>/
    .ai/archive/handoffs/<SPECIALIZATION>/

An active handoff and an archived handoff with the same semantic `Specialization` and `Chapter` identify one chapter. Their different locations DO NOT make them contradictory.

Recovery MUST validate the handoff header, not merely its path or filename. A valid candidate has:

    Specialization = current specialization
    Chapter = four-digit chapter number

Recovery MUST distinguish:

- **Active-only evidence** — valid candidate in the active handoff location.
- **Archive-only evidence** — valid candidate in the archive when no active candidate establishes the chapter.
- **Duplicate evidence** — active and archive copies of the same chapter.
- **Contradictory evidence** — candidates that cannot be reconciled into one valid chapter under sequential continuity.
- **No-handoff / first-chapter case** — no repository handoff exists. Absence alone does not establish a current chapter. The first valid chapter is `0001`; a migration assertion for `0002` MAY therefore validate candidate predecessor `0001` without requiring a predecessor handoff.

A recovery procedure MUST NOT select the numerically latest handoff merely because it is latest, and MUST NOT treat path location alone as proof of currentness.

If deterministic recovery is impossible, `CURRENT_CHAPTER` is UNKNOWN. After an explicit recovery STOP, a syntactically valid user-supplied `CURRENT_CHAPTER` becomes recovered conversation context. It MUST be checked against repository evidence when evidence exists, but lack of evidence MUST NOT cause the same STOP to repeat. Direct contradiction remains a STOP condition.

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

When the user requests migration: update the current handoff, commit that update, generate the bootstrap instruction for the future receiving chapter, and DO NOT modify the future receiving handoff or predecessor merely to mark it consumed.

The current conversation remains the current chapter until a new conversation actually executes bootstrap.

## 7. Contextual risk

There is no reliable user-visible counter for remaining context. Do not claim a precise percentage or message count.

Monitor conversation length, technical-state accumulation, distant-context reliance, chat-only decisions, and risk of reconstructing details from incomplete context.

When contextual risk becomes significant, warn the user and recommend updating the handoff.

## 8. Keep handoffs useful and lightweight

Do not create a handoff for every ordinary message. Do not copy the entire conversation. Do not duplicate stable project documentation unnecessarily.

Record concrete state and decisions that future work actually needs.

The handoff is durable context, not a second project documentation system.
