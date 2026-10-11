---
name: ai-infrastructure
description: Switch the working domain to the repository's AI infrastructure and establish elevated active-infrastructure context without loading historical archives.
---

# AI-infrastructure context mode

Use this skill when the user requests the `>>ai-infrastructure` operation or otherwise explicitly switches the working domain to the repository's AI infrastructure.

## Semantic meaning

`>>ai-infrastructure` means:

> Switch the AI's working domain to the repository's AI-infrastructure rather than project-specific implementation, and load elevated infrastructure context before proceeding.

This is a domain/context switch, not an indiscriminate repository-wide context load.

## Activation

Before executing the operation, activate the canonical owners required by this operation:

    .ai/skills/repository/SKILL.md
    .ai/skills/workflow/SKILL.md
    .ai/skills/activation/SKILL.md
    .ai/skills/normative-language/SKILL.md
    .ai/INDEX.md

The current repository versions are authoritative. Normative-language semantics are owned by `.ai/skills/normative-language/SKILL.md`.

## Elevated context

Establish the following context in this order.

### Normative-language activation

`>>ai-infrastructure` MUST activate the normative-language capability because the mode operates on the active `.ai` infrastructure layer.

Read:

    .ai/skills/normative-language/SKILL.md

This is dependency activation of the canonical normative-language skill.

### Repository-level orientation

Read:

    AGENTS.md
    README.md
    docs/PROJECT-INSTRUCTIONS.md

These provide project identity and the project-specific boundary that MUST remain distinct from the AI-infrastructure layer.

### AI-infrastructure orientation

Read:

    .ai/README.md
    .ai/AGENTS.md
    .ai/INDEX.md
    .ai/config.yaml

Discover the current set of `README.md` files from the repository tree. Read the README files of active subsystems needed for broad orientation. In particular, read `.ai/archives/README.md` to understand the archive boundary, but DO NOT automatically read `.ai/archives/**`.

Use README files for subsystem orientation, navigation, and additional context; they MUST NOT replace canonical semantic owners. Reading a README does not imply reading every document in its directory.

### Active infrastructure semantics

Survey the active `.ai/docs/` tree to establish what durable architecture, FAQ, and other infrastructure documentation exists.

Read `.ai/docs/ai-document-hierarchy-and-authoring.md` as the maintained orientation guide for document hierarchy, semantic ownership, and authoring boundaries. It provides architectural rationale and orientation; it does not replace canonical owners.

The survey is an orientation step. DO NOT automatically read every large architecture document in full.

Read deeper architecture or FAQ documents only when the current task requires them.

## Context boundary

The normal elevated context is therefore:

    repository orientation
        +
    active .ai orientation
        +
    active infrastructure documentation survey
        +
    archive boundary README

and explicitly excludes archive contents.

Do not turn this operation into a second routing registry, semantic owner, dependency graph, or permanent requirement to read every architecture document.

## Progressive disclosure

After elevated context is established:

1. identify the actual infrastructure question;
2. locate its canonical semantic owner;
3. reread that owner before executing the requested operation;
4. read deeper architecture/history only when justified by the bounded question;
5. preserve the active/archive boundary.

The operation establishes orientation; it does not itself perform arbitrary `.ai` mutations.

## TRACE

Because this is a user-facing `>>` command, operation-level TRACE follows the canonical contract in:

    .ai/skills/activation/SKILL.md

The TRACE MUST report the canonical owners actually reread and the additional repository files actually read for this operation. Archive contents MUST NOT appear in the normal operation read set merely because the archive exists.

## Boundary

    user command
        ↓
    .ai/INDEX.md
        ↓
    ACTIVATE
        ↓
    .ai/skills/ai-infrastructure/SKILL.md
        ↓
    elevated active-infrastructure context
        ↓
    bounded infrastructure operation
