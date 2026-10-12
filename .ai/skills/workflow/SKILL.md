---
name: workflow
description: Guide AI-assisted development through research, decision capture, incremental implementation, testing, and result verification.
disable-model-invocation: false
user-invocable: true
---

# Workflow

This skill defines the shared development methodology. Repository-access and mutation mechanics belong to the corresponding host-specific repository and workflow skills.

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

1. identify the relevant evidence;
2. study the relevant source or SDK material;
3. document findings;
4. identify assumptions and open questions;
5. establish the intended behavior;
6. implement only after the understanding is sufficiently reliable.

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

Test claims MUST be based on observed results, not merely on the intended operation or the absence of an error.

## 6. Commits

Follow `.ai/skills/commits/SKILL.md` for commit authorization, commit policy, and commit-message construction.

## 7. Documentation follows decisions

When an architectural or behavioral decision becomes stable, update the appropriate repository documentation.

Do not allow important decisions to exist only in temporary conversation context.

## 8. Keep AI workflow understandable and lightweight

Prefer explicit, maintainable solutions over clever systems.

AI instructions SHOULD help development rather than become development overhead.

## 9. Repository-wide inspection

Before making repository-wide structural or semantic claims, establish an authoritative revision and complete coverage of the declared inspection scope.

Use the repository's authoritative tree and direct file retrieval rather than repository-wide search indexes when those indexes are incomplete, stale, or otherwise untrusted. Do not infer completeness from a successful but partial retrieval.

Use the host-specific workflow skill for the applicable mechanism:

- `.ai/skills/github-api-workflow/SKILL.md` — pinning and inspecting a repository through the GitHub API;
- `.ai/skills/git-cli-workflow/SKILL.md` — pinning and inspecting a local Git repository and its working copy.

A reliable inspection sequence is:

    establish authoritative revision and tree
        ↓
    identify the declared inspection scope
        ↓
    retrieve contents in complete, meaningful batches
        ↓
    subdivide unusually large areas without silently sampling them
        ↓
    analyze the retrieved content
        ↓
    inspect historical/archive areas separately unless in scope
        ↓
    record evidence and coverage limits

For a semantic sweep of active AI infrastructure, consider the actual active areas, such as:

    .ai/config.yaml
    .ai/README.md
    .ai/AGENTS.md
    .ai/INDEX.md
    .ai/skills/*
    .ai/conversation-management/*
    .ai/handoffs/README.md
    .ai/memory/README.md
    .ai/captures/README.md
    .ai/docs/*
    .ai/scripts/*
    .ai/tests/*
    docs/PROJECT-INSTRUCTIONS.md

This list is an inspection aid, not a requirement to load every file for every task. Select the scope that fits the question, read the relevant README files for orientation, and inspect large or history-heavy areas separately.

After each batch, record which paths were actually retrieved. A repository-wide conclusion MUST be based on complete coverage of the declared scope, not on successful retrieval of only a subset.
