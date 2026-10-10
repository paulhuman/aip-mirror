# Conversation Handoff

**Conversation:**
C0085 — Architecture & Research

**Specialization:**
C

**Chapter:**
0085

**Previous chapter:**
0084

## Starting objective

Continue the accepted AI-infrastructure documentation and memory restructuring work from C0084. Implement and verify the semantic boundary between active owners, persistent structural descriptions, working memory, and archives; then restructure the former `.ai/docs/` content into maintained documentation, working memory, and historical archives without rewriting historical evidence. Work in ordered, evidence-backed stages. Avoid mass replacement passes and do not finalize unsupported taxonomy.

## Bootstrap and repository identity

- Repository: `paulhuman/aip-mirror`
- Canonical branch from `.ai/config.yaml`: `main`
- Repository locator: `https://github.com/paulhuman/aip-mirror`
- Specialization / short name: `C` / `Architecture & Research`
- Previous handoff: `.ai/handoffs/C/C0084-Architecture-&-Research.md`
- Current handoff: `.ai/handoffs/C/C0085-Architecture-&-Research.md`
- Canonical initialization procedure: `.ai/conversation-management/handoff/BOOTSTRAP.md`

## Confirmed bootstrap context

- The bootstrap instruction explicitly supplied `PREVIOUS_CHAPTER = 0084`, `CURRENT_CHAPTER = 0085`, `SPECIALIZATION = C`, and `SHORT_NAME = Architecture & Research`.
- `.ai/config.yaml` confirms repository `paulhuman/aip-mirror`, default branch `main`, and specialization C short name `Architecture & Research`.
- The predecessor handoff was read successfully from the configured repository.
- The current branch ref was resolved to commit `78c321d62714463ddd3e420dfc311f11d1a7dd13`; its root tree is `83fb3e17d8b4d0fa36d94aeddee786f5f81448fa`. The recursive tree reports `truncated=false` and 255 entries. Subsequent repository-wide audit reads must be pinned to this immutable commit, not a moving branch.
- The previous recorded snapshot `cf4cfbede97b58cc25ac4f8b635f5bb70f44010d` is historical evidence only; C0085 has established a fresh baseline.
- Repository write capability is available through connected GitHub tools. This bootstrap follows the WRITE-CAPABLE branch.
- The C0085 handoff did not exist in the verified current tree before bootstrap.

## Canonical files read during bootstrap

- `.ai/config.yaml`
- `.ai/conversation-management/handoff/BOOTSTRAP.md`
- `.ai/skills/repository/SKILL.md`
- `.ai/skills/activation/SKILL.md`
- `.ai/skills/workflow/SKILL.md`
- `.ai/skills/commits/SKILL.md`
- `.ai/conversation-management/handoff/SKILL.md`
- `.ai/conversation-management/handoff/reference-preservation/SKILL.md`
- `.ai/AGENTS.md`
- `.ai/INDEX.md`
- `.ai/handoffs/README.md`
- `.ai/docs/architecture/README.md`
- `.ai/handoffs/C/C0084-Architecture-&-Research.md`

## Accepted decisions carried forward from C0084

### Active owners and structural descriptions

- Active semantic owners are self-contained and define the operational semantics required for their function.
- Active owners may read persistent structural descriptions, such as README files and local purpose descriptions, when justified by their operation. These are not disposable memory entries.
- README files are part of the active orientation surface. Reading a README describing a memory layer is not equivalent to ingesting the layer's memory documents.
- Active owners MUST NOT depend on handoffs, memory entries, archives, or other disposable contextual material to establish their own semantics.
- Memory, handoffs, and historical/archive material MAY refer to active rules, skills, workflows, and routers.
- Active owners MUST NOT link back to disposable memory content as an authority for their own semantics; justified references to permanent structural descriptions are permitted.
- Ordinary project `docs/` is maintained project documentation and remains distinct from AI-infrastructure memory.

### Documentation, memory, and archives

Target layout:

