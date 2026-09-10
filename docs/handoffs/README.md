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

    04A-Project-Workshop.md
    04B-Project-Workshop.md

## Current specializations

AIP Mirror currently has four complementary conversation specializations:

- `01` — JSX Prototype
- `02` — Native AIP Plugin
- `03` — Architecture & Research
- `04` — Project Workshop

The current chapters are `01A`, `02A`, `03A`, and `04A`.

## Purpose

A handoff records conversation-specific state needed to continue work safely in the next chapter.

It is not a replacement for normal project documentation.

## Project Workshop

`04 — Project Workshop` is the project's practical support and learning workspace. It is intended for IDE and toolchain configuration, CMake/build setup, Git commands and repository mechanics, SDK/tooling setup, ChatGPT interface questions, debugging of development-environment problems, and other routine technical questions that would otherwise distract from the primary workstreams.

The Workshop does not own project architecture, FreeHand research, JSX implementation, or native AIP implementation. Durable decisions produced there should be moved into the appropriate repository documentation.

## Required distinction

Handoffs must distinguish confirmed observations from inferences, assumptions, and open questions.

See `.ai/skills/conversation-handoff/SKILL.md` and `.ai/rules/conversation-lifecycle.md` for the workflow and format.
