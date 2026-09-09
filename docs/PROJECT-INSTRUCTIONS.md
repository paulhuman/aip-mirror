# Illustrator AIP Mirror — Project Instructions & Workflow

## Purpose

**AIP Mirror** is a native Adobe Illustrator plugin project whose goal is to reproduce and extend the interactive mirror workflow of Macromedia FreeHand MX, with the general usability goals of tools such as Astute Graphics MirrorMe.

The project is intentionally split into three working conversations:

1. **AIP Mirror — 01 — JSX Prototype**
2. **AIP Mirror — 02 — Native AIP Plugin**
3. **AIP Mirror — 03 — Architecture & Research**

These are not three separate projects. They are three workstreams around the same `aip-mirror` repository.

---

## Critical workflow rule

### Chat 01 — JSX Prototype

This chat is for the **behavioral prototype only**.

The JSX implementation is a reference/proof-of-concept used to:

- discover and validate the desired interaction;
- reproduce FreeHand-like mirror behavior;
- experiment with geometry and transformations;
- test UX decisions quickly;
- establish expected results before native implementation.

Do **not** treat the JSX prototype as the final architecture.

When the behavior is sufficiently understood and validated, development moves to:

> **Chat 02 — Native AIP Plugin**

The transition is:

```text
Chat 01
JSX prototype
    ↓
validated behavior
    ↓
Chat 02
native C++ AIP implementation
```

The JSX code should therefore be written with clarity and behavioral fidelity in mind, not with the assumption that it will become the final production implementation.

---

## Chat 02 — Native AIP Plugin

This chat is for the actual Illustrator native plugin:

- C++;
- Illustrator AIP SDK;
- Illustrator-specific suites and APIs;
- native interactive tool implementation;
- Adobe Dialog Manager (ADM), where appropriate;
- plugin lifecycle and integration;
- Windows/macOS native concerns;
- eventual production architecture.

The native interactive mirror engine should live in C++/Illustrator SDK rather than depending on CEP or UXP.

### Important

**AIP does not require CEP or UXP.**

CEP and UXP are separate extension/UI technologies.

A pure native AIP can be implemented using:

```text
C++
+
Illustrator SDK
+
Illustrator suites
+
native plugin UI (e.g. ADM)
```

ADM is an old Adobe native UI toolkit. It provides dialogs, palettes, controls, events, etc. It is conceptually similar to using a C++ UI toolkit such as JUCE, although it is Adobe's own older framework.

For the first native milestone, a simple/ugly ADM settings dialog is completely acceptable. The important part is the interactive mirror tool itself.

---

## Chat 03 — Architecture & Research

This chat is the shared architectural/research space.

Use it for:

- project-wide architecture;
- reverse engineering;
- FreeHand MX behavior research;
- Illustrator SDK research;
- technology decisions;
- boundaries between JSX and native code;
- decisions that affect multiple workstreams;
- documenting assumptions and discovered facts.

Do not move detailed implementation work here if it belongs naturally in Chat 01 or Chat 02.

---

# Repository model

The project has two GitHub repositories with deliberately different roles.

## 1. `paulhuman/adobe-illustrator-2026-sdk`

This is the **canonical Adobe SDK reference repository**.

It contains the complete Illustrator 2026 SDK, including things such as:

- `docs`
- `illustratorapi`
- `samplecode`
- `tools`
- and other SDK material.

### Rule

Treat this repository as **reference-only** for AIP development.

Do not copy the SDK into `aip-mirror`.

When an exact Illustrator AIP API detail is needed, inspect this repository instead of asking the user to upload SDK files.

Original Adobe sample code also remains in the SDK repository. If a sample is adapted for AIP Mirror, the adapted project-specific version belongs in `aip-mirror`, not as a copy of the entire SDK.

---

## 2. `paulhuman/aip-mirror`

This is the actual project repository.

It should contain:

- project source code;
- JSX prototypes;
- project documentation;
- specifications;
- research notes;
- experiments;
- test data;
- project resources;
- eventually the native AIP implementation.

It should **not** contain a copy of the Adobe SDK.

---

# Recommended repository structure

Do not create every possible directory immediately. Let the repository grow with the project.

### Initial structure

```text
aip-mirror/
├── README.md
├── LICENSE
├── .gitignore
│
├── docs/
│
├── references/
│   ├── javascript/
│   │   └── Illustrator-JavaScript-Scripting-Reference-Nov-2025.pdf
│   └── test-data/
│       ├── screenshots/
│       └── videos/
│
└── prototypes/
    └── jsx/
```

Later, when native development starts:

```text
aip-mirror/
├── docs/
│   ├── architecture/
│   ├── design/
│   ├── reverse-engineering/
│   │   ├── freehand-mx/
│   │   └── illustrator/
│   └── specifications/
│
├── references/
│   ├── javascript/
│   └── test-data/
│
├── prototypes/
│   └── jsx/
│       ├── mirror/
│       └── geometry/
│
├── src/
│   ├── core/
│   │   ├── geometry/
│   │   ├── mirror/
│   │   └── transform/
│   ├── plugin/
│   │   ├── tools/
│   │   ├── commands/
│   │   ├── suites/
│   │   └── notifiers/
│   ├── ui/
│   └── bridge/
│
├── resources/
│   ├── icons/
│   └── strings/
│
├── tests/
│   ├── geometry/
│   ├── mirror/
│   ├── fixtures/
│   └── integration/
│
├── experiments/
│   ├── sdk/
│   ├── adm/
│   ├── geometry/
│   └── bridge/
│
└── tools/
    ├── analysis/
    └── development/
```

### Directory rules

- `docs/reverse-engineering/` — observed facts and evidence about FreeHand MX and Illustrator.
- `docs/specifications/` — formal project behavior and mathematical/interaction contracts derived from observations.
- `prototypes/jsx/` — executable reference implementations.
- `src/core/` — project-owned geometry/mirror/transform logic that can remain as independent from Illustrator-specific API as practical.
- `src/plugin/` — native Illustrator AIP implementation.
- `src/ui/` — UI code. Do not force a web architecture into this directory before it is actually needed.
- `src/bridge/` — only create/use this if a web/native bridge is genuinely required.
- `resources/` — icons, strings and other runtime resources.
- `tests/` — automated and integration tests.
- `experiments/` — temporary technical investigations. Proven code should eventually move to its proper production location.
- `tools/` — development and analysis utilities.
- `build/` — local build output; normally ignored by Git rather than committed.

Do not create empty directories merely for symmetry.

---

# Architectural chain

A key principle of the project is:

```text
reverse engineering
        ↓
observations
        ↓
specification
        ↓
JSX reference implementation
        ↓
C++ native implementation
```

This separation is important.

The JSX prototype is not merely disposable code. It acts as an **executable behavioral reference**.

The C++ implementation should reproduce the behavior defined by the specification and validated by the prototype, rather than blindly porting JSX line-by-line.

---

# Native implementation strategy

## Level 1 — simplest native plugin

The first native milestone should be intentionally simple:

- C++;
- Illustrator 2026 SDK;
- native AIP plugin;
- interactive mirror tool;
- basic/ugly ADM settings UI.

Do not introduce unnecessary web technologies at this stage.

The priority is:

1. correct Illustrator integration;
2. correct mouse interaction;
3. responsive live preview;
4. correct mirror geometry;
5. correct object/path handling;
6. undo/redo behavior;
7. stable plugin lifecycle.

UI polish comes later.

---

# CEP, UXP, NUXP and Spectrum

These technologies must not be conflated.

## CEP

CEP is a legacy Adobe extension technology based around a browser/CEF-style environment.

It is not a prerequisite for AIP.

Do not introduce CEP merely because a modern UI is desired.

## UXP

UXP is Adobe's newer JavaScript/HTML/CSS extension runtime.

For Illustrator, third-party availability should be verified against current Adobe documentation/status before being treated as a project dependency.

UXP is also not a prerequisite for AIP.

## NUXP

NUXP is a third-party architecture/workaround that connects a native C++ Illustrator plugin to a modern web frontend, currently using an embedded HTTP/SSE-style bridge.

It is interesting as an architectural reference, but it is **not required** for AIP Mirror.

Do not port NUXP wholesale at the beginning.

If a modern web UI becomes necessary later, borrow only the architectural ideas that solve an actual project requirement.

In particular, do not expose hundreds of SDK functions through a bridge merely because a generic bridge can do so. AIP Mirror needs a small, purpose-built interface.

## Spectrum Web Components

Spectrum Web Components are a web UI technology.

They are not UXP itself.

Using Spectrum requires a suitable web runtime/host and, in a native AIP architecture, potentially a bridge to the native plugin.

Therefore Spectrum should be considered a later UI option, not a foundation of the initial native plugin.

---

# Interactive tool architecture

The mirror interaction itself should be native.

Conceptually:

```text
Illustrator mouse/input events
        ↓
native mirror tool
        ↓
geometry calculation
        ↓
live preview
        ↓
Illustrator document/object operations
```

The UI should not be responsible for the high-frequency interactive geometry loop.

