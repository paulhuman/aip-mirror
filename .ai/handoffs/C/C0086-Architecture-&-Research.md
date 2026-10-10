# Conversation Handoff

**Conversation:**
C0086 — Architecture & Research

**Specialization:**
C

**Chapter:**
0086

**Previous chapter:**
0085

## Starting objective

Continue the accepted AI-infrastructure documentation review after the completed directory reorganization. Work through `.ai/memory/ai-docs-architecture-update-todo.md` using current repository evidence. Review all seven maintained documents in `.ai/docs/`, classify claims, fix current-use stale paths/references, verify semantic-owner boundaries, and record evidence. Do not translate existing documents as part of this review.

## Bootstrap and repository identity

- Repository: `paulhuman/aip-mirror`
- Canonical branch: `main`, from `.ai/config.yaml`
- Repository locator: https://github.com/paulhuman/aip-mirror
- Specialization / short name: `C` / `Architecture & Research`
- Previous handoff: `.ai/handoffs/C/C0085-Architecture-&-Research.md`
- Current handoff: `.ai/handoffs/C/C0086-Architecture-&-Research.md`
- Bootstrap procedure: `.ai/conversation-management/handoff/BOOTSTRAP.md`

## Confirmed bootstrap context

- The bootstrap instruction supplied `PREVIOUS_CHAPTER = 0085`, `CURRENT_CHAPTER = 0086`, `SPECIALIZATION = C`, and `SHORT_NAME = Architecture & Research`.
- `.ai/config.yaml` confirms repository `paulhuman/aip-mirror`, default branch `main`, and specialization C short name `Architecture & Research`.
- The predecessor handoff was retrieved successfully from `.ai/handoffs/C/C0085-Architecture-&-Research.md`.
- GitHub repository write and commit tools are available; this initialization follows the WRITE-CAPABLE branch.
- The latest structural reorganization was recorded in predecessor handoff as commit `8ad398be5a1fb301894a6beefd96b786a941d3ce`; subsequent TODO/README changes are also recorded there. These are predecessor-reported checkpoints; this bootstrap did not independently resolve a fresh immutable tree snapshot.
- Do not make repository-wide completeness claims until a fresh authoritative commit/tree snapshot is established and its completeness verified.

## Canonical context read

- `.ai/config.yaml`
- `.ai/conversation-management/handoff/BOOTSTRAP.md`
- `.ai/skills/repository/SKILL.md`
- `.ai/skills/workflow/SKILL.md`
- `.ai/conversation-management/handoff/SKILL.md`
- `.ai/conversation-management/handoff/reference-preservation/SKILL.md`
- `.ai/skills/activation/SKILL.md`
- `.ai/skills/commits/SKILL.md`
- `.ai/AGENTS.md`
- `.ai/INDEX.md`
- `.ai/handoffs/README.md`
- `.ai/docs/README.md`
- `.ai/memory/ai-docs-architecture-update-todo.md`
- `.ai/handoffs/C/C0085-Architecture-&-Research.md`

## Accepted architecture and constraints

- `.ai/docs/` contains maintained AI-infrastructure documentation; `.ai/memory/` contains working memory and open TODOs; `.ai/archives/memory/` contains completed, superseded, or historical material.
- Active semantic owners must remain self-contained. Reading supporting documentation for a bounded task is permitted; depending on it to supply required owner semantics is not.
- README files orient readers and describe structure; they must not become duplicate semantic owners.
- Existing documents retained in `.ai/docs/` should not be translated as part of this review. New documents in `.ai/docs/` are written in Russian while necessary technical terms, identifiers, paths, field names, and exact technical designations remain in their original form.
- DSH-specific technical claims must be corrected only using authoritative DSH sources or primary technical evidence/controlled tests. Keep DSH technical authorship separate from AIP Mirror integration.
- Do not assume `whenToUse`, `disable-model-invocation`, or `user-invocable` behavior without evidence. In particular, whether `whenToUse` affects discovery, ranking, selection, or automatic invocation remains an open research question.
- For existing-file changes: READ CURRENT FILE → MAKE MINIMAL CHANGE → WRITE COMPLETE FILE → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT.
- Do not reconstruct existing content from memory. A successful write or valid commit does not prove content integrity.
- Do not repeat the completed directory moves or mass-rewrite historical paths in archive/memory records without a demonstrated current-facing reason.

## Immediate next task

1. Read the current canonical owners and establish a fresh immutable `main` commit/tree snapshot before making repository-wide claims.
2. Continue the OPEN TODO in `.ai/memory/ai-docs-architecture-update-todo.md`.
3. Inventory and read the seven maintained documents listed in `.ai/docs/README.md`; record which files were actually retrieved.
4. Classify claims as current/confirmed, historical, inferred, or open; verify current-facing paths and links, semantic-owner boundaries, and DSH-related assertions against evidence.
5. Make only bounded, evidence-backed edits, each with independent read-back and diff/scope verification. Record evidence and final status in the TODO. Archive completed work only after verification.

## Confirmed versus unresolved

**Confirmed:** repository identity, branch configuration, specialization short name, predecessor handoff contents, current TODO purpose, agreed docs/memory/archive layout, and the constraints above as recorded in the repository context read during bootstrap.

**Not independently verified in this bootstrap:** a fresh full-tree snapshot of current `main`; exhaustive completeness of all current references; technical correctness of retained DSH observations; actual semantics of `whenToUse`, `disable-model-invocation`, and `user-invocable`.

## Recommended starting context

- `.ai/memory/ai-docs-architecture-update-todo.md`
- `.ai/docs/README.md`
- `.ai/docs/ai-document-hierarchy-and-authoring.md`
- `.ai/docs/agentic-ai-dsh-observations.md`
- `.ai/docs/agentic-ai-skill-discovery-verification.md`
- `.ai/docs/ai-infrastructure-context-mode.md`
- `.ai/docs/ai-infrastructure-vnext-proposal.md`
- `.ai/docs/adapting-to-a-new-project.md`
- `.ai/docs/manual-activation.md`
- `.ai/skills/ai-infrastructure/SKILL.md`
- `.ai/skills/normative-language/SKILL.md`
