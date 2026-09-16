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
HANDED_OFF

## Starting objective

Continue the project-wide AI-instruction architecture work from 03B. The immediate task was the dedicated **OVERRIDE Architecture Decision Pass**, followed by formalization of precedence/override, applicability/activation, and TRACE semantics. Structural refactoring was explicitly deferred until these semantics became sufficiently stable.

## Starting state

The repository remains in the legacy/pre-refactor layout. No structural architecture refactor has been executed. 03B completed the audit/design pass and was `HANDED_OFF`; during this migration 03B has now been correctly marked `SUPERSEDED` as required when 03C reaches `READY_FOR_HANDOFF`.

## Controlled lifecycle recovery

This handoff was a pre-existing artifact created before the receiving chapter's bootstrap. Its creation and the subsequent `03B → HANDED_OFF` transition were performed in violation of the handoff ownership invariants before 03C began its bootstrap.

Controlled lifecycle recovery was explicitly authorized after the violation was detected. The existing 03C handoff is retained and owned by 03C; it is not recreated, and the original Git history is not rewritten. The handoff was normalized as the receiving chapter's canonical `DRAFT` checkpoint. The already-completed `03B → HANDED_OFF` transition was accepted as historical state and was not repeated.

## Established architecture decisions inherited from 03B

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

The following points were worked through during this chapter. They are intentionally preserved here as the durable checkpoint for 03D. They should be promoted to formal AD entries only after 03D performs the final Architecture Decision Pass and confirms the remaining open semantics.

### Durable by default; explicit temporary override supported

- `OVERRIDE` is **durable by default**.
- If an override declaration says nothing about temporariness, it is treated as durable.
- The architecture **officially supports explicit temporary OVERRIDE** for controlled migration/recovery, debugging, or other bounded workflows where a permanent repository override would be inappropriate.
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

The exact temporary-lifetime schema remains open.

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

Preserved Variant B notes for future:

- If `scope` is ever introduced, it should be **optional**, not mandatory.
- No scope would mean **inherit target applicability**.
- An explicit scope would **restrict** the target's applicability rather than replace it with a second applicability model.
- Conceptually, effective override applicability could be treated as the intersection of target applicability and override scope.
- A scope wider than the target's applicability would be **invalid and fail closed**.
- Scope must never expand the target's applicability or authority.
- Scope should not become a free-form policy language or a second independent applicability system.
- Concrete scope values (repository/workflow/chapter/file/object/etc.) were deliberately **not** selected; they must not be assumed later without a dedicated architecture decision.
- Before introducing scope, test every proposed use case against existing Applicability, Activation, and WORKFLOW semantics. A scope mechanism should be added only when those mechanisms demonstrably cannot provide a safe and understandable restriction.

### OVERRIDE must not expand target applicability or authority

The following principle is adopted independently of whether a future `scope` mechanism is ever introduced:

> **OVERRIDE may preserve or narrow the applicability of its target, but it must never expand the target's applicability or authority.**

Therefore:

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

## OVERRIDE authority and specificity: current research conclusions

The following conclusions were deliberately held as **research conclusions / hypotheses**, not yet final AD entries:

1. **OVERRIDE is a semantic relation, not an authority level.**
2. `relation: OVERRIDE` does **not** itself grant permission to establish or apply an override.
3. An effective OVERRIDE requires independently established authorization to perform that relation against its target in the applicable context.
4. General authority to govern and authority/permission to override may be distinct concepts; they must not be assumed identical until the authority model is formalized.
5. **Specificity never creates, grants, or strengthens OVERRIDE authority.**
6. A more-specific rule without explicit OVERRIDE remains a `SPECIALIZE`/contextual rule rather than an override.
7. OVERRIDE cannot expand the target's applicability or authority.
8. Delegated override permission may preserve or narrow an existing permission but must not silently amplify it.
9. Numeric or path-depth-based authority is not justified by the current research and should not be introduced merely to obtain a deterministic ordering.

Important unresolved point:

> **The exact semantics of “authority to override” remain open. Rule 3 above is a strong working hypothesis, but must be analyzed and explicitly accepted before being promoted to a final AD.**

## Multiple-valid-OVERRIDE conflict model

Research and counterexample testing produced a deliberately conservative baseline:

```text
0 valid OVERRIDE
    ↓
no override

1 valid OVERRIDE
    ↓
apply

2+ valid OVERRIDEs
    ↓
UNRESOLVED
```

This is a **safe baseline hypothesis**, not yet a final architecture decision.

Key conclusions:

- `A = VALID` and `B = VALID` does not imply that either A or B wins.
- Multiple valid/authorized OVERRIDEs are a **conflict-resolution problem**, not an authorization problem.
- A deterministic A/B winner would require an additional semantic ordering/precedence mechanism that the current architecture does not need and should not invent merely to resolve this case.
- There is therefore **no “last found rule wins” semantics**.
- Discovery order, filesystem order, path depth, filename order, traversal order, or incidental processing order must not become hidden precedence.
- If multiple valid OVERRIDEs remain unresolved, the combined result is `UNRESOLVED` and the override must not be silently applied.
- `UNRESOLVED` is intentionally fail-closed for OVERRIDE.

