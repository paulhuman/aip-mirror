# Independent Architecture Review Brief

Status: REVIEW REQUEST

Project: AIP Mirror
Repository: `paulhuman/aip-mirror`
Architecture/research specialization: `03 — Architecture & Research`
Current chapter: `03AF — Architecture & Research`

## 1. Why you are reading this

You are being invited to act as an **independent external AI architecture reviewer** for the AIP Mirror project.

This project is being developed with multiple AI-assisted workstreams. The repository is the durable technical record; individual AI conversations are finite working contexts. The goal of this review is deliberately broader than asking you to continue the current discussion.

We want a fresh, technically serious second opinion on the architecture we are building for AI-assisted software development and on the semantic model being developed inside specialization `03 — Architecture & Research`.

Do not assume that the current architecture is correct merely because it is already documented. We specifically want you to challenge it.

You are encouraged to identify:

- concepts that are unnecessarily complicated;
- concepts that have been conflated;
- missing semantic boundaries;
- circular definitions;
- hidden assumptions;
- dangerous implicit precedence;
- terminology that will cause implementation problems later;
- Architecture Decisions that should be rejected or reopened;
- areas where a simpler model would be stronger;
- areas where our model is too weak and needs an explicit concept;
- counterexamples that break the current working model;
- useful ideas from other agent/instruction/policy architectures;
- opportunities to make the architecture more project-agnostic and reusable.

A particularly valuable outcome would be a statement such as:

> "I think your current model is wrong at boundary X; here is a concrete counterexample and a simpler/better replacement model."

Do not avoid criticism in order to preserve continuity. The purpose of this review is precisely to make disagreement safe and useful.

At the same time, do not manufacture objections merely to be contrarian. Every challenge should be supported by a concrete example, logical argument, repository evidence, external reference, or clearly labelled hypothesis.

---

## 2. First principle: inspect the repository, not this document alone

Read the repository itself thoroughly before forming a final opinion.

The repository is the source of truth for the project's current state. This document is a review brief and orientation aid, not an authority that overrides repository rules or architecture documents.

You should inspect:

- the root project documentation;
- `.ai/` rules, skills, workflows, references, and memory where present;
- `docs/architecture/`;
- `docs/specifications/` and `docs/reverse-engineering/` where present;
- `docs/handoffs/` as described below;
- prototype and implementation areas relevant to understanding why the architecture exists;
- tests, fixtures, examples, and other evidence;
- Git history when useful for understanding why a decision changed;
- relevant external/reference material already stored in the repository.

Do not treat every file as equally authoritative. Part of your job is to identify the semantic role of each source.

The project intentionally distinguishes research, specification, implementation, AI instructions, durable memory, and conversation handoff state. Preserve those distinctions while evaluating them.

---

## 3. Handoffs: do NOT read every handoff

There are historical handoffs for several chapters. Reading all of them would add historical noise and repeated material without materially improving the current architectural review.

For specialization `03`, read these handoffs **in this order**:

1. `docs/handoffs/03A-Architecture-Research.md`
2. `docs/handoffs/03C-Architecture-Research.md`
3. `docs/handoffs/03D-Architecture-Research.md`
4. `docs/handoffs/03E-Architecture-Research.md`
5. `docs/handoffs/03AF-Architecture-Research.md`

### Why this order

- `03A` establishes the original architecture-refactor intent and the initial ontology/lifecycle/applicability/observability work.
- `03B` is intentionally skipped because `03C` carries forward its established AD-01 through AD-21 checkpoint. `03B` is a superseded intermediary handoff, and reading it would mostly repeat information already inherited by `03C`.
- `03C` contains the major OVERRIDE/authorization research checkpoint and its counterexamples.
- `03D` contains the detailed authorization boundary and candidate-level precedence work.
- `03E` is the immediate predecessor and explains the prerequisite/dependency boundary that led into the current research.
- `03AF` is the current-format receiving chapter and contains the latest state, including the completed chains/cycles counterexample pass.

Do **not** interpret the historical identifiers `03A`–`03E` as current-format aliases such as `03AA`–`03AE`. They are legacy historical identifiers. `03AF` is the first physically created current-format chapter for specialization 03; its relation to `03A`–`03E` is ordinal correspondence only.

You do not need to read `04A-Project-Workshop.md` for the architecture review unless a concrete question about Workshop ownership or tooling requires it.

