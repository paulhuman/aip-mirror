# Conversation Handoff

Conversation:
AIP Mirror — 03C — Architecture & Research

Specialization:
03

Chapter:
C

Previous chapter:
AIP Mirror — 03B — Architecture & Research

Status:
DRAFT

## Starting objective

Continue the project-wide AI-instruction architecture work from 03B. The immediate task is the dedicated **OVERRIDE Architecture Decision Pass**, followed by formalization of precedence/override, applicability/activation, and TRACE semantics. Structural refactoring must wait until these semantics are sufficiently stable.

## Starting state

The repository remains in the legacy/pre-refactor layout. No structural architecture refactor has been executed. 03B completed the audit/design pass and is now `HANDED_OFF`.

## Controlled lifecycle recovery

This handoff was a pre-existing artifact created before the receiving chapter's bootstrap. Its creation and the subsequent `03B → HANDED_OFF` transition were performed in violation of the handoff ownership invariants before 03C began its bootstrap.

Controlled lifecycle recovery was explicitly authorized after the violation was detected. The existing 03C handoff is retained and owned by 03C; it is not recreated, and the original Git history is not rewritten. The handoff is normalized as the receiving chapter's canonical `DRAFT` checkpoint. The already-completed `03B → HANDED_OFF` transition is accepted as historical state and is not repeated.

## Established architecture decisions

- **AD-01:** Core semantic types are `RULE / SKILL / WORKFLOW / REFERENCE / MEMORY`; `EXTENSIONS` are separate repository-defined extensions.
- **AD-02:** RULE = policy/authority/constraint; SKILL = capability/methodology; WORKFLOW = ordered procedure.
- **AD-03:** REFERENCE is evidence/source, not instruction or authority.
- **AD-04:** MEMORY is durable context, not authority automatically.
- **AD-05:** HANDOFF is a cross-cutting lifecycle mechanism spanning RULE + WORKFLOW + state documents; it is not an optional extension.
- **AD-06:** TRACE is an architecture extension under future `.ai/extensions/trace/`.
- **AD-07:** TRACE is observability, not authority.
- **AD-08:** Applicability, Activation, and Precedence are distinct concepts.
- **AD-09:** Specificity does not automatically override authority; by default a more-specific rule specializes a broader rule. `specificity ≠ authority`.
- **AD-10:** Override must be explicit, limited, explainable, and traceable; path/depth is never an implicit override.
- **AD-11:** Preliminary resolution order is `Applicability → Activation → Authority → Specificity → Conflict resolution`; unresolved conflicts must not be silently resolved.
- **AD-12:** `AGENTS.md` is the compact AI entry/router/map; `.ai/README.md` is the instruction-system map/ontology.
- **AD-13:** `.ai/config.json` contains machine-readable configuration/metadata only and must not duplicate policy.
- **AD-14:** Skills should be discoverable/activatable from metadata and relevance; automatic discovery does not mean mandatory activation.
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

- **AD-17:** Project-agnosticity is an explicit architectural criterion.
- **AD-18:** Project-specific domain knowledge, rules, references, tests/fixtures, and project workflows remain separate from reusable AI-system core semantics.
- **AD-19:** Proposed `.ai` elements are classified `CORE / PROJECT-SPECIFIC / ADAPTABLE` before architecture freeze.
- **AD-20:** Rule portability test: **Could this rule be copied unchanged into a completely unrelated software project?**
- **AD-21:** `aip-mirror`, `gearmulator` + `virus-ti2-adssr`, and a future Ableton Live Extensions project are conceptual validation cases only; no future-project repositories are to be modified during this chapter.

## OVERRIDE checkpoint inherited from 03B

Semantic RULE IDs are preferred as stable identifiers, independent of filename/path/depth. `OVERRIDE` should be declared semantically in YAML/frontmatter, for example:

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

Candidate required fields: `id`, `type`, `relation`, `override.target`, and `override.reason`.

`SPECIALIZE` is distinct from `OVERRIDE`: it extends, narrows, or contextualizes without replacing the target. Invalid or ambiguous override targets should fail closed: do not apply the override and surface a warning/unresolved conflict.

## OVERRIDE decisions reached during 03C

The following are **working architectural decisions agreed during this chapter**. They should be promoted to formal AD entries after the complete OVERRIDE Architecture Decision Pass is finished; until then, this handoff is the durable record of the decisions and rationale.

### Durable by default; explicit temporary override supported

