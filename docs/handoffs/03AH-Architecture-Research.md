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

Continue **C-1 — Minimum Resolution Context** by testing candidate context elements one at a time.

Synthesis-1 consolidated U-1 through U-10 and left the Model A vs Model B Architecture Decision open. C-1 now tests whether individual candidate context elements are actually necessary.

No Architecture Decision has been made.

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

## Synthesis-1

### 1. Evidence summary

| Test | What was tested | Result | What it establishes / does not establish |
|---|---|---|---|
| U-1 | Predicate/condition evaluation with missing context | Model B survives preliminarily | Missing evidence can remain a cause/context distinction; no need for a typed state was demonstrated. |
| U-2 | Authority standing with missing/ambiguous authority evidence | Model B survives preliminarily | Authority uncertainty can be represented through subject + cause/context without proving a semantic subtype. |
| U-3 | Core current-operation result at an operation boundary | Model B survives preliminarily | An unresolved operation result need not become a new state subtype merely because its cause differs. |
| U-4 | Candidate eligibility propagated from an unresolved predicate | Model B survives preliminarily | Propagation can be represented through subject, cause, origin, source, and dependency context. `PROPAGATED` is not demonstrated to be a semantic state. |
| U-5 | Candidate effect depending on an unresolved effective outcome | Model B survives preliminarily | Dependency relation and provenance preserve the relevant distinction without requiring a typed `UNRESOLVED`. |
| U-6 | Effective outcome with competing eligible ALLOW/DENY candidates and no resolving precedence | Model B survives preliminarily, with increased pressure | Conflict is semantically relevant context, but the test did not prove that `CONFLICT` must be encoded as a subtype of `UNRESOLVED`. |
| U-7 | Dependency predicate whose target effective outcome is unresolved | Model B survives preliminarily | The dependency relation, target, source, and consumer context preserve the distinction; consumer consequence need not be encoded in the state itself. |
| U-8 | Eligibility dependency on unresolved authority | Model B survives preliminarily | Dependency target and consumer role can affect downstream behavior while remaining explicit context rather than becoming unresolved-state subtypes. |
| U-9 | Search for the smallest semantic-information-loss counterexample | No counterexample found | For the tested distinctions, Model B preserved the necessary information when sufficient context/graph/rules were available. This does not prove universal superiority. |
| U-10 | Combinatorial growth across cause × consumer role × dependency target | Neither model wins by simple counting | Complexity can accumulate in Model A's taxonomy or in Model B's rules/policies. The architectural question is where complexity is intentionally located and structured. |


### C-1.4 — `origin`

C-1.4 tested whether `origin` is independently necessary as a Resolution Context axis, or whether its required information can be expressed through existing context such as cause, provenance, and dependency relation.

The adversarial test was **C-1.4-T1**:

> Find a minimal counterexample in which two Resolution instances have the same state, cause, provenance, and dependency relation, but different `origin`, and the difference in `origin` produces different required downstream semantic behavior.

Independent review result:

```text
No counterexample found.
```

Qwen attempted three distinct counterexamples:

1. **Retry / re-evaluation behavior** — proposed different retry ordering for direct vs propagated unresolvedness. This was rejected because dependency structure already determines evaluation ordering.
2. **Override semantics** — proposed different override targets for direct vs propagated unresolvedness. This was rejected because authority/provenance and dependency relation already express the relevant constraints.
3. **Depth-limiting / cycle behavior** — proposed different handling based on direct vs propagated origin. This was rejected because cycle information is already represented by cause and dependency structure; the distinction did not establish different required semantics.

The reviewer therefore refined its position:

> `origin` is not demonstrated to carry independent semantic necessity and can currently be treated as derived information rather than a mandatory Resolution Context axis.

The result is bounded. The test does **not** prove that `origin` can never become semantically relevant in a future case. It establishes only that no independent semantic necessity was demonstrated by C-1.4-T1.

Working treatment:

