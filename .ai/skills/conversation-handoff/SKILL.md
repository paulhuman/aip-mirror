---
name: conversation-handoff
description: Create a durable state snapshot when an AIP Mirror conversation approaches a contextual limit, reaches a major milestone, or is being continued in a new chapter.
---

# Conversation handoff

Use this skill to preserve the working state of an AIP Mirror conversation before continuing in a new chapter.

The goal is continuity without requiring the next conversation to reconstruct important state from an old chat.

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

## Output location

Create or update the applicable file under:

    docs/handoffs/

Naming convention:

    <specialization><chapter>-<short-name>.md

Examples:

    01A-JSX-Prototype.md
    02A-Native-AIP-Plugin.md
    03A-Architecture-Research.md

## Handoff structure

Use this structure unless a project-specific format requires otherwise:

    # Conversation Handoff

    Conversation:
    AIP Mirror — XXY — <Specialization>

    Specialization:
    <01 / 02 / 03>

    Chapter:
    <A / B / C / ...>

    Previous chapter:
    <chapter or N/A>

    Status:
    READY_FOR_HANDOFF

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

## Before closing the chapter

Verify that the handoff answers:

1. What were we trying to accomplish?
2. What is already complete?
3. What is the current state of the implementation?
4. What decisions were made?
5. What remains unresolved?
6. Where are the relevant files?
7. What should happen next?
8. Which statements are confirmed versus uncertain?

Only mark the handoff `READY_FOR_HANDOFF` when the next chapter can reasonably continue without guessing.

## After migration

When the next chapter has started successfully, the previous handoff may be marked `HANDED_OFF` or `SUPERSEDED` while remaining in the repository as historical state.
