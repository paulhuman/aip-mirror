# Conversation Handoff

Conversation:
AIP Mirror — 03AI — Architecture & Research

Specialization:
03

Chapter:
AI

Previous chapter:
AIP Mirror — 03AH — Architecture & Research

Status:
SUPERSEDED

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

| Test | What was tested                                                                             | Result                                                  | What it establishes / does not establish                                                                                                                                |
| ---- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| U-1  | Predicate/condition evaluation with missing context                                         | Model B survives preliminarily                          | Missing evidence can remain a cause/context distinction; no need for a typed state was demonstrated.                                                                    |
| U-2  | Authority standing with missing/ambiguous authority evidence                                | Model B survives preliminarily                          | Authority uncertainty can be represented through subject + cause/context without proving a semantic subtype.                                                            |
| U-3  | Core current-operation result at an operation boundary                                      | Model B survives preliminarily                          | An unresolved operation result need not become a new state subtype merely because its cause differs.                                                                    |
| U-4  | Candidate eligibility propagated from an unresolved predicate                               | Model B survives preliminarily                          | Propagation can be represented through subject, cause, origin, source, and dependency context. `PROPAGATED` is not demonstrated to be a semantic state.                 |
| U-5  | Candidate effect depending on an unresolved effective outcome                               | Model B survives preliminarily                          | Dependency relation and provenance preserve the relevant distinction without requiring a typed `UNRESOLVED`.                                                            |
| U-6  | Effective outcome with competing eligible ALLOW/DENY candidates and no resolving precedence | Model B survives preliminarily, with increased pressure | Conflict is semantically relevant context, but the test did not prove that `CONFLICT` must be encoded as a subtype of `UNRESOLVED`.                                     |
| U-7  | Dependency predicate whose target effective outcome is unresolved                           | Model B survives preliminarily                          | The dependency relation, target, source, and consumer context preserve the distinction; consumer consequence need not be encoded in the state itself.                   |
| U-8  | Eligibility dependency on unresolved authority                                              | Model B survives preliminarily                          | Dependency target and consumer role can affect downstream behavior while remaining explicit context rather than becoming unresolved-state subtypes.                     |
| U-9  | Search for the smallest semantic-information-loss counterexample                            | No counterexample found                                 | For the tested distinctions, Model B preserved the necessary information when sufficient context/graph/rules were available. This does not prove universal superiority. |
| U-10 | Combinatorial growth across cause × consumer role × dependency target                       | Neither model wins by simple counting                   | Complexity can accumulate in Model A's taxonomy or in Model B's rules/policies. The architectural question is where complexity is intentionally located and structured. |

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

### C-1.5 — `provenance`

C-1.5 tested whether **`provenance` is independently necessary** as a Resolution Context axis, or whether every semantically required distinction can be reconstructed from the other retained context.

Adversarial question:

> Is `provenance` genuinely an independently necessary element of Resolution Context, or can every required semantic distinction be expressed through `subject + state + cause + dependency relation` and other retained context?

### C-1.5-T1 — semantic-necessity counterexample

The primary test was intentionally symmetric with C-1.4-T1:

> Find a minimal counterexample in which two Resolution instances have the same currently retained context except for `provenance`, and the difference in provenance produces different required downstream semantic behavior.

The test held the following dimensions constant unless a proposed counterexample specifically demonstrated that one could not be held constant:

```text
subject
state
cause / reason
dependency relation
dependency target
consumer role
consumer consequence inputs
```

The intended discriminator was only:

```text
provenance
```

The burden of proof was **semantic necessity**, not observability.

The following were explicitly rejected as insufficient on their own:

- diagnostic usefulness;
- logging or tracing convenience;
- UI display;
- audit/history convenience;
- easier debugging;
- easier human inspection;
- easier AI reasoning.

A valid counterexample had to show that changing only provenance requires a **different downstream semantic rule, eligibility result, candidate effect, effective outcome, authority consequence, precedence consequence, or other architecture-level semantic behavior**.

#### C-1.5-T1 independent-review result

Qwen 05AB returned:

```text
B — No counterexample found

No minimal counterexample demonstrating independent semantic necessity
of provenance was found.
```

Three principal attack directions were executed:

1. **Source-sensitive semantics** — attempted to make different semantic sources require different downstream behavior.
2. **Consumer-policy semantics** — attempted to make a consumer branch solely on provenance while all other context remained equal.
3. **Dependency reconstruction** — attempted to identify information in provenance that could not be reconstructed from subject, cause, dependency relation, dependency target, and consumer role.

