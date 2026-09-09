# Conversation handoffs

This directory contains durable state snapshots for AIP Mirror conversation chapters.

A chat is a finite working context. The repository is the durable project memory.

## Naming

Use the specialization number and chapter letter:

    01A-JSX-Prototype.md
    01B-JSX-Prototype.md

    02A-Native-AIP-Plugin.md
    02B-Native-AIP-Plugin.md

    03A-Architecture-Research.md
    03B-Architecture-Research.md

## Purpose

A handoff records conversation-specific state needed to continue work safely in the next chapter.

It is not a replacement for normal project documentation.

## Required distinction

Handoffs must distinguish confirmed observations from inferences, assumptions, and open questions.

See `.ai/skills/conversation-handoff/SKILL.md` and `.ai/rules/conversation-lifecycle.md` for the workflow and format.
