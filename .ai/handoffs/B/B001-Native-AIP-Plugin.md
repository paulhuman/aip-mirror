# Conversation Handoff

Conversation:
AIP Mirror — 02AB — Native AIP Plugin

Specialization:
02

Chapter:
AB

Previous chapter:
AIP Mirror — 02AA — Native AIP Plugin

Status:
DRAFT

## Current objective

Continue the Native AIP Plugin specialization from the validated handoff state of chapter 02AA, without restarting the established project workflow or handoff system.

## Completed

- Bootstrap procedure for chapter 02AB has been started according to `.ai/skills/conversation-handoff/BOOTSTRAP.md`.
- Applicable lifecycle, workflow, repository, architecture, handoff, and commit-message rules have been read.
- Previous handoff `docs/handoffs/02AA-Native-AIP-Plugin.md` was verified as `READY_FOR_HANDOFF` before this receiving chapter's lifecycle transition.
- This chapter's mandatory initial `DRAFT` handoff has been created as part of bootstrap.

## Current implementation state

The 02AA handoff records that native C++/AIP implementation has not yet been completed. The production target remains a native C++ plugin using the Illustrator 2026 AIP SDK, with an interactive Mirror tool as the priority.

No native implementation files were identified by the previous handoff as already established. The repository currently contains project documentation, references, and the JSX prototype area; the canonical Illustrator 2026 SDK remains external in `paulhuman/adobe-illustrator-2026-sdk`.

## Decisions

- Native implementation belongs to specialization `02`.
- The native product is C++ plus the Illustrator AIP SDK.
- The JSX prototype is an executable behavioral reference and must not be mechanically translated into C++.
- Core geometry should remain independent from Illustrator-specific APIs where practical.
- The first native milestone should prioritize the interactive mirror tool; a simple ADM settings UI is acceptable if needed.
- CEP/UXP/NUXP/Spectrum are not foundations of the first native implementation.
- Repository changes must follow the established write-safety and verification rules.

## Open questions

- Exact Illustrator SDK suites/APIs required for the native tool.
- Plugin lifecycle and registration details for the Illustrator 2026 SDK.
- Native mouse/input event handling and interactive tool lifecycle.
- Live preview mechanism and Illustrator document/object interaction.
- Object/path manipulation, undo/cancel behavior, and native UI details.
- Which validated JSX/FreeHand behaviors should be implemented first in the native milestone.

## Current files

- `.ai/skills/conversation-handoff/BOOTSTRAP.md`
- `.ai/skills/conversation-handoff/SKILL.md`
- `.ai/skills/commit-message/SKILL.md`
- `.ai/rules/conversation-lifecycle.md`
- `.ai/rules/workflow.md`
- `.ai/rules/repository.md`
- `.ai/rules/project-architecture.md`
- `docs/PROJECT-INSTRUCTIONS.md`
- `docs/handoffs/02AA-Native-AIP-Plugin.md`
- `docs/handoffs/02AB-Native-AIP-Plugin.md`
- `prototypes/jsx/`
- `references/freehand/`
- `references/javascript/`
- `references/test-data/`
- External canonical SDK reference: `paulhuman/adobe-illustrator-2026-sdk`

## Relevant references

- Macromedia FreeHand MX Mirror reference material under `references/freehand/`.
- Illustrator JavaScript scripting reference under `references/javascript/`.
- Illustrator 2026 SDK in `paulhuman/adobe-illustrator-2026-sdk`.
- Project test data under `references/test-data/`.

## Important constraints

- Do not begin implementation before bootstrap is complete.
- Do not redo the established conversation lifecycle or repository safety rules.
- Do not invent unverified FreeHand or Illustrator behavior.
- Do not copy the complete Illustrator SDK into `aip-mirror`.
- Keep durable project decisions in repository documentation.
- Ordinary feature-development commits remain user-controlled; mandatory handoff bootstrap/lifecycle commits are explicitly pre-authorized by the workflow.

## Evidence / confidence

### Confirmed / observed

- `02AA-Native-AIP-Plugin.md` was in `READY_FOR_HANDOFF` state at bootstrap start.
- The project defines `02` as the Native AIP Plugin specialization.
- The project uses C++ with the Illustrator 2026 AIP SDK for the production native plugin.
- The native implementation was not yet completed according to the 02AA handoff.

### Inferred

- Chapter 02AB should begin native implementation investigation/design from the existing project state rather than recreating the handoff infrastructure.

### Assumed / unverified

- The exact first native implementation slice has not yet been selected.
- No claim is made here that any particular Illustrator SDK suite or event API has already been validated for the Mirror tool.

### Open

- Native AIP implementation details listed under Open questions remain to be researched and validated.

## Last completed task

Created the mandatory initial `DRAFT` handoff for chapter 02AB during bootstrap.

## Immediate next task

Complete the receiving-chapter bootstrap by updating `02AA-Native-AIP-Plugin.md` from `READY_FOR_HANDOFF` to `HANDED_OFF`, commit that lifecycle transition, verify the resulting repository state, and only then begin chapter 02AB work.

## Things not to redo

- Do not redesign the established chapter/handoff lifecycle.
- Do not recreate `BOOTSTRAP.md` with chapter-specific values.
- Do not treat the JSX prototype as a C++ architecture template.
- Do not copy the Adobe SDK into the project repository.
- Do not assume unverified Illustrator SDK behavior.

## Recommended starting context for next chapter

After bootstrap completion, begin by identifying the smallest well-supported native AIP implementation slice and inspect the exact Illustrator 2026 SDK material needed for it. Preserve the evidence distinction between confirmed SDK facts, inference, assumptions, and implementation choices.
