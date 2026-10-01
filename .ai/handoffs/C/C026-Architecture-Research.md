# Conversation Handoff

**Conversation:**
C026 — Architecture & Research

**Specialization:**
C

**Chapter:**
026

**Previous chapter:**
025

## Current objective

Continue Iteration 2 of the AI-infrastructure restructuring by completing the semantic-ownership work around the repository entry layer.

The Repository Identity & Path Resolution ownership pass is complete. The next frontier is the design of `.ai/INDEX.md` as an operational command router and capability-discovery surface, followed by the final decision on whether the residual bootstrap workflow remains independently justified.

## Completed

### Iteration 2 physical restructuring

- Physical restructuring of the AI-infrastructure tree is complete.
- Handoffs were moved from `.ai/handoffs/` to `.ai/handoffs/<specialization>/`.
- Architecture, rules, skills, and workflow locations were normalized according to the accepted Iteration 2 structure.
- Historical one-letter chapter naming was removed from active architecture/handoff references.

### Repository Identity & Path Resolution ownership pass

The canonical boundary is now:

- `.ai/config.yaml` — project repository identity and configuration facts (**WHAT / WHERE**).
- `.ai/rules/repository.md` — repository interpretation, path resolution, boundaries, taxonomy/hygiene, durable repository knowledge, and write safety (**HOW**).
- Other rules, skills, and workflows — consumers/references; they must not redefine the canonical ownership.

Completed bounded repairs include:

- `.ai/rules/handoff/references.md` was cleaned to delegate repository identity/path resolution to `.ai/rules/repository.md`.
- Commit: `69145e5bfd73a43ea464008d1060b0a8662f61b4`.
- Commit-layer ownership was re-verified: `.ai/rules/commits.md` owns policy; `.ai/skills/commits/SKILL.md` owns reusable commit construction.
- Stale commit/handoff naming references were removed in bounded corrective commits.
- `.ai/skills/handoff/SKILL.md` frontmatter was normalized to `name: handoff`.
- Duplicate migration-completion material was removed from `.ai/workflows/handoff-bootstrap/BOOTSTRAP.md`, leaving migration ownership in the handoff skill.
- Commit: `9caf822259ad11587346c62981cbcc3981dc0a75`.
- A durable TODO was recorded: if BOOTSTRAP remains after residual-core analysis, rename it to `.ai/workflows/handoff/BOOTSTRAP.md`.
- Commit: `c40375b2f84d99eab30f3a932ac77f1159152d09`.

### Entry-layer work

- `.ai/AGENTS.md` exists as the compact AI repository operating contract.
- `.ai/INDEX.md` exists as the future operational command/capability routing surface.
- The approved layering is:
  - `README.md` — human orientation;
  - `.ai/AGENTS.md` — always-on AI operating contract;
  - `.ai/INDEX.md` — command surface, capability discovery, canonical-owner routing;
  - `.ai/rules/` — canonical semantics/constraints;
  - `.ai/skills/` — reusable capabilities;
  - `.ai/workflows/` — ordered procedures.
- No `ENTRY.md` is planned in Iteration 2.

### Command-routing model

Five currently documented user-facing handoff commands were identified:

1. `Пора обновить handoff`
2. `Пора выполнить миграцию в чат XXYY`
3. `Пора восстановить handoff`
4. `Пора выполнить handoff lifecycle correction`
5. `Пора выдать bootstrap-инструкцию`

The semantic routing model is:

    user command
        ↓
    .ai/INDEX.md
        ↓
    operation identification
        ↓
    reread canonical owner files
        ↓
    execute owning rule / skill / workflow

Important distinctions are preserved:

- HANDOFF STATE != OPERATION != COMMIT.
- Checkpoint keeps the handoff in DRAFT.
- Migration ends the closing chapter at READY_FOR_HANDOFF; the receiving chapter later performs HANDED_OFF.
- Lifecycle Recovery and Lifecycle Correction are distinct exceptional operations.
- Bootstrap-instruction generation is not itself a lifecycle operation.

## Current implementation state

The durable architecture file has been updated through C026:

`.ai/architecture/ai-infrastructure-restructuring.md`

It now records:

- completion of the Repository Identity & Path Resolution ownership pass;
- the current AGENTS/INDEX entry-layer model;
- the five-command routing table;
- the decomposition of BOOTSTRAP into canonical-owner content versus residual bootstrap-specific semantics;
- the current Iteration 2 frontier;
- the assignment for C027.

Architecture update commit:
`5eb27327157e0fa4d7114ef5ce7a85a8329bbad7`

The architecture file's resulting blob was read back and verified to contain the C026 completion, entry-layer model, BOOTSTRAP residual-core analysis, and C027 assignment.

## Decisions

- Do not repeat physical Iteration 2 restructuring.
- Do not reopen the completed Repository Identity & Path Resolution ownership decision without new evidence.
- `.ai/config.yaml` remains the owner of repository identity/configuration facts.
- `.ai/rules/repository.md` remains the owner of repository interpretation/path-resolution/safety mechanics.
- `.ai/INDEX.md` is an operational router/discovery surface, not a new policy or procedure owner.
- `.ai/AGENTS.md` remains compact and must not become a second INDEX or bootstrap document.
- Do not create `ENTRY.md`.
- Exact command IDs/syntax remain intentionally unfrozen.
- Detailed procedures remain in their canonical rule/skill/workflow owners.

## BOOTSTRAP status

`.ai/workflows/handoff-bootstrap/BOOTSTRAP.md` is **UNRESOLVED**.