- `OVERRIDE` is **durable by default**.
- If an override declaration says nothing about temporariness, it is treated as durable.
- The architecture **officially supports explicit temporary OVERRIDE** for cases such as controlled migration/recovery, debugging, or other bounded workflows where a permanent repository override would be inappropriate.
- Temporary status must be **explicitly declared**. It must never be inferred from context or assumed by the AI.
- Durable and temporary overrides have the same requirements for authority, validity, reason, and traceability. They differ in lifecycle only.
- A temporary override must not silently disappear from historical state when it stops being active. Its lifecycle and eventual expiration/revocation must remain auditable.
- When a temporary override is active, the user should receive an explicit status/observability signal that a temporary override is currently being applied, particularly for debugging and controlled exception handling.
- `lifetime` and `scope` are separate concepts. The chosen architecture must not conflate how long an override exists with where it applies.

Conceptual durable form:

```yaml
override:
  target: REPO-EDIT-001
  reason: ...
```

Conceptual temporary form:

```yaml
override:
  target: REPO-EDIT-001
  reason: ...
  lifetime:
    kind: temporary
    ...
```

The exact temporary-lifetime schema remains open until the rest of the OVERRIDE pass is complete.

### No `override.scope` for now

The architecture currently chooses **Variant A: no `override.scope`**.

Rationale:

- The existing semantic model already has `Applicability` and `Activation`; adding another scope mechanism would risk duplicating or complicating applicability semantics.
- A workflow-specific or chapter-specific temporary exception can generally be modeled through workflow/context activation rather than a new OVERRIDE scope mechanism.
- Debugging status/observability can be handled by TRACE and activation state without introducing `scope`.
- Object/type-specific restrictions can generally be expressed through the target's existing applicability model.
- Introducing scope merely for hypothetical future flexibility would add semantic surface area before a demonstrated need exists.

Current rule:

> **OVERRIDE inherits the applicability of its target; no separate `override.scope` exists in the current architecture.**

Future escape hatch:

> **If real architectural scenarios demonstrate that the existing Applicability + Activation + WORKFLOW mechanisms are insufficient to restrict an OVERRIDE safely, `override.scope` may be introduced later as a separate Architecture Decision.**

The following useful Variant B design notes are intentionally preserved here so that a future scope decision does not require rediscovery:

- If `scope` is ever introduced, it should be **optional**, not mandatory.
- No scope would mean **inherit target applicability**.
- An explicit scope would **restrict** the target's applicability rather than replace it with a second applicability model.
- Conceptually, effective override applicability could be treated as the intersection of target applicability and override scope.
- A scope wider than the target's applicability would be **invalid and fail closed**.
- Scope must never expand the target's applicability or authority.
- Scope should not become a free-form policy language or a second independent applicability system.
- Concrete scope values (repository/workflow/chapter/file/object/etc.) were deliberately **not** selected; they must not be assumed later without a dedicated architecture decision.
- Before introducing scope, test every proposed use case against existing Applicability, Activation, and WORKFLOW semantics. A scope mechanism should be added only when those mechanisms demonstrably cannot provide a safe and understandable restriction.

### OVERRIDE must not expand target applicability

The following principle is adopted independently of whether a future `scope` mechanism is ever introduced:

> **OVERRIDE may preserve or narrow the applicability of its target, but it must never expand the target's applicability or authority.**

Therefore, any future explicit restriction mechanism must obey:

```text
No restriction
    ↓
inherit target applicability

Explicit restriction
    ↓
restrict target applicability

Restriction wider than target
    ↓
INVALID → fail closed
```

An OVERRIDE is not a mechanism for granting broader reach or authority than the target already possesses.

## Open OVERRIDE questions inherited from 03B

1. Durable vs explicitly temporary: **working decision reached — durable by default, explicit temporary supported.**
2. `override.scope`: **working decision reached — omit for now; preserve Variant B notes above as a future escape hatch.**
3. How does OVERRIDE interact with authority and specificity?
4. What happens with invalid, ambiguous, inactive, chained, or cyclic targets?
5. Does `RESOLVE` belong in TRACE?

The remaining open questions must still be resolved before the OVERRIDE Architecture Decision Pass is complete and before the decisions above are promoted to final AD entries.

## Activation checkpoint

Activation is distinct from applicability. Candidate activation states are `auto`, `manual`, and `hybrid`. Skills should generally be discoverable from metadata/relevance; manual-only workflows remain valid. No separate `activation.json` is planned; `.ai/config.json` remains machine-readable configuration.

## TRACE checkpoint

TRACE must remain observational. It should make rule/skill behavior auditable without deciding authority. Candidate events:

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

The final event vocabulary and schema remain open.