The reviewed counterexamples were rejected for the following reasons:

- **Authority-based routing:** the proposed distinction collapsed into authority/trust level rather than independent provenance semantics.
- **Explicit vs implicit authorization:** the proposed distinction collapsed into authority consequence / authority level.
- **Mutable vs immutable source:** the distinction was a property of the dependency target, not an independent provenance fact.
- **Same-source re-validation:** this introduced a new policy not currently defined by the architecture and therefore could not serve as evidence for an existing semantic requirement.
- **Override eligibility by establisher:** the proposed distinction required additional authority/precedence rules; provenance alone did not establish the different behavior.

The recurring result was:

```text
provenance
    ↓
attempted downstream semantic distinction
    ↓
either already represented by another context field,
or requires a new semantic policy,
or contains hidden information in a supposedly fixed field
```

Qwen also identified several remaining areas where future architecture could change the result:

1. future source-dependent policies;
2. a stricter distinction between provenance and authority;
3. temporal semantics if a separate ordering/timestamp concept becomes relevant;
4. multi-source evaluation where source identity itself becomes a required semantic discriminator.

These are open possibilities, not demonstrated counterexamples.

### C-1.5-T1 bounded conclusion

**Current status: independent semantic necessity of `provenance` was not demonstrated by the tested counterexamples.**

This does **not** establish that provenance is universally unnecessary. It establishes only that, under the current architectural definitions and tested scenarios, no minimal counterexample showed that provenance must exist as an independent semantic Context axis.

Working treatment:

```text
provenance
→ independent semantic necessity NOT demonstrated
→ candidate for derived / reconstructable information
→ must not be assumed to be an independent Context axis
→ may still be retained where needed to preserve or reconstruct semantic relations
→ diagnostic / tracing convenience alone does not justify independent storage
```

This is a Working Decision, not a final Architecture Decision.

### C-1.5 conclusion

For the current candidate pass:

```text
origin
→ independent axis not demonstrated
→ currently treated as derived / reconstructable

provenance
→ independent axis not demonstrated
→ currently treated as derived / reconstructable candidate
```

The two results are analogous but not identical in evidentiary scope: each is bounded by its own adversarial test.

The minimum Resolution Context is **still not established**. The remaining candidate fields must be tested before a minimum Context Contract is formalized.

No Architecture Decision has been made.

### C-1.6-T1 — `consumer consequence`

C-1.6-T1 tested whether **`consumer consequence` is independently necessary** as a Resolution Context axis, or whether it is a derived result of applying a consumer rule to retained Resolution Context.

The adversarial question was:

> Can two otherwise identical Resolution instances have different `consumer consequence` values such that the difference requires different downstream semantic behavior that cannot be derived from the retained context, consumer role, and applicable consumer rules?

The test held the following dimensions constant where possible:

```text
subject
state
cause / reason
dependency relation
dependency target
consumer role
conflict / cycle context
applicable consumer rule
```

The burden of proof was **independent semantic necessity**, not caching, logging, diagnostic usefulness, implementation convenience, or performance.

#### C-1.6-T1 independent-review result

Qwen 05AB returned:

```text
B — no independent semantic necessity demonstrated
```

No minimal counterexample was found.

The principal attack directions were:

1. **Eligibility** — a difference in consequence could not change eligibility while all inputs and applicable rules remained identical without introducing a new policy or changing an existing input.
2. **Candidate effect** — consequence could be represented as an intermediate result of consumer-policy evaluation rather than an independent input.
3. **Effective outcome** — storing the consequence would record an intermediate result rather than add independent semantic information; caching would be an optimization, not semantic necessity.
4. **Authority / precedence** — proposed uses either collapsed into existing authority/precedence concepts or required introducing a new policy that depends on stored consequence.
5. **Consumer-role attack** — different consumers can legitimately produce different consequences from the same Resolution because consumer role and consumer rules differ; this shows that consequence is a property of the Resolution-consumer interaction rather than an intrinsic property of the Resolution.
6. **Definition-level derivation** — the tested cases were adequately represented by:

```text
consumer_consequence
    =
ConsumerRule(
    Resolution Context,
    consumer role,
    applicable policy
)
```

The reviewer therefore classified `consumer consequence` as:

```text
derived semantic result
consumer-policy output
```

