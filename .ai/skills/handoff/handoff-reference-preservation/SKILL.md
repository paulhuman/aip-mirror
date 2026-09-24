---
name: handoff-reference-preservation
description: Identify and preserve research references that are materially required for a conversation handoff, while excluding incidental browsing.
---

# Handoff reference preservation

Use this skill when preparing or reviewing a conversation handoff to determine which research references must survive into the next chapter.

## Goal

Preserve continuity without turning handoffs into internet transcript dumps.

A handoff should carry forward the **material research reference points** needed to understand, validate, or continue the work represented by the handoff.

## Material reference test

A reference is material when losing it would materially increase the risk that the next chapter will:

- misunderstand an important decision or its rationale;
- be unable to validate a recorded conclusion;
- repeat research unnecessarily;
- lose a known external implementation, specification, repository, document, or other meaningful evidence;
- incorrectly infer why a source was relevant.

Do not preserve every URL that was opened during research. Incidental browsing and temporary exploration do not belong in the handoff unless they became materially relevant.

## Required metadata

For each preserved external reference, record:

- identity;
- Role — why the reference matters;
- URL;
- upstream/parent relationship when relevant, especially for forks.

Recommended format:

```text
## Research references

### External repositories

- <owner>/<repository>
  - Fork of: <upstream repository, if applicable>
  - Role: <why this reference matters>
  - URL: <canonical URL>
```

The Role should be short but specific enough that a future chapter will not need the original conversation to remember why the reference was collected.

## Reference authority

A preserved reference is evidence/source material. Its presence in a handoff does not make it a RULE, grant it authority, or override project decisions.

## Handoff review procedure

When reviewing a handoff:

1. identify decisions, conclusions, assumptions, and open questions that depend on external research;
2. identify the external references that materially support or explain them;
3. preserve those references with Role metadata;
4. deliberately exclude incidental browsing;
5. verify that the next chapter can understand why each preserved reference matters without the old conversation.

If a material reference cannot be identified confidently, record the uncertainty rather than inventing its purpose.

## Project-agnosticity

This skill is reusable across projects. Concrete repositories, documents, URLs, and research roles belong in the handoff or project documentation, not in this skill.
