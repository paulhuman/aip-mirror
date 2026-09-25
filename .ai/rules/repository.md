# Repository rules

These rules define repository identity, repository boundaries, project file organization, repository durability, and safe repository mutation.

## 1. Repository identity

The project repository identity is defined by `.ai/config.yaml`.

Use:

- `project.repository` for the repository identifier
- `project.default_branch` for the default branch
- `project.hosting.base_url` for constructing repository URLs

### Repository path resolution

The canonical repository root is constructed from the configured hosting base URL and repository identifier.

All unqualified repository-relative paths in project-controlled documentation resolve from that repository root on the configured default branch.

When a specific branch, tag, or commit must be explicit, use:

    <repository>@<ref>:/path/to/file.md

Do not resolve repository-relative paths from the current working directory, another repository, an attachment, or conversational context.

## 2. External repository boundaries

External repositories should remain separate from the project repository unless there is a clear project requirement and the licensing and maintenance implications are understood.

Reference repositories used by the project are declared under `references.repositories` in `.ai/config.yaml`. Use their declared `role` to determine why a reference repository is relevant.

Project-specific adaptations of material from a reference repository may be placed in the project repository when needed, but the original reference material remains in its canonical or declared external repository.

## 3. Repository content taxonomy

Use these categories consistently.

### `references/`

External reference material needed to understand or validate the project.

Examples:

- Illustrator JavaScript reference material
- FreeHand MX documentation
- screenshots
- videos
- reference test data

### `prototypes/`

Executable experimental implementations.

The JSX mirror prototype belongs under:

    prototypes/jsx/

### `docs/`

Human-readable project documentation.

Examples:

- architecture
- specifications
- reverse-engineering findings
- project instructions
- durable project documentation

Conversation-specific migration state is owned by the handoff infrastructure under `.ai/handoffs/`.

### `.ai/`

AI workflow instructions and generic AI infrastructure.

These files describe how AI-assisted work should be performed. They are not application source code.

Do not create large directory trees or placeholder files before they are needed. Directories should generally appear when their contents have a real purpose.

## 4. Repository hygiene

Build products and machine-specific generated files should normally remain outside version control.

Never commit:

- API keys
- access tokens
- passwords
- private credentials
- personal authentication data
- machine-specific secrets

The repository should contain source, configuration, documentation, tests, and intentional project artifacts rather than local build output or secrets.

## 5. Repository as durable project record

Conversation history is temporary working context. The repository is the durable technical record.

Important behavior, architecture, specifications, research findings, decisions, and validated project state should be captured in files under version control.

The general development workflow requires stable decisions to be documented; this rule defines the repository-level durability of that documentation.

Conversation continuity and handoff lifecycle are defined by `.ai/rules/handoff/lifecycle.md` and should not be redefined here.

## 6. Documentation traceability

Important architectural or behavioral decisions must be represented in the appropriate repository documentation rather than existing only in chat.

When a decision materially affects implementation, record it in the appropriate project document.

Do not duplicate generic workflow guidance here; `.ai/rules/workflow.md` owns the general documentation principle.

## 7. Repository write safety

GitHub API file updates are full-content replacements, not line-level edits. When an existing file is updated through an API that accepts complete file content, the new content must contain the entire intended file.

For an existing file:

    READ CURRENT FILE
        ↓
    make minimal intended change
        ↓
    WRITE COMPLETE FILE
        ↓
    READ BACK
        ↓
    VERIFY CONTENT
        ↓
    INSPECT DIFF
        ↓
    VERIFY SCOPE
        ↓
    COMMIT
        ↓
    VERIFY RESULT

Therefore:

- Read the current file from the repository before modifying it.
- Use the current file content as the source of truth; do not reconstruct an existing file from memory when it can be fetched.
- Preserve all unrelated content exactly unless the change intentionally modifies it.
- Treat the current blob SHA as part of the write precondition for an existing file.
- After writing, read the resulting file back from the repository.
- Verify that the intended change is present and unrelated content was not accidentally removed or altered.
- Inspect the resulting diff and changed-file scope before considering the change ready for commit.
- If the resulting content differs unexpectedly, stop and restore the correct content before making further changes.

A successful API operation, a valid blob SHA, or a valid Git commit does not by itself prove that the repository content is correct.

Content integrity must be verified independently of API success.

This rule applies to source code, documentation, configuration, scripts, tests, AI instructions, and every other existing repository file.
