# Conversation Handoff

**Conversation:**
C027 — Architecture & Research

**Specialization:**
C

**Chapter:**
027

**Previous chapter:**
026

**Status:**
DRAFT

## Current objective

Analyze the current `.ai/INDEX.md` presentation and determine the minimum sufficient, scalable router/discovery structure before making any INDEX edits.

The bounded target is approximately 10–15 commands/capabilities. INDEX must remain a routing and discovery surface; canonical rules, skills, and workflows remain the semantic and procedural owners.

## Starting state

- Physical Iteration 2 restructuring is complete.
- Repository Identity & Path Resolution ownership is established.
- The active chapter identifier format is `[A-Z][0-9]{3}`.
- `.ai/INDEX.md` currently combines a user-facing command table with a capability-discovery map.
- Current command-table metadata includes command phrase, semantic operation, canonical owner, required reread targets, repository-state effect, and commit indication.
- The architecture record explicitly leaves the minimum semantic metadata boundary and scalable INDEX presentation open for this chapter.
- `.ai/AGENTS.md` currently contains only its heading and is therefore not to be treated as a substantive operating-contract source during this analysis unless the repository state changes later.

## Immediate next task

1. Read `.ai/INDEX.md`.
2. Read `.ai/architecture/ai-infrastructure-restructuring.md`, especially:
   - “Current .ai/INDEX.md model”
   - “Next Iteration 2 work plan — INDEX presentation and scalability”
3. Read `.ai/AGENTS.md`.
4. Read `.ai/rules/handoff/lifecycle.md`.
5. Read `.ai/skills/handoff/SKILL.md`.
6. Read `.ai/workflows/handoff/BOOTSTRAP.md`.
7. Inventory current command-routing and capability-discovery presentation.
8. Separate discovery information from routing metadata.
9. Test the minimum semantic metadata boundary and identify any shadow-owner semantics.
10. Design a compact presentation that can scale toward approximately 10–15 entries.
11. Only after the analysis is settled, decide whether an INDEX edit is justified.

If an INDEX edit is justified, use the repository-standard sequence: read → minimal edit → full write → read-back → semantic consistency sweep → diff/scope verification → commit → result verification.

## Relevant files

Primary analysis:

- `.ai/INDEX.md`
- `.ai/architecture/ai-infrastructure-restructuring.md`
- `.ai/AGENTS.md`

Canonical owners for validation:

- `.ai/config.yaml`
- `.ai/rules/repository.md`
- `.ai/rules/workflow.md`
- `.ai/rules/handoff/lifecycle.md`
- `.ai/rules/handoff/references.md`
- `.ai/rules/commits.md`
- `.ai/skills/handoff/SKILL.md`
- `.ai/skills/commits/SKILL.md`
- `.ai/workflows/handoff/BOOTSTRAP.md`

Previous handoff:

- `.ai/handoffs/C/C026-Architecture-Research.md`

Earlier same-specialization handoff checked during bootstrap:

- `.ai/handoffs/C/C025-Architecture-Research.md`

## Decisions and constraints

- INDEX identifies and routes; canonical owners define and execute.
- Do not duplicate canonical procedures inside INDEX.
- Do not create `ENTRY.md`.
- Do not change lifecycle semantics.
- Do not change BOOTSTRAP ownership or ordering.
- Do not change the chapter identifier format.
- Do not move project-specific configuration out of `.ai/config.yaml`.
- Do not restart physical Iteration 2 restructuring.
- Do not start the deferred handoff-operation / commit-vocabulary work.
- Do not freeze exact command IDs or final command syntax.
- Do not edit INDEX before the presentation and metadata analysis is settled.
- Preserve the distinction between discovery information, routing metadata, and canonical execution semantics.

## Open questions

- Which current INDEX fields are required for discovery?
- Which fields are required for safe routing once an operation is identified?
- Is `Repository state may change` necessary routing metadata, or can it be represented more compactly without becoming a shadow owner?
- Is `Commit` useful as routing metadata, or does its current wording risk owning commit semantics?
- Are `Required reread targets` routing metadata or a partial dependency graph, and what is the minimum useful form?
- Can command discovery and capability discovery share a compact presentation without creating a second registry/manifest layer?
- What presentation remains immediately usable at approximately 10–15 entries?

## Evidence / confidence

### Confirmed / observed

- Repository identity is `paulhuman/aip-mirror`, default branch `main`, from `.ai/config.yaml`.
- C026 was `READY_FOR_HANDOFF` before this bootstrap.
- `.ai/INDEX.md` is explicitly defined as a router/discovery surface.
- The current INDEX metadata set is intentionally preserved pending the minimum-semantic-metadata analysis.
- `.ai/workflows/handoff/BOOTSTRAP.md` is the canonical ordered bootstrap workflow.
- The lifecycle is `DRAFT → READY_FOR_HANDOFF → HANDED_OFF`.

### Inferred

- The INDEX presentation can likely be made more compact without introducing a new filesystem layer, but this must be demonstrated by analysis rather than assumed.
- The minimum semantic boundary may be smaller than the current table, but no field should be removed merely for visual compactness.

### Assumed / unverified

- The current six-field routing metadata set is not yet proven minimal.
- The final scalable presentation structure has not been selected.
- It is not yet known whether an INDEX edit will be justified.

## Things not to redo

- Physical Iteration 2 restructuring.
- Repository Identity & Path Resolution ownership pass.
- The decision to retain BOOTSTRAP as an independent ordered workflow.
- The decision not to create `ENTRY.md`.
- The current chapter identifier migration.
- The prior decision to preserve INDEX metadata pending evidence.

## Recommended starting context

Use the user-provided C027 bootstrap order as the authoritative starting sequence. Start with the current INDEX and architecture note, then validate against AGENTS, lifecycle, handoff skill, and BOOTSTRAP before consulting additional owners as needed.

The durable architectural question is:

> What is the minimum semantic information an INDEX router needs to discover and safely activate the canonical capability while remaining only a router and never becoming a shadow owner?
