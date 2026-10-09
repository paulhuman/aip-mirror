# Conversation Handoff

**Conversation:**
C0083 — Architecture & Research

**Specialization:**
C

**Chapter:**
0083

**Previous chapter:**
0082

## Starting objective

Continue the AI-infrastructure active-file audit from C0082. Verify the current repository snapshot before making tree-wide claims, then complete an evidence-backed audit of active references and semantic-owner boundaries. The proposed three-level semantic-role model remains provisional and is not accepted as a final taxonomy. Avoid mass changes.

## Bootstrap and repository identity

- Repository: `paulhuman/aip-mirror`
- Canonical branch from `.ai/config.yaml`: `main`
- Repository locator: `https://github.com/paulhuman/aip-mirror`
- Specialization / short name: `C` / `Architecture & Research`
- Previous handoff: `.ai/handoffs/C/C0082-Architecture-&-Research.md`
- Current handoff: `.ai/handoffs/C/C0083-Architecture-&-Research.md`
- Canonical initialization procedure: `.ai/conversation-management/handoff/BOOTSTRAP.md`

## Confirmed bootstrap context

- The bootstrap instruction explicitly supplied `PREVIOUS_CHAPTER = 0082`, `CURRENT_CHAPTER = 0083`, `SPECIALIZATION = C`, and `SHORT_NAME = Architecture & Research`.
- `.ai/config.yaml` confirms repository `paulhuman/aip-mirror`, default branch `main`, and specialization C short name `Architecture & Research`.
- Repository write capability is available through the connected GitHub repository tools; bootstrap follows the WRITE-CAPABLE branch.
- The predecessor handoff was read successfully. It records a previously verified snapshot at commit `fbd0d8bfa2e298538fffd5e1617a2dab41bf885d`, root tree `a53cc9f6f419c9ca818ad49316d29d44d06a7657`, recursive tree `truncated=false`, 253 entries. This is a historical snapshot only; it does not establish current `main` HEAD.
- The generic GitHub `fetch` action supports Git Database REST endpoints. At the completed audit snapshot, `main` resolved to commit `05002d6f102ebd4bf5c359b77f9e1c85812eadcf`, root tree `2adc988ceb90d12cdb5a6edf0971bafd3971c8ee`; the recursive tree returned `truncated=false` and 254 entries. The audit reads below were pinned to immutable commit SHAs. The handoff update itself will create a later commit, so this snapshot identity is intentionally recorded rather than described as the future branch HEAD.

## Canonical files read during bootstrap

- `.ai/config.yaml`
- `.ai/conversation-management/handoff/BOOTSTRAP.md`
- `.ai/skills/repository/SKILL.md`
- `.ai/skills/workflow/SKILL.md`
- `.ai/skills/activation/SKILL.md`
- `.ai/skills/commits/SKILL.md`
- `.ai/conversation-management/handoff/SKILL.md`
- `.ai/conversation-management/handoff/reference-preservation/SKILL.md`
- `.ai/handoffs/README.md`
- `.ai/docs/architecture/README.md`
- `.ai/README.md`
- `.ai/INDEX.md`
- `.ai/handoffs/C/C0082-Architecture-&-Research.md`

## Confirmed current-file observations