Qwen identified bounded future cases that could change the result, including temporal/history semantics, genuinely nondeterministic consumer rules, future policies that explicitly consume a stored consequence, or protocol-level requirements for cross-system consistency. None of these was established by the current architecture or by the test.

### C-1.6-T1 bounded conclusion

**Current status: independent semantic necessity of `consumer consequence` was not demonstrated by the tested counterexamples.**

This does **not** prove that storing a consumer consequence is universally wrong. It establishes only that, under the current architectural definitions and tested scenarios, no minimal counterexample demonstrated that it must be an independent Resolution Context axis.

Working treatment:

```text
consumer consequence
→ not an independent Context axis under current evidence
→ derived semantic result
→ consumer-policy output
→ computed from retained context + consumer role + applicable rules
→ must not be treated as an intrinsic property of Resolution
```

This is a Working Decision, not a final Architecture Decision.

### C-1.6-T1 conclusion

The current candidate set is reduced by one additional element:

```text
consumer consequence
→ independent axis not demonstrated
→ currently treated as a derived consumer-policy result
```

The remaining candidate set is now:

```text
Resolution Context
├── subject
├── state
├── cause / reason
├── dependency relation
├── dependency target
├── consumer role
└── conflict / cycle context
```

This list remains **provisional**. The remaining fields have not yet been proven independently necessary or mutually independent.

## Interim Synthesis after C-1.6-T1

C-1.4, C-1.5, and C-1.6-T1 now provide three consecutive bounded tests of candidate context elements:

| Candidate              | Current result                                         | Working treatment                                |
| ---------------------- | ------------------------------------------------------ | ------------------------------------------------ |
| `origin`               | No independent semantic-necessity counterexample found | Derived / reconstructable information candidate  |
| `provenance`           | No independent semantic-necessity counterexample found | Derived / reconstructable information candidate  |
| `consumer consequence` | No independent semantic-necessity counterexample found | Derived semantic result / consumer-policy output |

The three results reinforce a common distinction:

```text
semantic state
    ≠
context required to evaluate it
    ≠
derived result of consuming it
```

More specifically:

```text
Resolution
    │
    ├── retained semantic/context information
    │
    ▼
Consumer role + applicable rule
    │
    ▼
Consumer consequence
```

This reduces pressure to enlarge the semantic state vocabulary or the Resolution Context merely because a concept has a distinct name and participates in downstream reasoning.

At the same time, the results do **not** establish that every remaining context element is independent, mandatory, or intrinsic. The remaining candidate set must still be examined for hidden level-mixing between Resolution properties, dependency relationships, consumer context, and conflict/cycle context.

### Interim synthesis conclusion

The research is increasingly separating three questions that were previously easy to conflate:

1. **What is the semantic state of the Resolution?**
2. **What information/relations must remain available to evaluate downstream rules correctly?**
3. **What result is produced when a consumer applies its rule to that Resolution?**

C-1.4 through C-1.6-T1 provide no demonstrated need to promote `origin`, `provenance`, or `consumer consequence` into independent semantic axes merely because they are useful concepts.

The next research step should therefore shift from testing already-excluded candidates toward checking whether the **remaining candidate set itself mixes different semantic levels** and whether each remaining element is independently necessary.

No Architecture Decision has been made.

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
- Consumer consequence is a derived consumer-policy result, not currently an independent Resolution Context axis; it must not be inferred universally from `UNRESOLVED`.
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
- C-1.5-T1 found no demonstrated semantic necessity for independently storing `provenance`; it is currently treated as derived/reconstructable information candidate.
- C-1.6-T1 found no demonstrated semantic necessity for independently storing `consumer consequence`; it is currently treated as a derived consumer-policy result.

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

| Concern                        | Model A                                                                 | Model B                                                                                 |
| ------------------------------ | ----------------------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| Local readability of one rule  | Often easier when the subtype directly names the relevant semantic case | Can be concise, but important meaning may be distributed across fields                  |
| Cross-file navigation          | Potentially lower when behavior is coupled to the subtype taxonomy      | Can be higher if policies/rules are externalized                                        |
| Transparency of semantic state | Strong when subtype taxonomy is well designed                           | Strong separation between state and context, but requires the reader to inspect context |
| Debugging / provenance         | Can require reconstructing why a subtype was assigned                   | Natural fit for explicit source/origin/cause fields                                     |
| Risk of taxonomy growth        | Higher if every new distinction becomes a subtype                       | Lower at the state-vocabulary level, but rule/policy growth remains possible            |

