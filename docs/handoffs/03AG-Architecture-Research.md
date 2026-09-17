# Conversation Handoff

Conversation:
AIP Mirror — 03AG — Architecture & Research

Specialization:
03

Chapter:
AG

Previous chapter:
AIP Mirror — 03AF — Architecture & Research

Status:
DRAFT

## Current objective

Continue the project-wide AI-instruction architecture research from 03AF. The immediate semantic focus is **UNRESOLVED propagation semantics**, specifically whether distinct appearances/causes of `UNRESOLVED` require typed semantic subtypes or can be represented by one semantic state plus orthogonal metadata.

The next experiment compares:

```text
MODEL A — Typed semantic UNRESOLVED

TRUE / FALSE / UNRESOLVED{types}
```

against:

```text
MODEL B — Untyped semantic state + orthogonal metadata

TRUE / FALSE / UNRESOLVED
+
reason / source / propagation / conflict / cycle
```

The comparison must be driven by minimal counterexamples, not by preference for either model. No formal Architecture Decision should be created until the evidence demonstrates a stable semantic boundary.

## Completed

03AF completed the prerequisite/dependency chain and cycle counterexample pass and extended the research with Qwen's ten `UNRESOLVED` counterexamples (U-1 through U-10).

The durable working separation is:

```text
semantic state
    ≠
reason / cause
    ≠
origin / propagation mechanism
    ≠
source / provenance
    ≠
consumer consequence
```

The prerequisite/dependency work also established the working relationship:

```text
DEPENDENCY TARGET
    ×
CONSUMER ROLE
```

with precedence remaining a separate explicit mechanism.

The following remain working directions rather than formal ADs:

- candidate-level precedence;
- dependency target/consumer-role combinations;
- cycle semantics;
- `UNRESOLVED` representation and propagation semantics.

## Current implementation state

The repository remains in the legacy/pre-refactor AI-instruction layout. No structural architecture refactor has been executed.

No generic dependency engine, precedence engine, authorization engine, candidate evaluator, or TRACE subsystem has been implemented as part of this research.

The current work is research/specification analysis only; no application implementation is required for the immediate counterexample pass.

## Decisions / working invariants carried forward

- Candidate-level precedence is a working direction, not a formal Architecture Decision.
- Precedence acts only on already eligible candidates and cannot bypass or create eligibility or authority.
- Hidden precedence from path depth, discovery order, filename order, timestamps, IDs, or incidental processing order is prohibited.
- Candidate effect and effective outcome are distinct semantic concepts.
- Dependency target, consumer role, and precedence are separate dimensions.
- `Relationship structure → semantic resolution → execution strategy` remains the working decomposition.
- `Dependency` is not a generic Core semantic category or execution engine.
- `UNRESOLVED` is a semantic state, but its internal representation and propagation semantics remain undecided.
- `UNRESOLVED` must not be treated as automatically equivalent to `DENIED`.
- Consumer consequence is a separate semantic rule and is not determined merely by the presence of `UNRESOLVED`.
- A cycle is not automatically invalid and is not automatically `UNRESOLVED`; if cycles are supported, explicit resolution/termination semantics are required.
- Incidental execution order must not resolve a semantic cycle.
- External authority states such as `AUTHORIZED / DENIED / UNRESOLVED` remain conceptually distinct from Core operation outcomes such as `EFFECTIVE / DENIED / UNRESOLVED`.

## UNRESOLVED propagation baseline

Qwen's candidate taxonomy is retained only as a research hypothesis:

```text
UNRESOLVED
├── INSUFFICIENT_EVIDENCE
├── UNRESOLVED_CONFLICT
├── STRUCTURAL_CYCLE
└── PROPAGATED
```

The taxonomy is **not adopted**.

The strongest unresolved issue is dimensional conflation. In particular, `PROPAGATED` appears to describe origin/mechanism rather than a peer semantic cause. The current research therefore keeps these dimensions separate:

```text
SEMANTIC STATE
    TRUE / FALSE / UNRESOLVED / ...

REASON / CAUSE
    missing evidence / conflict / cycle / ...

ORIGIN / PROPAGATION / PROVENANCE
    direct / propagated / source reference / ...

CONSUMER CONSEQUENCE
    what the consuming rule does with the result
```

A plain three-valued semantic state may be sufficient even if a plain three-valued **logic** is insufficient to encode causal or provenance information. Do not claim that three-valued logic is insufficient without identifying the specific semantic requirement that cannot be expressed.

## U-1…U-10 research cases

The independent-review pass produced these ten cases:

1. U-1 — predicate / missing data
2. U-2 — authority standing / missing or ambiguous authority evidence
3. U-3 — Core operation / operation-boundary mismatch
4. U-4 — candidate eligibility / propagated predicate unresolved
5. U-5 — candidate effect / propagated dependency target unresolved
6. U-6 — effective outcome / unresolved conflict
7. U-7 — dependency predicate / propagated effective-outcome unresolved
8. U-8 — dependency consumer consequence / authority unresolved plus consumer role
9. U-9 — cycle detection / structural circularity
10. U-10 — multiple valid OVERRIDEs / unresolved conflict

