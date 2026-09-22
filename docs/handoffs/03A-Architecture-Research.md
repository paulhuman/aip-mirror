# Conversation Handoff

Conversation:
AIP Mirror — 03A — Architecture & Research

Specialization:
03

Chapter:
A

Previous chapter:
N/A — first handoff for specialization 03

Status: HANDED_OFF
## Current objective

Refactor and clarify the project-wide AI-assisted development architecture before substantive native implementation expands. The immediate focus is to turn the existing rules, skills, handoff procedures, and project instructions into a coherent, non-duplicated AI instruction system with explicit applicability, ownership, observability, and lifecycle behavior.

This migration checkpoint preserves the architectural reasoning and audit state accumulated in 03A so 03B can continue without reconstructing it from the old conversation.

## Completed

- Established generic chapter patterns `01[A-Z]`, `02[A-Z]`, `03[A-Z]`, `04[A-Z]`; concrete chapters remain `03A`, `02B`, etc.
- Established that 03 may detect/report problems in other specializations' handoffs but must not edit them; the owning chapter corrects its own handoff.
- Agreed that handoffs remain under `docs/handoffs/` and `docs/handoffs/README.md` remains small and self-documenting.
- Agreed that `.ai/memory/` is for durable accumulated knowledge and is distinct from handoffs.
- Agreed target `.ai/` concepts: `README.md`, `config.json`, `rules/`, `skills/`, `workflows/`, `references/`, `memory/`.
- Agreed that `conversation-handoff/BOOTSTRAP.md` is procedurally a workflow and should move from `.ai/skills/` to `.ai/workflows/conversation-handoff/` during the refactor.
- Agreed that `.ai/rules/applicability.md` should define applicability and explicit trigger types.
- Agreed applicability categories: Always applicable, Task-applicable, Conditionally applicable.
- Agreed semantic `READ` means an applicable source was read as instruction/knowledge; `APPLY` means it materially affected the current action/decision; `CHECK` is a distinct verification event.
- Established mini-log vocabulary: `📘 READ`, `🧭 APPLY`, `🛡️ CHECK`, `⚠️ WARNING`, `🔀 HANDOFF`, `💾 COMMIT`.
- Agreed mini-logs are observable tracing of the applicability/workflow engine, not an unrelated feature.
- Studied `paulhuman/spectrum-web-components` as an architectural reference, including root `AGENTS.md`, `.ai/README.md`, `.ai/config.json`, rules/skills separation, workflows, memory, and `consistency-pass`.
- Studied the supplied `The-Complete-Guide-to-Building-Skill-for-Claude.pdf`; adopted relevant ideas: progressive disclosure, explicit triggers, concise skills, staged validation, iterative refinement, and positive/negative trigger testing.
- Identified `consistency-pass` as a useful capability to add.
- Agreed root `AGENTS.md` should be the primary AI entry point/router and `.ai/README.md` the AI system map.
- Agreed root `README.md` can contain human-facing project information.
- Agreed `docs/PROJECT-INSTRUCTIONS.md` is redundant and should ultimately be removed after necessary content is redistributed.
- Strengthened lifecycle/workflow wording so mandatory procedures use `must` intentionally and recommendations retain `should` where flexibility is intended.
- Explicitly decided not to globally replace `should` or `may`; retain them where they intentionally express recommendations, permission, or uncertainty.
- Confirmed standard checkpoint command: `Пора обновить handoff`.
- Confirmed standard migration command: `Пора выполнить миграцию в чат [0-9]{2}[A-Z]`.
- New user requirement: whenever AI proposes changing a handoff, AI should explicitly tell the user which of those two commands is appropriate, so the required user action is immediately unambiguous. This should become canonical rule/workflow behavior, not merely a conversational convention.

## Current implementation state

The repository is still in the pre-refactor AI-instruction layout. The conceptual target architecture is agreed, but the structural refactor has not yet been executed.