The independent review's usability observations should be treated as qualitative analysis, not as an objective benchmark. In particular, no fixed step-count comparison is established.

### 6. AI operability

The same trade-off appears from an AI reasoning perspective.

**Model A** can support straightforward pattern matching when the subtype itself maps closely to the required behavior. This can reduce the amount of contextual reconstruction required for a single local decision. The corresponding risk is that the model learns or assumes semantic behavior from taxonomy labels whose boundaries may become coupled to policy.

**Model B** makes reasoning inputs explicit: cause, origin, source, dependency relation, target, and consumer role can be inspected independently. This can make provenance and debugging easier to verify and can reduce pressure to encode every contextual distinction into the state vocabulary. The corresponding cost is context management: the reasoning system must locate and correctly apply the relevant rules instead of relying only on a state/subtype match.

No quantitative AI benchmark was established by U-1 through U-10. Claims such as a fixed number of reasoning steps are therefore not evidence.

### 7. Remaining trade-offs

| Dimension                 | Model A                                               | Model B                                                                    |
| ------------------------- | ----------------------------------------------------- | -------------------------------------------------------------------------- |
| Semantic vocabulary       | More descriptive, potentially more specialized        | Small and stable                                                           |
| Context separation        | Some context can become embedded in types             | Explicit by design                                                         |
| Local pattern matching    | Potentially simpler                                   | Requires context-aware interpretation                                      |
| Provenance/debugging      | May require additional metadata anyway                | Naturally represented by orthogonal fields                                 |
| Taxonomy growth           | Risk of subtype proliferation                         | State vocabulary remains stable                                            |
| Rule/policy growth        | Some behavior may be encoded through subtype dispatch | More behavior may live in rules/policies                                   |
| Cross-context consistency | Depends on keeping subtype meanings stable            | Depends on consistent interpretation of shared fields/rules                |
| Extensibility             | New semantic distinctions may invite new subtypes     | New dimensions can often be added orthogonally, subject to rule complexity |

This table is a trade-off map, not a ranking.

### 8. Architecture questions that remain

The following are not resolved by Synthesis-1 or C-1.5:

1. What exact minimum context must travel with an unresolved result so that downstream consumers cannot lose required semantics?
2. Where should consumer rules live, and how should they be discovered without creating opaque cross-file policy dependencies?
3. Which distinctions, if any, are truly intrinsic to the semantic state rather than contextual attributes of a resolution?
4. Can conflict and cycle context remain orthogonal while still producing deterministic and inspectable consumer behavior?
5. Does propagation depth ever have semantic meaning, or is it only provenance/diagnostic information?
6. What constraints should prevent Model B's rule/policy layer from becoming an implicit subtype taxonomy with worse discoverability?
7. If a subtype is eventually justified, what is the precise downstream semantic requirement that cannot be expressed correctly with explicit context?
8. How should the representation expose root cause versus local propagation cause without creating ambiguous causal chains?
9. How should precedence and eligibility interact with unresolved values while preserving the existing authority/eligibility boundaries?

No Architecture Decision is made on these questions.

### 9. Decision readiness

**Current status: not yet ready for a final Architecture Decision between Model A and Model B.**

The current evidence is strong enough to reject a weaker claim — namely, that Model B is already shown to lose semantic information in the tested cases. It is not strong enough to establish that Model B is the final architecture, nor that Model A is required.

A further U-test is **not automatically required** merely to continue the series. U-1 through U-10 have already covered direct uncertainty, authority, operation results, propagation, dependency, conflict, nested dependency, information-loss search, and complexity placement.

If another adversarial test is commissioned, it should target a specific remaining uncertainty rather than simply add another variation of the same propagation pattern. The highest-value target would be a case where two `UNRESOLVED` instances have the same currently proposed orthogonal context but are required to produce different downstream semantic behavior. That would directly test the burden-of-proof condition for a semantic subtype.

Otherwise, the next productive step is architecture design work around **context preservation and rule/policy organization**, while explicitly keeping the Model A vs Model B decision open.

### 10. Handoff update

This handoff has been updated with Synthesis-1, the C-1.4 research checkpoint, and the completed C-1.5-T1 provenance adversarial pass. No Architecture Decision has been recorded.

The chapter is now `READY_FOR_HANDOFF` for migration to **AIP Mirror — 03AI — Architecture & Research**. The research remains provisional and no final Architecture Decision has been made.

### C-1.6-T2 — `dependency relation`

