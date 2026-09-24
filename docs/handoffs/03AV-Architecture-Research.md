# Conversation Handoff

Conversation:
AIP Mirror — 03AV — Architecture & Research

Specialization:
03 — Architecture & Research

Chapter:
03AV

Previous chapter:
03AU — Architecture & Research

Status:
DRAFT

## Current objective

Continue Iteration 2 of the practical AI project-instruction infrastructure.

The immediate goal is to complete the local inventory/classification of the existing `.ai/` and `docs/` materials before any physical restructuring.

The central working boundary is:

> If the primary subject is how AI should work with the project, it belongs in `.ai/`. If the primary subject is what AIP Mirror is or how it works, it belongs in `docs/`.

## Completed

Bootstrap source context has been read from the canonical repository on `main`, including:
- `.ai/skills/conversation-handoff/BOOTSTRAP.md`
- `.ai/skills/conversation-handoff/SKILL.md`
- applicable lifecycle, workflow, repository, and handoff-reference rules
- `docs/PROJECT-INSTRUCTIONS.md`
- `docs/handoffs/03AU-Architecture-Research.md`
- `.ai/architecture/03AU_ai-infrastructure-restructuring.md`

The 03AU durable research context has been preserved as the primary architectural source for this chapter.

The 03AU → 03AV lifecycle bootstrap is being performed by a write-capable AI.

## Current implementation state

No physical restructuring of the `.ai/` or `docs/` tree has been performed.

The current repository still contains the historical/incremental organization. The intended restructuring remains a classification and architecture question first, followed by independent review, and only then physical moves/merges/splits.

## Decisions

1. `.ai/` is portable AI infrastructure.
2. `docs/` is AIP Mirror project knowledge.
3. Root `references/` remains AIP Mirror-specific.
4. `.ai/architecture/` is conceptually accepted; exact taxonomy remains open.
5. Historical AI-infrastructure research is a candidate for `.ai/archive/`.
6. `docs/handoffs/` is conversation state and is a candidate for `.ai/handoffs/`; this is not yet a physical move.
7. `.ai/skills/conversation-handoff/` is a candidate for the shorter `.ai/skills/handoff/` structure.
8. `.ai/rules/conversation-lifecycle.md` and `.ai/rules/handoff-references.md` are candidates for a `.ai/rules/handoff/` grouping.
9. `docs/PROJECT-INSTRUCTIONS.md` is mixed and should be decomposed rather than blindly moved or renamed.
10. `.ai/rules/project-architecture.md` is AIP Mirror-specific and should move conceptually toward `docs/architecture/`.
11. `.ai/rules/workflow.md` and `.ai/rules/repository.md` require content-level classification/decomposition.
12. `docs/architecture/ai-project-instruction-architecture.md` is AI-infrastructure material and belongs conceptually under `.ai/architecture/`.
13. Independent-review onboarding documents are candidates for `.ai/workflows/independent-review/`.
14. No physical move, rename, merge, split, or deletion is authorized merely by the target-tree sketches.
15. New chapter-produced documents use the working `03AV_document-name.md` filename-prefix convention, pending formalization after inventory/review.
16. Do not use “bootstrap kernel” as an architecture term. Where historically needed, use “non-empty initial active context”.

## Open questions

Do not silently resolve:
- exact `.ai/architecture/` taxonomy;
- exact architecture filenames;
- exact `.ai/rules/`, `.ai/skills/`, and `.ai/workflows/` taxonomy;
- exact target for handoffs;
- exact decomposition of `docs/PROJECT-INSTRUCTIONS.md`;
- exact split of `.ai/rules/repository.md`;
- exact split of `.ai/rules/workflow.md`;
- exact `AGENTS.md` and `.ai/INDEX.md` contents;
- command syntax, operation IDs, and fragment/section ID conventions;
- whether historical filenames should later be converted to the chapter-prefix convention.

## Current files

Primary durable research context:
- `.ai/architecture/03AU_ai-infrastructure-restructuring.md`

Current migration handoff:
- `docs/handoffs/03AU-Architecture-Research.md`
- `docs/handoffs/03AV-Architecture-Research.md`

High-priority inventory sources:
- `.ai/rules/`
- `.ai/skills/`
- `docs/PROJECT-INSTRUCTIONS.md`
- `docs/architecture/`
- `docs/handoffs/`
- `README.md`
- planned `AGENTS.md`

