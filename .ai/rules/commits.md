# Commit rules

These rules define the project's general policy for creating and verifying Git commits.

## 1. Authorization

AI-assisted development changes SHOULD NOT be committed automatically unless the user explicitly requests the commit or the change is an explicit part of an established automated workflow.

Initial handoff creation, checkpoint updates, and migration handoff updates are pre-authorized parts of the handoff workflow when that workflow explicitly calls for them.

## 2. Coherent commits

A commit SHOULD represent one logical change.

- DO NOT commit unrelated changes together.
- Keep the changed-file scope intentional.
- Split unrelated work when it can reasonably be separated.
- A commit message SHOULD describe the primary purpose of the commit, not every changed file.

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

Normal handoff creation and update commits use the short ai-docs(handoff) convention:

    ai-docs(handoff): create C034
    ai-docs(handoff): update C034

Do not append conversation titles, task descriptions, rationale, milestone summaries, or other explanatory suffixes.

## 6. Repository integrity

A successful write operation or valid Git commit does not by itself prove that the repository content is correct.

When an existing file is modified through a full-content API or similar mechanism, follow the repository write-safety rules in `.ai/rules/repository.md` before committing.