C-1.6-T2 tested whether **`dependency relation` has independent semantic necessity as an internal Resolution Context axis**, or whether its semantics belong to the relationship between Resolution instances.

The key methodological distinction was:

```
semantic necessity of information
≠
necessity to store that information inside Resolution Context
```

Qwen 05AB returned:

```
B — no independent semantic necessity demonstrated
(as an internal Resolution Context axis)
```

The result has an important qualification: `dependency relation` appears semantically necessary as a property of the relationship between Resolution instances, but not as an internal field of the Resolution itself.

Attack directions covered:

1. Eligibility — differences collapsed into consumer rules interpreting relation types.
2. Candidate effect — relation functions as an input to consumer policy rather than an intrinsic Resolution property.
3. Effective outcome — differences are attributable to graph structure or consumer policy.
4. Authority / precedence — proposed differences require authority/precedence rules; the relation itself does not establish an independent internal axis.
5. Relation-vs-target — relation type and target jointly describe a relationship between two Resolution instances rather than two independent internal Resolution fields.
6. Graph / edge ownership — multiple outgoing relations naturally form graph edges.
7. Multi-consumer — the same relation may be interpreted differently by different consumers.
8. Definition-level — relation is naturally represented as edge semantics.

### C-1.6-T2 bounded conclusion

**Current status: independent semantic necessity of `dependency relation` was not demonstrated as an internal Resolution Context axis.**

This does **not** mean that dependency relation is semantically unnecessary. Its current classification is:

```
dependency relation
→ semantically necessary relationship information
→ relationship / graph-edge semantics
→ not an independent internal Resolution Context axis
```

The provisional semantic model is:

```
Resolution = semantic node

Relation = semantic relationship between Resolution nodes

Relation
├── source
├── target
├── relation_type
└── possibly other relation-level semantics
```

This is a Working Decision / provisional semantic classification, not a final Architecture Decision that all relations must necessarily be implemented as graph edges.

Remaining uncertainty includes relationships without a target Resolution, temporal/dynamic relations, multiple relation graphs, and implementation-level denormalization. None currently reverses the bounded result.

### C-1.6-T2 conclusion

The candidate set is now provisionally split by semantic level:

```
Resolution Context
├── subject
├── state
├── cause / reason
├── dependency target        ← still under test
├── consumer role
└── conflict / cycle context

Relation Context / Graph semantics
├── source
├── target
├── relation_type
└── ...
```

The placement of `dependency target` remains unresolved and is intentionally tested separately in C-1.6-T3.

No Architecture Decision has been made.

## Current implementation state

The repository remains in the legacy/pre-refactor AI-instruction layout.

No structural architecture refactor has been executed as part of this research.

No generic dependency engine, precedence engine, authorization engine, candidate evaluator, or TRACE subsystem has been implemented as part of this research.

This chapter remains research/specification analysis only.

## Decisions

Working invariants carried forward and consolidated by Synthesis-1 and C-1.5-T1:

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
- The burden of proof for an independent Resolution Context axis is a demonstrated semantic distinction that cannot be correctly expressed from the other retained context.
- Propagation from a dependency target must preserve dependency relation and provenance where that information is retained.
- Root cause and local propagation cause should remain distinguishable.
- U-9 provides no demonstrated semantic-information-loss counterexample against Model B for the tested cases.
- U-10 establishes a complexity-location trade-off, not a model winner.
- C-1.4-T1 found no demonstrated semantic necessity for independently storing `origin`.
- C-1.5-T1 found no demonstrated semantic necessity for independently storing `provenance`.

## Open questions

- What minimum context must accompany `UNRESOLVED`?
- Are the remaining candidate context axes independently necessary, or are some also derivable/reconstructable?
- Does the remaining candidate set mix Resolution properties with dependency relations, consumer context, or conflict/cycle context?
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
- Keep semantic state, cause, origin/propagation, provenance, relation/context, consumer role, and consumer consequence distinct while their independent necessity is being tested.
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
- C-1.5-T1 found no demonstrated semantic necessity for independently storing `provenance` in the tested scenarios.
- C-1.6-T1 found no demonstrated semantic necessity for independently storing `consumer consequence`; it is currently classified as a derived semantic result / consumer-policy output.

### Inferred

