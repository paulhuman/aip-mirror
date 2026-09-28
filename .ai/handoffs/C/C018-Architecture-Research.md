# 03AS — Architecture & Research

## Chapter identity

- **Chapter:** 03AS
- **Specialization:** 03 — Architecture & Research
- **Previous chapter:** 03AR — Architecture & Research
- **Status:** HANDED_OFF

## Starting objective

Continue the architecture/research work from 03AR while preserving established context. The remaining project constraints have now been supplied and consolidated. The next task is to reduce the highest-leverage architectural uncertainty before selecting implementation structure.

## Bootstrap state

03AR is the direct predecessor and was verified as `READY_FOR_HANDOFF` at bootstrap.

The current repository model remains:

- `paulhuman/aip-mirror` on `main` is the canonical project repository.
- `docs/handoffs/` is temporary conversation context transfer.
- Durable project knowledge belongs in authoritative project documentation.
- Specialization 03 owns architecture, research, cross-workstream decisions, and project-wide architectural consistency.

## Current research context

03AR completed the bounded inspection of intentional-acceptance practice. No dedicated Acceptance entity or universal acceptance mechanism was introduced.

The historical semantic-trace direction remains paused.

The new owner constraints are now explicit:

1. The assistant is not a one-to-one command executor; the meta-system supports reasoning and work rather than replacing it with a rigid interpreter.
2. `rules/` and `skills/` should be maximally compact, clear, and unambiguous, containing execution-critical knowledge rather than redundant explanation.
3. Detailed rationale, history, examples, architecture explanation, and research context may live in Agents, README, docs, and handoffs.
4. The system should minimize data reread before an action while preserving complete understanding of the relevant process.
5. Compactness must not sacrifice semantic correctness.
6. The eventual meta-system must remain project-agnostic and reusable outside AIP Mirror.
7. Qwen and Grok are independent review inputs. They challenge the architecture but are not authority sources.

## Constraint → Problem Map

The bounded map is recorded in:

`docs/architecture/constraint-problem-map-03AS.md`

The map separates owner constraints from architectural problems and deliberately avoids choosing a registry, router, manifest, memory store, command syntax, or filesystem structure.

### Primary architectural uncertainty

> **What is the Minimal Execution Context: the smallest set of knowledge and state that must be available to the assistant for a given action to be performed correctly, without requiring a full reread of the project's instruction system?**

This is currently a semantic/operational research question, not an implementation commitment.

## Bounded MEC test: applicability selection

The first bounded MEC test inspected these existing instruction sources:

- `.ai/rules/conversation-lifecycle.md`
- `.ai/rules/workflow.md`
- `.ai/rules/repository.md`
- `.ai/rules/handoff-references.md`
- `.ai/skills/conversation-handoff/SKILL.md`
- `.ai/skills/conversation-handoff/BOOTSTRAP.md`

The test asked whether applicability can be determined cheaply enough to select MEC before loading a full instruction body.

### Findings

1. **Applicability is state-dependent.** Task intent alone does not always determine the applicable execution path.
2. **Document-level applicability is often cheap.** The task normally identifies the relevant instruction domain without loading the whole corpus.
3. **Section-level applicability is currently more expensive.** Conditional paths such as Lifecycle Recovery and Lifecycle Correction place their applicability conditions inside the execution body.
4. **Conditional execution knowledge should remain dormant.** Recovery, correction, read-only branches, and similar paths should not enter normal MEC unless their conditions are met.
5. **Current project state is a first-class applicability input.** Examples include current chapter identity, bootstrap state, handoff existence/status, detected lifecycle violation, capability, and explicit authorization.
6. **Instruction duplication is a separate compression problem.** `SKILL.md` and `BOOTSTRAP.md` currently duplicate substantial lifecycle/recovery/correction semantics. This increases rereading pressure and should eventually be addressed through a single authoritative execution source plus cross-references, but that is not yet an implementation change.

### Refined MEC model

```
MEC(action, state) =
    task / intent
  + applicable execution constraints
  + required current project state
  + required semantic/project knowledge
  + applicable conditional context
```

Applicability determination itself is part of the execution problem, but its input should be substantially smaller than the full instruction corpus if rereading is to be minimized.

## New architectural hypothesis from the owner

The owner proposed a possible **compact command/action index**:

