# Prerequisite / Dependency Semantics — Counterexample Research

Status: WORKING RESEARCH

Chapter:
AIP Mirror — 03AF — Architecture & Research

## Overview

This document records the counterexample pass for the semantic boundary between context prerequisites, decision-source prerequisites, eligibility requirements, candidate-effect dependencies, dependency graphs/cycles, and candidate-level precedence.

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

Observation: determining the meaning of A's relationship requires a result associated with B. This cannot be treated as an ordinary context predicate without hiding the fact that another decision source is referenced.

Critical semantic distinction: `B must authorize X` is ambiguous unless the architecture specifies what A depends on:

- B's authority standing to authorize X;
- B's candidate effect;
- B's effective outcome after B participates in conflict resolution;
- some other established decision result produced by B.

Important correction: **the semantic role of a decision-source prerequisite is not established as eligibility.** It is a working hypothesis only. The relationship must first be decomposed by the semantic object it references and by the role that reference plays for A.

Working interpretation: the relationship is a decision-source reference/dependency. Its consumer role remains open until tested.

Result:

```text
decision-source relationship
    → requires a defined result/property from B
    → consumer semantic role UNKNOWN until tested
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

Working interpretation: this is a candidate-effect dependency and must not automatically be folded into eligibility.

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

Observation: a decision-source relationship can create a chain of required evaluations.

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

## Case A — Dependency on B's authority standing

The relationship is made explicit as:

```text
A requires:
    B is authorized to authorize X
```

This is a reference to B's established authorization standing, not to B's candidate effect or effective outcome.

### A1 — B authority = AUTHORIZED

The referenced requirement is satisfied:

```text
B authority(X)
      ↓
  AUTHORIZED
      ↓
dependency condition = satisfied
```

This does **not** by itself prove that the relationship is an eligibility rule. It proves only that the referenced authority requirement is satisfied.

### A2 — B authority = DENIED

The requirement is not satisfied:

```text
B authority(X)
      ↓
    DENIED
      ↓
dependency condition = not satisfied
```

The consequence for A remains a separate semantic rule. `dependency = FALSE` must not be silently equated with `A effective outcome = DENIED`.

### A3 — B authority = UNRESOLVED

The architecture cannot assume that the requirement is satisfied. A natural three-valued interpretation is:

```text
AUTHORIZED  → TRUE
DENIED      → FALSE
UNRESOLVED  → UNRESOLVED
```

but the final consumer consequence remains unformalized.

### A4 — Precedence interaction

B may retain:

```text
B authority(X) = AUTHORIZED
```

while its policy candidate loses precedence and its effective outcome becomes DENY. Therefore precedence can change B's effective outcome without changing B's authority standing.

Conclusion: a dependency on B's authority is not equivalent to a dependency on B's effective outcome.

## Case B — Dependency on B's candidate effect

The relationship is made explicit as:

```text
A requires:
    B's candidate effect = ALLOW
```

### B1 — B candidate effect = ALLOW

The referenced candidate-level requirement is satisfied.

### B2 — B candidate effect = DENY

The referenced requirement is not satisfied. Again, this establishes the dependency predicate, not the final consequence for A.

### B3 — Precedence interaction

Use:

```text
B:
    eligible
    candidate effect = ALLOW

C:
    eligible
    candidate effect = DENY

precedence:
    C > B
```

After conflict resolution:

```text
B candidate effect  = ALLOW
B effective outcome = DENY
```

Therefore a dependency on `B.candidate_effect == ALLOW` can remain satisfied even though B does not become the governing effective decision.

This demonstrates that candidate effect and effective outcome are distinct semantic targets.

### B4 — B candidate effect = UNRESOLVED

If the dependency is an exact requirement for ALLOW, an unresolved candidate effect cannot establish that requirement. A natural three-valued predicate is again plausible:

```text
ALLOW       → TRUE
DENY        → FALSE
UNRESOLVED  → UNRESOLVED
```

but the consumer consequence remains open.

Conclusion: precedence does not automatically invalidate a candidate-effect reference. Whether such a reference is semantically appropriate must be explicit.

## Case C — Dependency on B's effective outcome

The relationship is:

```text
A requires:
    B.effective_outcome == ALLOW
