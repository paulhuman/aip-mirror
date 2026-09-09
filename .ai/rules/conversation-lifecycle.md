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

The number identifies the specialization. The letter identifies the conversation chapter.

Continue alphabetically within the same specialization.

Do not rename the numeric specialization when starting a new chapter.

## 3. Current chapters

The current project chapters are:

- `AIP Mirror — 01A — JSX Prototype`
- `AIP Mirror — 02A — Native AIP Plugin`
- `AIP Mirror — 03A — Architecture & Research`

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

- `DRAFT` — work in progress
- `READY_FOR_HANDOFF` — safe starting point for the next chapter
- `HANDED_OFF` — the next chapter has successfully started from this handoff
- `SUPERSEDED` — this handoff was later replaced by a newer handoff for the same specialization

### Allowed transitions

Handoff status changes follow this state machine:

    DRAFT
      ↓
    READY_FOR_HANDOFF
      ↓
    HANDED_OFF
      ↓
    SUPERSEDED

Only the following forward transitions are valid:

- `DRAFT` → `READY_FOR_HANDOFF`
- `READY_FOR_HANDOFF` → `HANDED_OFF`
- `HANDED_OFF` → `SUPERSEDED`

Do not skip states.

`SUPERSEDED` is not the normal immediate result of migration. A handoff becomes `HANDED_OFF` when the receiving chapter successfully starts from it. It becomes `SUPERSEDED` only later, when a newer handoff for the same specialization replaces it.

### Transition ownership

The responsibility for each transition is explicit:

- The current chapter creates or updates its handoff and is responsible for `DRAFT` → `READY_FOR_HANDOFF`.
- The receiving chapter is responsible for `READY_FOR_HANDOFF` → `HANDED_OFF`, after it has successfully started from the previous handoff.
- A later chapter is responsible for `HANDED_OFF` → `SUPERSEDED` when a newer handoff has replaced the older one.

The previous chapter must not mark its own handoff `HANDED_OFF` merely because it has finished writing or delivering it. `HANDED_OFF` confirms successful receipt and startup by the next chapter.

## 11. Starting a new chapter

The next chapter should read:

1. the applicable project rules;
2. the latest relevant project documentation;
3. the previous chapter's handoff;
4. any files identified as current implementation state.

After successfully starting from the previous handoff, the receiving chapter must update that handoff from `READY_FOR_HANDOFF` to `HANDED_OFF`.

The new chapter should not assume that every detail from the previous chat remains available.

## 12. Handoff lifecycle and Git traceability

Every lifecycle transition must be represented by a Git commit.

A lifecycle transition may be combined with logically related handoff content changes in the same commit. A separate status-only commit is not required when the transition is part of the same coherent handoff update.

Use the `commit-message` skill for the required commit-message vocabulary and style.

The repository history should therefore make the handoff lifecycle auditable:

    handoff created/updated → READY_FOR_HANDOFF
    receiving chapter starts → HANDED_OFF
    later handoff replaces it → SUPERSEDED

## 13. Avoid duplicated state

Project knowledge belongs in normal project documentation.

Conversation-specific migration state belongs in `docs/handoffs/`.

Do not turn handoffs into a second, competing documentation system.

## 14. User control

Do not silently migrate a conversation or create a new chapter without telling the user.

The AI may warn that a handoff is advisable, but the user decides when to start the next chapter unless the user has explicitly delegated that decision.
