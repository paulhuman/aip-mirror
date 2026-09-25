# Conversation Handoff

Conversation:
AIP Mirror — 03AY — Architecture & Research

Specialization:
03 — Architecture & Research

Chapter:
03AY

Previous chapter:
03AX — Architecture & Research

Status:
DRAFT

## Starting objective

Continue Iteration 2 from the current repository state after the first repository-wide consistency sweep.

The immediate task is to inspect and repair the bounded set of project-specific leakage and ownership inconsistencies identified by 03AX. Do not return to semantic-comparison or target-tree planning.

## Durable context

- `.ai/architecture/ai-infrastructure-restructuring.md` — current Iteration 2 architecture and migration context.
- `docs/architecture/iteration-2-consistency-sweep.md` — current sweep findings, classifications, and repair plan.
- Historical architecture research is preserved under `.ai/archive/architecture/` and is not active operational context unless specifically needed.

## Current architectural boundary

- `.ai/` is intended to become project-agnostic AI working infrastructure.
- `docs/` contains AIP Mirror project knowledge and project-specific decisions.
- Workstreams are organizational areas represented by separate AI conversations, not autonomous agents.
- Handoff lifecycle is exactly `DRAFT → READY_FOR_HANDOFF → HANDED_OFF`.
- `SUPERSEDED` is not a lifecycle state.
- Do not introduce `ENTRY.md`.
- Do not use `bootstrap kernel` as an architectural term.

## Post-edit consistency requirement

After every MOVE, RENAME, DECOMPOSE, or canonical-owner change:

1. search for old paths, filenames, owners, obsolete terms, duplicated normative wording, stale identifiers, bootstrap references, and routing targets;
2. classify relevant hits semantically;
3. repair actual inconsistencies or deliberately preserve valid historical references;
4. read back changed files;
5. inspect diff and scope;
6. commit;
7. verify the resulting repository state.

## 03AX sweep results

Clean findings:

- no active `SUPERSEDED` residue;
- no active `bootstrap kernel` terminology;
- no active `ENTRY.md` layer;
- no old `docs/handoffs/` routing requiring repair;
- no stale active references to the archived architecture files.

Repair frontier:

1. `.ai/rules/repository.md` — contains concrete AIP Mirror and Adobe Illustrator SDK repository identity. This is an architectural ownership question; do not fix by blind replacement.
2. `.ai/rules/handoff/references.md` — contains project-specific repository identity; likely generic-rule leakage.
3. `.ai/rules/handoff/lifecycle.md` — contains project-specific framing although lifecycle semantics are generic.
4. `.ai/rules/workflow.md` — contains project-specific framing although workflow guidance is generic.
5. `.ai/skills/commits/SKILL.md` — mixed generic procedure and project-specific references; inspect each occurrence.
6. `.ai/skills/deep-understanding/SKILL.md` — AIP Mirror / Adobe Illustrator / JSX / FreeHand references; probable project leakage.
7. `.ai/skills/handoff/SKILL.md` — mixed generic capability and project-specific wording.
8. `.ai/workflows/independent-review/` — project-specific model-review onboarding/configuration; determine whether reusable mechanism and project configuration should be separated.

## Important architectural question

The target is not merely “remove the words AIP Mirror from `.ai`”. The stronger rule is:

> Generic `.ai` rules, skills, and workflows must remain reusable without project-specific knowledge or embedded project configuration.

The repository identity case is therefore the key boundary question:

> Where should project-specific repository identity live when repository safety and path-resolution mechanics remain reusable infrastructure?

Resolve this deliberately before editing `.ai/rules/repository.md`.

## Required next sequence

1. Read the affected files in context.
2. Classify each project-specific occurrence as reusable mechanism, project configuration, illustrative example, historical evidence, or stale duplication.
3. Decide repository-identity ownership.
4. Repair generic rules/skills without weakening required operational context.
5. Decide the ownership of independent-review onboarding/configuration.
6. Run a second repository-wide consistency sweep.
7. Only after the repaired repository is internally coherent, review `AGENTS.md` and `.ai/INDEX.md` entry surfaces.


## TODO — recover external repository references from 03 handoffs

Review the complete 03 handoff lineage for explicit external repository references, especially repositories created or forked specifically for project research/work.

For each discovered repository:
- preserve the repository identifier;
- preserve the repository's documented role;
- add it to .ai/config.yaml under references.repositories;
- do not add a reference merely because it is project-specific: it must have a concrete consumer in generic .ai infrastructure;
- distinguish canonical/reference repositories from research forks through the documented role, not by duplicating URL-only metadata.

Initial recovered research forks:
- paulhuman/codex
- paulhuman/skills
- paulhuman/agent.md

This TODO was created because these repositories were found embedded in historical 03 handoffs and had not been preserved in the new configuration layer.

## Things not to redo

- Do not reconstruct 03AU/03AV/03AW from conversation history.
- Do not restart semantic comparison.
- Do not rebuild the old target tree.
- Do not repeat completed physical moves.
- Do not recreate old `docs/handoffs/` paths.
- Do not restore repository path resolution to `docs/PROJECT-INSTRUCTIONS.md` without new evidence.
- Do not reintroduce `SUPERSEDED`.
- Do not introduce `ENTRY.md` without new evidence.
- Do not start the handoff-operation / commit-vocabulary TODO yet.
