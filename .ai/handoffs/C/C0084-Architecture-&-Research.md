# Conversation Handoff

**Conversation:**
C0084 — Architecture & Research

**Specialization:**
C

**Chapter:**
0084

**Previous chapter:**
0083

## Starting objective

Continue the evidence-backed audit of semantic-owner boundaries in the AI infrastructure. Start from the current `.ai/skills/repository/SKILL.md` and related orientation documents. Distinguish active semantic owners, supporting/contextual material, and historical evidence by actual operational role. The proposed multi-level semantic-role model remains provisional; do not finalize a taxonomy or force mutually exclusive categories without evidence. Avoid mass changes.

## Bootstrap and repository identity

- Repository: `paulhuman/aip-mirror`
- Canonical branch from `.ai/config.yaml`: `main`
- Repository locator: `https://github.com/paulhuman/aip-mirror`
- Specialization / short name: `C` / `Architecture & Research`
- Previous handoff: `.ai/handoffs/C/C0083-Architecture-&-Research.md`
- Current handoff: `.ai/handoffs/C/C0084-Architecture-&-Research.md`
- Canonical initialization procedure: `.ai/conversation-management/handoff/BOOTSTRAP.md`

## Confirmed bootstrap context

- The bootstrap instruction explicitly supplied `PREVIOUS_CHAPTER = 0083`, `CURRENT_CHAPTER = 0084`, `SPECIALIZATION = C`, and `SHORT_NAME = Architecture & Research`.
- `.ai/config.yaml` confirms repository `paulhuman/aip-mirror`, default branch `main`, and specialization C short name `Architecture & Research`.
- The canonical handoff workflow specifies the receiving handoff path `.ai/handoffs/C/C0084-Architecture-&-Research.md`.
- Repository write capability is available through the connected GitHub repository tools; this bootstrap follows the WRITE-CAPABLE branch.
- The predecessor handoff was read successfully. Its immediate next task is to continue the evidence-backed audit of semantic-owner boundaries, with particular attention to `.ai/skills/repository/SKILL.md`, related orientation documents, and the historical status of older architecture material.
- The latest commit returned by the GitHub commit search during bootstrap was `93cee20e64e1d6a9124ac3a8782e8e348fbec0b7`, message `ai-docs(handoff): update C0083`. This identifies the latest commit visible to that search; an authoritative Git ref/root-tree/recursive-tree completeness check has not yet been performed in this chapter. Do not present a repository-wide tree audit as freshly verified until that snapshot is established.

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
- `.ai/README.md`
- `.ai/handoffs/README.md`
- `.ai/docs/architecture/README.md`
- `.ai/handoffs/C/C0083-Architecture-&-Research.md`

## Carried-forward findings from C0083

These are findings recorded in the predecessor handoff, not claims that a new complete-tree audit has already been repeated in C0084.

1. **Repository tree inspection procedure.** `.ai/skills/workflow/SKILL.md` documents the sequence for resolving a configured branch to an immutable commit, recording the root tree SHA, retrieving the recursive tree, verifying `truncated=false` and entry count, and pinning subsequent reads to the commit.
2. **Structural-reference corrections.** C0083 recorded corrections to stale active structural references in architecture/readme/orientation material and operational links. The specific commits and files are documented in the predecessor handoff; use current file content rather than assuming all carried-forward details remain current.
3. **Historical research documents.** The three Agentic AI research documents were recorded as superseded historical evidence by reference to `.ai/docs/architecture/ai-infrastructure-vnext-proposal.md`. Current-facing owner references were updated while historical paths inside evidence were retained.
4. **Historical bootstrap references.** C0083 recorded an old bootstrap path inside a historical validation record in `.ai/docs/architecture/ai-infrastructure-context-mode.md`, and noted that the vNext proposal explicitly predates the migration. Preserve such passages when they are clearly historical unless evidence shows a current-facing claim is misleading.
5. **Root README.** The predecessor recorded the root `README.md` as empty in its verified snapshot. Recheck before relying on that observation.
6. **Audit scope.** The predecessor's last recorded complete-tree audit baseline was commit `0cecf6ef04792d5d181f08271ca437aedd90bec7`, root tree `e706ab0bbbfd4e94fcc9857a60b9c29959bd047d`, `truncated=false`, 254 entries. This is a historical snapshot, not the current C0084 baseline.

