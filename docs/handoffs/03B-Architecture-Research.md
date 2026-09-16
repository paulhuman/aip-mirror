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
SUPERSEDED

## Handoff destination

AIP Mirror — 03C — Architecture & Research

03C was initialized from the complete 03B architecture checkpoint and is now the receiving chapter. The repository remains in the legacy/pre-refactor layout; no structural refactor has been executed.

## Handoff state

03B completed the audit/design pass and transferred the current architecture checkpoint to 03C. The substantive context is preserved in `docs/handoffs/03C-Architecture-Research.md`.

## Completed architecture checkpoint

03B established AD-01 through AD-21, including:

- semantic types `RULE / SKILL / WORKFLOW / REFERENCE / MEMORY`, with `EXTENSIONS` separate;
- RULE/SKILL/WORKFLOW semantic boundaries;
- HANDOFF as a cross-cutting lifecycle mechanism;
- TRACE as observability, not authority;
- separate Applicability, Activation, and Precedence concepts;
- `specificity ≠ authority`;
- explicit semantic `OVERRIDE` and distinct `SPECIALIZE` relations;
- semantic RULE IDs independent of filename/path/depth;
- fail-closed handling of invalid or ambiguous override targets;
- compact `AGENTS.md` routing and `.ai/README.md` ontology roles;
- machine-readable `.ai/config.json` without duplicated policy;
- `auto / manual / hybrid` activation model as a candidate;
- project-agnostic architecture as an explicit criterion;
- `CORE / PROJECT-SPECIFIC / ADAPTABLE` classification;
- the rule portability test;
- future repositories as conceptual validation cases only.

## Immediate next work transferred to 03C

Perform the dedicated **OVERRIDE Architecture Decision Pass** first:

1. Decide durable vs explicitly temporary OVERRIDE semantics.
2. Decide whether `override.scope` is necessary and define it if retained.
3. Define OVERRIDE interaction with authority and specificity.
4. Define behavior for invalid, ambiguous, inactive, chained, and cyclic overrides.
5. Decide whether `RESOLVE` belongs in TRACE.
6. Record resulting decisions as new AD entries.
7. Apply the Project-Agnosticity Check to every resulting decision.

Then formalize precedence/override, continue applicability/activation, define TRACE schema/events, and only then begin structural refactoring.

## Repository safety

For future repository changes: read current content; preserve unrelated content; write complete intended content; read back; verify integrity, diff, and scope; commit; verify the resulting ref/commit. Never trust a successful write without readback/diff verification. Do not force-push merely to clean up an API incident.

## Things not to redo

- Do not recreate 03A decisions from scratch.
- Do not redesign the chapter/handoff model.
- Do not create `.ai/plugins/`.
- Do not treat HANDOFF as an optional extension.
- Do not treat TRACE as authority.
- Do not treat specificity/path/depth as implicit override.
- Do not globally replace `should`/`may`; classify semantics case by case.
- Do not begin native AIP implementation merely because architecture refactoring is underway.
- Do not delete `docs/PROJECT-INSTRUCTIONS.md` before semantic redistribution and verification.
- Do not create temporary transcript dumps in `.ai/memory/`.
- Do not modify future repositories merely to test portability.