```text
origin
→ not required as an independent Context axis
→ currently treated as derived information
→ may be reconstructed when needed from retained context/relations
→ diagnostic convenience does not justify independent storage
```

This is a Working Decision, not a final Architecture Decision.

### C-1.4 conclusion

**Current status: `origin` is excluded from the current candidate minimum Resolution Context, subject to later falsification.**

This wording is intentionally provisional because C-1 has not yet established the minimumity of the remaining fields.

### C-1.5 — next candidate

The next candidate to test is **`provenance`**.

Adversarial question:

> Is `provenance` genuinely an independently necessary element of Resolution Context, or can every required semantic distinction be expressed through `subject + state + cause + dependency relation` and other retained context?

Use the same burden of proof:

> Find a minimal counterexample where two Resolution instances have the same currently retained context except for `provenance`, and where that provenance difference creates different required downstream semantic behavior.

Diagnostic, logging, tracing, or UI convenience alone is not sufficient to establish necessity.

U-9 is particularly important: the independent reviewer did not find a minimal case where Model B, with sufficiently rich orthogonal context, necessarily loses semantic information that Model A can represent.

This is evidence against the claim that Model B is inherently less expressive for the tested cases. It is not proof that Model B is universally sufficient or superior.

### 2. Established semantic invariants

The investigation consistently supports keeping the following dimensions separate:

```text
resolution
├── subject
├── state
│   ├── TRUE
│   ├── FALSE
│   └── UNRESOLVED
├── cause / reason
├── origin / propagation mechanism
├── source / provenance
├── dependency relation
├── dependency target
├── consumer role
├── conflict / cycle context
└── consumer consequence
```

Established working invariants:

- Semantic state is not the same thing as cause.
- Semantic state is not the same thing as origin/propagation mechanism.
- Semantic state is not the same thing as source/provenance.
- Dependency relation and dependency target identify what a propagated unresolved result is about; they are not automatically unresolved-state types.
- Consumer role can change the rule applied to an unresolved result without changing the result's semantic state.
- Consumer consequence is a separate semantic rule and must not be inferred universally from `UNRESOLVED`.
- `UNRESOLVED` must not automatically mean `DENIED`, `FALSE`, blocked, or ineligible.
- `PROPAGATED` was previously treated as an origin/mechanism distinction; C-1.4 now provides evidence that a separately stored `origin` field is not currently required as an independent Context axis.
- Root cause and local propagation cause may both be relevant and should remain distinguishable through causal/provenance context.
- Candidate effect and effective outcome remain distinct.
- Precedence acts only on already eligible candidates and cannot bypass or create eligibility or authority.
- Hidden precedence based on incidental execution order remains prohibited.
- A generic dependency engine is not justified by this research.
- Candidate-level precedence remains a working direction, not an Architecture Decision.
- Qwen's typed `UNRESOLVED` taxonomy remains a research hypothesis, not adopted architecture.
- The burden of proof for a semantic subtype is a demonstrated downstream semantic requirement that an orthogonal representation cannot express correctly.
- The burden of proof for an independent Resolution Context axis is a demonstrated semantic distinction that cannot be correctly expressed from the other retained context.
- C-1.4-T1 found no demonstrated semantic necessity for independently storing `origin`; it is currently treated as derived information.

### 3. Expressiveness

For the cases actually tested, both models can represent the observed distinctions.

Model A places more of the distinction directly into the semantic taxonomy:

```text
UNRESOLVED{insufficient_evidence}
UNRESOLVED{conflict}
UNRESOLVED{dependency}
...
```

Model B keeps the semantic state stable and carries the distinction through explicit fields/context:

```text
state      = UNRESOLVED
cause      = conflict
origin     = direct
source     = J.effective_outcome
relation   = requires J.effective_outcome == ALLOW
role       = eligibility_requirement
```

U-9 did not produce a demonstrated semantic-information-loss counterexample for Model B. Therefore the current evidence does not justify declaring typed `UNRESOLVED` states necessary for expressiveness.

