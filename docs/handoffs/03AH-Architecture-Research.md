# Conversation Handoff

Conversation:
AIP Mirror — 03AH — Architecture & Research

Specialization:
03

Chapter:
AH

Previous chapter:
AIP Mirror — 03AG — Architecture & Research

Status:
DRAFT

## Current objective

Continue the Model A vs Model B investigation of `UNRESOLVED` propagation semantics from 03AG, beginning with **U-7 — Dependency Predicate / propagated effective-outcome unresolved**.

The immediate goal is to test the exact U-7 counterexample supplied by the independent reviewer (Qwen) without reconstructing or inventing its contents.

Competing research models:

```text
MODEL A — Typed semantic UNRESOLVED
TRUE / FALSE / UNRESOLVED{types}
```

```text
MODEL B — Untyped semantic state + orthogonal metadata
TRUE / FALSE / UNRESOLVED
+
reason / source / propagation / conflict / cycle
```

No Architecture Decision has been made from this research.

## Completed

03AG completed U-1 through U-6.

Current evidence status:

```text
U-1 → Model B survives preliminarily
U-2 → Model B survives preliminarily
U-3 → Model B survives preliminarily
U-4 → Model B survives preliminarily
U-5 → Model B survives preliminarily
U-6 → Model B survives preliminarily, but pressure increases
U-7 → Model B survives preliminarily; consumer role is contextual/semantic input, not yet a demonstrated unresolved subtype
```

### U-7 — Dependency Predicate / propagated effective-outcome unresolved

Exact case supplied by Qwen:

```text
Candidate I:
  dependency: requires J.effective_outcome == ALLOW

Candidate J:
  effective_outcome: UNRESOLVED (see U-6)
```

The unresolved subject is the **dependency predicate** for I, specifically the relation `I → J.effective_outcome`. Its unresolvedness is propagated from J's unresolved effective outcome.

Model A can encode this as a typed unresolved subtype, e.g. `UNRESOLVED{dependency}`.

Model B can encode the same semantic information without changing the state vocabulary:

```text
subject     = dependency predicate(I → J.effective_outcome)
state       = UNRESOLVED
cause       = propagated unresolvedness from dependency target
origin      = propagated
source      = J.effective_outcome
relation    = dependency / requires == ALLOW
```

The important observation is that U-7 contains more than the scalar state: the dependency relation and provenance identify what is unresolved and where the unresolvedness came from. Removing that relation would lose semantic information, but that does not show that the information must be encoded as a subtype of `UNRESOLVED`; it can remain an orthogonal relation/context field.

The consumer-role distinction is also real but does not, by itself, force a typed unresolved state. The same unresolved predicate may be consumed by different semantic rules, for example an eligibility requirement versus effect evaluation, and the consuming rule may legitimately produce different consequences. This is a difference in **consumer semantics/context**, not necessarily a difference in the state of the predicate itself.

Therefore the hidden-subtype test is not yet defeated: two instances can both expose `state = UNRESOLVED` while explicit relation, provenance, and consumer context preserve the information needed for different downstream behavior.

U-7 does, however, strengthen the requirement that the architecture must not collapse these dimensions into a bare boolean-like `UNRESOLVED`. In particular, propagated unresolvedness should preserve its dependency source and relation, and downstream consumers must not infer a universal consequence such as `FALSE` or `DENIED` from the propagated state alone.

A further useful distinction is:

```text
J.effective_outcome
    state  = UNRESOLVED
    cause  = conflict

        ↓ propagation through dependency

I.dependency_predicate
    state  = UNRESOLVED
    cause  = propagated unresolvedness
    source = J.effective_outcome
    relation = requires J.effective_outcome == ALLOW
```

The root cause (`conflict`) and the local propagation cause (`dependency target unresolved`) should remain distinguishable through provenance/causal context rather than being flattened into a new semantic state subtype.

## Current implementation state

The repository remains in the legacy/pre-refactor AI-instruction layout.

No structural architecture refactor has been executed as part of this research.

No generic dependency engine, precedence engine, authorization engine, candidate evaluator, or TRACE subsystem has been implemented as part of this research.

This chapter begins as research/specification analysis only.

## Decisions

Working invariants carried forward from 03AG:

- `UNRESOLVED` is a semantic state; its internal representation and propagation semantics remain under investigation.
- `UNRESOLVED` must not be treated as automatically equivalent to `DENIED`.
- Consumer consequence is a separate semantic rule.
- Subject and state are separate semantic dimensions.
- Cause/reason, origin/propagation, source/provenance, dependency relation, conflict context, and consumer consequence must not be silently collapsed into semantic state.
- `PROPAGATED` is currently treated as a candidate origin/mechanism dimension, not an adopted semantic subtype.
- Candidate effect and effective outcome remain distinct.
- Dependency target, consumer role, and precedence remain distinct dimensions.
- Precedence acts only on already eligible candidates and cannot bypass or create eligibility or authority.
- Hidden precedence from incidental execution order is prohibited.
- A generic dependency engine is not justified by the current evidence.
- Candidate-level precedence remains a working direction, not a formal Architecture Decision.
- Qwen's typed `UNRESOLVED` taxonomy remains a research hypothesis, not adopted architecture.
- The burden of proof for a semantic subtype is a demonstrated downstream semantic requirement that the orthogonal representation cannot express correctly.
- U-7 does not yet demonstrate that consumer role must become an `UNRESOLVED` subtype; consumer role can remain explicit semantic context for the consuming rule.
- Propagation from a dependency target must preserve the dependency relation and provenance; propagation is not itself a new semantic state.

