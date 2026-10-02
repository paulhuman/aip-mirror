# Conversation Handoff

**Conversation:**
A0002 — JSX Prototype

**Specialization:**
A

**Chapter:**
0002

**Previous chapter:**
0001

## Starting objective

Recover the interrupted migration into A0002 and continue the JSX Prototype workstream from the reconstructed A0001 state without guessing. The immediate technical goal is to validate the first Multiple → Rotate JSX prototype against the actual Illustrator JavaScript API before treating the implementation as reliable.

## Completed during bootstrap

- Confirmed repository identity from `.ai/config.yaml`: `paulhuman/aip-mirror`, default branch `main`.
- Read the canonical bootstrap workflow and the applicable handoff, lifecycle, repository, workflow, activation, reference-preservation, and commit owners.
- Reconstructed the missing A0001 handoff from durable repository state and surviving conversation context.
- Created and read back `.ai/handoffs/A/0001-JSX Prototype.md`.
- Verified the A0001 creation commit contains only the intended new handoff file.
- Confirmed the repository does not currently contain a committed JSX prototype file under `prototypes/jsx/`.
- Confirmed the relevant FreeHand, Illustrator JavaScript, screenshot, and video reference areas are present in the repository.

## Current implementation state

The durable repository state contains research evidence and project instructions, but no committed `MultipleRotate.jsx` implementation.

A local `MultipleRotate.jsx` draft existed in the interrupted A0001 conversation. It is not repository state. Its arbitrary-center matrix transform has not been validated against the actual Illustrator scripting reference or in Illustrator and therefore must remain experimental.

The reconstructed A0001 handoff records the behavioral target and the known uncertainties. A0002 should continue from that state rather than repeat the confirmed FreeHand reverse-engineering work.

## Decisions carried forward

1. Initial JSX scope is Multiple → Rotate only.
2. Reflect is out of scope for the first prototype.
3. Close Paths is out of scope for the first prototype.
4. Initial ScriptUI scope is Multiple, Center X, and Center Y.
5. JSX is a behavioral prototype, not the final native architecture.
6. The production target remains a native C++ Illustrator AIP plugin.
7. FreeHand MX is the primary behavioral reference.
8. Normal Rotate keeps the source/reference fixed; source participation through Alt is a separate interaction behavior to model later.

## Confirmed starting evidence

- Multiple counts total objects including the source.
- Multiple Rotate uses 360 / N angular spacing.
- Test-1 document is 1000 × 1000 px with source pivot approximately at (500,500) and test Mirror center at (620,350).
- The no-Alt interaction keeps the source fixed while generated copies recompute as the Mirror center moves.
- The tested Alt interaction makes the source participate in a wheel-like rotation.
- The repository contains captured test videos and screenshots for these behaviors.

## Unresolved

- Exact Illustrator `Matrix` field/sign semantics.
- Exact `PageItem.transform()` arguments and transformation-anchor semantics for arbitrary-center rotation.
- Exact Illustrator coordinate/sign mapping relative to the FreeHand test coordinates.
- Exact initial gesture and phase/orientation behavior of the real FreeHand interactive tool.
- Whether the local prototype's current matrix implementation is mathematically and API-correct.

## Relevant files and references

- `.ai/handoffs/A/0001-JSX Prototype.md` — reconstructed predecessor context.
- `docs/PROJECT-INSTRUCTIONS.md` — project operating model and behavioral target.
- `references/javascript/Illustrator-JavaScript-Scripting-Reference-Nov-2025.pdf` — API validation source for JSX.
- `references/freehand/using-freehandmx.pdf` — primary FreeHand behavioral reference.
- `references/freehand/FreehandMX-MirrorTool-Manual.png` — visual FreeHand reference.
- `references/test-data/screenshots/` — captured states and test positions.
- `references/test-data/videos/` — captured interactive behavior.
- `prototypes/jsx/` — intended durable JSX prototype location; currently no committed implementation.

## Important constraints

- Use the current repository contents as the source of truth. Do not reconstruct existing repository files from memory.
- For any existing-file API update, follow READ CURRENT FILE → MAKE MINIMAL CHANGE → WRITE COMPLETE FILE → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT.
- Do not claim an API or transform behavior is validated until it has been checked against the project reference and/or Illustrator.
- Keep the canonical Adobe Illustrator SDK external to this repository.
- Do not turn the JSX prototype into the native architecture by translation alone.
- Ordinary commits remain user-controlled. Handoff creation is explicitly authorized by the bootstrap/handoff workflow.

## Last completed task

Recovered A0002 from the interrupted migration and reconstructed the missing A0001 handoff so the chapter chain is durable.

## Immediate next task

Inspect the Nov-2025 Illustrator JavaScript reference for `Matrix`, `getIdentityMatrix()`, `PageItem.transform()`, and `Transformation`, then compare those documented semantics with the local `MultipleRotate.jsx` draft before making any repository prototype change.

## Things not to redo

- Do not repeat the confirmed Multiple-counting rule or 360 / N spacing research.
- Do not repeat the already captured no-Alt and Alt behavioral observations unless new evidence contradicts them.
- Do not recreate a missing historical A0001 handoff again; it is now persisted and verified.

## Recommended starting context

Start with `.ai/handoffs/A/0001-JSX Prototype.md`, then inspect the actual Illustrator scripting reference sections named above. Only after API semantics are established should the prototype be revised or committed.