However, this conclusion is bounded: Model B's expressiveness depends on the architecture preserving the required context and making it available to the rules/consumers that need it. A bare `UNRESOLVED` value with the context discarded would not satisfy the evidence tested here.

### 4. Complexity / scaling

U-10 showed that complexity does not disappear merely by choosing either representation.

Model A can accumulate combinations in the semantic taxonomy. With the tested dimensions of 4 causes × 3 consumer roles × 3 dependency targets, a naive pure taxonomy already exposes 36 combinations before considering additional dimensions such as origin. That count is illustrative, not a prediction of the final taxonomy size.

Model B keeps dimensions orthogonal, but complexity can move into rules, policies, or consumer logic. A flat policy set could still contain many combinations; compositional rules can reduce duplication but require a well-designed rule structure.

Therefore the useful architectural distinction is:

```text
Model A
complexity tends toward:
    semantic taxonomy / subtype structure

Model B
complexity tends toward:
    context + rules / policies + consumer logic
```

Neither statement implies identical scaling, nor does the combination count alone establish a winner. The remaining design question is where complexity should be made explicit, inspectable, reusable, and constrained.

### 5. Human readability

The current evidence suggests a real trade-off rather than a universal winner.

| Concern | Model A | Model B |
|---|---|---|
| Local readability of one rule | Often easier when the subtype directly names the relevant semantic case | Can be concise, but important meaning may be distributed across fields |
| Cross-file navigation | Potentially lower when behavior is coupled to the subtype taxonomy | Can be higher if policies/rules are externalized |
| Transparency of semantic state | Strong when subtype taxonomy is well designed | Strong separation between state and context, but requires the reader to inspect context |
| Debugging / provenance | Can require reconstructing why a subtype was assigned | Natural fit for explicit source/origin/cause fields |
| Risk of taxonomy growth | Higher if every new distinction becomes a subtype | Lower at the state-vocabulary level, but rule/policy growth remains possible |

The independent review's usability observations should be treated as qualitative analysis, not as an objective benchmark. In particular, no fixed step-count comparison is established.

### 6. AI operability

The same trade-off appears from an AI reasoning perspective.

**Model A** can support straightforward pattern matching when the subtype itself maps closely to the required behavior. This can reduce the amount of contextual reconstruction required for a single local decision. The corresponding risk is that the model learns or assumes semantic behavior from taxonomy labels whose boundaries may become coupled to policy.

**Model B** makes reasoning inputs explicit: cause, origin, source, dependency relation, target, and consumer role can be inspected independently. This can make provenance and debugging easier to verify and can reduce pressure to encode every contextual distinction into the state vocabulary. The corresponding cost is context management: the reasoning system must locate and correctly apply the relevant rules instead of relying only on a state/subtype match.

No quantitative AI benchmark was established by U-1 through U-10. Claims such as a fixed number of reasoning steps are therefore not evidence.

### 7. Remaining trade-offs

| Dimension | Model A | Model B |
|---|---|---|
| Semantic vocabulary | More descriptive, potentially more specialized | Small and stable |
| Context separation | Some context can become embedded in types | Explicit by design |
| Local pattern matching | Potentially simpler | Requires context-aware interpretation |
| Provenance/debugging | May require additional metadata anyway | Naturally represented by orthogonal fields |
| Taxonomy growth | Risk of subtype proliferation | State vocabulary remains stable |
| Rule/policy growth | Some behavior may be encoded through subtype dispatch | More behavior may live in rules/policies |
| Cross-context consistency | Depends on keeping subtype meanings stable | Depends on consistent interpretation of shared fields/rules |
| Extensibility | New semantic distinctions may invite new subtypes | New dimensions can often be added orthogonally, subject to rule complexity |

This table is a trade-off map, not a ranking.

### 8. Architecture questions that remain

The following are not resolved by Synthesis-1:

