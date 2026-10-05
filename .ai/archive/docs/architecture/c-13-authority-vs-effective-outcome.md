# C-13 — Authority Standing vs Effective Outcome

Chapter:
03AP — Architecture & Research

Status:
BOUNDED RESEARCH TEST — CLOSED

## Purpose

This test examines one narrow boundary identified independently by the 03AP, Qwen 05AE, and Grok 06AA bottleneck audits:

> When a decision source retains a defined authority standing while its candidate effect loses precedence and its effective outcome changes, is a dependent consumer observably sensitive to whether it references the authority standing or the effective outcome?

The test is deliberately narrower than "what is the true Dependency target?" It does not choose an ontology for Resolution, Result, or Dependency.

## Scope

Included:

- one referenced decision source B;
- one conflict affecting B's candidate effect;
- one dependent consumer A;
- positive dependency predicates;
- comparison of B's authority standing with B's effective outcome.

Excluded:

- negative dependencies;
- dependency cycles;
- UNRESOLVED propagation;
- three-valued logic;
- mapping;
- representation policy;
- Resolution ontology;
- Result ontology;
- generic dependency engines;
- candidate-level precedence formalization.

## Starting model

Use the already-supported working pipeline:

~~~text
B eligibility
    ↓
conflict
    ↓
precedence
    ↓
candidate effect
    ↓
B effective outcome
~~~

And the already-demonstrated distinction:

~~~text
B authority standing
        ≠
B effective outcome
~~~

The test does not introduce either distinction as a new semantic primitive.

## Minimal Case 0 — No divergence

Set:

~~~text
B authority standing = AUTHORIZED
B candidate effect  = ALLOW
B effective outcome = ALLOW
~~~

Define two dependency variants for A:

~~~text
Variant S:
    A requires B.authority(X) == AUTHORIZED

Variant E:
    A requires B.effective_outcome == ALLOW
~~~

Result:

~~~text
Variant S → satisfied
Variant E → satisfied
~~~

This is the control condition. No discrimination is expected because the two referenced values agree.

## Minimal Case 1 — Single conflict creates divergence

Introduce one competing candidate C:

~~~text
B:
    authority standing = AUTHORIZED
    candidate effect  = ALLOW

C:
    candidate effect  = DENY

precedence:
    C > B
~~~

After the conflict:

~~~text
B authority standing = AUTHORIZED
B candidate effect  = ALLOW
B effective outcome = DENY
~~~

Now evaluate the same dependent consumer A under two reference interpretations.

### Variant S — Authority-standing reference

~~~text
A requires B.authority(X) == AUTHORIZED
~~~

The referenced condition remains satisfied:

~~~text
B authority = AUTHORIZED
→ dependency predicate = satisfied
~~~

### Variant E — Effective-outcome reference

~~~text
A requires B.effective_outcome == ALLOW
~~~

The referenced condition is not satisfied:

~~~text
B effective outcome = DENY
→ dependency predicate = not satisfied
~~~

## Primary observation

The same underlying B case produces different dependency-predicate results:

~~~text
                       Case 1
                         │
             ┌───────────┴───────────┐
             ▼                       ▼
      authority reference      outcome reference
             │                       │
             ▼                       ▼
        AUTHORIZED                  DENY
             │                       │
             ▼                       ▼
         satisfied              not satisfied
~~~

Therefore the two reference interpretations are **observationally distinguishable** under the bounded case.

This result does not require a Resolution ontology.

## Consumer-role control

The previous observation concerns only the dependency predicate. To avoid silently converting predicate difference into a claim about consumer semantics, hold the consumer role fixed in two separate applications.

### Consumer Role A — Eligibility-related requirement

Use:

~~~text
A is otherwise eligible.

A requires:
    referenced dependency predicate = satisfied
~~~

Under Variant S:

~~~text
A requirement = satisfied
~~~

Under Variant E:

~~~text
A requirement = not satisfied
~~~

Thus the two reference interpretations can produce different eligibility-related consequences for A.

The test establishes **possible semantic divergence**, not a universal rule that every failed dependency denies eligibility.

### Consumer Role B — Effect evaluation

Use:

~~~text
A eligibility = independently satisfied

A candidate effect is enabled only if:
    referenced dependency predicate = satisfied
~~~

Under Variant S:

~~~text
A eligibility = satisfied
A effect condition = satisfied
~~~

Under Variant E:

~~~text
A eligibility = satisfied
A effect condition = not satisfied
~~~

Thus the same target distinction can also produce different effect-evaluation consequences.

