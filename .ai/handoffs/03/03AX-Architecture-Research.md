# Conversation Handoff

Conversation:
AIP Mirror — 03AX — Architecture & Research

Specialization:
03 — Architecture & Research

Chapter:
03AX

Previous chapter:
03AW — Architecture & Research

Status:
DRAFT

## Starting objective

Continue Iteration 2 from the current repository state after physical restructuring.

The immediate task is a repository-wide post-edit consistency sweep for stale references, duplicated normative instructions, obsolete terms, and stale dependencies left by the completed restructuring.

Do not restart the earlier semantic-comparison or target-tree planning stage.

## Known starting implementation state

03AW completed the current physical restructuring pass and documented the mandatory post-edit consistency-sweep procedure.

The current architectural boundary remains:

> If the primary subject is how AI should work with the project, it belongs in .ai/. If the primary subject is what AIP Mirror is or how it works, it belongs in docs/.

The current repository state is authoritative.

## Important constraints

- .ai/ = AI working infrastructure.
- docs/ = AIP Mirror project knowledge.
- Workstreams are organizational areas represented by separate AI conversations, not autonomous agents.
- Handoff lifecycle is exactly DRAFT → READY_FOR_HANDOFF → HANDED_OFF.
- SUPERSEDED is not a lifecycle state.
- Do not introduce ENTRY.md.
- Do not use “bootstrap kernel” as an architectural term.
- After every MOVE, RENAME, DECOMPOSE, or canonical-owner change, perform a post-edit consistency sweep.
- The sweep must search for old paths, old filenames, stale owners, obsolete terms, duplicated normative wording, stale chapter/specialization identifiers, bootstrap references, and routing/link targets; classify each relevant hit and repair or deliberately preserve it.
- Repository writes follow the canonical read → minimal edit → complete write → read-back → verify → diff/scope → commit → verify sequence.

## Durable architectural context

- .ai/architecture/ai-infrastructure-restructuring.md
- docs/architecture/iteration-2-consistency-sweep.md

Historical Iteration 2 architecture/research artifacts are preserved under `.ai/archive/architecture/` and should be consulted only when their historical context is specifically needed.

## Operational sources

- .ai/rules/repository.md
- .ai/rules/handoff/lifecycle.md
- .ai/rules/workflow.md
- .ai/rules/commits.md
- .ai/skills/commits/SKILL.md
- .ai/workflows/handoff-bootstrap/BOOTSTRAP.md

## Confirmed / observed

- 03AW was READY_FOR_HANDOFF at bootstrap start.
- 03AX did not exist before this bootstrap.
- The repository contains the completed Iteration 2 physical restructuring recorded by 03AW.
- Historical architecture research has been moved to `.ai/archive/architecture/`; the active architecture layer now contains only the current restructuring working notes.
- The first repository-wide sweep found no active `SUPERSEDED`, `bootstrap kernel`, `ENTRY.md`, or old `docs/handoffs/` routing residue requiring repair.
- The sweep did find project-specific leakage in several generic-looking `.ai` rules/skills, plus a deeper ownership question around repository identity in `.ai/rules/repository.md`.

## Current sweep findings

1. `.ai/rules/repository.md` contains concrete AIP Mirror and Adobe Illustrator SDK repository identity. This is an architectural boundary question, not a mechanical string-replacement task.
2. `.ai/rules/handoff/references.md` contains project-specific repository identity and is a repair candidate.
3. `.ai/rules/handoff/lifecycle.md` contains project-specific framing even though its lifecycle semantics are generic.
4. `.ai/rules/workflow.md` contains project-specific framing even though its workflow guidance is generic.
5. `.ai/skills/commits/SKILL.md` contains mixed generic commit procedure and project-specific references; inspect occurrences semantically before editing.
6. `.ai/skills/deep-understanding/SKILL.md` contains AIP Mirror / Adobe Illustrator / JSX / FreeHand references and is a probable project-leakage case requiring semantic inspection.
7. `.ai/skills/handoff/SKILL.md` contains project-specific wording mixed with otherwise reusable handoff capability.
8. `.ai/workflows/independent-review/` contains project-specific onboarding/configuration for current model reviews; determine whether it belongs as project configuration rather than reusable workflow infrastructure.

Detailed sweep record and repair plan:

- `docs/architecture/iteration-2-consistency-sweep.md`

## Recovered handoff-operation context

Important information recovered during 03AX and preserved for the next continuation:

- Keep the three semantic dimensions distinct: **HANDOFF LIFECYCLE = state**, **HANDOFF OPERATION = action**, **HANDOFF COMMIT = durable Git record**.
- Do not derive the operation vocabulary directly from lifecycle transitions. An operation may leave lifecycle state unchanged.
- The archival analysis, examples, and unresolved TODO for operations and commit naming are preserved in:
  - `.ai/architecture/ai-infrastructure-restructuring.md` §17.1 — **Archived TODO-A — handoff operations and commit vocabulary**
  - `.ai/architecture/ai-infrastructure-restructuring.md` §17.2 — **Commit-message vocabulary TODO**
- Those sections are durable context, not instructions to execute the analysis immediately.
- When this TODO is eventually resumed, derive the operation vocabulary from the actual handoff workflow/rules/skills, then map operations to commit classifications and define the minimal hard-MUST commit-message vocabulary.

## Immediate next task

1. Inspect the mixed project-specific findings in context.
2. Decide the ownership boundary for repository identity before editing `.ai/rules/repository.md`.
3. Generalize genuinely generic rules and skills.
4. Determine whether independent-review onboarding should be separated into reusable mechanism plus project-specific configuration.
5. Run the post-edit consistency sweep again after repairs.
6. Only then review entry surfaces (`AGENTS.md` / `.ai/INDEX.md`).

## Things not to redo

- Do not reconstruct 03AU/03AV/03AW from conversation history.
- Do not restart semantic comparison.
- Do not rebuild the old target tree as a future plan.
- Do not repeat already completed physical moves.
- Do not recreate the old docs/ handoff paths.
- Do not restore repository path resolution to docs/PROJECT-INSTRUCTIONS.md.
- Do not reintroduce SUPERSEDED.
- Do not introduce ENTRY.md without new evidence.
- Do not create a separate TODO file without a demonstrated ownership need.

## Migration note

This chapter is now ready to hand off. The repository-wide sweep has produced a durable findings document and a bounded repair frontier. The next chapter should continue from those artifacts rather than reconstructing this analysis from chat history.
