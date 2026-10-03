---
name: handoff
description: Create a durable state snapshot when a conversation approaches a contextual limit, reaches a major milestone, or is being continued in a new chapter.
---

# Conversation handoff

Use this skill to preserve the working state of a conversation before continuing in a new chapter.

The goal is continuity without requiring the next conversation to reconstruct important state from an old chat.

## Repository paths

Repository identity and path resolution are owned by `.ai/rules/repository.md`. This skill does not redefine those rules.

## When to use

Use this skill when:

- contextual risk is becoming significant;
- the user asks to continue in a new chapter;
- a major milestone has been reached;
- the current conversation is becoming very long or technically dense;
- important working state exists only in the conversation.

DO NOT create a handoff for every ordinary message.

## Important limitation

DO NOT claim to know an exact remaining context percentage or exact number of remaining messages.

Use qualitative contextual-risk assessment instead.

## Repository write-capability self-check

Before any handoff operation that could modify the repository, the AI MUST determine which capability applies:

- **WRITE-CAPABLE AI** — the AI can create/update repository files and create commits in the target repository.
- **READ-ONLY AI** — the AI can inspect repository contents but cannot create/update repository files or create commits.
- **UNCERTAIN** — if write capability cannot be reliably established, treat the AI as READ-ONLY AI.

Follow exactly one capability branch in the relevant handoff procedure. A WRITE-CAPABLE AI MUST ignore READ-ONLY instructions; a READ-ONLY AI MUST ignore repository-write instructions.

An AI MUST NOT claim a repository operation or lifecycle transition occurred unless it actually performed and verified it.

## Output location

Create or update the applicable file under:

    .ai/handoffs/<specialization>/

Naming convention:

    <chapter>-<short-name>.md

The Chapter Identifier Format is defined canonically by `.ai/rules/handoff/lifecycle.md`.

Use that rule for the exact identifier format and sequence; this skill only uses the identifier when naming and operating on handoff files.

## Handoff structure

Use this canonical structure for every handoff:

    # Conversation Handoff

    **Conversation:**
    <chapter> — <SHORT_NAME>

    **Specialization:**
    <A-Z>

    **Chapter:**
    <0001-9999>

    **Previous chapter:**
    <previous chapter number or N/A>

Header field rules:

- `SHORT_NAME` is the canonical short conversation title.
- `Conversation` contains the full chapter identifier followed by `SHORT_NAME`.
- DO NOT include the project name prefix in `Conversation`.
- `Specialization` contains only the specialization letter.
- `Chapter` contains only the four-digit chapter number.
- `Previous chapter` contains only the previous chapter's four-digit number, or `N/A` when this is the first chapter in the specialization.
- DO NOT include the specialization letter in the `Chapter` or `Previous chapter` field.
- Use bold Markdown (`**...:**`) for every header field name exactly as shown above.
- The full chapter identifier is formed from `Specialization` + `Chapter`; for example, `A` + `0001` = `A0001`.
  Chapter numbering is one-based: the first chapter is `0001`, and `0000` MUST NOT be used as a chapter number.
- The handoff filename uses the full chapter identifier: `<chapter>-<short-name>.md`.

Example:

    # Conversation Handoff

    **Conversation:**
    A0001 — Project Workshop

    **Specialization:**
    A

    **Chapter:**
    0001

    **Previous chapter:**
    N/A

## New chapter initialization

New chapter initialization is operationally defined by `.ai/workflows/handoff/BOOTSTRAP.md`.

This skill provides the handoff capability and structure; it does not duplicate the bootstrap procedure. When a new chapter is initialized, follow the applicable capability branch and verification sequence in BOOTSTRAP.md.

## Checkpoint updates

The user MAY request a checkpoint with:

    >>handoff

A WRITE-CAPABLE AI MUST create the handoff if absent, update it with current durable state, preserve the canonical header, verify content and scope, and commit the checkpoint. A READ-ONLY AI MUST prepare the complete proposed handoff and exact manual commit message without claiming repository writes.

Checkpoint updates MAY be repeated when meaningful state accumulates.

## Migration

When the user requests migration with `>>migrate <chapter>`, the migration target is ALWAYS derived as exactly one increment from the current chapter:

    TARGET_CHAPTER = CURRENT_CHAPTER_CONTEXT + 1

The numeric `<chapter>` argument is a user assertion of the expected next chapter and a safety/validation input. It MUST NOT select a different target.

Before migration, determine `CURRENT_CHAPTER_CONTEXT` as follows.

### Recovery evidence set

When active conversation/bootstrap context does not establish `CURRENT_CHAPTER_CONTEXT`, inspect both repository handoff locations for the current specialization:

    .ai/handoffs/<SPECIALIZATION>/
    .ai/archive/handoffs/<SPECIALIZATION>/

Both locations are repository evidence. Location alone MUST NOT determine the current chapter.

