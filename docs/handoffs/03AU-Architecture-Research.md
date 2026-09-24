# Conversation Handoff

Conversation:
AIP Mirror — 03AU — Architecture & Research

Specialization:
03 — Architecture & Research

Chapter:
03AU

Previous chapter:
03AT — Architecture & Research

Status:
READY_FOR_HANDOFF

## Current objective

Continue Iteration 2 of the practical AI project-instruction infrastructure.

The immediate goal is to finish a local inventory/classification of the existing .ai/ and docs/ structure before any physical restructuring.

The central working boundary is:

> If the primary subject is how AI should work with the project, it belongs in .ai/. If the primary subject is what AIP Mirror is or how it works, it belongs in docs/.

## Major architectural decisions reached in 03AU

### .ai is portable AI infrastructure

The .ai directory should be reusable when the repository is adapted to another project.

Project-specific material must not be embedded in supposedly generic .ai files.

When .ai is migrated to another project:
- reusable infrastructure remains;
- current project handoffs can be removed/cleared;
- archive can be cleared or selectively retained;
- the new project's docs/ is populated independently.

This explains why several current .ai files are now recognized as misclassified: they describe AIP Mirror itself.

### docs is project knowledge

docs/ contains AIP Mirror-specific:
- architecture;
- implementation/design;
- Illustrator/FreeHand research;
- specifications;
- validated behavior;
- project decisions;
- project-specific development knowledge.

Root references/ remains AIP Mirror-specific and is not part of this .ai restructuring.

### .ai/architecture exists conceptually

A new .ai/architecture/ area is now accepted.

Exact subfolders and exact filenames remain open.

Historical AI-infrastructure research will likely move into .ai/archive/.

### Handoffs

docs/handoffs/ is AI conversation state, not AIP Mirror project documentation.

The likely target is:

    docs/handoffs/
        -> .ai/handoffs/

This is a target decision, not yet a physical move.

### Shorter handoff/skill naming

The current folder:

    .ai/skills/conversation-handoff/

is considered unnecessarily verbose.

Working target:

    .ai/skills/handoff/

Likewise:

    .ai/rules/conversation-lifecycle.md
        -> .ai/rules/handoff/lifecycle.md

and:

    .ai/rules/handoff-references.md
        -> .ai/rules/handoff/references.md

No physical move has been made yet.

## Repository entry points

Three distinct roles are now the working model:

    README.md
        -> human-facing repository introduction

    AGENTS.md
        -> small AI repository entry point

    .ai/INDEX.md
        -> operational map of AI infrastructure

AGENTS.md must not become a copy of .ai/INDEX.md.

No nested AGENTS.md is currently needed.

The root README.md is currently empty, so there is no historical content that must be preserved there.

## docs/PROJECT-INSTRUCTIONS.md

Do not move or rename this file yet.

It is mixed and likely needs decomposition:

    docs/PROJECT-INSTRUCTIONS.md
        |
        +-- AIP Mirror project knowledge -> docs/...
        +-- AI infrastructure -> .ai/...
        +-- repository entry point -> AGENTS.md

Whether a reduced PROJECT-INSTRUCTIONS.md survives is still open.

## Important classification findings

### Clearly project-specific and therefore not portable .ai

.ai/rules/project-architecture.md describes AIP Mirror architecture, including JSX/native boundaries, C++/AIP, geometry, FreeHand behavior, CEP/UXP, and AIP Mirror specializations.

Working target:

    docs/architecture/...

It should not remain a generic .ai rule.

.ai/rules/workflow.md is also substantially AIP Mirror-specific. It contains the AIP Mirror development cycle, four specializations, chapter numbering, and Workshop boundaries.

It likely requires decomposition into project documentation plus any genuinely generic AI workflow material.

.ai/rules/repository.md mixes project-specific repository facts with AI working behavior and requires content-level decomposition.

### Clearly .ai infrastructure

docs/architecture/ai-project-instruction-architecture.md is AI infrastructure architecture and belongs conceptually under:

    .ai/architecture/...

The exact name remains open.

docs/architecture/independent-review-deepseek-onboarding.md
docs/architecture/independent-review-grok-onboarding.md
docs/architecture/independent-review-qwen-onboarding.md

are AI onboarding/workflow material and are candidates for:

    .ai/workflows/independent-review/...

### Historical .ai research

The following are strong .ai/archive candidates:

- architectural-bottleneck-audit-03AP.md
- architectural-bottleneck-cross-audit-03AP.md
- c-13-authority-vs-effective-outcome-03AP.md
- c-14-override-semantic-dimension-03AP.md
- constraint-problem-map-03AS.md
- intentional-acceptance-audit-03AP.md
- mec-dynamic-context-03AT.md
- minimal-execution-context-03AS.md
- post-c-13-architectural-leverage-audit-03AP.md
- prerequisite-dependency-semantics.md
- semantic-source-authority-audit-03AP.md

Reason: these primarily concern abstract AI/project-instruction infrastructure rather than AIP Mirror product architecture.

MEC remains historical. Do not reintroduce "bootstrap kernel" as an architecture term.

## New filename convention

A new working naming rule was proposed for documents produced by a specialization/chapter.

Old style:

    architectural-bottleneck-cross-audit-03AP.md

New style:

    03AP_architectural-bottleneck-cross-audit.md

For 03AU:

    03AU_document-name.md

