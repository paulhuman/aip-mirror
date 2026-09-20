# Illustrator AIP Mirror — Project Instructions & Workflow

## Canonical repository identity and path resolution

The canonical AIP Mirror project repository is:

    REPOSITORY_ROOT = https://github.com/paulhuman/aip-mirror

The repository's canonical project branch is:

    main

### Repository path rule

> **Any repository-relative path without an explicit absolute path or URL is relative to the root of the aip-mirror repository on the main branch.**

This rule applies to project instructions, rules, skills, handoffs, architecture documents, research notes, bootstrap messages, and other project-controlled documentation.

For internal canonical references, use the qualified repository-reference form:

    paulhuman/aip-mirror@main:/.ai/rules/workflow.md

A repository-relative path may remain unqualified in prose when this rule makes its location unambiguous. The qualified form is preferred when the repository, branch/ref, or exact location needs to be explicit.

For historical or reproducibility-sensitive references, the @<ref> portion MUST be explicit. The ref may be a commit SHA, tag, or branch as appropriate:

    paulhuman/aip-mirror@<commit-sha>:/path/to/file.md
    paulhuman/aip-mirror@<tag>:/path/to/file.md
    paulhuman/aip-mirror@<branch>:/path/to/file.md

Unqualified repository-relative paths always mean the current main branch. They must not be resolved from the current working directory, another repository, an attachment, or conversational context.

If a repository-relative path cannot be resolved from REPOSITORY_ROOT, the AI must report the unresolved reference rather than guess.

---

## Purpose

**AIP Mirror** is a native Adobe Illustrator plugin project whose goal is to reproduce and extend the interactive mirror workflow of Macromedia FreeHand MX, with the general usability goals of tools such as Astute Graphics MirrorMe.

The project is intentionally split into four complementary working specializations around the same `aip-mirror` repository. Each specialization may span multiple conversation chapters as the project grows.

### Specialization chapter patterns

The current Chapter Identifier Format is:

    [0-9]{2}[A-Z]{2}

The first two digits identify the specialization. The final two uppercase letters identify the chapter using a continuous base-26 alphabetical sequence:

    AA → AB → ... → AZ → BA → BB → ... → BZ → CA → ... → ZZ

No letters are skipped.

1. **AIP Mirror — 01[A-Z]{2} — JSX Prototype**
2. **AIP Mirror — 02[A-Z]{2} — Native AIP Plugin**
3. **AIP Mirror — 03[A-Z]{2} — Architecture & Research**
4. **AIP Mirror — 04[A-Z]{2} — Project Workshop**

These are not four separate projects. They are four workstreams around the same repository.

---

# Conversation specialization model

## AIP Mirror — 01 — JSX Prototype

This specialization is for the **behavioral prototype only**.

The JSX implementation is a reference/proof-of-concept used to:

- discover and validate the desired interaction;
- reproduce FreeHand-like mirror behavior;
- experiment with geometry and transformations;
- test UX decisions quickly;
- establish expected results before native implementation.

Do **not** treat the JSX prototype as the final architecture.

When behavior is sufficiently understood and validated, development moves toward the native implementation in `02`.

---

## AIP Mirror — 02 — Native AIP Plugin

This specialization is for the actual Illustrator native plugin:

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

For the first native milestone, a simple/ugly ADM settings dialog is completely acceptable. The important part is the interactive mirror tool itself.

---

## AIP Mirror — 03 — Architecture & Research

This specialization is the shared architectural/research space.

Use it for:

- project-wide architecture;
- reverse engineering;
- FreeHand MX behavior research;
- Illustrator SDK research;
- technology decisions;
- boundaries between JSX and native code;
- decisions that affect multiple workstreams;
- documenting assumptions and discovered facts.

Do not move detailed implementation work here if it belongs naturally in the JSX or native implementation specialization.

### Cross-specialization consistency responsibility

`03` may review the repository and detect architectural, lifecycle, documentation, or consistency problems in handoffs belonging to other specializations.

When such a problem is found, `03` should report the inconsistency and route correction to the owning specialization. `03` must not edit another specialization's handoff on its behalf.

In particular, if a receiving chapter has stale or contradictory post-bootstrap state, the receiving chapter owns correction of its own handoff.

