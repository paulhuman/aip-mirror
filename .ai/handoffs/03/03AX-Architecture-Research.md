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
- .ai/architecture/ai-project-instruction-architecture.md
- .ai/architecture/decomposition-map.md

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
- The first substantive task is the stale-reference / duplication consistency sweep.

## Immediate next task

1. Inventory the current repository state relevant to the completed restructuring.
2. Search for stale paths, filenames, owners, obsolete lifecycle/concept terms, duplicated normative instructions, stale chapter identifiers, and moved-file references.
3. Classify each relevant result as valid, stale, duplicate, historical, or otherwise intentionally retained.
4. Repair actual consistency problems before beginning any new semantic restructuring.
5. Only then continue Iteration 2 where a real unresolved semantic or consistency issue remains.

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

## Recommended starting context

1. .ai/handoffs/03/03AW-Architecture-Research.md
2. .ai/architecture/ai-infrastructure-restructuring.md
3. .ai/architecture/ai-project-instruction-architecture.md
4. .ai/architecture/decomposition-map.md
5. .ai/rules/repository.md
6. .ai/rules/handoff/lifecycle.md
7. .ai/rules/workflow.md
8. .ai/rules/commits.md
9. .ai/skills/commits/SKILL.md
10. .ai/workflows/handoff-bootstrap/BOOTSTRAP.md
