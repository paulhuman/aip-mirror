# Conversation handoff bootstrap

This file is the reusable procedural workflow for initializing a new conversation chapter.

It covers both receiving a chapter from a previous handoff and starting the first chapter of a specialization. It is a workflow owner, not a universal command router or entry registry.

It MUST NOT contain the identity of a specific current or next chapter. Actual chapter values are supplied by the bootstrap message that invokes this procedure.

## Bootstrap inputs

The bootstrap message supplies:

    PREVIOUS_CHAPTER = <previous chapter or N/A>
    CURRENT_CHAPTER = <current chapter>
    SPECIALIZATION = <specialization>

These values are runtime context for the receiving chapter. DO NOT write them into this template.

`CURRENT_CHAPTER` always means the receiving chapter that is executing this bootstrap procedure.

Chapter numbering is one-based. The first chapter of a specialization is `0001`, and `0000` MUST NOT be used as a chapter number.
The chapter sequence advances as `0001 → 0002 → 0003 ...`.

`PREVIOUS_CHAPTER` means the predecessor chapter whose handoff is being received. For the first chapter of a specialization, use `N/A`.

### Supplied `SHORT_NAME` context

The bootstrap message MAY also supply:

    SHORT_NAME = <short conversation name>

`SHORT_NAME` is supplied context, not a fourth canonical bootstrap runtime input.

When `SHORT_NAME` is supplied, the bootstrap procedure MUST use the supplied value for the receiving handoff filename and conversation title unless the supplied value is malformed or otherwise unusable.

When `SHORT_NAME` is omitted, the bootstrap procedure MUST resolve it from the specialization vocabulary in `.ai/config.yaml`:

    SPECIALIZATION → specializations.<SPECIALIZATION>.short_name

For example:

    SPECIALIZATION = A
    SHORT_NAME = Project Workshop

If a supplied `SHORT_NAME` is present, configuration lookup is a fallback and MUST NOT replace the supplied value merely because a configured value also exists.

If `SHORT_NAME` is neither supplied nor resolvable from configured specialization vocabulary, bootstrap MUST stop and report the unresolved short name rather than guessing one.

The resolved `SHORT_NAME` is the canonical short conversation title.
It is used for the `Conversation` field and for the canonical handoff filename.

For the filename, derive `FILENAME_SHORT_NAME` by replacing every space in `SHORT_NAME` with a hyphen. This normalization is part of the canonical handoff filename contract.

For generated migration transport, the value MUST already be resolved from the specialization vocabulary. The receiving AI MUST NOT require the user to repeat specialization or short-name context.

    .ai/handoffs/<SPECIALIZATION>/<CHAPTER_ID>-<FILENAME_SHORT_NAME>.md

For example:

    SPECIALIZATION = A
    CURRENT_CHAPTER = 0001
    CHAPTER_ID = A0001
    SHORT_NAME = Project Workshop
    FILENAME_SHORT_NAME = Project-Workshop

    .ai/handoffs/A/A0001-Project-Workshop.md

A handoff filename MUST NOT be constructed as `<CURRENT_CHAPTER>-<SHORT_NAME>.md`.

A handoff-producing chapter prepares its own handoff for the next chapter; a receiving chapter executes bootstrap with itself as `CURRENT_CHAPTER` and the predecessor as `PREVIOUS_CHAPTER`.

## Transport generation and template ownership

The generated bootstrap transport is a canonical template instantiation, not newly authored prose.

When generating bootstrap transport, the AI MUST:

1. read the current `.ai/conversation-management/handoff/BOOTSTRAP.md`;
2. copy the applicable canonical generated-transport template exactly;
3. replace only the explicitly variable placeholders;
4. preserve all fixed text, ordering, repository locator, field names, and required instructions exactly;
5. MUST NOT reconstruct, summarize, paraphrase, shorten, redesign, or otherwise rewrite the template from memory.

The repository locator is mandatory transport content even though it is not a canonical BOOTSTRAP runtime input.

A generated transport is invalid if the canonical repository locator or any other fixed template element is omitted, paraphrased, reordered, or replaced with an inferred value.

Before returning generated bootstrap transport, the AI MUST verify that it contains:

- the canonical repository locator;
- the canonical nested BOOTSTRAP instruction;
- the canonical `.ai/conversation-management/handoff/BOOTSTRAP.md` reference;
- `PREVIOUS_CHAPTER`;
- `CURRENT_CHAPTER`;
- `SPECIALIZATION`;
- the resolved `SHORT_NAME`;
- the canonical field ordering.

### Canonical invocation format

