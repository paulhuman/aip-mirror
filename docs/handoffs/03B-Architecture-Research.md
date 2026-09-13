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

Continue the project-wide AI-instruction architecture work from 03A. The pre-change audit and migration/ownership map are complete, and Architecture Decision Pass v1 is complete conceptually. The current focus is formalizing applicability, activation, precedence, explicit `OVERRIDE`, and TRACE semantics before beginning the structural refactor.

## Current state

03B has completed the audit/design pass without changing the repository structure. The repository is still in the legacy/pre-refactor layout; the structural refactor has NOT yet been executed.

Reference forks compared:

- `paulhuman/codex` — `AGENTS.md` hierarchy and operational instruction model.
- `paulhuman/skills` — Agent Skills metadata/discovery/progressive disclosure model.
- `paulhuman/agent.md` — vendor-neutral conceptual comparison.

No additional reference fork is currently needed.

## Completed

### Migration / ownership map

- `.ai/rules/conversation-lifecycle.md` — RETAIN → REFACTOR; canonical lifecycle RULE.
- `.ai/rules/project-architecture.md` — RETAIN → REFACTOR; canonical architecture RULE.
- `.ai/rules/repository.md` — RETAIN → REFACTOR; canonical repository-safety RULE.
- `.ai/rules/workflow.md` — SPLIT/REFACTOR into general workflow RULE plus procedural WORKFLOW files.
- `.ai/skills/commit-message/SKILL.md` — RETAIN → REFACTOR; canonical commit-message SKILL.
- `.ai/skills/conversation-handoff/SKILL.md` — SPLIT/REFACTOR; conceptual capability remains SKILL while bootstrap becomes WORKFLOW.
- `.ai/skills/conversation-handoff/BOOTSTRAP.md` — MOVE to future `.ai/workflows/conversation-handoff/`; exact filename open.
- `.ai/skills/deep-understanding/SKILL.md` — RETAIN → REFACTOR; canonical research methodology SKILL.
- `docs/PROJECT-INSTRUCTIONS.md` — REDISTRIBUTE → DELETE only after extraction and verification.
- `docs/handoffs/README.md` — RETAIN → REFACTOR; human-facing handoff documentation.
- `docs/handoffs/*.md` — RETAIN; chapter state records.

Target additions:

- `AGENTS.md` — AI entry/router.
- `.ai/README.md` — AI instruction-system map/ontology.
- `.ai/config.json` — machine-readable metadata/config only, not policy.
- `.ai/rules/applicability.md` — applicability/activation/precedence model.
- `.ai/memory/` — selective durable AI-specific context.
- `.ai/workflows/` — ordered procedures.
- `.ai/extensions/trace/` — repository-defined TRACE extension specification.
- potentially `.ai/skills/consistency-pass/` — reusable consistency capability, pending scope/trigger decisions.

### Canonical ownership

One concept should have one canonical authority. Other files may reference, specialize, or operationalize it but must not silently redefine it.

- Lifecycle state machine → `.ai/rules/conversation-lifecycle.md`.
- Repository write safety → `.ai/rules/repository.md`.
- Commit message format → `.ai/skills/commit-message/SKILL.md`.
- Handoff execution → future `.ai/workflows/conversation-handoff/`.
- Research methodology → `.ai/skills/deep-understanding/SKILL.md`.
- Project architecture → `.ai/rules/project-architecture.md`.
- AI routing → `AGENTS.md` / `.ai/README.md`.
- Applicability/activation/precedence → future `.ai/rules/applicability.md`.
- Handoff state → `docs/handoffs/`.
- External evidence → `references/`.
- Durable project knowledge → appropriate `docs/` files.

## Architecture Decision Pass v1

- **AD-01:** Core = `RULE / SKILL / WORKFLOW / REFERENCE / MEMORY`; `EXTENSIONS` are separate repository-defined extensions.
- **AD-02:** RULE = policy/authority/constraint; SKILL = capability/methodology; WORKFLOW = ordered procedure.
- **AD-03:** REFERENCE = evidence/source, not instruction or authority.
- **AD-04:** MEMORY = durable context, not authority automatically.
- **AD-05:** HANDOFF is a cross-cutting lifecycle mechanism, not a core instruction type or optional extension; it spans RULE + WORKFLOW + state documents.
- **AD-06:** TRACE is an extension, likely `.ai/extensions/trace/`, with schema/events documentation and no runtime code required at this stage.
- **AD-07:** TRACE is observability, not authority. Candidate events: `📘 READ`, `🧭 APPLY`, `🛡️ CHECK`, `⚠️ WARNING`, `🔀 HANDOFF`, `💾 COMMIT`.
- **AD-08:** Applicability, Activation, and Precedence are distinct concepts.
- **AD-09:** A more-specific RULE does not automatically override a global RULE; by default it specializes it. `specificity ≠ authority`.
- **AD-10:** Explicit override may exist, but must be explicit, limited, explainable, and traceable; deeper files are not silent overrides.
- **AD-11:** Preliminary resolution order = `Applicability → Activation → Authority → Specificity → Conflict resolution`. Higher authority wins; specificity may specialize; explicit override is required to replace higher authority; unresolved conflicts must not be silently resolved and should surface through TRACE/WARNING.
- **AD-12:** `AGENTS.md` is the compact AI entry/router/map. `.ai/README.md` is the instruction-system map/ontology, not a second policy encyclopedia.
- **AD-13:** `.ai/config.json` contains machine-readable metadata/config only and must not duplicate policy.
- **AD-14:** Skills should be discoverable/activatable automatically from metadata/relevance; users should not have to name every skill. Automatic discovery does not mean mandatory activation.
- **AD-15:** Manual-only WORKFLOWs are valid; handoff is a principal example.
- **AD-16:** Target structure is approximately:

