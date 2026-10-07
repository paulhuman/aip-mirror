# Post-C-13 Architectural Leverage Audit — 03AP

Chapter:
03AP — Architecture & Research

Status:
RESEARCH NOTE — NOT AN ARCHITECTURE DECISION

## Purpose

This audit re-evaluates the architectural bottlenecks after C-13.

The question is not which concept is "most important", but:

> After the positive C-13 discrimination, which unresolved boundary now constrains the largest number of downstream semantic decisions, while still admitting a bounded test that does not presuppose an ontology?

The audit deliberately avoids selecting a Dependency or Resolution ontology.

## Starting point after C-13

C-13 established a bounded positive discrimination:

~~~text
dependency on B
    ≠
dependency on B.authority
    ≠
dependency on B.candidate_effect
    ≠
dependency on B.effective_outcome
~~~

More precisely, under one conflict:

~~~text
B authority standing = AUTHORIZED
B candidate effect  = ALLOW
B effective outcome = DENY
~~~

A reference to authority can remain satisfied while a reference to effective outcome is not, and a reference to candidate effect can remain satisfied.

Therefore the semantic identity of the referenced property/result matters.

C-13 did not establish what ontology owns the effective outcome.

## Candidate remaining boundaries

### A — Dependency target ↔ result/referent semantics

C-13 strengthened this boundary.

Remaining questions include:

- what exactly is the referenced semantic property/result;
- whether the referenced thing is an intermediate state, a result, or another semantic object;
- whether "effective outcome" has an identity independent of its producer;
- whether a final dependency vocabulary must distinguish all currently tested target classes.

However, much of this work can remain deliberately abstract while the distinctions are preserved.

### B — Authority / Precedence ↔ effective outcome

C-13 also made this boundary sharper.

We now have a bounded counterexample showing:

~~~text
authority standing
        ≠
candidate effect
        ≠
effective outcome
~~~

while precedence can be involved in changing the latter without changing the former two.

The unresolved question is therefore no longer merely whether the values differ.

It is:

> What semantic relationship, if any, connects authority standing and precedence to the effective outcome?

This boundary affects:

- the meaning of an effective-outcome reference;
- interaction between precedence and dependencies;
- the possible meaning of temporary OVERRIDE;
- whether OVERRIDE acts on authority, precedence, applicability, candidate selection, or effective result;
- the point at which a referenced effective outcome becomes semantically available.

Thus this boundary reaches both major unresolved branches identified by the cross-audit.

### C — Consumer consequence semantics

C-13 showed that target distinction can produce different predicate results for both eligibility-related and effect-evaluation consumers.

What remains open:

- what TRUE means for each consumer;
- what FALSE means;
- whether an unresolved target can be represented without introducing three-valued semantics;
- whether consumer consequence is part of Dependency or external policy.

This is important, but it is downstream of identifying what the referenced semantic value actually is.

### D — Resolution ontology

Resolution remains unresolved, but C-13 does not show that its full ontology is needed immediately.

The test worked while treating effective outcome as an opaque semantic distinction.

Therefore:

~~~text
full Resolution ontology
        ≠
prerequisite for all further research
~~~

A full ontology test now risks turning a useful observed distinction into premature structure.

## Leverage assessment

The current evidence supports the following qualitative assessment:

| Boundary | C-13 impact | Downstream reach | Can remain ontology-neutral? |
|---|---|---:|---:|
| Dependency target ↔ referent | strengthened | high, but partly local | yes |
| Authority / Precedence ↔ effective outcome | sharpened substantially | high across Dependency + OVERRIDE | yes |
| Consumer consequence | clarified as separate dimension | medium | yes |
| Resolution ontology | remains open | potentially high | yes, but ontology tests are premature |

The strongest leverage is therefore not another generic Dependency-target enumeration.

It is the **Authority / Precedence ↔ effective outcome boundary**, because C-13 has already supplied the necessary divergence case and exposed the missing semantic transformation between them.

## Why this is the next substantial question

Before C-13, "effective outcome" could still be treated as an undifferentiated endpoint.

After C-13, that is no longer sufficient for architecture:

~~~text
candidate effect
       │
       │ precedence/conflict
       ▼
effective outcome
       │
       ├── can be referenced by Dependency
       │
       └── may interact with OVERRIDE
~~~

The missing question is what changes when an intervention such as OVERRIDE is introduced.

The useful discrimination is not:

> "What is OVERRIDE?"

That would invite ontology-first reasoning.

The useful question is:

> When an override is introduced into an otherwise fixed conflict, which already-distinguished semantic dimension changes: authority standing, precedence relation, candidate selection, candidate effect, or effective outcome?

This can be tested without deciding what Resolution is.

## Proposed next bounded research arc

### C-14 — OVERRIDE Semantic-Dimension Discrimination

Test a minimal conflict containing:

- one lower-precedence candidate B;
- one higher-precedence candidate C;
- stable authority standing;
- fixed candidate effects;
- one temporary OVERRIDE intervention.

Compare the semantic values before and after the intervention.

The test should explicitly observe, without assuming the answer:

1. authority standing;
2. candidate effects;
3. precedence relation;
4. governing candidate, if such a notion is already supported by the tested model;
5. effective outcome.

The test must not begin by defining OVERRIDE as changing any one of these.

### Required controls

The bounded test should include at least:

**Control 0 — ordinary conflict**

~~~text
B candidate effect = ALLOW
C candidate effect = DENY
C > B
~~~

Observe the existing C-13 divergence.

**Variant 1 — override with authority unchanged**

Do not assume this is valid. If the project's existing semantics permit an override that leaves authority standing unchanged, test whether the remaining dimensions change.

**Variant 2 — override affecting precedence**

If existing semantics describe an override as changing the precedence relation, observe whether candidate selection/effective outcome changes while authority remains stable.

**Variant 3 — override affecting effective result directly**

If existing semantics distinguish an override from precedence, test whether the effective outcome changes without requiring a changed authority standing or ordinary precedence relation.

The variants are **candidate interpretations for discrimination only**, not proposed semantics.

## Exclusions

C-14 must not introduce:

- Resolution ontology;
- Result ontology;
- typed UNRESOLVED;
- three-valued logic;
- generic precedence engine;
- generic dependency engine;
- graph implementation;
- new mapping ontology;
- universal consumer-consequence rules;
- a final definition of OVERRIDE before the observations.

If the repository contains no sufficiently explicit existing OVERRIDE semantics, the correct outcome is not to invent them. The test should then remain a research protocol and identify the missing source evidence.

## Expected architectural value

A positive discrimination would tell us which semantic dimension OVERRIDE actually interacts with, narrowing the boundary between:

~~~text
authority
precedence
candidate selection
effective outcome
~~~

A negative result would also be useful if it demonstrates that the tested intervention is observationally equivalent across the relevant dimensions.

Either result would constrain later formalization more directly than another enumeration of Dependency target classes.

## Relation to Resolution

C-14 should treat effective outcome as an already-observed semantic value without deciding whether it is:

- a Resolution state;
- a Result;
- a property of a decision source;
- another semantic construct.

Thus the test can reduce architectural uncertainty while preserving the current prohibition against premature ontology.

## Status

~~~
POST_C13_AUDIT = COMPLETE
CURRENT_HIGHEST_LEVERAGE_BOUNDARY =
    Authority / Precedence ↔ OVERRIDE ↔ effective outcome

NEXT_RESEARCH_ARC =
    C-14 OVERRIDE Semantic-Dimension Discrimination

ONTOLOGY_SELECTED = NO
IMPLEMENTATION_AUTHORIZED = NO
~~~

Human remains the final architecture decision-maker.
