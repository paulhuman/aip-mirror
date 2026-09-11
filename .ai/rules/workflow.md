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

## 2. Four project specializations

The project uses four complementary conversation specializations. Each specialization may span multiple alphabetical chapters.

### AIP Mirror — 01 — JSX Prototype

Purpose: behavioral experiments, Illustrator JSX prototyping, interaction and geometry experiments, and rapid validation of user-visible behavior.

Current chapter: `AIP Mirror — 01A — JSX Prototype`

### AIP Mirror — 02 — Native AIP Plugin

Purpose: C++ implementation, Illustrator AIP integration, native interactive tool behavior, Illustrator event handling, live preview, object/path manipulation, undo/cancel behavior, and production architecture.

Current chapter: `AIP Mirror — 02A — Native AIP Plugin`

### AIP Mirror — 03 — Architecture & Research

Purpose: reverse engineering, architecture, specifications, technical research, FreeHand MX behavior analysis, Illustrator behavior analysis, technology evaluation, and cross-project decisions.

Current chapter: `AIP Mirror — 03A — Architecture & Research`

### AIP Mirror — 04 — Project Workshop

Purpose: practical development support and learning outside the primary implementation/research streams, including IDE configuration, CMake/build setup, Git commands and repository mechanics, SDK/tooling setup, ChatGPT interface questions, debugging of development environment issues, and routine technical questions.

Current chapter: `AIP Mirror — 04A — Project Workshop`

The `04` specialization is a support/workshop space. It should not become a competing architecture, research, JSX, or native implementation stream.

## 3. Do not duplicate reasoning across conversations

If a question belongs primarily to one specialization, keep the detailed investigation there.

Use repository documentation when the result is important to the entire project.

If a specialization reaches a contextual limit or needs a clean continuation, create the next alphabetical chapter and use a handoff from `docs/handoffs/`.

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

Classify findings as observed fact, inference, assumption, specification, implementation detail, or open question.

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

## 8. Testing

When practical, test at the lowest appropriate level:

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

### Repository write verification

When modifying an existing repository file through an API or other full-content write mechanism, use this verification sequence:

    read current file
          ↓
    make minimal intended change
          ↓
    write complete file
          ↓
    read file back
          ↓
    verify intended change
          ↓
    verify unrelated content preserved
          ↓
    inspect diff
          ↓
    verify scope
          ↓
    commit
          ↓
    verify resulting commit/ref

A successful write operation is not evidence that the content is correct. A valid blob SHA or Git commit is also not sufficient evidence of content integrity.

Before committing, confirm that:

- every intended file is present in the changed-file set;
- no unrelated file was changed;
- the modified file still contains all required pre-existing content unless its removal was intentional;
- the resulting diff contains only the intended change;
- the commit points to the intended repository state.

If an unexpected deletion, truncation, replacement, or unrelated modification is discovered, stop the workflow and correct the file before proceeding.

For existing files, prefer editing freshly fetched repository content rather than reconstructing the file from memory.

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

## 11. Conversation lifecycle

A chat is a finite working context. Do not claim an exact remaining context percentage or exact number of remaining messages.

When contextual risk becomes significant, warn the user and recommend a handoff rather than continuing until important state is lost.

Use the `conversation-handoff` skill to create a state snapshot under `docs/handoffs/`.

The user should know when a migration is recommended and decides when the next chapter is started unless they explicitly delegate that decision.

## 12. Documentation follows decisions

When an architectural or behavioral decision becomes stable, update the appropriate repository documentation.

Do not allow important decisions to exist only in temporary conversation context.

## 13. Keep the project understandable

Prefer explicit, maintainable solutions over clever systems.

The goal is a robust Illustrator plugin, not an elaborate AI-development framework.

AI instructions should help development rather than become development overhead.

## 14. Project Workshop routing rule

Use `04` for questions about the development environment, IDE, toolchain, Git mechanics, repository operations, SDK/tooling setup, ChatGPT interface, and other routine support.

If the answer establishes a project-wide architectural decision, move the durable decision into repository documentation and, when appropriate, the `03` architecture/research specialization.

If the work is actual JSX behavior/prototyping, continue in `01`. If it is actual native C++/AIP implementation, continue in `02`.
