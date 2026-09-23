# 03AS — Architecture & Research

## Chapter identity

- **Chapter:** 03AS
- **Specialization:** 03 — Architecture & Research
- **Previous chapter:** 03AR — Architecture & Research
- **Status:** DRAFT

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

- `docs/architecture/independent-review-deepseek-onboarding.md` — repository filename; the document identifies the reviewer as DeepSeek.
- Current observed Qwen handoff: `docs/handoffs/05AE-Independent-Review-Qwen.md`.

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

### Inferred

- Minimal Execution Context is currently the highest-leverage uncertainty to reduce.
- The distinction between durable knowledge and active execution context is likely central to the eventual meta-system.
- A compact execution layer may be possible without turning the assistant into a rigid command interpreter.

### Assumed / unverified

- The final shape of the reusable meta-system.
- Whether any routing mechanism is necessary.
- Whether a registry, manifest, index, or equivalent mechanism is useful.
- Whether existing handoffs need replacement or extension.
- Whether a new filesystem boundary is needed.

### Open

- Exact definition of Minimal Execution Context.
- What an action can infer from current task/conversation state.
- What must be discovered from project state.
- What must be explicit in execution-critical instructions.
- What can remain explanatory-only.
- How missing execution context should be detected.
- How independent review material can remain useful without becoming default execution context.

## Research boundary

Before introducing any implementation structure, determine:

1. what a representative action actually requires;
2. what can be inferred from the current conversation/task;
3. what must be discovered from project state;
4. what must be explicit in execution instructions;
5. what can remain explanatory-only;
6. what failure occurs when a required element is absent.

Do not create:

- `docs/meta/permanent/`;
- `docs/meta/temporary/`;
- `.ai/memory/`;
- a command registry;
- a command prefix;

merely to support this research.

Do not resume the historical semantic-trace work or launch a new C-series experiment merely because the current ideas are visible.

## Immediate next task

Run a bounded **Minimal Execution Context** analysis on a small set of representative actions.

The analysis should begin with concrete action cases and a decomposition of the knowledge required for each case. It should not begin by proposing a universal meta-system architecture.

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
- `docs/architecture/independent-review-deepseek-onboarding.md`
- `docs/architecture/independent-review-grok-onboarding.md`
- `docs/handoffs/05AE-Independent-Review-Qwen.md`
- `docs/handoffs/06AA-Independent-Review-Grok.md`
- `docs/architecture/constraint-problem-map-03AS.md`

Further architecture documents should be read selectively according to the bounded research question. Do not reload the entire historical architecture corpus by default.

## Last completed task

03AS consolidated the remaining owner constraints into `docs/architecture/constraint-problem-map-03AS.md`, verified the new document by read-back, and assessed `ai-project-instruction-architecture.md` as stale in several concrete areas.

## Bootstrap note

This handoff remains a compact live checkpoint. It records the active research frontier and constraints without reproducing the accumulated architecture history.
