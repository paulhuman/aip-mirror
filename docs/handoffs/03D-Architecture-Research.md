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

Continue the project-wide AI-instruction architecture research from 03C. The current focus is the **OVERRIDE Architecture Decision Pass**, now concentrated on authorization boundaries and precedence semantics. Structural refactoring remains deferred until the relevant semantics are sufficiently stable.

The immediate unresolved boundary is whether precedence selects a governing policy-bearing candidate/rule or merely selects among already computed outcomes. The next step should continue the one-decision-at-a-time counterexample process rather than prematurely freezing the model.

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
23. **Precedence cannot create authority.** `Precedence MUST NOT create, grant, expand, or strengthen authorization.` This remains a working invariant pending the next candidate-level precedence decision.
24. **Precedence acts only on eligible candidates.** `Precedence MAY select a governing outcome only among candidates that are already authorized, applicable, active, and valid.`
25. **Precedence cannot bypass eligibility.** `A precedence rule MUST NOT make an otherwise unauthorized, inapplicable, inactive, or invalid candidate eligible for conflict resolution.`
26. **Conflict resolution does not mutate authorization.** `Resolving a policy conflict through precedence MUST NOT mutate the authorization status of the participating candidates.`
27. **Outcome change is not authority mutation.** Selecting a governing candidate/outcome may change the effective policy result without changing the authorization standing of any participating candidate.

## Current precedence model

The current working pipeline is:

```text
Context
  ↓
Applicability / Activation / Validity / Authority evaluation
  ↓
Eligible candidates
  ↓
Conflict detection
  ↓
Applicable explicit precedence rules
  ↓
Unique deterministic result?
  ├─ YES → governing candidate/outcome → effective result
  └─ NO  → UNRESOLVED
```

Important distinctions:

- **Authority** answers whether a candidate has authorization standing to participate.
- **Eligibility** captures the conditions required before precedence can consider a candidate, including authorization, applicability, activation, and validity.
- **Precedence** resolves a conflict among eligible candidates only when an explicit applicable policy assigns it that role.
- **Effective outcome** is the resulting governing policy effect; it must not be confused with authorization standing.
- A candidate that loses precedence remains authorized if it was authorized before conflict resolution; precedence does not revoke or rewrite that authorization.
- A precedence rule is itself a policy input and therefore cannot gain authority merely by being closer in the repository, more specific by path, discovered first, or otherwise incidentally ordered.

## Current unresolved decision point

### Precedence candidate semantics: outcome vs governing policy-bearing candidate

Two models are under consideration:

**Model A — Outcome-level precedence**

Precedence selects among already computed outcomes such as `ALLOW` and `DENY`:

```text
Rule A → ALLOW
Rule B → DENY
        ↓
    precedence
        ↓
      DENY
```

**Model B — Candidate/rule-level precedence**

Precedence selects a governing eligible policy-bearing candidate/rule, whose already-established semantic outcome then governs:

```text
Rule A → ALLOW
Rule B → DENY
        ↓
    precedence
        ↓
   Rule B governs
        ↓
      DENY
```

The current discussion leans toward candidate/rule-level precedence because policy-bearing candidates contain more semantics than a bare outcome and because it keeps precedence expressed as a relation among decision sources rather than turning it into an `ALLOW/DENY` combining language. However, this is **not yet an accepted Architecture Decision**. Continue with counterexamples before freezing it.

Potential terminology under consideration: `governing candidate` is intentionally broader than `governing rule` until it is established which policy-bearing entities can participate in conflict resolution.

## Open questions

- Whether precedence selects governing policy-bearing candidates/rules or merely computed outcomes.
- What exactly constitutes a `candidate` for precedence and whether the term should remain generic (`policy-bearing candidate`) rather than `RULE`-specific.
- Formal semantics for invalid, ambiguous, inactive, expired, revoked, chained, and cyclic OVERRIDEs.
- Whether `RESOLVE` is a TRACE event and its exact semantic boundary.
- Final temporary OVERRIDE lifetime/expiration/revocation semantics and user-facing observability.
- Which accepted working invariants should be promoted into numbered formal AD entries.
- Final interaction among precedence, Applicability, Activation, Authority, Specificity, and OVERRIDE.
- Whether precedence rules themselves can conflict and how the defined resolution boundary terminates without recursive invention.
- TRACE event schema and provenance fields, including the role of `decision_id`.
- Project-Agnosticity classification (`CORE / PROJECT-SPECIFIC / ADAPTABLE`) for the resulting semantics before structural refactoring.

