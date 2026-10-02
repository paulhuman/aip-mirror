# Conversation Handoff

**Conversation:**
A0001 — JSX Prototype

**Specialization:**
A

**Chapter:**
0001

**Previous chapter:**
N/A

## Starting objective

Establish the JSX Prototype workstream for AIP Mirror and turn the observed Macromedia FreeHand MX Mirror behavior into a small, testable Illustrator JSX prototype. The initial implementation target is Multiple → Rotate only.

## Completed

- Established the project goal: reproduce the interactive FreeHand MX Mirror workflow in modern Illustrator rather than relying on Illustrator's static Object → Repeat → Mirror behavior.
- Reverse-engineered the first Multiple → Rotate test sufficiently to define the initial behavioral target.
- Confirmed that Multiple is the total object count, including the source object.
- Confirmed the angular spacing rule for Multiple Rotate: 360 / N degrees.
- Confirmed the normal Rotate behavior observed in testing: the source/reference object remains fixed while generated copies rotate around the chosen Mirror center.
- Confirmed the interactive nature of the operation: while the mouse is held, changing the Mirror center causes the generated copies to recompute continuously.
- Confirmed Alt behavior in the tested Rotate interaction: the source/reference participates in the wheel-like rotation rather than remaining fixed.
- Recorded the important distinction between Rotate and Reflect behavior. In the tested Reflect interaction, Alt moved only the reflected copies while the already rotated copies remained fixed. The initial JSX target intentionally does not implement Reflect.
- Established the first prototype UI scope: Multiple, Center X, and Center Y.
- A local MultipleRotate.jsx draft was produced outside the repository for Illustrator testing. It was not committed to the repository.

## Current implementation state

The repository currently contains no committed JSX prototype under prototypes/jsx/.

The local prototype draft is therefore experimental working material, not durable repository state. Its matrix/transform implementation has not yet been validated against the actual Illustrator JavaScript API and MUST NOT be treated as correct merely because the script is syntactically plausible.

The repository already contains the primary FreeHand and Illustrator scripting references plus captured test screenshots and videos.

## Decisions

1. The first JSX prototype is limited to Multiple → Rotate.
2. Reflect mode is explicitly out of scope for this first prototype.
3. Close Paths is not part of the first prototype scope.
4. The prototype should use a small ScriptUI dialog with Multiple, Center X, and Center Y.
5. The prototype is a behavioral proof of concept, not the final native architecture.
6. The production implementation remains a native C++ Illustrator AIP plugin.
7. FreeHand MX is the primary behavioral reference. MirrorMe is not the behavioral authority.
8. The source/reference should remain fixed in normal Rotate behavior unless a later interaction design explicitly enables source participation.

## Behavioral observations

### Confirmed / observed

- FreeHand test document: 1000 × 1000 px.
- Source object pivot: approximately (500, 500).
- Test Mirror center: (620, 350).
- Test object size: approximately 120 × 180 px.
- A Multiple value of 6 produces 6 total objects, including the source.
- The six-object angular spacing is 60 degrees.
- The tested center movement sequence was: (620,350) → (700,350) → (700,500) → (700,650) → (620,650).
- In no-Alt testing, the source stayed fixed while generated objects moved smoothly as the center changed.
- In Alt testing, the source participated in the rotating wheel.
- Shift is associated with the documented 45-degree rotation constraint.
- Up/Down toggle Rotate/Reflect in the FreeHand workflow; Left/Right adjust the number of axes.

### Inferred

- For the first mathematical prototype, generated object positions can be modeled as rotations of the source around the selected center.
- A candidate Test-1 source-pivot radius from (500,500) to (620,350) is approximately 192.094.
- For six objects, the expected source-pivot positions from a straightforward Cartesian rotation model were previously calculated, but the exact Illustrator coordinate/sign convention still requires validation.

### Assumed / unverified

- Exact Illustrator Matrix field/sign semantics for the intended transform.
- Exact PageItem.transform() parameter semantics and transformation-anchor behavior for arbitrary-center rotation.
- Exact mapping between Illustrator document coordinates and the tested FreeHand coordinate system.
- Exact initial mouse gesture and phase/orientation rules of the real FreeHand interactive tool.
- Exact subpixel behavior.

## Relevant files and references

### Project sources

- docs/PROJECT-INSTRUCTIONS.md
- .ai/config.yaml
- prototypes/jsx/ — intended JSX prototype location; currently empty/not present as a committed file.

### FreeHand references

- references/freehand/using-freehandmx.pdf
  - Role: primary FreeHand MX manual/reference for Mirror workflow and modifier behavior.
- references/freehand/FreehandMX-MirrorTool-Manual.png
  - Role: visual reference for the Mirror tool UI and documented behavior.

### Illustrator scripting reference

- references/javascript/Illustrator-JavaScript-Scripting-Reference-Nov-2025.pdf
  - Role: canonical project-local JavaScript scripting reference for validating Illustrator JSX APIs such as matrices and item transforms.

### Test evidence

- references/test-data/screenshots/
  - Role: captured FreeHand Mirror states, including Rotate/Reflect windows and held/released test centers.
- references/test-data/videos/
  - Role: captured interactive behavior, including no-Alt Rotate, Alt/Shift interaction, and Reflect-mode Alt behavior.

## Important constraints

- Do not copy the complete Adobe Illustrator SDK into aip-mirror; the canonical SDK is external.
- Do not treat the JSX prototype as the production plugin architecture.
- Do not promote inferred geometry or unverified Illustrator API semantics to confirmed behavior without validation.
- For existing repository files, follow the repository write-safety sequence: read current file, make minimal change, write complete content, read back, verify content, inspect diff, verify scope, then commit.
- User controls ordinary commits. Handoff creation/update commits are explicitly authorized by the handoff workflow.
- No repository commit was made for the local MultipleRotate.jsx draft during this chapter.

## Open questions

1. Validate the exact Illustrator JavaScript matrix and transform APIs before trusting the current JSX draft.
2. Determine whether the first prototype should create copies from the original source or use another Illustrator duplication/transform strategy.
3. Determine how closely a ScriptUI parameterized prototype should model the eventual interactive center-drag state machine.
4. Validate rotation direction and coordinate-system conversion against an actual Illustrator document.
5. Determine the smallest test fixture that can distinguish a correct arbitrary-center rotation from a sign/axis error.

## Last completed task

Produced the first local MultipleRotate.jsx behavioral prototype draft and captured the current known limitations of its Illustrator transform implementation.

## Immediate next task

Before committing or expanding the prototype, validate the JSX transform implementation against the Nov-2025 Illustrator JavaScript reference and then test the smallest possible Multiple Rotate case in Illustrator.

## Things not to redo

- Do not re-research the already confirmed fact that Multiple counts the source object.
- Do not re-research the confirmed 360 / N angular spacing.
- Do not re-derive the already observed no-Alt versus Alt behavior unless a new test contradicts it.
- Do not replace FreeHand as the primary behavioral reference without a project-level decision.

## Recommended starting context

Read docs/PROJECT-INSTRUCTIONS.md, the relevant handoff state, and the Illustrator JavaScript reference sections covering Matrix, getIdentityMatrix(), PageItem.transform(), and Transformation before modifying the prototype.

## Recovery note

This handoff is being created after the original A0001 conversation ended before its normal handoff checkpoint was persisted. The historical state above is a reconstruction from the durable repository state and surviving conversation context. Items explicitly marked inferred or unverified MUST remain so until validated.