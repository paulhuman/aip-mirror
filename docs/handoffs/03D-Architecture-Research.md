# Conversation Handoff

Conversation:
AIP Mirror — 03D — Architecture & Research

Specialization:
03

Chapter:
D

Previous chapter:
AIP Mirror — 03C — Architecture & Research

Status:
DRAFT

## Current objective

Continue the project-wide AI-instruction architecture research from 03C. The immediate focus is the **OVERRIDE Architecture Decision Pass**, followed by formalization of precedence/override, Applicability/Activation, and TRACE semantics. Structural refactoring remains deferred until these semantics are sufficiently stable.

## Completed

Bootstrap has established the canonical starting state from 03C. The 03C checkpoint records the completed OVERRIDE research/counterexample pass, including the durable-by-default temporary-override model, no `override.scope` decision, non-expansion of target applicability/authority, and the conservative unresolved-conflict baseline.

## Current implementation state

The repository remains in the legacy/pre-refactor AI-instruction layout. No structural architecture refactor has been executed. `docs/PROJECT-INSTRUCTIONS.md` remains a legacy aggregate and must be semantically redistributed and verified before deletion.

The current repository already contains the lifecycle/rule/skill material required to continue the architecture pass, including handoff reference preservation guidance.

## Decisions inherited from 03C

- `OVERRIDE` is a semantic relation, not an authority level.
- Declaring `OVERRIDE` does not itself grant permission.
- Effective override requires independently established authorization in applicable context; the exact authorization model remains open.
- Specificity does not create or strengthen override authority.
- OVERRIDE must not expand target applicability or authority.
- OVERRIDE is durable by default; temporary OVERRIDE must be explicit and auditable.
- `override.scope` is not part of the current architecture; Applicability + Activation + WORKFLOW semantics are the current restriction mechanisms.
- Multiple valid/authorized OVERRIDEs have no implicit winner; unresolved conflict fails closed.
- TRACE is observational and cannot grant authority or authorization.
- Handoff lifecycle and authorization lifecycle are separate state machines.
- Semantic RULE IDs should be independent of filename/path/depth.
- Project-agnosticity must be checked for resulting architecture decisions using `CORE / PROJECT-SPECIFIC / ADAPTABLE`.

## Open questions

- Exact semantics of authority/permission to establish and apply an OVERRIDE.
- Formal behavior for invalid, ambiguous, inactive, chained, and cyclic OVERRIDEs.
- Whether `RESOLVE` is a TRACE event and its semantic boundary.
- Final temporary OVERRIDE lifetime/expiration/revocation semantics and user-facing observability requirements.
- Which 03C hypotheses should be promoted to formal AD entries.
- Final precedence/override interaction with Applicability, Activation, Authority, and Specificity.
- TRACE event schema and provenance fields, including the role of `decision_id`.

## Current files

### Lifecycle / workflow

- `.ai/skills/conversation-handoff/BOOTSTRAP.md`
- `.ai/skills/conversation-handoff/SKILL.md`
- `.ai/rules/conversation-lifecycle.md`
- `.ai/rules/workflow.md`

### Architecture / research guidance

- `.ai/rules/project-architecture.md`
- `.ai/rules/repository.md`
- `.ai/rules/handoff-references.md`
- `.ai/skills/handoff-reference-preservation/SKILL.md`
- `.ai/skills/deep-understanding/SKILL.md`
- `.ai/skills/commit-message/SKILL.md`
- `docs/PROJECT-INSTRUCTIONS.md`

### Handoff chain

- `docs/handoffs/03A-Architecture-Research.md`
- `docs/handoffs/03B-Architecture-Research.md`
- `docs/handoffs/03C-Architecture-Research.md`
- `docs/handoffs/03D-Architecture-Research.md`

## Relevant references

### External AI-instruction / authorization research

- OpenAI Model Spec — Role: conceptual reference for authority, applicability, and instruction conflict/override semantics. URL: https://model-spec.openai.com/
- Anthropic Agent Skills specification — Role: reference for skill discovery, activation, and capability execution. URL: https://agentskills.io/specification
- GitHub Copilot custom instructions — Role: evidence for repository/path-specific instruction application without assuming specificity is automatic override. URL: https://docs.github.com/en/copilot/customizing-copilot/adding-repository-custom-instructions-for-github-copilot
- Cursor Rules — Role: reference for rule activation/context and enforcement distinctions. URL: https://docs.cursor.com/context/rules
- Model Context Protocol authorization — Role: reference for authorization, scope, expiration, and least privilege. URL: https://modelcontextprotocol.io/specification/draft/basic/authorization
- NIST ABAC — Role: reference for multi-attribute authorization rather than a single numeric authority model. URL: https://csrc.nist.gov/projects/attribute-based-access-control
- OpenFGA — Role: reference for relationship-based authorization and explicit permission relations. URL: https://openfga.dev/docs
- Open Policy Agent — Role: reference for policy evaluation, conflict handling, combining, and decision logging. URL: https://www.openpolicyagent.org/docs
- AWS Cedar — Role: comparative reference for explicit policy effects, default deny, determining policies, and diagnostics. URL: https://docs.cedarpolicy.com/
- W3C PROV — Role: provenance model relevant to future TRACE/decision provenance. URL: https://www.w3.org/TR/prov-overview/