1. **`.ai/skills/workflow/SKILL.md`** now includes the missing reusable procedure: resolve the configured branch ref → record commit SHA → read root tree SHA → retrieve the recursive tree → verify tree identity, `truncated=false`, and entry count → pin subsequent reads to the commit. This was added after checking 14 canonical owner/entry files; no exact procedure was found there.
2. **`.ai/handoffs/README.md`** had two operational references to the absent `.ai/skills/conversational-only/handoff/SKILL.md`. Both now point to `.ai/conversation-management/handoff/SKILL.md`; read-back verified the complete file and confirmed zero remaining occurrences of the stale path.
3. **`.ai/skills/activation/SKILL.md`** linked to the absent `.ai/architecture/faq/manual-activation.md`. The link now points to the existing `.ai/docs/faq/manual-activation.md`; read-back verified the complete file and confirmed zero remaining occurrences of the stale path.
4. **`.ai/docs/architecture/README.md`** still describes `.ai/skills/conversational-only/`, `.ai/workflows/`, and `.ai/templates/` as active owner locations. In the pinned complete tree, all three paths are absent; `.ai/conversation-management/` and `.ai/conversation-management/templates/` exist. This is a confirmed stale structural description, but correction must respect semantic ownership rather than mechanically replace every path.
5. **`.ai/README.md`** duplicates the `.ai/conversation-management/` entry and lists absent `.ai/templates/`. Both are confirmed in the pinned snapshot; a minimal README correction is still pending.
6. **`.ai/skills/repository/SKILL.md`** normatively classifies `.ai/templates/` as an active owner and includes it in the active-owner dependency prohibition, but that path is absent while templates live under `.ai/conversation-management/templates/`. This needs a deliberate taxonomy decision; do not mechanically substitute the nested path or treat the proposed three-level model as accepted.
7. **`.ai/skills/workflow/SKILL.md`** still uses `.ai/workflows/*` in its example batch even though that directory is absent from the pinned complete tree. The new tree-inspection procedure is present, but this example remains a separate stale-path candidate.
8. **`.ai/INDEX.md`** identifies itself coherently as a router/discovery surface, not a procedure owner. Its metadata-boundary exclusion list repeats `repository-state effects`; this is a confirmed narrow editorial defect, not by itself an architectural defect.
9. The architecture note `.ai/docs/architecture/ai-infrastructure-context-mode.md` was previously confirmed present at the pinned snapshot. Preserve historical passages unless evidence and scope justify a targeted correction.

These findings are based on the complete pinned tree recorded above. This chapter changed `.ai/skills/workflow/SKILL.md` to document the reusable tree-inspection procedure and corrected two stale operational links in `.ai/handoffs/README.md` and `.ai/skills/activation/SKILL.md`. The architecture README, general README, INDEX, and repository taxonomy have not yet been changed.

## Open questions and constraints

- The GitHub `fetch` action can read the Git ref, commit, and recursive tree APIs. The current documented procedure is now in `.ai/skills/workflow/SKILL.md`.
- The remaining question is how to update structural descriptions and the repository-owner taxonomy without accidentally creating a new or incorrect semantic boundary.
- Which stale paths are actionable in active operational content, and which are historical or explanatory mentions that should remain?
- How should the hybrid responsibilities in `.ai/skills/repository/SKILL.md` be classified without imposing a false mutually exclusive taxonomy?

Important constraints:
1. Root `AGENTS.md` remains the Agentic AI entry surface unless the user explicitly revises this boundary; Conversational AI bootstrap begins from the explicit bootstrap instruction.
2. Do not treat the three-level semantic-role model as final.
3. Separate actionable stale active references, intentional historical references, and unresolved references requiring evidence.
4. Do not mass-rewrite paths or mutate files merely because they mention removed locations.
5. Pin repository-wide claims to an immutable commit and record its root tree SHA, `truncated` value, and entry count; do not confuse an audit snapshot with a later `main` HEAD.
6. For existing-file changes: READ CURRENT FILE → MAKE MINIMAL CHANGE → WRITE COMPLETE CONTENT → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT.
7. Preserve historical snapshots and distinguish confirmed observations from inference, assumptions, and open questions.
8. Do not modify predecessor handoff snapshots merely to record that they were consumed.

## C0083 progress update (2026-10-10)

### Verified current snapshot

- After the structural-reference corrections and the manual-activation FAQ correction, `main` points to commit `2f18f94e74c34af84123b5d39d2e3d1756966af1`.
- Root tree: `2825cd8d8a5fda5871da20c6cca5b7ea0319bb09`; recursive tree returned `truncated=false`, 254 entries.
- The tree and all post-write reads were pinned to immutable commit SHAs. Candidate diffs and changed-file scope were inspected before updating `main`.

### Completed narrow corrections