- a short list of commands/actions available to the AI;
- a very short description of each;
- references to the relevant `rules/` and `skills/` sources;
- references ideally identifying the applicable sections of those sources;
- potentially load this compact index during bootstrap so the assistant knows what capabilities/actions are available;
- use it as an index when a user explicitly invokes an action from the list, while still allowing the assistant to reason rather than behave as a rigid one-to-one command interpreter.

This is a **research hypothesis, not an architecture decision**.

Its relevance to MEC is specific: such an index could provide a cheap applicability surface while keeping detailed execution knowledge dormant until needed.

The hypothesis must be tested against alternatives before any registry/router/manifest or command system is introduced.

## North-Star document assessment

`docs/architecture/ai-project-instruction-architecture.md` remains valuable context, but is now outdated as a clean current North-Star specification.

The bounded map identified concrete drift:

- command examples still use leading `/`;
- Memory is described as a standing architectural category without the current rejection of `.ai/memory/`;
- the document predates the explicit compactness requirement for `rules/` and `skills/`;
- the execution model does not explicitly formulate Minimal Execution Context;
- lifecycle wording contains historical supersession language inconsistent with the current lifecycle;
- current meta-system/project-boundary constraints are not integrated.

**Do not patch it yet.** First complete the Minimal Execution Context research; then deliberately update or replace the North-Star document from the resulting model.

## Independent review inputs

### Qwen

- `docs/architecture/independent-review-qwen-onboarding.md`
- Current observed Qwen handoff: `docs/handoffs/05AE-Independent-Review-Qwen.md`.
- The older `docs/architecture/independent-review-deepseek-onboarding.md` file is unrelated historical repository content and is not the Qwen onboarding source.

### Grok

- `docs/architecture/independent-review-grok-onboarding.md`
- Current observed Grok handoff: `docs/handoffs/06AA-Independent-Review-Grok.md`.

These remain review inputs, not authority sources. They should be consulted selectively when a bounded research question benefits from independent counterexamples or critique.

## Evidence / confidence

### Confirmed / observed

- Canonical repository/branch: `paulhuman/aip-mirror` / `main`.
- 03AR was `READY_FOR_HANDOFF` at bootstrap.
- Current lifecycle: `DRAFT → READY_FOR_HANDOFF → HANDED_OFF`.
- 03AR intentional-acceptance inspection is complete.
- No dedicated Acceptance mechanism was introduced.
- The owner has supplied the remaining compactness / execution-context / project-agnosticity constraints.
- The bounded Constraint → Problem Map has been created and read back successfully.
- The North-Star document is stale in the specific areas listed above.
- The bounded MEC applicability test has been completed on the six listed instruction sources.
- The test found state-dependent applicability, dormant conditional execution paths, and duplicated execution semantics.
- The owner has proposed a compact action/command index as a possible applicability surface.

### Inferred

- Minimal Execution Context is currently the highest-leverage uncertainty to reduce.
- The distinction between durable knowledge and active execution context is likely central to the eventual meta-system.
- A compact execution layer may be possible without turning the assistant into a rigid command interpreter.
- A compact action index may reduce the cost of applicability selection, but its sufficiency and optimal form are unverified.

### Assumed / unverified

- The final shape of the reusable meta-system.
- Whether any routing mechanism is necessary.
- Whether the proposed index is necessary or merely one possible solution.
- Whether an index should reference whole files, sections, IDs, or another semantic unit.
- Whether existing handoffs need replacement or extension.
- Whether a new filesystem boundary is needed.

### Open

- Exact definition of Minimal Execution Context.
- What an action can infer from current task/conversation state.
- What must be discovered from project state.
- What must be explicit in execution-critical instructions.
- What can remain explanatory-only.
- How missing execution context should be detected.
- What is the minimum information needed for cheap applicability selection.
- Whether a compact action index can provide that information without becoming a rigid command registry/router.
- How duplicated execution semantics should eventually be eliminated without losing semantic completeness.
- How independent review material can remain useful without becoming default execution context.

## Research boundary

Before introducing any implementation structure, determine:

1. what a representative action actually requires;
2. what can be inferred from the current conversation/task;
3. what must be discovered from project state;
4. what must be explicit in execution instructions;
5. what can remain explanatory-only;
6. what failure occurs when a required element is absent;
7. what minimum applicability information is required before loading detailed execution knowledge.