For each candidate handoff, validate its semantic identity from its canonical header:

    Specialization = <SPECIALIZATION>
    Chapter = <four-digit chapter>

The filename MAY be checked as an additional consistency signal, but it MUST NOT replace validation of the header.

Recovery MUST classify the result as:

- **KNOWN** — the active conversation/bootstrap context establishes the chapter.
- **RECOVERED** — repository evidence establishes exactly one chapter consistent with lifecycle continuity.
- **UNKNOWN** — evidence is absent, insufficient, or contradictory and no deterministic chapter can be established.

### Deterministic recovery cases

The recovery procedure MUST handle these cases explicitly:

1. **Active evidence** — a valid active handoff MAY establish the candidate chapter when continuity is unambiguous.
2. **Archive-only evidence** — a valid archived handoff MAY establish the candidate chapter when active evidence is absent and continuity is unambiguous.
3. **First chapter / no handoff evidence** — absence of handoffs does not by itself prove an existing current chapter. For a migration assertion `<chapter>`, the procedure MAY derive candidate predecessor `<chapter> - 1`; `0001` is the only valid first chapter. A candidate `0001` with no predecessor handoff is valid only when the first-chapter lifecycle invariant is satisfied. Otherwise the chapter remains UNKNOWN.
4. **Duplicate or contradictory evidence** — active and archived copies of the same semantic chapter are duplicates, not a contradiction. Different chapters, malformed headers, or continuity conflicts are contradictory evidence unless one copy is demonstrably historical and the other establishes the same current chapter. DO NOT resolve contradiction by choosing the newest path or numerically latest handoff.
5. **No usable evidence** — if none of the deterministic cases establishes a chapter, classify the result as UNKNOWN.

When a valid active and archived handoff describe the same specialization and chapter, treat them as duplicate-location evidence for one chapter. DO NOT infer two current chapters merely because two copies exist.

### UNKNOWN recovery interaction

If recovery reaches UNKNOWN, the AI MUST STOP and ask the user to supply `CURRENT_CHAPTER`.

The STOP response MUST require exactly a four-digit numeric chapter value, for example:

    Please provide CURRENT_CHAPTER as a four-digit number, e.g. 0059.

After the user supplies a syntactically valid value, record it as `USER_SUPPLIED_CURRENT_CHAPTER`. That value becomes the **RECOVERED `CURRENT_CHAPTER_CONTEXT`** for the pending migration validation. It is user-provided recovery input, not new repository evidence.

The AI MUST then validate `USER_SUPPLIED_CURRENT_CHAPTER` against any repository evidence that is available:

- if repository evidence is absent, `USER_SUPPLIED_CURRENT_CHAPTER` MUST NOT trigger another UNKNOWN STOP solely because evidence is absent;
- if evidence is consistent, accept `USER_SUPPLIED_CURRENT_CHAPTER` as `CURRENT_CHAPTER_CONTEXT` in RECOVERED state and continue;
- if evidence directly contradicts `USER_SUPPLIED_CURRENT_CHAPTER`, STOP and explain the contradiction.

This continuation rule MUST be applied: a valid user response MUST NOT enter a circular UNKNOWN → ask → UNKNOWN STOP loop.

### Migration argument validation

When `CURRENT_CHAPTER_CONTEXT` is KNOWN or RECOVERED:

    USER_ASSERTED_NEXT_CHAPTER = <chapter>
    EXPECTED_TARGET = CURRENT_CHAPTER_CONTEXT + 1

Migration is valid only when:

    USER_ASSERTED_NEXT_CHAPTER == EXPECTED_TARGET

A mismatch MUST stop migration rather than override sequential target selection.

If the numeric argument does not match the expected target and `CURRENT_CHAPTER_CONTEXT` is not established by active context, the AI MUST ask for `CURRENT_CHAPTER` using the same four-digit format before attempting recovery again. A user-supplied `CURRENT_CHAPTER` then becomes `USER_SUPPLIED_CURRENT_CHAPTER` and, after validation, `CURRENT_CHAPTER_CONTEXT`; it MUST NOT be required to create new repository evidence before validation can continue.

Argumentless `>>migrate` is outside the documented command syntax and MUST NOT be treated as an implicit alias unless a later bounded decision changes this contract.

A WRITE-CAPABLE AI MUST update the current handoff for the immediate successor, verify content and scope, commit the handoff update, and generate the standard bootstrap instruction for that derived target.

The generated bootstrap transport MUST use:

    PREVIOUS_CHAPTER = <current chapter context>
    CURRENT_CHAPTER = <current chapter context + 1>
    SPECIALIZATION = <current specialization>
    SHORT_NAME = <resolved short name>

The current handoff is not marked as transferred or closed. The previous handoff MUST NOT be modified merely to record that it has been consumed.

A READ-ONLY AI MUST prepare the proposed handoff and manual commit message for the immediate successor without modifying the repository.