- `.ai/docs/` — current, maintained AI-infrastructure documentation.
- `.ai/memory/` — working memory, unresolved research, active TODOs, and context with limited useful lifetime.
- `.ai/archives/` — completed, superseded, or obsolete memory retained for historical evidence.

Move the two FAQ files from `.ai/docs/faq/` to the root of `.ai/docs/`:

- `.ai/docs/faq/adapting-to-a-new-project.md` → `.ai/docs/adapting-to-a-new-project.md`
- `.ai/docs/faq/manual-activation.md` → `.ai/docs/manual-activation.md`

The former architecture/context notes under `.ai/docs/` are memory rather than maintained architecture documentation merely because of their previous location. For each note, determine whether its implementation is complete and verifiable or whether unresolved work must be preserved in `.ai/memory/`. Archive completed material rather than repeatedly revising historical paths. Historical paths inside memory/archive files may be evidence of the structure that existed when written; do not mechanically modernize them.

The user asked for one appropriate README per real folder. Inspect the actual resulting tree and make README coverage accurate without creating meaningless placeholder folders. README files are orientation, not duplicate semantic owners.

### Memory lifecycle skill

Create a TODO for a dedicated first-level memory lifecycle skill, likely `.ai/skills/memory/SKILL.md` after checking current conventions. It should own memory placement, TODO status/target/evidence, reconciliation against current repository state, verification before completion, archival, preservation of unresolved work and historical evidence, README upkeep, and avoiding routine rereads of completed TODOs. It must complement—not duplicate—the handoff lifecycle owner.

## Implementation plan — preserve ordered stages

### Stage 0 — Bootstrap and evidence

1. Bootstrap this chapter and create/verify this handoff.
2. Reread current canonical owners before each substantive operation.
3. Use the fresh immutable snapshot recorded above for the initial inventory. If `main` advances before work begins, establish and record a new authoritative snapshot before making repository-wide claims.
4. Enumerate the actual relevant tree and read the complete contents of files being classified or changed. Code-search excerpts alone do not establish inventory completeness.

### Stage 1 — Inventory current structure and references

1. Inventory paths under `.ai/docs/`, `.ai/memory/` if present, `.ai/archives/`, and relevant README files.
2. Find current references to `.ai/docs/`, `.ai/docs/faq/`, the two FAQ filenames, proposed `.ai/memory/` paths, and architecture/context notes that may be moved or archived.
3. Classify each reference by operational role: active semantic dependency, justified structural README read, navigation to a permanent description, memory/handoff/archive reference to an active owner, or intentional historical reference.
4. Record exact files actually retrieved; do not claim exhaustive findings from search excerpts alone.
5. Verify TODO/document implementation status against active owners and current repository state; classify as implemented, unresolved, or unclear.

### Stage 2 — Define active semantic boundary

Make a minimal, evidence-backed edit to `.ai/skills/repository/SKILL.md` defining self-contained active owners and the permitted structural-description exception. Distinguish permanent README/local purpose descriptions from disposable memory. Preserve reference directionality and the distinction between AI-infrastructure memory and ordinary project documentation. Read back the complete file, verify the exact change and unchanged surrounding content, inspect diff and scope before continuing.

### Stage 3 — Establish target directory structure

- Move the FAQ files to their exact target paths and remove the old FAQ directory if empty.
- Move remaining former `.ai/docs/` material into maintained docs, memory, or archives according to actual purpose and completion evidence.
- Preserve unfinished research and decisions.
- Use Git operations that preserve complete content; do not reconstruct files from memory.
- Prefer coherent, reviewable structural changes over blind bulk path replacement.

### Stage 4 — Update active orientation and references

1. Update `.ai/README.md` to explain maintained documentation, memory, and archives.
2. Update `.ai/skills/ai-infrastructure/SKILL.md` so it reads persistent structural descriptions to understand/maintain the layout, but does not survey memory documents during normal activation.
3. Update `.ai/INDEX.md`, `AGENTS.md`, `.ai/AGENTS.md`, `.ai/skills/activation/SKILL.md`, `.ai/conversation-management/handoff/BOOTSTRAP.md`, and other active files only where inventory proves a current-facing contract/reference needs change.
4. Preserve historical paths in memory/archive records. Update only references proven to be current-facing.

