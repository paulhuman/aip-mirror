# Conversation Handoff

**Conversation:**
C0029 — Architecture & Research

**Specialization:**
C

**Chapter:**
029

**Previous chapter:**
028

## Current objective

Complete the bounded normative-language consistency work identified after the C0028 entry-layer architecture work, establish the project's normative-language rule, normalize active normative/procedural wording without changing semantic ownership, and leave the repository ready for the next Architecture & Research chapter.

## Completed work

### Normative-language model

Established and applied the project convention:

- BCP 14 normative keywords: `MUST`, `MUST NOT`, `SHOULD`, `SHOULD NOT`, `MAY`.
- Procedural vocabulary: `DO`, `DO NOT`.
- `DO / DO NOT` are local procedural vocabulary, not BCP 14 keywords.
- Lowercase `must`, `should`, and `may` remain ordinary English when they do not express normative meaning.
- Normative prohibition is expressed as `MUST NOT`; `MUST NEVER` is not a project keyword.
- Markdown emphasis is not an alternative normative syntax.
- Blind search-and-replace is not an acceptable normalization method.

The semantic classification used four categories:

- NORMATIVE
- PROCEDURAL
- ORDINARY_ENGLISH
- AMBIGUOUS

### Normative-language RULE

Created:

`.ai/rules/normative-language.md`

The RULE defines scope, BCP 14 vocabulary, procedural vocabulary, case/emphasis handling, ordinary English, the semantic test, prohibition wording, and relationship to other project rules.

The RULE itself was self-reviewed for consistency.

### Targeted cleanup and consistency sweep

Applied the convention to the active scoped documentation and infrastructure files.

Scope:

- all active `.ai/**`, excluding `.ai/archive/**`;
- `.ai/handoffs/README.md`;
- all `docs/**`;
- other handoff files were excluded.

The cleanup deliberately preserved lowercase ordinary English, questions, and historical/research narrative where the words were not normative.

Alternative normative forms and Markdown-emphasis variants were checked and removed where they expressed normative meaning.

## Current repository state

The repository now contains the normative-language RULE and the corresponding targeted cleanup.

The cleanup is intentionally bounded. It does not reopen the completed AGENTS/INDEX architecture work, BOOTSTRAP ownership, or other previously settled architecture decisions.

## Important decisions

- Current repository state remains the source of truth.
- Normative capitalization is semantic, not lexical.
- `MUST NOT` is the canonical prohibition form.
- `DO NOT` is retained for procedural instructions.
- Ordinary lowercase English remains valid.
- Historical/research material is not mechanically rewritten into normative language.
- Do not treat remaining lowercase occurrences as cleanup defects without semantic review.

## Evidence / confidence

### Confirmed / observed

- C0028's entry/routing architecture remains the current baseline.
- The normative-language RULE exists in the repository.
- The targeted cleanup was reviewed by scope and semantic classification.
- `.ai/archive/**` was not included in the cleanup scope.
- Handoff files other than `.ai/handoffs/README.md` were not included in the cleanup scope.
- The final repository state was read back after the cleanup commits.

### Inferred

- The normative-language convention is sufficiently stable to serve as the canonical project rule for future documentation edits.
- Remaining lowercase occurrences should generally be treated as ordinary English or context-dependent material unless semantic review shows otherwise.

### Open

- Whether future architecture work reveals additional normative-language edge cases requiring a small RULE refinement.
- The next bounded Architecture & Research question after this documentation consistency work.

## Things not to redo

- C0028 entry-layer restructuring.
- The AGENTS entry-contract decision.
- The INDEX minimum-routing decision.
- The decision not to create `ENTRY.md`.
- BOOTSTRAP ownership and ordering.
- The current chapter identifier format.
- The completed normative-language inventory/classification/cleanup unless new evidence directly requires it.
- Do not mechanically capitalize every remaining lowercase `must`, `should`, or `may`.

## Immediate next task

C0030 should begin from the current repository state and choose the next bounded Architecture & Research task. The normative-language cleanup itself is complete; do not reopen it without new evidence.

## Recommended starting context

Read the current entry-layer and architecture material as needed, especially:

- `.ai/AGENTS.md`
- `.ai/INDEX.md`
- `.ai/rules/handoff/lifecycle.md`
- `.ai/rules/normative-language.md`
- `.ai/architecture/ai-infrastructure-restructuring.md`
- `docs/PROJECT-INSTRUCTIONS.md`
- `docs/architecture/project-architecture.md`

Use the current repository as the source of truth rather than reconstructing C0029 from conversation history.
