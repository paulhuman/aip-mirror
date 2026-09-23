# Constraint → Problem Map — 03AS

**Status:** Research checkpoint / not an Architecture Decision  
**Chapter:** 03AS — Architecture & Research  
**Purpose:** Bound the new meta-system problem before selecting architecture or implementation.

---

## 1. New owner constraints

### C-01 — The assistant is not a command executor
The meta-system must not assume that the assistant mechanically executes every command one-to-one. It supports the assistant's reasoning and work rather than replacing it with a rigid interpreter.

### C-02 — Execution instructions must be compact
Rules and Skills should contain only the information needed for reliable execution and correct interpretation of the relevant process.

### C-03 — Detailed explanation may live elsewhere
Rationale, history, examples, architecture explanation, and research context may remain in Agents, README, docs, and handoffs.

### C-04 — Minimize per-action reread
The system should reduce the amount of instruction/context that must be reread before an action while preserving complete understanding of the process.

### C-05 — Preserve semantic correctness
Compactness must not remove distinctions required for correct behavior.

### C-06 — Project-agnostic meta-system
The resulting mechanism must remain reusable outside AIP Mirror. AIP Mirror-specific knowledge remains project-specific.

### C-07 — External independent review is part of the research loop
Qwen and Grok are independent review inputs, not authority sources. Their onboarding documents and relevant handoffs may be used selectively as review evidence.

---

## 2. Existing architectural constraints retained

- Complexity should be lazy rather than mandatory for every task.
- Applicability, activation, authority, and precedence remain distinct.
- Durable knowledge and execution context are not assumed to be the same thing.
- Handoffs are context transfer, not automatically the permanent source of truth.
- `.ai/memory/` is not justified merely as another knowledge store.
- No command registry or command prefix has been selected.
- Chat UI limitations rule out relying on leading `/` or `@` as the user-facing trigger.
- No new filesystem boundary such as `docs/meta/permanent/` / `temporary/` is accepted.
- Historical semantic-trace work remains paused until the current architecture problem is bounded.
- Current lifecycle is `DRAFT → READY_FOR_HANDOFF → HANDED_OFF`.

---

## 3. Problem decomposition

### P-01 — Knowledge vs execution context
We need to distinguish:
- knowledge that must exist somewhere;
- knowledge that must be available for a particular action;
- knowledge that must be reread explicitly;
- knowledge that can remain outside the active context.

**Open:** What is the minimum sufficient execution context for an action?

### P-02 — Routing
If only a subset of project knowledge is needed, something must make that subset discoverable.

Possible mechanisms are deliberately undecided.

**Open:** How can relevant context be selected without creating a heavy command/router framework?

### P-03 — Compression boundary
Rules/Skills need to become compact without becoming cryptic or losing semantics.

**Open:** What information belongs in execution-critical instruction text versus explanatory documentation?

### P-04 — Assistant understanding vs procedural enforcement
A rigid procedure can reduce omission risk but can also duplicate reasoning the assistant already performs.

**Open:** Which parts should be expressed as constraints, which as reusable capabilities, and which should remain ordinary reasoning?

### P-05 — State restoration
A new conversation needs enough context to continue correctly without rereading the entire architecture corpus.

**Open:** What state must be restored, and what can be rediscovered lazily?

### P-06 — Meta/project boundary
The reusable meta-system must not absorb AIP Mirror-specific architecture.

**Open:** What is the smallest project-independent core that can be extracted without premature filesystem restructuring?

### P-07 — Review integration
Independent reviews can challenge the model but must not become hidden authority or mandatory reread burden.

**Open:** How should review material become discoverable evidence without becoming execution context by default?

---

## 4. Primary architectural uncertainty

The highest-leverage unresolved question is:

> **What is the Minimal Execution Context: the smallest set of knowledge and state that must be available to the assistant for a given action to be performed correctly, without requiring a full reread of the project's instruction system?**

This question is semantic/operational, not yet a data-structure or filesystem question.

---

## 5. Research boundary

Before designing a registry, router, manifest, memory store, command syntax, or new directory structure, determine:

1. what an action actually requires;
2. what can be inferred from the current conversation/task;
3. what must be discovered from project state;
4. what must be explicit in execution instructions;
5. what can remain explanatory-only;
6. what failure occurs when a required element is absent.

The first bounded research target should therefore be **Minimal Execution Context**, using small concrete action cases rather than a universal framework proposal.

---

## 6. Success condition

A useful result should let us state, with bounded confidence:

> For a given class of action, this is the minimum context required for reliable execution; everything else may remain outside the active execution context unless the action escalates.

This is not yet an implementation prescription.

---

## 7. North-Star document assessment

`docs/architecture/ai-project-instruction-architecture.md` remains valuable as historical/current architectural context, but it is no longer a clean current North-Star specification.

Known stale or insufficient areas include:

- its examples still use `/handoff ...` command syntax;
- it describes Memory as a standing architectural category without incorporating the current `.ai/memory/` rejection;
- it predates the current compact `rules/skills` constraint;
- its execution model still describes a broader instruction framework without the newly explicit Minimal Execution Context problem;
- its lifecycle discussion contains historical supersession language that no longer matches the current lifecycle;
- it does not yet integrate the current meta-system/project-boundary discussion.

**Decision:** do not rewrite it yet. First complete the bounded Minimal Execution Context research, then use the resulting model to produce a deliberate replacement/update rather than patching the old document incrementally.

---

## 8. Review inputs available

### Qwen
- `docs/architecture/independent-review-deepseek-onboarding.md` (repository filename; document identifies DeepSeek)
- Current Qwen handoff chain, latest observed: `docs/handoffs/05AE-Independent-Review-Qwen.md`

### Grok
- `docs/architecture/independent-review-grok-onboarding.md`
- Current observed handoff: `docs/handoffs/06AA-Independent-Review-Grok.md`

These are review inputs. They do not override specialization-03 architectural decisions.

---

## 9. Next step

Run a bounded **Minimal Execution Context** analysis on a small set of representative actions.

Do not begin with a proposed meta-system architecture.
