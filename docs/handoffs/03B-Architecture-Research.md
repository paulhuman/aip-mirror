# Conversation Handoff

Conversation:
AIP Mirror — 03B — Architecture & Research

Specialization:
03

Chapter:
B

Previous chapter:
AIP Mirror — 03A — Architecture & Research

Status:
DRAFT

## Current objective

Continue the project-wide AI-instruction architecture work from 03A. The pre-change audit and migration/ownership map are complete, and Architecture Decision Pass v1 is complete conceptually. The current focus is formalizing project-agnostic core semantics, applicability, activation, precedence, explicit `OVERRIDE`, and TRACE semantics before beginning the structural refactor.

## Project-agnostic architecture

The architecture is now explicitly required to separate a reusable AI instruction system from project-specific instruction/domain knowledge.

Core architectural semantics, lifecycle, workflows, observability, discovery/activation, and authority/precedence must be project-agnostic. Project identity, technology stack, domain rules, technical references, tests/fixtures, and project-specific workflows belong to the project-specific layer.

The intended system behavior is conceptually:

```text
This repository is an Adobe Illustrator AIP project.
```

or:

```text
This repository is a C++ synthesizer emulator UI project.
```

without changing the fundamental instruction model.

The working architectural principle is:

> **Design the AI instruction architecture so that its core semantics, lifecycle, workflows, observability and authority model are project-agnostic, while domain knowledge, project rules and technical references remain project-specific.**

This is a design criterion for the current architecture, not a commitment to name the result a “framework” or to introduce framework-level engineering prematurely.

### Project-Agnosticity Check

A dedicated Project-Agnosticity Check is added to the research process. Before finalizing the `.ai` architecture, each proposed element should be classified as:

- `CORE` — reusable unchanged across unrelated software projects.
- `PROJECT-SPECIFIC` — intentionally tied to one project's domain, technology, repository, or evidence.
- `ADAPTABLE` — structurally reusable but expected to receive project-specific values/content.

A primary test for RULEs is:

> **Could this rule be copied unchanged into a completely unrelated software project?**

If yes, it is a strong candidate for `CORE`. If no, determine whether it belongs in the project-specific layer or whether the abstraction can be generalized and made `ADAPTABLE`.

Initial examples:

| Element / concept | Classification | Rationale |
|---|---|---|
| RULE / SKILL / WORKFLOW semantic model | CORE | Fundamental instruction architecture is domain-independent. |
| Lifecycle / handoff state semantics | CORE | The lifecycle mechanism is not specific to Illustrator. |
| TRACE event model | CORE | Observability semantics can apply to any repository/project. |
| Authority / precedence / conflict model | CORE | Instruction authority is independent of technical domain. |
| Semantic RULE IDs | CORE | Stable identity is a general instruction-system mechanism. |
| `OVERRIDE` / `SPECIALIZE` relations | CORE | Relation semantics do not depend on project technology. |
| `activation: auto/manual/hybrid` | CORE | Activation semantics are domain-independent. |
| `AGENTS.md` routing role | CORE | Entry/routing semantics can be reused across projects. |
| Repository write-safety rules | ADAPTABLE | The safety principle is reusable; exact tooling/API behavior may vary. |
| Commit-message skill | ADAPTABLE | Method is reusable; project-specific conventions may vary. |
| Deep-understanding/research skill | ADAPTABLE | Research methodology is reusable; evidence sources vary. |
| `explain-code` skill | ADAPTABLE | Capability is reusable across C++, JSX, RmlUi, etc. |
| Adobe Illustrator AIP facts | PROJECT-SPECIFIC | Domain/SDK-specific knowledge. |
| FreeHand Mirror behavior | PROJECT-SPECIFIC | Product-specific reference/evidence. |
| RmlUi / OsTIrus skin rules | PROJECT-SPECIFIC | Future project-domain knowledge. |
| Project test fixtures / screenshots / videos | PROJECT-SPECIFIC | Evidence belongs to the concrete project. |
| Ableton Live Extensions SDK details | PROJECT-SPECIFIC | Future technology-specific reference material. |