These cases show materially different appearances/causes of `UNRESOLVED`, but they do not by themselves prove that semantic subtyping is required.

## Candidate-level precedence status

The working pipeline remains:

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
  ↓
Applicable explicit precedence rules
  ↓
Unique deterministic result?
  ├─ YES → governing candidate → candidate effect → effective outcome
  └─ NO  → UNRESOLVED
```

This remains a working model. The exact interaction between dependencies, precedence, and unresolved propagation is still open.

## Independent cross-model research pattern

The Qwen collaboration demonstrated a reusable project-agnostic adversarial research pattern that is **not yet a formal Architecture Decision**:

```text
ARCHITECT / PRIMARY MODEL
        ↓
RESEARCH HYPOTHESIS
        ↓
INDEPENDENT REVIEWER
        ↓
COUNTEREXAMPLES
        ↓
PRIMARY MODEL RESPONSE
        ↓
REVIEWER REFINEMENT
        ↓
EVIDENCE SYNTHESIS
        ↓
HUMAN DECISION
        ↓
ARCHITECTURE DECISION
```

Reviewer role is adversarial pressure/counterexample generation, not competing architecture ownership. A valid review outcome is that the current model survives the test. Human remains the referee and final decision-maker.

Future extraction should distinguish:

```text
specialization identity
    ≠
