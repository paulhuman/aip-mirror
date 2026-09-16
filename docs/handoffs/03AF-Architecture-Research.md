# Conversation Handoff

Conversation:
AIP Mirror — 03AF — Architecture & Research

Specialization:
03

Chapter:
AF

Previous chapter:
AIP Mirror — 03E — Architecture & Research

Status:
DRAFT

## Current objective

Continue the project-wide AI-instruction architecture research from 03E. The current focus is the semantic boundary between **prerequisites**, **dependencies**, **candidate eligibility**, **candidate effects**, and **candidate-level precedence**.

The immediate task is a focused **Prerequisite / Dependency Semantics counterexample pass**. Establish the concrete semantic relationship before introducing any generic dependency mechanism.

## Completed

Bootstrap has established this chapter from the 03E handoff. The 03E working model remains the starting point:

```text
eligibility
  → conflict detection
  → explicit precedence
  → governing candidate
  → candidate effect
  → effective outcome
```

Candidate-level precedence remains a working direction, not yet a formal Architecture Decision.

## Current implementation state

The repository remains in the legacy/pre-refactor AI-instruction layout. No structural architecture refactor has been executed.

No implementation of a generic dependency engine, precedence engine, candidate evaluator, authorization engine, or TRACE subsystem has been started as part of this research pass.

## Decisions / working invariants carried forward

- OVERRIDE uses Explicit Authorization as the baseline; declaration is not authorization and TRACE is not authority.
- Authorization is bounded; delegation requires explicit authorization and cannot expand the source grant.
- Target-specific authorization is the Core semantic primitive; target-class authorization remains outside Core pending a separate architecture decision.
- Core consumes externally established authority and does not define the mechanism for constructing/verifying authority chains.
- `AUTHORIZED / DENIED / UNRESOLVED` at external authority establishment remain distinct from Core current-operation results such as `EFFECTIVE / DENIED / UNRESOLVED`.
- Specificity and authority do not independently create precedence; they may participate only through explicit precedence policy.
- Precedence acts only on already eligible candidates and cannot bypass or create eligibility or authority.
- Hidden precedence from path depth, discovery order, filename order, timestamps, IDs, or incidental processing order is prohibited.
- If applicable resolution rules do not produce a unique deterministic result within the defined resolution boundary, the result is `UNRESOLVED`.
- Conflict resolution does not mutate authorization standing.
- Candidate effect and effective outcome are distinct semantic concepts.
- Execution order is not semantic order by default; architecture should not prescribe eager versus lazy evaluation without a semantic reason.
- `Dependency` is intentionally not yet a generic Core semantic category.

## Prerequisite / dependency counterexample scope

Test the following distinctions one at a time:

1. **Context prerequisites** — requirements about the current context that can plausibly be evaluated as predicates/conditions contributing to eligibility.
2. **Decision-source prerequisites** — requirements whose truth depends on another policy-bearing decision source.
3. **Eligibility requirements** — requirements that must hold before a candidate may participate in conflict resolution.
4. **Candidate-effect dependencies** — relationships needed to evaluate or realize a candidate's effect but not necessarily required for the candidate to be eligible.
5. **Dependency graphs and cycles** — determine whether decision-source relationships form semantic graphs and what explicit semantics, if any, are required for cycles.
6. **Candidate-level precedence interaction** — determine whether dependencies change the meaning or ordering of eligibility, conflict detection, precedence, governing candidate selection, or effect evaluation.

### Starting counterexample

```text
Candidate A:
  prerequisite = B must authorize X
  effect = TRANSFORM(X)

Candidate B:
  effect = ALLOW
```

Ask separately:

- Is B's decision required to establish A's eligibility?
- Is B required only to evaluate A's effect?
- Is the relationship itself a distinct semantic dependency rather than an eligibility predicate?
- What happens if A and B both participate in a conflict-resolution relationship?
- What happens if B depends on A?
- What happens if A and B form a cycle?

Do not infer an implementation engine from the existence of these relationships. First determine whether the architecture actually needs a first-class dependency semantic, and if so, exactly what it means.

## Open questions

