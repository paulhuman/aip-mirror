# Agnostic AI Project-Instruction Architecture

**Status:** Architecture baseline / north-star document  
**Purpose:** Canonical description of the project-agnostic AI instruction architecture being developed and validated through AIP Mirror.  
**Repository:** paulhuman/aip-mirror  
**Primary role:** Bootstrap-level architectural context for future AI agents and ordinary ChatGPT conversation chapters.

---

## 1. Purpose and North Star

This document describes the **project-agnostic AI project-instruction architecture** being developed through the AIP Mirror project.

The actual meta-project goal is:

> **Create an agnostic project-instruction architecture that allows AI — both as an agent and as an ordinary chat chapter — to reliably work with Rules, Skills, Workflows, and project state, automatically and through explicit user commands, with minimal additional cognitive load on both the human and the AI.**

AIP Mirror is the first serious validation project for this architecture. It is **not the final purpose of the meta-architecture**.

The distinction is fundamental:

    AGNOSTIC AI PROJECT-INSTRUCTION ARCHITECTURE
                       /       |       \
                      /        |        \
                  Rules      Skills    Workflows
                    |           |          |
                    +-----------+----------+
                                |
                           Project state
                                |
                      Handoff / lifecycle
                                |
                           Observability
                                |
                  +-------------+-------------+
                  |                           |
             AI agent                ordinary chat chapter
                  |                           |
                  +--------- AIP Mirror -------+
                         validation project

The architecture exists to make AI-assisted work **more reliable with less cognitive overhead**, not to create an elaborate framework that the AI must manually operate before every ordinary task.

---

## 2. The Core Design Problem

An AI project accumulates many kinds of durable instructions and state:

- policies and constraints;
- reusable capabilities;
- ordered procedures;
- project architecture;
- technical decisions;
- research findings;
- references and evidence;
- conversation migration state;
- durable lessons and memory;
- observability information.

Without structure, the AI may:

- forget an important rule;
- apply an irrelevant rule;
- fail to discover a relevant skill;
- repeat research;
- lose project state during chapter migration;
- misunderstand the authority of a reference;
- forget a lifecycle transition;
- overload the conversation with meta-management;
- or lose the overall purpose while concentrating on a narrow local problem.

The architecture therefore has two simultaneous goals:

1. **Increase reliability.**
2. **Reduce the amount of reliability work that the AI and human must perform manually.**

These goals are inseparable.

A system that requires the AI to manually execute a long checklist for every small task is not a successful architecture, even if its semantic model is internally elegant.

For example, this must **not** become the default procedure for a simple request such as:

    "add a new function"

followed by:

    discover rules
    → classify rule
    → resolve applicability
    → activate skills
    → resolve precedence
    → resolve dependencies
    → inspect trace
    → update memory
    → validate lifecycle
    → ...

If ordinary work requires that sequence explicitly every time, the architecture has transferred its own management burden onto the AI and the human.

That is an architectural failure.

---

## 3. Cognitive-Load Principle

The central operational principle is:

> **The meta-architecture must reduce cognitive load on ordinary chat chapters rather than transfer the burden of managing the meta-architecture onto them.**

This applies to both AI and humans.

### 3.1 Ordinary chapters are not miniature agents

An ordinary ChatGPT chapter may have:

- finite context;
- no repository automation;
- limited operational tools;
- a human actively participating in the work;
- a narrow project objective.

It must therefore not be expected to behave like a fully autonomous orchestration engine.

The architecture should provide the chapter with the **right context at the right time**, rather than requiring the chapter to understand and administer the whole instruction framework.

### 3.2 Complexity must be lazy

Instruction-system complexity should be activated progressively.

A useful default principle is:

    simple task
        ↓
    minimal relevant context
        ↓
    perform task

and only when necessary:

    task requires special procedure
        ↓
    activate relevant skill/workflow

and only when necessary:

    real conflict / ambiguity / architectural decision
        ↓
    activate deeper resolution machinery

The architecture should therefore prefer:

- automatic discovery;
- scoped applicability;
- lazy activation;
- sensible defaults;
- explicit escalation;
- durable state;
- automatic lifecycle handling where possible;
- manual repair when automation fails.

It should avoid making every mechanism mandatory for every task.

### 3.3 Cognitive load is an architecture criterion

Cognitive load is not proof of semantic correctness.