### Stage 5 — README coverage

Inspect the actual resulting tree and ensure each real folder has one accurate README describing purpose, content categories, lifecycle, and semantic status. Verify links. Do not make README files duplicate active rule semantics.

### Stage 6 — Memory lifecycle skill

Check skill naming, activation, and routing conventions before creating the memory skill. Integrate minimally into discovery/activation only if the architecture requires it. Keep handoff lifecycle semantics with the handoff owner.

### Stage 7 — Archive completed material

Use current implementation evidence—not merely a stale COMPLETE label—to identify completed notes/TODOs. Archive completed items while preserving useful historical content and provenance. Keep unresolved work in memory and this handoff. Do not rewrite historical paths inside archived files.

### Stage 8 — Verification

For every existing-file edit, follow the canonical protocol:

READ CURRENT FILE → MAKE MINIMAL CHANGE → WRITE COMPLETE FILE → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT.

Verify FAQ content preservation and new paths, removal of old active paths, accurate docs/memory/archive roles, README coverage, active-owner semantic independence, valid operation-owned README reads, correct memory skill behavior, justified archival, preservation of unresolved work and historical paths, valid current-facing references, and intended changed-file scope. Inspect the complete diff and resulting repository state before declaring the migration complete.

## Important constraints

1. The three-way documentation/memory/archive layout is an accepted target, but individual files must be classified from current evidence.
2. Do not rewrite historical paths merely because they are old.
3. Do not perform mass edits before the inventory and classification are complete.
4. Do not promote inferences or assumptions to confirmed facts.
5. A successful API write or valid commit does not prove content correctness.
6. Do not modify C0084 merely to record that it was consumed.
7. Root `AGENTS.md` is the Agentic AI entry surface. Conversational AI initialization begins from the explicit bootstrap instruction; do not conflate these entry paths.
8. The tree snapshot is a point-in-time baseline. Pin audit reads to its commit and refresh the snapshot if the branch advances before a new repository-wide audit.

## Active TODOs

1. Implement the accepted active-owner / structural-description / memory boundary in `.ai/skills/repository/SKILL.md`.
2. Migrate former `.ai/docs/` content into the agreed `.ai/docs/` + `.ai/memory/` layout; move the two FAQ files to the exact new paths.
3. Update only affected current-facing active paths and operation-owned README reads; do not rewrite historical paths inside memory/archive files.
4. Ensure every real folder has one accurate README.
5. Create a dedicated memory-management skill for document lifecycle and TODO reconciliation/archival.
6. Verify implementation status and archive completed memory/TODO items; preserve unresolved work.
7. Re-run full path/reference and tree verification after migration.

## Immediate next task

Begin Stage 1: use the immutable snapshot at commit `78c321d62714463ddd3e420dfc311f11d1a7dd13` to inventory the current `.ai/docs/`, `.ai/memory/` (if present), `.ai/archives/`, README files, and current-facing references. Pin direct file reads to this commit. Do not edit or move files until the inventory and implementation-status classification are evidence-backed.


## User clarifications accepted during Stage 1

### Self-contained skills and documentation links