---

## AIP Mirror — 04 — Project Workshop

This specialization is the project's practical support and learning workspace.

Use it for questions and tasks that support development without belonging to the primary behavioral, native, or architectural workstreams, including:

- IDE configuration and project setup;
- CMake, compiler, debugger, and toolchain configuration;
- Git commands, branches, commits, repository mechanics, and routine GitHub operations;
- Illustrator SDK/tooling setup questions;
- ChatGPT interface and workflow questions;
- debugging development-environment problems;
- general programming learning and explanations;
- small or routine technical questions that would unnecessarily distract `01`, `02`, or `03`.

`04` is a support/workshop space, not a competing implementation stream. If a Workshop discussion produces a durable architecture or project-wide decision, record it in the repository and, when appropriate, route the decision through `03`.

---

# Conversation lifecycle and handoff

Chat context is finite working context. The repository is the durable technical memory of the project.

There is no reliable user-visible counter that allows the AI to know an exact percentage of remaining conversation context. Therefore, the AI must not claim an exact context percentage or exact number of remaining messages.

Instead, the AI should monitor for **contextual risk**: very long conversations, large accumulated technical state, increasing dependence on distant conversation details, or important decisions that exist only in chat.

When contextual risk becomes significant, the AI should warn the user early and recommend a handoff rather than waiting until information may be lost.

## Chapter naming

Each specialization uses a numeric identity followed by a two-letter chapter suffix.

The current Chapter Identifier Format is:

```text
[0-9]{2}[A-Z]{2}
```

The first two digits identify the specialization. The final two uppercase letters identify the chapter using a continuous base-26 alphabetical sequence:

```text
AA → AB → ... → AZ → BA → BB → ... → BZ → CA → ... → ZZ
```

No letters are skipped.

The sequence is positional and mathematical:

```text
AA = chapter ordinal 1
AB = chapter ordinal 2
AC = chapter ordinal 3
...
AE = chapter ordinal 5
AF = chapter ordinal 6
...
ZZ = chapter ordinal 676
```

The ordinal position of a chapter must not be confused with the identity of its identifier.

### Legacy historical identifiers

The former Chapter Identifier Format was:

```text
[0-9]{2}[A-Z]
```

Identifiers created under that format remain valid historical identifiers. They MUST NOT be rewritten merely to conform to the current Chapter Identifier Format, and a legacy identifier MUST NOT be interpreted as a current-format identifier.

Legacy and current identifiers occupy different identifier namespaces by format. Historical handoff documents retain their original chapter identifiers and filenames.

Historical chapters occupy their existing ordinal positions when the current format is introduced. They are not renamed into the current format. New chapters continue from the next unused ordinal position.

For specialization `03`, the historical/current ordinal correspondence is:

```text
ordinal   legacy ID   current-format position

1         03A         AA
2         03B         AB
3         03C         AC
4         03D         AD
5         03E         AE
6         —           AF  ← first new-format Chapter
```

This is **ordinal correspondence only**. It does NOT establish identifier identity. In particular:

```text
03A ≠ 03AA
03B ≠ 03AB
03C ≠ 03AC
03D ≠ 03AD
03E ≠ 03AE
```

`03AA`–`03AE` are not historical aliases and are not physically used as current identifiers in this repository.

Concrete chapters therefore use identifiers such as `03AF`, while historical chapters retain their original legacy identifiers such as `03A`–`03E`.

## Handoff documents

Conversation-specific migration state belongs under:

```text
docs/handoffs/
```

Use one state snapshot per chapter, for example:

```text
docs/handoffs/01AA-JSX-Prototype.md
docs/handoffs/02AB-Native-AIP-Plugin.md
docs/handoffs/03AF-Architecture-Research.md
docs/handoffs/04AA-Project-Workshop.md
```

Historical handoff documents created under the legacy one-letter format remain unchanged, for example:

```text
docs/handoffs/03A-Architecture-Research.md
docs/handoffs/03B-Architecture-Research.md
docs/handoffs/03C-Architecture-Research.md
docs/handoffs/03D-Architecture-Research.md
docs/handoffs/03E-Architecture-Research.md
```

