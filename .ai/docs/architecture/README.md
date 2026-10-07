# Architecture notes

This directory contains durable architecture context for the `.ai` infrastructure.

The files here preserve longer-lived reasoning, architectural decisions, research results, historical context, and bounded open questions that would be too large or too detailed for ordinary handoffs or active `.ai` rules, skills, and workflows.

## Purpose

Architecture notes exist to prevent later chapters from reconstructing important infrastructure decisions from conversation history alone.

They are the **large durable-memory layer** for `.ai` architecture work:

```text
.ai/handoffs/
    = small chapter continuity snapshots

.ai/docs/architecture/
    = larger durable architecture context
```

An architecture file may contain the reasoning and history behind a decision while the active semantic owner remains elsewhere in `.ai`.

## Architecture FAQ and usage notes

The `.ai/docs/faq/` directory contains small, human-oriented explanations of how the `.ai` infrastructure is used in practice.

These files are durable orientation material, not canonical semantic owners. They MAY answer practical “how does this work?” questions in more detail than an active rule or skill SHOULD.

Prefer separate files for separate questions rather than accumulating unrelated answers in one large document.

When a practical explanation describes an active semantic rule, skill, or workflow, the canonical owner remains authoritative. FAQ material SHOULD explain or illustrate that owner rather than redefine it.

## Tests and results

The `.ai/tests/scenarios/` directory contains reproducible architecture-level test scenarios for validating AI-infrastructure behavior.

Test scenario files define the reusable test input and expected pass criteria. They are not runtime results and SHOULD remain stable between runs unless the test definition itself is intentionally revised.

The `.ai/tests/results/` subtree contains separate result artifacts for individual test runs. Each result records the tested repository revision, execution context, observed behavior, deviations, and pass/fail outcome without replacing the reusable scenario.

This separation keeps the test definition distinct from historical evidence:

```text
.ai/tests/scenarios/
    = reusable architecture test scenarios

.ai/tests/results/
    = per-run historical test evidence
```

Architecture tests are durable infrastructure evidence, not active semantic owners. Their scenarios and results MUST NOT be treated as replacements for the canonical rule, skill, workflow, or other owner being tested.

## Ownership boundary

Architecture notes are **not active execution owners**.

They MUST NOT become replacements for:

- `.ai/rules/` — canonical semantic constraints;
- `.ai/skills/` — reusable capabilities;
- `.ai/workflows/` — ordered procedures;
- `.ai/INDEX.md` — routing and capability discovery.

When an architectural decision becomes an active rule, skill, workflow, or other operational semantic, the active owner MUST contain the usable definition. The architecture note preserves the durable explanation and history rather than becoming a second owner.

## When to read

Read the relevant architecture note when:

- continuing architecture or research work;
- investigating why an infrastructure decision was made;
- resolving a bounded architectural question recorded there;
- reviewing historical restructuring decisions;
- validating that an active owner still agrees with its durable architectural record.

Do not read the entire directory as a routine prerequisite for ordinary operations.

## Relationship to handoffs

A handoff records the current chapter's durable working state so a receiving chapter can continue without guessing.

An architecture note records durable architecture context that may remain useful across many chapters.

The same subject MAY therefore appear in both layers, but with different responsibilities:

```text
handoff
    = what this chapter needs to continue

architecture note
    = why the architecture is this way and what durable decisions/history matter
```

A handoff SHOULD point to relevant architecture notes when they are part of the chapter's starting context. The architecture note SHOULD NOT be copied wholesale into the handoff.

## Lifecycle and archive boundary

Architecture notes are working durable memory, not permanent active infrastructure.

When an architecture investigation is complete and its remaining useful content has been incorporated into the appropriate active owners or otherwise preserved as historical evidence, the architecture files MAY be moved to `.ai/archives/docs/architecture/` according to the repository's archive rules.

The archive is outside the active `.ai` scan.

## README role

This README provides orientation for the directory. It does not define architecture decisions and is not a runtime activation owner.