An explicit user request to violate normal sequential migration is a different, separately explained operation. A bare `>>migrate <chapter>` command MUST NOT skip, repeat, or move backward.

## Bootstrap instruction

The standard migration workflow generates the bootstrap instruction. The standalone operation is:

    >>generate-bootstrap <chapter>

Use it when the bootstrap transport for a future receiving chapter needs to be generated or regenerated independently of migration. It generates transport only; it does not execute the receiving chapter's BOOTSTRAP workflow, create the receiving handoff, or change the current conversation identity.

Normal migration remains:

    >>migrate <chapter>

and MUST generate the bootstrap transport as its terminal step.

The standard generated transport is:

    Initialize a new conversation chapter for the repository:
    https://github.com/paulhuman/aip-mirror

    Follow the new-chapter initialization procedure specified by `.ai/AGENTS.md`, item 6, and use `.ai/workflows/handoff/BOOTSTRAP.md` as the canonical chat-initialization workflow.

    PREVIOUS_CHAPTER = <current chapter context>
    CURRENT_CHAPTER = <target chapter>
    SPECIALIZATION = <current specialization>
    SHORT_NAME = <resolved short name>

The generated transport MUST contain an explicit repository locator and the resolved `SHORT_NAME`.

The repository locator is transport context, not a canonical BOOTSTRAP runtime input. The receiving AI MUST use it to establish repository identity before resolving any repository-relative `.ai/...` path.

The instruction is for a future receiving conversation and MUST NOT be presented as evidence that the receiving chapter has already started.

## Manual bootstrap templates

Manual bootstrap transport MAY be used when starting the first chapter directly or recovering from an interrupted migration.

### Template A — first chapter

    Initialize a new conversation chapter for the repository:
    https://github.com/paulhuman/aip-mirror

    Follow the new-chapter initialization procedure specified by `.ai/AGENTS.md`, item 6, and use `.ai/workflows/handoff/BOOTSTRAP.md` as the canonical chat-initialization workflow.

    PREVIOUS_CHAPTER = N/A
    CURRENT_CHAPTER = <four-digit chapter>
    SPECIALIZATION = <single uppercase specialization letter>
    SHORT_NAME = <short conversation name>

### Template B — interrupted migration recovery

    Initialize a new conversation chapter as a recovery from an interrupted migration for the repository:
    https://github.com/paulhuman/aip-mirror

    Follow the new-chapter initialization procedure specified by `.ai/AGENTS.md`, item 6, and use `.ai/workflows/handoff/BOOTSTRAP.md` as the canonical chat-initialization workflow.

    PREVIOUS_CHAPTER = <four-digit previous chapter>
    CURRENT_CHAPTER = <four-digit current chapter>
    SPECIALIZATION = <single uppercase specialization letter>
    SHORT_NAME = <short conversation name>

If `SHORT_NAME` is omitted from a manual bootstrap message, BOOTSTRAP MUST resolve it from `.ai/config.yaml` through:

    SPECIALIZATION → specializations.<SPECIALIZATION>.short_name

If `SHORT_NAME` is supplied, BOOTSTRAP uses the supplied value unless it is malformed or unusable. If no supplied or configured short name is available, BOOTSTRAP MUST stop and report the unresolved value rather than guessing.

The canonical bootstrap runtime contract remains exactly:

    PREVIOUS_CHAPTER
    CURRENT_CHAPTER
    SPECIALIZATION

`SHORT_NAME` remains contextual data rather than a fourth canonical runtime input.

## Writing rules

Be concrete.

Prefer:

    A component in `src/...` currently handles input tracking.

over:

    "We worked on the mirror tool."

Record decisions and their rationale when that rationale matters to future work.

Record unresolved questions rather than inventing answers.

DO NOT hide uncertainty.

DO NOT copy the entire conversation into the handoff.

DO NOT duplicate stable project documentation unnecessarily.

## Project knowledge versus conversation state

Put durable project knowledge in the appropriate project documentation.

Use the handoff for temporary or chapter-specific state such as:

- what was being investigated;
- what was just changed;
- what remains unfinished;
- what the next chapter SHOULD do first;
- which conversation-specific assumptions still need validation.

## Handoff completeness

Before a handoff is updated for migration or as a significant checkpoint, verify that it answers:

1. What were we trying to accomplish?
2. What is already complete?
3. What is the current implementation state?
4. What decisions were made?
5. What remains unresolved?
6. Where are the relevant files?
7. What should happen next?
8. Which statements are confirmed versus uncertain?

## Receiving a handoff

Receiving-chapter bootstrap is operationally defined by `.ai/workflows/handoff/BOOTSTRAP.md`.

This skill does not duplicate the bootstrap procedure or post-bootstrap verification. After bootstrap, use this skill for the ongoing handoff capability and checkpoint/migration operations.
