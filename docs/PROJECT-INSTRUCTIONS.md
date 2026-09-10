# Illustrator AIP Mirror — Project Instructions & Workflow

## Purpose

**AIP Mirror** is a native Adobe Illustrator plugin project whose goal is to reproduce and extend the interactive mirror workflow of Macromedia FreeHand MX, with the general usability goals of tools such as Astute Graphics MirrorMe.

The project is intentionally split into four complementary working specializations around the same `aip-mirror` repository. Each specialization may span multiple conversation chapters as the project grows.

### Current chapters

1. **AIP Mirror — 01A — JSX Prototype**
2. **AIP Mirror — 02A — Native AIP Plugin**
3. **AIP Mirror — 03A — Architecture & Research**
4. **AIP Mirror — 04A — Project Workshop**

These are not four separate projects. They are four workstreams around the same repository.

---

# Conversation specialization model

### 01 — JSX Prototype

Behavioral prototype only. Use it for Illustrator JSX prototyping, interaction and geometry experiments, rapid behavioral validation, and establishing expected results before native implementation.

The JSX implementation is an executable behavioral reference, not the final architecture.

### 02 — Native AIP Plugin

Production implementation stream. Use it for C++, Illustrator 2026 AIP SDK integration, Illustrator suites/APIs, native interactive tool behavior, event handling, live preview, object/path manipulation, undo/cancel behavior, plugin lifecycle, and production architecture.

The native interactive mirror engine should live in C++/Illustrator SDK rather than depending on CEP or UXP.

### 03 — Architecture & Research

Shared architectural and research stream. Use it for reverse engineering, FreeHand MX behavior research, Illustrator SDK research, specifications, technology evaluation, boundaries between JSX and native code, and decisions affecting multiple workstreams.

Do not move detailed implementation work here when it belongs naturally in 01 or 02.

### 04 — Project Workshop

Practical support and learning stream. Use it for questions and tasks that support the project without belonging to the primary behavioral, native, or architectural workstreams, including:

- IDE configuration and project setup;
- CMake, compiler, debugger, and toolchain configuration;
- Git commands, branches, commits, repository mechanics, and routine GitHub operations;
- Illustrator SDK/tooling setup questions;
- ChatGPT interface and workflow questions;
- debugging development-environment problems;
- general programming learning and explanations;
- other small or routine technical questions that would unnecessarily distract 01, 02, or 03.

`04` is a support/workshop space, not a competing implementation stream. If a Workshop discussion produces a durable architecture or project-wide decision, record it in the repository and, when appropriate, route the decision through 03.

---

# Conversation lifecycle and handoff

Chat context is finite working context. The repository is the durable technical memory of the project.

There is no reliable user-visible counter that allows the AI to know an exact percentage of remaining conversation context. Therefore, the AI must not claim an exact context percentage or exact number of remaining messages.

Instead, the AI should monitor for **contextual risk**: very long conversations, large accumulated technical state, increasing dependence on distant conversation details, or important decisions that exist only in chat.

When contextual risk becomes significant, the AI should warn the user early and recommend a handoff rather than waiting until information may be lost.

## Chapter naming

Each specialization uses a numeric identity followed by an alphabetical chapter letter:

```text
AIP Mirror — 01A — JSX Prototype
AIP Mirror — 01B — JSX Prototype
AIP Mirror — 01C — JSX Prototype

AIP Mirror — 02A — Native AIP Plugin
AIP Mirror — 02B — Native AIP Plugin
AIP Mirror — 02C — Native AIP Plugin

AIP Mirror — 03A — Architecture & Research
AIP Mirror — 03B — Architecture & Research
AIP Mirror — 03C — Architecture & Research

AIP Mirror — 04A — Project Workshop
AIP Mirror — 04B — Project Workshop
AIP Mirror — 04C — Project Workshop
```

The number identifies the specialization; the letter identifies the conversation chapter.

## Handoff documents

Conversation-specific migration state belongs under:

```text
docs/handoffs/
```

Use one state snapshot per chapter, for example:

```text
docs/handoffs/01A-JSX-Prototype.md
docs/handoffs/02A-Native-AIP-Plugin.md
docs/handoffs/03A-Architecture-Research.md
docs/handoffs/04A-Project-Workshop.md
```

A handoff is a **state snapshot**, not a casual conversation summary. It should record the current objective, completed work, implementation state, decisions, open questions, relevant files and references, constraints, assumptions, last completed task, immediate next task, things not to redo, and recommended starting context for the next chapter.

Handoffs must distinguish confirmed observations from inferences, assumptions, and open questions.

See `.ai/rules/conversation-lifecycle.md` and `.ai/skills/conversation-handoff/SKILL.md` for the complete lifecycle and handoff procedure.

---

# Critical workflow rule

The intended project chain is:

```text
FreeHand / Illustrator research
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

Do not perform a mechanical JSX-to-C++ translation.

---

# Repository model

The project has two GitHub repositories with deliberately different roles.

## 1. `paulhuman/adobe-illustrator-2026-sdk`

This is the **canonical Adobe SDK reference repository**. Treat it as reference-only for AIP development.

Do not copy the complete SDK into `aip-mirror`.

When an exact Illustrator AIP API detail is needed, inspect this repository instead of asking the user to upload SDK files.

## 2. `paulhuman/aip-mirror`

This is the actual project repository. It should contain project source code, JSX prototypes, documentation, specifications, research notes, experiments, test data, project resources, conversation handoffs, and eventually the native AIP implementation.

It should not contain a copy of the Adobe SDK.

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
├── prototypes/
│   └── jsx/
│
├── README.md
├── LICENSE
└── .gitignore
```

Later, when justified, the repository can grow toward architecture/specification/research docs, JSX geometry/mirror prototypes, native `src/core`, `src/plugin`, `src/ui`, tests, experiments, resources, and development tools. Do not create empty directories merely for symmetry.

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

CEP is a legacy Adobe extension technology and is not a prerequisite for AIP.

UXP is a separate Adobe extension runtime. Current Illustrator support should be verified against current Adobe documentation before being treated as a project dependency. UXP is not a prerequisite for AIP.

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

# Geometry, testing, and documentation

Keep project-owned geometry as independent from Illustrator APIs as practical. Geometry should be deterministic and independently testable.

The project should eventually test at several levels:

- geometry tests;
- mirror behavior tests;
- Illustrator integration tests.

Document discoveries by distinguishing:

- **Observed fact** — directly observed in a reference, test, SDK document, or runtime;
- **Inference** — conclusion derived from observations;
- **Assumption** — believed true but not sufficiently verified;
- **Specification** — deliberate project requirement;
- **Implementation detail** — technical choice used to satisfy the specification.

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

If a topic crosses boundaries, keep the durable architectural decision in the `03` specialization and the implementation work in the appropriate implementation specialization. Use `04` to support the work, not to relocate it.

Each specialization may have multiple chapters (`A`, `B`, `C`, ...). If a chapter becomes too large or contextually risky, warn the user and create a handoff before continuing in the next chapter.

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