- Model B remains expressively viable for the tested cases if required context and rules are preserved and accessible.
- Explicit subject identification and provenance may be more important than expanding the semantic state vocabulary.
- `origin` currently appears to be derivable from retained context rather than an independent semantic axis, based on C-1.4-T1.
- `provenance` currently appears to be a derived/reconstructable candidate rather than an independently necessary semantic axis, based on C-1.5-T1.
- The main unresolved architecture question has shifted from basic expressiveness toward context preservation and rule/policy organization.
- Model A's subtype taxonomy and Model B's rule/policy layer are alternative locations for complexity; neither has been established as universally preferable.

### Assumed / unverified

- That a complete Model B implementation can maintain discoverability and consistency as rule/policy complexity grows.
- That no future semantic case will require an intrinsic unresolved subtype.
- That propagation depth remains diagnostic/provenance information rather than semantic state.
- That future cases will not establish an independent semantic need for `origin` or `provenance`; C-1.4-T1 and C-1.5-T1 only found no such case so far.
- That conflict and cycle context can remain orthogonal without hidden semantic coupling.

### Open

- Final Model A vs Model B Architecture Decision.
- Minimum required context contract for `UNRESOLVED` propagation.
- Whether any remaining candidate context axis is independently necessary.
- Rule/policy organization and discoverability.
- Whether another adversarial test is necessary after the remaining candidate axes are made concrete.

## Last completed task

**C-1.6-T4 — `consumer role`**.

Result: no independent semantic necessity was demonstrated for `consumer role` as an internal Resolution Context axis. It is currently classified as evaluation-context information / consumer-policy input, with possible relationship-level ownership between Resolution and Consumer remaining unresolved.

C-1.6-T5 has been commissioned; its Qwen response is pending.

## Immediate next task

Continue **C-1.6 — remaining-context minimality** with **C-1.6-T5 — `applicability / applicability condition`**.

Current provisional candidate set:

```
Resolution Context
├── subject
├── state
├── cause / reason
├── dependency target
├── consumer role
└── conflict / cycle context

Relation Context / Graph semantics
├── source
├── target
├── relation_type
└── ...
```

Next question:

> Can `dependency target` have independent semantic necessity specifically as an internal Resolution Context attribute, or does its semantics belong entirely to the Relation / Edge connecting Resolution instances?

Do not assume the C-1.6-T2 graph-edge classification is automatically correct; test `dependency target` independently.

Do not formalize the final minimum Context Contract yet. Continue testing the remaining candidates and their semantic level one at a time.

Do not jump to a final Architecture Decision between Model A and Model B.

## Things not to redo

- Do not restart the broad UNRESOLVED research pass.
- Do not redo U-1 through U-10 without a specific evidentiary reason.
- Do not repeat C-1.4-T1 or C-1.5-T1 unless a new concrete counterexample invalidates their bounded results.
- Do not formalize the Qwen taxonomy.
- Do not introduce generic dependency/precedence/authorization engines.
- Do not redesign the handoff mechanism.
- Do not extract the adversarial-review pattern into a formal reusable skill/workflow yet.
- Do not treat Qwen's qualitative usability recommendations as benchmark evidence.

## Recommended starting context for next chapter

Use this provisional frame for C-1.6:

```text
CANDIDATE RESOLUTION CONTEXT

subject
state
cause / reason
dependency relation
dependency target
consumer role
conflict / cycle context
```

Do **not** assume every item in this list is independent or mandatory.

For each candidate axis, ask:

> Can two otherwise identical Resolution instances differ only in this axis and thereby require different downstream semantic behavior?

If no minimal counterexample can be found, provisionally classify the axis as derived/reconstructable or as a consequence/rule rather than an independent Context axis.

If a counterexample is found, minimize it and verify that the distinction is not already encoded in another retained field.

Primary discriminator for future adversarial tests:

> Can two instances that both expose `UNRESOLVED` have the same currently represented orthogonal context yet still require different downstream semantic behavior?

If yes, identify the missing intrinsic semantic distinction and test whether that distinction genuinely belongs in state rather than context/rules. If no, Model B remains viable for that case, while the architecture still must solve context preservation and rule/policy organization.

### C-1.6-T3 — `dependency target`

C-1.6-T3 tested whether `dependency target` has independent semantic necessity as an internal Resolution Context attribute, or whether its semantics belong to the relationship between Resolution instances.

Qwen returned:

```
B — no independent semantic necessity demonstrated
(as an internal Resolution Context attribute)
```

No minimal counterexample was found in which changing only `dependency target` required different downstream semantic behavior that could not be expressed through the relation, target Resolution semantics, or consumer policy.

