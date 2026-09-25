---
name: conversation-handoff
description: Create a durable state snapshot when an AIP Mirror conversation approaches a contextual limit, reaches a major milestone, or is being continued in a new chapter.
---

# Conversation handoff

Use this skill to preserve the working state of an AIP Mirror conversation before continuing in a new chapter.

The goal is continuity without requiring the next conversation to reconstruct important state from an old chat.

## Repository paths

Repository identity and path resolution are owned by `.ai/rules/repository.md`. This skill does not redefine those rules.

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

## When to use

Use this skill when:

- contextual risk is becoming significant;
- the user asks to continue in a new chapter;
- a major milestone has been reached;
- the current conversation is becoming very long or technically dense;
- important working state exists only in the conversation.

Do not create a handoff for every ordinary message.

## Important limitation

Do not claim to know an exact remaining context percentage or exact number of remaining messages.

Use qualitative contextual-risk assessment instead.

## Repository write-capability self-check

Before any handoff operation that could modify the repository, the AI MUST determine which capability applies:

- **WRITE-CAPABLE AI** — the AI can create/update repository files and create commits in the target repository.
- **READ-ONLY AI** — the AI can inspect repository contents but cannot create/update repository files or create commits.
- **UNCERTAIN** — if write capability cannot be reliably established, treat the AI as READ-ONLY AI.

Follow exactly one capability branch in the relevant handoff procedure. A WRITE-CAPABLE AI must ignore READ-ONLY instructions; a READ-ONLY AI must ignore repository-write instructions.

An AI must never claim a repository operation or lifecycle transition occurred unless it actually performed and verified it.

## Output location

Create or update the applicable file under:

    .ai/handoffs/<specialization>/

Naming convention:

    <chapter>-<short-name>.md

The current generic chapter identifier is:

    [0-9]{2}[A-Z]{2}

The final two uppercase letters form a continuous base-26 alphabetical sequence:

    AA → AB → ... → AZ → BA → BB → ... → BZ → CA → ... → ZZ

No letters are skipped.

The sequence is positional and mathematical:

    AA = chapter ordinal 1
    AB = chapter ordinal 2
    AC = chapter ordinal 3
    ...
    AE = chapter ordinal 5
    AF = chapter ordinal 6
    ...
    ZZ = chapter ordinal 676

## Handoff structure

Use this structure unless a project-specific format requires otherwise:

    # Conversation Handoff

    Conversation:
    AIP Mirror — XXYY — <Specialization>

    Specialization:
    <01 / 02 / 03 / 04>

    Chapter:
    <AA / AB / AC / ... / ZZ>

    Previous chapter:
    <chapter or N/A>

    Status:
    DRAFT

    ## Current objective

    ## Completed

    ## Current implementation state

    ## Decisions

    ## Open questions

    ## Current files

    ## Relevant references

    ## Important constraints

    ## Evidence / confidence

    ### Confirmed / observed

    ### Inferred

    ### Assumed / unverified

    ### Open

    ## Last completed task

    ## Immediate next task

    ## Things not to redo

    ## Recommended starting context for next chapter

## Lifecycle rules

Handoff lifecycle state, transition ownership, Lifecycle Recovery, and Lifecycle Correction are canonically defined by `.ai/rules/handoff/lifecycle.md`.

This skill does not redefine those lifecycle rules. When a handoff operation depends on lifecycle state or transition ownership, follow the canonical lifecycle rule and use the operational procedures in this skill and `.ai/workflows/handoff-bootstrap/BOOTSTRAP.md` to execute and verify the action.

## New chapter initialization

When a new chapter is initialized, a WRITE-CAPABLE AI must immediately create its own handoff file with status `DRAFT`.

This is mandatory for every new chapter, including the first chapter of a specialization and every later alphabetical chapter.

The new chapter may create this initial `DRAFT` handoff without asking the user for permission. The initialization is part of the standard bootstrap procedure, not an optional development change.

A READ-ONLY AI must not create or overwrite the repository file. It must instead prepare the complete proposed initial `DRAFT` handoff and provide the exact manual commit message, following the READ-ONLY branch in `.ai/workflows/handoff-bootstrap/BOOTSTRAP.md`.

If a pre-existing receiving handoff is discovered during bootstrap, do not silently recreate or overwrite it as though it were a normal initial-DRAFT creation. Apply the lifecycle rules and, if the bootstrap is blocked by a qualifying pre-existing violation, wait for the explicit Lifecycle Recovery command before making recovery changes.

