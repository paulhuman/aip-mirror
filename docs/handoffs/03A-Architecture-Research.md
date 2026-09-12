# Conversation Handoff

Conversation:
AIP Mirror — 03A — Architecture & Research

Specialization:
03

Chapter:
A

Previous chapter:
N/A — first handoff for specialization 03

Status:
DRAFT

## Current objective

Refactor and clarify the project-wide AI-assisted development architecture before substantive native implementation expands. Focus: rules, skills, workflows, applicability, observability, references, memory, and conversation handoffs.

## Completed

- Established generic chapter patterns `01[A-Z]`, `02[A-Z]`, `03[A-Z]`, `04[A-Z]`.
- Established that 03 may detect/report problems in other specializations' handoffs but must not edit them; the owning chapter corrects its own handoff.
- Agreed that handoffs remain under `docs/handoffs/` and `docs/handoffs/README.md` remains small and self-documenting.
- Agreed that `.ai/memory/` is needed for durable accumulated knowledge, but handoffs are not memory.
- Agreed on the target `.ai/` concepts: `README.md`, `config.json`, `rules/`, `skills/`, `workflows/`, `references/`, and `memory/`.
- Agreed that `conversation-handoff/BOOTSTRAP.md` is a workflow artifact and should move from `.ai/skills/` to `.ai/workflows/conversation-handoff/` during the refactor.
- Agreed that `.ai/rules/applicability.md` should define applicability and include explicit trigger types.
- Agreed on applicability categories: Always applicable, Task-applicable, and Conditionally applicable.
- Agreed that semantic `READ` means an applicable source was read as instruction/knowledge, while `APPLY` means it materially affected the current action or decision. `CHECK` remains a distinct verification event.
- Established mini-log vocabulary: `📘 READ`, `🧭 APPLY`, `🛡️ CHECK`, `⚠️ WARNING`, `🔀 HANDOFF`, `💾 COMMIT`.
- Agreed that mini-logs are observable tracing of the applicability/workflow engine.
- Studied `paulhuman/spectrum-web-components` as an architectural reference, including `AGENTS.md`, `.ai/README.md`, rules/skills separation, workflows, config, and consistency-pass.
- Studied the supplied skill-building guide and adopted relevant ideas: progressive disclosure, explicit triggers, concise skills, staged validation, iterative refinement, and positive/negative trigger testing.
- Identified `consistency-pass` as a useful capability to add.
- Agreed that root `AGENTS.md` should be the primary AI entry point/router and `.ai/README.md` the AI system map.
- Agreed that root `README.md` can contain human-facing project information.
- Agreed that `docs/PROJECT-INSTRUCTIONS.md` is redundant and should ultimately be removed after necessary content is redistributed.
- Strengthened lifecycle/workflow wording so mandatory procedures use `must` intentionally and recommendations retain `should` where flexibility is intended.

## Current implementation state

The repository still has the pre-refactor AI-instruction layout. Current authoritative files include:

- `.ai/rules/conversation-lifecycle.md`
- `.ai/rules/project-architecture.md`
- `.ai/rules/repository.md`
- `.ai/rules/workflow.md`
- `.ai/skills/commit-message/SKILL.md`
- `.ai/skills/conversation-handoff/BOOTSTRAP.md`
- `.ai/skills/conversation-handoff/SKILL.md`
- `.ai/skills/deep-understanding/SKILL.md`
- `docs/PROJECT-INSTRUCTIONS.md`
- `docs/handoffs/README.md`

The refactor is agreed conceptually but has not yet been executed. `AGENTS.md`, `.ai/README.md`, `.ai/config.json`, `.ai/rules/applicability.md`, and `.ai/memory/` have not yet been created for this refactor.

`docs/handoffs/02B-Native-AIP-Plugin.md` remains owned by specialization 02 and must not be edited by 03.

## Decisions

### Instruction ontology

- RULE — constraint or invariant.
- SKILL — reusable task capability.
- WORKFLOW — ordered procedure/lifecycle.
- REFERENCE — supporting knowledge.
- MEMORY — accumulated durable lessons/knowledge.
- HANDOFF — chapter-specific state snapshot.

### Applicability

Applicability, obligation level, precedence, ownership, and observability are separate concerns. Trigger type should explain why a source is applicable rather than collapsing all behavior into prose. Candidate trigger types include path/file scope, task/intent, conditional state, and explicit user invocation. Exact schema remains open.

### Handoffs

Handoffs remain in `docs/handoffs/`. `.ai/memory/` must not become a second handoff system.

### AI entry points

`AGENTS.md` should route AI into `.ai/README.md` and applicable canonical sources rather than duplicate detailed instructions.

### Consistency

A reusable `consistency-pass` skill should provide explicit triggers, independent checks, a deterministic report format, and cascading consistency detection.