Do not create:

- `docs/meta/permanent/`;
- `docs/meta/temporary/`;
- `.ai/memory/`;
- a command registry;
- a command prefix;

merely to support this research.

Do not resume the historical semantic-trace work or launch a new C-series experiment merely because the current ideas are visible.

## Completed bounded test: Applicability Surface Test

Cases A/B/C compared:

1. task/state inference alone;
2. a minimal explicit applicability surface attached to execution knowledge;
3. a compact global capability index pointing to execution-critical sections.

The test established a useful separation:

### Capability discovery
**Question:** What capabilities are available, and where can their execution knowledge be found?

A compact capability surface can potentially answer this without becoming a router or semantic interpreter.

### Applicability determination
**Question:** What applies now, and which execution path is active?

This depends on a small applicability surface plus current project state. Conditional execution knowledge can remain dormant until its applicability condition is met.

### Execution
**Question:** How is the action performed correctly?

This still requires the applicable execution knowledge and the fresh project state needed by the action.

The resulting bounded model is:

    REASONING
        |
        +-----------------------+
        |                       |
        v                       v
CAPABILITY DISCOVERY      APPLICABILITY
        |                       |
compact capability        local applicability
   surface                    surface
        |                       |
        +-----------+-----------+
                    |
                    v
            EXECUTION KNOWLEDGE
                    |
                    + CURRENT STATE
                    |
                    v
                   MEC
                    |
                    v
                EXECUTION

The arrows represent knowledge availability/reasoning flow, not a mandatory programmatic pipeline.

### Bounded conclusion

A compact capability description has an independent potential role in capability discovery. This is distinct from applicability determination and execution.

The test does **not** establish that a separate physical global index is required. The capability-discovery function could be implemented by a different or more compact mechanism.

The test also does not establish a registry, router, manifest, command syntax, or universal metadata schema.

### Argument boundary

A capability description may identify required arguments, but it does not silently supply missing values. If the user gives an underspecified task such as “modify the existing file”, the assistant must resolve or ask for the missing target rather than having the capability surface guess it.

## Completed bounded test: Applicability as runtime reasoning result

Independent review by Grok and Qwen challenged the A/B/C boundary. The review surfaced two counterarguments: capability discovery and applicability may overlap when relevance is state-dependent; and treating applicability as a separate precondition/interface can create a circular dependency when the knowledge needed to evaluate that precondition exists only inside the execution body.

The bounded follow-up test evaluated three hypotheses: applicability as separate knowledge; applicability as a capability interface/gate; and applicability as a runtime reasoning result.

Current investigative model:

```
CAPABILITY KNOWLEDGE
        +
CURRENT STATE
        +
USER INTENT
        +
REASONING
        ↓
   APPLICABILITY
        ↓
 if applicable
        ↓
EXECUTION KNOWLEDGE
        ↓
       MEC
        ↓
    EXECUTION
        ↓
 NEW / OBSERVED STATE
        │
        └──────────► REASONING
```

This is an **investigative model, not an architecture, schema, or filesystem decision**.

Key conclusions:

1. Applicability is best treated as a reasoning result rather than a mandatory knowledge layer.
2. Reasoning may need additional knowledge before it can reach a sufficiently reliable applicability judgment. Execution knowledge therefore does not have to be downstream of an already-complete applicability decision.
3. Applicability may be refined iteratively as more relevant knowledge is obtained.
4. After execution, observed current state returns to reasoning. Normal execution, correction, and recovery can therefore be understood as alternative execution knowledge selected by reasoning against newly observed state, rather than requiring a separate deterministic recovery subsystem.
5. Current state remains distinct from instruction knowledge.
6. The earlier A/B/C separation remains useful as a distinction of functions, but it should no longer be treated as a mandatory three-stage pipeline or as proof of three persistent artefacts.
7. No global index, registry, router, manifest, command syntax, capability-ID scheme, universal metadata schema, .ai/memory/, or new filesystem boundary is justified by this result.

### Current semantic model

