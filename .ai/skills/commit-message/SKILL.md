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

## Choosing the message

Describe the primary purpose of the commit, not every changed file.

If a commit changes several files as part of one coherent feature, use one message describing the feature.

If unrelated changes are present, recommend splitting them into separate commits.

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

    refactor(core): separate geometry from Illustrator adapters

    test(mirror): add axis-crossing cases

    chore(repository): add project AI instructions