```text
AGENTS.md
.ai/
├── README.md
├── config.json
├── rules/
│   ├── applicability.md
│   ├── conversation-lifecycle.md
│   ├── project-architecture.md
│   ├── repository.md
│   └── workflow.md
├── skills/
├── workflows/
├── memory/
└── extensions/
    └── trace/
        ├── README.md
        ├── schema.md
        └── events.md
```

### Discovery versus authority

Discovery path:

`AGENTS.md → .ai/README.md → applicability → activation → RULE/SKILL/WORKFLOW`

Instruction authority comes from semantic role and precedence, not discovery order or directory depth. TRACE observes this process; it does not control authority.

### Extension model

`extensions/` means repository-defined extensions to the core AI instruction architecture, not vendor/plugin packages. Do not create `.ai/plugins/`. TRACE is a likely extension; HANDOFF remains built-in/core lifecycle.

## Architecture Decision Pass v2 — current checkpoint

The following principles were explicitly agreed while refining `OVERRIDE`, activation, and TRACE. They remain to be formalized in the canonical architecture files.

### Rule identity and explicit OVERRIDE

- Semantic RULE IDs are preferred as stable identifiers for rules, analogous to stable HTML `id` anchors.
- A semantic RULE ID should be independent of filename, filesystem path, or directory depth.
- `OVERRIDE` should be represented semantically in YAML/frontmatter rather than inferred from file location.
- Candidate declaration shape:

```yaml
---
id: REPO-EDIT-LOCAL-001
type: RULE

relation: OVERRIDE

override:
  target: REPO-EDIT-001
  reason: ...
---
```

- Candidate required fields are `id`, `type`, `relation`, `override.target`, and `override.reason`.
- `override.scope` remains an open design question.
- `OVERRIDE` is a source-to-target relation: the overriding rule explicitly identifies the semantic rule it replaces.
- `SPECIALIZE` is a distinct relation used to extend, narrow, or contextualize an applicable rule without replacing it.
- More-specific scope does not itself imply `OVERRIDE`.
- `specificity ≠ authority` remains a core principle.
- Proposed safety behavior is fail-closed for invalid or ambiguous override targets: do not apply the override; surface the problem as a warning/unresolved conflict.
- An `OVERRIDE` must target a specific semantic RULE ID; filename, path, directory depth, or specificity alone cannot constitute an override.

### Activation

- `activation` is distinct from `applicability`.
- Candidate simple activation states are `auto`, `manual`, and `hybrid`.
- Skills should generally be discoverable/activatable from metadata and relevance; manual-only workflows remain valid.
- No separate `activation.json` is currently planned; `.ai/config.json` remains system-level machine-readable configuration.

### TRACE

- TRACE remains observability only; it must not determine which rule wins.
- TRACE should explicitly represent `CONFLICT` and `OVERRIDE` events.
- `RESOLVE` is proposed as an additional event to make the resolution step observable without making TRACE the authority mechanism.
- Candidate event vocabulary now includes:

```text
DISCOVER
READ
APPLY
ACTIVATE
SPECIALIZE
OVERRIDE
CONFLICT
RESOLVE
WARNING
HANDOFF
COMMIT
```

The exact final vocabulary and event schema remain open until the dedicated TRACE design pass.

## Current implementation state

No structural architecture refactor has been committed. Work since bootstrap has been architecture/research/design only.

Relevant commits:

- `9d2cbaf` — `docs(handoff): initialize 03B architecture research draft`.
- `5548b2d` — `docs(handoff): mark 03A handoff handed off`.
- `628ac85e` — `docs(handoff): update 03B architecture research checkpoint`.

## Repository safety

For future repository changes:

1. read the current file;
2. preserve unrelated content during full-content replacement;
3. write complete intended content;
4. read back;
5. verify integrity, diff, and scope;
6. commit;
7. verify resulting ref/commit.