A handoff is a **state snapshot**, not a casual conversation summary. It should record the current objective, completed work, implementation state, decisions, open questions, relevant files and references, constraints, assumptions, last completed task, immediate next task, things not to redo, and recommended starting context for the next chapter.

Handoffs must distinguish confirmed observations from inferences, assumptions, and open questions.

See `.ai/rules/conversation-lifecycle.md` and `.ai/skills/conversation-handoff/SKILL.md` for the complete lifecycle and handoff procedure.

---

# Critical workflow rule

The key project chain is:

```text
reverse engineering
        ↓
observations
        ↓
specification
        ↓
JSX reference implementation
        ↓
validation
        ↓
native design
        ↓
C++ / AIP implementation
```

The JSX prototype is an **executable behavioral reference**. The C++ implementation should reproduce the behavior defined by the specification and validated by the prototype, rather than blindly porting JSX line-by-line.

---

# Repository model

The project has two GitHub repositories with deliberately different roles.

## 1. `paulhuman/adobe-illustrator-2026-sdk`

This is the **canonical Adobe SDK reference repository**.

It contains the complete Illustrator 2026 SDK, including things such as `docs`, `illustratorapi`, `samplecode`, `tools`, and other SDK material.

Treat this repository as **reference-only** for AIP development.

Do not copy the SDK into `aip-mirror`.

When an exact Illustrator AIP API detail is needed, inspect this repository instead of asking the user to upload SDK files.

Original Adobe sample code also remains in the SDK repository. If a sample is adapted for AIP Mirror, the adapted project-specific version belongs in `aip-mirror`, not as a copy of the entire SDK.

## 2. `paulhuman/aip-mirror`

This is the actual project repository.

It should contain project source code, JSX prototypes, documentation, specifications, research notes, experiments, test data, project resources, conversation handoffs, and eventually the native AIP implementation.

It should **not** contain a copy of the Adobe SDK.

---

# Recommended repository structure

Do not create every possible directory immediately. Let the repository grow with the project.

### Initial structure

```text
aip-mirror/
├── .ai/
│   ├── skills/
│   │   ├── commit-message/
│   │   │   └── SKILL.md
│   │   ├── conversation-handoff/
│   │   │   └── SKILL.md
│   │   └── deep-understanding/
│   │       └── SKILL.md
│   └── rules/
│       ├── conversation-lifecycle.md
│       ├── project-architecture.md
│       ├── repository.md
│       └── workflow.md
│
├── docs/
│   ├── handoffs/
│   │   └── README.md
│   └── PROJECT-INSTRUCTIONS.md
│
├── references/
│   ├── freehand/
│   │   ├── FreehandMX-MirrorTool-Manual.png
│   │   └── using-freehandmx.pdf
│   ├── javascript/
│   │   └── Illustrator-JavaScript-Scripting-Reference-Nov-2025.pdf
│   └── test-data/
│       ├── screenshots/
│       └── videos/
│
├── prototypes/
│   └── jsx/
│
├── README.md
├── LICENSE
└── .gitignore
```

Later, when native development starts, the repository can grow toward:

```text
aip-mirror/
├── docs/
│   ├── architecture/
│   ├── handoffs/
│   ├── reverse-engineering/
│   │   ├── freehand-mx/
│   │   └── illustrator/
│   └── specifications/
│
├── references/
├── prototypes/
│   └── jsx/
│       ├── mirror/
│       └── geometry/
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
├── resources/
│   ├── icons/
│   └── strings/
├── tests/
│   ├── geometry/
│   ├── mirror/
│   ├── fixtures/
│   └── integration/
├── experiments/
│   ├── sdk/
│   ├── adm/
│   ├── geometry/
│   └── bridge/
└── tools/
    ├── analysis/
    └── development/
```

Do not create empty directories merely for symmetry.

---

# Native implementation strategy

The first native milestone should be intentionally simple:

- C++;
- Illustrator 2026 SDK;
- native AIP plugin;
- interactive mirror tool;
- basic/ugly ADM settings UI.

Do not introduce unnecessary web technologies at this stage.

Priority:

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

CEP is a legacy Adobe extension technology based around a browser/CEF-style environment. It is not a prerequisite for AIP.