This gives a clean three-stage baseline:

```text
VALIDITY / AUTHORIZATION
        ↓
0 / 1 / 2+ valid OVERRIDEs
        ↓
NO OVERRIDE / APPLY / UNRESOLVED
```

`decision_id` becomes useful as a correlation identifier for such a decision: it can associate the evaluated candidates, authorization evidence, applicable context, rule revisions, conflict-resolution result, and final outcome. A mandatory-safety-vs-ordinary-override distinction would be a separate future architectural layer and is explicitly out of scope for the current architecture pass.

## Counterexample pass completed in 03C

The following twelve scenarios were checked against the emerging model:

1. Low-authority rule attempts to override high-authority rule → relation alone is insufficient; without `may_override` authorization, deny.
2. High-authority rule attempts to override low-authority rule → high authority alone does not automatically grant override permission; explicit authorization is still required.
3. OVERRIDE relation exists but authorization is missing → relation may remain syntactically/semantically declared but is ineffective; TRACE may explain the denial.
4. Delegated override permission → valid when delegation explicitly permits the relation and applicability, target, activation, and lifetime remain valid.
5. Narrow delegated permission → delegated actor may override only the permitted target set/context.
6. Delegation attempts to expand authority → invalid/deny; delegation must not silently amplify authority.
7. Temporary permission expires → historical rule/relation remains auditable, but authorization is expired and ineffective.
8. Permission is revoked before expiration → `REVOKED` is distinct from `EXPIRED`; the override becomes ineffective immediately under the applicable revocation semantics.
9. Target becomes inapplicable → valid override authorization cannot make an inapplicable target applicable.
10. TRACE exists but authorization is missing → TRACE can observe/log/explain; it cannot grant authorization.
11. Authorization source becomes `SUPERSEDED` → HANDOFF lifecycle and authorization lifecycle are separate state machines; `SUPERSEDED` must not automatically mean `REVOKED`.
12. Two valid authorized OVERRIDEs conflict → both may be valid, but without explicit conflict semantics the result is `UNRESOLVED`; no implicit winner.

These counterexamples passed the current safety model. They are validation evidence, not automatically formal ADs.

## Strong research hypotheses carried into 03D

- **H-01:** `OVERRIDE` is a semantic relation, not an authority level.
- **H-02:** Declaring `OVERRIDE` does not itself grant permission.
- **H-03:** Effective OVERRIDE requires independently established authorization to perform the relation against the target in applicable context.
- **H-04:** General authority to govern and authority/permission to override are distinct unless an explicit architectural rule establishes their relationship.
- **H-05:** Specificity never creates/grants/strengthens override authorization.
- **H-06:** Delegation may preserve/narrow override authorization but not expand it.
- **H-07:** OVERRIDE cannot expand target applicability or authority.
- **H-08:** Expiration and explicit revocation are distinct authorization lifecycle events.
- **H-09:** Handoff lifecycle states, including `SUPERSEDED`, must not be conflated with authorization lifecycle.
- **H-10:** TRACE records/explains decisions but cannot grant, extend, revive, or strengthen authorization.
- **H-11:** Authorization and conflict resolution are distinct stages.
- **H-12:** Ambiguous/unresolved OVERRIDE authorization/conflict fails closed.
- **H-13:** Multiple authorized OVERRIDEs require explicit conflict-resolution semantics; no implicit winner from path/depth/discovery order.
- **H-14:** Specificity/precedence/authority/delegation may be inputs to conflict resolution, but none automatically becomes OVERRIDE authority.
- **H-15:** Safe baseline: 0 candidates = no override; 1 candidate = eligible effective candidate; 2+ candidates require explicit resolution; absent resolution = unresolved/no apply.

## External research references required for continuation

The following references are materially relevant to the 03C OVERRIDE/authorization/conflict-resolution work and should be preserved for 03D. This is intentionally **not** a transcript of every URL visited.

### AI instruction / agent architecture

- **OpenAI Model Spec** — authority levels, applicability, and instruction conflict/override semantics. Role: conceptual reference for separating authority from applicability and for comparing explicit versus implicit override behavior.
  - https://model-spec.openai.com/

- **Anthropic Agent Skills specification** — skill discovery, activation, and execution. Role: reference for separating discovery from activation and capability execution.
  - https://agentskills.io/specification

- **GitHub Copilot custom instructions documentation** — repository-wide and path-specific instruction application. Role: evidence that specificity/context can coexist without implying automatic replacement/override.
  - https://docs.github.com/en/copilot/customizing-copilot/adding-repository-custom-instructions-for-github-copilot

- **Cursor Rules documentation** — multiple rule activation modes and explicit enforcement. Role: reference for distinguishing discovery/activation/context from stronger enforcement semantics.
  - https://docs.cursor.com/context/rules

- **Model Context Protocol authorization** — authorization, scopes, expiration, and least-privilege concepts. Role: reference for separating resource targeting, permission, scope, and lifecycle.
  - https://modelcontextprotocol.io/specification/draft/basic/authorization