The bootstrap message is the transport boundary for the initialization context. A generated migration instruction MUST explicitly identify itself as an instruction to initialize a new conversation chapter, MUST contain an explicit repository locator, and MUST direct the receiving AI to follow the procedure in the nested BOOTSTRAP workflow. Human manual bootstrap templates are maintained separately in `.ai/conversation-management/templates/manual-bootstrap-templates.md`.

The repository locator is transport context, not a canonical BOOTSTRAP runtime input. It exists so the receiving AI can identify the target repository before resolving any repository-relative path.

The canonical generated form is:

    Initialize a new conversation chapter for the repository:
    https://github.com/paulhuman/aip-mirror

    Follow the new-chapter initialization procedure in `.ai/conversation-management/handoff/BOOTSTRAP.md`.

    PREVIOUS_CHAPTER = <four-digit previous chapter number or N/A>
    CURRENT_CHAPTER = <four-digit current chapter number>
    SPECIALIZATION = <single uppercase specialization letter>
    SHORT_NAME = <resolved short conversation name>

For this project, the generated repository locator is constructed from `project.hosting.base_url` and `project.repository` in `.ai/config.yaml`. The receiving AI MUST NOT be expected to infer the repository from memory, conversation history, local paths, attachments, or implicit project context.

The standard generated transport contains the repository locator instruction above, followed by:

    PREVIOUS_CHAPTER = <four-digit previous chapter number or N/A>
    CURRENT_CHAPTER = <four-digit current chapter number>
    SPECIALIZATION = <single uppercase specialization letter>
    SHORT_NAME = <resolved short conversation name>

The canonical BOOTSTRAP runtime contract remains three inputs:

    PREVIOUS_CHAPTER
    CURRENT_CHAPTER
    SPECIALIZATION

`SHORT_NAME` is contextual data, not a fourth canonical runtime input. Generated migration instructions MUST include the already-resolved `SHORT_NAME`. A manual bootstrap message MAY supply it explicitly; when omitted, the supplied/fallback resolution rules above apply.

The chapter number values MUST NOT include the specialization letter.

Use:

    CURRENT_CHAPTER = 0001

not:

    CURRENT_CHAPTER = A0001

For this first-chapter example:

    PREVIOUS_CHAPTER = N/A

`CURRENT_CHAPTER` and `PREVIOUS_CHAPTER` therefore carry only the numeric chapter component. The specialization is carried separately by `SPECIALIZATION`.

The full chapter identifier is derived from these values as `SPECIALIZATION` + `CURRENT_CHAPTER` (for example, `A` + `0001` = `A0001`). This derived value is `CHAPTER_ID`.

    CHAPTER_ID = SPECIALIZATION + CURRENT_CHAPTER

The handoff filename MUST use `CHAPTER_ID`, never `CURRENT_CHAPTER` alone. The predecessor handoff path is derived from `SPECIALIZATION` + `PREVIOUS_CHAPTER` when `PREVIOUS_CHAPTER` is not `N/A`.

A bootstrap message that supplies a chapter number with the specialization letter included is malformed and MUST be corrected before bootstrap proceeds.

## Canonical repository identity and path resolution

Bootstrap MUST first use the explicit repository locator carried by the bootstrap instruction to identify the target repository.

The receiving AI MUST NOT infer the target repository from memory, conversation history, local paths, attachments, or implicit project context.

After the repository locator has established the target repository, the bootstrap AI MUST read `.ai/config.yaml` from that repository before resolving any other repository-relative path, and use:

- `project.repository` as the repository identifier;
- `project.default_branch` as the canonical project branch;
- `project.hosting.base_url` as the hosting base URL.

A qualified internal repository path is represented as:

    <repository>@<ref>:/path/to/file.md

All repository-relative paths used by this bootstrap procedure MUST be resolved from the configured repository identity on the configured default branch unless the path is explicitly given as an absolute filesystem path, URL, or qualified repository reference.

For an internal canonical reference, use the configured repository identifier and default branch, for example:

    <repository>@<default-branch>:/.ai/skills/workflow/SKILL.md

For historical or reproducibility-sensitive references, the branch, tag, or commit MUST be explicit, for example:

    <repository>@<commit-sha>:/.ai/handoffs/<specialization>/<chapter-id>.md

The bootstrap AI MUST NOT resolve .ai/..., docs/..., or other unqualified repository paths from its current working directory, another repository, an attachment, or conversational context.

**Bootstrap ordering requirement:** repository identity/path resolution MUST be established from `.ai/config.yaml` before the AI attempts to resolve any other .ai/... path. After reading the configuration, the first repository-controlled semantic owner read must be `.ai/skills/repository/SKILL.md`, followed by the other applicable canonical skills.

If a referenced repository-relative path cannot be resolved from the configured repository identity, bootstrap MUST stop and report the unresolved reference rather than guessing.

## Chat-initialization boundary