## Relevant references

### Repository

- `paulhuman/aip-mirror`
  - Role: canonical AIP Mirror project repository and durable source of project/infrastructure state.

### Primary durable research context

- `paulhuman/aip-mirror@main:/.ai/architecture/03AU_ai-infrastructure-restructuring.md`
  - Role: main preserved 03AU research context for the AI-infrastructure restructuring.

### Handoff

- `paulhuman/aip-mirror@main:/docs/handoffs/03AU-Architecture-Research.md`
  - Role: predecessor chapter checkpoint and migration state.

## Important constraints

- Complete local inventory/classification before target-tree finalization.
- Classification labels are exactly:
  - KEEP
  - MOVE
  - DECOMPOSE
  - ARCHIVE
- For each relevant file record current path, primary subject, type, target layer, current problem, proposed action, and unresolved question.
- Sequence is: local inventory → target tree → independent Grok/Qwen alternatives → comparison → physical restructuring.
- `.ai/` must remain portable; AIP Mirror-specific assumptions must not be embedded in supposedly generic infrastructure.
- Do not physically restructure files during the inventory phase.
- For existing-file mutations, use: READ CURRENT FILE → minimal change → WRITE COMPLETE FILE → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT.
- Human remains the final decision-maker for architectural choices.
- Do not use “bootstrap kernel” as an architecture term.

## Evidence / confidence

### Confirmed / observed

- 03AU marked the local inventory/classification as the immediate next task.
- `.ai/architecture/03AU_ai-infrastructure-restructuring.md` is the main durable 03AU research context.
- No physical restructuring was performed in 03AU.
- The `.ai/` versus `docs/` boundary is an accepted working decision.
- The current repository is `paulhuman/aip-mirror` on `main`.

### Inferred

- Several existing files will require decomposition because they mix portable AI infrastructure with AIP Mirror-specific project knowledge.
- A substantial portion of historical AI-infrastructure research can likely be retained under `.ai/archive/` without remaining active infrastructure.
- The current handoff location is likely to change to `.ai/handoffs/`, but this is still a target-state decision.

### Assumed / unverified

- The exact final target tree.
- The exact number and boundaries of files produced by decomposition.
- The final policy for archive retention and portability.
- Whether `docs/PROJECT-INSTRUCTIONS.md` survives in reduced form.

### Open

All unresolved architecture/taxonomy questions listed above remain open until the inventory and review stages resolve them.

## Last completed task

Initialized 03AV bootstrap from the canonical 03AU handoff and durable architecture context, and verified the applicable repository-controlled bootstrap/lifecycle instructions.

## Immediate next task

Finish the local inventory/classification of existing `.ai/` and `docs/` materials, starting with all `.ai/rules/` files, then all `.ai/skills/`, `docs/PROJECT-INSTRUCTIONS.md`, `docs/architecture/`, `docs/handoffs/`, `README.md`, and the planned `AGENTS.md`.

For every relevant file, record:

    KEEP
    MOVE
    DECOMPOSE
    ARCHIVE

along with:
- current path;
- primary subject;
- type;
- target layer;
- current problem;
- proposed action;
- unresolved question.

Do not start Grok/Qwen review until the local inventory is complete.

## Things not to redo

- Do not reconstruct the 03AU architectural reasoning from conversation history.
- Do not restart MEC theory.
- Do not re-derive the `.ai/` versus `docs/` boundary unless new evidence contradicts it.
- Do not physically move or delete files merely because a target location has been proposed.
- Do not reintroduce “bootstrap kernel” as an architecture term.
- Do not treat the target tree as already approved.

## Recommended starting context for next chapter

1. `.ai/architecture/03AU_ai-infrastructure-restructuring.md`
2. `docs/handoffs/03AV-Architecture-Research.md`
3. `docs/PROJECT-INSTRUCTIONS.md`
4. `.ai/skills/conversation-handoff/BOOTSTRAP.md`
5. `.ai/skills/conversation-handoff/SKILL.md`
6. `.ai/rules/conversation-lifecycle.md`
7. `.ai/rules/workflow.md`
8. `.ai/rules/repository.md`
9. `.ai/rules/handoff-references.md`
10. `docs/architecture/ai-project-instruction-architecture.md`

The durable 03AU architecture working file is the primary preserved research context. The next chapter should continue from repository state rather than from conversational reconstruction.