1. What exact minimum context must travel with an unresolved result so that downstream consumers cannot lose required semantics?
2. Where should consumer rules live, and how should they be discovered without creating opaque cross-file policy dependencies?
3. Which distinctions, if any, are truly intrinsic to the semantic state rather than contextual attributes of a resolution?
4. Can conflict and cycle context remain orthogonal while still producing deterministic and inspectable consumer behavior?
5. Does propagation depth ever have semantic meaning, or is it only provenance/diagnostic information?
6. What constraints should prevent Model B's rule/policy layer from becoming an implicit subtype taxonomy with worse discoverability?
7. If a subtype is eventually justified, what is the precise downstream semantic requirement that cannot be expressed correctly with explicit context?
8. How should the representation expose root cause versus local propagation cause without creating ambiguous causal chains?
9. How should precedence and eligibility interact with unresolved values while preserving the existing authority/eligibility boundaries?

No Architecture Decision is made on these questions by Synthesis-1.

### 9. Decision readiness

**Current status: not yet ready for a final Architecture Decision between Model A and Model B.**

The current evidence is strong enough to reject a weaker claim — namely, that Model B is already shown to lose semantic information in the tested cases. It is not strong enough to establish that Model B is the final architecture, nor that Model A is required.

A further U-test is **not automatically required** merely to continue the series. U-1 through U-10 have already covered direct uncertainty, authority, operation results, propagation, dependency, conflict, nested dependency, information-loss search, and complexity placement.

If another adversarial test is commissioned, it should target a specific remaining uncertainty rather than simply add another variation of the same propagation pattern. The highest-value target would be a case where two `UNRESOLVED` instances have the same currently proposed orthogonal context but are required to produce different downstream semantic behavior. That would directly test the burden-of-proof condition for a semantic subtype.

Otherwise, the next productive step is architecture design work around **context preservation and rule/policy organization**, while explicitly keeping the Model A vs Model B decision open.

### 10. Handoff update

This handoff has been updated with Synthesis-1 and the C-1.4 research checkpoint. No Architecture Decision has been recorded.

The chapter remains `DRAFT` because the research synthesis does not by itself satisfy the conditions for a final architecture decision or handoff readiness.

## Current implementation state

The repository remains in the legacy/pre-refactor AI-instruction layout.

No structural architecture refactor has been executed as part of this research.

No generic dependency engine, precedence engine, authorization engine, candidate evaluator, or TRACE subsystem has been implemented as part of this research.

This chapter remains research/specification analysis only.

## Decisions

Working invariants carried forward and consolidated by Synthesis-1:

- `UNRESOLVED` is a semantic state; typed subtypes have not been justified by the current evidence.
- `UNRESOLVED` must not be treated as automatically equivalent to `DENIED` or `FALSE`.
- Consumer consequence is a separate semantic rule.
- Subject and state are separate semantic dimensions.
- Cause/reason, origin/propagation, source/provenance, dependency relation, dependency target, conflict context, consumer role, and consumer consequence must not be silently collapsed into semantic state.
- `PROPAGATED` is currently treated as an origin/mechanism dimension, not an adopted semantic subtype.
- Candidate effect and effective outcome remain distinct.
- Dependency target, consumer role, and precedence remain distinct dimensions.
- Precedence acts only on already eligible candidates and cannot bypass or create eligibility or authority.
- Hidden precedence from incidental execution order is prohibited.
- A generic dependency engine is not justified by the current evidence.
- Candidate-level precedence remains a working direction, not a formal Architecture Decision.
- Qwen's typed `UNRESOLVED` taxonomy remains a research hypothesis, not adopted architecture.
- The burden of proof for a semantic subtype is a demonstrated downstream semantic requirement that the orthogonal representation cannot express correctly.
- Propagation from a dependency target must preserve dependency relation and provenance.
- Root cause and local propagation cause should remain distinguishable.
- U-9 provides no demonstrated semantic-information-loss counterexample against Model B for the tested cases.
- U-10 establishes a complexity-location trade-off, not a model winner.

## Open questions