A semantically correct design can still be operationally poor if it requires excessive reasoning or bookkeeping.

Conversely, a simple representation cannot be accepted merely because it is easier to process if it loses necessary semantics.

Therefore semantic research and architecture evaluation must keep these questions distinct:

- Is the model semantically correct?
- Is it sufficiently expressive?
- What cognitive load does it impose on AI?
- What cognitive load does it impose on humans?
- What operational machinery does it require?
- Is it project-agnostic?
- Can it be observed and debugged?
- Can it be maintained as the project grows?

No single one of these criteria should silently replace the others.

---

## 4. Two Execution Environments

The architecture must support at least two fundamentally different consumers.

### 4.1 AI agents

An AI agent may have:

- repository access;
- file operations;
- Git operations;
- larger working context;
- more autonomous execution;
- richer tooling.

The architecture may expose more automation to this environment.

### 4.2 Ordinary chat chapters

A chapter may have:

- finite conversation context;
- human-guided operation;
- partial repository access;
- fewer automation capabilities;
- a focused local objective.

The architecture must remain usable here without requiring the chapter to become an administrator of the meta-system.

### 4.3 Same architecture, different execution surface

The underlying concepts should remain compatible:

                    shared instruction architecture
                            /            \
                           /              \
                        agent          chat chapter
                           |              |
                     richer execution   lighter execution

The implementation surface may differ. The conceptual model should not fork into unrelated systems.

---

## 5. Automatic and Manual Modes

The architecture requires **both automatic operation and explicit human control**.

### 5.1 Automatic mode

The AI should be able to:

- discover relevant instructions;
- determine whether they apply;
- activate necessary capabilities/procedures;
- preserve durable state;
- perform lifecycle transitions;
- emit useful observability information;
- warn when a process has become unreliable or ambiguous.

Automation exists to reduce routine cognitive work.

### 5.2 Manual mode

The human must be able to explicitly invoke the same durable mechanisms when needed.

Examples include commands analogous to:

    /handoff update
    /handoff migrate

The exact command vocabulary is implementation-specific, but the architectural requirement is not:

> **Any important automated lifecycle mechanism should have a deliberate human-repair / human-invocation path where practical.**

Manual control is especially important when:

- automation failed;
- the AI forgot a lifecycle step;
- the user wants an explicit checkpoint;
- the user wants to force migration;
- a state transition needs correction;
- the human wants to inspect or repair the durable project state.

Manual commands are not a substitute for automation. They are the recovery and control surface.

---

## 6. Rules, Skills, Workflows, References, Memory

The architecture must preserve semantic distinctions between instruction categories.

### 6.1 RULE

A Rule expresses a constraint, invariant, policy, or authority-bearing instruction.

Examples:

- repository safety requirements;
- project boundaries;
- lifecycle invariants;
- prohibited operations;
- required verification steps.

A Rule is not merely information.

### 6.2 SKILL

A Skill describes a reusable capability or methodology.

Examples:

- deep understanding;
- commit-message formulation;
- a repeatable research method;
- a specialized technical procedure.

A Skill describes **how to perform a kind of work**, rather than merely stating a project constraint.

### 6.3 WORKFLOW

A Workflow describes an ordered procedure.

For example, conversation bootstrap is semantically a workflow even if the repository physically stores its definition under a Skill directory.

This distinction is important:

> Physical file location does not by itself determine semantic category.

### 6.4 REFERENCE

A Reference is evidence or source material.

Examples:

- SDK documentation;
- external repositories;
- research papers;
- manuals;
- test data.

Reading a Reference does not automatically grant it authority over project rules.

This principle also applies to references preserved in handoffs.

### 6.5 MEMORY

Memory is durable knowledge, lessons, context, or project state intended to survive beyond one local conversation.

Memory is not automatically an instruction.

The architecture must avoid turning every durable fact into an authority-bearing rule.

### 6.6 HANDOFF

A Handoff is a conversation-state transfer mechanism.

It preserves the state required for a later chapter to continue without depending on the full old conversation.

A handoff is therefore durable project state, not merely a summary.

### 6.7 TRACE

TRACE is an observability layer.

It can expose:

- what was discovered;
- what was applied;
- what was checked;
- what lifecycle transition occurred;
- where a warning or ambiguity appeared;
- what operation was performed.

TRACE is **not an authority source** and must not become a second source of truth.

