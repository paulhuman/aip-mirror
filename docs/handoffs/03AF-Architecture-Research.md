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

The immediate task was a focused **Prerequisite / Dependency Semantics counterexample pass**. The concrete semantic relationship was to be established before introducing any generic dependency mechanism.

## Completed

Bootstrap established this chapter from the 03E handoff. The 03E working model remained the starting point:

```text
eligibility
  → conflict detection
  → explicit precedence
  → governing candidate
  → candidate effect
  → effective outcome
```

The prerequisite/dependency counterexample pass was extended through chains and cycles. The resulting working model is now:

```text
1. Relationship structure
2. Semantic resolution
3. Execution strategy
```

This separation is explicit: dependency relationships describe semantic structure; semantic resolution determines what those relationships mean and what result follows; execution strategy is an implementation concern and must not be allowed to create semantic meaning through incidental ordering.

The chain/cycle pass established the following working observations:

- An acyclic dependency chain can be resolved from an independent source when the relevant consumer semantics are defined.
- A dependency predicate being `FALSE` does not by itself imply a particular consumer result such as `DENIED`; the consequence is defined by the consumer semantics.
- `UNRESOLVED` at a dependency target does not automatically define the consumer result; propagation semantics remain a separate open question.
- A cycle is a recursive relationship structure, not automatically an error and not automatically `UNRESOLVED`.
- A cycle may admit self-consistent states, but the existence of such a fixed point does not itself specify a rule that selects it.
- Incidental execution order cannot resolve a semantic cycle.
- If cyclic dependencies are to be supported, explicit cycle-resolution/termination semantics would be required. Whether Core needs such semantics remains open.

Candidate-level precedence was also tested against dependency targets. The working distinction remains:

```text
dependency target
        ≠
consumer role
        ≠
precedence
```

Precedence may change a dependency result when the dependency explicitly targets a semantic result that precedence changes (for example, an effective outcome), while a dependency targeting a candidate effect or authority standing can remain unchanged. Precedence does not become a generic dependency resolver.

## Current implementation state

The repository remains in the legacy/pre-refactor AI-instruction layout. No structural architecture refactor has been executed.

No implementation of a generic dependency engine, precedence engine, authorization engine, candidate evaluator, or TRACE subsystem has been started as part of this research pass.

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

## Prerequisite / dependency semantic boundary

The research now uses the following working model:

```text
DEPENDENCY TARGET
    authority standing
    candidate-level result / candidate effect
    effective decision result

        ×

CONSUMER ROLE
    eligibility-related requirement
    effect/effective-outcome evaluation
```

This is a working semantic model, not yet a formal Architecture Decision. Not every combination is assumed to be valid.

A **decision-source relationship** is therefore not assumed to be an eligibility prerequisite merely because it references another decision source. The relationship references a semantic result/property of the source; the **consumer role** determines where and how that referenced result is used.

A dependency may connect two decision/pipeline instances without becoming a universal pipeline stage.

## Chain and cycle semantics — current working conclusions

### Chain

For a chain such as:

```text
A → B → C
```

what propagates is not simply `C result → B result → A result`. The semantic structure is better represented as:

```text
C semantic result
     ↓
relationship predicate
     ↓
B consumer semantics
     ↓
B semantic result
     ↓
relationship predicate
     ↓
A consumer semantics
```

The exact consumer consequence of `TRUE`, `FALSE`, or `UNRESOLVED` remains relationship/consumer-specific.

### Cycle

For a cycle such as:

```text
A → B → A
```

there is no independent semantic source inside the cycle. The cycle therefore requires explicit semantics if it is to be resolved.

Working rule:

```text
cycle
  ≠ automatically invalid
  ≠ automatically UNRESOLVED
  → requires explicit resolution/termination semantics if supported
```

Execution order must not be used as an implicit cycle-breaking mechanism.

### Precedence interaction

If a dependency targets `B.effective_outcome`, precedence may change the dependency result by changing B's effective outcome. If it targets `B.candidate_effect`, precedence may leave that target unchanged even when B loses precedence. Therefore dependency target must remain distinct from both consumer role and precedence.

## Completed counterexample pass

The following four cases were tested with resolved-positive, resolved-negative, and `UNRESOLVED` states:

1. **Eligibility chain** — `A eligibility → B → C`.
2. **Eligibility cycle** — `A eligibility → B eligibility → A eligibility`.
3. **Effect chain** — `A.effect → B.effective_outcome → C.effective_outcome`.
4. **Effect cycle** — `A.effect → B.effective_outcome → A.effective_outcome`.

The pass did not justify introducing a generic dependency engine or a universal propagation mechanism.

## Candidate-level precedence status

Candidate-level precedence remains a working direction, not yet a formal Architecture Decision.

The counterexamples support keeping precedence separate from dependency semantics:

```text
eligibility
  → conflict detection
  → explicit precedence
  → governing candidate
  → candidate effect
  → effective outcome
```

A dependency may reference a result produced within or around this process, but its presence does not by itself redefine the pipeline or grant precedence permission to bypass eligibility.

## Open questions

- Which prerequisites are context predicates/conditions and therefore part of eligibility?
- Which prerequisites are decision-source relationships?
- Which combinations of dependency target and consumer role should Core permit?
- Whether a dependency may be evaluated without making eligibility equivalent to hidden full candidate/effect evaluation.
- Whether candidate effects may contain dependencies that do not affect eligibility.
- Exact semantics for `UNRESOLVED` dependency predicates and their consumer consequences.
- Whether dependency graphs have semantic ordering, implementation ordering, or both.
- Whether cycles should be supported at all in Core semantics.
- If cycles are supported, what explicit resolution/termination semantics should apply.
- Whether a governing candidate can depend on a candidate that loses precedence, and what semantic consequences follow for different dependency targets.
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

This pipeline remains a working direction. It must be refined if future counterexamples demonstrate that a decision-source dependency crosses the current eligibility/effect boundary in a way that cannot be represented by an explicit relationship plus consumer semantics.

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

### Persistent research

- `docs/architecture/prerequisite-dependency-semantics.md`

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
- The chains/cycles counterexample pass was completed for eligibility and effect chains/cycles, including resolved-positive, resolved-negative, and `UNRESOLVED` states.

### Inferred

- Context prerequisites likely fit naturally within eligibility, while decision-source prerequisites require an explicit relationship whose consumer role must be identified rather than assumed.
- The key architectural boundary is whether a dependency is a requirement for candidate participation or a relationship needed only to evaluate a candidate's effect.
- Cycles introduce a distinct semantic problem because they lack an independent source within the recursive relationship structure.

### Assumed / unverified

- Exact semantics of `UNRESOLVED` dependency predicates and consumer consequences remain unverified.
- Whether cycles should be supported in Core remains unverified.
- Exact dependency graph semantics remain unverified.
- The final effect of dependencies on candidate-level precedence remains unverified.

### Open

- Prerequisite/dependency semantics.
- Dependency graph and cycle semantics.
- Candidate-level precedence formalization.

## Last completed task

Completed the focused chains-and-cycles counterexample pass for prerequisite/dependency semantics. The working separation `relationship structure → semantic resolution → execution strategy` was confirmed, and the pass did not justify a generic dependency engine or universal propagation semantics.

## Immediate next task

Proceed to the next research step after the chains/cycles checkpoint. The exact next step is intentionally left open for the next discussion rather than precommitting the architecture to a particular dependency/cycle mechanism.

## Things not to redo

- Do not restart broad OVERRIDE research unless a new counterexample requires it.
- Do not re-derive the established authorization boundary decisions from 03D/03E unless the new prerequisite/dependency evidence directly challenges them.
- Do not redesign the handoff mechanism as part of this semantic research task; the recurring handoff ownership problem is preserved as a separate future architecture/process task.
- Do not repeat the completed chains/cycles counterexample pass unless new evidence directly challenges its conclusions.

## Recommended starting context for next chapter

Use the current working model as the baseline:

```text
Relationship structure
        ↓
Semantic resolution
        ↓
Execution strategy
```

Keep dependency target, consumer role, and precedence as separate semantic dimensions. Continue with the smallest counterexample that can distinguish the next unresolved boundary, and preserve the working direction `eligibility → conflict detection → explicit precedence → governing candidate → candidate effect → effective outcome` unless a concrete counterexample demonstrates that the boundary must change.
