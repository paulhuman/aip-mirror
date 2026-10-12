---
name: repository
description: Establish project-agnostic repository identity, boundaries, content taxonomy, durability, and universal repository-safety invariants.
disable-model-invocation: false
user-invocable: true
---

# Repository

This skill owns shared repository semantics: identity, boundaries, content organization, durability, and safety invariants that apply regardless of AI host or repository access mechanism.

## 1. Repository identity

The project's repository identity and project-specific repository settings are defined by `.ai/config.yaml`.

Use configured repository identity and hosting information when constructing repository links. Do not infer project-specific names, paths, or conventions from memory.

### Repository path resolution

Keep two questions distinct:

1. **How a repository-relative path is written in project-controlled documentation.** Resolve it from the configured canonical repository root and default branch. When a specific branch, tag, or commit MUST be explicit, use:

       <repository>@<ref>:/path/to/file.md

2. **How a host locates a file for reading or mutation.** The access mechanism determines how the repository root and file are resolved. Follow the relevant host-specific repository skill rather than deriving a local filesystem path from a hosting URL or applying local filesystem assumptions to remote API access.

Documentation-relative paths MUST NOT be resolved from another repository, an attachment, or conversational context.

## 2. External repository boundaries

External repositories SHOULD remain separate from the project repository unless there is a clear project requirement and the licensing and maintenance implications are understood.

Reference repositories used by the project are declared under `references.repositories` in `.ai/config.yaml`. Use their declared `role` to determine why a reference repository is relevant.

Project-specific adaptations of material from a reference repository MAY be placed in the project repository when needed, but the original reference material remains in its canonical or declared external repository.

## 3. Repository content taxonomy

Use these categories consistently. Project-specific locations and naming conventions belong in configuration or project documentation rather than in these generic repository semantics.

### `references/`

External reference material needed to understand or validate the project. Reference repositories declared in configuration remain external unless there is a clear reason to bring specific adapted material into the project.

### `prototypes/`

Executable experimental implementations used to explore or validate possible approaches before or alongside a settled implementation.

Prototype files MAY use different languages, formats, and implementation technologies. JSX files are one possible example; the directory is not restricted to JSX or to a particular specialization. Project-specific subdirectories, naming, and lifecycle conventions belong in project configuration or project documentation.

### `docs/`

Human-readable project documentation, such as architecture, specifications, reverse-engineering findings, project instructions, and durable project knowledge.

Conversation-specific migration state is owned by the handoff infrastructure under `.ai/handoffs/`.

### `.ai/`

AI-assisted working infrastructure: shared instructions, canonical skills, routing, conversation continuity, supporting context, and infrastructure documentation. It is not application source code.

Its active and supporting areas have distinct purposes:

- `.ai/AGENTS.md`, `.ai/INDEX.md`, and canonical skills/workflows provide active operating semantics and routing.
- `.ai/docs/` holds durable explanation, rationale, architecture context, and orientation for the AI infrastructure.
- `.ai/memory/` holds temporary but important infrastructure working context, including active TODOs, open questions, and unfinished research. Completed or superseded records may later be archived.
- `.ai/captures/` is an inbox for raw, not-yet-processed material captured for later sorting. It is not a knowledge base or semantic owner. Once processed, material moves to its appropriate destination or is discarded; duplicate raw copies are not retained there.
- `.ai/handoffs/` holds conversation continuity and chapter state.
- `.ai/archives/` holds historical material retained for recovery, audit, or reference when explicitly needed.
- README files inside these areas provide orientation; they do not replace canonical owners.

Do not create large directory trees or placeholder files before they are needed. Directories SHOULD generally appear when their contents have a real purpose.

## 4. Repository hygiene

Build products and machine-specific generated files SHOULD normally remain outside version control.

The following MUST NOT be committed:

- API keys
- access tokens
- passwords
- private credentials
- personal authentication data
- machine-specific secrets

The repository SHOULD contain source, configuration, documentation, tests, and intentional project artifacts rather than local build output or secrets.

## 5. Repository as durable project record

Conversation history is temporary working context. The repository is the durable technical record.

Important behavior, architecture, specifications, research findings, decisions, and validated project state SHOULD be captured in files under version control.

The general development workflow requires stable decisions to be documented; this skill defines the repository-level durability of that documentation.

Conversation continuity and handoff lifecycle are owned by the explicitly invoked conversation-management procedures and SHOULD NOT be redefined here.

## 6. Documentation traceability

Important architectural or behavioral decisions MUST be represented in the appropriate repository documentation rather than existing only in chat.

When a decision materially affects implementation, record it in the appropriate project document.

Do not duplicate general workflow guidance here; `.ai/skills/workflow/SKILL.md` owns the general workflow principles.

## 6.1 Active owners and supporting AI-infrastructure layers

The `.ai` infrastructure distinguishes **active semantic owners** from **supporting or contextual layers**.

Canonical active owners include:

- `AGENTS.md` (repository root) — the repository entry point, bootstrap routing, and always-on operating instructions;
- `.ai/AGENTS.md` — the operating contract for work performed inside `.ai/`;
- `.ai/skills/` — canonical skill owners and operational semantics, including shared and host-specific skills;
- `.ai/conversation-management/` — explicitly invoked conversation-management procedures that MUST NOT be exposed as ordinary first-level discovered skills;
- `.ai/INDEX.md` — routing and capability discovery;
- future `.ai` subsystems MAY become active owners when their architecture explicitly assigns them that role.