### Authorization / policy / provenance

- **NIST Attribute Based Access Control (ABAC)** — authorization as a function of subject, object, operation, environment, and policy attributes. Role: reference against a simplistic single numeric “authority” model.
  - https://csrc.nist.gov/projects/attribute-based-access-control

- **OpenFGA documentation** — relationship-based authorization and derived permissions. Role: reference supporting a distinct relation such as `may_override(A,B)` rather than treating override as a universal authority level.
  - https://openfga.dev/docs

- **Open Policy Agent (OPA)** — policy decisions, conflict handling, explicit combining/ordering, and decision logging. Role: reference for separating policy evaluation from conflict resolution and observability.
  - https://www.openpolicyagent.org/docs
  - https://www.openpolicyagent.org/docs/faq

- **AWS Cedar documentation** — default deny, explicit policy effects, determining policies, and diagnostics. Role: comparative reference showing one explicit conflict model without assuming it is appropriate for OVERRIDE.
  - https://docs.cedarpolicy.com/

- **XACML / NIST policy-combining material** — deny-overrides, permit-overrides, first-applicable, only-one-applicable. Role: comparative reference demonstrating that conflict resolution is an explicit architectural choice rather than a universal ordering rule.
  - https://csrc.nist.gov/projects/attribute-based-access-control

- **W3C PROV** — provenance entities, activities, agents, derivations, responsibility, and time. Role: reference for future decision provenance/TRACE semantics.
  - https://www.w3.org/TR/prov-overview/

- **Google Zanzibar paper** — authorization state consistency and coherent policy/ACL evaluation. Role: comparative reference for relationship-based authorization and deterministic policy state, without importing its semantics directly.
  - https://storage.googleapis.com/pub-tools-public-publication-data/pdf/10683a8984f2e0a4a4f8b3f2e4e0d6e0e6e8d8c9.pdf

### External repositories

- **paulhuman/codex**
  - Fork of: openai/codex
  - Role: Research reference for coding-agent architecture, agent behavior, instruction handling, and repository-oriented workflows relevant to the AI-instruction system being designed here.
  - URL: https://github.com/paulhuman/codex

- **paulhuman/skills**
  - Fork of: anthropics/skills
  - Role: Research reference for reusable AI skill structure, skill packaging/discovery conventions, and capability-oriented instruction design.
  - URL: https://github.com/paulhuman/skills

- **paulhuman/agent.md**
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

For temporary OVERRIDE specifically, TRACE/observability should make the active exception visible to the user and preserve its lifecycle in historical state. `decision_id` is a promising correlation field for future TRACE, but its exact schema remains open.

## Project-agnosticity

The architecture must keep reusable AI-system semantics project-agnostic while project identity, technology, domain rules, references, fixtures, and project-specific workflows remain project-specific. Every resulting architecture decision should receive a `CORE / PROJECT-SPECIFIC / ADAPTABLE` check.

## Project-specific reference context

Current project facts that remain project-specific include Adobe Illustrator 2026/AIP, the JSX prototype, FreeHand MX Mirror behavior, Illustrator/FreeHand coordinate conventions and test fixtures, screenshots/videos, and the eventual native AIP implementation. These facts must not leak into the reusable core architecture semantics.

## Implementation state

No structural refactor has been committed. `docs/PROJECT-INSTRUCTIONS.md` remains a legacy aggregate and must be redistributed and verified before deletion. No future-project repository has been modified.

## Research stopping point

03C deliberately stops the research phase here. The research has established enough evidence and counterexamples to begin the **OVERRIDE Architecture Decision Pass** in 03D. Do not restart broad research unless a concrete unresolved semantic question requires new evidence.

## Immediate next task for 03D

1. Perform the **OVERRIDE Architecture Decision Pass** using the research conclusions and hypotheses above.
2. Resolve the exact semantics of authority/permission to establish and apply an OVERRIDE, without introducing a numeric or incidental path-based authority model merely to obtain ordering.
3. Decide the formal behavior for invalid, ambiguous, inactive, chained, and cyclic OVERRIDEs.
4. Decide whether `RESOLVE` is a TRACE event and define its semantic boundary so TRACE remains observational.
5. Finalize temporary OVERRIDE lifecycle semantics and explicit user-facing observability requirements.
6. Promote only sufficiently validated OVERRIDE conclusions to formal AD entries.
7. Apply the `CORE / PROJECT-SPECIFIC / ADAPTABLE` Project-Agnosticity Check to each resulting AD.
8. Then formalize precedence/override and continue the Applicability/Activation work.
9. Define the TRACE schema/events and provenance fields, including whether/how `decision_id` participates.
10. Only after those semantics are sufficiently stable, begin structural refactoring.

## Migration state

This handoff is finalized as `READY_FOR_HANDOFF` for **AIP Mirror — 03D — Architecture & Research**.

The previous same-specialization handoff `03B` was physically verified as `SUPERSEDED` before this handoff was transitioned to `READY_FOR_HANDOFF`, satisfying the mandatory READY_FOR_HANDOFF supersession invariant.

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
