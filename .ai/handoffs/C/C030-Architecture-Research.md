# Conversation Handoff

**Conversation:**
C030 — Architecture & Research

**Specialization:**
C

**Chapter:**
030

**Previous chapter:**
029

**Status:**
DRAFT

## Current objective

Continue Architecture & Research from the verified C029 repository state.

C030 is the receiving chapter for C029. This handoff is the live checkpoint for the current conversation and will be updated as meaningful state accumulates.

## Starting state

C029 completed the bounded normative-language verification work and then began the next architecture question: progressive disclosure / Minimum Sufficient Execution Context (MEC).

The important correction made at the end of C029 was methodological: do not treat MEC as a pre-existing internal model architecture, and do not attempt to reason about the AI's hidden thinking process. Test only observable repository behavior: what context must actually be discovered to perform a concrete task correctly.

## Previous chapter

C029 — Architecture & Research.

Its handoff has been prepared as `READY_FOR_HANDOFF` during this self-migration and is expected to be transitioned to `HANDED_OFF` after this C030 handoff is created and verified.

## Important constraints

- Preserve the established AGENTS / INDEX / canonical-owner architecture.
- Do not recreate `ENTRY.md`.
- Do not reopen settled entry-layer decisions without new evidence.
- Preserve BOOTSTRAP ownership and lifecycle ordering.
- Treat `.ai/rules/normative-language.md` as the current canonical owner of normative-language conventions.
- Do not mechanically reopen the completed normative-language cleanup.
- Work from observable repository behavior, not speculation about hidden model reasoning.
- Treat MEC as a working research question, not as an already-established architecture component.
- Do not introduce a router, registry, manifest, command schema, or additional filesystem layer unless a bounded test demonstrates a concrete need.
- No repository changes for the MEC question until the tests produce a concrete architectural decision.
- Use current repository state as the source of truth.

## Evidence / confidence

### Confirmed / observed

- C028's normative-language work is complete and its handoff is `HANDED_OFF`.
- C029's normative-language verification was recorded in `.ai/architecture/ai-infrastructure-restructuring.md`.
- The current architecture model distinguishes AGENTS, INDEX, canonical rules/skills/workflows, and project-source routing.
- `docs/PROJECT-INSTRUCTIONS.md` explicitly defines workstreams as organizational boundaries rather than permanent knowledge ownership.
- `docs/PROJECT-INSTRUCTIONS.md` routes canonical project knowledge to its semantic owner and requires cross-workstream continuity through durable repository knowledge.
- No formal repository definition of `MEC`, `P-01`, `P-02`, or `P-03` was found; those labels are not established repository specifications.
- C029's final active research direction was to replace abstract MEC speculation with simple observable tests.

### Inferred

- The existing AGENTS → INDEX → canonical-owner topology may already provide sufficient progressive disclosure for concrete tasks.
- Any additional MEC layer should earn its existence through a demonstrated failure or discoverability gap.

### Open

- Whether the minimum context required for concrete operations can be measured from bounded tests.
- Whether the tests reveal any missing routing/discoverability mechanism.
- Whether the current architecture needs any change at all.

## Immediate next task

Run the bounded progressive-disclosure tests:

1. **T1 — repository write-safety owner discovery:** start from the normal entry context and determine whether the canonical repository write-safety rule can be found without prior knowledge of its path.
2. **T2 — INDEX-routed handoff operation:** start from the normal entry context and determine whether a handoff operation leads to the required lifecycle/skill/workflow sources without the answer being pre-known.
3. **T3 — cross-workstream project knowledge:** start from the normal entry context and `docs/PROJECT-INSTRUCTIONS.md`, then follow semantic-owner routing to the canonical project architecture source without a special privileged workstream router.

For each test record only:
- starting context;
- sources actually required;
- whether discovery succeeded;
- the exact gap, if any.

Do not infer hidden model internals from the result.

## Things not to redo

- C027 entry-layer restructuring.
- The AGENTS entry-contract decision.
- The INDEX minimum-routing decision.
- The decision not to create `ENTRY.md`.
- BOOTSTRAP ownership and ordering.
- The current chapter identifier format.
- The completed normative-language inventory/classification/cleanup unless new evidence directly requires it.
- Do not mechanically capitalize remaining lowercase `must`, `should`, or `may`.
- Do not convert the historical/deferred MEC discussion into a formal architecture object merely by naming it.

## Recommended starting context

- `.ai/AGENTS.md`
- `.ai/INDEX.md`
- `.ai/rules/repository.md`
- `.ai/rules/workflow.md`
- `.ai/rules/handoff/lifecycle.md`
- `.ai/rules/normative-language.md`
- `.ai/skills/handoff/SKILL.md`
- `.ai/workflows/handoff/BOOTSTRAP.md`
- `.ai/architecture/ai-infrastructure-restructuring.md`
- `docs/PROJECT-INSTRUCTIONS.md`
- `docs/architecture/project-architecture.md`
