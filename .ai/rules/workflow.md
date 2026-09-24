# Workflow rules

These rules define the preferred development workflow for AIP Mirror.

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

Not every task requires every stage, but significant architectural or behavioral work should follow this order.

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

Changes should be incremental and understandable.

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

A pure mathematical transformation should not require launching Illustrator if it can be tested independently.

## 6. Commits

Follow `.ai/rules/commits.md` for commit policy and commit-related repository rules.

## 7. General commit authorization

AI-assisted development changes should not be committed automatically unless the user has explicitly requested the commit or an established automated workflow authorizes it.

## 8. Documentation follows decisions

When an architectural or behavioral decision becomes stable, update the appropriate repository documentation.

Do not allow important decisions to exist only in temporary conversation context.

## 9. Keep AI workflow understandable and lightweight

Prefer explicit, maintainable solutions over clever systems.

AI instructions should help development rather than become development overhead.