---

## 7. Applicability, Activation, Authority, Precedence

These concepts must remain separate.

### Applicability

Does an instruction potentially apply to the current task or state?

### Activation

Has the instruction actually been brought into the active reasoning context?

### Authority

Does the instruction have the right to constrain the current decision?

### Precedence

If multiple applicable authoritative instructions conflict, which one governs?

These are different questions.

In particular:

    specificity ≠ authority
    authority ≠ precedence
    applicability ≠ activation
    automatic discovery ≠ mandatory activation

A future formal model must not collapse these distinctions merely for implementation convenience.

---

## 8. Progressive Instruction Resolution

The architecture should not assume that every task requires every layer.

A conceptual resolution ladder is:

    1. route / discover relevant context
    2. determine applicability
    3. activate only what is needed
    4. resolve authority or conflict if necessary
    5. perform the task
    6. validate only the relevant lifecycle/state invariants
    7. preserve durable state when warranted
    8. expose useful trace information

This is **not a mandatory checklist for every task**.

It is an architectural decomposition of concerns.

A trivial task may only need a small subset.

A high-risk repository mutation may need most of it.

An architectural conflict may legitimately activate much more machinery.

The system should decide this incrementally rather than imposing maximum procedure by default.

---

## 9. Failure Resistance

A major purpose of the architecture is to make common AI mistakes **less likely**.

This is deliberately stronger than merely documenting the correct procedure.

For example, if the handoff lifecycle requires:

    new chapter
        ↓
    create own DRAFT

and later:

    receiving chapter
        ↓
    previous READY_FOR_HANDOFF → HANDED_OFF

then the system should be designed so that these transitions are difficult to forget.

Likewise, when a newer chapter reaches the relevant lifecycle point:

    older HANDED_OFF → SUPERSEDED

should be handled reliably rather than relying only on the model remembering the rule in a long conversation.

The architecture therefore favors:

- canonical procedures;
- explicit state;
- narrow entry points;
- automatic transitions where feasible;
- validation at meaningful boundaries;
- observable lifecycle events;
- manual repair commands;
- durable state outside the conversation.

The goal is not zero failure.

The goal is:

> **make important failures less probable and make recovery explicit and reliable when they occur.**

---

## 10. Conversation Handoff and Lifecycle

Conversation context is finite working memory.

The repository is durable project memory.

A handoff therefore exists to transfer **state**, not merely prose.

The intended lifecycle is:

    DRAFT
      ↓
    READY_FOR_HANDOFF
      ↓
    HANDED_OFF
      ↓
    SUPERSEDED

The lifecycle retains history.

### 10.1 New chapter

A new chapter creates its own handoff in DRAFT as part of bootstrap.

It should not wait until ordinary work begins.

### 10.2 Receiving chapter

The receiving chapter is responsible for recognizing the previous chapter's transfer state and moving the previous handoff from READY_FOR_HANDOFF to HANDED_OFF where required.

### 10.3 Supersession

When a newer handoff of the same specialization reaches the appropriate transfer state, the older HANDED_OFF handoff becomes SUPERSEDED.

Historical state remains preserved.

### 10.4 Handoff is not the whole architecture

Handoffs preserve local research state very effectively, but they do not replace the project's top-level purpose.

This distinction is critical.

    north-star architecture
            ↓
    project purpose / global constraints
            ↓
    specialization context
            ↓
    chapter state / handoff
            ↓
    current task

The bootstrap must establish the upper layers before dropping into local research state.

---

## 11. Bootstrap as Context Restoration

Bootstrap is not merely administrative initialization.

Its deeper purpose is **context restoration**.

A new chapter can lose the forest for the trees if it receives only a narrow handoff.

Therefore bootstrap should eventually establish, in compact form:

1. What the meta-architecture is.
2. Why it exists.
3. What AIP Mirror's role is within it.
4. What global constraints matter.
5. What instruction mechanisms exist.
6. What the current specialization is.
7. What the current handoff state is.
8. What the immediate task is.

The canonical north-star document is intended to become a stable bootstrap input so that future chapters do not have to reconstruct the meta-project's purpose from old conversations.

---

## 12. Project-Agnosticity

The architecture is explicitly **project-agnostic**.

AIP Mirror is a validation project.

A useful test is:

