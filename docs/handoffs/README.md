# Conversation handoffs

This directory contains durable state snapshots for AIP Mirror conversation chapters.

A chat is a finite working context. The repository is the durable project memory.

## Naming

Use the specialization number and chapter letter. The generic chapter identifier is `[0-9]{2}[A-Z]`:

    01[A-Z]-JSX-Prototype.md
    02[A-Z]-Native-AIP-Plugin.md
    03[A-Z]-Architecture-Research.md
    04[A-Z]-Project-Workshop.md

For example, concrete chapters may be:

    01A-JSX-Prototype.md
    02B-Native-AIP-Plugin.md
    03A-Architecture-Research.md
    04A-Project-Workshop.md

The specialization number remains fixed within a workstream; the chapter letter advances alphabetically.

## Current specializations

AIP Mirror currently has four complementary conversation specializations:

- `01` — JSX Prototype
- `02` — Native AIP Plugin
- `03` — Architecture & Research
- `04` — Project Workshop

A specific chapter is identified by its concrete chapter ID, such as `03A` or `02B`. Do not encode a single concrete chapter as the permanent project-wide "current chapter" here; chapter-specific state belongs in its handoff document.

## Purpose

A handoff records conversation-specific state needed to continue work safely in the next chapter.

It is not a replacement for normal project documentation.

## Project Workshop

`04 — Project Workshop` is the project's practical support and learning workspace. It is intended for IDE and toolchain configuration, CMake/build setup, Git commands and repository mechanics, SDK/tooling setup, ChatGPT interface questions, debugging of development-environment problems, and other routine technical questions that would otherwise distract from the primary workstreams.

The Workshop does not own project architecture, FreeHand research, JSX implementation, or native AIP implementation. Durable decisions produced there should be moved into the appropriate repository documentation.

## Required distinction

Handoffs must distinguish confirmed observations from inferences, assumptions, and open questions.

See `.ai/skills/conversation-handoff/SKILL.md` and `.ai/rules/conversation-lifecycle.md` for the workflow and format.
