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

`PREVIOUS_CHAPTER` means the predecessor chapter whose handoff is being received. For the first chapter of a specialization, use `N/A`.

The bootstrap procedure MUST NOT reinterpret these values as the chapter that authored the bootstrap message or as a `NEXT_CHAPTER` transition.

A handoff-producing chapter prepares its own handoff for the next chapter; a receiving chapter executes bootstrap with itself as `CURRENT_CHAPTER` and the predecessor as `PREVIOUS_CHAPTER`.

`NEXT_CHAPTER` is not a bootstrap input and MUST NOT be used as a substitute for `CURRENT_CHAPTER`.

### Canonical invocation format

The bootstrap message is the transport boundary for these runtime inputs. Its format is canonical and MUST be used when invoking this workflow:

    PREVIOUS_CHAPTER = <three-digit previous chapter number or N/A>
    CURRENT_CHAPTER = <three-digit current chapter number>
    SPECIALIZATION = <single uppercase specialization letter>

The chapter number values MUST NOT include the specialization letter.

Use:

    CURRENT_CHAPTER = 033

not:

    CURRENT_CHAPTER = C033

Likewise, use:

    PREVIOUS_CHAPTER = 032

not:

    PREVIOUS_CHAPTER = C032

`CURRENT_CHAPTER` and `PREVIOUS_CHAPTER` therefore carry only the numeric chapter component. The specialization is carried separately by `SPECIALIZATION`.

The full chapter identifier is derived from these values as `SPECIALIZATION` + `CURRENT_CHAPTER` (for example, `C` + `033` = `C033`). The predecessor handoff path is derived from `SPECIALIZATION` + `PREVIOUS_CHAPTER` when `PREVIOUS_CHAPTER` is not `N/A`.

A bootstrap message that supplies a chapter number with the specialization letter included is malformed and MUST be corrected before bootstrap proceeds.

## Canonical repository identity and path resolution

Bootstrap uses the repository that contains this bootstrap procedure as the canonical project repository.

Before resolving any other repository-relative path, the bootstrap AI MUST read `.ai/config.yaml` from that repository and use:

- `project.repository` as the repository identifier;
- `project.default_branch` as the canonical project branch;
- `project.hosting.base_url` as the hosting base URL.

A qualified internal repository path is represented as:

    <repository>@<ref>:/path/to/file.md

All repository-relative paths used by this bootstrap procedure MUST be resolved from the configured repository identity on the configured default branch unless the path is explicitly given as an absolute filesystem path, URL, or qualified repository reference.

For an internal canonical reference, use the configured repository identifier and default branch, for example:

    <repository>@<default-branch>:/.ai/rules/workflow.md

For historical or reproducibility-sensitive references, the branch, tag, or commit MUST be explicit, for example:

    <repository>@<commit-sha>:/.ai/handoffs/<specialization>/<chapter-id>.md

The bootstrap AI MUST NOT resolve .ai/..., docs/..., or other unqualified repository paths from its current working directory, another repository, an attachment, or conversational context.

**Bootstrap ordering requirement:** repository identity/path resolution MUST be established from `.ai/config.yaml` before the AI attempts to resolve any other .ai/... path. After reading the configuration, the first repository-controlled rule document read must be `.ai/rules/repository.md`, followed by the applicable .ai/... rules and skills.

If a referenced repository-relative path cannot be resolved from the configured repository identity, bootstrap MUST stop and report the unresolved reference rather than guessing.

## Chat-initialization boundary

This workflow is the reusable chat-initialization procedure for a new chapter. The initialization boundary is:

    new conversation
        ↓
    establish repository + chapter context
        ↓
    ACTIVATE required canonical owners
        ↓
    execute the applicable bootstrap branch
        ↓
    substantive chapter work

The workflow has two initialization cases:

- **RECEIVING CHAPTER** — `PREVIOUS_CHAPTER` identifies an existing predecessor handoff;
- **FIRST CHAPTER** — `PREVIOUS_CHAPTER = N/A`, so there is no predecessor handoff to receive or transition.

This workflow does not route ordinary user commands, define command IDs, maintain a registry, or replace `.ai/INDEX.md`. Its responsibility begins when a new chapter is being initialized and ends when the chapter has passed bootstrap verification.

### ACTIVATE at chat initialization

After repository identity and path resolution are established, the AI MUST read `.ai/skills/activation/SKILL.md` and invoke ACTIVATE for the `conversation initialization` operation using the required canonical owners for the applicable branch. At minimum, the initialization owner set is:

- `.ai/rules/workflow.md`;
- `.ai/rules/handoff/lifecycle.md`;
- `.ai/skills/handoff/SKILL.md`;
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

1. Confirm current chapter identity, previous chapter, and specialization from the bootstrap message.
2. Read this file.
3. Read .ai/rules/workflow.md, .ai/rules/handoff/references.md, and the handoff skill.
4. Read .ai/skills/activation/SKILL.md and invoke ACTIVATE.
5. If PREVIOUS_CHAPTER is not N/A, read the predecessor handoff.
6. Inspect implementation files and references identified by the predecessor handoff when applicable.
7. Confirm that the new chapter can continue from the recorded state without guessing.

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

## Initial handoff

The initial handoff MUST use the standard handoff structure from the `.ai/skills/handoff/SKILL.md` unless a project-specific format requires otherwise and MUST contain, at minimum:

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

    Пора обновить handoff

Treat this as a direct request to update the current handoff with meaningful durable state, verify it, and commit the update.

## Commit convention

Normal handoff creation and update commits MUST use these short forms:

    ai-docs(handoff): create C034
    ai-docs(handoff): update C034

Do not append conversation titles, task descriptions, rationale, milestone summaries, or other explanatory suffixes to normal handoff commit messages.