- What minimum context must accompany `UNRESOLVED`?
- Is `provenance` independently necessary, or can it be derived/reconstructed from other retained context?
- How should consumer rules/policies be organized and discovered?
- Which distinctions, if any, are intrinsic semantic state rather than context?
- Can conflict and cycle remain orthogonal without obscuring deterministic behavior?
- Does propagation depth ever have semantic meaning?
- What prevents Model B rules from becoming an implicit subtype taxonomy?
- Is there a concrete downstream semantic requirement that cannot be expressed with explicit context?
- How should root cause and local propagation cause be represented and traversed?
- How should unresolved values interact with precedence and eligibility without violating existing boundaries?

## Current files

### Handoff / lifecycle files read during bootstrap

- `docs/handoffs/03AG-Architecture-Research.md`
- `docs/handoffs/03AF-Architecture-Research.md`
- `docs/handoffs/03E-Architecture-Research.md`

### Rules / skills read during bootstrap

- `.ai/skills/conversation-handoff/BOOTSTRAP.md`
- `.ai/skills/conversation-handoff/SKILL.md`
- `.ai/rules/conversation-lifecycle.md`
- `.ai/rules/workflow.md`
- `.ai/rules/project-architecture.md`
- `.ai/rules/repository.md`
- `.ai/skills/deep-understanding/SKILL.md`
- `.ai/skills/commit-message/SKILL.md`

### Architecture/research documentation reviewed

- `docs/architecture/prerequisite-dependency-semantics.md`
- `docs/architecture/independent-review-qwen-onboarding.md`

## Relevant references

- `docs/architecture/independent-review-qwen-onboarding.md` — operational onboarding and role boundary for the Qwen independent-review workflow.
- `docs/architecture/prerequisite-dependency-semantics.md` — semantic separation and dependency/prerequisite boundaries.
- `docs/handoffs/03AG-Architecture-Research.md` — immediate research checkpoint before U-7 through U-10.
- `docs/handoffs/03AF-Architecture-Research.md` — predecessor same-specialization research inventory.
- `docs/handoffs/05AA-Independent-Review-Qwen.md` — independent-review role boundary and evidence-handling context.

## Important constraints

- Do not treat Qwen's taxonomy as adopted architecture.
- Do not equate `UNRESOLVED` with `DENIED`, `FALSE`, or any universal fail-closed consequence.
- Do not introduce a generic dependency engine.
- Do not prematurely formalize candidate-level precedence.
- Keep semantic state, cause, origin/propagation, provenance, relation/context, consumer role, and consumer consequence distinct.
- Do not treat U-9 as proof of universal Model B superiority.
- Do not treat U-10 as proof that both models scale identically.
- Do not use fixed reasoning-step counts as an AI benchmark without evidence.
- Do not create a third hybrid model merely from Qwen's usability suggestion; any hybrid requires separate analysis.
- The human referee remains the final decision-maker for architecture decisions.
- Preserve repository write-safety for all future existing-file modifications.

## Evidence / confidence

### Confirmed / observed

- U-1 through U-10 have been completed as an independent-review research sequence.
- U-1 through U-8 did not demonstrate a semantic requirement that Model B cannot preserve.
- U-9 did not find a smallest counterexample showing semantic information loss in Model B.
- U-10 demonstrated that complexity can accumulate in different architectural locations depending on representation.
- The tested cases consistently required distinctions beyond a scalar `UNRESOLVED` value, but those distinctions remained representable as explicit orthogonal context in the tested cases.
- C-1.4-T1 found no demonstrated semantic necessity for independently storing `origin`.

### Inferred

- Model B remains expressively viable for the tested cases if required context and rules are preserved and accessible.
- Explicit subject identification and provenance may be more important than expanding the semantic state vocabulary.
- `origin` currently appears to be derivable from retained context rather than an independent semantic axis, based on C-1.4-T1.
- The main unresolved architecture question has shifted from basic expressiveness toward context preservation and rule/policy organization.
- Model A's subtype taxonomy and Model B's rule/policy layer are alternative locations for complexity; neither has been established as universally preferable.

### Assumed / unverified

