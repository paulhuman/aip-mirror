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

## 2. Three project conversations

The project uses three complementary conversations.

### AIP Mirror — 01 — JSX Prototype

Purpose:

- behavioral experiments
- Illustrator JSX prototyping
- interaction experiments
- geometry experiments
- rapid validation of user-visible behavior

The JSX prototype should answer questions such as:

- What should the interaction feel like?
- How should the mirror axis behave?
- What happens when drawing crosses the axis?
- How should the reflected geometry be generated?
- Which modifier-key behaviors are desirable?

The JSX prototype is not the final native implementation.

### AIP Mirror — 02 — Native AIP Plugin

Purpose:

- C++ implementation
- Illustrator AIP integration
- native interactive tool
- Illustrator event handling
- live preview
- object/path manipulation
- undo/cancel behavior
- production architecture

This conversation should use the validated behavior and specifications produced by the research and prototype work.

### AIP Mirror — 03 — Architecture & Research

Purpose:

- reverse engineering
- architecture
- specifications
- technical research
- FreeHand MX behavior analysis
- Illustrator behavior analysis
- technology evaluation
- cross-project decisions

Important decisions affecting multiple parts of the project should be recorded in the repository.

## 3. Do not duplicate reasoning across conversations

If a question belongs primarily to one conversation, keep the detailed investigation there.

Use repository documentation when the result is important to the entire project.

For example:

    Chat 03
       ↓
    architecture decision
       ↓
    docs/architecture/
       ↓
    Chat 02 uses the decision

## 4. JSX to native transition

The intended transition is:

    FreeHand / Illustrator research
            ↓
       observations
            ↓
       specification
            ↓
       JSX prototype
            ↓
         validation
            ↓
       native design
            ↓
       C++ / AIP implementation

Do not perform a mechanical JSX-to-C++ translation.

The native implementation should be based on the validated behavior and appropriate native architecture.

## 5. Research before major implementation

Before implementing an unfamiliar or technically significant area:

1. identify the relevant evidence
2. study the relevant source or SDK material
3. document findings
4. identify assumptions and open questions
5. establish the intended behavior
6. implement only after the understanding is sufficiently reliable

Use the `deep-understanding` skill for substantial investigations.

## 6. Validate behavior before declaring it final

A behavior discovered during reverse engineering is not automatically a project requirement.

Classify findings as:

- observed fact
- inference
- assumption
- specification
- implementation detail
- open question

Promote a finding to specification only when the project has intentionally accepted it.

## 7. Prefer small, reviewable changes

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

Avoid large unreviewed changes when the behavior or architecture is still uncertain.

## 8. Testing

When practical, test at the lowest appropriate level.

Prefer:

    geometry
       ↓
    behavior
       ↓
    Illustrator integration

A pure mathematical transformation should not require launching Illustrator if it can be tested independently.

## 9. Commit discipline

Before creating a commit:

- verify the changed files
- verify the intended scope
- run relevant tests when available
- inspect the diff
- choose an appropriate commit message

Use the `commit-message` skill when a commit message needs to be formulated.

Do not commit unrelated changes.

## 10. User control over commits

AI-assisted changes should not be committed automatically unless the user has explicitly requested the commit.

A useful default workflow is:

    make change
        ↓
    show / explain change
        ↓
    user review
        ↓
    commit when requested

For larger changes, a feature branch and pull request may be preferable.

## 11. Documentation follows decisions

When an architectural or behavioral decision becomes stable, update the appropriate repository documentation.

Do not allow important decisions to exist only in temporary conversation context.

## 12. Keep the project understandable

Prefer explicit, boring, maintainable solutions over clever systems.

The goal is a robust Illustrator plugin, not an elaborate AI-development framework.

AI instructions should help development rather than become development overhead.