---
name: workflow
description: Guide AI-assisted development through research, decision capture, incremental implementation, testing, and repository verification.
---

# Workflow

This skill defines the preferred development workflow.

## 1. General development cycle

For non-trivial work, prefer:

    research
        ↓
    document
        ↓
    review
        ↓
    specify
        ↓
    prototype
        ↓
    validate
        ↓
    implement
        ↓
    test
        ↓
    document

Not every task requires every stage, but significant architectural or behavioral work SHOULD follow this order.

## 2. Research before major implementation

Before implementing an unfamiliar or technically significant area:

1. identify the relevant evidence
2. study the relevant source or SDK material
3. document findings
4. identify assumptions and open questions
5. establish the intended behavior
6. implement only after the understanding is sufficiently reliable

Use the `deep-understanding` skill for substantial investigations.

## 3. Validate behavior before declaring it final

A behavior discovered during reverse engineering is not automatically a project requirement.

Classify findings as observed fact, inference, assumption, specification, implementation detail, or open question.

Promote a finding to specification only when the project has intentionally accepted it.

## 4. Prefer small, reviewable changes

Changes SHOULD be incremental and understandable.

For significant features:

    investigation
        ↓
    small implementation step
        ↓
    test
        ↓
    review
        ↓
    next step

## 5. Testing

When practical, test at the lowest appropriate level.

A pure mathematical transformation SHOULD NOT require launching the host application if it can be tested independently.

## 6. Commits

Follow `.ai/skills/commits/SKILL.md` for commit-message construction and the canonical repository owner for commit policy.

## 7. Documentation follows decisions

When an architectural or behavioral decision becomes stable, update the appropriate repository documentation.

Do not allow important decisions to exist only in temporary conversation context.

## 8. Keep AI workflow understandable and lightweight

Prefer explicit, maintainable solutions over clever systems.

AI instructions SHOULD help development rather than become development overhead.

## 9. Repository-wide inspection

### Establishing an authoritative, pinned tree snapshot

Before making repository-wide structural claims, resolve the target branch to an immutable commit and verify the complete tree:

1. Read the Git ref for the configured branch (for example, `GET /repos/{owner}/{repo}/git/ref/heads/main`) and record the referenced commit SHA.
2. Read that commit and record its root tree SHA.
3. Request the recursive tree for that exact tree SHA (for example, `GET /repos/{owner}/{repo}/git/trees/{tree_sha}?recursive=1`).
4. Verify that the returned tree SHA matches the requested tree SHA, record the number of returned entries, and inspect the `truncated` field.
5. Treat the tree as complete only when `truncated` is `false`. If it is `true`, retrieve the affected subtrees in bounded, non-recursive batches and establish coverage before claiming completeness.
6. Pin all subsequent file reads and reference checks to the recorded commit SHA. Do not mix a moving branch name with a supposedly consistent snapshot.
7. Record the commit SHA, root tree SHA, completeness status, and entry count with the audit evidence.

A successful API response alone does not prove that a recursive tree is complete. If the ref, commit, tree, or completeness status cannot be verified, state the limitation and keep conclusions bounded to the files and revision actually inspected.

When a task requires reliable inspection of a substantial repository area, prefer the repository's authoritative tree/contents API and direct file retrieval over repository-wide code-search indexes when the latter are incomplete, stale, or otherwise untrusted.

Use this sequence:

    repository tree
        ↓
    identify the relevant root-level directories/files
        ↓
    retrieve contents one directory at a time
        ↓
    subdivide unusually large directories into meaningful batches
        ↓
    analyze the complete retrieved content
        ↓
    inspect historical/archive areas separately when they are not part of the active scope

The tree establishes the actual repository structure. Direct file retrieval establishes the actual file contents. Do not infer completeness from a search index that is known or suspected to omit files.

For a semantic sweep of an active infrastructure layer, first retrieve the active root-level areas separately rather than fetching the entire repository in one large batch. This keeps the analysis complete while preventing output truncation and accidental mixing of active and historical material.

For example, an active repository-context inspection may be batched as:

    .ai/config.yaml
    .ai/docs/architecture/*
    .ai/skills/*
    .ai/workflows/*
    .ai/handoffs/README.md
    docs/PROJECT-INSTRUCTIONS.md

Large or history-heavy areas such as archived architecture and historical handoffs SHOULD be inspected separately unless they are explicitly part of the current question.

When a required directory is too large for one retrieval, split it by its existing semantic subdirectories rather than arbitrarily truncating or sampling files.

After each batch, record which paths were actually retrieved. A repository-wide conclusion MUST be based on complete coverage of the declared scope, not on successful retrieval of only a subset.
