---
name: handoff
description: Create a durable state snapshot when a conversation approaches a contextual limit, reaches a major milestone, or is being continued in a new chapter.
---

# Conversation handoff

Use this skill to preserve the working state of a conversation before continuing in a new chapter.

The goal is continuity without requiring the next conversation to reconstruct important state from an old chat.

## Repository paths

Repository identity and path resolution are owned by `.ai/rules/repository.md`. This skill does not redefine those rules.

## When to use

Use this skill when:

- contextual risk is becoming significant;
- the user asks to continue in a new chapter;
- a major milestone has been reached;
- the current conversation is becoming very long or technically dense;
- important working state exists only in the conversation.

DO NOT create a handoff for every ordinary message.

## Important limitation

DO NOT claim to know an exact remaining context percentage or exact number of remaining messages.

Use qualitative contextual-risk assessment instead.

## Repository write-capability self-check

Before any handoff operation that could modify the repository, the AI MUST determine which capability applies:

- **WRITE-CAPABLE AI** — the AI can create/update repository files and create commits in the target repository.
- **READ-ONLY AI** — the AI can inspect repository contents but cannot create/update repository files or create commits.
- **UNCERTAIN** — if write capability cannot be reliably established, treat the AI as READ-ONLY AI.

Follow exactly one capability branch in the relevant handoff procedure. A WRITE-CAPABLE AI MUST ignore READ-ONLY instructions; a READ-ONLY AI MUST ignore repository-write instructions.

An AI MUST NOT claim a repository operation or lifecycle transition occurred unless it actually performed and verified it.

## Output location

Create or update the applicable file under:

    .ai/handoffs/<specialization>/

Naming convention:

    <chapter>-<short-name>.md

The Chapter Identifier Format is defined canonically by `.ai/rules/handoff/lifecycle.md`.

Use that rule for the exact identifier format and sequence; this skill only uses the identifier when naming and operating on handoff files.

## Handoff structure

Use this canonical structure for every handoff:

    # Conversation Handoff

    **Conversation:**
    <chapter> — <short conversation title>

    **Specialization:**
    <A-Z>

    **Chapter:**
    <000-999>

    **Previous chapter:**
    <previous chapter number or N/A>

    **Status:**
    DRAFT

Header field rules:

- `Conversation` contains the full chapter identifier followed by the short conversation title.
- DO NOT include the project name prefix in `Conversation`.
- `Specialization` contains only the specialization letter.
- `Chapter` contains only the three-digit chapter number.
- `Previous chapter` contains only the previous chapter's three-digit number, or `N/A` when this is the first chapter in the specialization.
- DO NOT include the specialization letter in the `Chapter` or `Previous chapter` field.
- Use bold Markdown (`**...:**`) for every header field name exactly as shown above.
- The full chapter identifier is formed from `Specialization` + `Chapter`; for example, `E` + `001` = `E001`.
- The handoff filename uses the full chapter identifier: `<chapter>-<short-name>.md`.

Example:

    # Conversation Handoff

    **Conversation:**
    E001 — Independent Review (Qwen)

    **Specialization:**
    E

    **Chapter:**
    001

    **Previous chapter:**
    000

    **Status:**
    HANDED_OFF

## Lifecycle rules

Handoff lifecycle state, transition ownership, Lifecycle Recovery, and Lifecycle Correction are canonically defined by `.ai/rules/handoff/lifecycle.md`.

This skill does not redefine those lifecycle rules. When a handoff operation depends on lifecycle state or transition ownership, follow the canonical lifecycle rule and use the operational procedures in this skill and `.ai/workflows/handoff/BOOTSTRAP.md` to execute and verify the action.

## New chapter initialization

New chapter initialization is operationally defined by `.ai/workflows/handoff/BOOTSTRAP.md`.

This skill provides the handoff capability and structure; it does not duplicate the bootstrap procedure. When a new chapter is initialized, follow the applicable capability branch and verification sequence in BOOTSTRAP.md.

## Checkpoint updates

A handoff in `DRAFT` is a live checkpoint document for the current chapter.

The user MAY request a checkpoint update with:

    Пора обновить handoff

When this command is used:

### WRITE-CAPABLE AI

A WRITE-CAPABLE AI MUST:

1. create the handoff if it does not yet exist;
2. update it with the current chapter state;
3. keep its status as `DRAFT`;
4. verify the resulting content and scope;
5. commit the checkpoint without asking for separate user permission.

### READ-ONLY AI

A READ-ONLY AI MUST:

