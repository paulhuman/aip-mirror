# Conversation Management

## Purpose

This directory contains the procedures and human-facing templates used to preserve continuity across conversations: handoffs, chapter initialization, migration, and related reference preservation.

## Conversational AI, not Agentic AI

**This area is designed for Conversational AI workflows—not for Agentic AI task execution.**

Conversational AI works through an ongoing dialogue with a person. The procedures here help carry intent, decisions, constraints, and unfinished work from one conversation chapter to the next. They are invoked deliberately when conversation continuity is needed.

Agentic AI, by contrast, performs bounded tasks through tool use and an execution workflow. General-purpose agent capabilities and their canonical operational instructions belong in `.ai/skills/` or other explicitly designated active infrastructure locations—not here merely because they mention a conversation or handoff.

The distinction is about the intended operating mode, not the file format: these documents may contain procedural instructions, but they exist to support **human-guided conversational continuity**, rather than to serve as ordinary skills discovered and run by an autonomous agent.

## Contents

- `handoff/` — explicitly invoked procedures for handoff checkpoints, chapter migration, bootstrap, and reference preservation.
- `templates/` — human-facing copy/paste templates, including manual bootstrap and independent-review onboarding templates.

## Usage boundary

- Use these procedures when preparing, continuing, or transferring conversational context.
- Keep reusable Agentic AI capabilities in their canonical skill or workflow locations.
- Keep chapter state and handoff records under `.ai/handoffs/`; this directory contains the procedures and templates, not the chapter records themselves.
- Treat this README as orientation only. The canonical procedure files remain authoritative.
