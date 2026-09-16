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
HANDED_OFF

## Current objective

Continue the project-wide AI-instruction architecture research from 03C. The current focus is the **OVERRIDE Architecture Decision Pass**, now concentrated on authorization boundaries, precedence semantics, and the boundary between eligibility, candidate semantics, and effective outcome. Structural refactoring remains deferred until the relevant semantics are sufficiently stable.

The candidate-level precedence model is now strongly supported by the counterexample pass, but its formal AD is still pending. The next chapter should continue the one-decision-at-a-time counterexample process, now concentrating on `prerequisite` and `dependency` semantics and the exact boundary of candidate eligibility versus effect evaluation.

## Completed

Bootstrap established the canonical starting state from 03C. The 03C checkpoint recorded the completed OVERRIDE research/counterexample pass. During 03D, the authorization model has been substantially narrowed and clarified through explicit Architecture Decision Passes:

- **OVERRIDE-01 — Source of Authorization:** Model B, Explicit Authorization, is the baseline. Declaration of an OVERRIDE is not authorization; authorization is not itself effective application; TRACE is not authority. Automatic resolution is allowed only when the architecture can resolve deterministically; otherwise the result is `UNRESOLVED` and may require user decision.
- **OVERRIDE-02 — Sufficient authorization:** authorization is a bounded grant with conceptual properties for subject, action, target boundary, applicability, activation, lifecycle validity, and delegation constraints. Delegation must itself be explicitly authorized and must not expand the source grant.
- **OVERRIDE-02A — Target boundary:** target-specific authorization is the semantic primitive. Target-class authorization is not part of Core and may only be introduced later as a separate extension/architecture decision.
- **OVERRIDE-02B — Bounded target set:** a bounded target set is semantically equivalent to an aggregation of independent target-specific grants when the grants share a compatible/common authorization boundary. It is a representation optimization, not a new authorization language.
- **OVERRIDE-03 — Authorization object boundary:** one authorization object has one authorization boundary and one lifecycle. A bounded target set may aggregate only targets whose authorization semantics do not require independent applicability, activation, or lifecycle states.
- **OVERRIDE-04 — Authorization boundary contents:** subject, action, targets, applicability, activation, lifetime, and delegation constraints are semantic grant properties. Reason/provenance/identifiers are explanatory or provenance metadata unless separately defined as semantic. Reason must not become a hidden policy condition.
- **OVERRIDE-04A — Issuer and authority:** issuer identity is not equivalent to issuer authority. An authorization record is a claim, not authority merely because it exists. Authority establishment has the distinct states `AUTHORIZED / DENIED / UNRESOLVED`.
- **OVERRIDE-04B — Authority mechanism:** Core uses an abstract **established authority** boundary. Core does not define the mechanism for constructing/verifying the authority chain. An external authority mechanism establishes whether a claimed authorization is authorized; Core evaluates what an established authorization permits.
- **OVERRIDE-04C — Authority result:** Model C, a two-level result, is the baseline. External authority establishment returns `AUTHORIZED / DENIED / UNRESOLVED` plus an established authorization boundary/evidence when appropriate. Core then evaluates that boundary for the current operation/context and may return `EFFECTIVE / DENIED / UNRESOLVED`. These levels must not be conflated.
- **OVERRIDE-04D — Core evaluation boundary:** Core may evaluate an established authorization boundary against the current operation, but MUST NOT enlarge, reinterpret, or strengthen it. Specificity cannot create authority. Expiration yields denial; unknown validity yields unresolved. Delegation beyond the established boundary must not be silently transformed into a different grant.
- **OVERRIDE-04E — Multiple grants:** multiple independently established grants can provide `MULTIPLE SUPPORT` without requiring a winner. Conflicting authorized outcomes are a separate conflict-resolution problem. Multiple grants must not be silently collapsed merely because they currently produce the same result.
- **OVERRIDE-04F — Specificity:** specificity may participate in conflict resolution only when an explicit precedence rule assigns it that role. Specificity must not create/grant/expand/strengthen authorization. If applicable precedence rules do not produce a unique result, the conflict remains `UNRESOLVED`.
- **OVERRIDE-04G — Authority vs precedence:** authority level does not independently determine conflict precedence. Authority may participate in conflict resolution only when an explicit precedence rule assigns it that role. Authority establishes authorization standing; precedence determines which authorized outcome governs a conflict. Equal precedence remains unresolved unless another explicit applicable rule deterministically resolves it.
- **OVERRIDE-04H — Precedence policy:** Model B is the baseline: precedence rules are ordinary policy inputs, not a universal fixed Core hierarchy. Core MUST NOT recursively invent higher-order precedence rules to resolve conflicts between precedence rules. Precedence policy itself must be established authority/policy and must not emerge from file layout, path depth, discovery order, or incidental processing order. If applicable resolution rules do not produce a unique deterministic result within the defined resolution boundary, Core MUST return `UNRESOLVED` rather than invent a winner.