This reinforces the separate dimensions:

~~~text
referenced result/property
        ×
consumer role
~~~

The test does not establish that both roles must exist in a final ontology.

## Control against candidate-effect substitution

The case also preserves the already-tested distinction:

~~~text
B candidate effect = ALLOW
B effective outcome = DENY
~~~

Therefore a third variant:

~~~text
Variant C:
    A requires B.candidate_effect == ALLOW
~~~

also remains satisfied.

The three predicates in the bounded case are therefore:

~~~text
B.authority(X)       == AUTHORIZED → satisfied
B.candidate_effect   == ALLOW      → satisfied
B.effective_outcome  == ALLOW      → not satisfied
~~~

This is a compact discrimination surface for the three already-tested target distinctions.

## What the test establishes

### Observed / derived within the bounded model

1. A single precedence conflict can preserve B's authority standing while changing B's effective outcome.
2. Under that same case, a dependency predicate referencing B's authority standing can remain satisfied while a dependency predicate referencing B's effective outcome is not satisfied.
3. A dependency predicate referencing B's candidate effect can also remain satisfied.
4. The distinction is observable for both an eligibility-related requirement and an effect-evaluation use when those consumer consequences are held fixed.
5. Therefore the three tested target distinctions are not interchangeable in the bounded case.

### Inference

The dependency target cannot be identified solely from the identity of the referenced decision source B.

More specifically:

> "Dependency on B" is insufficient to determine the semantic behavior of A. The referenced result/property matters.

This strengthens the existing target × consumer-role research model.

### Not established

The test does not establish:

- that authority standing, candidate effect, and effective outcome are three members of a final Dependency ontology;
- that Dependency must always identify exactly one of these three targets;
- that a separate Result entity exists;
- that Resolution produces the effective outcome;
- that authority standing is intrinsically a Dependency target;
- that every consumer must expose the distinction;
- any universal TRUE/FALSE/UNRESOLVED semantics;
- any implementation architecture.

## Architectural discrimination result

The test was designed to distinguish two competing simplifications.

### Simplification A

~~~text
dependency on B
    ≈
dependency on B's effective outcome
~~~

The bounded case discriminates against this simplification.

### Simplification B

~~~text
dependency on B
    ≈
dependency on B's authority standing
~~~

The bounded case also discriminates against this simplification.

The result is therefore not "choose authority" or "choose effective outcome."

It is:

~~~text
dependency reference
        ↓
must preserve which semantic result/property is being referenced
~~~

This is an information/semantic discrimination result, not an ontology decision.

## Relation to precedence

The test also sharpens the current authority/precedence boundary:

~~~text
precedence can change
    B effective outcome

without necessarily changing
    B authority standing
    B candidate effect
~~~

Therefore any future architecture that allows dependencies to reference B's effective outcome must preserve the fact that this reference is downstream of precedence.

A dependency on authority standing cannot be silently rewritten as a dependency on effective outcome merely because both are associated with the same decision source.

## Relation to Resolution

The test deliberately avoids deciding what Resolution is.

It only requires the working distinction:

~~~text
B effective outcome
~~~

The test therefore supports the following bounded statement:

> Effective-outcome Dependency has a distinct semantic information requirement from authority-standing Dependency, even before the ontology of the effective outcome is settled.

This is stronger than "Resolution is the bottleneck" and weaker than "Resolution is the semantic producer of every Dependency target."

## Result

~~~text
C-13
  STATUS = CLOSED
  TEST TYPE = BOUNDED SEMANTIC DISCRIMINATION
  PRIMARY DISTINCTION = authority standing vs effective outcome
  CONTROL DISTINCTION = candidate effect vs effective outcome
  OBSERVABLE DIFFERENCE = YES
  DEPENDENCY_TARGET_ONTOLOGY = NOT ESTABLISHED
  RESOLUTION_ONTOLOGY = NOT ESTABLISHED
  NEXT_TEST_AUTOMATICALLY_SELECTED = NO
~~~

## Conclusion

C-13 provides a bounded positive discrimination:

> A dependency reference to a decision source is not semantically determined by the source identity alone. In a minimal conflict where authority standing remains stable while effective outcome changes, authority-standing and effective-outcome references can produce observably different dependency predicates and downstream consumer consequences.

The result strengthens the target × consumer-role research surface and the identified Dependency ↔ effective-outcome boundary.

It does not justify introducing a new semantic entity, selecting a Resolution ontology, formalizing a generic Dependency engine, or choosing a universal consumer-consequence rule.

Human remains the final architecture decision-maker.
