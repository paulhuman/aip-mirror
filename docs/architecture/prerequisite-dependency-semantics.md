# Prerequisite / Dependency Semantics — Counterexample Research

Status: WORKING RESEARCH

Chapter:
AIP Mirror — 03AF — Architecture & Research

## Overview

This document records the first counterexample pass for the semantic boundary between context prerequisites, decision-source prerequisites, eligibility requirements, candidate-effect dependencies, dependency graphs/cycles, and candidate-level precedence.

This is research, not a formal Architecture Decision. Candidate-level precedence remains a working direction.

## Scope

The pass asks one question at a time:

1. Is the prerequisite about the current context or another decision source?
2. If another decision source is involved, is its result required for candidate eligibility or only for candidate-effect evaluation?
3. What semantic object is actually depended upon: authority, candidate effect, or effective decision outcome?
4. What happens when dependencies form chains or cycles?
5. Does candidate-level precedence remain independent of these dependencies?

A generic dependency engine is deliberately out of scope until a concrete semantic relationship demonstrates a need for one.

## Counterexample 1 — Pure context prerequisite

```text
Candidate A:
  prerequisite = context.mode == SAFE
  effect = ALLOW
```

Observation: the prerequisite is evaluated from context. No other policy-bearing decision source is needed.

Working interpretation: this is an eligibility requirement. It can be represented semantically as a predicate/condition contributing to candidate eligibility. No dependency graph is required.

Result:

```text
context prerequisite
    → eligibility
```

## Counterexample 2 — Decision-source prerequisite

```text
Candidate A:
  prerequisite = B must authorize X
  effect = TRANSFORM(X)

Candidate B:
  effect = ALLOW
```

Observation: determining whether A may participate now requires a result associated with B. This cannot be treated as an ordinary context predicate without hiding the fact that another decision source must be evaluated.

Critical semantic distinction: `B must authorize X` is ambiguous unless the architecture specifies what A depends on:

- B's authority standing to authorize X;
- B's candidate effect;
- B's effective outcome after B participates in conflict resolution;
- some other established decision result produced by B.

Working interpretation: the relationship is a **decision-source prerequisite**. It may contribute to A's eligibility, but the dependency itself is a distinct relationship from a simple context predicate.

Result:

```text
decision-source prerequisite
    → requires a defined result from B
    → may affect A eligibility
```

No generic dependency engine follows from this alone. The architecture first needs to define the semantic object being referenced.

## Counterexample 3 — Candidate-effect dependency without eligibility dependency

```text
Candidate A:
  eligibility = otherwise satisfied
  effect = TRANSFORM(X) only if B's effective decision permits X

Candidate B:
  effect = ALLOW
```

Observation: A can be eligible even though B's result is not yet known. The dependency is needed to determine A's eventual semantic effect/effective outcome, not whether A may participate in conflict resolution.

Working interpretation: this is a **candidate-effect dependency** and must not automatically be folded into eligibility.

This demonstrates that `dependency` cannot simply mean `eligibility prerequisite`.

Result:

```text
A eligibility
    → can succeed independently

A selected effect
    → may depend on B's decision result
    → effective outcome may therefore remain unresolved
```

## Counterexample 4 — Dependency plus candidate-level precedence

```text
Candidate A:
  eligible
  effect = ALLOW if B's effective decision permits X

Candidate B:
  eligible
  effect = ALLOW

Candidate C:
  eligible
  effect = DENY

Precedence:
  C governs the conflict between B and C
```

Observation: if A's dependency means **B's effective outcome**, then B losing precedence means B's effective outcome may be DENY (or otherwise governed by the B/C conflict), so A's effect can change accordingly. If the dependency instead means **B's authorization standing**, B can lose precedence while remaining authorized, and A may still satisfy the dependency.

Therefore precedence does not by itself break dependency semantics. The architecture must define what result the dependency references.

Working interpretation:

- candidate-level precedence can remain a separate conflict-resolution relation;
- dependencies must point to a semantically defined result/source property;
- a dependency must not silently mean "the candidate's raw effect before precedence" if the intended relationship is to an effective decision.

This is a strong reason not to formalize candidate-level precedence until dependency reference semantics are clearer.

## Counterexample 5 — Dependency chain

```text
A eligibility depends on B result.
B eligibility depends on C result.
C has no dependency.
```

Observation: a decision-source prerequisite can create a chain of required evaluations.

Working interpretation: a graph-like semantic structure may exist, but the graph is a consequence of explicit decision-source relationships rather than evidence for a generic dependency subsystem.

A useful semantic distinction emerges:

```text
relationship declaration
    ≠
execution engine
```