model identity
```

`05 — Independent Review` should remain a function; Qwen is only the current implementation/instance.

Future improvements identified for the Qwen onboarding are to distinguish research hypothesis vs working decision vs formal Architecture Decision, explicitly permit a "model survives" review outcome, preserve reviewer independence, and avoid binding the specialization to Qwen. Do not rewrite the Qwen onboarding solely for these improvements at this stage.

## Open questions

### UNRESOLVED

- Is one semantic state `UNRESOLVED` sufficient when reason/origin/provenance are orthogonal?
- Does any U-1…U-10 case require a typed semantic unresolved state rather than metadata?
- Which information is actually consumed downstream: state, reason, origin, provenance, or a combination?
- Is `PROPAGATED` a state, reason, origin, or mechanism?
- Does propagation depth have semantic meaning or only diagnostic value?
- How should mixed unresolved causes be represented?
- What happens when unresolved information participates in a precedence rule?
- What happens when cycle and propagation overlap?
- Can a consumer convert `UNRESOLVED` to `DENIED`, `ALLOW`, or another result, and only under what explicit rule?
- Does nested `UNRESOLVED` introduce a semantic distinction that metadata cannot preserve?

### Dependency / cycles

- Which combinations of dependency target and consumer role should Core permit?
- Whether dependency relationships can themselves conflict.
- Whether cycles should be supported at all in Core semantics.
- If supported, what explicit resolution/termination semantics should apply.

### Candidate-level precedence

- Formalize only after unresolved propagation and dependency semantics stabilize.
- Determine whether multiple candidates can support the same effective result without requiring a governing winner.
- Determine exact conflict-resolution boundaries.

### OVERRIDE / authority

- Temporary OVERRIDE lifecycle: existence, validity, standing, activation, expiration, and history.
- Clarify authority-level vocabulary only through a dedicated evidence-driven pass.

## Current files

### Rules / skills read during bootstrap

- `.ai/rules/conversation-lifecycle.md`
- `.ai/rules/workflow.md`
- `.ai/rules/project-architecture.md`
- `.ai/rules/repository.md`
- `.ai/skills/conversation-handoff/BOOTSTRAP.md`
- `.ai/skills/conversation-handoff/SKILL.md`
- `.ai/skills/deep-understanding/SKILL.md`
- `.ai/skills/commit-message/SKILL.md`

### Handoffs read during bootstrap

- `docs/handoffs/03AF-Architecture-Research.md`
- `docs/handoffs/03E-Architecture-Research.md`
- `docs/handoffs/05AA-Independent-Review-Qwen.md`

### Architecture/research documentation reviewed

- `docs/architecture/prerequisite-dependency-semantics.md`

## Relevant references

- `docs/handoffs/03AF-Architecture-Research.md` — authoritative starting state for this migration.
- `docs/architecture/prerequisite-dependency-semantics.md` — prerequisite/dependency counterexample research.
- `docs/handoffs/05AA-Independent-Review-Qwen.md` — independent-review/Qwen research context.
- `.ai/rules/conversation-lifecycle.md` — lifecycle ownership and verification.
- `.ai/rules/workflow.md` — research-first and repository verification workflow.
- `.ai/skills/deep-understanding/SKILL.md` — evidence-driven research method.

## Important constraints

- Do not begin a broad new research program; continue directly from 03AF.
- Do not repeat the completed prerequisite/dependency chain/cycle pass without new evidence.
- Do not treat Qwen's typed taxonomy as adopted architecture.
- Do not treat `UNRESOLVED = DENIED` or fail-closed as a universal rule.
- Do not introduce a generic dependency engine.
- Do not turn candidate-level precedence into a formal AD before the semantic boundary is sufficiently tested.
- Keep semantic state, reason/cause, origin/propagation, provenance, and consumer consequence distinct.
- Do not infer that different causes require different semantic states merely because they are diagnostically different.
- The burden of proof for Model A is not "types exist"; the relevant question is whether a downstream semantic rule cannot be expressed correctly with Model B.
- Keep the recurring handoff ownership issue separate from the current semantic research.
- Do not modify the Qwen onboarding merely for already-identified future improvements.
- Preserve repository write-safety for any future existing-file modification: read current content, make minimal change, write complete content, read back, verify content and diff/scope, then commit and verify the resulting ref.

## Evidence / confidence

### Confirmed / observed

- 03AF was the READY_FOR_HANDOFF source for this receiving chapter.
- The prerequisite/dependency chain and cycle counterexample pass was completed before this migration.
- Ten U-1…U-10 `UNRESOLVED` counterexamples were produced by the independent-review pass.
- Qwen's typed unresolved taxonomy is a research hypothesis, not a formal Architecture Decision.
- `UNRESOLVED` must not be equated automatically with `DENIED`.
- Candidate-level precedence remains a working direction, not a formal AD.
- The cross-model adversarial research pattern has been exercised in practice and remains a candidate for later project-agnostic extraction.

### Inferred

- The state/reason/origin/provenance/consumer-consequence separation may provide a cleaner semantic model than the proposed typed taxonomy.
- Model B may preserve the semantic expressiveness of the U-1…U-10 cases while reducing semantic coupling, but this must be demonstrated rather than assumed.
- `PROPAGATED` is likely an origin/mechanism dimension rather than a semantic subtype.

### Assumed / unverified

- Exact consumer consequences for unresolved dependency predicates.
- Whether any U-1…U-10 case requires a typed semantic state.
- Whether metadata can preserve every distinction that a typed state would expose to consumers.
- Whether cycles require a dedicated semantic result beyond the existing unresolved state.
- Whether propagation depth has semantic meaning.

### Open

- Model A vs Model B for U-1…U-10.
- Nested and mixed unresolved cases.
- Dependency/cycle semantics.
- Candidate-level precedence formalization.
- Temporary OVERRIDE lifecycle.
- Future project-agnostic extraction of the adversarial-review pattern.

## Last completed task

03AF completed its research checkpoint and prepared the migration state: dependency chains/cycles were tested; ten unresolved counterexamples were reviewed; the proposed taxonomy was kept explicitly unadopted; and the next A/B experiment was defined around the distinction between semantic state and orthogonal metadata.

## Immediate next task

Run the **smallest discriminating counterexample** for Model A vs Model B.

Start with a case where the downstream consumer must make a semantic decision based on information that differs between two unresolved situations but where the semantic state is identical. The first goal is not to model all U-1…U-10, but to find the minimum pair that could force a semantic subtype.

Then:

1. State the consumer rule explicitly.
2. Encode the case under Model A.
3. Encode the same case under Model B.
4. Ask whether the consumer can distinguish the cases using only the semantic state plus permitted orthogonal metadata.
5. If Model B fails, identify the exact semantic rule that requires the missing distinction.
6. If Model B succeeds, reduce the result to the simplest representation that still preserves required semantics.

Do not declare a winner before the counterexample has actually discriminated the models.

## Things not to redo

- Do not restart broad OVERRIDE research.
- Do not repeat the completed chain/cycle counterexample pass without new evidence.
- Do not re-derive established authorization boundaries from earlier chapters.
- Do not treat Qwen's taxonomy as adopted.
- Do not treat fail-closed as the universal consequence of `UNRESOLVED`.
- Do not introduce a generic dependency engine.
- Do not prematurely formalize candidate-level precedence.
- Do not extract the adversarial-review pattern into a formal reusable skill/workflow yet.
- Do not rewrite the Qwen onboarding solely for already-identified improvements.
- Do not redesign the handoff mechanism as part of this semantic research task.

## Recommended starting context for next chapter

Begin with this distinction:

```text
SEMANTIC STATE
    TRUE / FALSE / UNRESOLVED

REASON / CAUSE
    why resolution is unavailable

ORIGIN / PROPAGATION
    where/how unresolvedness entered the result

PROVENANCE
    which source/result supplied the information

CONSUMER CONSEQUENCE
    what the consuming rule does with the result
```

Then search for the smallest case in which a consumer's **correct semantic behavior** differs between two instances that both expose `UNRESOLVED`. If the difference can be expressed by an explicit consumer rule over orthogonal metadata, Model B remains viable. If not, identify the precise semantic distinction that must become part of the state itself.

Keep the burden of proof on adding semantic types, and keep the human as final decision-maker for any eventual architecture decision.
