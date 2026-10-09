# Conversation handoffs

This directory contains durable state snapshots for conversation chapters.

A chat is a finite working context. The repository is the durable project record.

## Naming

Use the current Chapter Identifier Format defined canonically by `.ai/conversation-management/handoff/SKILL.md`.

Handoff filenames use the full `CHAPTER_ID` and the resolved `SHORT_NAME` in filename-safe form:

    <CHAPTER_ID>-<FILENAME_SHORT_NAME>.md

`CHAPTER_ID = SPECIALIZATION + CURRENT_CHAPTER`.
`FILENAME_SHORT_NAME` is derived from `SHORT_NAME` by replacing spaces with hyphens.

For example:

    SPECIALIZATION = A
    CURRENT_CHAPTER = 0001
    CHAPTER_ID = A0001
    SHORT_NAME = Project Workshop
    FILENAME_SHORT_NAME = Project-Workshop

    .ai/handoffs/A/A0001-Project-Workshop.md

Handoff filenames use `CHAPTER_ID`, not `CURRENT_CHAPTER` alone. The filename component is derived from `SHORT_NAME`; it is not a separate conversation-title value.

The README provides naming orientation only; it does not redefine the chapter identifier format or sequence.

## Specialization directories

Handoffs are grouped by specialization under `.ai/handoffs/<specialization>/`.

The README does not maintain a project-wide specialization registry. Specialization identity and chapter-specific state belong to the applicable project documentation and handoff files.

## Purpose

A handoff records conversation-specific state needed to continue work safely in the next chapter.

It is not a replacement for normal project documentation.

## Required distinction

Handoffs MUST distinguish confirmed observations from inferences, assumptions, and open questions.

See `.ai/conversation-management/handoff/SKILL.md` for the workflow and format.