Current relevant files:

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
- `docs/handoffs/02A-Native-AIP-Plugin.md`
- `docs/handoffs/02B-Native-AIP-Plugin.md`
- `docs/handoffs/03A-Architecture-Research.md`

Target artifacts not yet created:

- root `AGENTS.md`
- `.ai/README.md`
- `.ai/config.json`
- `.ai/rules/applicability.md`
- structured `.ai/memory/` content
- `.ai/workflows/conversation-handoff/BOOTSTRAP.md`
- `consistency-pass` capability

`docs/handoffs/02B-Native-AIP-Plugin.md` remains owned by specialization 02 and must not be edited by 03.

## Audit checkpoint

### Target architecture

The intended system separates:

- `AGENTS.md` — root AI router/entry point; short and directs AI to canonical guidance.
- `.ai/README.md` — AI-facing system map explaining rules, skills, workflows, references, memory, and activation.
- `.ai/rules/` — constraints/invariants and project-wide policy.
- `.ai/skills/` — reusable task capabilities, activated by task/intent.
- `.ai/workflows/` — ordered procedures and lifecycle workflows.
- `.ai/references/` — supporting reference material.
- `.ai/memory/` — durable accumulated lessons/knowledge, not handoff state.
- `docs/handoffs/` — chapter-specific state snapshots and lifecycle records.
- root `README.md` — human-facing project information.

### Audit findings

1. `.ai` currently mixes reusable capabilities and ordered procedures: `conversation-handoff/BOOTSTRAP.md` is procedurally a workflow despite living under `skills/`.
2. Applicability logic is distributed across rules/skills rather than having an explicit applicability layer, making activation and observability harder to reason about.
3. `docs/PROJECT-INSTRUCTIONS.md` substantially overlaps with `.ai` guidance and risks becoming a second authority; remove it only after necessary content is redistributed.
4. Root `AGENTS.md` and `.ai/README.md` are missing, so there is no concise root router/system map.
5. `config.json` is not designed; it should hold machine-readable configuration where that adds deterministic value and must not become another prose authority.
6. Mini-logs should expose semantic source use and lifecycle events; exact implementation remains open.
7. `consistency-pass` is valuable because the refactor creates cascading consistency requirements across rules, skills, workflows, handoffs, paths, and activation semantics.
8. The `must` / `should` / `may` audit is semantic, not lexical: `must` for mandatory procedure; `should` for recommendations; `may` for permission/option or genuine uncertainty. No blanket replacement is justified.
9. The lifecycle system already defines both user commands. Future guidance should explicitly distinguish them whenever AI asks the user to act on a handoff.
10. The new command-guidance requirement belongs in canonical lifecycle/workflow/applicability guidance because it governs AI behavior across chapters.

### Decisions already made

- Keep handoffs in `docs/handoffs/`.
- Keep memory separate from handoffs.
- Use generic chapter notation `[0-9]{2}[A-Z]`.
- 03 may detect/report other handoff problems but cannot edit another specialization's handoff.
- Receiving chapter owns `READY_FOR_HANDOFF` → `HANDED_OFF`; later chapter owns `HANDED_OFF` → `SUPERSEDED` when required.
- Use explicit applicability categories and retain trigger type as a separate concept.
- Candidate trigger types: path/file scope, task/intent, conditional state, explicit user invocation.
- Treat `READ`, `APPLY`, and `CHECK` as different events.
- Use fixed mini-log vocabulary: `📘 READ`, `🧭 APPLY`, `🛡️ CHECK`, `⚠️ WARNING`, `🔀 HANDOFF`, `💾 COMMIT`.
- Use root `AGENTS.md` as router and `.ai/README.md` as system map.
- Add `consistency-pass`.
- Remove `docs/PROJECT-INSTRUCTIONS.md` after redistribution.
- Do not start native implementation merely because this refactor is underway.
- Do not create a temporary memory/transcript dump for migration; preserve semantic state in handoff.