For temporary OVERRIDE specifically, TRACE/observability should make the active exception visible to the user and preserve its lifecycle in historical state. The exact event payloads remain open.

## Project-agnosticity

The architecture must keep reusable AI-system semantics project-agnostic while project identity, technology, domain rules, references, fixtures, and project-specific workflows remain project-specific. Every resulting architecture decision should receive a `CORE / PROJECT-SPECIFIC / ADAPTABLE` check.

## Project-specific reference context

Current project facts that remain project-specific include Adobe Illustrator 2026/AIP, the JSX prototype, FreeHand MX Mirror behavior, Illustrator/FreeHand coordinate conventions and test fixtures, screenshots/videos, and the eventual native AIP implementation. These facts must not leak into the reusable core architecture semantics.

## Research references

These are the external repositories that are materially required to understand or continue the research represented by this handoff. They are preserved intentionally; this is **not** a list of everything opened during web research.

### External repositories

- paulhuman/codex
  - Fork of: openai/codex
  - Role: Research reference for coding-agent architecture, agent behavior, instruction handling, and repository-oriented workflows relevant to the AI-instruction system being designed here.
  - URL: https://github.com/paulhuman/codex

- paulhuman/skills
  - Fork of: anthropics/skills
  - Role: Research reference for reusable AI skill structure, skill packaging/discovery conventions, and capability-oriented instruction design.
  - URL: https://github.com/paulhuman/skills

- paulhuman/agent.md
  - Role: Research reference for agent instruction-file conventions, instruction hierarchy/routing, and durable repository-level AI guidance.
  - URL: https://github.com/paulhuman/agent.md

## Handoff reference preservation

This chapter adopts the following reusable rule and skill as part of the handoff architecture:

- Rule: `.ai/rules/handoff-references.md`
- Skill: `.ai/skills/handoff-reference-preservation/SKILL.md`

Core principle:

> **A handoff must preserve not only decisions, but also the references materially required to understand, validate, or continue those decisions.**

The preservation rule deliberately distinguishes **material references** from incidental browsing. A handoff must not become an internet transcript dump. Every preserved external reference should have a concise **Role** explaining why the reference matters; otherwise a future chapter may inherit URLs without knowing their purpose.

This rule is project-agnostic. Concrete research references remain in the applicable handoff or project documentation.

## Repository safety

For every future repository modification:

1. read the current file;
2. preserve unrelated content during full-content replacement;
3. write the complete intended content;
4. read back;
5. verify integrity, diff, and changed-file scope;
6. commit;
7. verify the resulting ref/commit.

Never trust a successful GitHub write without readback/diff verification. Do not force-push merely to clean up an API incident.

## Implementation state

No structural refactor has been committed. `docs/PROJECT-INSTRUCTIONS.md` remains a legacy aggregate and must be redistributed and verified before deletion. No future-project repository has been modified.

## Immediate next task

Continue the **OVERRIDE Architecture Decision Pass**:

1. Finalize the interaction of OVERRIDE with authority and specificity.
2. Define behavior for invalid, ambiguous, inactive, chained, and cyclic overrides.
3. Decide whether `RESOLVE` belongs in TRACE.
4. Finalize temporary OVERRIDE lifecycle semantics and user-facing observability requirements.
5. Promote the completed OVERRIDE decisions to formal AD entries.
6. Apply the Project-Agnosticity Check to every resulting decision.

Then formalize precedence/override, continue applicability/activation, define TRACE schema/events, and only then begin structural refactoring.

## Things not to redo

- Do not recreate 03A decisions from scratch.
- Do not redesign the chapter/handoff model.
- Do not create `.ai/plugins/`.
- Do not treat HANDOFF as an optional extension.
- Do not treat TRACE as authority.
- Do not treat specificity/path/depth as implicit override.
- Do not treat temporary OVERRIDE as implicitly inferred from context.
- Do not add `override.scope` unless a future architecture pass demonstrates a real semantic need and explicitly decides it.
- Do not allow any future scope mechanism to expand target applicability or authority.
- Do not globally replace `should`/`may`; classify semantics case by case.
- Do not begin native AIP implementation merely because architecture refactoring is underway.
- Do not delete `docs/PROJECT-INSTRUCTIONS.md` before semantic redistribution and verification.
- Do not create temporary transcript dumps in `.ai/memory/`.
- Do not modify future repositories merely to test portability.
- Do not force-push merely to clean up an API incident.
- Never trust a successful GitHub write without readback/diff verification.
- Do not copy every browsed URL into a handoff; preserve only materially required research references.
- Do not preserve a material external reference without recording its Role.