- Every .ai/skills/*/SKILL.md MUST be semantically self-contained: the AI must be able to understand and apply the skill without consulting supporting documentation to discover its actual behavior.
- A narrowly justified link to documentation for human help is permitted, e.g. .ai/skills/activation/SKILL.md linking to .ai/docs/manual-activation.md for practical examples. This is not an operational dependency and MUST NOT be used to offload required skill semantics.
- .ai/skills/ai-infrastructure/SKILL.md is specialized for infrastructure maintenance. It SHOULD inspect structural descriptions, README files, and the organization/status of .ai/docs/ and .ai/memory/ so it can maintain their cleanliness and layout, without reading every memory/document payload indiscriminately.
- Normal elevated context MUST NOT load all memory entries. Inspect the structure and relevant README/indicators first; read individual records only when the bounded task needs them. .ai/archives/** remains excluded from normal context, except for bounded historical retrieval.

### User-selected documentation to retain

The following documents are valuable and MUST remain in maintained .ai/docs/, relocated from .ai/docs/architecture/ to the root of .ai/docs/ together with the two FAQ files:

- .ai/docs/architecture/agentic-ai-dsh-observations.md → .ai/docs/agentic-ai-dsh-observations.md
- .ai/docs/architecture/agentic-ai-skill-discovery-verification.md → .ai/docs/agentic-ai-skill-discovery-verification.md
- .ai/docs/architecture/ai-infrastructure-context-mode.md → .ai/docs/ai-infrastructure-context-mode.md

The user explicitly values the DSH observations and skill-discovery verification as long-lived technical records. Do not archive them merely because they belong to the earlier agentic-ai-* series.

### Documentation update TODO and language/ownership policy

Created and read back successfully:

- .ai/memory/README.md — commit 0e04426618905a821d3c35943057d7f024c57623.
- .ai/memory/ai-docs-architecture-update-todo.md — commit eb3b53987d402c6ae61bf5edf1386d5981f726c2.

The TODO records a later review of all documents retained in .ai/docs/, requires new .ai/docs/ documents to be written in Russian apart from necessary technical terms/identifiers, and separates responsibilities for DSH-specific material: DSH should update technical descriptions of its own internals; AIP Mirror work should handle integration into AI-infrastructure semantics. The TODO also requires a technical-source/experiment-backed investigation of whenToUse, disable-model-invocation, and user-invocable. Do not assume whenToUse guarantees automatic activation until verified.

### Metadata field whenToUse

The user considers whenToUse especially valuable and wants its implications investigated for future common skills. Treat this as an open research question, not a confirmed claim about DSH's activation mechanism. Determine whether the field affects discovery, ranking, selection, or automatic invocation, and distinguish documented behavior from observed behavior.

### Refined semantic boundary

The distinction is dependency versus reading:

- Reading .ai/docs/ or .ai/memory/ for a justified infrastructure-maintenance task is permitted.
- Active skills MUST NOT require those documents to understand or apply their own required semantics.
- A human-help link from a skill to an explanatory FAQ is a narrow, explicit exception; it does not authorize skill behavior to be delegated to that FAQ.
- ai-infrastructure may consult supporting material when adding, correcting, or reviewing skills because infrastructure maintenance is its specialization—not because skills are allowed to be incomplete.

## Revised active TODOs

Keep existing TODOs 1–7. Add:

8. After the directory migration, review every retained .ai/docs/ document for conformance with the new architecture; write future .ai/docs/ files in Russian (retaining necessary technical terms); for DSH-authored technical findings, defer technical corrections to DSH or primary technical evidence while handling AIP Mirror integration here. Track work in .ai/memory/ai-docs-architecture-update-todo.md.
9. Investigate whenToUse, disable-model-invocation, and user-invocable from authoritative DSH technical evidence and/or controlled tests, and only then decide how confirmed behavior should inform common AIP Mirror skills.

## Updated immediate next task

The directory reorganization is now committed and verified on `main`; do not repeat Stage 1 or the completed moves. In C0086, continue the still-open `.ai/memory/ai-docs-architecture-update-todo.md`: review all seven maintained documents in `.ai/docs/`, classify claims as current/confirmed, historical, inferred, or open, fix current-use stale paths and references, verify semantic-owner boundaries, and record evidence. Do not translate existing documents as part of this review. For DSH-specific technical assertions, use authoritative DSH sources or controlled evidence and keep technical authorship separate from AIP Mirror integration.

## Recommended starting context

Read the current canonical versions of:

- `.ai/conversation-management/handoff/BOOTSTRAP.md`
- `.ai/conversation-management/handoff/SKILL.md`
- `.ai/skills/repository/SKILL.md`
- `.ai/skills/workflow/SKILL.md`
- `.ai/skills/activation/SKILL.md`
- `.ai/skills/ai-infrastructure/SKILL.md`
- `.ai/INDEX.md`
- `.ai/README.md`

Use `paulhuman/aip-mirror@78c321d62714463ddd3e420dfc311f11d1a7dd13` as the initial pinned inventory baseline. The C0084 tree at `cf4cfbede97b58cc25ac4f8b635f5bb70f44010d` is historical evidence only.


## Checkpoint — hierarchy and active-document authoring principles

### Completed in this checkpoint

- Created and read back .ai/docs/ai-document-hierarchy-and-authoring.md as a stable Russian-language architecture document, retaining necessary English technical terminology.
- The document records the agreed hierarchy and boundaries for canonical semantic owners, structural README files, maintained documentation, working memory, and archives.
- It explicitly distinguishes reading a document for a bounded task from depending on that document as a required source of semantics.
- It defines authoring principles for SKILL.md, INDEX.md, README.md, AGENTS.md, and BOOTSTRAP.md, including skill self-containment, progressive disclosure, evidence-backed technical claims, and final verification.
- It preserves the open research requirement not to assume undocumented behavior for whenToUse, disable-model-invocation, or user-invocable.
- Confirmed that .ai/memory/ exists and contains:
  - .ai/memory/README.md
  - .ai/memory/ai-docs-architecture-update-todo.md
- The memory TODO remains OPEN and records the later review of retained .ai/docs/ documents, Russian-language policy for future docs, separation of DSH technical authorship from AIP Mirror integration, and metadata research.

### Verification evidence

- Architecture document creation commit: d16b0a9a46810732cdadea1d4b552e9ee99b1aa5
- Read-back blob SHA: 6b8aadb7a77f7f80b9980b9fa8cb868b0c0389ec
- Read-back checks confirmed the hierarchy section, dependency-versus-reading distinction, skill-authoring rules, and coverage of INDEX.md, README.md, AGENTS.md, and BOOTSTRAP.md.
- The commit diff adds one new 152-line document and contains no unrelated paths.

### Immediate next task

C0086 must begin with the seven maintained documents now at the root of `.ai/docs/` and continue the OPEN documentation-update TODO. Inspect each document and its current-use links against the current repository tree; preserve historical paths where they are evidence rather than live instructions. Separate confirmed/current technical claims from historical observations, inference, and unresolved questions. Do not translate existing documents during this review. Update the TODO with evidence and verified outcomes; do not mark it complete until all criteria in the TODO are satisfied.


## Checkpoint — documentation and archive reorganization (2026-10-10)

### Completed and verified

- Added `.ai/docs/README.md`, including the rule that new documents in `.ai/docs/` are written in Russian apart from necessary technical terms and exact identifiers.
- Moved the two FAQ documents and four retained architecture/context documents to the root of `.ai/docs/`; all seven maintained documents plus the new README are now at one level.
- Moved five completed compatibility research notes and the former architecture README into the flat `.ai/archives/memory/` area.
- Flattened the former `.ai/archives/docs/architecture/` contents into `.ai/archives/memory/`; the archive now has 23 files at one level. `.ai/memory/` also remains flat.
- Updated `.ai/archives/README.md`, `.ai/INDEX.md`, and the active memory TODO to match the new paths and lifecycle boundaries.
- Added the same Russian-language policy to `.ai/memory/README.md`: new memory documents are written in Russian while necessary technical terminology and exact identifiers remain in their original form.
- The content and branch tree were read back and checked. The recursive tree was not truncated; no old `.ai/docs/architecture/`, `.ai/docs/faq/`, or `.ai/archives/docs/` paths remain.

### Verification evidence

- Main structural commit: `8ad398be5a1fb301894a6beefd96b786a941d3ce`.
- TODO status/path correction: `c2acbdaa352fc3d8ee9b9d182e3b5bbb5390261d`.
- Memory README language policy: `11701759e68e34b8c2cf60d27f29b06fe64230e1`; read-back blob SHA `d612bd070257766b9f0d023a05059c691dd1adc5`.
- Documentation review remains OPEN; structural reorganization does not establish that all retained content is current.
