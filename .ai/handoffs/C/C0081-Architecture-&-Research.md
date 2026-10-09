# Conversation Handoff

**Conversation:**
C0081 — Architecture & Research

**Specialization:**
C

**Chapter:**
0081

**Previous chapter:**
0080

## Starting objective

Recover the interrupted migration into C0081 and continue the AI-infrastructure audit. First determine the intended entry contract between the root Agentic AI instructions and the conversational-only chapter bootstrap. Inspect the complete root `AGENTS.md`, the current `.ai/AGENTS.md`, the nested `BOOTSTRAP.md`, and Git history—especially the earlier version of item 6 in `.ai/AGENTS.md`. Do not make broad architectural changes before the contract and relevant file boundaries are verified.

## Bootstrap and repository identity

- Repository: `paulhuman/aip-mirror`
- Canonical branch: `main`
- Repository locator: `https://github.com/paulhuman/aip-mirror`
- Specialization / short name: `C` / `Architecture & Research`
- Previous handoff: `.ai/handoffs/C/C0080-Architecture-&-Research.md`
- Current handoff: `.ai/handoffs/C/C0081-Architecture-&-Research.md`
- Canonical initialization procedure: `.ai/conversation-management/handoff/BOOTSTRAP.md`

## Confirmed starting context

- The explicit bootstrap message supplied `PREVIOUS_CHAPTER = 0080`, `CURRENT_CHAPTER = 0081`, and `SPECIALIZATION = C`. The configured short name resolves to `Architecture & Research` from `.ai/config.yaml`.
- The C0080 handoff exists and was read from `main`. It records an unresolved inconsistency: `.ai/conversation-management/handoff/BOOTSTRAP.md` Shared steps item 1 requires validating the “AGENTS item 6 entry path”, although the conversational bootstrap begins from an explicit bootstrap instruction and does not include root `AGENTS.md` in its ACTIVATE owner set.
- Root `AGENTS.md` describes itself as the repository entry point for AI agents and routes through `.ai/config.yaml`, `.ai/skills/repository/SKILL.md`, `.ai/AGENTS.md`, and `.ai/INDEX.md`. It should remain an Agentic AI entry surface; do not add it to Conversational AI's required read set merely to reconcile wording.
- The current `.ai/AGENTS.md` has six numbered items. Its current item 6 says to reread the canonical skill, workflow, or project source that owns the operation before executing it. It does not describe a chapter-bootstrap entry path.
- Git history confirms that item 6 previously said: when initializing a new conversation chapter, use `.ai/workflows/handoff/BOOTSTRAP.md` as the canonical chat-initialization workflow and do not invent a separate entry procedure. Commit `b9d37bd916144dffceeb67c471075ae41d83ae97` changed item 6 to the current operation-owner reread rule while adding repository mutation-safety items 3–4 and renumbering the remaining items. The same older item-6 wording is present at commit `c6fe2692e36a5c76d508759129c82aef3301b2ea`.
- Therefore the bootstrap's “AGENTS item 6 entry path” wording reflects an earlier contract and became stale when `.ai/AGENTS.md` item 6 was repurposed. This is now supported by direct historical file reads and the changing commit diff, not merely inferred from current text.
- The current bootstrap Shared steps item 1 therefore does not match the visible current wording of either the root `AGENTS.md` or `.ai/AGENTS.md`. This is an observed textual mismatch; the intended historical contract is not yet established.
- The current nested bootstrap requires the explicit repository locator, then `.ai/config.yaml` before resolving other repository-relative paths, and calls for the repository skill as the first repository-controlled semantic owner.
- `.ai/handoffs/README.md` and `.ai/docs/architecture/README.md` still contain stale references to removed locations such as `.ai/skills/conversational-only/handoff/`, `.ai/workflows/`, and `.ai/templates/`. These are already part of the wider audit; do not silently fix them during this bounded entry-contract investigation.

## Important constraints

1. Keep root `AGENTS.md` exclusively as the Agentic AI entry surface unless the user explicitly revises this boundary.
2. Do not require Conversational AI to read all Agentic AI instructions as a prerequisite to explicit bootstrap.
3. Inspect Git history for `.ai/AGENTS.md` and recover the earlier item 6 wording before deciding whether bootstrap text is stale or another contract changed during migration.
4. Keep observations distinct from inferences and assumptions.
5. No broad mutation until the actual boundary and intended correction are supported by repository evidence.
6. For existing-file changes: READ CURRENT FILE → MAKE MINIMAL CHANGE → WRITE COMPLETE CONTENT → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT.
7. Treat `.ai/config.yaml` and the current repository state on `main` as authoritative for identity and current content. Use explicit commit refs for historical content.
8. Do not modify archived handoff snapshots merely to record that they were consumed.

## Immediate next task

1. Retrieve the history of `.ai/AGENTS.md` from GitHub, including the commit that changed its item 6 during the recent migration. Read the relevant commit diff and the file at the parent revision.
2. Compare that historical item 6 with the current `.ai/AGENTS.md`, root `AGENTS.md`, and the full bootstrap entry/Shared steps contract.
3. Determine whether the “AGENTS item 6 entry path” wording was once valid and became stale, or whether it was already invalid. Preserve the Agentic/Conversational boundary.
4. Only after the historical contract is clear, propose the smallest canonical-owner correction. Do not implement a correction without evidence and a clear scope.
5. Continue the wider infrastructure audit and validate the provisional semantic-role model against real files and hybrid cases; the three-level model is not accepted as final.

## Confirmed versus open

- **Confirmed:** Current root `AGENTS.md` is the repository entry point for AI agents and should remain Agentic AI-focused per the user's instruction.
- **Confirmed:** Current `.ai/AGENTS.md` item 6 is the operation-owner reread rule.
- **Confirmed:** Current `BOOTSTRAP.md` Shared steps item 1 references an “AGENTS item 6 entry path” that is not described by the currently retrieved root `AGENTS.md` or `.ai/AGENTS.md`.
- **Confirmed:** The earlier item 6 explicitly routed new-chapter initialization to the then-canonical `.ai/workflows/handoff/BOOTSTRAP.md`; commit `b9d37bd916144dffceeb67c471075ae41d83ae97` replaced that with the operation-owner reread rule.
- **Open:** The smallest correction to the current bootstrap Shared steps item 1, now that its historical origin is established. Preserve the explicit bootstrap transport as the Conversational AI entry boundary and keep root `AGENTS.md` Agentic-only.
- **Open:** Wider audit findings and the proposed semantic-role model remain unfinalized.

## Recommended starting context

- `.ai/conversation-management/handoff/BOOTSTRAP.md`
- `.ai/handoffs/C/C0080-Architecture-&-Research.md`
- `.ai/AGENTS.md`
- root `AGENTS.md`
- `.ai/config.yaml`
- `.ai/skills/repository/SKILL.md`
- `.ai/skills/activation/SKILL.md`
- `.ai/conversation-management/handoff/SKILL.md`
- `.ai/archives/docs/architecture/ai-infrastructure-restructuring-todo.md`