You do not need to read `02A`/`02B` unless a concrete architecture question requires native-plugin context. Those chapters are implementation-stream state, not the primary source for specialization 03's architecture semantics.

---

## 4. Current architectural mission

AIP Mirror is not merely a mirror tool implementation. The immediate architectural work is building a reusable AI-instruction and AI-assisted-development architecture that can eventually support this project and other unrelated software projects.

The project has four complementary conversation specializations:

```text
01 — JSX Prototype
02 — Native AIP Plugin
03 — Architecture & Research
04 — Project Workshop
```

They are complementary rather than competing implementation streams.

Specialization `03` owns cross-cutting architecture, research, semantic boundaries, and decisions that affect multiple parts of the project. It should not become an implementation stream merely because an architectural question has a possible implementation.

The architecture is intended to be sufficiently project-agnostic that its reusable core could be carried into another software project without dragging AIP Mirror-specific domain assumptions with it.

Two important conceptual validation cases have been discussed for this purpose:

- `dsp56300/gearmulator` with its related work;
- a future Ableton Live Extensions project.

These are validation ideas, not repositories that should be modified as part of this review.

---

## 5. Why this architecture exists

The architecture grew from a practical problem: AI-assisted software development becomes unreliable when important instructions, procedures, assumptions, and historical decisions are mixed together in large conversations or duplicated across loosely related files.

The intended system separates concerns such as:

```text
RULE
SKILL
WORKFLOW
REFERENCE
MEMORY
HANDOFF
TRACE / observability extension
```

with separate concerns for:

```text
Applicability
Activation
Authority
Specificity
Precedence
Ownership
Observability
Lifecycle
```

The project does not want a large universal "AI framework" simply because one could be built. The recurring design principle is **avoid premature abstraction**.

Introduce a semantic concept when a real boundary, repeated behavior, evidence, or architectural requirement justifies it.

---

## 6. Instruction ontology currently established

The architecture currently distinguishes:

- **RULE** — policy, constraint, invariant, or authority-related instruction.
- **SKILL** — reusable capability or methodology.
- **WORKFLOW** — ordered procedure/lifecycle process.
- **REFERENCE** — supporting evidence/source material, not instruction or authority.
- **MEMORY** — durable accumulated knowledge/context, not authority merely because it exists.
- **HANDOFF** — a cross-cutting lifecycle/state mechanism for moving work between finite AI conversations.
- **TRACE** — an observability extension; it records/explains/correlates activity but is not authority.

The architecture deliberately keeps semantic type separate from applicability, activation, precedence, ownership, and observability.

The intended future `.ai/` organization is approximately:

```text
AGENTS.md
.ai/
├── README.md
├── config.json
├── rules/
├── skills/
├── workflows/
├── memory/
└── extensions/
    └── trace/
```

The repository currently remains in the legacy/pre-refactor layout. Structural refactoring has deliberately been postponed until the semantics are sufficiently stable.

`docs/PROJECT-INSTRUCTIONS.md` is a legacy aggregate that is intended to be semantically redistributed and removed only after redistribution and verification. Do not assume that its eventual deletion means its useful semantics should disappear.

---

## 7. Applicability, activation, authority, specificity, and precedence

One of the project's strongest architectural goals is to prevent several different questions from collapsing into one vague concept such as "priority".

The current model treats these as distinct:

### Applicability

Does this instruction/candidate apply in the current context?

### Activation

Is an applicable capability/procedure/instruction currently activated for use?

### Authority

Is the relevant actor/source actually authorized to establish or perform the semantic relation in question?

### Specificity

How specifically does a rule describe the relevant context/target? Specificity does not automatically create authority or override another rule.

### Precedence

When already-eligible candidates conflict, does an explicit policy rule determine which candidate governs?

The architecture explicitly rejects hidden precedence derived from:

- filesystem/path depth;
- discovery order;
- filename order;
- timestamps;
- IDs merely because they are IDs;
- incidental traversal/processing order.

Specificity and authority may participate in conflict resolution only when an explicit precedence policy assigns them that role. Neither becomes precedence automatically.

---

## 8. OVERRIDE and authorization model

The current baseline is **Explicit Authorization**.

Important distinctions established through counterexample research include:

```text
OVERRIDE declaration
    ≠ authorization

authorization
    ≠ effective application

TRACE
    ≠ authority
```

