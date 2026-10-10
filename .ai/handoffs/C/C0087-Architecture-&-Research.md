# Conversation Handoff

**Conversation:**
C0087 — Architecture & Research

**Specialization:**
C

**Chapter:**
0087

**Previous chapter:**
0086

## Status

DRAFT

## Starting objective

Continue the AI-infrastructure documentation review from C0086. Work on the existing branch `c0086/ai-docs-audit-translation`; do not merge its substantive changes into `main` without explicit user approval. Finish the Russian translations and bounded audits of the remaining maintained documents under `.ai/docs/`, preserve experiment/version boundaries and proposal status, and keep the open TODO accurate.

## Bootstrap and repository identity

- Repository: `paulhuman/aip-mirror`
- Canonical branch: `main`, from `.ai/config.yaml`
- Repository locator: https://github.com/paulhuman/aip-mirror
- Specialization / short name: `C` / `Architecture & Research`
- Previous handoff: `.ai/handoffs/C/C0086-Architecture-&-Research.md`
- Current handoff: `.ai/handoffs/C/C0087-Architecture-&-Research.md`
- Bootstrap procedure: `.ai/conversation-management/handoff/BOOTSTRAP.md`
- Working branch to continue: `c0086/ai-docs-audit-translation`

## Confirmed bootstrap context

- The bootstrap instruction supplied `PREVIOUS_CHAPTER = 0086`, `CURRENT_CHAPTER = 0087`, `SPECIALIZATION = C`, and `SHORT_NAME = Architecture & Research`.
- `.ai/config.yaml` on `main` confirms repository `paulhuman/aip-mirror`, default branch `main`, and specialization C short name `Architecture & Research`.
- The predecessor handoff was read from `main` and from the working branch; both returned the C0086 handoff with the recorded migration checkpoint.
- The C0086 handoff says the working branch has independent documentation/audit commits and these changes have not been merged into `main`. The receiving chapter must resolve the branch head before substantive work and inspect the actual branch files.
- Repository write and commit tools are available; bootstrap follows the WRITE-CAPABLE branch.
- A fresh immutable full-tree snapshot was not established during this bootstrap. Do not make repository-wide completeness claims until the configured branch or target working branch is pinned to a commit and its tree completeness is verified.

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
- `.ai/handoffs/README.md`
- `.ai/handoffs/C/C0086-Architecture-&-Research.md`

## Accepted decisions and constraints

- Only documents under `.ai/docs/` are in scope for the Russian translation; do not translate unrelated repository documents.
- Preserve necessary technical terms, identifiers, paths, field names, exact technical designations, and source fragments in their original form.
- Translate `.ai/docs/agentic-ai-skill-discovery-verification.md` without collapsing experimental observations, environment versions, historical results, and open questions into current facts.
- Translate `.ai/docs/ai-infrastructure-vnext-proposal.md` while explicitly preserving its proposal status; do not imply that the proposal has been accepted or implemented.
- Audit and translate `.ai/docs/adapting-to-a-new-project.md`; verify current-facing examples and paths against the actual repository structure, while classifying historical examples rather than mechanically rewriting them.
- Review `.ai/docs/ai-document-hierarchy-and-authoring.md` and the seven-document index/links for consistency.
- Practical tests of DSH harness behavior—including the roles of `whenToUse`, `disable-model-invocation`, and `user-invocable`—are deferred to DSH and remain open TODO work. Do not claim these tests were performed.
- Do not mass-rewrite historical paths or repeat completed directory moves without a demonstrated current-facing reason.
- For existing-file changes: READ CURRENT FILE → MAKE MINIMAL CHANGE → WRITE COMPLETE FILE → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT. Do not reconstruct existing content from memory.
- Keep the memory TODO OPEN until its evidence, semantic-owner, reference, and translation criteria have actually been verified.

## Immediate next task

1. Resolve and record the current head of `c0086/ai-docs-audit-translation`; inspect its status and relevant files rather than assuming branch contents from this handoff.
2. Read `.ai/memory/ai-docs-architecture-update-todo.md` and the remaining document files from the pinned working-branch revision.
3. Translate and audit `.ai/docs/agentic-ai-skill-discovery-verification.md`, preserving versioned experimental evidence and open questions.
4. Translate `.ai/docs/ai-infrastructure-vnext-proposal.md`, clearly marking it as a proposal.
5. Audit and translate `.ai/docs/adapting-to-a-new-project.md` against current structure; distinguish current instructions from historical examples.
6. Review `.ai/docs/ai-document-hierarchy-and-authoring.md` and document indexes/links for consistency, then update the TODO only when supported by evidence.
7. For every edit, read back the complete file, verify content, inspect diff and changed-file scope, and verify the resulting commit. Do not merge to `main` without explicit user approval.

## Confirmed versus unresolved

**Confirmed:** bootstrap inputs; repository identity and configured default branch; specialization short name; predecessor handoff content and recorded task state; existence of the working branch; the agreed translation scope and DSH testing boundary.

**Not independently verified in this bootstrap:** the current immutable head/tree of the working branch; full-tree completeness; exhaustive current references; technical correctness of retained DSH observations; actual behavior of `whenToUse`, `disable-model-invocation`, and `user-invocable` in the relevant local harness.

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