1. Commit [`93f323c201c0bb66c40091558e5f14a2ece34300`](https://github.com/paulhuman/aip-mirror/commit/93f323c201c0bb66c40091558e5f14a2ece34300) corrected six files:
   - `.ai/docs/architecture/README.md`: replaced absent `.ai/skills/conversational-only/`, `.ai/workflows/`, and `.ai/templates/` structural descriptions with current conversation-management locations.
   - `.ai/README.md`: removed duplicate `.ai/conversation-management/` entry and described `.ai/conversation-management/templates/` instead of the absent root `.ai/templates/`.
   - `.ai/skills/workflow/SKILL.md`: corrected the example batch path from `.ai/workflows/*` to the existing `.ai/conversation-management/*`.
   - `.ai/skills/repository/SKILL.md`: removed `.ai/templates/` as a standalone active owner and clarified that `.ai/conversation-management/templates/` contains human-facing transport aids governed by conversation-management procedures, not an independent semantic owner. The proposed multi-level semantic-role model remains provisional.
   - `.ai/INDEX.md`: removed the duplicate `repository-state effects` bullet.
   - `docs/PROJECT-INSTRUCTIONS.md`: corrected three stale handoff/bootstrap paths and replaced the absent `.ai/workflows/` routing entry with the current general workflow owner.
2. Commit [`2f18f94e74c34af84123b5d39d2e3d1756966af1`](https://github.com/paulhuman/aip-mirror/commit/2f18f94e74c34af84123b5d39d2e3d1756966af1) corrected the stale handoff-skill reference in `.ai/docs/faq/manual-activation.md`.
3. Both commits were read back from their candidate commits, their diffs and scopes were inspected, and the branch head was verified after each update.

### Remaining audit findings

- `.ai/docs/faq/adapting-to-a-new-project.md` is an active how-to guide but contains many obsolete paths, including old conversational-only handoff paths and `.ai/workflows/`. Do not blindly rewrite the large document; decide whether to update its current instructions, clearly delimit historical examples, or otherwise retire obsolete guidance.
- `.ai/docs/architecture/agentic-ai-compatibility-architecture.md`, `.ai/docs/architecture/agentic-ai-compatibility-capability-audit.md`, and `.ai/docs/architecture/agentic-ai-owner-seam-audit.md` contain pre-migration `.ai/rules/`, `.ai/workflows/`, and older handoff-owner references. Their continuity points to C0069-era research, so preserve historical evidence and classify whether a current-state addendum or archival transition is warranted before editing.
- `.ai/docs/architecture/ai-infrastructure-context-mode.md` contains an old bootstrap path inside its historical validation record; `.ai/docs/architecture/ai-infrastructure-vnext-proposal.md` explicitly marks itself as predating the migration. Treat those occurrences as historical unless a specific current-facing passage is shown to be misleading.
- The root `README.md` is empty in the verified snapshot. No change was made to it.

## Immediate next task

1. Continue the active-reference audit, separating actionable current instructions from historical evidence in supporting documentation.
2. Inspect `.ai/docs/faq/adapting-to-a-new-project.md` as a current how-to guide. Classify its many obsolete paths and decide a bounded repair strategy before changing the large document.
3. Review the three C0069-era Agentic AI architecture/audit documents listed above. Preserve historical findings; decide whether current-path addenda or archival transitions are appropriate instead of mechanically rewriting snapshots.
4. Recheck active owner references only within a declared, pinned tree snapshot. Do not expand into archive contents or impose a final multi-level semantic-role taxonomy.
5. For any further edits, read current files at the pinned commit, make minimal changes, inspect candidate diff and scope, update `main` with an expected-SHA guard, then read back and verify the result.

## Recommended starting context

Start with this handoff, `.ai/skills/repository/SKILL.md`, `.ai/skills/workflow/SKILL.md`, `.ai/docs/faq/adapting-to-a-new-project.md`, `.ai/docs/architecture/agentic-ai-compatibility-architecture.md`, `.ai/docs/architecture/agentic-ai-compatibility-capability-audit.md`, and `.ai/docs/architecture/agentic-ai-owner-seam-audit.md`. Current tree proof and the Git ref → commit → root tree → recursive tree procedure are established; remaining work is classification of stale current-facing documentation versus preserved historical research.