## Important constraints

1. Before new repository-wide structural claims, establish a fresh immutable commit/tree snapshot; record commit SHA, root tree SHA, `truncated` value, and entry count. Pin subsequent audit reads to that commit.
2. Treat the three-level semantic-role model as provisional. Do not finalize the taxonomy or assume categories are mutually exclusive.
3. Separate actionable stale references in current operational content from intentional historical evidence and unresolved references requiring more evidence.
4. Do not mass-rewrite paths or mutate files merely because they mention removed locations.
5. For existing-file changes, follow: READ CURRENT FILE → MAKE MINIMAL CHANGE → WRITE COMPLETE CONTENT → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT.
6. A successful API write or valid commit does not prove the content is correct.
7. Preserve the distinction between confirmed observations, inferences, assumptions/unverified claims, and open questions.
8. Do not modify predecessor handoff snapshots merely to record that they were consumed.
9. Root `AGENTS.md` is the repository entry surface for Agentic AI. Conversational AI chapter initialization begins from the explicit bootstrap instruction; do not conflate the two entry paths.

## C0084 findings and accepted decisions

### Confirmed semantic distinction

The user clarified the model more precisely than the previous provisional taxonomy:

- Active semantic owners are self-contained. They define the rules and operational semantics needed to perform their own function.
- Active owners do not read or depend on disposable memory content as an authority for their own semantics.
- Active operations MAY read persistent structural descriptions such as README files and local descriptions of directory/file purpose. Such files explain the structure and lifecycle of a layer; they are not the disposable contents of that layer.
- README files are part of the active orientation surface. Reading a README that describes memory is not the same as reading memory entries.
- For example, `.ai/skills/ai-infrastructure/SKILL.md` should inspect/read persistent descriptions of the memory/documentation structure to understand what exists and whether the structure is maintained. It should not survey or ingest memory notes as part of normal activation.
- `.ai/conversation-management/handoff/BOOTSTRAP.md` may read the prescribed orientation README files for its bootstrap purpose. This does not make those README files owners of bootstrap semantics.
- Ordinary project-specific `docs/` remains maintained project documentation and is distinct from AI-infrastructure memory.

### Directionality of references

The user accepted the proposed rule formulation, to be proposed and implemented in the active canonical owner:

1. Active owners contain their own complete operational semantics.
2. Active owners may link to/read permanent structural descriptions (README files and local purpose descriptions) where that is part of their operation.
3. Active owners MUST NOT depend on handoffs, memory entries, archives, or other disposable contextual material to understand or establish their own semantics.
4. Memory, handoffs, and historical/archive material MAY refer to active rules, skills, workflows, and routers.
5. Links from active owners back to disposable memory content are prohibited; references to permanent structural descriptions are allowed when operationally justified.
6. A normal operation may inspect a layer's README to maintain structural awareness, but MUST NOT treat the layer's contents as a routine read set merely because the layer exists.

These are accepted user-level design decisions. Exact normative wording and placement in `.ai/skills/repository/SKILL.md` must be made as a minimal edit during implementation.

### Documentation versus memory

The user explicitly approved this target layout:

- `.ai/docs/` becomes the maintained, current documentation layer for AI-infrastructure.
- `.ai/memory/` becomes the working-memory layer for notes, TODOs, research, handoffs/context carried between tasks, and material with limited useful lifetime.
- Move the two FAQ files from `.ai/docs/faq/` to the root of `.ai/docs/`:
  - `.ai/docs/faq/adapting-to-a-new-project.md` → `.ai/docs/adapting-to-a-new-project.md`
  - `.ai/docs/faq/manual-activation.md` → `.ai/docs/manual-activation.md`
