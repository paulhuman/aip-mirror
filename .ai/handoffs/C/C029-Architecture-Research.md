# Conversation Handoff

**Conversation:**
C029 — Architecture & Research

**Specialization:**
C

**Chapter:**
029

**Previous chapter:**
028

**Status:**
DRAFT

## Current objective

Continue Architecture & Research from the verified C028 repository state.

C029 is the receiving chapter for C028. This handoff is the live checkpoint for the current conversation and will be updated as meaningful state accumulates.

## Starting state

C028 completed the bounded normative-language consistency work:

- established `.ai/rules/normative-language.md`;
- applied the semantic distinction between BCP 14 normative vocabulary and local procedural `DO / DO NOT`;
- completed targeted cleanup and consistency verification;
- preserved ordinary lowercase English, historical/research narrative, and ambiguous cases where they are not normative;
- prepared its handoff for transition to C029.

The current repository state, not the historical C028 conversation, is the source of truth.

## Previous chapter

C028 — Architecture & Research.

Its handoff is expected to be transitioned to `HANDED_OFF` as part of this self-migration after this C029 handoff is created.

## Important constraints

- Preserve the established AGENTS / INDEX / canonical-owner architecture.
- Do not recreate `ENTRY.md`.
- Do not reopen settled entry-layer decisions without new evidence.
- Preserve BOOTSTRAP ownership and lifecycle ordering.
- Treat `.ai/rules/normative-language.md` as the current canonical owner of normative-language conventions.
- Do not mechanically reopen the completed normative-language cleanup.
- Use current repository state as the source of truth.

## Evidence / confidence

### Confirmed / observed

- C028's handoff was reconstructed from the verified repository state and prepared for handoff.
- The normative-language RULE exists in the repository.
- The targeted cleanup and consistency work has been committed and verified.
- C029 is the current active Architecture & Research conversation.

### Inferred

- The next useful Architecture & Research task should be selected from current repository evidence rather than inherited automatically from older deferred TODOs.

### Open

- Whether the progressive-disclosure / Minimum Sufficient Execution Context question can be resolved by simple observable repository tests rather than abstract analysis.
- What minimum repository context is actually required to perform concrete operations correctly.
- Whether any discoverability gap appears in those tests; do not introduce a new router/registry/manifest layer without evidence.

## Immediate next task

Run the bounded progressive-disclosure tests against observable repository behavior. Start with simple concrete operations rather than model-internal reasoning: (1) repository write-safety owner discovery, (2) INDEX-routed handoff operation discovery, and (3) cross-workstream project-knowledge routing. Record only the context actually required by each test. Treat MEC as a working question, not an established architecture object. Do not make repository changes until the tests produce a concrete architectural decision.

## Recommended starting context

- `.ai/AGENTS.md`
- `.ai/INDEX.md`
- `.ai/rules/repository.md`
- `.ai/rules/workflow.md`
- `.ai/rules/handoff/lifecycle.md`
- `.ai/rules/normative-language.md`
- `.ai/architecture/ai-infrastructure-restructuring.md`
- `docs/PROJECT-INSTRUCTIONS.md`
- `docs/architecture/project-architecture.md`

Do not assume that older conversation context is required to continue.