GitHub API writes to existing files may be full-content replacements, so successful API write alone is not proof of preservation.

## Open questions

- Whether `OVERRIDE` may be explicitly temporary (e.g. `temporary: true`) or should always represent a durable architectural declaration.
- Whether `override.scope` is needed, and if so, its exact semantics.
- Exact applicability schema and trigger representation.
- Exact responsibility split between `AGENTS.md` and `.ai/README.md`.
- Exact `.ai/config.json` schema.
- Final RULE/SKILL/WORKFLOW decomposition.
- Formal precedence and explicit-override syntax/semantics.
- Project Workshop hard `must not` boundaries and ownership.
- Initial `.ai/memory/` structure and its boundary with normal docs.
- Exact handoff bootstrap WORKFLOW destination/name/content.
- `consistency-pass` scope, triggers, report format, automatic/manual behavior.
- Exact redistribution map for `docs/PROJECT-INSTRUCTIONS.md` before deletion.
- Exact TRACE/mini-log implementation mechanism.
- Whether the preliminary precedence sequence should become normative unchanged.
- Whether `RESOLVE` belongs in the final TRACE event vocabulary.

## Evidence / confidence

### Confirmed / observed

- 03A is `HANDED_OFF`; 03B is active `DRAFT`.
- Audit and preliminary migration/ownership map are complete.
- AD-01 through AD-16 are conceptually established.
- Structural refactor has not yet begun.
- `codex`, Agent Skills, and vendor-neutral models were compared through existing forks.
- No additional fork is currently needed.

### Inferred

- Discovery/authority separation should make routing and conflicts more auditable.
- Compact `AGENTS.md` + `.ai/README.md` should prevent root instructions from becoming an encyclopedia.
- `consistency-pass` should help detect cascading contradictions after redistribution.
- Semantic TRACE events can provide the desired short real-time AI status/debug messages without becoming an authority layer.
- Stable semantic RULE IDs should make explicit overrides more robust than path- or depth-based semantics.
- Fail-closed handling of invalid/ambiguous overrides should prevent silent authority corruption.

### Assumed / unverified

- Actual runtime support for `AGENTS.md`, `.ai/README.md`, and `.ai/config.json` varies by host/tool.
- Exact mechanism for conversational AI to expose repository-defined TRACE events in real time is not established.
- Exact precedence/override syntax and applicability/config schemas remain unimplemented.
- Final TRACE event vocabulary is not yet fixed.

### Open

- Final normative precedence/override wording.
- Final workflow/skill/rule redistribution.
- Final machine-readable and TRACE schemas.
- Final refactor sequence and deletion gate for `docs/PROJECT-INSTRUCTIONS.md`.

## Last completed task

Captured the latest Architecture Decision Pass checkpoint for `OVERRIDE`, `SPECIALIZE`, semantic RULE IDs, activation states, and TRACE observability. The user agreed with the semantic YAML approach, stable RULE-ID targeting, the distinction between `SPECIALIZE` and `OVERRIDE`, `specificity ≠ authority`, simple activation states, and TRACE visibility for `CONFLICT` and `OVERRIDE`. The questions of temporary overrides, `override.scope`, and adding `RESOLVE` remain open for the next dedicated design pass.

## Immediate next task

When work resumes, perform the dedicated Architecture Decision Pass on explicit `OVERRIDE` first: settle temporary-vs-durable semantics, determine whether `override.scope` is necessary, and decide whether `RESOLVE` belongs in the TRACE vocabulary. Then formalize the resulting precedence/override model and continue with the applicability/activation schema and final structural migration plan.

## Things not to redo

- Do not redesign the chapter model or move handoffs out of `docs/handoffs/`.
- Do not edit another specialization's handoff from 03.
- Do not recreate 03A decisions from scratch.
- Do not blindly copy external repositories or Spectrum Web Components.
- Do not globally replace `should`/`may`; classify semantics case by case.
- Do not create `.ai/plugins/`.
- Do not treat HANDOFF as an optional extension or TRACE as authority.
- Do not begin native AIP implementation merely because this architecture refactor is underway.
- Do not delete `docs/PROJECT-INSTRUCTIONS.md` before redistribution and verification.
- Do not create a temporary transcript dump in `.ai/memory/`.
- Do not treat specificity, directory depth, or file location as an implicit override.

## Recommended starting context

Start from this checkpoint and the existing 03A/03B architecture work. The next substantive output should be the dedicated `OVERRIDE` Architecture Decision Pass, followed by formalization of precedence/override and then applicability/activation and TRACE schemas. Only after those semantics are sufficiently stable should structural file changes begin. When implementation begins, use small auditable changes with full read-back/diff verification after every existing-file replacement.