- The old `.ai/docs/` architecture/context contents are memory, not maintained architecture documentation merely because they were previously stored under a directory named `docs`.
- Completed memory/TODO material is considered worked through when the described implementation has actually been completed and verified. Archive completed material rather than repeatedly revisiting or rewriting its historical paths.
- Do not mechanically correct historical paths inside memory/archive documents. Their old paths may be evidence of the structure that existed when the document was written. Archive completed memory when appropriate; preserve unresolved work in memory.
- Ordinary repository `docs/` is a separate project-documentation layer and should remain current and reflect the actual project architecture.

### README policy

The user wants one README per folder. During implementation, inventory the actual resulting directory tree and ensure each folder has one appropriate README that explains its purpose and contents. At minimum this includes the roots `.ai/docs/` and `.ai/memory/`; existing nested folders must be checked against the final tree rather than assumed.

README files are persistent structural descriptions and part of the active orientation surface. They MUST NOT become duplicate semantic owners or redefine the canonical rules/skills.

### Memory lifecycle and future skill

Create a new TODO for a dedicated first-level skill for memory lifecycle management, likely `.ai/skills/memory/SKILL.md` after checking current skill naming and activation conventions. This is not implemented yet.

The skill should define how to:
- create and place memory documents;
- record TODOs with a clear status and implementation target;
- reconcile active TODOs against the current repository state instead of blindly carrying them forward;
- verify whether described work is actually implemented;
- archive completed TODOs and memory documents;
- preserve unresolved decisions, dependencies, and evidence;
- distinguish active TODOs from completed/historical records;
- keep memory README/descriptions accurate without making memory contents part of normal active-owner context;
- avoid re-reading completed TODOs unless there is a concrete verification or recovery reason.

The handoff workflow owns conversation continuity and handoff lifecycle. The proposed memory skill must complement it, not duplicate or replace it.

## C0084 outcome

- The full-tree method is already implemented in `.ai/skills/workflow/SKILL.md`, section 9, “Establishing an authoritative, pinned tree snapshot.” The method is not a pending implementation TODO. It resolves the configured branch to an immutable commit, records the root tree SHA, retrieves/verifies the recursive tree and its completeness, pins file reads, and records audit evidence.
- The last snapshot verified in this chapter was commit `cf4cfbede97b58cc25ac4f8b635f5bb70f44010d`, root tree `ccb0a0ee67e4170dcedd18be28014353d275e29f`, `truncated=false`, 255 entries. Treat this as the snapshot observed during C0084, not a claim about the current head at C0085 bootstrap.
- No repository mutations were made during the semantic-boundary investigation in C0084.
- The previous audit's suggested approach of rewriting historical paths in architecture notes is explicitly rejected. Treat those files as memory/history and archive completed material instead of polishing historical references.
- C0084 is handing off the work. Per the canonical handoff skill, do not pre-create the C0085 handoff and do not mark this handoff as transferred/closed.

## C0085 implementation plan — preserve all stages

Do the work in ordered, verifiable stages. Do not combine the entire restructuring into one blind path-replacement pass.

### Stage 0 — Bootstrap and establish evidence

1. Run the canonical bootstrap for C0085.
2. Activate and reread current canonical owners, especially:
   - `.ai/conversation-management/handoff/BOOTSTRAP.md`
   - `.ai/conversation-management/handoff/SKILL.md`
   - `.ai/skills/repository/SKILL.md`
   - `.ai/skills/workflow/SKILL.md`
   - `.ai/skills/activation/SKILL.md`
   - `.ai/skills/ai-infrastructure/SKILL.md`
   - `.ai/INDEX.md`
   - `.ai/README.md`
3. Establish a fresh authoritative pinned tree snapshot of `main` using the procedure in workflow/SKILL.md. Record commit SHA, root tree SHA, tree identity, `truncated`, and entry count. Do not rely on the C0084 snapshot as the new chapter's baseline.
4. Retrieve the complete relevant tree and file contents using authoritative tree/direct file reads. If the available tool path cannot retrieve the full tree, state the limitation and do not claim a complete inventory.

### Stage 1 — Inventory current structure and references