## Open questions

- Exact schema for `.ai/rules/applicability.md` and trigger types.
- Exact boundaries between `AGENTS.md` and `.ai/README.md`.
- Exact `.ai/config.json` schema and machine-readable data.
- Final rule decomposition and any merge/split operations.
- Whether the Project Workshop boundary should be a hard `must not` rule.
- Initial `.ai/memory/` subsection structure.
- Exact destination/name for the moved bootstrap workflow.
- Scope and trigger model of `consistency-pass`.
- Which content from `docs/PROJECT-INSTRUCTIONS.md` must be preserved before deletion.
- Exact representation of mini-log behavior without unnecessary development overhead.

## Current files

AI rules/skills:
- `.ai/rules/conversation-lifecycle.md`
- `.ai/rules/project-architecture.md`
- `.ai/rules/repository.md`
- `.ai/rules/workflow.md`
- `.ai/skills/commit-message/SKILL.md`
- `.ai/skills/conversation-handoff/BOOTSTRAP.md`
- `.ai/skills/conversation-handoff/SKILL.md`
- `.ai/skills/deep-understanding/SKILL.md`

Documentation:
- `docs/PROJECT-INSTRUCTIONS.md`
- `docs/handoffs/README.md`
- `docs/handoffs/02A-Native-AIP-Plugin.md`
- `docs/handoffs/02B-Native-AIP-Plugin.md`

Relevant project areas:
- `prototypes/jsx/`
- `references/freehand/`
- `references/javascript/`
- `references/test-data/`

External reference:
- `paulhuman/adobe-illustrator-2026-sdk`

## Important constraints

- 03 may report another specialization's handoff problem but must not edit that handoff.
- Handoffs stay in `docs/handoffs/` and remain distinct from memory.
- Do not create a competing project-instructions authority during the refactor.
- Do not globally replace `should` or `may`; preserve them where they intentionally express recommendations, permission, or uncertainty.
- Do not mechanically copy Spectrum Web Components; adapt only justified ideas.
- Preserve repository write-safety: read existing files before full-content updates, then read back and verify integrity, diff, and scope.
- Do not begin native implementation merely because this architecture refactor is underway.

## Evidence / confidence

### Confirmed / observed

- No root `AGENTS.md` currently exists.
- Existing handoffs are under `docs/handoffs/` and `docs/handoffs/README.md` exists.
- Current handoff procedure lives in `.ai/skills/conversation-handoff/`.
- Current lifecycle rules use `[0-9]{2}[A-Z]` and statuses `DRAFT`, `READY_FOR_HANDOFF`, `HANDED_OFF`, `SUPERSEDED`.
- Current lifecycle rules contain both standard checkpoint and migration commands.
- Current repository rules require full-content write verification for existing files.
- `docs/PROJECT-INSTRUCTIONS.md` overlaps substantially with the `.ai` system.

### Inferred

- An explicit applicability layer can reduce duplicated activation logic and make instruction usage auditable.
- Moving bootstrap into `.ai/workflows/` clarifies capability versus procedure.
- Root `AGENTS.md` plus `.ai/README.md` should provide a clearer AI entry path without duplicating detailed rules.

### Assumed / unverified

- The exact `.ai/config.json` schema is not designed yet.
- Runtime support for `AGENTS.md`, `.ai/README.md`, and `.ai/config.json` has not been established; these are project conventions unless a specific runtime supports them.
- The mini-log implementation mechanism is not specified yet.

### Open

- See the Open questions section.

## Last completed task

Agreed on the target high-level AI architecture: retain `docs/handoffs/`, add structured `.ai/memory/`, add applicability with trigger types, make mini-logs observable workflow tracing, move bootstrap into `.ai/workflows/`, add `consistency-pass`, introduce root `AGENTS.md` plus `.ai/README.md`, and remove redundant `docs/PROJECT-INSTRUCTIONS.md` after redistribution.

## Immediate next task

Complete the pre-change audit and produce the concrete migration map for every existing AI-facing file: retain, rename, move, split, merge, or delete; define content ownership; and identify contradictions or duplicated authority before making repository changes.

## Things not to redo

- Do not redesign the four-specialization chapter model from scratch.
- Do not move handoffs out of `docs/handoffs/`.
- Do not edit another specialization's handoff from chapter 03.
- Do not mechanically copy the Spectrum Web Components AI structure.
- Do not treat the supplied skill guide as project authority.
- Do not recreate repository write-safety rules from memory.

## Recommended starting context for next chapter

Continue the AI-instruction architecture audit from the existing repository state. Map current `.ai/` content and overlapping material in `docs/PROJECT-INSTRUCTIONS.md`, then design the target routing, applicability schema, config, rule/skill/workflow boundaries, memory structure, and consistency-pass capability while preserving explicit ownership and lifecycle boundaries.
