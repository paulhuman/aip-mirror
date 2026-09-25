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

## Specialization directories

Handoffs are grouped by specialization under `.ai/handoffs/<specialization>/`.

The README does not maintain a project-wide specialization registry. Specialization identity and chapter-specific state belong to the applicable project documentation and handoff files.

## Purpose

A handoff records conversation-specific state needed to continue work safely in the next chapter.

It is not a replacement for normal project documentation.

## Project Workshop

`04 — Project Workshop` is the project's practical support and learning workspace. It is intended for IDE and toolchain configuration, CMake/build setup, Git commands and repository mechanics, SDK/tooling setup, ChatGPT interface questions, debugging of development-environment problems, and other routine technical questions that would otherwise distract from the primary workstreams.

The Workshop does not own project architecture, FreeHand research, JSX implementation, or native AIP implementation. Durable decisions produced there should be moved into the appropriate repository documentation.

## Required distinction

Handoffs must distinguish confirmed observations from inferences, assumptions, and open questions.

See `.ai/skills/handoff/SKILL.md` and `.ai/rules/handoff/lifecycle.md` for the workflow and format.