```
                 ┌─────────────────────┐
                 │ CAPABILITY KNOWLEDGE│
                 │                     │
                 │ what capabilities   │
                 │ exist / what they   │
                 │ are about / where   │
                 │ detailed knowledge  │
                 │ can be found        │
                 └──────────┬──────────┘
                            │
                            ▼
                     ┌────────────┐
                     │  REASONING │◄──── USER INTENT
                     └─────┬──────┘
                           ▲
                           │
                     CURRENT STATE
                           │
                           ▼
                    APPLICABILITY
                           │
                     "what applies?"
                           │
                           ▼
                  REQUIRED KNOWLEDGE
                           │
                           ▼
                          MEC
                           │
                           ▼
                       EXECUTION
                           │
                           ▼
                     OBSERVED STATE
                           │
                           └──────────► REASONING
```

The arrows represent semantic/information dependencies, not a mandatory programmatic pipeline.

### Important unresolved point

The bounded test does **not** prove that applicability can always be determined from capability knowledge + state + intent alone. Sometimes reasoning must obtain additional execution/project knowledge before reaching an applicability judgment.

The resulting open question is therefore not "where is the applicability artefact?" but:

> How does this reasoning-oriented model change the definition and boundary of Minimal Execution Context?

## Immediate next task for 03AT

Examine the consequences of the runtime-reasoning model for:

1. the definition of MEC;
2. P-01 Knowledge vs execution context;
3. P-02 Context discovery and applicability;
4. P-03 Compression boundary.

Do this before introducing implementation structure. In particular, determine whether the word **minimal** in MEC describes a static preselected context, a dynamically sufficient context at a reasoning moment, or something more precise.

Do not add another generic bounded case merely to generate more examples.

## Things not to redo

Do not repeat merely for migration:

- the 03AR intentional-acceptance inspection;
- C-13;
- C-14;
- C-12;
- C-11.11–C-11.15;
- the 03AP Semantic Source & Authority Audit;
- the 03AP Intentional Acceptance Audit;
- the 03AP Architectural Bottleneck Audit;
- the 03AP Architectural Bottleneck Cross-Audit;
- the Post-C-13 Architectural Leverage Audit;
- the completed 03AQ lifecycle cleanup.

Do not reintroduce `SUPERSEDED` into the current lifecycle.

## Recommended starting context

Already read during bootstrap:

- `docs/PROJECT-INSTRUCTIONS.md`
- `.ai/skills/conversation-handoff/BOOTSTRAP.md`
- `.ai/skills/conversation-handoff/SKILL.md`
- `.ai/rules/conversation-lifecycle.md`
- `.ai/rules/workflow.md`
- `.ai/rules/handoff-references.md`
- `.ai/skills/commit-message/SKILL.md`
- `docs/handoffs/03AR-Architecture-Research.md`

Additional research inputs now inspected selectively:

- `docs/architecture/ai-project-instruction-architecture.md`
- `docs/architecture/independent-review-qwen-onboarding.md`
- `docs/architecture/independent-review-grok-onboarding.md`
- `docs/architecture/independent-review-deepseek-onboarding.md` (historical leftover; not Qwen onboarding)
- `docs/handoffs/05AE-Independent-Review-Qwen.md`
- `docs/handoffs/06AA-Independent-Review-Grok.md`
- `docs/architecture/constraint-problem-map-03AS.md`
- `.ai/rules/conversation-lifecycle.md`
- `.ai/rules/workflow.md`
- `.ai/rules/repository.md`
- `.ai/rules/handoff-references.md`
- `.ai/skills/conversation-handoff/SKILL.md`
- `.ai/skills/conversation-handoff/BOOTSTRAP.md`

Further architecture documents should be read selectively according to the bounded research question. Do not reload the entire historical architecture corpus by default.

## Last completed task

03AS completed the A/B/C Applicability Surface Test, the independent Grok/Qwen boundary review, and the bounded follow-up test of applicability as runtime reasoning. The current research position is that applicability is best treated as a reasoning result that may be refined after obtaining additional knowledge, with observed post-execution state feeding reasoning again for normal, correction, or recovery paths. The next chapter should now examine what this does to MEC and P-01/P-02/P-03.

## Migration note

03AS is finalized as `READY_FOR_HANDOFF` for migration to 03AT.

The receiving chapter must create its own `docs/handoffs/03AT-Architecture-Research.md` as `DRAFT`, then perform the normal post-bootstrap verification and mark this handoff `HANDED_OFF`.

## Bootstrap note

This handoff remains a compact live checkpoint. It records the active research frontier and constraints without reproducing the accumulated architecture history.