### Candidate-level precedence conclusions from the current pass

The following conclusions were reached after the OVERRIDE-04H checkpoint and counterexample pass:

- **Governing candidate is needed when there is a conflict.** Multiple sources producing the same outcome do not require a governing candidate; they may provide `MULTIPLE SUPPORT`.
- **Eligibility precedes precedence.** Precedence receives only candidates that are already eligible. It cannot bypass applicability, activation, validity, authority, or other eligibility requirements.
- **Precedence does not compute conditions.** Conditions/predicates are evaluated before a candidate can participate in precedence.
- **Candidate-level precedence is the accepted working direction.** Precedence selects a governing policy-bearing decision source rather than selecting or combining bare outcome values.
- **Precedence selects a decision source, not its interpretation.** A governing candidate carries its own semantic effect; precedence does not need to understand every possible effect type.
- **Specificity and authority remain inputs only through explicit precedence policy.** Neither independently becomes a precedence mechanism.
- **Semantic effect and effective outcome are distinct.** A candidate may have a semantic effect/contribution before precedence, while the effective outcome exists only after a governing candidate has been selected.
- **Evaluation strategy is not yet an architectural requirement.** An implementation may compute candidate effects eagerly or lazily when semantically equivalent. Architecture should define semantic dependencies, not unnecessarily prescribe execution order.

### Working vocabulary accepted in this pass

- **Candidate:** an already eligible policy-bearing decision source that may participate in conflict resolution.
- **Eligibility:** the determination that a candidate may participate in precedence/conflict resolution in the current context.
- **Candidate effect / semantic contribution:** what a candidate semantically specifies if it governs; Core precedence does not need to enumerate every possible effect type.
- **Governing candidate:** the eligible candidate selected by applicable explicit precedence to govern a conflict.
- **Effective outcome:** the result derived from the governing candidate's semantic effect after conflict resolution.
- **Predicate:** a logical test/evaluation input that may contribute to determining eligibility; it is not itself an authority or outcome.
- **Condition:** a semantic condition whose evaluation may contribute to candidate eligibility; condition is not part of precedence semantics.
- **Prerequisite:** intentionally not yet collapsed into `condition`; it may be a context prerequisite or a semantic dependency on another decision source.
- **Dependency:** intentionally remains an underspecified relationship term until its semantic role is explicitly defined. It must not become a generic mechanism that silently absorbs unrelated concepts.

## Accepted working invariants from the current OVERRIDE pass

The following invariants are accepted as working invariants unless a later counterexample demonstrates a necessary refinement:

1. **Declaration is not authorization.** Declaring an OVERRIDE does not itself grant permission.
2. **TRACE is not authority.** TRACE can record, explain, and correlate decisions, but cannot grant, extend, revive, or strengthen authorization.
3. **Authorization is bounded.** An authorization grant cannot self-expand.
4. **Delegation is bounded.** Authorization may be delegated only when delegation itself is explicitly authorized, and delegation must not expand the authority granted by its source.
5. **Target classes are not Core.** Target-class authorization is future-extension territory only after a separate architecture decision.
6. **Target sets are aggregation.** A bounded target set is valid Core representation only as aggregation of explicit target-specific grants with compatible/common authorization boundaries.
7. **One authorization object, one boundary, one lifecycle.** Independent applicability, activation, or lifecycle semantics must not be hidden inside one aggregated authorization object.
8. **OVERRIDE cannot expand target applicability or authority.** An OVERRIDE may preserve or narrow the target's applicability, but never expand the target's applicability or authority. No separate `override.scope` exists in the current Core model.
9. **Issuer is not authority.** The existence or identity of an issuer does not establish the issuer's authority.
10. **Core consumes established authority.** Core does not define the mechanism for constructing/verifying authority chains and MUST NOT infer authority from record existence, location, specificity, provenance, or discovery order.
11. **Authorization standing and current effectiveness are distinct.** An externally established `AUTHORIZED` grant can still be `DENIED` or `UNRESOLVED` by Core when its boundary does not permit the current operation/context or its current validity cannot be established.
12. **Core cannot enlarge an established boundary.** Core may evaluate but not enlarge, reinterpret, or strengthen an established authorization boundary.
13. **Multiple grants may jointly support.** Multiple independently established grants need not have a winner when they support the same outcome.
14. **No implicit winner among conflicting grants.** Multiple authorized conflicting outcomes require explicit conflict resolution; discovery order, path depth, filename order, timestamps, IDs, and incidental processing order are not implicit tie-breakers.
15. **Specificity is not authority.** Specificity MUST NOT create, grant, expand, or strengthen authorization.
16. **Specificity requires explicit precedence.** Specificity MAY participate in conflict resolution only when an explicit precedence rule assigns it that role.
17. **Authority requires explicit precedence for conflict use.** Authority MAY participate in conflict resolution only when an explicit precedence rule assigns it that role; authority level alone is not conflict precedence.
18. **No universal fixed precedence hierarchy.** Core MUST NOT assume a universal project-level precedence hierarchy among conflict-resolution policies.
19. **Precedence is policy.** Precedence rules are explicit policy inputs and MUST themselves be subject to normal applicability, activation, authority, and validity evaluation.
20. **No recursive invention.** Core MUST NOT invent or recursively infer higher-order precedence solely to resolve a conflict between precedence rules.
21. **Deterministic-or-unresolved.** If applicable precedence/resolution rules do not produce a unique deterministic result within the defined resolution boundary, Core MUST return `UNRESOLVED` rather than invent a winner.
22. **Precedence cannot make an ineligible candidate eligible.** Precedence may resolve a conflict between eligible candidates, but it cannot make an otherwise unauthorized, inapplicable, inactive, or invalid candidate eligible for conflict resolution.
23. **Precedence cannot create authority.** `Precedence MUST NOT create, grant, expand, or strengthen authorization.`
24. **Precedence acts only on eligible candidates.** `Precedence MAY select a governing candidate only among candidates that are already authorized, applicable, active, and valid.`
25. **Precedence cannot bypass eligibility.** `A precedence rule MUST NOT make an otherwise unauthorized, inapplicable, inactive, or invalid candidate eligible for conflict resolution.`
26. **Conflict resolution does not mutate authorization.** `Resolving a policy conflict through precedence MUST NOT mutate the authorization status of the participating candidates.`
27. **Outcome change is not authority mutation.** Selecting a governing candidate may change the effective policy result without changing the authorization standing of any participating candidate.
28. **Precedence does not interpret effect types.** Precedence selects a governing candidate; it does not need outcome-specific semantics for every possible candidate effect.
29. **Effective outcome follows governing candidate selection.** A candidate's semantic effect may be established independently of precedence, but the effective outcome is derived only after a governing candidate is selected.
30. **Execution order is not semantic order by default.** The architecture does not require eager or lazy effect evaluation when either strategy preserves the same defined semantics.

## Current conceptual evaluation pipeline

The working conceptual pipeline is now:

```text
Context
  ↓
Candidate evaluation
  ├─ Applicability
  ├─ Activation
  ├─ Validity
  ├─ Authority
  └─ Conditions / predicates / applicable prerequisites
  ↓
Eligible candidates
  ↓
Conflict detection
  ├─ No conflict → no governing-candidate selection required
  │                 → effective result from applicable candidate semantics
  │
  └─ Conflict
       ↓
   Applicable explicit precedence rules
       ↓
   Unique deterministic result?
       ├─ YES → governing candidate
       │          ↓
       │       candidate effect / effect evaluation
       │          ↓
       │       effective outcome
       │
       └─ NO  → UNRESOLVED
```

Important distinctions:

- **Authority** answers whether a candidate has authorization standing to participate.
- **Eligibility** captures the requirements that must be satisfied before precedence can consider a candidate, including authorization, applicability, activation, validity, and relevant conditions/predicates/prerequisites.
- **Precedence** resolves a conflict among eligible candidates only when an explicit applicable policy assigns it that role.
- **Candidate effect** is the semantic contribution/effect carried by a policy-bearing candidate; it is not itself the governing result.
- **Governing candidate** is selected only when a conflict requires a winner among eligible candidates.
- **Effective outcome** is derived from the governing candidate's effect after conflict resolution.
- A candidate that loses precedence remains authorized if it was authorized before conflict resolution; precedence does not revoke or rewrite that authorization.
- A precedence rule is itself a policy input and therefore cannot gain authority merely by being closer in the repository, more specific by path, discovered first, or otherwise incidentally ordered.
- Conditions and predicates may contribute to eligibility, but precedence does not evaluate them.
- A prerequisite may be a context-level condition or may represent a semantic dependency on another decision source; the latter case remains an open semantic question.
- `Dependency` is deliberately not yet a Core semantic category because its meaning depends on the relationship being represented.
- An implementation may compute effects before or after candidate selection when the resulting semantics are equivalent; this is an execution-strategy question unless a concrete semantic dependency proves otherwise.

## Current candidate-level precedence decision point

The earlier outcome-vs-candidate question has been narrowed substantially by the counterexample pass.

**Working model — Candidate-level precedence**

Precedence selects a governing eligible policy-bearing candidate:

```text
Candidate A → eligible → effect ALLOW
Candidate B → eligible → effect DENY
                  ↓
              conflict
                  ↓
              precedence
                  ↓
           Candidate B governs
                  ↓
          effective outcome DENY
```

This model is currently the preferred semantic direction because:

- precedence remains a relation among decision sources rather than a language over outcome values;
- new effect types do not require extending precedence semantics;
- candidate semantics can contain more information than a bare outcome;
- eligibility remains a prerequisite to precedence;
- authorization, precedence, and effective outcome remain distinct.

This is still a **working model**, not yet a formal numbered Architecture Decision. The next chapter should test it further around prerequisites and decision-source dependencies before promotion.

## Open questions

- What exactly constitutes a `candidate` for precedence and whether `policy-bearing candidate` should remain the Core abstraction rather than `RULE`-specific terminology.
- What exactly constitutes eligibility beyond applicability, activation, validity, and authority.
- Where `conditions` and `predicates` end and other forms of semantic prerequisite begin.
- How to distinguish **context prerequisites** from **decision prerequisites** without introducing unnecessary machinery.
- Whether a prerequisite that depends on another decision source creates a dependency graph that affects eligibility evaluation.
- What semantic roles `dependency` may represent; avoid making it an unrestricted catch-all relationship.
- Whether decision prerequisites can create cycles and, if so, how cycles terminate as `UNRESOLVED` or otherwise under explicit semantics.
- Whether effect evaluation can itself contain prerequisites/dependencies that are not eligibility requirements.
- Whether `RESOLVE` is a TRACE event and its exact semantic boundary.
- Formal semantics for invalid, ambiguous, inactive, expired, revoked, chained, and cyclic OVERRIDEs.
- Final temporary OVERRIDE lifetime/expiration/revocation semantics and user-facing observability.
- Which accepted working invariants should be promoted into numbered formal AD entries.
- Final interaction among precedence, Applicability, Activation, Authority, Specificity, and OVERRIDE.
- Whether precedence rules themselves can conflict and how the defined resolution boundary terminates without recursive invention.
- TRACE event schema and provenance fields, including the role of `decision_id`.
- Project-Agnosticity classification (`CORE / PROJECT-SPECIFIC / ADAPTABLE`) for the resulting semantics before structural refactoring.

## Current implementation state

The repository remains in the legacy/pre-refactor AI-instruction layout. No structural architecture refactor has been executed. `docs/PROJECT-INSTRUCTIONS.md` remains a legacy aggregate and must be semantically redistributed and verified before deletion.

No implementation of an OVERRIDE engine, authorization engine, precedence engine, candidate evaluator, or TRACE subsystem has been started as part of this architecture pass.

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
- `.ai/skills/deep-understanding/SKILL.md`
