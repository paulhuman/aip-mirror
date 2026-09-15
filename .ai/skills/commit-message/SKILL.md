---
name: commit-message
description: Create concise, consistent Git commit messages for the AIP Mirror project using the project's conventional commit style and vocabulary.
---

# Commit message

Create clear, concise Git commit messages that describe the purpose of a change.

AIP Mirror uses Conventional Commit-style messages:

    <type>(<scope>): <short description>

## Commit types

Use the type that best describes the primary purpose of the commit.

### feat

A new capability or user-visible behavior.

Example:

    feat(mirror): add interactive mirror axis preview

### fix

A correction to existing behavior.

Example:

    fix(geometry): correct reflection across arbitrary axis

### refactor

A structural change that does not intentionally change behavior.

Example:

    refactor(core): separate geometry from Illustrator adapters

### test

Adding or changing tests without a primary production-code change.

Example:

    test(mirror): add axis-crossing cases

### docs

Documentation-only changes.

Example:

    docs(architecture): document JSX to AIP transition

### chore

Repository maintenance, tooling, configuration, or project infrastructure.

Example:

    chore(repo): add project AI instructions

### build

Build-system or dependency changes.

Example:

    build(windows): configure Visual Studio project

### perf

A performance improvement.

Example:

    perf(mirror): reduce interactive preview allocations

## Scope

Use a short project-specific scope when it improves clarity.

Common scopes include:

- mirror
- geometry
- core
- plugin
- tool
- ui
- adm
- jsx
- sdk
- architecture
- repository
- tests
- build
- docs
- handoff

Do not force a scope when none is useful.

## Style rules

Commit messages should:

- use imperative wording
- be concise
- start with a lowercase description after the colon
- describe what the commit accomplishes
- avoid unnecessary implementation trivia
- avoid ending the subject with a period
- use terminology consistent with the project
- represent one coherent change
- avoid unrelated changes in the same commit

Prefer:

    feat(mirror): add interactive axis preview

over:

    added some code for the mirror thing

## Repository verification

Choosing a commit message does not replace verifying the repository change.

Before a commit is created, follow the repository write-safety rules in `.ai/rules/repository.md` and the commit verification procedure in `.ai/rules/workflow.md`.

In particular, when an existing file is changed through a full-content API update:

- fetch the current file before editing;
- preserve unrelated content;
- read the file back after writing;
- verify content integrity and the intended change;
- inspect the resulting diff and changed-file scope before committing.

A successful API write or valid Git commit does not by itself prove that the content is correct.

## Handoff commits

Handoff lifecycle changes are part of the project's auditable workflow and must be represented by Git commits.

Use the `handoff` scope for commits whose primary purpose is creating, updating, or changing the lifecycle status of a handoff.

Recommended vocabulary:

    docs(handoff): add 01A JSX prototype handoff

    docs(handoff): update 01A JSX prototype handoff

    docs(handoff): mark 01A handoff ready

    docs(handoff): mark 01A handoff handed off

    docs(handoff): mark 01A handoff superseded

    docs(handoff): correct overdue 03A handoff supersession

Rules:

- Every handoff lifecycle transition must appear in Git history.
- A transition may be combined with logically related handoff content changes in one coherent commit.
- A separate status-only commit is not required when the transition is already part of the same logical handoff update.
- The commit message should describe the primary handoff action, not every changed field.
- The chapter that owns the transition must perform the corresponding commit.
- A Lifecycle Correction commit records a later correction of repository state; it must not imply that the corrected transition happened at its original historical time.
- Lifecycle Correction commits must preserve the historical commits that show the original violation.

Transition ownership is defined by the conversation lifecycle rules:

    current chapter:
        DRAFT → READY_FOR_HANDOFF

    receiving chapter:
        READY_FOR_HANDOFF → HANDED_OFF

    later chapter:
        HANDED_OFF → SUPERSEDED

A Lifecycle Correction is not an additional lifecycle state transition and must not be represented as a skipped or replacement transition. Its commit records the controlled correction of the durable handoff state.

The previous chapter must not create a commit claiming `HANDED_OFF` merely because it has completed the handoff document.

## Choosing the message

Describe the primary purpose of the commit, not every changed file.

If a commit changes several files as part of one coherent feature, use one message describing the feature.

If unrelated changes are present, recommend splitting them into separate commits.

For handoff work, prefer one coherent commit when content and lifecycle status change together rather than creating unnecessary status-only commits.

For Lifecycle Correction, use a message that clearly identifies the correction as a later repair of durable handoff state. Do not phrase it as though the historical transition happened normally.

## When the user asks for commit messages

Provide 1–3 candidate messages when useful.

The first option should be the recommended default.

If the distinction between options matters, briefly explain why the recommended option is preferable.

Do not create or perform the commit merely because a commit message was requested.

Creating a commit and choosing its message are separate actions.

## Project vocabulary

Prefer established AIP Mirror terminology:

- JSX prototype
- native AIP plugin
- Illustrator AIP SDK
- mirror axis
- interactive preview
- reflection
- geometry
- transform
- FreeHand MX behavior
- Illustrator integration
- core geometry
- native tool
- ADM
- specification
- reverse engineering

Avoid inventing alternate names for established project concepts unless there is a reason to change the terminology.

## Example messages

    feat(mirror): add interactive mirror axis preview

    feat(jsx): add mirror behavior prototype

    fix(geometry): correct reflection across arbitrary axis

    docs(reverse-engineering): document FreeHand mirror behavior

    docs(architecture): document JSX to AIP transition

    docs(handoff): update 01A JSX prototype handoff

    docs(handoff): correct overdue 03A handoff supersession

    refactor(core): separate geometry from Illustrator adapters

    test(mirror): add axis-crossing cases

    chore(repository): add project AI instructions
