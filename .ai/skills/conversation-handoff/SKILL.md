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
    04A-Project-Workshop.md

## Handoff structure

Use this structure unless a project-specific format requires otherwise:

    # Conversation Handoff

    Conversation:
    AIP Mirror — XXY — <Specialization>

    Specialization:
    <01 / 02 / 03 / 04>

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

## Lifecycle rules

Handoff status is a state machine, not an informal label:

    DRAFT
      ↓
    READY_FOR_HANDOFF
      ↓
    HANDED_OFF
      ↓
    SUPERSEDED

The valid forward transitions are:

- `DRAFT` → `READY_FOR_HANDOFF`
- `READY_FOR_HANDOFF` → `HANDED_OFF`
- `HANDED_OFF` → `SUPERSEDED`

Do not skip states.

### Ownership of transitions

The chapter that is closing prepares its handoff and may move it from `DRAFT` to `READY_FOR_HANDOFF` once the next chapter can continue without guessing.

The receiving chapter, not the previous chapter, owns the transition from `READY_FOR_HANDOFF` to `HANDED_OFF`. It must make this transition only after successfully starting from the previous handoff.

A later chapter owns the transition from `HANDED_OFF` to `SUPERSEDED` when a newer handoff for the same specialization replaces the older one.

The previous chapter must never mark its own handoff `HANDED_OFF` merely because the handoff was written, committed, or communicated.

`SUPERSEDED` is not an automatic migration status. It means that a later handoff has subsequently replaced the historical handoff.

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

Only mark the handoff `READY_FOR_HANDOFF` when the next chapter can reasonably continue without guessing.

## Receiving a handoff

When a new chapter starts from a previous handoff:

1. read the applicable project rules;
2. read the previous handoff;
3. inspect the current files identified by the handoff;
4. confirm that the new chapter can continue from the recorded state;
5. update the previous handoff status to `HANDED_OFF`;
6. commit that lifecycle transition using the `commit-message` skill.

Do not mark `HANDED_OFF` before the receiving chapter has actually started from the handoff.

## After migration

A handoff remains `HANDED_OFF` after successful migration until a later handoff for the same specialization replaces it. At that point, the later chapter may update the older handoff to `SUPERSEDED` and must commit that lifecycle transition.

## Project Workshop boundary

The `04` specialization may help with IDE configuration, build systems, Git commands, repository mechanics, SDK/tooling setup, ChatGPT interface questions, and general development learning.

When a Workshop discussion produces a durable project decision, record it in the appropriate project documentation rather than leaving it only in the Workshop conversation.

Do not use `04` as a substitute for:

- `01` JSX behavioral prototyping;
- `02` native C++/AIP implementation;
- `03` architecture, research, specifications, or project-wide decisions.
