---
name: handoff-reference-preservation
description: Explicitly preserve material research references for conversation handoffs while excluding incidental browsing; conversational-only, not an ordinary discovered agent skill.
---

# Handoff reference preservation

Use this skill when preparing or reviewing a conversation handoff to determine which research references must survive into the next chapter.

## Goal

Preserve continuity without turning handoffs into internet transcript dumps. Repository handoff state MUST outlive the conversation that created it; a later chapter MUST NOT have to reconstruct a material reference from the old conversation.

A handoff SHOULD carry forward the **material research reference points** needed to understand, validate, or continue the work represented by the handoff.

## Repository path resolution

Repository identity and path resolution are owned by `.ai/skills/repository/SKILL.md`. When a reference MUST remain reproducible against a specific branch, tag, or commit, use:

    <repository>@<ref>:/path

## Material reference test

A reference is material when losing it would materially increase the risk that the next chapter will:

- misunderstand an important decision or its rationale;
- be unable to validate a recorded conclusion;
- repeat research unnecessarily;
- lose a known external implementation, specification, repository, document, or other meaningful evidence;
- incorrectly infer why a source was relevant.

DO NOT preserve every URL that was opened during research. Incidental browsing and temporary exploration do not belong in the handoff unless they became materially relevant.

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

The Role SHOULD be short but specific enough that a future chapter will not need the original conversation to remember why the reference was collected.

## Reference authority

A preserved reference is evidence/source material. Its presence in a handoff does not make it a RULE, grant it authority, or override project decisions.

## Handoff review procedure

When reviewing a handoff:

1. identify decisions, conclusions, assumptions, and open questions that depend on external research;
2. identify the external references that materially support or explain them;
3. preserve those references with Role metadata;
4. deliberately exclude incidental browsing;
5. verify that the next chapter can understand why each preserved reference matters without the old conversation.

Before a handoff is considered ready for the next chapter, also check:

1. Which external references materially support the decisions or conclusions being transferred?
2. Could the next chapter understand why those references mattered without the old conversation?
3. Does each preserved reference have enough identity to locate it again?
4. Does each preserved reference have a concise Role?
5. Have incidental links been deliberately excluded rather than copied indiscriminately?

If a material reference is missing, the handoff is incomplete until the reference is preserved or the reason for its exclusion is explicitly documented.

If a material reference cannot be identified confidently, record the uncertainty rather than inventing its purpose.

## Project-agnosticity

This skill is reusable across projects. Concrete repositories, documents, URLs, and research roles belong in the handoff or project documentation, not in this skill.
