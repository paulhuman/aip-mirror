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

### Shared bootstrap steps — all AI

When a new chapter is initialized, all AI MUST:

1. Confirm the current chapter identity, previous chapter, and specialization from the bootstrap message.
2. Read this file.
3. Read the applicable project rules, especially `.ai/rules/handoff/lifecycle.md`, `.ai/rules/workflow.md`, and `.ai/rules/handoff/references.md`.
4. Read `.ai/skills/activation/SKILL.md` and invoke ACTIVATE for `conversation initialization` with the required canonical owners defined above.
5. If `PREVIOUS_CHAPTER` is not `N/A`, read the previous chapter's handoff under `.ai/handoffs/<specialization>/`.
6. If a previous handoff exists, inspect the current implementation files and references identified by that handoff.
7. Confirm that the new chapter can continue from the recorded state without guessing; for a first chapter, confirm that the initial objective and project context are sufficient to begin.

### Branch selection

If `PREVIOUS_CHAPTER = N/A`, use the **FIRST CHAPTER** branch. Otherwise use the **RECEIVING CHAPTER** branch below.

### Branch A — WRITE-CAPABLE AI

**A WRITE-CAPABLE AI MUST read and execute this branch and MUST ignore Branch B.**

7. Immediately create the new chapter's handoff under `.ai/handoffs/<specialization>/` with status `DRAFT` **if it does not already exist**.
8. Commit that initial `DRAFT` handoff as part of bootstrap; this is a pre-authorized procedural commit and does not require a separate approval step **when normal initial creation is applicable**.
9. For a receiving chapter, update the previous chapter's handoff from `READY_FOR_HANDOFF` to `HANDED_OFF`. For a first chapter, there is no predecessor transition.
10. For a receiving chapter, commit that lifecycle transition. For a first chapter, proceed directly to verification.
11. Perform the mandatory post-bootstrap consistency verification described below.
12. Only after bootstrap is complete, proceed with new implementation or other chapter work.

If the receiving handoff already exists when bootstrap begins, DO NOT recreate it or pretend that normal initial creation occurred. Determine whether the existing state represents a qualifying pre-existing lifecycle violation. If so, bootstrap MUST be treated as blocked and the receiving chapter MUST wait for explicit user authorization before performing Lifecycle Recovery.

### Branch B — READ-ONLY AI

**A READ-ONLY AI MUST read and execute this branch and MUST ignore Branch A.**

7. DO NOT create, update, or commit any repository file.
8. If the receiving handoff already exists, DO NOT overwrite or normalize it.
9. Prepare the complete proposed new-chapter handoff with status `DRAFT`, using the standard handoff structure and all information that can be verified from the repository and current conversation.
10. Return the **entire handoff file content** to the user as plain Markdown so the user can place it in `.ai/handoffs/<specialization>/` manually.
11. Provide the exact commit message that should be used for the manual initial-DRAFT commit.
12. DO NOT provide the separate bootstrap instruction for the next chat in the same response. A read-only AI MUST keep its response focused on the complete handoff file and its manual commit message so that constrained interfaces are not unnecessarily burdened by a second long artifact.
13. DO NOT claim `DRAFT` creation, `HANDED_OFF`, a commit, post-bootstrap verification, or `BOOTSTRAP = COMPLETE` because those repository operations were not performed by the AI.
14. The user is responsible for applying the supplied handoff file and completing the required repository lifecycle writes manually before treating bootstrap as complete.

For a READ-ONLY AI, the supplied handoff is a proposed repository state, not evidence that the repository already contains that state.

If the previous handoff is `READY_FOR_HANDOFF`, the READ-ONLY AI may state that the manual bootstrap must subsequently perform the corresponding `READY_FOR_HANDOFF` → `HANDED_OFF` lifecycle update, but it MUST NOT present that transition as completed. For a first chapter, no predecessor lifecycle transition is required.

