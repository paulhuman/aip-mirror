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
HANDED_OFF

## Starting objective

Continue Iteration 2 from the current repository state after the first repository-wide consistency sweep.

The immediate task is to inspect and repair the bounded set of project-specific leakage and ownership inconsistencies identified by 03AX. Do not return to semantic-comparison or target-tree planning.

## Durable context

- `.ai/architecture/ai-infrastructure-restructuring.md` — current Iteration 2 architecture and migration context.
- `.ai/config.yaml` — current project configuration and recovered external repository references.
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

The 03AX repair frontier has been worked through in 03AY.

Completed:
- genericized the active repository, workflow, commit, deep-understanding, and handoff infrastructure where project-specific leakage was confirmed;
- separated project repository identity/configuration into `.ai/config.yaml`;
- preserved repository path-resolution and safety mechanics in `.ai/rules/repository.md`;
- centralized Chapter Identifier Format ownership in `.ai/rules/handoff/lifecycle.md`;
- repaired stale operational references exposed by the 03AU–03AY consistency pass;
- reduced independent-review onboarding to the current reusable workflow surface;
- verified remaining checked historical matches are legitimate migration history rather than active operational references.

The remaining frontier is semantic ownership analysis of the active repository-identity and path-resolution consumers. This is the next chapter's assignment.

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


## External repository reference recovery — completed

The external repository references recovered from the 03 handoff lineage have been recorded in `.ai/config.yaml` under `references.repositories`, with their documented roles.

Recovered research/reference repositories include:
- `paulhuman/adobe-illustrator-2026-sdk`
- `paulhuman/spectrum-web-components`
- `paulhuman/codex`
- `paulhuman/skills`
- `paulhuman/agent.md`

No further recovery work remains in this TODO.

## Migration boundary

03AY is complete enough to hand off. The receiving chapter should continue from the repository state represented by this handoff and the durable architecture notes; it should not create a future chapter handoff as part of bootstrap.

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