Reason:
- chapter identity is immediately visible;
- files sort naturally by chapter;
- provenance is visible without a suffix;
- underscore is preferred for now.

Do not mass-rename historical files yet.

Treat this as a working rule for new chapter-produced documents. Formalize it in the canonical rule set after the inventory/target-tree review.

## Durable working material

The accumulated restructuring work has been preserved in:

    .ai/architecture/03AU_ai-infrastructure-restructuring.md

This file contains the working hypotheses, diagrams, classification findings, target-tree sketches, naming proposal, accepted decisions, open questions, and next work package.

It was created and committed during 03AU.

## Current target-tree hypothesis

Conceptually:

    .ai/
    +-- INDEX.md
    +-- rules/
    |   +-- handoff/
    |   +-- repository/
    |   +-- ...
    +-- skills/
    |   +-- handoff/
    |   +-- commit-message/
    |   +-- deep-understanding/
    |   +-- ...
    +-- workflows/
    |   +-- handoff-bootstrap/
    |   +-- independent-review/
    |   +-- ...
    +-- references/
    +-- handoffs/
    +-- architecture/
    +-- archive/

This is not the final tree.

## What has actually changed in the repository during this chapter

No existing project files were moved or deleted.

Created:

    .ai/architecture/03AU_ai-infrastructure-restructuring.md

Commit:

    1dbee551106f398d18efc53ddd4e756b9facb83c

The new file was read back from GitHub after creation and verified to contain the preserved working material.

## Immediate next task

Do not jump to Grok/Qwen review yet.

Finish the local inventory/classification first.

For every relevant existing document, classify:

    KEEP
    MOVE
    DECOMPOSE
    ARCHIVE

Record:
- current path;
- primary subject;
- type;
- target layer;
- current problem;
- proposed action;
- unresolved question.

Priority:

1. all .ai/rules/
2. all .ai/skills/
3. docs/PROJECT-INSTRUCTIONS.md
4. all docs/architecture/
5. all docs/handoffs/
6. README.md
7. planned AGENTS.md

Then:

1. produce the first complete target tree;
2. identify decomposition/merge/split operations;
3. preserve the chapter-prefix naming proposal;
4. obtain independent Grok and Qwen alternatives;
5. compare them;
6. only then perform physical moves/merges/splits.

## Open questions

Do not silently resolve:
- exact .ai/architecture taxonomy;
- exact architecture filenames;
- exact rules/skills/workflows taxonomy;
- exact AGENTS.md contents;
- exact README.md contents;
- exact .ai/INDEX.md format;
- command syntax and operation IDs;
- section/fragment ID conventions;
- exact split of .ai/rules/repository.md;
- exact split of .ai/rules/workflow.md;
- whether docs/PROJECT-INSTRUCTIONS.md survives in reduced form;
- whether historical files should later be renamed to the chapter-prefix convention.

## Repository safety

For existing-file mutations:

READ CURRENT FILE -> minimal change -> WRITE COMPLETE FILE -> READ BACK -> VERIFY CONTENT -> INSPECT DIFF -> VERIFY SCOPE -> COMMIT -> VERIFY RESULT.

Do not physically restructure the repository until the target classification has been completed and reviewed.

## Bootstrap instruction for successor

Initialize the next chapter as:

    CURRENT_CHAPTER = 03AU
    NEXT_CHAPTER = 03AV
    SPECIALIZATION = 03 — Architecture & Research
    REPOSITORY = paulhuman/aip-mirror
    BRANCH = main

Before continuing research:

1. Read .ai/skills/conversation-handoff/BOOTSTRAP.md.
2. Read .ai/skills/conversation-handoff/SKILL.md.
3. Read the applicable .ai/rules, especially conversation-lifecycle.md, workflow.md, repository.md, and handoff-references.md.
4. Read this handoff completely.
5. Read .ai/architecture/03AU_ai-infrastructure-restructuring.md completely; it is the primary durable 03AU research context.
6. Verify the repository state and the existence/readability of the referenced files.
7. Create docs/handoffs/03AV-Architecture-Research.md with status DRAFT as part of bootstrap, then commit it according to the handoff lifecycle.
8. After bootstrap verification, continue from the Immediate next task below. Do not restart the architectural reasoning from conversation history.

The successor must preserve the current boundary: .ai is portable AI infrastructure; docs is AIP Mirror project knowledge. Do not physically move, rename, merge, split, or delete files merely because the target tree is sketched here. Complete the local inventory/classification first, then target-tree review, then independent Grok/Qwen review, and only then physical restructuring.

Do not use “bootstrap kernel” as an architecture term. The current working language is “non-empty initial active context” where that concept is needed historically or descriptively.

## Recommended starting context for next chapter

1. .ai/architecture/03AU_ai-infrastructure-restructuring.md
2. this handoff
3. docs/PROJECT-INSTRUCTIONS.md
4. .ai/skills/conversation-handoff/BOOTSTRAP.md
5. .ai/skills/conversation-handoff/SKILL.md
6. .ai/rules/conversation-lifecycle.md
7. .ai/rules/workflow.md
8. .ai/rules/repository.md
9. .ai/rules/handoff-references.md
10. docs/architecture/ai-project-instruction-architecture.md

The new architecture working file should be treated as the main preserved 03AU research context; do not rely on conversation history to reconstruct the restructuring reasoning.
