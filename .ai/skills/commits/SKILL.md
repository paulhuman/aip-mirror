---
name: commits
description: Create concise, consistent Git commit messages using Conventional Commit style and project-defined vocabulary.
---

# Commit messages

Create clear, concise Git commit messages that describe the purpose of a change.

Use Conventional Commit-style messages:

    <type>(<scope>): <short description>

## Commit types

Use the type that best describes the primary purpose of the change. Standard project types include feat, fix, refactor, test, docs, chore, build, and perf.

## AI-infrastructure commit namespace

This repository uses a local ai-\* namespace to make .ai/ infrastructure visible in Git history.

For handoff creation and update operations, including migration, use exactly:

    ai-docs(handoff): create C034
    ai-docs(handoff): update C034

Migration MUST use `update`, not `migrate`, in the commit message.
`migrate` is a workflow operation, not a handoff commit-message action.

Keep these messages short. Do not append conversation titles, task descriptions, rationale, milestone summaries, or other explanatory suffixes.

For other .ai/ infrastructure changes, use the ai-\* form that most clearly identifies the operation when a dedicated form is useful. Do not invent a larger taxonomy without a concrete need.

Project documentation remains under normal docs(...) vocabulary.

## Scope

Use a short scope when it improves clarity.

Project-specific scopes are defined in `.ai/config.yaml` under `terminology.commit_scopes`.

Generic scopes MAY also be used when appropriate, for example:

- architecture
- repository
- tests
- build
- docs
- handoff

DO NOT force a scope when none is useful.

## Style rules

Commit messages SHOULD:

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

If unrelated changes are present, the AI SHOULD recommend splitting them into separate commits.

For handoff work, describe the primary handoff action.

For lifecycle recovery or correction, clearly identify the action as recovery or correction rather than implying that a historical transition happened at the original time.

## When the user asks for commit messages

Provide 1–3 candidate messages when useful.

The first option SHOULD be the default candidate.

If the distinction between options matters, briefly explain why.

DO NOT create or perform the commit merely because a commit message was requested.

Creating a commit and choosing its message are separate actions.

## Project vocabulary

Prefer established terminology defined in `.ai/config.yaml` under `terminology.project_terms`.

Do not invent alternate names for established project concepts unless there is a reason to change the terminology.

## Examples

Use the configured project vocabulary and commit scopes when constructing concrete commit-message examples. Do not encode project-specific examples in this reusable skill.