> **Could this instruction or mechanism be transferred to a completely unrelated software project without changing its underlying meaning?**

This test distinguishes:

### CORE

Concepts that belong to the reusable architecture itself.

Examples:

- Rule / Skill / Workflow distinction;
- applicability versus activation;
- handoff lifecycle;
- manual recovery;
- TRACE as observability;
- cognitive-load principle.

### PROJECT-SPECIFIC

Concrete material belonging to a particular project.

Examples:

- Illustrator SDK rules;
- FreeHand behavior;
- AIP Mirror repository identity;
- JSX prototype requirements.

### ADAPTABLE

Reusable mechanisms whose concrete configuration differs by project.

Examples:

- chapter naming;
- repository paths;
- project-specific rule scopes;
- lifecycle configuration;
- bootstrap references.

Project-agnosticity does not mean every file must be literally identical between projects.

It means the underlying architecture must remain transferable.

---

## 13. AIP Mirror's Role

AIP Mirror is the first serious test case for the architecture.

Its role is to expose whether the meta-architecture works under real conditions:

- multiple specializations;
- multiple conversation chapters;
- repository-backed state;
- research-heavy work;
- implementation work;
- external references;
- handoffs;
- AI instructions;
- lifecycle transitions;
- human intervention;
- architectural uncertainty.

The project should therefore be treated as both:

1. a real Illustrator plugin project; and
2. a validation environment for the agnostic instruction architecture.

The second role must not erase the first.

The meta-architecture should serve the project, not consume it.

---

## 14. Current AIP Mirror Workstream Model

The current project has four complementary specializations.

### 01 — JSX Prototype

Behavioral prototype and rapid experimentation.

Purpose:

- discover interaction;
- test geometry;
- validate UX;
- reproduce FreeHand-like behavior;
- establish expected behavior before native implementation.

The JSX prototype is a behavioral reference, not the final native architecture.

### 02 — Native AIP Plugin

Production-oriented C++ / Illustrator SDK implementation.

Purpose:

- native Illustrator integration;
- interactive mirror tool;
- mouse/input handling;
- live preview;
- object/path manipulation;
- undo/cancel behavior;
- plugin lifecycle;
- native UI where required.

The first native milestone intentionally favors a simple native UI such as ADM rather than introducing unnecessary web technologies.

### 03 — Architecture & Research

Shared architectural and research space.

Purpose:

- reverse engineering;
- architecture;
- specification;
- FreeHand research;
- Illustrator SDK research;
- cross-workstream decisions;
- technology boundaries;
- semantic research.

### 04 — Project Workshop

Practical support and learning.

Purpose:

- IDE;
- CMake;
- compiler/toolchain;
- Git mechanics;
- SDK setup;
- ChatGPT workflow;
- development-environment debugging;
- routine technical questions.

It is a support space, not a competing implementation stream.

---

## 15. Repository as Durable State

The repository is the durable technical memory of the project.

Conversation history is temporary working context.

Important durable information should therefore be recorded in version-controlled files, including:

- architecture;
- specifications;
- research conclusions;
- assumptions;
- validated behavior;
- important references;
- lifecycle state;
- handoffs;
- AI workflow instructions.

However, this does **not** mean every conversation sentence should be persisted.

The system should preserve information according to its durable value.

---

## 16. Repository Safety as a Reliability Pattern

AIP Mirror has an explicit repository safety rule for API-backed writes.

When modifying an existing file:

    READ CURRENT FILE
            ↓
    minimal intended change
            ↓
    WRITE COMPLETE FILE
            ↓
    READ BACK
            ↓
    VERIFY intended change
            ↓
    VERIFY unrelated content preserved
            ↓
    INSPECT DIFF
            ↓
    VERIFY SCOPE
            ↓
    COMMIT
            ↓
    VERIFY RESULT

A successful API write is not evidence that the file is correct.

A valid blob SHA is not evidence that the file is correct.

A valid Git commit is not evidence that the file is correct.

Content integrity must be independently verified.

This is a concrete example of the wider meta-architecture principle: **reliability should be enforced by workflow structure rather than left entirely to model memory.**

---

## 17. Observability / TRACE

TRACE exists so that important system behavior can be inspected without making the entire instruction system part of the user's cognitive workload.

Useful trace events may include:

- READ — relevant instruction/reference read;
- APPLY — instruction applied;
- CHECK — invariant or condition checked;
- WARNING — ambiguity or risk detected;
- HANDOFF — lifecycle operation;
- COMMIT — repository state operation.

The exact vocabulary can evolve.

The architectural requirement is:

> Observability should explain important system actions without becoming another authority system.

TRACE should answer questions such as:

- What did the AI use?
- Why was a procedure activated?
- What lifecycle transition occurred?
- Where did a warning originate?
- What was checked?

It should not become a second place where rules are defined.

---

## 18. Consistency and Change Propagation

A mature instruction architecture must account for the fact that changing one instruction can affect others.

A future consistency mechanism should be able to detect:

- contradictions;
- stale references;
- broken assumptions;
- lifecycle inconsistencies;
- cascading changes.

A consistency-pass capability/workflow has therefore been considered as a reusable mechanism.

It should be used selectively, not automatically for every trivial edit.

---

## 19. Semantic Research Is a Subsystem, Not the North Star

The architecture has a separate semantic research program.

That research is valuable because the instruction system eventually needs reliable semantics for relationships, states, conflicts, dependencies, and resolutions.

However:

> **Semantic-model research is subordinate to the practical purpose of the meta-architecture.**

The project must not lose its overall purpose merely because a difficult semantic question is being investigated.

The correct hierarchy is:

    meta-architecture purpose
            ↓
    instruction-system reliability
            ↓
    semantic model where required
            ↓
    specific research tests

Not:

    semantic research
            ↓
    everything else

This distinction is especially important for future chapter bootstrap.

---

## 20. Current Semantic Research State

The semantic research currently uses an adversarial bounded-test methodology:

    Qwen / independent review
            ↓
    architect-side counterargument
            ↓
    synthesis
            ↓
    next bounded test

Qwen is an independent adversarial reviewer, not an authority. Final architectural decisions belong to the project/human decision process.

### 20.1 Research discipline

Each test should distinguish:

- stipulated behavior;
- semantic observations;
- inferences;
- candidate assumptions;
- missing evidence;
- pairwise distinguishability;
- conclusion strength.

Avoid promoting a plausible interpretation into an established architecture decision without sufficient evidence.

### 20.2 Current dependency research

The current research reached C-11.2, Conditional Guard Ownership Test.

The conservative accepted result is:

> **Y can affect applicability without changing apparent identity X; target-alone does not explain conditional applicability; B/C/D remain indistinguishable on current cases; A is not required, but not universally impossible.**

Here:

- A = target specification;
- B = dependency relation;
- C = governing rule of B;
- D = applicability/context;
- E = other.

C-11.2 was classified as:

> **Multiple semantically equivalent interpretations remain.**

The test did not establish:

- a new dependency type;
- semantic ownership of Y;
- a universal applicability/context mechanism;
- a universal target-expansion rule.

C-11.3 was proposed as a future Rule/Relation/Context Discrimination Test but was deliberately deferred to a later chapter.

### 20.3 Important non-conclusions

The following are explicitly **not established**:

- “The subject is intrinsically required.”
- unrestricted content as a universal semantic container;
- target specification as a universal semantic container;
- Resolution = {subject, state, cause/reason};
- Finding as a universal semantic entity;
- a separate Result referent;
- generic dependency engine;
- generic precedence engine;
- fixed-point semantics;
- typed UNRESOLVED taxonomy;
- three-valued logic merely because it appears convenient;
- graph implementation merely because semantic relationships exist.

Semantic necessity must not be confused with storage necessity.

Relationship semantics must not be confused with graph implementation architecture.

---

## 21. Current Resolution / Conflict Research Direction

A broader research direction has considered two models for unresolved semantic states.

### Model A

Typed semantic unresolved states, for example:

    UNRESOLVED_INSUFFICIENT_EVIDENCE
    UNRESOLVED_CONFLICT
    UNRESOLVED_CYCLE
    ...

### Model B

A single semantic state:

    UNRESOLVED

with orthogonal metadata/context explaining why it remains unresolved.

The important methodological conclusion is:

> Complexity is relocated, not eliminated.

Model A places complexity in the taxonomy.

Model B places more complexity in contextual/rule reasoning.

Simple processing-step counts are not evidence that one model is objectively better.

This remains a research question, not a settled architecture decision.

---

## 22. Dependency and Pipeline Research