- That a complete Model B implementation can maintain discoverability and consistency as rule/policy complexity grows.
- That no future semantic case will require an intrinsic unresolved subtype.
- That propagation depth remains diagnostic/provenance information rather than semantic state.
- That future cases will not establish an independent semantic need for `origin`; C-1.4 only found no such case so far.
- That conflict and cycle context can remain orthogonal without hidden semantic coupling.

### Open

- Final Model A vs Model B Architecture Decision.
- Minimum required context contract for `UNRESOLVED` propagation.
- Whether `provenance` is independently necessary.
- Rule/policy organization and discoverability.
- Whether another adversarial test is necessary after these design questions are made concrete.

## Last completed task

**C-1.4 — `origin`**, including adversarial test **C-1.4-T1**.

Result: no counterexample demonstrated independent semantic necessity for `origin`; it is currently excluded from the candidate minimum Resolution Context as a derived field.

## Immediate next task

Continue **C-1.5 — `provenance`**.

Do not jump to a final Architecture Decision or formal minimum-context data structure yet. Test whether `provenance` is independently necessary using the same semantic-necessity burden of proof.

## Things not to redo

- Do not restart the broad UNRESOLVED research pass.
- Do not redo U-1 through U-10 without a specific evidentiary reason.
- Do not formalize the Qwen taxonomy.
- Do not introduce generic dependency/precedence/authorization engines.
- Do not redesign the handoff mechanism.
- Do not extract the adversarial-review pattern into a formal reusable skill/workflow yet.
- Do not treat Qwen's qualitative usability recommendations as benchmark evidence.

## Recommended starting context for next chapter

Use this semantic frame:

```text
SEMANTIC STATE
    TRUE / FALSE / UNRESOLVED

SUBJECT
    what is being resolved

CAUSE / REASON
    why resolution is unavailable

ORIGIN / PROPAGATION
    how unresolvedness reached the subject

PROVENANCE
    which source/result supplied the information

RELATION / CONTEXT
    dependency, conflict, cycle, etc.

DEPENDENCY TARGET
    what prerequisite result is being depended upon

CONSUMER ROLE
    eligibility, effect evaluation, precedence, etc.

CONSUMER CONSEQUENCE
    what the consuming rule does with the result
```

Primary discriminator for any future adversarial test:

> Can two instances that both expose `UNRESOLVED` have the same currently represented orthogonal context yet still require different downstream semantic behavior?

If yes, identify the missing intrinsic semantic distinction and test whether that distinction genuinely belongs in state rather than context/rules. If no, Model B remains viable for that case, while the architecture still must solve context preservation and rule/policy organization.

## C-1 research checkpoint

```text
C-1.4 — origin
STATUS
- No semantic-necessity counterexample found.
- origin is currently excluded from the candidate minimum Context Contract.
- origin may be derived/reconstructed when needed.
- This remains a Working Decision, not a final Architecture Decision.

NEXT
- C-1.5 — provenance.
- Apply the same adversarial semantic-necessity test.
- Keep the overall minimum Context Contract provisional until the candidate-by-candidate pass is complete.
```

## Final Synthesis-1 status

```text
WHAT WE KNOW
- No U-1…U-10 case demonstrated necessary semantic information loss in Model B.
- The tested distinctions can currently be represented as state + orthogonal context.
- Semantic state, cause, propagation, provenance, dependency, consumer role, and consequence should remain distinct.
- Complexity is relocated, not eliminated, by choosing a representation.

WHAT WE DO NOT KNOW
- Whether Model B remains maintainable and inspectable at full rule/policy scale.
- Whether a future case will demonstrate an intrinsic semantic subtype requirement.
- The final minimum context contract and rule/policy organization.

RECOMMENDED NEXT STEP
- Continue C-1 candidate-by-candidate testing, starting with `provenance`, before formalizing the minimum Context Contract.
- Keep Model A vs Model B formally undecided.
- Commission further adversarial tests only when they target a concrete remaining uncertainty.
```
