# Conversation Handoff

**Conversation:**
C0088 — Architecture & Research

**Specialization:**
C

**Chapter:**
0088

**Previous chapter:**
0087

## Bootstrap and recovery status

- Repository: `paulhuman/aip-mirror`
- Canonical branch: `main`, as configured in `.ai/config.yaml`.
- Working branch to continue: `c0086/ai-docs-audit-translation`.
- Bootstrap inputs supplied: `PREVIOUS_CHAPTER = 0087`, `CURRENT_CHAPTER = 0088`, `SPECIALIZATION = C`; resolved `SHORT_NAME = Architecture & Research`.
- The receiving handoff path is `.ai/handoffs/C/C0088-Architecture-&-Research.md`.
- This chapter was initialized as recovery after an interrupted migration and context exhaustion.
- **Recovery limitation:** no `C0087` handoff was present in the inspected working-branch tree at commit `6f93b494e6c7bc7dc4af27b17ee2fd5b55f39bc5`. The most recent active handoff found was `.ai/handoffs/C/C0086-Architecture-&-Research.md`, whose migration checkpoint records the expected successor as C0087 and identifies the continuing task. Therefore, the missing C0087 conversation-specific state has not been reconstructed or treated as confirmed. The user intends to provide additional context from the interrupted conversation before substantive work resumes.
- The bootstrap orientation files `.ai/memory/README.md` and `.ai/docs/README.md` were read. The old `.ai/docs/architecture/README.md` path no longer exists because its orientation responsibilities are split between those two README files.
- The branch's pinned tree snapshot at `6f93b494e6c7bc7dc4af27b17ee2fd5b55f39bc5` has root tree SHA `626b38ca93dfb90ff6ff346361221efc2874b3cb`; recursive tree returned 259 entries with matching tree SHA and `truncated = false`. This confirms the absence of C0087 in that branch snapshot, not necessarily in every historical commit or branch.

## Current project objective

Continue the open AI-infrastructure documentation review recorded in `.ai/memory/ai-docs-architecture-update-todo.md`. Do not resume substantive changes until the user supplies the missing context from the interrupted conversation and the current state is reconciled against that context.

## Confirmed state from C0086 and the working branch

- The active working branch is `c0086/ai-docs-audit-translation`; its changes have not been merged into `main`.
- Three maintained documents were translated into Russian; further documentation review and translation remain.
- The TODO remains **OPEN**. DSH-specific runtime behavior for `whenToUse`, `disable-model-invocation`, and `user-invocable` remains unresolved; no new DSH harness experiments should be claimed.
- The maintained documentation inventory is in `.ai/docs/README.md`; working records and open tasks belong in `.ai/memory/`.
- `.ai/memory/README.md` defines working memory as the location for unfinished investigations, active TODOs, and open questions.
- `.ai/docs/README.md` defines `.ai/docs/` as supporting architecture/research documentation, not a replacement for canonical semantic owners. Both README files specify Russian for new documents, preserving exact technical terms and identifiers.
- The previous audit added evidence to the TODO claiming that a complete recursive tree could not be retrieved. That claim is contradicted by the verified tree request described above and needs correction before relying on the audit evidence. Do not silently change the TODO without reading the current complete file and following the repository write-safety protocol.
- Earlier commits on the branch used `docs: ...` for `.ai/` infrastructure changes, despite the current commits skill specifying the local `ai-*` namespace for such changes. Do not rewrite history without explicit user authorization. For handoff creation/update, use the exact `ai-docs(handoff): create C088` / `ai-docs(handoff): update C088` pattern required by the current commits skill.

## Immediate next task

1. Receive the user's context from the interrupted C0087 conversation.
2. Reconcile that context with the current branch head, the open TODO, and the evidence already present in the repository. Preserve uncertainty and do not repeat work that the context shows was already done.
3. Correct the TODO's obsolete statement about recursive-tree retrieval only after rereading the complete current file, then read back and verify the edit and its scope.
4. Continue the remaining maintained-document and reference/path audit, using an immutable commit/tree snapshot and pinning all reads to that commit.
5. Keep the TODO **OPEN** until all criteria, including DSH-specific evidence or explicitly assigned testing, are satisfied.
6. Do not merge the working branch into `main` or rewrite existing commit history without explicit user approval.

## Verification and operating constraints

- For repository edits: READ CURRENT FILE → MAKE MINIMAL CHANGE → WRITE COMPLETE FILE → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT.
- A successful API write or valid Git commit is not proof of correct content.
- Read canonical owners before executing their procedures; do not reconstruct rules or files from memory.
- Keep visible TRACE in the assistant response for routed operations, including `ACTIVATE owners` and `OPERATION READS files`.
- Separate confirmed observations, inferences, assumptions, and open questions. The user's promised context from the interrupted chat has not yet been received.

## Recommended starting context

- `.ai/memory/ai-docs-architecture-update-todo.md`
- `.ai/memory/README.md`
- `.ai/docs/README.md`
- `.ai/skills/workflow/SKILL.md`
- `.ai/skills/commits/SKILL.md`
- `.ai/conversation-management/handoff/BOOTSTRAP.md`
- `.ai/handoffs/C/C0086-Architecture-&-Research.md`