## Open questions

- Does U-8 or a later nested/mixed case demonstrate a semantic distinction that Model B cannot preserve?
- Does a dependency predicate receiving a propagated unresolved effective outcome ever require a typed semantic state rather than explicit relation/context?
- Which dimensions of later cases are semantic state versus cause, origin, provenance, dependency relation, conflict context, or consumer consequence?
- Does propagation depth carry semantic meaning or only diagnostic value?
- Do nested or mixed unresolved cases require additional semantic distinctions?
- Can conflict and cycle context remain orthogonal without becoming hidden semantic subtypes?
- What, if anything, remains to be learned from U-8 through U-10 after U-7?

## Current files

### Handoff / lifecycle files read during bootstrap

- `docs/handoffs/03AG-Architecture-Research.md`
- `docs/handoffs/03AF-Architecture-Research.md`

### Rules / skills read during bootstrap

- `.ai/skills/conversation-handoff/BOOTSTRAP.md`
- `.ai/skills/conversation-handoff/SKILL.md`
- `.ai/rules/conversation-lifecycle.md`
- `.ai/rules/workflow.md`
- `.ai/skills/commit-message/SKILL.md`

### Architecture/research documentation reviewed

- `docs/architecture/independent-review-qwen-onboarding.md`

## Relevant references

- `docs/architecture/independent-review-qwen-onboarding.md` — operational onboarding and role boundary for the Qwen independent-review workflow.
- `docs/handoffs/03AG-Architecture-Research.md` — immediate research checkpoint and exact U-7 continuation task.
- `docs/handoffs/03AF-Architecture-Research.md` — predecessor same-specialization lifecycle and broader U-1…U-10 inventory.

## Important constraints

- Do not begin a broad new research pass.
- Do not invent or reconstruct the U-7 case; the user will provide the exact Qwen fragment.
- Do not repeat U-1 through U-6 unless new evidence specifically requires comparison.
- Do not treat Qwen's taxonomy as adopted architecture.
- Do not equate `UNRESOLVED` with `DENIED` or adopt fail-closed as a universal consequence.
- Do not introduce a generic dependency engine.
- Do not prematurely formalize candidate-level precedence.
- Keep semantic state, cause, origin/propagation, provenance, relation/context, and consumer consequence distinct.
- The human referee remains the final decision-maker for architecture decisions.
- Do not modify the Qwen onboarding merely for already-identified future improvements.
- Preserve repository write-safety for all future existing-file modifications.

## Evidence / confidence

### Confirmed / observed

- 03AG completed U-1 through U-6 of the Model A vs Model B investigation.
- 03AG is the immediate `READY_FOR_HANDOFF` source for this receiving chapter.
- 03AF is already `SUPERSEDED` and is the previous same-specialization predecessor of 03AG.
- No U-1 through U-6 case has demonstrated a semantic requirement that Model B cannot preserve.
- The exact U-7 case was supplied by Qwen and analyzed in this chapter.
- U-7 preserves the distinction between the unresolved dependency predicate and the unresolved dependency target through explicit subject/source/relation context.
- U-7's different downstream consequences can be expressed by consumer semantics without requiring different unresolved state values.

### Inferred

- Explicit subject identification may be more important than adding semantic state types.
- Model B preserves semantic expressiveness for the supplied U-7 case.
- `PROPAGATED` describes origin/mechanism rather than semantic state.
- Root cause and local propagation cause should remain distinguishable through causal/provenance context.

### Assumed / unverified

- Whether U-7's orthogonal representation remains sufficient under more deeply nested propagation.
- Whether propagation depth has semantic meaning.
- Whether later cases create a downstream semantic requirement that cannot be expressed by explicit context/relation.
- Whether orthogonal metadata remains sufficient for all downstream consumer behavior in the complete U-1…U-10 set.

### Open

- U-8 through U-10 comparison after U-7, if still warranted by evidence.
- Mixed/nested unresolved cases.
- Final disposition of Model A vs Model B.

## Last completed task

03AH analyzed U-7 — Dependency Predicate / propagated effective-outcome unresolved.

## Immediate next task

Obtain the exact Qwen fragment for **U-8**, if further testing is warranted, and apply the same Model A vs Model B discriminator without reconstructing the case from memory.

Do not infer the contents of U-8 before receiving the fragment.

## Things not to redo

- Do not restart the broad UNRESOLVED research pass.
- Do not redo U-1 through U-7 without a specific evidentiary reason.
- Do not redo the earlier dependency chain/cycle counterexample pass.
- Do not restart OVERRIDE research.
- Do not formalize the Qwen taxonomy.
- Do not introduce generic dependency/precedence/authorization engines.
- Do not redesign the handoff mechanism.
- Do not extract the adversarial-review pattern into a formal reusable skill/workflow yet.

## Recommended starting context for next chapter

Use this semantic frame when the next fragment arrives:

```text
SEMANTIC STATE
    TRUE / FALSE / UNRESOLVED

SUBJECT
    what is being resolved

REASON / CAUSE
    why resolution is unavailable

ORIGIN / PROPAGATION
    how unresolvedness reached the subject

PROVENANCE
    which source/result supplied the information

RELATION / CONTEXT
    dependency, conflict, cycle, etc.

CONSUMER CONSEQUENCE
    what the consuming rule does with the result
```

Primary discriminator:

> Can the consumer's correct semantic behavior differ between two instances that both expose `UNRESOLVED`, while the difference is preserved by explicit orthogonal metadata/context?

If yes, Model B remains viable for that case. If no, identify the precise semantic distinction that must become part of the state itself.