This is especially important for:

- mouse tracking;
- mirror-axis manipulation;
- live mirrored preview;
- snapping/precision;
- object/path transformation;
- low-latency feedback.

---

# FreeHand MX behavioral target

The target is not simply "make a reflection operation."

The project is intended to capture the **interactive behavior and workflow** associated with FreeHand MX's Mirror tool and extend it where useful.

Therefore, research should pay attention to:

- how the mirror axis is established;
- how the user positions the axis;
- which side is considered the source side;
- whether drawing can cross the mirror axis;
- live preview behavior;
- object/path transformation;
- selection behavior;
- repeated/interactive operation;
- cancellation;
- confirmation;
- modifier-key behavior;
- coordinate-system details;
- snapping;
- visual feedback.

Do not assume Illustrator's existing Object → Repeat → Mirror behavior is equivalent to the desired tool.

---

# Current user interaction preference

The user is comfortable drawing on the **right side** and wants the mirrored result on the **left side**.

The tool should therefore not be architected around an assumption that the source must be on the left.

Likewise, the desired workflow should allow drawing **past/across the mirror axis** where appropriate rather than automatically treating the axis as a hard clipping boundary.

These are behavioral requirements to validate against the intended FreeHand-style interaction and prototype.

---

# Geometry principle

Keep project-owned geometry as independent from Illustrator APIs as practical.

For example:

```text
Point / Vector
Line / Axis
Affine transform
Reflection
Intersection
Tolerance
Coordinate conversion
```

can conceptually belong in `src/core/geometry/`.

Illustrator-specific code should adapt between Illustrator data structures and project geometry rather than making every mathematical operation depend directly on Illustrator SDK types.

This makes the geometry:

- easier to test;
- easier to reason about;
- reusable between prototype/native implementations;
- less coupled to SDK details.

---

# Testing philosophy

The project should eventually test at several levels:

### Geometry tests

Pure mathematical behavior:

- point reflection;
- vector reflection;
- line/axis reflection;
- affine transforms;
- tolerances;
- coordinate conversion.

### Mirror behavior tests

Project-level rules:

- source/mirrored side;
- axis behavior;
- crossing the axis;
- preview expectations;
- repeated transformations.

### Integration tests

Illustrator-specific behavior:

- object/path creation;
- selection;
- transforms;
- undo;
- plugin lifecycle;
- actual document interaction.

The JSX prototype can also serve as a behavioral oracle for many cases before the C++ implementation exists.

---

# Documentation rules

When documenting discoveries, distinguish clearly between:

### Observed fact

Something directly observed in FreeHand, Illustrator, a test, SDK documentation, or actual runtime behavior.

### Inference

A conclusion derived from observations.

### Specification

A deliberate project requirement.

### Implementation detail

A technical choice used to satisfy the specification.

Example:

```text
Observed:
FreeHand previews the mirrored object while the user moves the axis.

Inference:
The operation is fundamentally interactive rather than a post-hoc transform.

Specification:
AIP Mirror must provide a live mirrored preview during axis manipulation.

Implementation:
The native C++ tool updates preview geometry from mouse events.
```

This distinction prevents assumptions from accidentally becoming requirements.

---

# Git and repository hygiene

Keep the project repository focused.

Do not commit:

- the complete Adobe SDK;
- generated build directories;
- compiler intermediates;
- IDE caches;
- `node_modules`;
- generated binaries unless there is a deliberate release reason;
- temporary experiments that have no lasting value.

Typical ignored items include:

```text
build/
out/
.vs/
.vscode/
.idea/
node_modules/
*.obj
*.pdb
*.dll
*.aip
```

Adjust `.gitignore` when the actual build system is established.

---

# Working rule for future conversations

When a question concerns:

- **JSX behavior/prototyping** → primarily Chat 01.
- **native C++/AIP/ADM implementation** → primarily Chat 02.
- **architecture/research/FreeHand behavior/project-wide decisions** → Chat 03.

If a topic crosses boundaries, keep the architectural decision in Chat 03 and the implementation work in the appropriate implementation chat.

The same `aip-mirror` repository is the shared source of truth for project artifacts.

---

# Most important mental model

This project is not:

```text
JSX → rewrite the same code in C++
```

It is:

```text
Research
   ↓
Behavioral specification
   ↓
JSX prototype
   ↓
validated interaction model
   ↓
native C++ AIP implementation
   ↓
production UI/architecture
```

The JSX phase exists to make the behavior concrete and testable before spending the larger engineering effort on a native Illustrator plugin.

The native phase is the real product.

