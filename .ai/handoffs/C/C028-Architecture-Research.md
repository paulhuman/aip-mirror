# Conversation Handoff

**Conversation:**
C028 — Architecture & Research

**Specialization:**
C

**Chapter:**
028

**Previous chapter:**
027

**Status:**
DRAFT

## Current objective

Investigate the next bounded architecture question:

> What does “minimal” in Minimum Execution Context (MEC) actually mean after the entry/routing architecture work completed in C027?

The investigation should examine MEC together with P-01, P-02, and P-03, using the current repository as the source of truth rather than reconstructing the model from historical conversation context.

## Starting state

C027 is the completed closing chapter for the preceding architecture sequence.

The current entry/routing topology is:

    AGENTS
      ↓
    config.yaml + repository.md
      ↓
    ┌──────────────────────┬────────────────────────┐
    │ AI infrastructure    │ Project work           │
    │ ↓                    │ ↓                      │
    │ INDEX                │ PROJECT-INSTRUCTIONS   │
    │ ↓                    │ ↓                      │
    │ canonical AI owners  │ canonical project      │
    │                      │ sources                │
    └──────────────────────┴────────────────────────┘

C027 established and verified:

- the current chapter identifier format `[A-Z][0-9]{3}`;
- repository identity/path initialization through `.ai/config.yaml` and `.ai/rules/repository.md`;
- `.ai/AGENTS.md` as a compact always-on entry contract;
- `.ai/INDEX.md` as a routing/discovery surface, not a semantic owner;
- the current command-routing boundary:
  `command → operation → owner → activation context`;
- separate capability discovery:
  `capability → owner → purpose`;
- retention of `.ai/workflows/handoff/BOOTSTRAP.md` as the ordered bootstrap workflow;
- completion of the targeted entry-layer consistency cleanup.

Do not restart Iteration 2 restructuring or reopen the settled INDEX minimum-routing decision without new evidence.

## Immediate next task

Study the relationship between:

- Minimum Execution Context (MEC);
- P-01;
- P-02;
- P-03;
- the now-established AGENTS / INDEX / canonical-owner entry path.

The central question is whether the earlier meaning of “minimal” in MEC still holds after the entry/routing model has been clarified.

Begin by locating and reading the current repository documents that define or discuss MEC and P-01/P-02/P-03. Treat historical architecture material as research evidence only; do not treat old TODOs or proposals as active tasks unless the current repository state establishes them as such.

## Required research discipline

Use the current repository state as the source of truth.

For the MEC investigation:

1. identify the current MEC/P-01/P-02/P-03 sources;
2. distinguish confirmed/observed facts, inferences, assumptions, and open questions;
3. compare the semantic role of MEC with entry initialization, routing, and canonical-owner activation;
4. determine whether “minimal” refers to token volume, semantic sufficiency, activation sufficiency, persistence, or another property;
5. avoid prematurely changing `.ai` files;
6. document a durable architectural conclusion only after the model is sufficiently established and reviewed.

## Relevant current files

Entry/infrastructure:

- `.ai/AGENTS.md`
- `.ai/INDEX.md`
- `.ai/config.yaml`
- `.ai/rules/repository.md`
- `.ai/rules/workflow.md`
- `.ai/rules/handoff/lifecycle.md`
- `.ai/skills/handoff/SKILL.md`
- `.ai/workflows/handoff/BOOTSTRAP.md`
- `.ai/architecture/ai-infrastructure-restructuring.md`

Project entry/architecture:

- `docs/PROJECT-INSTRUCTIONS.md`
- `docs/architecture/project-architecture.md`

The architecture directory must be inspected before substantive MEC work. Its current active file is `project-architecture.md`; additional files should be treated according to the actual current repository tree rather than assumed from historical conversations.

## Decisions and constraints

- Current repository state outranks old conversation memory.
- Do not begin another `.ai` refactoring pass merely because older documents contain deferred architecture questions.
- Do not recreate a removed `ENTRY.md` layer.
- Do not change BOOTSTRAP ownership or ordering.
- Do not change the current chapter identifier format.
- Do not freeze exact command IDs or final command syntax.
- Preserve the distinction between entry contract, routing surface, canonical semantic owners, and ordered bootstrap.
- Treat C027’s INDEX and AGENTS results as current architecture unless new evidence directly challenges them.

## Evidence / confidence

### Confirmed / observed

- C027 completed the bounded entry-layer architecture and cleanup sequence.
- C027 handoff is `READY_FOR_HANDOFF`.
- The previous C026 handoff is already `HANDED_OFF`.
- The current repository contains the implemented AGENTS/INDEX entry topology.
- The current lifecycle is `DRAFT → READY_FOR_HANDOFF → HANDED_OFF`.

### Inferred

- The clarified entry/routing topology may change the semantic interpretation of MEC’s “minimal” requirement.
- MEC may need to be evaluated as semantic sufficiency rather than simply as a smallest possible set of files/tokens.

### Open

- The exact current relationship among MEC, P-01, P-02, and P-03.
- Whether MEC should be defined in terms of initialization, activation, persistence, or semantic sufficiency.
- Whether any existing MEC terminology remains useful unchanged after the C027 entry/routing result.
- Whether the MEC analysis will require any repository changes at all.

## Things not to redo

- Physical Iteration 2 restructuring.
- Repository Identity & Path Resolution ownership work.
- The completed INDEX minimum-routing analysis.
- The completed AGENTS entry-contract implementation.
- The completed PROJECT-INSTRUCTIONS and lifecycle discovery cleanup.
- The decision not to create `ENTRY.md`.
- The decision to retain BOOTSTRAP as an ordered workflow.

## Recommended starting context

Read the current MEC/P-01/P-02/P-03 material from `docs/architecture/` and the durable architecture note first. Then build the semantic model against the current AGENTS → config/repository → INDEX or PROJECT-INSTRUCTIONS → canonical-owner topology.

The receiving chapter should answer the bounded question before proposing any implementation change.