The initial handoff must capture the chapter identity, previous chapter, starting objective, known starting state, and any other information already established during bootstrap. It may be incomplete because its purpose is to become the live checkpoint document for the new chapter.

A WRITE-CAPABLE AI must commit the initial creation immediately. This is an explicit exception to the normal user-review-before-commit rule for AI-assisted changes.

## Checkpoint updates

A handoff in `DRAFT` is a live checkpoint document for the current chapter.

The user may request a checkpoint update with:

    Пора обновить handoff

When this command is used:

### WRITE-CAPABLE AI

A WRITE-CAPABLE AI must:

1. create the handoff if it does not yet exist;
2. update it with the current chapter state;
3. keep its status as `DRAFT`;
4. verify the resulting content and scope;
5. commit the checkpoint without asking for separate user permission.

### READ-ONLY AI

A READ-ONLY AI must:

1. not create, update, or commit any repository file;
2. prepare the complete proposed handoff with status `DRAFT`;
3. return the entire handoff file content to the user;
4. provide the exact manual checkpoint commit message;
5. not claim that the checkpoint was written or committed.

Checkpoint commits are not migrations. They are ordinary, auditable `DRAFT` checkpoint commits that preserve the current working state.

Checkpoint updates may be repeated throughout the chapter. A checkpoint should be created when meaningful state has accumulated, not after every ordinary message.

## Migration

When the user requests migration to the next chapter, for example:

    Пора выполнить миграцию в чат 02AB

first perform the repository write-capability self-check above.

### WRITE-CAPABLE AI migration branch

A WRITE-CAPABLE AI must finish the current work, update the current handoff, and move it from `DRAFT` to `READY_FOR_HANDOFF` only when the next chapter can continue without guessing.

The current chapter owns this transition and must commit it.

Before declaring `DRAFT` → `READY_FOR_HANDOFF` complete, apply the `READY_FOR_HANDOFF supersession invariant` above. If a previous same-specialization handoff is `HANDED_OFF`, it must be changed to `HANDED_OFF` and physically verified before the migration transition is considered complete.

After that, generate the standard bootstrap instruction for the receiving chapter using `.ai/workflows/handoff-bootstrap/BOOTSTRAP.md`.

Do not mark the handoff `HANDED_OFF` in the closing chapter.

### READ-ONLY AI migration branch

A READ-ONLY AI must not modify or commit the repository.

Instead, it must prepare the complete current handoff as it should exist for migration, including `DRAFT` → `READY_FOR_HANDOFF` only as the **proposed manual repository state** when that transition is appropriate. It must return the entire proposed handoff file content to the user and provide the exact commit message for the manual handoff update.

A READ-ONLY AI must not claim that the handoff was changed to `READY_FOR_HANDOFF`, that any supersession transition was performed, or that any commit occurred.

A READ-ONLY AI must not append the separate bootstrap instruction to this long handoff response. If the user needs the missing bootstrap instruction, use the explicit `Пора выдать bootstrap-инструкцию` command separately.

A READ-ONLY AI may identify the lifecycle transition(s) that the user must apply manually, but must not represent those transitions as completed.

### Common migration rule

No migration branch may mark the handoff `HANDED_OFF` in the closing chapter.

### Bootstrap instruction recovery command

The standard migration workflow must generate the bootstrap instruction for the future receiving chapter. If the AI completed or discussed the migration but forgot to provide that instruction, the user may explicitly issue:

    Пора выдать bootstrap-инструкцию

Treat this as a direct request to generate the missing bootstrap instruction for the receiving chapter using `.ai/workflows/handoff-bootstrap/BOOTSTRAP.md`.

This command does **not** initialize the next chapter, does **not** change lifecycle state, and does **not** authorize repository writes by itself.

The generated instruction must contain the required runtime values for the receiving chapter:

    CURRENT_CHAPTER = <current chapter>
    NEXT_CHAPTER = <next chapter>
    SPECIALIZATION = <specialization>

The instruction is for a future receiving conversation. It must not be presented as evidence that the receiving chapter has already started.

This command may be used both by WRITE-CAPABLE and READ-ONLY AI. A READ-ONLY AI must generate only the bootstrap instruction requested by this command and must not claim that the receiving chapter was initialized or that any repository lifecycle operation occurred.

## Writing rules

Be concrete.