### Future-project validation cases

The architecture should be tested conceptually against at least these future domains without modifying their repositories now:

1. **`aip-mirror`** — Adobe Illustrator native AIP / JSX prototype work.
2. **`gearmulator` + `virus-ti2-adssr`** — C++ synthesizer-emulator UI/skin work, particularly OsTIrus and RmlUi-based interfaces.
3. **Future Ableton Live Extensions project** — later, once the public Extensions SDK is available.

The purpose of these cases is architectural validation only. They are not current migration targets and do not justify creating `.ai` files in those repositories during this chapter.

## Architecture Decision Pass v2 — additions

- **AD-17:** Project-agnosticity is an explicit architectural criterion. Core instruction semantics, lifecycle, workflows, observability, discovery/activation, and authority/precedence must not depend on a particular software domain.
- **AD-18:** Project-specific domain knowledge, rules, technical references, tests/fixtures, and project workflows must remain separate from the reusable AI-system core.
- **AD-19:** Each proposed `.ai` element should be evaluated with `CORE / PROJECT-SPECIFIC / ADAPTABLE` classification before the architecture is frozen.
- **AD-20:** The rule portability test is: “Could this rule be copied unchanged into a completely unrelated software project?” A positive answer is strong evidence for `CORE`; otherwise the element must be justified as project-specific or generalized as `ADAPTABLE`.
- **AD-21:** Future repositories such as `gearmulator`, `RmlUi`, and `virus-ti2-adssr` are theoretical validation cases only during this chapter. No files are to be created or modified there. Ableton Live Extensions remain a later validation domain because the relevant SDK is not yet publicly available to the user.

## Current implementation state

No structural architecture refactor has been committed. This checkpoint adds research/design criteria only; no future-project repository has been modified.

## Open questions

- Final definitions and placement rules for `CORE / PROJECT-SPECIFIC / ADAPTABLE`.
- Whether the Project-Agnosticity Check itself should become a formal RULE, SKILL, or part of the architecture/research workflow.
- How project identity should be declared/discovered without coupling the reusable core to a particular domain.
- Whether `OVERRIDE` may be explicitly temporary (e.g. `temporary: true`) or should always represent a durable architectural declaration.
- Whether `override.scope` is needed, and if so, its exact semantics.
- Exact applicability schema and trigger representation.
- Exact responsibility split between `AGENTS.md` and `.ai/README.md`.
- Exact `.ai/config.json` schema.
- Final RULE/SKILL/WORKFLOW decomposition.
- Formal precedence and explicit-override syntax/semantics.
- Project Workshop hard `must not` boundaries and ownership.
- Initial `.ai/memory/` structure and its boundary with normal docs.
- Exact handoff bootstrap WORKFLOW destination/name/content.
- `consistency-pass` scope, triggers, report format, automatic/manual behavior.
- Exact redistribution map for `docs/PROJECT-INSTRUCTIONS.md` before deletion.
- Exact TRACE/mini-log implementation mechanism.
- Whether the preliminary precedence sequence should become normative unchanged.
- Whether `RESOLVE` belongs in the final TRACE event vocabulary.

## Evidence / confidence

### Confirmed / observed

- 03A is `HANDED_OFF`; 03B is active `DRAFT`.
- Audit and preliminary migration/ownership map are complete.
- AD-01 through AD-16 are conceptually established; AD-17 through AD-21 now record the project-agnosticity additions.
- Structural refactor has not yet begun.
- `codex`, Agent Skills, and vendor-neutral models were compared through existing forks.
- The user has identified `gearmulator`, `RmlUi`, and `virus-ti2-adssr` as future reference/test cases for project-agnosticity; no files are to be created there now.
- Ableton Live Extensions SDK access is currently unavailable to the user while the SDK remains in beta/closed access.