### Project research repositories

- `paulhuman/codex` — Fork of `openai/codex`; Role: coding-agent architecture and repository-oriented workflow reference. URL: https://github.com/paulhuman/codex
- `paulhuman/skills` — Fork of `anthropics/skills`; Role: reusable skill structure/discovery reference. URL: https://github.com/paulhuman/skills
- `paulhuman/agent.md` — Role: agent instruction-file and repository guidance reference. URL: https://github.com/paulhuman/agent.md

### Project-specific references

- `paulhuman/adobe-illustrator-2026-sdk` — Role: canonical Illustrator 2026 SDK reference for AIP-related questions; reference-only, not copied into `aip-mirror`.
- `paulhuman/spectrum-web-components` — Role: architectural reference for AI-instruction system structure; not copied mechanically.
- `The-Complete-Guide-to-Building-Skill-for-Claude.pdf` — Role: skill-design reference used during earlier architecture research.

## Important constraints

- Do not restart broad OVERRIDE research unless a concrete unresolved semantic question requires new evidence.
- Do not introduce numeric, path-depth, discovery-order, or incidental ordering as hidden authority/precedence.
- Do not introduce `override.scope` without a dedicated architecture decision demonstrating a real need.
- Do not allow any future scope mechanism to expand target applicability or authority.
- Do not treat TRACE as authority.
- Do not globally replace `should` / `may`; classify their semantics case by case.
- Do not begin structural refactoring until the relevant semantics are sufficiently stable.
- Do not delete `docs/PROJECT-INSTRUCTIONS.md` before semantic redistribution and verification.
- Do not modify future-project repositories merely to test portability.
- Preserve repository write-safety: read current files, make minimal changes, write complete content, read back, verify content/diff/scope, then commit and verify the resulting ref.

## Evidence / confidence

### Confirmed / observed

- 03C is `READY_FOR_HANDOFF` and records the complete starting checkpoint for this chapter.
- 03B is `SUPERSEDED` and 03A is `SUPERSEDED`; the 03A → 03B → 03C lifecycle chain is coherent at bootstrap.
- No 03D handoff existed before this bootstrap, so this initial `DRAFT` is a normal receiving-chapter creation.
- 03C completed a counterexample pass for the emerging OVERRIDE safety model.
- No structural architecture refactor has been committed.

### Inferred

- The evidence accumulated in 03C is sufficient to begin a focused Architecture Decision Pass rather than broad exploratory research.
- A conservative fail-closed model is a useful baseline for unresolved OVERRIDE conflicts until explicit conflict semantics are accepted.

### Assumed / unverified

- The exact authorization semantics for OVERRIDE remain unverified and are not yet a project-wide formal decision.
- The final TRACE schema and temporary OVERRIDE lifetime schema remain unverified.

### Open

- All OVERRIDE/authorization/TRACE questions listed under Open questions remain open until explicitly resolved and documented.

## Last completed task

Completed receiving-chapter bootstrap from the `03C` READY_FOR_HANDOFF checkpoint and initialized this `03D` handoff as `DRAFT`.

## Immediate next task

Perform the **OVERRIDE Architecture Decision Pass**: resolve authorization semantics, invalid/ambiguous/inactive/chained/cyclic behavior, TRACE `RESOLVE` semantics, temporary override lifecycle/observability, and promotion of sufficiently validated conclusions into formal AD entries. Then apply the Project-Agnosticity Check before continuing to precedence/Applicability/Activation and TRACE schema work.

## Things not to redo

- Do not recreate 03A or 03B architecture decisions from scratch.
- Do not redesign the chapter/handoff model.
- Do not recreate the 03C OVERRIDE counterexample pass unless a new semantic question requires it.
- Do not treat specificity/path/depth as implicit override authority.
- Do not treat temporary OVERRIDE as implicitly inferred from context.
- Do not add `override.scope` without a new architecture decision.
- Do not begin structural refactoring prematurely.
- Do not begin native AIP implementation merely because architecture work continues.
- Do not copy every browsed URL into the handoff; preserve only materially relevant references with Roles.

## Recommended starting context for next chapter

Start with this `DRAFT` and `docs/handoffs/03C-Architecture-Research.md`. The lifecycle/bootstrap procedure has already been applied. Before substantive work, complete post-bootstrap verification against the repository state, then use the 03C research conclusions as the evidence base for the focused OVERRIDE Architecture Decision Pass.