Prefer:

    `src/.../MirrorTool.cpp` currently handles mouse tracking.

over:

    "We worked on the mirror tool."

Record decisions and their rationale when that rationale matters to future work.

Record unresolved questions rather than inventing answers.

Do not hide uncertainty.

Do not copy the entire conversation into the handoff.

Do not duplicate stable project documentation unnecessarily.

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

Also verify the `READY_FOR_HANDOFF supersession invariant` before declaring the transition complete.

Only mark the handoff `READY_FOR_HANDOFF` when the next chapter can reasonably continue without guessing and the previous same-specialization handoff, when applicable, is already verified as `HANDED_OFF`.

## Receiving a handoff

When a new chapter starts from a previous handoff, first read `.ai/workflows/handoff-bootstrap/BOOTSTRAP.md` and perform its repository write-capability self-check.

Then follow exactly one of the capability branches defined by BOOTSTRAP.md:

- A **WRITE-CAPABLE AI** performs the repository-writing bootstrap procedure and its post-bootstrap verification.
- A **READ-ONLY AI** performs only the read-only branch: it does not create, update, or commit repository files; it prepares the complete proposed receiving handoff with status `DRAFT` and provides the exact manual initial-DRAFT commit message to the user.
- An AI that cannot establish write capability must treat itself as READ-ONLY.

A READ-ONLY AI must not claim that `DRAFT` creation, `HANDED_OFF`, a commit, post-bootstrap verification, or `BOOTSTRAP = COMPLETE` occurred.

If a read-only bootstrap is being performed, do not append the separate bootstrap-instruction command to the handoff response. The complete handoff file and its manual commit message are the required output of the read-only bootstrap branch.

If the receiving handoff already exists, do not pretend that normal initial creation occurred. Apply the capability-specific rules in BOOTSTRAP.md. A qualifying pre-existing lifecycle violation blocks normal bootstrap; a READ-ONLY AI must report it and cannot perform Lifecycle Recovery.

If Lifecycle Recovery is authorized, follow the recovery procedure above. Do not repeat a lifecycle transition that the repository already contains in the required final state.

### Post-bootstrap consistency verification

The receiving chapter must verify the resulting state as a coherent lifecycle chain, not only an immediate pair, after both required bootstrap commits have completed or after authorized recovery where applicable.

At minimum:

1. read back the receiving chapter's own handoff;
2. confirm that its own status remains `DRAFT`;
3. confirm that `Previous chapter` identifies the handoff from which it actually started;
4. confirm that `Immediate next task` describes the first real task after bootstrap, not an action already completed during bootstrap or recovery;
5. read back the previous handoff after the lifecycle transition or authorized recovery;
6. confirm that the previous handoff is now `HANDED_OFF`;
7. confirm that the previous and receiving handoffs form a consistent lifecycle pair;
8. inspect the relevant earlier handoff for the same specialization when one exists;
9. if a predecessor handoff is `HANDED_OFF` even though the current receiving handoff has already replaced it, treat that as a lifecycle-chain inconsistency and stop/report rather than silently repairing it;
10. if any check fails, treat bootstrap as incomplete and correct only the receiving chapter's own handoff when the correction is within normal ownership or explicitly authorized recovery scope; otherwise stop and report the inconsistency;
11. re-read the corrected handoff and repeat the verification until it passes.

The receiving chapter owns correction of its own handoff. Another specialization may detect and report an inconsistency, but must not edit the receiving chapter's handoff on its behalf.

Bootstrap is complete only after this verification succeeds.

Recovery completion is not itself bootstrap completion and does not by itself authorize substantive work.

## After migration

A handoff remains `HANDED_OFF` after successful migration until a later handoff for the same specialization reaches `READY_FOR_HANDOFF`. At that point, the later chapter must update the older handoff to `HANDED_OFF` and commit that lifecycle transition. The later chapter must physically verify the handed off state before declaring its own `READY_FOR_HANDOFF` transition complete.

## Project Workshop boundary

The `04` specialization may help with IDE configuration, build systems, Git commands, repository mechanics, SDK/tooling setup, ChatGPT interface questions, and general development learning.

When a Workshop discussion produces a durable project decision, record it in the appropriate project documentation rather than leaving it only in the Workshop conversation.

Do not use `04` as a substitute for:

- `01` JSX behavioral prototyping;
- `02` native C++/AIP implementation;
- `03` architecture, research, specifications, or project-wide decisions.