Supporting or contextual layers include:

- `.ai/handoffs/` — chapter continuity state;
- `.ai/docs/` — durable explanation, rationale, research, and orientation;
- `.ai/memory/` — temporary working context, TODOs, and open questions;
- `.ai/captures/` — raw, unprocessed inbox material;
- `.ai/archives/` — historical material.

Templates under `.ai/conversation-management/templates/` are human-facing transport aids governed by their corresponding conversation-management procedures; they are not an independent semantic owner.

These supporting layers MAY be actively used for appropriate purposes and MAY remain active for different lengths of time. Their activity does not make them semantic owners.

Canonical active owners MUST NOT establish semantic requirements that depend on supporting or contextual layers. In particular, `AGENTS.md`, `.ai/AGENTS.md`, `.ai/skills/`, `.ai/conversation-management/`, `.ai/INDEX.md`, and any future active owner MUST NOT link to, depend on, or require `.ai/handoffs/`, `.ai/docs/`, `.ai/memory/`, `.ai/captures/`, or `.ai/archives/` as sources of active semantics.

Supporting or contextual material MAY describe, explain, or provide evidence for active owners, but it MUST NOT become a second semantic owner merely because an active owner references its explanation.

Active semantic owners SHOULD define the valid semantic model and expected behavior rather than enumerate every possible incorrect form. A negative requirement is appropriate when omitting it would permit a concrete semantic or technical error, ambiguity, or invalid repository state. Project-specific examples and historical mistakes belong in supporting documentation, tests, or handoffs rather than in generic active owners unless they define a reusable invariant.

When a handoff or document becomes obsolete, it MAY move into the appropriate archive location. This is a lifecycle transition, not a change in semantic ownership.

The active semantic model MUST remain understandable and operationally complete from the active owners themselves, without requiring routine loading of handoffs, docs, memory, captures, or archives.

## 7. Repository write safety

Repository mutation safety is defined by a small set of invariants that apply regardless of the AI host or mutation mechanism.

For an existing file:

    READ CURRENT FILE
        ↓
    MAKE MINIMAL INTENDED CHANGE
        ↓
    WRITE COMPLETE INTENDED CONTENT
        ↓
    READ BACK
        ↓
    VERIFY CONTENT
        ↓
    INSPECT DIFF
        ↓
    VERIFY SCOPE
        ↓
    COMMIT
        ↓
    VERIFY RESULT

Therefore:

- Read the current file from the repository before modifying it.
- Use the current file content as the source of truth; DO NOT reconstruct an existing file from memory when it can be fetched.
- Preserve all unrelated content exactly unless the change intentionally modifies it.
- After writing, read the resulting file back from the repository.
- Verify that the intended change is present and unrelated content was not accidentally removed or altered.
- Inspect the resulting diff and changed-file scope before considering the change ready for commit.
- If the resulting content differs unexpectedly, stop and restore the correct content before making further changes.
- A successful write, a valid commit, or a tool-level success response does not by itself prove that repository content is correct.
- Content integrity MUST be verified independently of mutation-tool success.
- Scope verification MUST account for the actual repository state affected by the operation, not only the files visible in a tracked-file list or diff. The host-specific repository skill defines how to inspect that state.

## 8. Branch deletion and preservation of unique work

Before deleting a branch or any other ref that may contain work not present elsewhere, inventory the branch's commits and changed paths relative to its base and determine which files or changes exist only on that ref.

The inventory MUST distinguish:
- changes already preserved on a canonical branch or in another durable location;
- stable, verified results or documentation that should be promoted to the canonical branch before cleanup;
- unfinished experiments and temporary fixtures that may remain disposable;
- files or commits whose only surviving copy is on the branch being considered for deletion.

Do not delete a branch merely because its implementation was reviewed, selected changes were copied, or its purpose is considered complete. First verify that every unique durable artifact that must be retained has been preserved and read back from its intended canonical destination. A successful cherry-pick, merge, file write, or commit is not enough without checking the actual paths and content.

If unique work remains, preserve it before deletion or obtain an explicit decision to discard it. When ownership or intended retention is unclear, stop and ask. After any authorized deletion, verify the ref is gone and that retained artifacts remain reachable from their canonical destination.

This preservation check applies to all branch hosts and workflows; the host-specific repository skill defines how to inventory refs, commits, trees, and local working-copy state.

## 9. Disposable repository fixtures

When an isolated repository test requires synthetic or destructive repository state, the test harness MUST isolate the fixture from canonical project state and unrelated user work, using the known commit SHA that establishes the required baseline. The host-specific repository and workflow skills define the applicable isolation mechanism and its safe use.

The fixture lifecycle MUST:

1. identify and pin the baseline revision;
2. create isolated disposable state without altering canonical branches or unrelated user work;
3. create, modify, or delete only the intended fixture files;
4. read back the resulting repository state;
5. verify content, diff, and fixture scope;
6. exercise the test operation against the actual fixture state;
7. remove disposable state when the test completes.

A disposable fixture MUST NOT be confused with moving an existing canonical branch ref. The host-specific repository and workflow skills define the available isolation mechanisms and their safe use.

Disposable fixture construction MUST NOT alter canonical project history, discard pre-existing user work, or introduce persistent repository state merely to support a test.
