# Conversation handoffs

This directory contains durable state snapshots for AIP Mirror conversation chapters.

A chat is a finite working context. The repository is the durable project memory.

## Naming

Use the specialization number and the current two-letter Chapter Identifier Format:

    [0-9]{2}[A-Z]{2}

The first two digits identify the specialization. The final two uppercase letters identify the chapter using a continuous base-26 alphabetical sequence:

    AA → AB → ... → AZ → BA → BB → ... → BZ → CA → ... → ZZ

No letters are skipped.

The sequence is positional and mathematical:

    AA = chapter ordinal 1
    AB = chapter ordinal 2
    AC = chapter ordinal 3
    ...
    AE = chapter ordinal 5
    AF = chapter ordinal 6
    ...
    ZZ = chapter ordinal 676

The ordinal position of a chapter must not be confused with the identity of its identifier.

### Legacy historical identifiers

The former Chapter Identifier Format used a single uppercase letter:

    [0-9]{2}[A-Z]

Identifiers created under that format remain valid historical identifiers. They MUST NOT be rewritten merely to conform to the current Chapter Identifier Format, and a legacy identifier MUST NOT be interpreted as a current-format identifier.

Legacy and current identifiers occupy different identifier namespaces by format. Historical handoff documents retain their original chapter identifiers and filenames.

Historical chapters occupy their existing ordinal positions when the current format is introduced. They are not renamed into the current format. New chapters continue from the next unused ordinal position.

For specialization `03`, the historical/current ordinal correspondence is:

    ordinal   legacy ID   current-format position

    1         03A         AA
    2         03B         AB
    3         03C         AC
    4         03D         AD
    5         03E         AE
    6         —           AF  ← first new-format Chapter

This is **ordinal correspondence only**. It does NOT establish identifier identity. In particular:

    03A ≠ 03AA
    03B ≠ 03AB
    03C ≠ 03AC
    03D ≠ 03AD
    03E ≠ 03AE

`03AA`–`03AE` are not historical aliases and are not physically used as current identifiers in this repository.

The specialization number remains fixed within a workstream; the two-letter chapter suffix advances continuously by ordinal position.

## Current specializations

AIP Mirror currently has four complementary conversation specializations:

- `01` — JSX Prototype
- `02` — Native AIP Plugin
- `03` — Architecture & Research
- `04` — Project Workshop

A specific chapter is identified by its concrete chapter ID. Do not encode a single concrete chapter as the permanent project-wide "current chapter" here; chapter-specific state belongs in its handoff document.

## Purpose

A handoff records conversation-specific state needed to continue work safely in the next chapter.

It is not a replacement for normal project documentation.

## Project Workshop

`04 — Project Workshop` is the project's practical support and learning workspace. It is intended for IDE and toolchain configuration, CMake/build setup, Git commands and repository mechanics, SDK/tooling setup, ChatGPT interface questions, debugging of development-environment problems, and other routine technical questions that would otherwise distract from the primary workstreams.

The Workshop does not own project architecture, FreeHand research, JSX implementation, or native AIP implementation. Durable decisions produced there should be moved into the appropriate repository documentation.

## Required distinction

Handoffs must distinguish confirmed observations from inferences, assumptions, and open questions.

See `.ai/skills/conversation-handoff/SKILL.md` and `.ai/rules/conversation-lifecycle.md` for the workflow and format.
