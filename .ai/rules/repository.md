# Repository rules

These rules define repository identity, repository boundaries, project file organization, repository durability, and safe repository mutation.

## 1. Repository identity

The project repository identity is defined by `.ai/config.yaml`.

Use:

- `project.repository` for the repository identifier
- `project.default_branch` for the default branch
- `project.hosting.base_url` for constructing repository URLs

### Repository path resolution

The canonical repository root is constructed from the configured hosting base URL and repository identifier.

All unqualified repository-relative paths in project-controlled documentation resolve from that repository root on the configured default branch.

When a specific branch, tag, or commit MUST be explicit, use:

    <repository>@<ref>:/path/to/file.md

Do not resolve repository-relative paths from the current working directory, another repository, an attachment, or conversational context.

## 2. External repository boundaries

External repositories SHOULD remain separate from the project repository unless there is a clear project requirement and the licensing and maintenance implications are understood.

Reference repositories used by the project are declared under `references.repositories` in `.ai/config.yaml`. Use their declared `role` to determine why a reference repository is relevant.

Project-specific adaptations of material from a reference repository MAY be placed in the project repository when needed, but the original reference material remains in its canonical or declared external repository.

## 3. Repository content taxonomy

Use these categories consistently.

### `references/`

External reference material needed to understand or validate the project.

### `prototypes/`

Executable experimental implementations. Project-specific prototype locations and naming belong to project configuration or project documentation, not to these generic repository rules.

### `docs/`

Human-readable project documentation.

Examples:

- architecture
- specifications
- reverse-engineering findings
- project instructions
- durable project documentation

Conversation-specific migration state is owned by the handoff infrastructure under `.ai/handoffs/`.

### `.ai/`

AI workflow instructions and generic AI infrastructure.

These files describe how AI-assisted work SHOULD be performed. They are not application source code.

Do not create large directory trees or placeholder files before they are needed. Directories SHOULD generally appear when their contents have a real purpose.

## 4. Repository hygiene

Build products and machine-specific generated files SHOULD normally remain outside version control.

Never commit:

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

The general development workflow requires stable decisions to be documented; this rule defines the repository-level durability of that documentation.

Conversation continuity and handoff lifecycle are defined by `.ai/rules/handoff/lifecycle.md` and SHOULD NOT be redefined here.

## 6. Documentation traceability

Important architectural or behavioral decisions MUST be represented in the appropriate repository documentation rather than existing only in chat.

When a decision materially affects implementation, record it in the appropriate project document.

Do not duplicate generic workflow guidance here; `.ai/rules/workflow.md` owns the general documentation principle.

## 6.1 Active owners and supporting AI-infrastructure layers

The `.ai` infrastructure distinguishes **active semantic owners** from **supporting or contextual layers**.

Canonical active owners include:

- `.ai/rules/` — semantic constraints;
- `.ai/skills/` — reusable capabilities;
- `.ai/workflows/` — ordered procedures;
- `.ai/templates/` — reusable structural templates;
- `.ai/INDEX.md` — routing and capability discovery;
- future `.ai` subsystems MAY become active owners when their architecture explicitly assigns them that role.

Supporting or contextual layers include:

- `.ai/handoffs/` — chapter continuity state;
- `.ai/docs/` — durable explanation, rationale, research, and orientation;
- `.ai/archives/` — historical material.

These supporting layers MAY be actively used for appropriate purposes and MAY remain active for different lengths of time. Their activity does not make them semantic owners.

Canonical active owners MUST NOT establish semantic requirements that depend on supporting or contextual layers. In particular, `.ai/rules/`, `.ai/skills/`, `.ai/workflows/`, `.ai/templates/`, `.ai/INDEX.md`, and any future active owner MUST NOT link to, depend on, or require `.ai/handoffs/`, `.ai/docs/`, or `.ai/archives/` as sources of active semantics.

Supporting or contextual material MAY describe, explain, or provide evidence for active owners, but it MUST NOT become a second semantic owner merely because an active owner references its explanation.

When a handoff or document becomes obsolete, it MAY move into the appropriate archive location. This is a lifecycle transition, not a change in semantic ownership.

The active semantic model MUST remain understandable and operationally complete from the active owners themselves, without requiring routine loading of handoffs, docs, or archives.
## 7. Repository write safety

Repository mutation safety is defined by a small set of invariants that apply
regardless of the AI host or mutation mechanism.

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
- Use the current file content as the source of truth; DO NOT reconstruct an
  existing file from memory when it can be fetched.
- Preserve all unrelated content exactly unless the change intentionally
  modifies it.
- After writing, read the resulting file back from the repository.
- Verify that the intended change is present and unrelated content was not
  accidentally removed or altered.
- Inspect the resulting diff and changed-file scope before considering the
  change ready for commit.
- If the resulting content differs unexpectedly, stop and restore the correct
  content before making further changes.
- A successful write, a valid commit, or a tool-level success response does
  not by itself prove that repository content is correct.
- Content integrity MUST be verified independently of mutation-tool success.

### GitHub Connector-specific mechanics

When an existing file is updated through a GitHub Contents API that accepts
complete file content:

- the new content MUST contain the entire intended file;
- the current blob SHA MUST be treated as the write precondition;
- the complete-file replacement semantics MUST NOT be mistaken for a
  line-level edit.

These are mechanics of the GitHub Connector/API path, not additional
repository-safety invariants.

### Agentic-host-specific mechanics

Tool-using Agentic AI environments MAY use different mutation mechanisms,
such as a local working copy, write, edit, shell commands, or native
repository tools.

Those mechanisms are host-specific and MUST NOT be copied into this
repository-wide rule as a second implementation procedure. They remain valid
only insofar as they satisfy the common repository-safety invariants above.

The same principle applies when an environment provides its own enforced
read-before-write or diff/commit safeguards: host enforcement MAY strengthen
the mechanism, but it does not replace independent verification of the
result.

## 8. Disposable repository fixtures

When an isolated repository test requires synthetic or destructive repository state, the test harness MUST prefer creating a disposable branch directly from the known commit SHA that establishes the required baseline.

Use this fixture flow:

    known commit SHA
        ↓
    create disposable branch from that SHA
        ↓
    create / modify / delete fixture files
        ↓
    read back the resulting repository state
        ↓
    verify diff and fixture scope
        ↓
    exercise the test operation
        ↓
    create the next disposable branch from the resulting commit when another state is required

A branch created from a commit is a new isolated test path. It MUST NOT be confused with moving an existing branch ref.

If moving an existing branch ref with `update_ref` is blocked, the AI MUST NOT treat that failure as evidence that the required fixture state cannot be constructed. The AI SHOULD decompose the fixture setup into commit-sized stages and create the next disposable branch from each resulting commit when ref movement is unavailable.

Fixture branches MUST remain clearly isolated from canonical branches such as `main`. Repository-state verification MUST use the actual fixture branch/ref and MUST NOT infer the resulting state from the intended commit operation alone.

Disposable fixture construction MUST NOT alter canonical project history or introduce persistent repository state merely to support a test.