Authorization is treated as a bounded grant. Delegation must itself be explicitly authorized and must not expand the authority granted by its source.

Target-specific authorization is the current Core semantic primitive. Target-class authorization is deliberately outside Core pending a separate architecture decision.

Core consumes an externally established authority boundary. Core does not define the mechanism that constructs or verifies an authority chain.

External authority establishment and Core operation evaluation are separate result layers:

```text
External authority establishment:
    AUTHORIZED / DENIED / UNRESOLVED

Core current-operation result:
    EFFECTIVE / DENIED / UNRESOLVED
```

These states must not be conflated.

An issuer's identity does not automatically establish issuer authority. The existence of an authorization record is not authority by itself.

Specificity cannot create authority. Precedence cannot create authority. Conflict resolution does not mutate authorization standing.

Temporary OVERRIDE is supported conceptually, but temporary status must be explicitly declared and must remain historically auditable. No `override.scope` mechanism exists in the current Core model; applicability/activation/workflow semantics are preferred until a concrete scenario proves that a separate scope mechanism is necessary.

---

## 9. Candidate-level precedence: current working direction

The current working pipeline is:

```text
eligibility
  → conflict detection
  → explicit precedence
  → governing candidate
  → candidate effect
  → effective outcome
```

More detailed working form:

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
  ├─ No conflict
  │    → no governing-candidate selection required
  │    → effective result from applicable candidate semantics
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
       └─ NO → UNRESOLVED
```

The important semantic distinction is:

```text
candidate effect
    ≠
effective outcome
```

A candidate can carry a semantic contribution/effect before conflict resolution. If eligible candidates conflict, explicit precedence selects a governing candidate. The effective outcome is then derived from that governing candidate's effect.

Multiple candidates that support the same result do not necessarily require a single governing candidate; the architecture has discussed the possibility of `MULTIPLE SUPPORT` where no winner is semantically needed.

Candidate-level precedence is **still a working direction, not a formally frozen numbered Architecture Decision**.

Your review must therefore treat it as challengeable.

---

## 10. The current prerequisite/dependency problem

This is the most recent semantic boundary we have been studying.

We discovered that the phrase:

```text
B must authorize X
```

is not sufficiently precise.

A may be referring to different semantic things about B:

```text
B.authority(X)
B.candidate_effect
B.effective_outcome
other defined decision result/property
```

And the reference can play different roles for A.

The current working two-dimensional model is:

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

This is **not yet a formal Architecture Decision**. Not every combination is assumed to be valid.

The key correction was:

> A decision-source relationship must not automatically be classified as an eligibility prerequisite merely because it references another decision source.

Instead:

```text
relationship
    → references a semantic result/property of B
    → consumer role determines where/how A uses it
```

A dependency may connect two decision/pipeline instances without becoming a universal pipeline stage.

---

## 11. Relationship structure → semantic resolution → execution strategy

The latest chains/cycles work produced a useful separation:

```text
1. Relationship structure
2. Semantic resolution
3. Execution strategy
```

### Relationship structure

The explicit semantic relationships exist, for example:

```text
A → B → C
```

or:

```text
A → B → A
```

### Semantic resolution

The architecture determines what those relationships mean and what result follows.

For a chain, it is not sufficient to think:

```text
C result → B result → A result
```

A more accurate representation is:

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

### Execution strategy

An implementation might use dependency traversal, memoization, work queues, recursion, topological evaluation, or another mechanism. Those implementation strategies must not silently create semantic meaning.

In particular, execution order is not semantic order by default.

---

## 12. Chains and cycles: current findings

The latest counterexample pass covered four cases, each considered with resolved-positive, resolved-negative, and `UNRESOLVED` states.

### Case 1 — Eligibility chain

```text
A eligibility requires B
B eligibility requires C
C is independent
```

An acyclic chain can be resolved from an independent source when the relevant consumer semantics are defined.

A false dependency predicate does not automatically mean that the consumer is `DENIED`; that consequence belongs to the consumer semantics.

`UNRESOLVED` at the target does not automatically define the consumer result. Propagation semantics remain open.

### Case 2 — Eligibility cycle

```text
A eligibility requires B
B eligibility requires A
```

A cycle is not automatically an error.

It may admit self-consistent states. The existence of a fixed point does not itself tell the system which fixed point to select.

Incidental A-first/B-first evaluation cannot provide a semantic justification for a result.

### Case 3 — Effect chain

```text
A.effect depends on B.effective_outcome
B.effect depends on C.effective_outcome
```

Eligibility may be independent of the chain. Dependency may affect effect/effective-outcome evaluation without being an eligibility requirement.

### Case 4 — Effect cycle

```text
A.effect depends on B.effective_outcome
B.effect depends on A.effective_outcome
```

Both candidates may be eligible while their effects/effective outcomes remain mutually recursive.

The current position is deliberately conservative:

```text
cycle
  ≠ automatically invalid
  ≠ automatically UNRESOLVED
