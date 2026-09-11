# Conversation lifecycle rules

These rules define how AIP Mirror conversations are split into chapters and how work is handed from one conversation to the next.

## 1. Conversations are finite workspaces

A chat conversation is working context, not the durable memory of the project.

The repository is the durable project memory.

Do not rely on a long conversation remaining fully available forever. Important discoveries, decisions, specifications, implementation state, and handoff state must be captured in repository files.

## 2. Chapter naming

Each specialization uses a numeric identity followed by an alphabetical chapter letter:

    AIP Mirror — 01A — JSX Prototype
    AIP Mirror — 01B — JSX Prototype
    AIP Mirror — 01C — JSX Prototype

    AIP Mirror — 02A — Native AIP Plugin
    AIP Mirror — 02B — Native AIP Plugin
    AIP Mirror — 02C — Native AIP Plugin

    AIP Mirror — 03A — Architecture & Research
    AIP Mirror — 03B — Architecture & Research
    AIP Mirror — 03C — Architecture & Research

    AIP Mirror — 04A — Project Workshop
    AIP Mirror — 04B — Project Workshop
    AIP Mirror — 04C — Project Workshop

The number identifies the specialization. The letter identifies the conversation chapter.

Continue alphabetically within the same specialization.

Do not rename the numeric specialization when starting a new chapter.

## 3. Current chapters

The current project chapters are:

- `AIP Mirror — 01A — JSX Prototype`
- `AIP Mirror — 02A — Native AIP Plugin`
- `AIP Mirror — 03A — Architecture & Research`
- `AIP Mirror — 04A — Project Workshop`

## 4. Early warning

There is no reliable user-visible counter that tells the AI exactly how much conversation context remains.

Therefore, do not claim a precise percentage or number of remaining messages.

Instead, monitor for contextual risk, including:

- a very long conversation;
- a large accumulation of technical state;
- increasing reliance on distant conversation details;
- important decisions that exist only in chat;
- signs that context may no longer be safely retained;
- increasing risk of reconstructing details from incomplete context.

When contextual risk becomes significant, warn the user before continuing a large task and recommend creating a handoff checkpoint.

Do not wait until context has already been lost.

## 5. Normal checkpoints

Important state should be documented during long-running work when a meaningful milestone is reached.

A checkpoint does not need to be created after every message.

Prefer project documentation for durable knowledge and handoff documents for conversation-specific state.

A `DRAFT` handoff is the live checkpoint document for the current chapter. It may be updated repeatedly as meaningful state accumulates.

The standard user command is:

    Пора обновить handoff

When this command is used, update the current handoff, keep `DRAFT`, verify the result, and create a checkpoint commit. Handoff checkpoint commits are pre-authorized by this project workflow and do not require a separate approval step.

Checkpoint commits are not migration commits. They preserve working state while the chapter remains active.

## 6. Handoff trigger

A handoff is appropriate when:

- the current chapter is becoming too large or complex;
- a major milestone has been reached and work will continue later;
- the user explicitly requests a chapter migration;
- contextual risk is significant;
- the conversation should be closed without losing its current working state.

## 7. Handoff location

Conversation handoffs belong under:

    docs/handoffs/

Use one file per chapter:

    docs/handoffs/01A-JSX-Prototype.md
    docs/handoffs/02A-Native-AIP-Plugin.md
    docs/handoffs/03A-Architecture-Research.md
    docs/handoffs/04A-Project-Workshop.md

When a chapter is superseded, retain its handoff as historical project state.

## 8. Handoff is a state snapshot, not a casual summary

A handoff must record enough information for the next chapter to continue without guessing.

Include, where applicable:

- current objective;
- completed work;
- current implementation state;
- important decisions;
- open questions;
- relevant files;
- relevant references;
- constraints;
- assumptions;
- unresolved risks;
- last completed task;
- immediate next task;
- things that must not be redone;
- recommended starting context for the next chapter.

## 9. Evidence and confidence