Working classification:

```
dependency target
→ semantically necessary relationship information
→ relationship-level / graph-edge semantics
→ not an independent internal Resolution Context axis
```

Important qualification:

```
semantic necessity of relationship information
≠
necessity to store it inside Resolution
```

The result does not establish a final graph architecture and does not prove that target information can never be denormalized for implementation reasons. It establishes only that independent semantic ownership inside the source Resolution was not demonstrated.

### C-1.6-T3 semantic ownership refinement

A useful distinction emerged during review:

```
target identity
≠
independent Resolution property
```

but:

```
target identity
=
semantically significant parameter of the Relation
```

For example:

```
A ──depends_on──▶ B
```

and:

```
A ──depends_on──▶ C
```

are different relations even when source and relation type are otherwise equal. The difference belongs to relationship semantics, not to an intrinsic target field of the source Resolution.

This remains a provisional semantic classification, not an Architecture Decision.

### C-1.6-T4 — `consumer role`

C-1.6-T4 tested whether `consumer role` has independent semantic necessity as an internal Resolution Context axis, or whether it belongs to evaluation/consumer context.

Qwen returned:

```
B — no independent semantic necessity demonstrated
(as an internal Resolution Context axis)
```

No minimal counterexample was found.

The strongest attacks were the same-Resolution/different-consumer and multi-consumer cases. A single Resolution can be evaluated by multiple consumers with different roles without changing the Resolution's own semantic state. Therefore a single intrinsic `consumer role` field creates an ownership ambiguity.

Working classification:

```
consumer role
→ evaluation-context information
→ consumer-policy input
→ possibly relationship-level semantics between Resolution and Consumer
```

The exact ownership boundary between Consumer, Evaluation Context, and a possible Consumer-Resolution Relation remains unresolved. The test does NOT establish that `consumer role` must be implemented as a graph edge.

### C-1.6-T4 semantic boundary

T4 reinforces:

```
Resolution semantics
    ≠
evaluation context
    ≠
consumer policy
    ≠
consumer consequence
```

A useful provisional model is:

```
Resolution
    │
    ▼
Evaluation Context
    ├── consumer
    ├── role
    └── policy
    │
    ▼
consumer consequence
    │
    ▼
effective outcome
```

This is a research model only and does not establish a final implementation architecture.

### C-1.6-T5 — `applicability / applicability condition`

T5 has been commissioned as the next adversarial test. The Qwen response is pending.

Research question:

> Is `applicability condition` independently necessary semantic information belonging to the Resolution itself, or can applicability be represented as evaluation context, consumer policy, relationship semantics, eligibility logic, authority/authorization logic, external-context predicates, or another semantic level without loss of meaning?

The test must distinguish:

```
applicability
eligibility
authority
authorization
consumer role
consumer policy
```

and search specifically for the smallest counterexample showing semantic information loss if applicability condition is not an intrinsic Resolution Context axis.

Required attack areas:

- applicability vs eligibility;
- applicability vs consumer role;
- applicability vs consumer policy;
- external context;
- conditional applicability;
- subject-specific applicability;
- temporal applicability;
- applicability vs authority/authorization;
- applicability vs eligibility pipeline position;
- reconstructability;
- multi-consumer / multi-subject applicability;
- definition-level ownership.

No result has been adopted yet. No Architecture Decision has been made.

### C-1.6 interim candidate map after T4

Current provisional semantic map:

```
Resolution Context
├── subject
├── state
├── cause / reason
└── conflict / cycle context

Relation Context / relationship semantics
├── source
├── target
├── relation_type
└── ...

Evaluation / Consumer Context
├── consumer
├── consumer role
├── policy
└── ...

Derived consumer result
└── consumer consequence
```

This map is intentionally provisional. It does not establish that every remaining Resolution Context element is independently necessary, nor that every relationship must be implemented as a graph edge.

The current research question is increasingly about semantic ownership and minimumity rather than simply collecting fields.

## C-1 research checkpoint