1. Enumerate every path under `.ai/docs/`, `.ai/memory/` if already present, `.ai/archives/`, and all relevant README files from the verified tree.
2. Inventory every current reference to:
   - `.ai/docs/`
   - `.ai/docs/faq/`
   - the two FAQ filenames
   - any intended new `.ai/memory/` paths
   - architecture/context notes that are to be archived or retained as unresolved memory.
3. Classify references by role:
   - active semantic dependency (prohibited when it depends on disposable memory content);
   - justified operation-owned read of a persistent README/structural description;
   - navigation to a permanent structure description;
   - memory/handoff/archive reference to an active owner;
   - historical reference inside memory/archive, which should not be rewritten merely to modernize it.
4. Do not use code-search results alone as proof of completeness. Record exact files actually retrieved.
5. Classify memory documents by implementation status: completed and verifiably implemented, unresolved/open, or unclear. Do not reread completed TODOs as a routine step; use active owners/current repository state to verify implementation.

### Stage 2 — Define the active semantic boundary

1. Make a minimal, evidence-backed edit to `.ai/skills/repository/SKILL.md` defining self-contained active owners and the permitted structural-description exception.
2. Explicitly distinguish permanent README/local purpose descriptions from disposable memory contents.
3. Define reference directionality: memory/handoffs/archive may refer to active owners; active owners may read justified permanent structure descriptions but MUST NOT depend on memory entries for semantics.
4. Preserve the distinction between AI-infrastructure memory and ordinary project `docs/`.
5. Re-read the complete updated file, verify the exact wording and unchanged surrounding content, inspect diff and scope, and only then continue.

### Stage 3 — Establish the directory target

Target structure:
- `.ai/docs/`: current, maintained AI-infrastructure documentation, including the two FAQ documents at its root.
- `.ai/memory/`: non-canonical working memory and unresolved/active research notes.
- `.ai/archives/`: completed, superseded, or obsolete memory retained for historical evidence and eventual cleanup.

Move the FAQ files to the exact target paths recorded above. Do not keep a redundant `.ai/docs/faq/` directory once empty.

Move the remaining former `.ai/docs/` material into the memory layer as appropriate. Before moving each architecture/context note, determine whether its work is completed and should be archived, or whether it contains unresolved work that must remain in `.ai/memory/`. Do not discard unfinished research simply because it is old.

Use Git tree/file operations that preserve complete file content and, where possible, make structural changes in a coherent reviewable commit. Do not reconstruct files from memory.

### Stage 4 — Update active orientation and operation-owned reads

1. Update `.ai/README.md` to explain the three distinct layers: maintained AI documentation, memory, and archives.
2. Update `.ai/skills/ai-infrastructure/SKILL.md`: it should read persistent README/structural descriptions to understand the current layout and keep structural awareness current. It must not survey/ingest the memory documents themselves as part of normal activation.
3. Update `.ai/INDEX.md`, `AGENTS.md`, `.ai/AGENTS.md`, `.ai/skills/activation/SKILL.md`, `.ai/conversation-management/handoff/BOOTSTRAP.md`, and other active files only where the inventory demonstrates a real current-facing path/contract change.
4. The active-owner-to-memory link prohibition does not prohibit links to permanent README descriptions when justified by an operation. It does prohibit using memory content as a source of active semantics.
5. Preserve historical paths in memory/archive records. Do not bulk-rewrite them.
6. Update only current-facing references to the two moved FAQ files and other paths that are proven to be live references.

### Stage 5 — README coverage

1. Inspect the actual post-migration directory tree.
2. Ensure one appropriate README exists in every folder, including root `.ai/docs/`, root `.ai/memory/`, and relevant nested folders.
3. Each README must explain the folder's purpose and content categories, lifecycle, and semantic status. Keep it an orientation file, not a duplicate rule owner.
4. Do not create meaningless placeholder directories solely to satisfy the README rule; the rule applies to folders that genuinely exist in the resulting design.
5. Verify all README links against the resulting tree.

### Stage 6 — Create the memory-management skill

Create and activate a TODO for a dedicated skill, expected path `.ai/skills/memory/SKILL.md` (confirm naming/structure before creation).

