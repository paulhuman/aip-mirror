# Conversation Handoff

Conversation:
AIP Mirror — 02A — Native AIP Plugin

Specialization:
02

Chapter:
A

Previous chapter:
N/A — this is the first handoff record for the 02 specialization

Status:
HANDED_OFF

## Current objective

Establish the durable handoff state for chapter 02A and migrate the Native AIP Plugin work cleanly to chapter 02B.

## Completed

- Defined the four-specialization / alphabetical-chapter conversation model.
- Established the conversation handoff lifecycle: `DRAFT` → `READY_FOR_HANDOFF` → `HANDED_OFF` → `SUPERSEDED`.
- Established that every new chapter must immediately create its own `DRAFT` handoff and commit it without a separate user approval step.
- Established the user checkpoint command `Пора обновить handoff` for repeated `DRAFT` checkpoint commits.
- Established that checkpoint commits are not migration commits.
- Established the migration command `Пора выполнять миграцию в чат XXY`.
- Established that the receiving chapter owns `READY_FOR_HANDOFF` → `HANDED_OFF`.
- Established that a later chapter must mark the older `HANDED_OFF` handoff `SUPERSEDED` when the later handoff reaches `READY_FOR_HANDOFF`.
- Added the static bootstrap procedure at `.ai/skills/conversation-handoff/BOOTSTRAP.md`.
- Updated the lifecycle/workflow rules to define bootstrap, checkpoint commits, pre-authorized handoff commits, and mandatory `SUPERSEDED` transitions.

## Current implementation state

Chapter 02A is the Native AIP Plugin specialization stream. Native implementation has not yet been completed; this handoff captures the chapter/workflow state established before continuing in 02B.

The native implementation is intended to use C++ with the Illustrator 2026 AIP SDK. The interactive Mirror tool is the production target. The JSX prototype is a behavioral reference and must not be mechanically translated into C++.

## Decisions

- Native implementation belongs in specialization `02`.
- The first native milestone may use a simple native ADM settings UI if needed; the interactive mirror tool is the priority.
- Core geometry should remain as independent from Illustrator APIs as practical.
- The development workflow is research → document → review → specify → prototype → validate → implement → test → document, where applicable.
- Repository writes must follow the established read → minimal change → write → read-back → verify → diff/scope → commit → ref verification sequence.
- Handoff bootstrap is a static procedure; chapter-specific values are supplied by the bootstrap message rather than written into `BOOTSTRAP.md`.

## Open questions

- Native C++/AIP implementation details remain to be investigated and validated in chapter 02.
- Exact Illustrator SDK suites/APIs, event handling, live preview mechanism, object/path operations, undo/cancel behavior, and native UI details remain implementation work.

## Current files

- `.ai/skills/conversation-handoff/SKILL.md`
- `.ai/skills/conversation-handoff/BOOTSTRAP.md`
- `.ai/rules/conversation-lifecycle.md`
- `.ai/rules/workflow.md`
- `.ai/rules/repository.md`
- `.ai/skills/commit-message/SKILL.md`
- `docs/PROJECT-INSTRUCTIONS.md`
- `prototypes/jsx/` — behavioral prototype area
- `references/freehand/` — FreeHand reference material
- `references/test-data/` — project test data
- `paulhuman/adobe-illustrator-2026-sdk` — canonical external Illustrator 2026 SDK reference repository

## Relevant references

- Macromedia FreeHand MX Mirror behavior and project reference material under `references/freehand/`.
- Illustrator 2026 SDK in the canonical external SDK repository `paulhuman/adobe-illustrator-2026-sdk`.
- Illustrator JavaScript scripting reference under `references/javascript/`.

## Important constraints

- Preserve the distinction between behavioral research/prototyping and native implementation.
- Do not invent unverified FreeHand or Illustrator behavior.
- Keep durable project knowledge in project documentation rather than duplicating it in handoffs.
- Do not silently migrate to another chapter; migration is user-controlled.
- Handoff lifecycle transitions must be represented by Git commits.
- Handoff procedural commits are pre-authorized; ordinary development changes still require the normal user-controlled commit workflow.

## Evidence / confidence

### Confirmed / observed

- The project uses specializations 01 JSX Prototype, 02 Native AIP Plugin, 03 Architecture & Research, and 04 Project Workshop.
- The 02 specialization is named Native AIP Plugin.
- The chapter naming convention uses an alphabetical suffix within each specialization.
- The handoff lifecycle and checkpoint/bootstrap procedures are explicitly defined in repository rules.

### Inferred

- 02B should continue from this chapter's Native AIP Plugin scope rather than restart project-wide architectural decisions.

### Assumed / unverified

- No new native implementation behavior is claimed as verified by this handoff.

### Open

- Native AIP implementation design and implementation details are still open work.

## Last completed task

Formalized and tested the conversation handoff workflow, including mandatory initial `DRAFT` creation, checkpoint commits, migration finalization, receiving-chapter ownership, and mandatory `SUPERSEDED` handling.

## Immediate next task

Initialize chapter 02B using the static bootstrap procedure.

## Things not to redo

- Do not redesign the handoff lifecycle already established in repository rules.
- Do not recreate chapter-specific values inside `BOOTSTRAP.md`.
- Do not treat checkpoint commits as migration commits.
- Do not require a separate user approval for mandatory handoff bootstrap/checkpoint commits.
- Do not mark this handoff `HANDED_OFF` from chapter 02A.

## Recommended starting context for next chapter

Start by reading `.ai/skills/conversation-handoff/BOOTSTRAP.md`, `.ai/rules/conversation-lifecycle.md`, and `.ai/rules/workflow.md`, then read this handoff and inspect the relevant native-plugin/project files and references before beginning implementation. Chapter 02B must create its own `docs/handoffs/02B-Native-AIP-Plugin.md` with status `DRAFT` immediately during bootstrap and commit it without asking for permission. After successful bootstrap, 02B must change this handoff from `READY_FOR_HANDOFF` to `HANDED_OFF` and commit that transition.