UXP is Adobe's newer JavaScript/HTML/CSS extension runtime. For Illustrator, third-party availability should be verified against current Adobe documentation/status before being treated as a project dependency. UXP is not a prerequisite for AIP.

NUXP is a third-party architecture/workaround connecting a native C++ Illustrator plugin to a modern web frontend. It is interesting as an architectural reference, but is not required for AIP Mirror. Do not port NUXP wholesale at the beginning.

Spectrum Web Components are a web UI technology, not UXP itself. Using Spectrum requires a suitable web runtime/host and, in a native AIP architecture, potentially a bridge to the native plugin. Therefore Spectrum is a later UI option, not a foundation of the initial native plugin.

---

# Interactive tool architecture

The mirror interaction itself should be native.

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

---

# FreeHand MX behavioral target

The target is not simply "make a reflection operation." The project is intended to capture the **interactive behavior and workflow** associated with FreeHand MX's Mirror tool and extend it where useful.

Research should pay attention to:

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

# Current interaction preference

The user is comfortable drawing on the **right side** and wants the mirrored result on the **left side**.

The tool should therefore not be architected around an assumption that the source must be on the left.

The desired workflow should allow drawing **past/across the mirror axis** where appropriate rather than automatically treating the axis as a hard clipping boundary.

These are behavioral requirements to validate against the intended FreeHand-style interaction and prototype.

---

# Geometry and testing

Keep project-owned geometry as independent from Illustrator APIs as practical. Point/vector, line/axis, affine transform, reflection, intersection, tolerance, and coordinate conversion logic can conceptually belong in `src/core/geometry/`.

The project should eventually test at several levels:

### Geometry tests

Pure mathematical behavior such as point reflection, vector reflection, line/axis reflection, affine transforms, tolerances, and coordinate conversion.

### Mirror behavior tests

Source/mirrored side, axis behavior, crossing the axis, preview expectations, and repeated transformations.

### Integration tests

Illustrator-specific object/path creation, selection, transforms, undo, plugin lifecycle, and actual document interaction.

The JSX prototype can also serve as a behavioral oracle for many cases before the C++ implementation exists.

---

# Documentation rules

When documenting discoveries, distinguish clearly between:

### Observed fact

Something directly observed in FreeHand, Illustrator, a test, SDK documentation, or actual runtime behavior.

### Inference

A conclusion derived from observations.

### Assumption

Something believed to be true but not yet sufficiently verified.

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

Do not commit the complete Adobe SDK, generated build directories, compiler intermediates, IDE caches, `node_modules`, or temporary experiments that have no lasting value.

Conversation history is not a substitute for repository documentation. Important architecture, behavior, research findings, decisions, and validated handoff state should be recorded under version control.

---

# Working rule for future conversations

When a question concerns:

- **JSX behavior/prototyping** → primarily the `01` specialization.
- **native C++/AIP/ADM implementation** → primarily the `02` specialization.
- **architecture/research/FreeHand behavior/project-wide decisions** → primarily the `03` specialization.
- **IDE/toolchain/Git/repository mechanics/SDK tooling/ChatGPT interface/general development support** → primarily the `04` specialization.

Each specialization may have multiple chapters using the current two-letter Chapter Identifier Format (`[0-9]{2}[A-Z]{2}`), with the suffix advancing continuously from `AA` through `ZZ`. If a chapter becomes too large or contextually risky, warn the user and create a handoff before continuing in the next chapter.

Legacy one-letter chapter identifiers remain valid historical identifiers and must not be rewritten merely to conform to the current format. Historical handoff files retain their original names and identifiers.

For specialization `03`, the legacy chapters `03A`–`03E` occupy ordinal positions 1–5; the first newly created current-format chapter is `03AF` at ordinal position 6. This is ordinal correspondence only, not identifier identity.

If a topic crosses boundaries, keep the architectural decision in the `03` specialization and the implementation work in the appropriate implementation specialization. Use `04` to support the work, not to relocate it.

If `03` detects a lifecycle or consistency problem in a handoff owned by another specialization, report it to that specialization rather than editing its handoff. The owning chapter is responsible for correcting its own handoff.

The `aip-mirror` repository is the shared source of truth for project artifacts.

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