```text
C-1.4 — origin
STATUS
- No semantic-necessity counterexample found.
- origin is currently excluded from the candidate minimum Context Contract.
- origin may be derived/reconstructed when needed.
- This remains a Working Decision, not a final Architecture Decision.

C-1.5 — provenance
STATUS
- No semantic-necessity counterexample found by Qwen 05AB.
- Tested source-sensitive, consumer-policy, and dependency-reconstruction attacks.
- Rejected counterexamples either collapsed into other fields or required new policies not currently defined.
- provenance is not currently demonstrated as an independent Context axis.
- This remains a Working Decision, not a final Architecture Decision.

C-1.6-T1 — consumer consequence
STATUS
- No semantic-necessity counterexample found by Qwen 05AB.
- Eligibility, candidate effect, effective outcome, authority/precedence, consumer-role, and definition-level derivation attacks were tested.
- consumer consequence is currently classified as a derived semantic result / consumer-policy output.
- It is not currently demonstrated as an independent Resolution Context axis.
- This remains a Working Decision, not a final Architecture Decision.

INTERIM SYNTHESIS
- origin, provenance, and consumer consequence have each failed to demonstrate independent semantic necessity in their bounded tests.
- C-1.6-T2 additionally found no independent semantic necessity for dependency relation as an internal Resolution Context axis.
- dependency relation is currently classified as semantically necessary relationship / graph-edge information rather than an intrinsic Resolution property.
- The remaining internal candidate set is provisionally reduced to subject, state, cause/reason, dependency target, consumer role, and conflict/cycle context.
- The relation-level model remains provisional and does not constitute a final graph architecture decision.

C-1.6-T2 — dependency relation
STATUS
- No semantic-necessity counterexample found by Qwen 05AB for dependency relation as an internal Resolution Context axis.
- dependency relation is currently classified as relationship / graph-edge semantics.
- This does not mean dependency relation is semantically unnecessary; it means its semantic necessity belongs to the relationship between Resolution instances rather than to the internal state/context of one Resolution.
- dependency target remains under separate test in C-1.6-T3.
- This remains a Working Decision, not a final Architecture Decision.

NEXT
- Continue C-1.6 with C-1.6-T3 — dependency target.
- Test whether dependency target is an independent Resolution Context axis or another relation/edge-level property.
- Keep the final minimum Context Contract provisional until the candidate-by-candidate pass is complete.
```

## C-1.6-T2 handoff checkpoint

```
COMPLETED
- C-1.6-T2 — dependency relation
- No independent semantic-necessity counterexample found for dependency relation as an internal Resolution Context axis.
- dependency relation is currently classified as relationship / graph-edge semantics.
- This is a semantic-level classification, not a final implementation/graph architecture decision.

REMAINING
- dependency target
- consumer role
- conflict / cycle context
- subject / state / cause and their exact minimumity/independence
- final minimum Resolution Context contract

NEXT
- C-1.6-T3 — dependency target
- Test target independently using the same semantic-necessity burden of proof.
```

## Final Synthesis-1 status

```text
WHAT WE KNOW
- No U-1…U-10 case demonstrated necessary semantic information loss in Model B.
- The tested distinctions can currently be represented as state + orthogonal context.
- C-1.4-T1 found no independent semantic necessity for origin.
- C-1.5-T1 found no independent semantic necessity for provenance in the tested scenarios.
- C-1.6-T1 found no independent semantic necessity for consumer consequence; it is currently classified as a derived consumer-policy result.
- Across C-1.4 through C-1.6-T1, distinct concepts have not automatically justified promotion to independent semantic axes.
- Complexity is relocated, not eliminated, by choosing a representation.

WHAT WE DO NOT KNOW
- Whether Model B remains maintainable and inspectable at full rule/policy scale.
- Whether a future case will demonstrate an intrinsic semantic subtype requirement.
- The final minimum context contract and rule/policy organization.
- Whether any remaining candidate context axis is itself derived/reconstructable.
- Whether the remaining candidate set mixes different semantic levels.

RECOMMENDED NEXT STEP
- Continue C-1.6 remaining-context minimality.
- Examine the remaining candidate set for semantic-level mixing.
- Test remaining candidate axes one at a time using the same semantic-necessity burden of proof.
- Keep Model A vs Model B formally undecided.
- Commission further adversarial tests only when they target a concrete remaining uncertainty.
```

## Bootstrap continuation

This chapter was initialized from **AIP Mirror — 03AH — Architecture & Research**.

Bootstrap state:

- Previous handoff: `03AH`
- Current handoff: `03AI`
- Status: `DRAFT`
- C-1.6-T3 adversarial instruction is already prepared.
- The next expected research input is the Qwen 05AB response to C-1.6-T3.

No final Architecture Decision has been made.

## Handoff readiness

This chapter remains **DRAFT** while C-1.6-T3 is being analyzed.