Its remaining potentially unique semantics are:

- runtime inputs: `CURRENT_CHAPTER`, `NEXT_CHAPTER`, `SPECIALIZATION`;
- receiving-chapter initialization;
- write-capability branch selection;
- ordered bootstrap sequence;
- post-bootstrap completion gate.

Its duplicated canonical material has already been reduced:

- repository semantics → `.ai/rules/repository.md`;
- lifecycle semantics → `.ai/rules/handoff/lifecycle.md`;
- handoff capability/migration → `.ai/skills/handoff/SKILL.md`;
- commit construction → `.ai/skills/commits/SKILL.md`.

Do not delete BOOTSTRAP merely because it contains delegated material. First compare its residual core with the completed INDEX command-routing model.

If it remains an independently useful ordered procedure, rename it to:

`.ai/workflows/handoff/BOOTSTRAP.md`

If no independent procedure remains, remove it rather than preserving a historical layer.

## Open questions

- Exact new command syntax and operation IDs.
- Exact command-entry/fragment ID convention for INDEX.md.
- Complete handoff operation vocabulary and operation-to-commit mapping.
- Long-term handoff retention/archive policy.
- Whether any remaining mixed rule files need another decomposition pass.
- Final fate of BOOTSTRAP after the INDEX/residual-core comparison.
- Exact long-term `.ai/architecture/` taxonomy.

Do not start the handoff-operation/commit-vocabulary TODO unless explicitly authorized later.

## Current files

Primary entry-layer scope:

- `.ai/AGENTS.md`
- `.ai/INDEX.md`
- `README.md`
- `docs/PROJECT-INSTRUCTIONS.md`

Canonical infrastructure owners:

- `.ai/config.yaml`
- `.ai/rules/repository.md`
- `.ai/rules/handoff/lifecycle.md`
- `.ai/rules/handoff/references.md`
- `.ai/rules/commits.md`
- `.ai/skills/handoff/SKILL.md`
- `.ai/skills/commits/SKILL.md`
- `.ai/workflows/handoff-bootstrap/BOOTSTRAP.md`

Durable architecture context:

- `.ai/architecture/ai-infrastructure-restructuring.md`

## Evidence / confidence

### Confirmed / observed

- Repository identity is `paulhuman/aip-mirror`, default branch `main`.
- Physical Iteration 2 restructuring is complete.
- Repository Identity & Path Resolution ownership has been repaired and verified in the inspected active core.
- `.ai/AGENTS.md` and `.ai/INDEX.md` exist.
- The five handoff-related user-facing command phrases above are present in the current rules/skills/workflow model.
- BOOTSTRAP's duplicate migration-completion section is removed.
- The architecture note contains the current C026 state and C027 assignment.

### Inferred

- The next useful abstraction boundary is the entry-layer command router, not another physical tree change.
- INDEX.md can carry the command surface without becoming a second procedure owner.

### Assumed / unverified

- Whether the full remaining `.ai/skills/` and `.ai/workflows/` population contains additional command surfaces not yet formalized in INDEX.md.
- Whether BOOTSTRAP's residual core is sufficiently independent to justify its own workflow after INDEX is designed.

### Open

- Final INDEX.md content and exact command IDs.
- Final BOOTSTRAP fate.

## Last completed task

Updated the durable Iteration 2 architecture context through C026, including the completed repository ownership pass, the entry-layer routing model, the BOOTSTRAP residual-core analysis, and the next-chapter assignment.

## Immediate next task

**C027 — Architecture & Research: design `.ai/INDEX.md`.**

Start with the existing minimal `.ai/INDEX.md` and the command-routing table in the architecture note.

Produce a compact but complete INDEX model that:

1. lists the full current user-facing command surface using the new command syntax;
2. gives each command its semantic operation;
3. identifies the canonical owner;
4. identifies the files that must be reread before execution;
5. indicates whether the operation may change repository state;
6. provides capability/workflow discovery without duplicating detailed procedures;
7. keeps command IDs/syntax provisional until there is enough evidence to freeze them.

Then compare the resulting INDEX model with the residual BOOTSTRAP semantics and decide whether BOOTSTRAP remains a genuinely independent ordered workflow.

Do not broaden the task into physical restructuring or the handoff-operation/commit-vocabulary TODO.

## Things not to redo

- Do not repeat physical Iteration 2 restructuring.
- Do not reconstruct C021/C022/C023/C024/C025 from chat history.
- Do not redo the Repository Identity & Path Resolution ownership sweep without new evidence.
- Do not recreate `.ai/AGENTS.md`.
- Do not create `ENTRY.md`.
- Do not duplicate detailed lifecycle, handoff, commit, or repository procedures in INDEX.md.
- Do not treat BOOTSTRAP as automatically obsolete before comparing its residual core.
- Do not freeze command IDs merely because an example syntax looks convenient.

## Recommended starting context for next chapter

Read, in this order:

1. `.ai/AGENTS.md`
2. `.ai/INDEX.md`
3. `.ai/architecture/ai-infrastructure-restructuring.md`
4. this handoff: `.ai/handoffs/C/C026-Architecture-Research.md`
5. `.ai/rules/handoff/lifecycle.md`
6. `.ai/skills/handoff/SKILL.md`
7. `.ai/workflows/handoff-bootstrap/BOOTSTRAP.md`

Then design INDEX before changing BOOTSTRAP.

The durable architectural question is:

> How should the entry layer route a user command to the canonical capability without becoming another owner?

The receiving chapter must not create a future handoff during bootstrap.