This workflow is the reusable initialization procedure for a receiving conversation chapter. It is conversational-only and MUST be entered only when the receiving conversation is explicitly instructed to initialize a new chapter.

Reading `.ai/AGENTS.md` or starting an ordinary conversation MUST NOT trigger chapter initialization. The receiving conversation uses the explicit bootstrap instruction to identify the repository and then follows this procedure.

The initialization boundary is:

    explicit bootstrap instruction
        ↓
    identify target repository
        ↓
    read .ai/config.yaml
        ↓
    read this nested BOOTSTRAP workflow
        ↓
    validate bootstrap context
        ↓
    ACTIVATE required canonical owners
        ↓
    execute the applicable bootstrap branch
        ↓
    substantive chapter work

If new-chapter initialization is requested but required bootstrap runtime values are absent or malformed, this workflow MUST stop before repository mutation and report the missing or malformed values. It MUST NOT guess, infer, or silently substitute chapter values.

The workflow has two initialization cases:

- **RECEIVING CHAPTER** — `PREVIOUS_CHAPTER` identifies an existing predecessor handoff;
- **FIRST CHAPTER** — `PREVIOUS_CHAPTER = N/A`, so there is no predecessor handoff to receive or transition.

This workflow does not route ordinary user commands, define command IDs, maintain a registry, or replace `.ai/INDEX.md`. Its responsibility begins when a new chapter is explicitly being initialized and ends when the chapter has passed bootstrap verification.

### ACTIVATE at chat initialization

After repository identity and path resolution are established, the AI MUST read `.ai/skills/activation/SKILL.md` and invoke ACTIVATE for the `conversation initialization` operation using the required canonical owners for the applicable branch. At minimum, the initialization owner set is:

- `.ai/skills/workflow/SKILL.md`;
- `.ai/conversation-management/handoff/SKILL.md`;
- `.ai/conversation-management/handoff/reference-preservation/SKILL.md`;
- this BOOTSTRAP workflow.

For a receiving chapter, the previous handoff is additional initialization context and MUST be read as required by the receiving branch. For a first chapter, no predecessor handoff is required.

ACTIVATE establishes current canonical operational context; it does not execute bootstrap, perform lifecycle transitions, create commits, or replace this workflow.

## Repository write-capability self-check

Before executing the repository-mutating parts of bootstrap, the AI MUST determine which capability branch applies:

- **WRITE-CAPABLE AI** — the AI has a working mechanism that can create/update repository files and create commits in the target repository.
- **READ-ONLY AI** — the AI can inspect repository contents but cannot create/update repository files or create commits.
- **UNCERTAIN** — if the AI cannot reliably establish that repository writes and commits are available and working, it MUST treat itself as **READ-ONLY AI** for this bootstrap.

After this self-check:

- Follow **exactly one** capability branch below.
- A WRITE-CAPABLE AI MUST follow the WRITE-CAPABLE branch and MUST ignore the READ-ONLY branch.
- A READ-ONLY AI MUST follow the READ-ONLY branch and MUST ignore all repository-write instructions in the WRITE-CAPABLE branch.
- An AI MUST NOT claim that a repository write, lifecycle transition, commit, or bootstrap completion occurred unless it actually performed and verified that operation.

## Required procedure

### Shared steps

1. Validate that this procedure was invoked by an explicit bootstrap instruction containing the canonical repository locator and directing the receiving AI to this BOOTSTRAP workflow. Do not require an AGENTS.md entry path for Conversational AI initialization.
2. Confirm current chapter identity, previous chapter, specialization, and supplied contextual `SHORT_NAME` from the bootstrap message.
3. If any canonical runtime input is missing or malformed, STOP before repository mutation and report exactly what is missing or malformed.
4. Compute `CHAPTER_ID = SPECIALIZATION + CURRENT_CHAPTER` and `FILENAME_SHORT_NAME` by replacing spaces in `SHORT_NAME` with hyphens. Before repository mutation, verify that the resulting handoff path matches `.ai/handoffs/<SPECIALIZATION>/<CHAPTER_ID>-<FILENAME_SHORT_NAME>.md`. If it does not, STOP and report the mismatch.
5. Read this file.
6. Read .ai/skills/workflow/SKILL.md, .ai/conversation-management/handoff/reference-preservation/SKILL.md, the handoff skill, `.ai/handoffs/README.md`, `.ai/memory/README.md`, and `.ai/docs/README.md`. The two README files are bootstrap orientation reads, not activation owners.
7. Read .ai/skills/activation/SKILL.md and invoke ACTIVATE.
8. After the repository write-capability self-check, a WRITE-CAPABLE bootstrap MUST read .ai/skills/commits/SKILL.md before emitting the operation-level TRACE, because the bootstrap branch includes an authorized repository commit. For a READ-ONLY bootstrap, .ai/skills/commits/SKILL.md is not required solely for bootstrap.
9. During bootstrap initialization, emit the required operation-level TRACE defined by `.ai/skills/activation/SKILL.md` before executing the applicable bootstrap branch. The TRACE MUST identify the bootstrap operation, list the canonical owners actually reread for ACTIVATE, report `status: ACTIVATED`, and include the unique additional repository files actually read in `OPERATION READS` without duplicating ACTIVATE owners. For a WRITE-CAPABLE bootstrap, `.ai/skills/commits/SKILL.md` MUST therefore appear in `OPERATION READS`. If bootstrap aborts or fails after ACTIVATE, the TRACE MUST still show the activation and the `OPERATION READS` accumulated up to that point.
10. If PREVIOUS_CHAPTER is not N/A, read the predecessor handoff.
11. Inspect implementation files and references identified by the predecessor handoff when applicable.
12. Confirm that the new chapter can continue from the recorded state without guessing.

