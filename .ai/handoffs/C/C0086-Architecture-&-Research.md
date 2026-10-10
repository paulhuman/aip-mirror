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

Continue the accepted AI-infrastructure documentation review after the completed directory reorganization. Work through `.ai/memory/ai-docs-architecture-update-todo.md` using current repository evidence. Review all seven maintained documents in `.ai/docs/`, translate the existing English documents into Russian while preserving exact technical terms and identifiers, classify claims, fix current-use stale paths/references, verify semantic-owner boundaries, and record evidence. DSH-specific practical testing is deferred to DSH and tracked in the TODO.

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
- Existing English documents retained in `.ai/docs/` are to be translated into Russian as explicitly confirmed by the user in C0086. Preserve necessary technical terms, identifiers, paths, field names, exact technical designations, and verifiable source fragments in their original form.
- DSH-specific technical claims must be corrected only using authoritative DSH sources or primary technical evidence/controlled tests. Keep DSH technical authorship separate from AIP Mirror integration.
- Do not assume `whenToUse`, `disable-model-invocation`, or `user-invocable` behavior without evidence. In particular, whether `whenToUse` affects discovery, ranking, selection, or automatic invocation remains an open research question.
- For existing-file changes: READ CURRENT FILE → MAKE MINIMAL CHANGE → WRITE COMPLETE FILE → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT.
- Do not reconstruct existing content from memory. A successful write or valid commit does not prove content integrity.
- Do not repeat the completed directory moves or mass-rewrite historical paths in archive/memory records without a demonstrated current-facing reason.

## Immediate next task

1. Continue the OPEN TODO in `.ai/memory/ai-docs-architecture-update-todo.md`; the initial tree and current docs inventory were already established for this working branch.
2. Finish translating `.ai/docs/agentic-ai-skill-discovery-verification.md` and `.ai/docs/ai-infrastructure-vnext-proposal.md`, preserving experiment/version boundaries and clearly marking the proposal as proposed rather than accepted or implemented.
3. Audit and translate `.ai/docs/adapting-to-a-new-project.md`; verify its examples and current-facing paths against the active repository tree, distinguishing historical examples from current instructions.
4. Audit `.ai/docs/ai-document-hierarchy-and-authoring.md` and the seven-document index/links for consistency; classify claims as current/confirmed, historical, inferred, or open.
5. Leave practical DSH harness tests for `whenToUse`, `disable-model-invocation`, and `user-invocable` to DSH; keep this as an explicit open task in the TODO. Do not claim the harness was tested here.
6. For each bounded edit, read back the complete file, verify content, inspect diff/scope, and verify the resulting commit. Do not merge this branch into `main` without explicit user approval.

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


## Checkpoint — documentation translation and revised responsibility boundary (2026-10-10)

### Completed on working branch `c0086/ai-docs-audit-translation`

- Translated `.ai/docs/manual-activation.md`, `.ai/docs/agentic-ai-dsh-observations.md`, and `.ai/docs/ai-infrastructure-context-mode.md` into Russian.
- Corrected the current-facing manual-activation link in `.ai/skills/activation/SKILL.md` from the obsolete `.ai/docs/faq/manual-activation.md` path to `.ai/docs/manual-activation.md`.
- Updated current semantic-owner references in the DSH observations document while retaining old paths only where they explain historical structure.
- Updated `.ai/memory/ai-docs-architecture-update-todo.md` to require translation of the existing English documents in `.ai/docs/`, not only future documents.
- Recorded the current upstream DSH metadata findings with the caveat that they do not establish the behavior of every earlier or locally installed version.

### User decisions recorded

- Practical tests of DSH harness behavior—including the role of `whenToUse`, `disable-model-invocation`, and `user-invocable`—are deferred to DSH itself. Keep these as open TODO work; do not present upstream reading as a local harness test.
- Translate `.ai/docs/agentic-ai-skill-discovery-verification.md` without collapsing experimental observations, environment versions, historical results, and open questions into current facts.
- Translate `.ai/docs/ai-infrastructure-vnext-proposal.md` while explicitly preserving its proposal status; do not imply the proposed architecture has been accepted or implemented.
- Audit and translate `.ai/docs/adapting-to-a-new-project.md`; current-facing examples and paths can be checked against the repository tree, while historical examples should be classified rather than mechanically rewritten.
- Only documents under `.ai/docs/` are in scope for the Russian translation. Do not translate unrelated repository documents.

### Current state and next work

- The working branch has independent commits; these changes have not been merged into `main`.
- Three maintained documents have been translated; three English documents remain to be translated and audited. `.ai/docs/ai-document-hierarchy-and-authoring.md` is already in Russian and still needs consistency review.
- Continue with the DSH verification journal and vNext proposal translations, then inspect and translate the practical guide with current-tree verification.
- Keep the memory TODO OPEN until its evidence, semantic-owner, reference, and translation criteria have actually been verified.

### Verification boundaries

- Do not claim practical DSH harness testing was performed.
- Do not classify proposal-only paths as broken current links unless they are presented as current instructions.
- Do not mass-rewrite historical paths.
- Before each repository edit, read the current file; after writing, read it back, verify content, inspect the diff and changed-file scope, and verify the resulting commit.
