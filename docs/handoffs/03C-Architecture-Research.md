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

Open OVERRIDE questions inherited from 03B:

1. Is OVERRIDE inherently durable, or may it be explicitly temporary?
2. Is `override.scope` necessary? If so, what exactly does it mean?
3. How does OVERRIDE interact with authority and specificity?
4. What happens with invalid, ambiguous, inactive, chained, or cyclic targets?
5. Does `RESOLVE` belong in TRACE?

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

## Project-agnosticity

The architecture must keep reusable AI-system semantics project-agnostic while project identity, technology, domain rules, references, fixtures, and project-specific workflows remain project-specific. Every resulting architecture decision should receive a `CORE / PROJECT-SPECIFIC / ADAPTABLE` check.

## Project-specific reference context

Current project facts that remain project-specific include Adobe Illustrator 2026/AIP, the JSX prototype, FreeHand MX Mirror behavior, Illustrator/FreeHand coordinate conventions and test fixtures, screenshots/videos, and the eventual native AIP implementation. These facts must not leak into the reusable core architecture semantics.

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

Perform the dedicated **OVERRIDE Architecture Decision Pass**:

1. Decide durable vs explicitly temporary OVERRIDE semantics.
2. Decide whether `override.scope` is necessary and define it if retained.
3. Define OVERRIDE interaction with authority and specificity.
4. Define behavior for invalid, ambiguous, inactive, chained, and cyclic overrides.
5. Decide whether `RESOLVE` belongs in TRACE.
6. Record resulting decisions as new AD entries.
7. Apply the Project-Agnosticity Check to every resulting decision.

Then formalize precedence/override, continue applicability/activation, define TRACE schema/events, and only then begin structural refactoring.

## Things not to redo

- Do not recreate 03A decisions from scratch.
- Do not redesign the chapter/handoff model.
- Do not create `.ai/plugins/`.
- Do not treat HANDOFF as an optional extension.
- Do not treat TRACE as authority.
- Do not treat specificity/path/depth as implicit override.
- Do not globally replace `should`/`may`; classify semantics case by case.
- Do not begin native AIP implementation merely because architecture refactoring is underway.
- Do not delete `docs/PROJECT-INSTRUCTIONS.md` before semantic redistribution and verification.
- Do not create temporary transcript dumps in `.ai/memory/`.
- Do not modify future repositories merely to test portability.
- Do not force-push merely to clean up an API incident.
- Never trust a successful GitHub write without readback/diff verification.
