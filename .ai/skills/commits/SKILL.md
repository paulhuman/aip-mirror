---
name: commits
description: Create concise, consistent Git commit messages using Conventional Commit style and project-defined vocabulary.
---

# Commit messages

Create clear, concise Git commit messages that describe the purpose of a change.

Use Conventional Commit-style messages:

    <type>(<scope>): <short description>

## Commit types

Use the type that best describes the primary purpose of the commit.

### feat

A new capability or user-visible behavior.

### fix

A correction to existing behavior.

### refactor

A structural change that does not intentionally change behavior.

### test

Adding or changing tests without a primary production-code change.

### docs

Documentation-only changes.

### chore

Repository maintenance, tooling, configuration, or project infrastructure.

### build

Build-system or dependency changes.

### perf

A performance improvement.

## Scope

Use a short scope when it improves clarity.

Project-specific scopes are defined in `.ai/config.yaml` under `terminology.commit_scopes`.

Generic scopes may also be used when appropriate, for example:

- architecture
- repository
- tests
- build
- docs
- handoff

Do not force a scope when none is useful.

## Style rules

Commit messages should:

- use imperative wording;
- be concise;
- start with a lowercase description after the colon;
- describe what the commit accomplishes;
- avoid unnecessary implementation trivia;
- avoid ending the subject with a period;
- use terminology consistent with the project configuration;
- represent one coherent change;
- avoid unrelated changes in the same commit.

## Choosing the message

Describe the primary purpose of the commit, not every changed file.

If a commit changes several files as part of one coherent feature, use one message describing the feature.

If unrelated changes are present, recommend splitting them into separate commits.

For handoff work, describe the primary handoff action.

For lifecycle recovery or correction, clearly identify the action as recovery or correction rather than implying that a historical transition happened at the original time.

## When the user asks for commit messages

Provide 1–3 candidate messages when useful.

The first option should be the default candidate.

If the distinction between options matters, briefly explain why.

Do not create or perform the commit merely because a commit message was requested.

Creating a commit and choosing its message are separate actions.

## Project vocabulary

Prefer established terminology defined in `.ai/config.yaml` under `terminology.project_terms`.

Do not invent alternate names for established project concepts unless there is a reason to change the terminology.

## Examples

Use the configured project vocabulary and commit scopes when constructing concrete commit-message examples. Do not encode project-specific examples in this reusable skill.