The research has also explored a conceptual pipeline:

    eligibility
        ↓
    conflict detection
        ↓
    explicit precedence
        ↓
    governing candidate
        ↓
    candidate effect
        ↓
    effective outcome

Important qualifications:

- dependency is not necessarily a pipeline stage;
- dependency may be a relationship between semantic pipeline instances;
- “decision-source prerequisite → eligibility” was found to be too strong as a universal formulation;
- a decision-source relationship can reference the semantic result of another process;
- the consumer's role determines how that result is used;
- candidate-level precedence is not yet formally established.

This work remains research.

---

## 23. Explicit Research Restraint

The architecture must resist the temptation to turn every unresolved research question into infrastructure.

In particular, do not prematurely introduce:

- universal dependency engines;
- universal precedence engines;
- generic graph frameworks;
- fixed-point computation;
- complex state taxonomies;
- generalized resolution objects;
- implementation architecture derived only from metaphor.

A bounded semantic test should remain bounded.

A failed hypothesis should not automatically be repaired by expanding the hypothesis until every counterexample fits.

---

## 24. Human Decision Authority

The meta-architecture supports human decision-making; it does not replace it.

The AI may:

- discover;
- compare;
- reason;
- identify conflicts;
- propose interpretations;
- perform defined procedures;
- report uncertainty;
- maintain project state.

The human remains able to:

- accept or reject architectural interpretations;
- invoke workflows manually;
- correct lifecycle state;
- override or revise project decisions;
- determine when a research question is sufficiently settled.

The architecture should make these decisions easier to exercise, not hide them behind automation.

---

## 25. Reliability Philosophy

The intended reliability model is not:

> “The AI will remember everything.”

It is:

> **Important behavior should be made structurally easier to perform correctly than incorrectly.**

This means:

- canonical entry points;
- explicit state;
- scoped instructions;
- reusable workflows;
- automatic routing where reliable;
- validation at boundaries;
- durable handoffs;
- observability;
- manual repair;
- minimal default cognitive load.

The architecture should tolerate imperfect AI memory.

That is a feature, not an embarrassment.

---

## 26. What the Architecture Must Avoid

The meta-architecture must not become:

### 26.1 A giant mandatory checklist

Every task must not trigger every subsystem.

### 26.2 A second programming language

The human should not need to learn an elaborate control language merely to make ordinary project progress.

### 26.3 A second source of truth

TRACE, handoffs, memory, and derived indexes must not silently compete with canonical project documentation.

### 26.4 A universal semantic engine before evidence exists

Semantic research must remain evidence-driven and bounded.

### 26.5 An agent-only system

Ordinary ChatGPT chapters are first-class execution environments.

### 26.6 A project-specific architecture disguised as a general one

AIP Mirror-specific details belong in project configuration or project documentation.

### 26.7 A burden shifted from AI to human

If the architecture requires the human to manually supervise every internal routing step, it has failed its cognitive-load objective.

---

## 27. Desired Operational Experience

For an ordinary task:

    User:
    "add a new function"

the desired experience is approximately:

    AI identifies relevant project context
            ↓
    AI performs the task using only the necessary instruction machinery
            ↓
    AI validates the relevant result
            ↓
    AI reports useful outcome / warning

The internal architecture may be sophisticated.

The user's experience should remain simple.

For a more complex task:

    User:
    "migrate this chapter"

the architecture should provide a dedicated workflow:

    explicit command / recognized intent
            ↓
    handoff workflow
            ↓
    state capture
            ↓
    lifecycle validation
            ↓
    new chapter bootstrap
            ↓
    context restoration

The complexity belongs primarily **inside the workflow**, not in the user's mental checklist.

---

## 28. Design Rule: Put Complexity Behind Interfaces

A general architectural principle follows:

> **Complexity should be implemented behind stable, small interfaces whenever possible.**

For the instruction architecture, the important interfaces are conceptually:

    task
     ↓
    routing
     ↓
    relevant context
     ↓
    capability / workflow
     ↓
    result
     ↓
    state update

The user should not need to know every internal stage.

Manual commands provide explicit control without requiring internal implementation knowledge.

This principle is especially important for ordinary chat chapters.

---

## 29. Future Architecture Work

The following areas remain open for future design:

1. Canonical machine-readable configuration.
2. Formal rule-scope representation.
3. Automatic versus explicit activation semantics.
4. Conflict and precedence representation.
5. Dependency representation.
6. Consistency-checking workflow.
7. TRACE format and display policy.
8. Memory boundaries.
9. Manual command vocabulary.
10. Bootstrap contract.
11. Agent versus chapter capability negotiation.
12. Failure recovery semantics.
13. Project-agnostic packaging.
14. Migration and lifecycle automation.
15. Minimal cognitive-load evaluation methodology.

These should be developed incrementally.

No future component should be introduced merely because the architecture diagram has a conceptual box for it.

---

## 30. Proposed Evaluation Criteria

When evaluating a candidate architecture, assess at least:

### Semantic correctness

Does it represent the intended meaning without unsupported assumptions?

### Expressiveness

Can it represent the required project situations?

### AI cognitive load

How much additional reasoning/bookkeeping does it impose on AI?

### Human cognitive load

How much additional work must the user perform?

### Operational complexity

How much infrastructure and procedure is required?

### Project agnosticity

Can the architecture transfer to unrelated projects?

### Reliability

Does it make important failures less likely?

### Recoverability

Can the human repair important failures explicitly?

### Observability

Can important behavior be understood and debugged?

### Maintainability

Can the architecture evolve without becoming self-defeating?

These are evaluation dimensions, not automatic scoring rules.

---

## 31. Architecture Invariants

The following principles should be treated as high-level invariants unless explicitly revised:

1. The architecture is project-agnostic.
2. AIP Mirror is a validation project, not the final purpose.
3. Both AI agents and ordinary chat chapters are supported.
4. Ordinary chapters must not carry unnecessary meta-system cognitive load.
5. Automatic and manual operation both exist.
6. Important automated behavior should have a practical recovery path.
7. Rules, Skills, Workflows, References, Memory, Handoffs, and TRACE are conceptually distinct.
8. Applicability, activation, authority, and precedence are distinct concepts.
9. TRACE is observability, not authority.
10. Repository state is durable project memory.
11. Conversation context is temporary working context.
12. Handoffs preserve chapter state across finite contexts.
13. Bootstrap restores global context before local task context.
14. Semantic research remains bounded and evidence-driven.
15. Semantic necessity must not be confused with storage necessity.
16. Relationship semantics must not be confused with graph implementation.
17. Complexity should be activated progressively rather than imposed universally.
18. Important reliability properties should be enforced structurally where possible.
19. Human authority over project decisions remains explicit.
20. The meta-architecture must serve project work rather than become the project's main workload.

---

## 32. Relationship to Existing AIP Mirror Instructions

This document is a **meta-architecture anchor**.

It does not replace project-specific instructions such as:

- docs/PROJECT-INSTRUCTIONS.md;
- .ai/rules/*.md;
- .ai/skills/*/SKILL.md;
- docs/handoffs/*.md;
- project architecture/research documents.

Instead, it provides the higher-level context needed to understand why those mechanisms exist and how they should evolve.

Project-specific rules remain authoritative for their project-specific domains.

This document should be read as an architectural north star and bootstrap context, not as a universal replacement for scoped operational instructions.

---

## 33. Bootstrap Placement

Future bootstrap should conceptually establish context in this order:

    1. meta-architecture purpose
    2. execution-environment model
    3. project identity and role
    4. relevant global constraints
    5. instruction-system map
    6. current specialization
    7. current chapter handoff
    8. current task

The implementation may optimize this sequence for context efficiency.

The important property is that a chapter should not receive only narrow local state while losing the global reason the system exists.

---

## 34. Final North-Star Statement

The project is not trying to build the world's most sophisticated AI instruction engine.

It is trying to build a **reliable, transferable, low-overhead way for AI and humans to work together on real projects**.

The desired result is:

                     MORE RELIABLE AI WORK
                              +
                     LESS HUMAN BOOKKEEPING
                              +
                  LESS AI META-COGNITIVE OVERHEAD
                              +
                    EXPLICIT HUMAN CONTROL
                              +
                     DURABLE PROJECT STATE
                              +
                       PROJECT AGNOSTICITY

AIP Mirror is where these ideas are being tested under real pressure.

The architecture succeeds only if the machinery eventually becomes **quiet**: the user can work on the project, while the system quietly helps the AI discover the right instructions, execute the right workflow, preserve state, detect important failures, and recover when necessary.

That is the purpose of the meta-architecture.