### Open decisions for 03B

- Exact applicability schema: representation of categories and trigger types while keeping precedence, ownership, obligation, and observability separate.
- Exact `AGENTS.md` versus `.ai/README.md` boundary.
- Exact `.ai/config.json` schema and machine-readable fields.
- Final rule decomposition and merge/split plan.
- Whether the Project Workshop boundary should be an explicit hard `must not` rule and where it belongs.
- Initial `.ai/memory/` subsection/file structure and its boundary with normal project documentation.
- Exact destination/name for moved bootstrap workflow.
- `consistency-pass` scope, triggers, report format, and automatic/manual behavior.
- Exact content migration map for `docs/PROJECT-INSTRUCTIONS.md` before deletion.
- Exact mini-log implementation mechanism without unnecessary development overhead.
- Exact wording/placement of the command-guidance requirement so AI always tells the user whether the needed action is checkpoint or migration.

## Decisions

### Instruction ontology

- RULE — constraint or invariant.
- SKILL — reusable task capability.
- WORKFLOW — ordered procedure/lifecycle.
- REFERENCE — supporting knowledge.
- MEMORY — accumulated durable lessons/knowledge.
- HANDOFF — chapter-specific state snapshot.

Applicability, obligation level, precedence, ownership, and observability are separate concerns.

### Handoff command semantics

- `Пора обновить handoff` — update the current chapter's `DRAFT` checkpoint and remain in the current chapter.
- `Пора выполнить миграцию в чат [0-9]{2}[A-Z]` — finalize the current handoff for migration and initiate the receiving chapter bootstrap.

Whenever AI proposes a handoff change, future canonical guidance must make the required user command explicit. If only a checkpoint is needed, tell the user to issue `Пора обновить handoff`. If migration is needed, tell the user to issue `Пора выполнить миграцию в чат [0-9]{2}[A-Z]`, replacing the pattern with the concrete next chapter.

### AI entry points

`AGENTS.md` should route AI into `.ai/README.md` and applicable canonical sources rather than duplicate detailed instructions.

### Consistency

A reusable `consistency-pass` skill should provide explicit triggers, independent checks, a deterministic report format, and cascading consistency detection.

## Open questions

The next chapter should resolve the open decisions above through repository-backed audit and explicit design decisions rather than guessing.

## Current files

### AI rules/skills

- `.ai/rules/conversation-lifecycle.md`
- `.ai/rules/project-architecture.md`
- `.ai/rules/repository.md`
- `.ai/rules/workflow.md`
- `.ai/skills/commit-message/SKILL.md`
- `.ai/skills/conversation-handoff/BOOTSTRAP.md`
- `.ai/skills/conversation-handoff/SKILL.md`
- `.ai/skills/deep-understanding/SKILL.md`

### Documentation

- `docs/PROJECT-INSTRUCTIONS.md`
- `docs/handoffs/README.md`
- `docs/handoffs/02A-Native-AIP-Plugin.md`
- `docs/handoffs/02B-Native-AIP-Plugin.md`
- `docs/handoffs/03A-Architecture-Research.md`

### Relevant project areas

- `prototypes/jsx/`
- `references/freehand/`
- `references/javascript/`
- `references/test-data/`

### External references

- `paulhuman/adobe-illustrator-2026-sdk` — canonical Illustrator 2026 SDK reference.
- `paulhuman/spectrum-web-components` — architectural reference only.
- Supplied `The-Complete-Guide-to-Building-Skill-for-Claude.pdf` — skill-design reference only.

## Important constraints

