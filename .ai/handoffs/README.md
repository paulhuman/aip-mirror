# Conversation handoffs

This directory contains durable state snapshots for conversation chapters.

A chat is a finite working context. The repository is the durable project record.

## Naming

Use the current Chapter Identifier Format defined canonically by `.ai/rules/handoff/lifecycle.md`.

Handoff filenames use:

    <chapter>-<short-name>.md

The README provides naming orientation only; it does not redefine the chapter identifier format or sequence.

## Specialization directories

Handoffs are grouped by specialization under `.ai/handoffs/<specialization>/`.

The README does not maintain a project-wide specialization registry. Specialization identity and chapter-specific state belong to the applicable project documentation and handoff files.

## Purpose

A handoff records conversation-specific state needed to continue work safely in the next chapter.

It is not a replacement for normal project documentation.

## Required distinction

Handoffs MUST distinguish confirmed observations from inferences, assumptions, and open questions.

See `.ai/skills/handoff/SKILL.md` and `.ai/rules/handoff/lifecycle.md` for the workflow and format.