### Inferred

- Discovery/authority separation should make routing and conflicts more auditable.
- Compact `AGENTS.md` + `.ai/README.md` should prevent root instructions from becoming an encyclopedia.
- `consistency-pass` should help detect cascading contradictions after redistribution.
- Semantic TRACE events can provide the desired short real-time AI status/debug messages without becoming an authority layer.
- Stable semantic RULE IDs should make explicit overrides more robust than path- or depth-based semantics.
- Fail-closed handling of invalid/ambiguous overrides should prevent silent authority corruption.
- Project-agnostic core semantics should allow the same instruction architecture to be bootstrapped into unrelated software projects without redesigning its fundamental model.
- A formal Project-Agnosticity Check should help detect accidental Illustrator-specific coupling before the architecture is frozen.

### Assumed / unverified

- Actual runtime support for `AGENTS.md`, `.ai/README.md`, and `.ai/config.json` varies by host/tool.
- Exact mechanism for conversational AI to expose repository-defined TRACE events in real time is not established.
- Exact precedence/override syntax and applicability/config schemas remain unimplemented.
- Final TRACE event vocabulary is not yet fixed.
- The final boundary between reusable AI infrastructure and project-specific instruction content has not yet been formally encoded in repository files.

### Open

- Final normative precedence/override wording.
- Final workflow/skill/rule redistribution.
- Final machine-readable and TRACE schemas.
- Final refactor sequence and deletion gate for `docs/PROJECT-INSTRUCTIONS.md`.
- Final project-agnosticity classification and boundary model.

## Last completed task

Expanded the 03B architecture research checkpoint to explicitly include project-agnosticity as an architectural criterion. The research now distinguishes reusable AI-system semantics from project-specific instruction/domain knowledge, defines the `CORE / PROJECT-SPECIFIC / ADAPTABLE` classification, adds the “Could this rule be copied unchanged into a completely unrelated software project?” test, and records `gearmulator`, `RmlUi`, and the future Ableton Extensions domain as theoretical validation cases only. No files were created or modified in those future repositories.

## Immediate next task

Continue the dedicated Architecture Decision Pass on explicit `OVERRIDE`: settle temporary-vs-durable semantics, determine whether `override.scope` is necessary, and decide whether `RESOLVE` belongs in the TRACE vocabulary. Apply the Project-Agnosticity Check alongside that work so the emerging model does not accidentally acquire Illustrator-specific semantics. Then formalize precedence/override, continue with applicability/activation and TRACE schemas, and only after those semantics are sufficiently stable begin structural file changes.

## Things not to redo

- Do not redesign the chapter model or move handoffs out of `docs/handoffs/`.
- Do not edit another specialization's handoff from 03.
- Do not recreate 03A decisions from scratch.
- Do not blindly copy external repositories or Spectrum Web Components.
- Do not globally replace `should`/`may`; classify semantics case by case.
- Do not create `.ai/plugins/`.
- Do not treat HANDOFF as an optional extension or TRACE as authority.
- Do not begin native AIP implementation merely because this architecture refactor is underway.
- Do not delete `docs/PROJECT-INSTRUCTIONS.md` before redistribution and verification.
- Do not create a temporary transcript dump in `.ai/memory/`.
- Do not treat specificity, directory depth, or file location as an implicit override.
- Do not create or modify future-project instruction files merely to test project-agnosticity during this chapter.
- Do not prematurely rename the resulting reusable system as a “framework” or introduce framework-level engineering unless later research justifies it.

## Recommended starting context

Start from this checkpoint and the existing 03A/03B architecture work. The next substantive output should be the dedicated `OVERRIDE` Architecture Decision Pass, with the Project-Agnosticity Check applied alongside it. Follow with formalization of precedence/override, then applicability/activation and TRACE schemas. Only after those semantics are sufficiently stable should structural file changes begin. When implementation begins, use small auditable changes with full read-back/diff verification after every existing-file replacement.