## Current implementation state

The repository remains in the legacy/pre-refactor AI-instruction layout. No structural architecture refactor has been executed. `docs/PROJECT-INSTRUCTIONS.md` remains a legacy aggregate and must be semantically redistributed and verified before deletion.

No implementation of an OVERRIDE engine, authorization engine, precedence engine, or TRACE subsystem has been started as part of this architecture pass.

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
- Do not introduce numeric, path-depth, discovery-order, filename-order, timestamp, or incidental ordering as hidden authority/precedence.
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

- 03C is `HANDED_OFF`; 03B is `SUPERSEDED`; 03A is `SUPERSEDED`; the lifecycle chain is coherent for the current 03D chapter.
- 03D was initialized from the 03C receiving checkpoint and remains `DRAFT`.
- No structural architecture refactor has been committed.
- The authorization/precedence conclusions listed above were explicitly accepted during the 03D discussion as working architecture semantics.
- The repository handoff document was read before update and the resulting file must be read back and verified after the write.

### Inferred

- The evidence accumulated in 03C plus the focused 03D decision pass is sufficient to continue with targeted semantic counterexamples rather than broad exploratory research.
- Candidate-level precedence is currently a promising model, but remains provisional until tested against cases where a policy-bearing candidate contains semantics beyond a simple `ALLOW/DENY` outcome.
- Keeping authorization standing separate from governing/effective outcome is a strong architectural boundary and should be preserved unless a counterexample requires refinement.

### Assumed / unverified

- Exact candidate semantics for precedence remain unverified.
- The final authority mechanism remains external/abstract by design, but its concrete integration contract is unverified.
- The final TRACE schema and temporary OVERRIDE lifetime schema remain unverified.

### Open

- All unresolved questions listed under `Open questions` remain open until explicitly resolved and documented.

## Last completed task

Updated this 03D handoff in detail after the OVERRIDE-04H precedence-policy decision pass. The checkpoint now records the accepted authorization/precedence working invariants, the distinction between authorization standing and effective outcome, the deterministic-or-`UNRESOLVED` resolution boundary, and the next unresolved candidate-level precedence question.

## Immediate next task

Continue the **Precedence Candidate Semantics** decision point: test **outcome-level precedence vs governing policy-bearing candidate/rule-level precedence** with concrete counterexamples. Establish what qualifies as a precedence candidate and whether `governing candidate` should remain the Core abstraction. Do not promote the provisional model to a formal AD until the counterexample pass is complete.

After that, continue the remaining OVERRIDE semantics (invalid/ambiguous/inactive/chained/cyclic behavior, temporary lifecycle, TRACE `RESOLVE`) and then perform the Project-Agnosticity Check before structural refactoring.

## Things not to redo

- Do not recreate 03A or 03B architecture decisions from scratch.
- Do not redesign the chapter/handoff model.
- Do not recreate the 03C OVERRIDE counterexample pass unless a new semantic question requires it.
- Do not treat specificity/path/depth as implicit override authority or precedence.
- Do not treat authority level as implicit conflict precedence.
- Do not treat temporary OVERRIDE as implicitly inferred from context.
- Do not add `override.scope` without a new architecture decision.
- Do not allow precedence to make an ineligible candidate eligible.
- Do not allow precedence to create, grant, expand, or strengthen authorization.
- Do not mutate authorization standing merely because a candidate loses a policy conflict through precedence.
- Do not begin structural refactoring prematurely.
- Do not begin native AIP implementation merely because architecture work continues.
- Do not copy every browsed URL into the handoff; preserve only materially relevant references with Roles.

## Recommended starting context for next chapter

Start with this `DRAFT` and `docs/handoffs/03C-Architecture-Research.md`. The lifecycle/bootstrap procedure has already been applied. The current checkpoint includes the focused OVERRIDE authorization and precedence decisions through **OVERRIDE-04H**. Before substantive work, complete post-bootstrap/read-back verification against the repository state, then continue from the unresolved **Precedence Candidate Semantics** decision point rather than restarting earlier research.