```

Unlike Cases A and B, B must first complete its own decision pipeline:

```text
B eligibility
    ↓
conflict detection
    ↓
explicit precedence
    ↓
governing candidate
    ↓
candidate effect
    ↓
B effective outcome
```

Only then can A evaluate its reference to B's effective outcome.

### C1 — B effective outcome = ALLOW

The dependency condition is satisfied.

### C2 — B effective outcome = DENY

The dependency condition is not satisfied.

### C3 — B effective outcome = UNRESOLVED

The architecture must explicitly define how an exact dependency on ALLOW propagates unresolvedness. It must not be assumed merely from the name `UNRESOLVED`.

### C4 — Precedence interaction

If B initially has candidate effect ALLOW but loses to a higher-precedence DENY candidate, then:

```text
B candidate effect  = ALLOW
B effective outcome = DENY
```

A dependency on B's effective outcome therefore changes as a consequence of B's precedence resolution.

This is different from Cases A and B because the referenced value is downstream of precedence.

## Control Check — Target versus Consumer Role

After Cases A–C, test the same dependency structure across two consumer roles:

```text
A depends on B
```

with the following variants:

1. `A requires B.authority(X)`
2. `A requires B.candidate_effect`
3. `A requires B.effective_outcome`
4. `A's candidate effect depends on B.effective_outcome`

The purpose is to distinguish **what is referenced** from **what the reference does to A**.

### Control 1 — Authority target used as a requirement

```text
A requires B.authority(X)
```

The reference target is B's authority standing. Its consumer role is not inherently determined by the target type. The architecture must separately state whether failure affects A eligibility, A effect, or another semantic property.

### Control 2 — Candidate-effect target used as a requirement

```text
A requires B.candidate_effect == ALLOW
```

Again, the target is a candidate-level result. The target type alone does not prove that it is an eligibility predicate. It could instead be an input to some later semantic evaluation if the model permits that relationship.

### Control 3 — Effective-outcome target used as a requirement

```text
A requires B.effective_outcome == ALLOW
```

The target is a resolved decision result. B must reach an effective outcome before the reference can be evaluated.

This is naturally modeled as a relationship between decision results rather than as an extra stage inside B's pipeline.

### Control 4 — Effective-outcome target used by A's effect

```text
A eligibility = independently satisfied
A candidate effect = TRANSFORM(X) only if B.effective_outcome == ALLOW
```

Here A can participate independently of B. B's result is consulted when evaluating A's effect.

This is a direct counterexample to the claim that every decision-source dependency is an eligibility prerequisite.

## Control Check — Provisional Result

The control pass supports a two-dimensional distinction:

```text
DEPENDENCY TARGET
    ├─ authority standing
    ├─ candidate-level result
    └─ effective decision result

        ×

CONSUMER ROLE
    ├─ eligibility-related requirement
    └─ effect/effective-outcome evaluation
```

This is a **working semantic model**, not yet a formal Architecture Decision.

The important result is that target type and consumer role are independent dimensions. The same decision-source result can, in principle, be referenced for different semantic purposes, provided the architecture explicitly defines the relationship.

This also strengthens the earlier conclusion:

```text
dependency
    ≠ pipeline stage
```

A dependency is better modeled initially as an explicit relationship/reference **between semantic objects or decision results**, potentially connecting two decision pipeline instances. The pipeline itself need not acquire a universal `dependency` stage.

## Provisional semantic boundary

The first pass now supports the following distinctions:

```text
Context prerequisite
    → ordinary context-based eligibility input

Decision-source relationship
    → explicit reference to a defined semantic result/property of another decision source

Dependency target
    → must identify the referenced semantic object/result

Dependency consumer role
    → must separately identify how the reference affects the consuming decision

Dependency graph
    → possible semantic structure induced by explicit cross-decision relationships

Cycle
    → semantic condition requiring explicit termination semantics;
       must not be resolved by incidental execution order
```