Handoff documents must distinguish:

- Confirmed / observed
- Inferred
- Assumed / unverified
- Open

A handoff must never silently promote an inference or assumption into a confirmed project fact.

## 10. Handoff status

Every handoff must contain an explicit lifecycle status:

- `DRAFT` — live checkpoint state for the current chapter
- `READY_FOR_HANDOFF` — safe starting point for the next chapter
- `HANDED_OFF` — the next chapter has successfully started from this handoff
- `SUPERSEDED` — a later handoff for the same specialization has replaced this handoff

### Allowed transitions

Handoff status changes follow this state machine:

    DRAFT
      ↓
    READY_FOR_HANDOFF
      ↓
    HANDED_OFF
      ↓
    SUPERSEDED

Only these forward transitions are valid:

- `DRAFT` → `READY_FOR_HANDOFF`
- `READY_FOR_HANDOFF` → `HANDED_OFF`
- `HANDED_OFF` → `SUPERSEDED`

Do not skip states.

`SUPERSEDED` is mandatory when its condition is met. When a later handoff for the same specialization reaches `READY_FOR_HANDOFF`, that later chapter must mark the previously `HANDED_OFF` handoff `SUPERSEDED` and commit that transition. The older handoff remains as historical state.

### Transition ownership

The responsibility for each transition is explicit:

- The current chapter owns `DRAFT` → `READY_FOR_HANDOFF`.
- The receiving chapter owns `READY_FOR_HANDOFF` → `HANDED_OFF`.
- A later chapter owns `HANDED_OFF` → `SUPERSEDED` when its replacement handoff reaches `READY_FOR_HANDOFF`.

The previous chapter must not mark its own handoff `HANDED_OFF` merely because it has finished writing or delivering it.

## 11. Starting a new chapter

A new chapter must immediately create its own handoff file with status `DRAFT`.

This is mandatory for every new chapter and is part of chapter initialization.

The initial `DRAFT` handoff creation and its bootstrap commit are pre-authorized parts of the handoff procedure. They must be completed immediately rather than waiting for a separate approval step.

The initial `DRAFT` may be incomplete. At minimum it should identify the new chapter, specialization, previous chapter, starting objective, and starting state established during bootstrap.

For a chapter created from a previous handoff, the receiving chapter should read:

1. `.ai/skills/conversation-handoff/BOOTSTRAP.md`;
2. the applicable project rules;
3. the previous chapter's handoff;
4. any files identified as current implementation state.

After successfully starting from the previous handoff, the receiving chapter must update that previous handoff from `READY_FOR_HANDOFF` to `HANDED_OFF` and commit that transition.

The new chapter should not assume that every detail from the previous chat remains available.

## 12. Handoff lifecycle and Git traceability

Every lifecycle transition must be represented by a Git commit.

Initial creation of a new chapter's `DRAFT` handoff and subsequent `DRAFT` updates are also Git-traceable checkpoint commits. They are not migration commits.

A lifecycle transition may be combined with logically related handoff content changes in one coherent commit.

The repository history should therefore make the workflow auditable:

    new chapter starts → DRAFT handoff created
    checkpoint → DRAFT handoff updated/committed
    current chapter migrates → READY_FOR_HANDOFF
    receiving chapter starts → HANDED_OFF
    later replacement reaches READY_FOR_HANDOFF → older handoff SUPERSEDED

Use the `commit-message` skill for the required commit-message vocabulary and style.

## 13. Avoid duplicated state

Project knowledge belongs in normal project documentation.

Conversation-specific migration state belongs in `docs/handoffs/`.

Do not turn handoffs into a second, competing documentation system.

## 14. User control

Do not silently migrate a conversation or create a new chapter without telling the user.

The AI may warn that a handoff is advisable, but the user decides when the next chapter is started unless the user has explicitly delegated that decision.

Handoff bootstrap and checkpoint actions that are explicitly defined as pre-authorized by these rules are not subject to an additional approval step.