- 03 may report another specialization's handoff problem but must not edit that handoff.
- Handoffs stay in `docs/handoffs/` and remain distinct from memory.
- Do not create a competing project-instructions authority during the refactor.
- Do not globally replace `should` or `may`.
- Do not mechanically copy Spectrum Web Components; adapt only justified ideas.
- Preserve repository write-safety: read existing files before full-content updates, then read back and verify integrity, diff, and scope.
- Lifecycle/handoff procedural commits are pre-authorized by workflow; ordinary development commits remain user-controlled unless explicitly delegated.
- Do not begin native implementation merely because this architecture refactor is underway.
- Do not use `.ai/memory/temp` or equivalent transcript dumps as a substitute for semantic handoff state.
- Future canonical guidance must make the required checkpoint-versus-migration user command explicit when AI requests a handoff-related action.

## Evidence / confidence

### Confirmed / observed

- 03A existed as a `DRAFT` checkpoint before this migration preparation.
- Current lifecycle rules define `[0-9]{2}[A-Z]` and statuses `DRAFT`, `READY_FOR_HANDOFF`, `HANDED_OFF`, `SUPERSEDED`.
- Current lifecycle rules define both standard user commands.
- Existing handoffs are under `docs/handoffs/` and `docs/handoffs/README.md` exists.
- Current bootstrap procedure lives under `.ai/skills/conversation-handoff/BOOTSTRAP.md`.
- Repository rules require full-content write verification for existing files.
- `docs/PROJECT-INSTRUCTIONS.md` overlaps substantially with the `.ai` system.
- `02B-Native-AIP-Plugin.md` is owned by specialization 02.

### Inferred

- Explicit applicability can reduce duplicated activation logic and make instruction usage auditable.
- Moving bootstrap into `.ai/workflows/` clarifies capability versus procedure.
- Root `AGENTS.md` plus `.ai/README.md` should provide a clearer AI entry path without duplicating detailed rules.
- `consistency-pass` can catch cross-file contradictions that local checks cannot reliably detect.
- Explicit command guidance should reduce ambiguity when AI requests user action around handoffs.

### Assumed / unverified

- Exact runtime support for root `AGENTS.md`, `.ai/README.md`, and `.ai/config.json` has not been established; these remain project conventions unless a runtime supports them.
- Exact `.ai/config.json` schema is not designed.
- Exact mini-log mechanism is not specified.
- Final applicability trigger schema is not specified.

### Open

- All open decisions listed above remain unresolved until 03B performs the repository-backed design work.

## Last completed task

Prepared and finalized the 03A migration checkpoint, consolidating the architecture-refactor state, audit findings, decisions, open design questions, constraints, research inputs, and the new user-command guidance requirement. The handoff is intended to be sufficient for 03B to continue without reconstructing the architecture discussion from the previous chat.

## Immediate next task

Bootstrap `03B` from this `READY_FOR_HANDOFF` handoff, perform the mandatory receiving-handoff consistency verification, and then continue the pre-change audit by producing the concrete migration map for every existing AI-facing file: `retain`, `rename`, `move`, `split`, `merge`, or `delete`; define canonical content ownership; and identify remaining contradictions or duplicated authority before executing the structural refactor.

## Things not to redo

- Do not redesign the four-specialization chapter model from scratch.
- Do not move handoffs out of `docs/handoffs/`.
- Do not edit another specialization's handoff from chapter 03.
- Do not mechanically copy the Spectrum Web Components AI structure.
- Do not treat the supplied skill guide as project authority.
- Do not recreate repository write-safety rules from memory.
- Do not recreate the semantic distinction between handoff checkpoint and migration command.
- Do not create a temporary transcript/memory dump simply to compensate for chat migration.

## Recommended starting context for next chapter

Start with this committed 03A handoff, then bootstrap `03B` using the canonical conversation-handoff procedure. After bootstrap verification, read the applicable lifecycle/workflow/repository/architecture guidance and perform the pre-change audit against the actual repository state. Treat this handoff as a semantic state snapshot, not a transcript. The first substantive deliverable in 03B should be the concrete AI-facing file migration/ownership map and its rationale; only then should structural file changes begin.