```

If cycles are supported, explicit cycle-resolution/termination semantics are required. If cycles are not supported, that prohibition must also be explicit.

Candidate-level precedence is not a universal cycle breaker. It resolves eligible candidate conflicts; it does not automatically solve recursive semantic dependencies.

---

## 13. Precedence interaction with dependencies

A particularly important distinction is that precedence can change some dependency targets but not others.

For example:

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

After conflict resolution, B may retain:

```text
B.candidate_effect = ALLOW
```

while its effective outcome becomes:

```text
B.effective_outcome = DENIED
```

Therefore:

```text
A depends on B.candidate_effect == ALLOW
```

can remain satisfied even though B loses precedence.

But:

```text
A depends on B.effective_outcome == ALLOW
```

can become unsatisfied because precedence changed B's effective result.

Similarly, B's authority standing may remain `AUTHORIZED` even though B loses a policy conflict.

Therefore the current model insists on keeping:

```text
dependency target
    ≠ consumer role
    ≠ precedence
```

---

## 14. What is deliberately NOT decided yet

Do not assume that the following questions have already been solved:

- exact semantic definition of a dependency;
- exact allowed dependency target types;
- exact allowed consumer roles;
- whether every cross-decision prerequisite is a dependency;
- exact `TRUE / FALSE / UNRESOLVED` predicate semantics;
- exact consumer consequences of a false or unresolved dependency predicate;
- whether dependency graphs are a Core semantic abstraction or merely an emergent structure;
- whether Core permits dependency cycles;
- if cycles are permitted, how they terminate or resolve;
- whether some cycle classes need different rules;
- whether intermediate semantic properties may be dependency targets;
- whether candidate-level precedence should become a formal AD;
- final interaction between precedence and dependency semantics;
- final TRACE semantics;
- final temporary OVERRIDE lifetime/revocation semantics;
- final project-wide instruction-system refactor.

Do not turn any of these open questions into "facts" simply because a plausible implementation can be imagined.

---

## 15. Evidence discipline required during your review

For every substantive conclusion, classify it as one of:

- **Observed fact** — directly supported by repository code, documentation, experiment, screenshot/video, reproducible behavior, or another concrete source.
- **Inference** — reasonable conclusion from evidence but not directly documented.
- **Assumption** — currently believed but insufficiently verified.
- **Specification** — deliberate requirement/contract for what the system should do.
- **Implementation detail** — a technical choice for realizing the specification.
- **Open question** — unresolved and requiring further investigation.

Do not silently promote an inference into a fact.

When disagreeing with the current architecture, state whether you are challenging an observation, an inference, a specification, or an implementation detail. This makes the disagreement actionable.

---

## 16. Questions we explicitly want you to answer

Do not limit the review to these questions, but answer them directly.

### A. Overall architecture

1. Is the current RULE/SKILL/WORKFLOW/REFERENCE/MEMORY separation coherent?
2. Are any of these categories actually the same semantic thing under different names?
3. Are any important categories missing?
4. Is HANDOFF correctly treated as a cross-cutting lifecycle mechanism rather than a normal content type?
5. Is TRACE correctly separated from authority?
6. Is the distinction between Applicability, Activation, Authority, Specificity, Precedence, Ownership, and Observability clean enough?
7. Do you see any circular definitions or concepts that depend on each other in an unhealthy way?

### B. OVERRIDE and authorization

1. Does Explicit Authorization provide a sound baseline?
2. Is the separation of authorization standing from current operation effectiveness useful and coherent?
3. Is target-specific authorization a defensible Core primitive?
4. Is the bounded-delegation model coherent?
5. Is the rule that specificity cannot create authority sound?
6. Is the rule that precedence cannot create authority sound?
7. Is the distinction between authorization conflict and policy conflict clear enough?
8. Is there a simpler authorization model that preserves the same safety properties?
9. Are we overengineering OVERRIDE before a concrete implementation requires it?
10. Which OVERRIDE assumptions would you reject or reopen?

### C. Candidate-level precedence

1. Does selecting a governing candidate make more semantic sense than selecting a bare outcome value?
2. Does the current pipeline have a missing stage or an incorrectly ordered boundary?
3. Can you produce a concrete counterexample where candidate-level precedence fails but outcome-level precedence succeeds?
4. Can you produce a concrete counterexample where outcome-level precedence creates a worse abstraction boundary?
5. Should candidate-level precedence be promoted to a formal AD now, or does it need more testing?
6. Are `MULTIPLE SUPPORT`, governing candidate, candidate effect, and effective outcome sufficiently distinct?

### D. Prerequisites and dependencies

1. Is the current two-dimensional model useful?
2. Is `dependency target × consumer role` the right decomposition, or are we missing a third dimension?
3. Should dependency be a first-class semantic relationship at all?
4. Could all currently observed cases be represented more simply using existing concepts?
5. Are we using the word "dependency" too broadly?
6. Is there a better term for some of the relationships currently called dependencies?
7. Are decision-source references fundamentally different from context predicates?
8. Is a dependency naturally a relation between decision results rather than a pipeline stage?

### E. Chains and cycles

1. Is the separation `relationship structure → semantic resolution → execution strategy` sound?
2. Is our treatment of cycles too permissive, too restrictive, or appropriately undecided?
3. Should Core explicitly prohibit cycles, return `UNRESOLVED`, or define a more formal recursive semantics?
4. Should eligibility cycles and effect cycles have different rules?
5. Is there a simpler way to model recursive relationships without creating a generic dependency engine?
6. Can precedence legitimately participate in cycle resolution, or should it remain completely orthogonal?

### F. Reusability / project-agnosticity

1. Could this architecture be reused for an unrelated project such as a synthesizer library, developer tool, or plugin framework?
2. Which current concepts are secretly AIP Mirror-specific?
3. Which rules are truly reusable Core rules?
4. Where would you draw `CORE / PROJECT-SPECIFIC / ADAPTABLE` boundaries?
5. Would you redesign the architecture differently if you knew it had to be reused in several unrelated repositories?

### G. Complexity budget

This is especially important.

Tell us where we are overengineering.

For each proposed concept, ask:

```text
What concrete problem does this solve?
What counterexample requires it?
Can an existing concept express the same semantics safely?
What new ambiguity does this concept introduce?
What implementation burden does it create?
```

We would rather have a smaller architecture with strong semantic boundaries than a grand framework that attempts to model every possible AI behavior.

---

## 17. Required review method

Use an evidence-first process.

### Phase 1 — Repository understanding

Read the relevant repository files and establish your own model.

Do not begin by agreeing or disagreeing with this brief.

### Phase 2 — Independent reconstruction

Write down, at least internally, your own reconstruction of:

```text
instruction ontology
applicability
activation
authority
specificity
precedence
OVERRIDE
candidate
eligibility
candidate effect
governing candidate
effective outcome
prerequisite
dependency
relationship structure
semantic resolution
execution strategy
```

Then compare your reconstruction with the repository.

### Phase 3 — Counterexamples

Try to break the current model.

Prefer the smallest counterexample that demonstrates a real semantic failure.

For every important counterexample, state:

```text
Initial model
Counterexample
Why it breaks / does not break
Proposed correction
Confidence
```

### Phase 4 — Alternative models

Where you think our model is wrong or unnecessarily complex, propose at least one concrete alternative.

Do not merely say "this could be simpler".

Show the simpler model.

### Phase 5 — Architecture challenge

Identify:

- decisions to keep;
- decisions to refine;
- decisions to reopen;
- decisions to reject;
- missing decisions;
- terminology to rename;
- concepts to merge;
- concepts that should remain separate.

### Phase 6 — Fresh ideas

Bring in useful ideas from your broader training and, where appropriate, external technical references.

However, do not blindly import another system's terminology or architecture. Translate external ideas into this project's semantic language and explain why they fit.

---

## 18. Important collaboration boundary

You are an **independent reviewer**, not the owner of the AIP Mirror architecture.

Initially:

- do not modify repository architecture files;
- do not rewrite handoffs;
- do not perform structural refactoring;
- do not implement a dependency engine;
- do not create code merely to prove a theoretical point;
- do not change the repository simply because you found something you dislike.

The first deliverable should be your independent analysis and recommendations.

Repository changes should happen only after the human project owner reviews the findings and explicitly chooses what to adopt.

If your environment permits repository writes, treat write access as a capability, not as authorization to redesign the project.

---

## 19. How to report disagreement

Use strong but precise language.

Good:

> "I recommend reopening AD-X because counterexample Y shows that the definition of Z is circular."

Good:

> "I think the current dependency model has an unnecessary second dimension. The consumer role can be derived from the relationship type if the following invariant is adopted..."

Good:

> "I could not find evidence that this concept is required. It currently appears to be an implementation-driven abstraction."

Avoid:

> "This architecture is obviously wrong."

unless you immediately explain exactly what semantic failure makes it wrong.

Distinguish:

```text
I disagree with the specification.
I disagree with the inference.
I found an implementation problem.
I found a missing semantic case.
I found terminology that hides the real distinction.
```

These are different kinds of findings.

---

## 20. Do not optimize for agreement with another AI

This review exists partly because multiple strong AI models can arrive at different conclusions.

Do not attempt to infer what another AI "wants" you to say.

Do not assume that the current architecture is correct because another model produced it.

Do not assume that your own first interpretation is correct either.

The desired process is:

```text
Repository evidence
       ↓
