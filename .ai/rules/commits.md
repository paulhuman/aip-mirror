# Commit rules

These rules define the project's general policy for creating and verifying Git commits.

## 1. Authorization

AI-assisted development changes should not be committed automatically unless:

- the user explicitly requests the commit; or
- the change is an explicit part of an established automated workflow.

Handoff lifecycle commits that are explicitly pre-authorized by the handoff rules are governed by those rules.

## 2. Coherent commits

A commit should represent one logical change.

- Do not commit unrelated changes together.
- Keep the changed-file scope intentional.
- Split unrelated work when it can reasonably be separated.
- A commit message should describe the primary purpose of the commit, not every changed file.

## 3. Verification before commit

Before creating a commit:

- verify the intended changed files;
- verify the intended scope;
- run relevant tests when available;
- inspect the diff;
- confirm that no unrelated change is included;
- choose an appropriate commit message.

Repository write-safety and full-content API verification are defined canonically in `.ai/rules/repository.md`.

## 4. Commit messages

Use `.ai/skills/commits/SKILL.md` for commit-message construction and project vocabulary.

Choosing a commit message does not authorize or create a commit.

## 5. Handoff commits

Handoff lifecycle commits follow the canonical handoff rules in `.ai/rules/handoff/lifecycle.md`.

The handoff lifecycle rules define:

- which lifecycle changes require Git commits;
- which chapter owns each transition;
- which handoff commits are pre-authorized;
- recovery and correction commit requirements.

Do not duplicate those lifecycle rules here.

## 6. Repository integrity

A successful write operation or valid Git commit does not by itself prove that the repository content is correct.

When an existing file is modified through a full-content API or similar mechanism, follow the repository write-safety rules in `.ai/rules/repository.md` before committing.
