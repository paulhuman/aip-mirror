# Conversation Handoff

Conversation:
AIP Mirror — 03B — Architecture & Research

Specialization:
03

Chapter:
B

Previous chapter:
AIP Mirror — 03A — Architecture & Research

Status:
DRAFT

## Current objective

Continue the project-wide AI-instruction architecture refactor from 03A. First complete the pre-change audit and produce a concrete migration/ownership map for the existing AI-facing files; then execute the structural refactor in coherent, verifiable steps.

## Starting state

03A has been finalized as `READY_FOR_HANDOFF`. Its checkpoint records the agreed architecture, audit findings, open decisions, constraints, and the new requirement that AI explicitly tell the user which handoff command is needed when requesting a handoff-related action.

The repository is still in the pre-refactor layout. No structural refactor should be assumed complete merely because the target architecture has been agreed.

## Relevant starting decisions

- Keep handoffs under `docs/handoffs/`; handoffs are chapter state, not memory.
- Use generic chapter identifiers `[0-9]{2}[A-Z]` with concrete chapters such as `03A` and `03B`.
- 03 may detect/report problems in other specializations' handoffs but must not edit them.
- Use ontology: RULE, SKILL, WORKFLOW, REFERENCE, MEMORY, HANDOFF.
- Use applicability categories: Always applicable, Task-applicable, Conditionally applicable.
- Keep trigger type separate from obligation, precedence, ownership, and observability; candidate trigger types are path/file scope, task/intent, conditional state, and explicit user invocation.
- Semantic tracing vocabulary: `📘 READ`, `🧭 APPLY`, `🛡️ CHECK`, `⚠️ WARNING`, `🔀 HANDOFF`, `💾 COMMIT`.
- Root `AGENTS.md` should be the AI router; `.ai/README.md` the AI system map.
- Add `.ai/config.json`, `.ai/rules/applicability.md`, structured `.ai/memory/`, workflows, and a reusable `consistency-pass` capability as justified by the audit.
- Move the procedural handoff bootstrap from `.ai/skills/conversation-handoff/BOOTSTRAP.md` to `.ai/workflows/conversation-handoff/`.
- Remove `docs/PROJECT-INSTRUCTIONS.md` only after all necessary content has been redistributed to canonical locations.
- Do not globally replace `should`/`may`; review them semantically.
- Do not start native implementation merely because this refactor is underway.

## Handoff command requirement

There are two distinct user commands:

- `Пора обновить handoff` — update the current `DRAFT` checkpoint and remain in the current chapter.
- `Пора выполнять миграцию в чат [0-9]{2}[A-Z]` — finalize the current handoff for migration and initiate the receiving chapter bootstrap.

Whenever AI proposes a handoff-related user action, canonical guidance must make clear which command the user should issue. For migration, use the concrete receiving chapter, e.g. `Пора выполнять миграцию в чат 03C`.

## Open design questions

- Exact applicability schema and trigger representation.
- Exact division of responsibility between root `AGENTS.md` and `.ai/README.md`.
- Exact `.ai/config.json` machine-readable schema.
- Final rule decomposition and merge/split map.
- Whether Project Workshop boundaries should include explicit hard `must not` constraints and where.
- Initial `.ai/memory/` structure and its boundary with normal project documentation.
- Exact destination/name and contents of the moved bootstrap workflow.
- `consistency-pass` scope, triggers, report format, and automatic/manual behavior.
- Exact redistribution map for `docs/PROJECT-INSTRUCTIONS.md` before deletion.
- Exact implementation mechanism for semantic mini-logs.

## Current implementation files to audit

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
- existing handoffs, treated as lifecycle/state records

## Important constraints

- Follow repository write safety: read existing file, make minimal intended full-content replacement, read back, verify integrity/diff/scope, commit, then verify ref.
- Lifecycle/handoff bootstrap commits are pre-authorized by workflow; ordinary development commits remain user-controlled unless explicitly delegated.
- Another specialization's handoff must not be edited from 03.
- Handoffs and memory must not become competing stores of the same state.
- Do not blindly copy Spectrum Web Components; use it only as architectural inspiration.
- Treat the supplied skill guide as reference, not project authority.
- Runtime support for `AGENTS.md`, `.ai/README.md`, and `.ai/config.json` is not yet established; these are project conventions unless a runtime supports them.

## Evidence / confidence

### Confirmed / observed

- 03A is `READY_FOR_HANDOFF` and contains the migration checkpoint.
- Current lifecycle rules define the chapter pattern, lifecycle states, both user commands, and post-bootstrap consistency verification.
- Current bootstrap is under `.ai/skills/conversation-handoff/BOOTSTRAP.md`.
- Current repository uses `docs/handoffs/` for chapter handoffs.
- The structural AI-instruction refactor has not yet been executed.

### Inferred

- Explicit applicability should make source activation and tracing more auditable.
- Root `AGENTS.md` + `.ai/README.md` should clarify AI entry and routing without duplicating detailed rules.
- `consistency-pass` should help detect cascading contradictions across the instruction system.

### Assumed / unverified

- Exact runtime behavior for the proposed root/config conventions.
- Exact applicability/config/mini-log implementation design.

## Immediate next task

Complete the pre-change repository audit and produce the concrete migration map for every existing AI-facing file: `retain`, `rename`, `move`, `split`, `merge`, or `delete`; identify canonical ownership for every important rule/procedure/knowledge area; and list contradictions or duplicated authority. Do not perform structural refactoring until this map is coherent.

## Things not to redo

- Do not redesign the chapter model.
- Do not move handoffs out of `docs/handoffs/`.
- Do not edit another specialization's handoff.
- Do not recreate the 03A architecture decisions from scratch.
- Do not blindly copy Spectrum Web Components.
- Do not globally replace `should`/`may`.
- Do not create a temporary transcript dump in `.ai/memory/`.

## Recommended starting context

Read this handoff and the 03A handoff, then read applicable lifecycle/workflow/repository/architecture guidance. Inspect the actual current files before designing the migration map. The first substantive 03B output should be the audit/migration/ownership map and its rationale; structural file changes come afterward.