If the receiving handoff already exists and indicates a qualifying pre-existing lifecycle violation, the READ-ONLY AI MUST report the blocked condition and MUST NOT attempt Lifecycle Recovery.

If the new chapter is the first chapter of a specialization, there is no previous handoff to mark `HANDED_OFF`.

For a WRITE-CAPABLE AI, the first chapter of a specialization still requires immediate creation and commit of the new chapter's `DRAFT` handoff, followed by the applicable post-bootstrap consistency verification.

For a READ-ONLY AI, the first chapter case follows Branch B: prepare and return the complete proposed `DRAFT` handoff and its manual initial-DRAFT commit message, without performing repository writes.

If the receiving handoff already exists when bootstrap begins, no AI MAY recreate it or pretend that normal initial creation occurred. Determine whether the existing state represents a qualifying pre-existing lifecycle violation. A WRITE-CAPABLE AI MUST block and wait for explicit user authorization before performing Lifecycle Recovery. A READ-ONLY AI MUST report the blocked condition and MUST NOT attempt Lifecycle Recovery.

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

## Lifecycle exceptions

Lifecycle Recovery and Lifecycle Correction are governed canonically by `.ai/rules/handoff/lifecycle.md`.

If bootstrap detects a qualifying pre-existing lifecycle violation, follow the canonical lifecycle rule for the applicable recovery or correction procedure. Do not duplicate those lifecycle rules in this bootstrap workflow.

## Post-bootstrap consistency verification

Bootstrap is not complete merely because the receiving handoff was created and the previous handoff was transitioned to `HANDED_OFF`.

Before beginning substantive chapter work, the receiving chapter MUST verify the resulting lifecycle state as a coherent chain, not only an immediate pair:

1. Read back the receiving chapter's own handoff after normal creation or authorized recovery.
2. Confirm that its own handoff still has `Status: DRAFT`.
3. Confirm that its `Previous chapter` identifies the handoff from which it actually started.
4. Confirm that its `Immediate next task` describes the first real task after bootstrap, not an action already completed as part of bootstrap or recovery.
5. If a previous handoff exists, read it back after the normal `READY_FOR_HANDOFF` → `HANDED_OFF` transition or authorized recovery.
6. Confirm that the previous handoff is now `HANDED_OFF`.
7. Confirm that the previous and receiving handoffs form a consistent lifecycle pair.
8. Inspect the relevant earlier handoff for the same specialization when one exists.
9. If a predecessor handoff is `HANDED_OFF` even though the current receiving handoff has already replaced it, treat that as a lifecycle-chain inconsistency and stop/report rather than silently repairing it.
10. If any check fails, treat bootstrap as incomplete. Correct only the receiving chapter's own handoff when the correction is within normal ownership or explicitly authorized recovery scope; otherwise stop and report the inconsistency.

The receiving chapter owns correction of its own handoff. Another specialization may detect and report an inconsistency, but MUST NOT edit the receiving chapter's handoff on its behalf.

Recovery completion is not itself bootstrap completion and does not by itself authorize substantive work.

## Initial DRAFT handoff

The initial handoff MUST use the standard handoff structure from the `.ai/skills/handoff/SKILL.md` unless a project-specific format requires otherwise and MUST contain, at minimum:

- conversation/chapter identity;
- specialization;
- previous chapter;
- `Status: DRAFT`;
- starting objective;
- known starting implementation state;
- relevant files and references;
- important constraints;
- confirmed versus inferred versus assumed information;
- immediate next task;
- recommended starting context.

The initial handoff is intentionally a live checkpoint document. It MAY be incomplete at bootstrap and MUST be updated during the chapter as meaningful state accumulates.

## Checkpoint command

During the chapter, the user MAY say:

    Пора обновить handoff

Treat this as a direct request to update the current handoff while keeping `Status: DRAFT`, verify it, and commit the checkpoint as part of the established handoff workflow.

These commits are **checkpoint commits**, not migration commits.

