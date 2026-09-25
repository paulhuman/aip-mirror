---
name: deep-understanding
description: Require a thorough study of the relevant codebase, SDK material, documentation, or behavior before planning or implementing non-trivial work. Record findings in a persistent markdown research document so the user can review and correct the understanding before implementation proceeds.
---

# Deep understanding

Every meaningful non-trivial task must begin with a deliberate study of the relevant material before planning or implementation.

The goal is not to produce an immediate solution. The goal is to establish a reliable understanding of the system first.

The relevant material may include:

- APIs and SDKs
- scripting behavior
- external application behavior
- interactive tool behavior
- algorithms and transformations
- native plugin architecture
- existing prototype code
- unfamiliar parts of the codebase

Findings must be written into a persistent markdown document, not kept only in the conversation.

The research document is the user's review surface. The user must have an opportunity to verify the understanding, correct mistakes, and resolve important assumptions before implementation proceeds.

## When to use

Use this skill when:

- the task touches multiple files or components
- the task involves a new subsystem
- the relevant code or API is not already well understood
- reverse engineering is required
- behavior must be reproduced from another application
- an architectural decision depends on technical evidence
- the user explicitly asks for deep research or detailed understanding
- implementation based on an incorrect assumption could cause significant rework

## When not to use

Do not use this skill for trivial, self-contained work such as:

- a one-line fix
- a simple typo
- a small known-file edit
- a straightforward formatting change
- a simple question whose answer does not require repository investigation

If the relevant implementation and behavior are already explicitly documented and understood, a full research pass may also be unnecessary.

## Core principle

Do not form a technical hypothesis before gathering the available evidence.

Treat assumptions as technical debt.

Prefer:

    evidence
        ↓
    observation
        ↓
    interpretation
        ↓
    specification
        ↓
    implementation

over:

    assumption
        ↓
    implementation
        ↓
    debugging

## Research workflow

### 1. Define the scope

Identify exactly what needs to be understood.

Record:

- the task
- relevant files
- relevant APIs
- external behavior being reproduced
- known constraints
- questions that must be answered

Avoid researching unrelated parts of the project.

### 2. Read deeply

Study the relevant material thoroughly enough to understand:

- control flow
- data flow
- state
- dependencies
- API calls
- event handling
- geometry
- transformations
- side effects
- lifecycle
- error handling
- edge cases

For SDK or external repository investigations, inspect the repositories declared in `.ai/config.yaml` when their configured Role makes them relevant to the current research.

Do not duplicate external reference repositories into the project repository unless there is a specific project requirement to do so.

### 3. Record evidence

Clearly distinguish the following categories.

#### Observed fact

Something directly supported by code, documentation, experiment, screenshot, video, or reproducible behavior.

#### Inference

A conclusion reasonably derived from observed evidence but not directly documented.

#### Assumption

Something currently believed to be true but not yet sufficiently verified.

#### Specification

A deliberate project requirement or behavioral contract.

#### Implementation detail

A technical choice describing how the specification is currently implemented.

#### Open question

Something that remains unresolved and requires further investigation or experimentation.

Do not present assumptions or inferences as established facts.

### 4. Write the research document

For a non-trivial investigation, create or update an appropriate persistent markdown document.

Prefer a location such as:

    docs/reverse-engineering/
    docs/architecture/
    docs/specifications/

Use `research.md` only when no more specific document name is appropriate.

The document should normally contain:

- Overview
- Scope
- Evidence / Observations
- How it works
- Components
- Detailed findings
- Edge cases
- Risks
- Open questions
- Conclusions
- References

### 5. Review before implementation

For significant work, stop after the research phase.

Present the resulting understanding to the user and allow them to:

- confirm it
- correct it
- add missing information
- reject assumptions
- request additional investigation

Do not silently proceed from an uncertain understanding into a major implementation.

### 6. Convert validated findings into specification

Once the understanding has been reviewed, convert stable behavioral conclusions into project specifications where appropriate.

Research documents describe what was discovered.

Specification documents describe what the project should do.

Do not mix the two unnecessarily.

### 7. Implement only after validation

Implementation should follow validated understanding and specification.

For a prototype-based workflow:

    research → specification → prototype experiment

For a native implementation workflow:

    research → specification → native design → implementation

Do not treat prototype source code as something that should simply be translated line-by-line into another implementation language or architecture.

## Research quality

A useful research document should make it possible for another developer to understand:

1. what was investigated
2. what evidence was found
3. what conclusions were reached
4. which conclusions are certain
5. which conclusions remain assumptions
6. what still needs to be investigated
7. how the findings affect the implementation

Avoid producing research that merely restates source code without explaining behavior or implications.

## Stop condition

Do not continue researching indefinitely.

Stop when:

- the relevant behavior is understood sufficiently for the current decision
- important uncertainties are explicitly documented
- the evidence supports the proposed specification
- remaining unknowns do not materially block the current task

If an unresolved question can materially change the architecture or implementation, keep it open and investigate it before proceeding.