### Branch A — WRITE-CAPABLE AI

A WRITE-CAPABLE AI MUST:

1. create the new chapter handoff if it does not already exist;
2. commit that initial handoff;
3. perform post-bootstrap consistency verification;
4. only then begin substantive work.

If the receiving handoff already exists, DO NOT recreate or blindly overwrite it. Read it, preserve valid context, and verify its header. If incomplete, update it as the receiving chapter's existing context snapshot and verify it before continuing.

### Branch B — READ-ONLY AI

A READ-ONLY AI MUST:

1. not create, update, or commit repository files;
2. prepare the complete proposed new-chapter handoff;
3. return the entire handoff content and exact manual initial-handoff commit message;
4. not claim bootstrap writes or verification were completed.

## Why handoffs exist

A conversation is a finite AI working context, not a durable execution environment. Handoffs exist to preserve project continuity when work moves from one bounded conversation to another.

A chapter may need to continue in a new conversation because of:

- a large accumulation of conversation history;
- approaching context limits;
- degradation of reasoning quality as context becomes large or distant;
- increasing risk of hallucination or reconstruction from incomplete context;
- browser or conversation instability;
- the need for a clean new conversation context;
- the need to preserve durable project state independently of the health or availability of the old conversation.

The repository handoff state MUST therefore outlive the conversation that created it. No old conversation or specialization is required to remain available in order for a later chapter to reconstruct or correct canonical handoff state.

## Post-bootstrap consistency verification

Before substantive work, the receiving chapter MUST:

1. read back its own handoff after creation or update;
2. confirm Conversation, Specialization, Chapter, and Previous chapter identify the receiving chapter correctly;
3. confirm Immediate next task describes the first real task after bootstrap;
4. if a predecessor exists, confirm the predecessor handoff was read successfully;
5. verify that the current handoff contains sufficient starting context to continue without guessing.

If a check fails, bootstrap is incomplete. Correct only the current receiving handoff within normal ownership; otherwise stop and report the inconsistency.

After the applicable bootstrap branch and post-bootstrap consistency verification are complete, assemble the required operation-level TRACE defined by `.ai/skills/activation/SKILL.md` and insert the completed TRACE into the assistant response. The TRACE MUST identify the bootstrap operation, list the canonical owners actually reread for ACTIVATE, report `status: ACTIVATED`, and include the unique additional repository files actually read in `OPERATION READS` without duplicating ACTIVATE owners. For a WRITE-CAPABLE bootstrap, `.ai/skills/commits/SKILL.md` MUST therefore appear in `OPERATION READS`.

If bootstrap aborts or fails after ACTIVATE, insert a TRACE into the assistant response showing the activation and the `OPERATION READS` accumulated up to the failure point. The TRACE is response content, not repository state.

## Initial handoff

The initial handoff MUST use the standard handoff structure from the `.ai/conversation-management/handoff/SKILL.md` unless a project-specific format requires otherwise and MUST contain, at minimum:

- conversation/chapter identity;
- specialization;
- previous chapter;
- starting objective;
- known starting implementation state;
- relevant files and references;
- important constraints;
- confirmed versus inferred versus assumed information;
- immediate next task;
- recommended starting context.

The initial handoff is intentionally a live checkpoint document. It MAY be incomplete at bootstrap and MUST be updated during the chapter as meaningful state accumulates.

## Checkpoint

During the chapter, the user MAY say:

    >>handoff

Treat this as a direct request to update the current handoff with meaningful durable state, verify it, and commit the update.

## Commit convention

Normal handoff creation and update commits MUST use these short forms:

    ai-docs(handoff): create A0001
    ai-docs(handoff): update A0001

Do not append conversation titles, task descriptions, rationale, milestone summaries, or other explanatory suffixes to normal handoff commit messages.