Design the skill to own:
- memory document creation and placement;
- TODO creation and required status/target/evidence fields;
- reconciliation of TODOs against active rules and current repository state;
- verification of implementation before marking work complete;
- archiving completed TODOs and memory documents;
- handling unresolved or superseded work;
- retention of historical evidence without path modernization;
- memory README maintenance;
- a rule against routinely re-reading completed TODOs without a concrete need.

Read current skill conventions and activation/routing requirements first. Integrate the skill minimally into the appropriate discovery/activation mechanisms only if required by the actual architecture. Do not duplicate handoff lifecycle ownership.

### Stage 7 — Archive completed material

1. Use the inventory and current active owner state to identify memory documents/TODOs whose described implementation is complete and verifiable.
2. Archive completed material under the appropriate `.ai/archives/` paths, preserving useful historical content and provenance.
3. Keep unfinished decisions, dependencies, and implementation stages in `.ai/memory/` and the active C0085 handoff.
4. Do not rewrite old paths inside archived files.
5. Record why each item is complete using current implementation evidence, not merely a stale “COMPLETE” label.
6. After archival, active TODO state should contain only work that remains to be done or explicitly needs follow-up.

### Stage 8 — Verification and finalization

For every existing-file edit, follow the canonical repository mutation protocol:
READ CURRENT FILE → MAKE MINIMAL CHANGE → WRITE COMPLETE FILE → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT.

Verify at minimum:
- all expected FAQ files exist at the new paths with their content preserved;
- old FAQ paths no longer exist as active files;
- `.ai/docs/` describes maintained documentation, not a memory archive;
- `.ai/memory/` exists and its contents/README reflect the actual result;
- each real folder has exactly the intended README;
- active owners contain their own semantics and do not link to memory entries for self-explanation;
- operation-owned reads of persistent README files remain valid;
- `.ai/skills/ai-infrastructure/SKILL.md` does not read memory contents as normal context;
- completed TODOs and completed notes are archived only after verifying implementation;
- unfinished work is preserved;
- historical memory/archive paths have not been rewritten;
- all current-facing references resolve;
- changed-file scope contains only intended files.
Inspect the complete diff and verify the resulting repository state before declaring the migration done.

## Active TODOs for C0085+

1. Implement the accepted active-owner / structural-description / memory boundary in `.ai/skills/repository/SKILL.md`.
2. Migrate former `.ai/docs/` content into the agreed `.ai/docs/` + `.ai/memory/` layout; move the two FAQ files to the exact new paths.
3. Update only affected current-facing active paths and operation-owned README reads; do not rewrite historical paths inside memory/archive files.
4. Ensure every real folder has one accurate README.
5. Create a dedicated memory-management skill for document lifecycle and TODO reconciliation/archival.
6. Verify implementation status and archive completed memory/TODO items; preserve unresolved work.
7. Re-run full path/reference and tree verification after migration.

## Migration state

- Current chapter: C0084.
- User requested `>>migrate 0085`.
- Derived next chapter: C0085 (sequential target matches the user assertion).
- C0084 handoff is the checkpoint to update for the immediate successor. Do not pre-create the C0085 handoff.
- The receiving chapter must establish its own fresh snapshot and create its own handoff during canonical bootstrap.

## Recommended starting context

For C0085, start with this handoff and the current versions of:
- `.ai/conversation-management/handoff/BOOTSTRAP.md`
- `.ai/conversation-management/handoff/SKILL.md`
- `.ai/skills/repository/SKILL.md`
- `.ai/skills/workflow/SKILL.md`
- `.ai/skills/activation/SKILL.md`
- `.ai/skills/ai-infrastructure/SKILL.md`
- `.ai/INDEX.md`
- `.ai/README.md`
- `.ai/docs/architecture/README.md` (historical path in C0084; resolve the current location after the migration is performed)
- the two FAQ files at their current paths or their migrated paths, depending on actual repository state.

Treat C0084 snapshot `cf4cfbede97b58cc25ac4f8b635f5bb70f44010d` as historical evidence only. Refresh the snapshot before repository-wide claims.