Independent reconstruction
       ↓
Counterexamples
       ↓
Alternative models
       ↓
Reasoned recommendation
       ↓
Human review
       ↓
Possible architecture decision
```

The human project owner remains the decision maker.

---

## 21. Special attention: handoff architecture is intentionally deferred

The repository contains evidence of a recurring handoff ownership failure in earlier migrations: a closing chapter created or initialized the receiving chapter's handoff even though canonical lifecycle rules assign creation/initialization to the receiving chapter.

This has happened more than once and is recorded as a future architecture/process problem.

Do not silently refactor the handoff system while reviewing the semantic architecture.

You may analyze the problem and recommend a better design if you see one, especially if you believe the current rules are insufficiently enforceable. But keep the recommendation separate from the current prerequisite/dependency semantic task.

---

## 22. What success looks like

A successful review does **not** necessarily end with "the architecture is good."

A successful review may conclude:

```text
The current model survives independent challenge.
```

or:

```text
The current model is mostly sound, but boundary X should change.
```

or even:

```text
Several current abstractions should be discarded and replaced by a smaller model.
```

All three outcomes are useful.

The most valuable result is a set of concrete, defensible observations that lets the project owner make a better architecture decision than either AI would have made independently.

---

## 23. Final requested deliverable

After reading the repository and performing the independent review, provide a structured report containing at least:

1. **Your reconstructed architecture** — explain it in your own words.
2. **What appears strong** — with evidence/reasoning.
3. **What appears weak or risky** — with concrete counterexamples.
4. **What you would reject/reopen** — identify exact concepts/decisions.
5. **What you would simplify** — propose concrete replacements.
6. **What you think is missing** — semantic boundaries or decisions.
7. **Prerequisite/dependency verdict** — specifically challenge the current model.
8. **Chains/cycles verdict** — specifically challenge the current model.
9. **Candidate-level precedence verdict** — challenge the working direction.
10. **OVERRIDE/authorization verdict** — challenge the current baseline.
11. **Project-agnosticity verdict** — test whether the model really generalizes.
12. **Fresh ideas** — concepts or approaches worth investigating.
13. **Recommended next research experiments** — smallest useful counterexamples first.
14. **Confidence and evidence classification** for major findings.

If you think the current architecture is substantially wrong, do not stop at criticism. Provide a replacement model detailed enough that the human owner can compare it directly with the current one.

If you think the architecture is substantially right, still identify its weakest assumptions and the next counterexamples that could falsify it.

---

## 24. One final request: surprise us

We deliberately want a second brain here.

If you discover a cleaner abstraction, a missing semantic distinction, a contradiction between two parts of the repository, a better way to reason about instruction authority, a more elegant treatment of recursive dependencies, or an architectural idea that neither the current documentation nor this brief anticipates, **bring it forward**.

You are not being asked to protect the existing design.

You are being asked to help us find the design that deserves to survive.

That includes telling us, clearly and with evidence, when something we have spent a lot of time designing should be thrown away and rebuilt.