The term `dependency` should therefore remain relational rather than become a universal engine concept or pipeline stage.

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

Dependencies can reference results at different semantic points without becoming a new stage in this pipeline.

In particular:

- an eligibility-related dependency must be resolved before a candidate can enter precedence;
- an effect dependency may remain unresolved until after a governing candidate is selected;
- a dependency may refer to an effective decision whose own result was produced through precedence;
- a dependency on authority standing is not rewritten by policy precedence;
- a dependency on candidate effect need not change merely because that candidate loses precedence;
- a dependency on effective outcome can change because precedence changed the referenced decision's result.

Therefore a dependency must identify **what semantic result it references** and **what role that reference plays for the consumer**.

## Evidence / confidence

### Confirmed / observed

- Context-only prerequisites can be represented without another decision source.
- A decision-source relationship cannot be fully understood as a context predicate because another policy-bearing result is involved.
- Authority standing, candidate effect, and effective outcome are distinct semantic targets.
- Candidate-level precedence can change an effective outcome without changing authority standing or the candidate effect that lost the conflict.
- A dependency on effective outcome can therefore change as a consequence of precedence, while a dependency on authority or candidate effect need not.
- A candidate-effect dependency can exist without being an eligibility requirement.
- The same dependency target category can be considered for different consumer roles; target and role are separate semantic dimensions.
- A dependency is better treated initially as an explicit relationship/reference between semantic objects or decision results, potentially connecting two decision pipeline instances, rather than as a universal pipeline stage.
- Incidental execution order must not be used to resolve semantic cycles.

### Inferred

- `dependency` is best treated initially as a relationship category, not as a generic execution engine.
- Decision-source references likely need explicit target typing: authority standing, candidate-level result, or effective decision result.
- Consumer role likely needs to be explicit rather than inferred from target type; at minimum, eligibility-related and effect/effective-outcome roles need separate consideration.
- Dependency chains can be modeled as relationships between decision sources without committing to a particular graph algorithm or evaluation order.

### Assumed / unverified

- Exact dependency predicates may naturally use three-valued semantics (`TRUE / FALSE / UNRESOLVED`).
- Strict eligibility cycles should terminate as `UNRESOLVED`.
- Effect/effective-outcome cycles should also terminate as `UNRESOLVED`, or may require a more specific rule.
- Some dependency targets or consumer roles may be disallowed by Core even if they are conceptually expressible.

### Open questions

- What exact consumer consequences correspond to dependency predicate `TRUE`, `FALSE`, and `UNRESOLVED`?
- Is every eligibility-related cross-decision reference a dependency, or can some be represented using existing authorization/eligibility concepts without a dependency relation?
- Should Core permit dependencies on candidate-level effects that do not become governing decisions?
- Can dependencies target only defined decision results, or may they reference intermediate semantic properties?
- How should a dependency behave when its target decision is itself `UNRESOLVED`?
- Are all dependency cycles necessarily `UNRESOLVED`, or are some structurally invalid before evaluation?
- Can dependency relationships themselves participate in conflict resolution, or are they always semantic inputs/references?
- What is the minimum formal vocabulary needed to express these relationships without creating a generic dependency engine?

## Current research conclusion

Do **not** formalize candidate-level precedence yet.

The counterexample pass now supports a clearer working boundary: dependency is better modeled as an explicit semantic relationship/reference between decision objects or decision results, potentially connecting two pipeline instances, rather than as an additional universal stage in the decision pipeline.

The three tested target classes — authority standing, candidate effect, and effective outcome — are semantically distinct. The control check further suggests that **dependency target** and **consumer role** are separate dimensions. This remains a working research model, not a formal Architecture Decision.

The next step is to test dependency chains and cycle semantics using this two-dimensional model, including separate treatment of eligibility-related cycles and effect/effective-outcome cycles.
