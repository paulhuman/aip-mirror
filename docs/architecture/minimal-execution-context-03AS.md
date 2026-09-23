# Minimal Execution Context — Bounded Analysis 03AS

**Status:** Research finding / not an Architecture Decision
**Scope:** First bounded analysis of representative AIP Mirror actions.

---

## 1. Research question

> What is the smallest set of knowledge and state that must be available to the assistant for a given action to be performed correctly?

The analysis deliberately separates:

- required execution knowledge;
- task/conversation state already available without reread;
- project state that must be discovered;
- optional explanatory context;
- conditional context required only when the action escalates.

---

## 2. Case A — Conversation handoff bootstrap

### Action
Initialize a new architecture chapter from the previous chapter.

### Required execution context
- bootstrap procedure applicable to the receiving chapter;
- current chapter identity and specialization supplied by the bootstrap message;
- canonical repository identity/path resolution;
- previous handoff and its lifecycle state;
- capability branch (write-capable vs read-only);
- the minimum project rules explicitly required by bootstrap;
- required post-bootstrap lifecycle verification.

### Already available from the task/conversation
- the requested migration parameters;
- the fact that this is a receiving chapter;
- user-supplied intent to initialize the chapter.

### Must be discovered from project state
- previous handoff contents/status;
- current repository state;
- files explicitly identified as current context by the previous handoff;
- write capability when not otherwise established.

### Conditional / escalation context
- Lifecycle Recovery procedure only if a qualifying pre-existing violation is detected;
- Lifecycle Correction only if a historical inconsistency is discovered and the separate authorization conditions apply;
- additional architecture documents only when required by the handoff's current task.

### Explanatory-only for ordinary bootstrap
- historical rationale for why handoffs exist;
- full research history;
- detailed recovery rationale when no recovery is needed;
- unrelated architecture documentation.

### Observation
The current BOOTSTRAP.md contains a large amount of conditional recovery/correction material. Ordinary bootstrap does not require all of that material to be active execution context. This is a concrete example of **conditional knowledge inflating the apparent execution context**.

---

## 3. Case B — Safe modification of an existing repository file

### Action
Change an existing project file while preserving unrelated content and commit the bounded change.

### Required execution context
- exact requested change;
- current file contents;
- repository identity and target ref/path;
- applicable repository/workflow rules;
- required write-safety procedure;
- commit-message requirements;
- any directly relevant project rule or architecture constraint;
- verification requirements for the resulting file/diff/scope.

### Already available from the task/conversation
- user intent and requested modification;
- known target file/path if supplied;
- constraints already established in the current conversation.

### Must be discovered from project state
- current file contents before editing;
- current file version/ref;
- relevant neighboring files only when required for correctness;
- resulting diff and repository state after the write.

### Conditional / escalation context
- deeper architecture documents if the requested change touches an architectural boundary;
- additional skills/rules if the file's domain requires them;
- historical references when reproducibility or semantic ambiguity requires them.

### Explanatory-only for ordinary file modification
- broad architecture history not affecting the change;
- rationale behind unrelated project rules;
- independent-review documents unless the change explicitly needs their evidence.

### Observation
Safe editing requires **fresh state**, but not broad historical context. The current repository rules can therefore be much smaller than a complete explanation of the project's architecture if the action can discover the exact state it needs.

---

## 4. Case C — Bounded architecture research

### Action
Investigate one narrowly defined architectural uncertainty and produce a research finding.

### Required execution context
- exact research question/boundary;
- current architectural state relevant to that question;
- applicable research methodology and evidence classifications;
- already-established constraints that prevent invalid reinterpretation;
- relevant existing research findings needed to avoid repeating closed work;
- the concrete test/counterexample being evaluated.

### Already available from the task/conversation
- current research objective;
- conclusions established earlier in the same active discussion;
- user constraints supplied in the current conversation.

### Must be discovered from project state
- authoritative architecture documents directly relevant to the question;
- current handoff/open questions;
- specific rules/skills governing the research activity.

### Conditional / escalation context
- Qwen/Grok review material when the question benefits from an independent counterexample;
- older research documents only where they constrain the current question;
- implementation files only if the architectural question crosses into implementation evidence.

### Explanatory-only for the bounded test
- unrelated architecture history;
- full independent-review onboarding text after the review role is already understood;
- detailed rationale for closed research arcs.

### Observation
Architecture research needs **semantic context**, but its context is question-scoped. A full architecture corpus is not intrinsically part of every research action.

---

## 5. Case D — Ordinary project question

### Action
Answer a narrow question about an already-known project fact.

### Required execution context
- the question;
- the authoritative source containing the requested fact, if the fact is not already established in the active conversation.

### Already available from the task/conversation
- terminology and context needed to interpret the question;
- any relevant facts already established in the current exchange.

### Must be discovered from project state
- only the authoritative file/state needed to answer the question when current repository evidence is required.

### Conditional / escalation context
- architecture or implementation documents only if the question crosses into those domains.

### Explanatory-only
- most of the instruction architecture.

### Observation
Some valid project actions require almost no meta-system execution context. This is important: **Minimal Execution Context is action-dependent rather than one universal package.**

---

## 6. Cross-case findings

### Finding F-01 — MEC is action-relative
The minimum context is not a single fixed bundle. It varies with the action.

### Finding F-02 — Current task/conversation state is part of context
Information already reliably available in the active conversation should not automatically be reread from repository instructions.

### Finding F-03 — Fresh project state is distinct from instruction knowledge
For repository mutation, current file/repository state is execution-critical even when broad documentation is not.

### Finding F-04 — Conditional knowledge should not be active by default
Recovery, historical research, independent review, and other escalation material can remain dormant until applicability is established.

### Finding F-05 — Explanation and execution knowledge are separable
Rationale can be stored elsewhere without making it part of every action's execution context, provided the execution-critical rule remains semantically complete.

### Finding F-06 — Compactness is not mere character-count reduction
A short instruction that omits a required semantic condition is not a successful compression. The target is **minimum sufficient execution context**, not minimum text.

### Finding F-07 — The assistant can perform contextual selection
The cases do not establish a need for a rigid command interpreter. They show that the assistant can reason from the task and selectively obtain the project state/instructions required by that task.

---

## 7. Preliminary MEC model

For a bounded action, execution context can provisionally be described as:

```text
MEC(action) =
    task intent
  + applicable execution constraints
  + required current state
  + required semantic/project knowledge
  + applicable conditional context
```

The important property is that each component is **action-relative** and should not be loaded merely because it exists.

---

## 8. What this does NOT establish

This analysis does not establish:

- a registry;
- a router;
- a manifest;
- a memory subsystem;
- a new filesystem boundary;
- a command syntax;
- a universal metadata schema;
- a particular division between Rules and Skills.

It only establishes a bounded research direction: reducing active context by selecting the minimum sufficient knowledge for the current action.

---

## 9. Next bounded question

The next useful test is not yet implementation design.

Test whether **applicability can be determined cheaply enough to select MEC before loading the full instruction body**.

Use a small set of existing Rules/Skills and classify their contents into:

1. always-needed execution core;
2. conditionally-needed execution material;
3. explanatory material;
4. historical/reference material.

Then test whether the resulting compact core remains sufficient for correct execution on minimal counterexamples.

---

## 10. Review input use

Qwen and Grok should be consulted only where an independent counterexample can materially challenge the MEC boundary. Their onboarding documents themselves should not automatically become MEC.

Correct Qwen onboarding reference:
`docs/architecture/independent-review-qwen-onboarding.md`.

The older DeepSeek onboarding file remains untouched as historical repository content.