The architecture may need to define the meaning and termination rules of the relationship without prescribing a particular graph algorithm or evaluation order.

## Counterexample 6 — Direct cycle

```text
A eligibility depends on B result.
B eligibility depends on A result.
```

Observation: neither candidate can establish its eligibility independently if both dependencies are strict prerequisites.

Working interpretation: this is a semantic cycle, not merely an implementation ordering problem. An implementation cannot solve it by choosing A-first or B-first without adding semantics that the model did not define.

Provisional conclusion: a strict eligibility dependency cycle must not be resolved by incidental evaluation order. The architecture needs an explicit cycle outcome/termination rule. `UNRESOLVED` is a plausible result, but this remains to be tested against other cycle forms before becoming a formal rule.

## Counterexample 7 — Effect cycle

```text
A is eligible.
A effect depends on B effective outcome.
B is eligible.
B effect depends on A effective outcome.
```

Observation: both candidates can enter conflict resolution, yet their final effects may be mutually recursive.

This differs from the eligibility cycle: eligibility itself is established, but effective outcomes cannot necessarily be derived without solving a recursive dependency.

Working interpretation: cycle semantics may need to distinguish at least:

- eligibility cycles;
- effect/effective-outcome cycles.

Therefore a single blanket rule such as "dependency cycles are invalid" may be too coarse.

## Provisional semantic boundary

The first pass supports the following provisional distinctions:

```text
Context prerequisite
    → eligibility requirement

Decision-source prerequisite
    → relationship whose referenced decision result may be required for eligibility

Candidate-effect dependency
    → relationship whose referenced decision result may be required for effect/effective-outcome evaluation

Dependency graph
    → possible semantic structure induced by explicit decision-source relationships

Cycle
    → semantic condition requiring explicit termination semantics;
       must not be resolved by incidental execution order
```

The term `dependency` should therefore remain relational rather than become a universal engine concept.

## Interaction with candidate-level precedence

The current evidence does not invalidate the working pipeline:

```text
eligibility
  → conflict detection
  → explicit precedence
  → governing candidate
  → candidate effect
  → effective outcome
```

However, a dependency can cross the boundary between these stages. In particular:

- an eligibility dependency must be resolved before a candidate can enter precedence;
- an effect dependency may remain unresolved until after a governing candidate is selected;
- a dependency may refer to an effective decision whose own result was produced through precedence;
- therefore a dependency must identify **what semantic result it references**, not merely name another candidate.

This suggests that candidate-level precedence and dependency semantics can coexist, but their interface cannot be formalized until dependency target semantics are defined.

## Evidence / confidence

### Confirmed / observed

- Context-only prerequisites can be represented without another decision source.
- A decision-source prerequisite cannot be fully understood as a context predicate because another policy-bearing result is involved.
- A candidate-effect dependency can exist without being an eligibility requirement.
- Candidate-level precedence may change the result referenced by a dependency when the dependency targets an effective decision outcome.
- Incidental execution order must not be used to resolve semantic cycles.

### Inferred

- `dependency` is best treated initially as a relationship category, not as a generic execution engine.
- Decision-source prerequisites may belong semantically to eligibility while retaining a distinct relationship type from ordinary context predicates.
- Effect dependencies may require a distinct post-eligibility semantic stage.
- Dependency targets likely need to distinguish authority standing from candidate/effective decision results.

### Assumed / unverified

- Strict eligibility cycles should terminate as `UNRESOLVED`.
- Effect/effective-outcome cycles should also terminate as `UNRESOLVED`, or may require a more specific rule.
- The architecture may need a formal distinction between a dependency on authority, candidate effect, and effective outcome.

### Open questions

- What exact object/result does the phrase "B must authorize X" reference?
- Can a dependency explicitly target authorization standing without depending on B's effective policy outcome?
- Can a dependency target a candidate's pre-precedence semantic contribution, or should dependencies reference only defined decision results?
- How should a dependency behave when its target decision is itself `UNRESOLVED`?
- Are all dependency cycles necessarily `UNRESOLVED`, or are some structurally invalid before evaluation?
- Can an effect dependency be conditionally active without becoming an eligibility prerequisite?
- Can dependency relationships themselves participate in conflict resolution, or are they always semantic prerequisites/inputs?
- What is the minimum formal vocabulary needed to express these relationships without creating a generic dependency engine?

## Current research conclusion

Do **not** formalize candidate-level precedence yet.

The counterexample pass has established enough to say that the prerequisite/dependency boundary is real and cannot be collapsed into a single generic `condition` concept. The next step is to sharpen the target of a decision-source dependency: authority standing versus candidate effect versus effective decision outcome, then test `UNRESOLVED` propagation and cycle semantics for each case.