- Which prerequisites are context predicates/conditions and therefore part of eligibility?
- Which prerequisites are decision-source relationships?
- Whether decision-source prerequisites are eligibility requirements, distinct dependencies, or can occupy more than one semantic role depending on the relationship.
- Whether a dependency may be evaluated without making eligibility equivalent to hidden full candidate/effect evaluation.
- Whether candidate effects may contain dependencies that do not affect eligibility.
- Whether dependency graphs have semantic ordering, implementation ordering, or both.
- Whether cycles are possible, and whether an explicit cycle rule is required (for example, termination as `UNRESOLVED`) or whether some cycles are structurally invalid.
- Whether candidate-level precedence remains stable when eligible candidates depend on other decision sources.
- Whether a governing candidate can depend on a candidate that loses precedence, and what semantic consequences follow.
- Whether dependency relationships themselves can conflict and, if so, whether they require precedence or a separate resolution boundary.
- Candidate-level precedence remains unformalized until these questions are sufficiently tested.

## Current conceptual pipeline

Working direction only:

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

This pipeline must be refined if counterexamples demonstrate that a decision-source dependency crosses the current eligibility/effect boundary.

## Relevant files

### Handoff / lifecycle

- `docs/handoffs/03E-Architecture-Research.md`
- `docs/handoffs/03AF-Architecture-Research.md`
- `.ai/skills/conversation-handoff/BOOTSTRAP.md`
- `.ai/skills/conversation-handoff/SKILL.md`
- `.ai/rules/conversation-lifecycle.md`

### Architecture / research guidance

- `.ai/rules/project-architecture.md`
- `.ai/rules/workflow.md`
- `.ai/rules/repository.md`
- `.ai/skills/deep-understanding/SKILL.md`

## Important constraints

- Continue one decision at a time; use counterexamples before formalization.
- Do not introduce a generic dependency engine merely because the term `dependency` appears.
- Do not collapse every prerequisite into `condition` without testing the semantic relationship.
- Do not let precedence bypass eligibility.
- Do not let specificity or authority independently become precedence.
- Do not introduce hidden precedence from incidental ordering.
- Do not promote candidate-level precedence to a formal Architecture Decision until the prerequisite/dependency boundary is sufficiently tested.
- Do not begin structural refactoring until the relevant semantics are sufficiently stable.
- Do not delete `docs/PROJECT-INSTRUCTIONS.md` before semantic redistribution and verification.
- Preserve repository write-safety: read current files, make minimal changes, write complete content, read back, verify content/diff/scope, then commit and verify the resulting ref.

## Evidence / confidence

### Confirmed / observed

- 03E was prepared as `READY_FOR_HANDOFF` for this receiving chapter.
- 03E explicitly left prerequisite/dependency semantics open.
- The candidate-level precedence model is a supported working direction, but is not yet a formal numbered Architecture Decision.
- Current-format chapter identity is `03AF`; `03AA`–`03AE` are not physically used. `03AF` is the first physically created current-format Chapter for specialization 03. Its relationship to 03A–03E is ordinal correspondence only, not identifier identity.

### Inferred

- Context prerequisites likely fit naturally within eligibility, while decision-source prerequisites may require a distinct semantic relationship.
- The key architectural boundary is whether a dependency is a requirement for candidate participation or a relationship needed only to evaluate a candidate's effect.

### Assumed / unverified

- Exact semantics of decision-source prerequisites remain unverified.
- Dependency graph semantics and cycle handling remain unverified.
- The effect of dependencies on candidate-level precedence remains unverified.

### Open

- Prerequisite/dependency semantics.
- Dependency graph and cycle semantics.
- Candidate-level precedence formalization.

## Last completed task

03E completed the handoff checkpoint after the candidate-level precedence counterexample pass and identified prerequisite/dependency semantics as the next unresolved boundary.

## Immediate next task

Run the **Prerequisite / Dependency Semantics counterexample pass**, beginning with context prerequisites versus decision-source prerequisites and then testing candidate-effect dependencies, dependency graphs/cycles, and interactions with candidate-level precedence.

## Things not to redo

- Do not restart broad OVERRIDE research unless a new counterexample requires it.
- Do not re-derive the established authorization boundary decisions from 03D/03E unless the new prerequisite/dependency evidence directly challenges them.
- Do not redesign the handoff mechanism as part of this semantic research task; the recurring handoff ownership problem is preserved as a separate future architecture/process task.

## Recommended starting context for next chapter

Begin with the smallest counterexample that distinguishes a context prerequisite from a decision-source prerequisite. For each case, record whether the relationship affects eligibility, effect evaluation, or both; only then test dependency chains and cycles. Preserve the working direction `eligibility → conflict detection → explicit precedence → governing candidate → candidate effect → effective outcome` unless a concrete counterexample demonstrates that the boundary must change.