1. not create, update, or commit any repository file;
2. prepare the complete proposed handoff with status `DRAFT`;
3. return the entire handoff file content to the user;
4. provide the exact manual checkpoint commit message;
5. not claim that the checkpoint was written or committed.

Checkpoint commits are not migrations. They are ordinary, auditable `DRAFT` checkpoint commits that preserve the current working state.

Checkpoint updates MAY be repeated throughout the chapter. A checkpoint SHOULD be created when meaningful state has accumulated, not after every ordinary message.

## Migration

When the user requests migration to the next chapter, for example:

    Пора выполнить миграцию в следующий chapter

first perform the repository write-capability self-check above.

### WRITE-CAPABLE AI migration branch

A WRITE-CAPABLE AI MUST finish the current work, update the current handoff, and move it from `DRAFT` to `READY_FOR_HANDOFF` only when the next chapter can continue without guessing.

The current chapter owns this transition and MUST commit it.

After that, generate the standard bootstrap instruction for the receiving chapter using `.ai/workflows/handoff/BOOTSTRAP.md`.

DO NOT mark the handoff `HANDED_OFF` in the closing chapter.

### READ-ONLY AI migration branch

A READ-ONLY AI MUST NOT modify or commit the repository.

Instead, it MUST prepare the complete current handoff as it should exist for migration, including `DRAFT` → `READY_FOR_HANDOFF` only as the **proposed manual repository state** when that transition is appropriate. It must return the entire proposed handoff file content to the user and provide the exact commit message for the manual handoff update.

A READ-ONLY AI MUST NOT claim that the handoff was changed to `READY_FOR_HANDOFF` or that any commit occurred.

A READ-ONLY AI MUST NOT append the separate bootstrap instruction to this long handoff response. If the user needs the missing bootstrap instruction, use the explicit `Пора выдать bootstrap-инструкцию` command separately.

A READ-ONLY AI MAY identify the lifecycle transition(s) that the user must apply manually, but MUST NOT represent those transitions as completed.

### Common migration rule

No migration branch MAY mark the handoff `HANDED_OFF` in the closing chapter.

### Bootstrap instruction recovery command

The standard migration workflow MUST generate the bootstrap instruction for the future receiving chapter. If the AI completed or discussed the migration but forgot to provide that instruction, the user may explicitly issue:

    Пора выдать bootstrap-инструкцию

Treat this as a direct request to generate the missing bootstrap instruction for the receiving chapter using `.ai/workflows/handoff/BOOTSTRAP.md`.

This command does **not** initialize the next chapter, does **not** change lifecycle state, and does **not** authorize repository writes by itself.

The generated instruction must contain the required runtime values for the receiving chapter:

    PREVIOUS_CHAPTER = <previous chapter>
    CURRENT_CHAPTER = <current chapter>
    SPECIALIZATION = <specialization>

The instruction is for a future receiving conversation. It must not be presented as evidence that the receiving chapter has already started.

This command MAY be used both by WRITE-CAPABLE and READ-ONLY AI. A READ-ONLY AI MUST generate only the bootstrap instruction requested by this command and MUST NOT claim that the receiving chapter was initialized or that any repository lifecycle operation occurred.

## Writing rules

Be concrete.

Prefer:

    A component in `src/...` currently handles input tracking.

over:

    "We worked on the mirror tool."

Record decisions and their rationale when that rationale matters to future work.

Record unresolved questions rather than inventing answers.

DO NOT hide uncertainty.

DO NOT copy the entire conversation into the handoff.

DO NOT duplicate stable project documentation unnecessarily.

## Project knowledge versus conversation state

Put durable project knowledge in the appropriate project documentation.

Use the handoff for temporary or chapter-specific state such as:

- what was being investigated;
- what was just changed;
- what remains unfinished;
- what the next chapter should do first;
- which conversation-specific assumptions still need validation.

## Before marking READY_FOR_HANDOFF

Verify that the handoff answers:

1. What were we trying to accomplish?
2. What is already complete?
3. What is the current state of the implementation?
4. What decisions were made?
5. What remains unresolved?
6. Where are the relevant files?
7. What should happen next?
8. Which statements are confirmed versus uncertain?

Only mark the handoff `READY_FOR_HANDOFF` when the next chapter can reasonably continue without guessing and the previous same-specialization handoff, when applicable, is already verified as `HANDED_OFF`.

## Receiving a handoff

Receiving-chapter bootstrap is operationally defined by `.ai/workflows/handoff/BOOTSTRAP.md`.

This skill does not duplicate the bootstrap branches, Lifecycle Recovery, Lifecycle Correction, or post-bootstrap verification procedure. After bootstrap, use this skill for the ongoing handoff capability and checkpoint/migration operations.
