# AI-infrastructure rules-to-skills migration roadmap

**Status:** Approved plan; implementation not yet started  
**Prepared:** 2026-10-09  
**Scope:** One bounded migration of active AI-infrastructure semantics and conversation-only handoff procedures  
**Repository:** `paulhuman/aip-mirror`, default branch `main`

## 1. Purpose

This roadmap transfers the agreed AI-infrastructure restructuring into an executable, reviewable sequence for a new conversation chapter. The objective is to eliminate the separate `.ai/rules/` layer without losing its semantics, preserve one canonical owner for each behavior, and separate shared agent capabilities from conversation-management procedures that ordinary agents must not discover or activate.

This document is an archived work plan and rationale record. It is not an active semantic owner. The current repository files remain authoritative until each planned change has been applied and verified.

## 2. Accepted decisions and boundaries

1. **Remove `.ai/rules/` entirely.** Do not retain it as a parallel source type, compatibility layer, or long-term fallback.
2. **Move all handoff-specific capability and procedure material under `.ai/skills/conversational-only/`.** This includes the handoff skill, reference-preservation skill, bootstrap workflow, and human bootstrap template. Keep handoff skills nested; do not place a `SKILL.md` directly in `.ai/skills/conversational-only/`.
3. **Keep shared skills at the first level of `.ai/skills/`.** Examples include activation, commits, knowledge-capture, normative-language, deep-understanding, explain-code, repository, and workflow. Do not move shared capabilities under `conversational-only/`.
4. **Respect the confirmed DSH discovery boundary.** DSH discovers skills one level deep at `.agents/skills/<skill-name>/SKILL.md`. Nested handoff skills may be readable by an explicitly directed operation, but are not automatically discovered as ordinary skills. This behavior was already tested; this migration does not require repeating that experiment.
5. **Maintain always-on invariants.** The compact `.ai/AGENTS.md` contract must state critical repository safety and canonical-source principles directly. It must not require an agent to discover a skill before obeying core safety requirements.
6. **Preserve single ownership.** INDEX routes; README files orient; architecture notes explain; handoffs preserve conversation state. None of these becomes a second semantic owner.
7. **Keep the root `AGENTS.md` portable.** Replace the DSH-specific host-notes block with the accepted generic skill-adapter description, without claiming that every host supports the same discovery mechanism.
8. **Do not relocate actual handoff state.** `.ai/handoffs/` remains conversation-state storage. Only the reusable handoff instructions, procedures, and template move.
9. **Other AI hosts are out of scope.** Do not add speculative adapters or broaden the task into a general multi-host redesign.
10. **Do not begin the infrastructure mutation until the roadmap and handoff have been saved.** This roadmap records the design and sequencing; the new chapter performs the active changes.

## 3. Target ownership model

```text
ROOT AGENTS.md
    = portable repository entry and adapter note
        |
        v
.ai/AGENTS.md
    = compact always-on operating contract
        |
        v
.ai/INDEX.md
    = command routing and capability discovery only
        |
        v
first-level .ai/skills/<shared-skill>/SKILL.md
    = shared, agent-facing capabilities and canonical procedures

.ai/skills/conversational-only/
    = explicitly invoked conversation-management material
        ├── handoff/SKILL.md
        ├── handoff/reference-preservation/SKILL.md
        ├── handoff/BOOTSTRAP.md
        └── handoff/handoff-bootstrap.md

.ai/handoffs/
    = actual per-chapter conversation state; location unchanged

.ai/docs/
    = active durable explanation and architecture context

.ai/archives/
    = historical plans, old architecture notes, and other explicitly requested history
```

The `.agents/skills` adapter remains a local, gitignored link to canonical `.ai/skills/`. It is recreated after a fresh clone by:

```powershell
pwsh -File .ai/scripts/adapters/New-SkillAdapters.ps1
```

The adapter script and its safety checks are not part of this migration unless inspection reveals a concrete incompatibility.

## 4. Rule-to-owner migration map

| Current source | Target owner | Required treatment |
|---|---|---|
| `.ai/rules/repository.md` | New `.ai/skills/repository/SKILL.md` plus compact invariants in `.ai/AGENTS.md` | Preserve identity/path resolution, repository boundaries, durability, taxonomy, write safety, full-content API verification, and scope integrity. Keep the always-on subset concise and self-contained. |
| `.ai/rules/workflow.md` | New `.ai/skills/workflow/SKILL.md` | Preserve research-before-implementation, decision/documentation discipline, incremental changes, testing, and reliable repository inspection. |
| `.ai/rules/commits.md` | `.ai/skills/commits/SKILL.md` | Merge authorization, coherent commits, pre-commit verification, repository integrity, and handoff-commit convention without duplicating commit-message construction. |
| `.ai/rules/developer-knowledge.md` | `.ai/skills/knowledge-capture/SKILL.md` | Merge the complete knowledge format contract and capture procedure. Remove dependency on a separate rule owner. |
| `.ai/rules/normative-language.md` | `.ai/skills/normative-language/SKILL.md` | Make the skill the sole owner of BCP 14 keyword semantics, local procedural vocabulary, classification, and normalization procedure. Remove the rule-owner indirection. |
| `.ai/rules/handoff/lifecycle.md` | `.ai/skills/conversational-only/handoff/SKILL.md` | Preserve chapter identity, sequential migration, recovery, handoff continuity, and state requirements in the conversational-only owner. |
| `.ai/rules/handoff/references.md` | `.ai/skills/conversational-only/handoff/reference-preservation/SKILL.md` | Preserve material-reference criteria, reference roles, authority boundary, and completeness checks. |
| `.ai/skills/handoff/SKILL.md` | `.ai/skills/conversational-only/handoff/SKILL.md` | Move the skill and merge lifecycle semantics; retain the canonical `name: handoff` identity only if it remains consistent with nested/non-discovered use. |
| `.ai/skills/handoff/reference-preservation/SKILL.md` | `.ai/skills/conversational-only/handoff/reference-preservation/SKILL.md` | Move the skill and merge reference-preservation semantics. |
| `.ai/workflows/handoff/BOOTSTRAP.md` | `.ai/skills/conversational-only/handoff/BOOTSTRAP.md` | Move the complete bootstrap workflow; update every active reference to its new path. |
| `.ai/templates/handoff-bootstrap.md` | `.ai/skills/conversational-only/handoff/handoff-bootstrap.md` | Move the human copy/paste template with its human-only versus AI-generated transport distinction intact. |

Do not blindly concatenate rule and skill text. Reconcile repeated statements into one semantic owner, preserving all unique requirements and examples that are still needed.

## 5. Files requiring reference and boundary updates

Inspect current content before editing. Update only the relevant references; preserve unrelated material.

### Core routing and operating contract

- Root `AGENTS.md`: replace the DSH-specific host-notes section with the accepted generic adapter text.
- `.ai/AGENTS.md`: remove the dependency on `.ai/rules/repository.md`; state the always-on invariants directly and point to the repository skill for detailed semantics. Remove the instruction that agents initialize new chat chapters through handoff bootstrap; handoff is conversational-only.
- `.ai/INDEX.md`: route shared capabilities to their first-level skills; keep handoff/migrate/generate-bootstrap entries as explicit conversational-only operations pointing to the nested paths. Do not make handoff an ordinary discovered agent capability. Remove every `.ai/rules/` owner reference.
- `.ai/README.md`: remove `.ai/rules/` from active areas and update the new handoff-material location and chapter-initialization guidance.
- `.ai/config.yaml`: change only if the actual active configuration contains a rule-specific reference or vocabulary item that needs migration. Do not invent a new registry.

### Active documentation and project instructions

- `.ai/docs/architecture/README.md`: update the active-owner taxonomy to remove `.ai/rules/`, explain that shared skills own their operational semantics, and retain the boundary between active owners and supporting docs/archives.
- `docs/PROJECT-INSTRUCTIONS.md`: remove or clarify any agent-facing handoff/bootstrap instructions so ordinary project agents do not activate conversational-only procedures.
- `.ai/handoffs/README.md`: update links to the moved handoff skill and lifecycle/reference semantics, while keeping the directory's role as actual conversation-state storage.
- `.ai/archives/README.md`: update only if needed to explain that this roadmap is historical; archived documents must remain outside routine active context.

### Skill and workflow references

Search all active files for old paths and concepts, including:
- `.ai/rules/`
- `.ai/workflows/handoff/BOOTSTRAP.md`
- `.ai/templates/handoff-bootstrap.md`
- `.ai/skills/handoff/SKILL.md`
- `.ai/skills/handoff/reference-preservation/SKILL.md`
- wording that directs ordinary agents to initialize a conversation chapter.

Classify matches before changing them. Current operational references must be migrated. Historical/archive evidence may legitimately mention old paths when describing the former architecture; do not blindly rewrite historical material.

## 6. Execution phases

### Phase 0 — establish baseline

1. Read this roadmap and the current `.ai/AGENTS.md`, `.ai/INDEX.md`, `.ai/README.md`, `.ai/config.yaml`, root `AGENTS.md`, and architecture README.
2. Fetch the authoritative repository tree and record the actual active file set.
3. Read each current rule and its corresponding skill/workflow before changing it.
4. Search for all direct and indirect references to `.ai/rules/` and the handoff paths.
5. Record the starting commit SHA and exact baseline paths.
6. Confirm that no previous partial mutation has occurred. If the tree differs from the known baseline, reconcile the difference rather than assuming the prior state.

**Exit criterion:** complete, path-grounded source/dependency map; no writes.

### Phase 1 — consolidate shared owners before deleting sources

1. Create `.ai/skills/repository/SKILL.md` from the current repository rule. Include complete repository semantics and safe mutation procedure.
2. Add only the essential always-on repository invariants to `.ai/AGENTS.md`: current-source-first, no reconstruction from memory, read-back verification, diff/scope verification, and no claim of success without evidence.
3. Create `.ai/skills/workflow/SKILL.md` from the current workflow rule.
4. Merge commit policy into `.ai/skills/commits/SKILL.md`.
5. Merge developer-knowledge semantics and procedure into `.ai/skills/knowledge-capture/SKILL.md`.
6. Merge normative-language semantics and procedure into `.ai/skills/normative-language/SKILL.md`.
7. At this stage, keep the old rule files until their replacement content has been read back and semantically checked.

**Exit criterion:** each shared rule has a complete replacement owner; no semantic gap; no unnecessary duplicate owner introduced.

### Phase 2 — consolidate conversational-only handoff material

1. Create the nested destination directories under `.ai/skills/conversational-only/`.
2. Move the handoff skill, reference-preservation skill, bootstrap workflow, and human template to the target paths.
3. Merge lifecycle semantics into the handoff skill and reference-preservation semantics into the reference-preservation skill.
4. Preserve the distinction between:
   - a handoff skill used only by an explicit conversational command;
   - a bootstrap procedure for the receiving conversation;
   - the human bootstrap template;
   - the actual per-chapter files in `.ai/handoffs/`.
5. Do not add a `.ai/skills/conversational-only/SKILL.md`.
6. Do not move existing handoff records into the skills directory.

**Exit criterion:** all handoff instructions are nested under the conversational-only boundary; active chapter-state files remain where they are.

### Phase 3 — reroute active instructions and documentation

1. Update root `AGENTS.md` to the generic adapter note.
2. Update `.ai/AGENTS.md` so always-on invariants are direct and handoff is not an agent bootstrap requirement.
3. Update `.ai/INDEX.md` routing and capability map.
4. Update `.ai/README.md`, `.ai/docs/architecture/README.md`, and `.ai/handoffs/README.md`.
5. Update `docs/PROJECT-INSTRUCTIONS.md` to keep conversational-only procedures out of ordinary agent instructions.
6. Search and update every remaining active reference to old rule and handoff paths.
7. Review research/architecture documents individually; preserve historical descriptions where appropriate.

**Exit criterion:** all active references resolve to the new paths; the routing layer remains a router rather than a procedure owner.

### Phase 4 — delete the old rules layer

Only after Phases 1–3 have passed their local checks:

1. Verify that every file in `.ai/rules/` has an explicit replacement owner.
2. Verify that no active file still requires or routes to `.ai/rules/`.
3. Delete the old rule files and the now-empty `.ai/rules/` directory through a tree update.
4. Do not leave stub rules, forwarding files, or a compatibility copy.
5. Do not delete historical records merely because they mention the former path.

**Exit criterion:** `.ai/rules/` is absent from the repository tree and no active source depends on it.

### Phase 5 — repository-wide verification

Run checks against the resulting repository tree and retrieved file contents:

- [ ] All intended target skill/workflow/template files exist.
- [ ] All seven former rule files have been accounted for.
- [ ] `.ai/rules/` is absent.
- [ ] No active file contains a stale operational reference to `.ai/rules/`.
- [ ] All old handoff paths in active content point to their new nested destinations.
- [ ] No `SKILL.md` exists directly under `.ai/skills/conversational-only/`.
- [ ] Shared capabilities remain first-level skills and can be discovered by the confirmed DSH mechanism.
- [ ] Handoff paths remain nested and are not presented as ordinary discovered skills.
- [ ] Root `AGENTS.md` contains no DSH-version/profile-specific facts and does not claim unverified cross-host behavior.
- [ ] `.ai/AGENTS.md` contains the compact always-on invariants without relying on a skill activation to apply them.
- [ ] INDEX routes to owners without copying their procedures.
- [ ] `.ai/docs/architecture/README.md` accurately describes the new owner taxonomy.
- [ ] `docs/PROJECT-INSTRUCTIONS.md` does not activate conversational-only handoff procedures for ordinary agent work.
- [ ] The adapter script and `.gitignore` remain compatible and unchanged unless evidence required a specific change.
- [ ] Normative language is consistent with the consolidated skill; no blind keyword replacement was used.
- [ ] No unrelated files or project implementation files changed.

A text search is a locator, not a semantic verdict. Review each match to distinguish current operational dependency from historical discussion. Where practical, use a tree-based sweep and direct file retrieval instead of relying on incomplete code-search results.

### Phase 6 — inspect diff, commit, and verify the published result

1. Read back every newly created or modified file from GitHub.
2. Compare the resulting content with the intended content, not merely the tool's success status.
3. Inspect the complete diff against the recorded baseline.
4. Verify the changed-file list and confirm the scope is limited to this migration.
5. Run any available relevant validation; record unavailable tests as unavailable, not as passing.
6. Use a coherent commit message describing the infrastructure refactor.
7. Update the branch using the expected prior SHA/lease so an intervening change is not overwritten.
8. Fetch the resulting branch head, commit, tree, and critical files again.
9. Confirm the resulting commit contains the verified content and no unintended changes.

**Exit criterion:** published repository state matches the reviewed diff and all acceptance checks are satisfied.

## 7. Mutation safety protocol

For every existing file, use the repository's current content as the source of truth:

```text
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
```

A successful API write is not proof of correct content. A valid Git commit is not proof of correct content. If read-back differs unexpectedly, stop and reconcile before making further changes.

Prefer staged logical groups. Do not bundle unrelated changes simply because a single tree/commit operation is convenient. If tool constraints prevent reliable read-back or diff inspection, stop and report the limitation rather than claiming completion.

## 8. Risks and mitigations

| Risk | Mitigation |
|---|---|
| Semantic requirements lost during consolidation | Map every rule section to a target owner; compare requirements before deleting old sources. |
| Two competing owners remain | Each target skill owns its semantics directly; INDEX and README only route/orient. |
| Handoff becomes accidentally discoverable as a general skill | Keep all handoff material nested under `conversational-only/`; no parent `SKILL.md`. |
| Agents lose critical write-safety constraints | Keep a compact, self-contained safety contract in `.ai/AGENTS.md`. |
| Stale paths survive in active instructions | Search the complete active tree after migration and inspect each match. |
| Historical documents are damaged by blanket replacement | Classify historical references; retain descriptions that accurately document the old state. |
| Root entry remains host-specific | Replace installed-DSH details with the accepted portable adapter description. |
| API mutation corrupts existing content | Read current version, write complete intended content, read back, inspect diff and scope, then verify published result. |
| A concurrent commit is overwritten | Use expected-SHA ref update; on mismatch, fetch the new head and reconcile rather than force blindly. |
| The task expands into unsupported host research | Keep other hosts out of scope; use the already-confirmed DSH discovery constraint as a design input. |

## 9. Non-goals

This roadmap does not authorize or require:

- redesigning the overall AI-infrastructure architecture beyond the rules-to-skills and conversational-only migration;
- adding support for other AI hosts;
- repeating the already completed DSH nested-discovery experiment;
- copying the entire SDK or changing Illustrator plugin implementation;
- rewriting all historical architecture documents;
- moving actual handoff records out of `.ai/handoffs/`;
- inventing a new command registry or dependency graph;
- adding speculative adapters, skills, directories, or placeholder files;
- committing unrelated work.

## 10. New chapter's immediate starting sequence

The receiving chapter should begin by:

1. Read this roadmap in full as the explicit historical plan requested by the user.
2. Read the current handoff for C0079 and re-read the active canonical owners relevant to repository mutation, activation, commits, and infrastructure operations.
3. Fetch the current repository tree and confirm the actual baseline; do not assume that no intervening commit has occurred.
4. Convert the phases above into a concise execution checklist and track phase status with evidence.
5. Begin Phase 1 only after confirming the current source files and their complete contents.
6. Keep the work bounded to the approved target model. Ask the user only if a real semantic conflict or authorization boundary arises; do not reopen decisions already explicitly accepted.
7. Do not mark a phase complete until its exit criterion has been verified from repository state.

## 11. Completion record

This document records the approved target and planned sequence as of 2026-10-09. At creation time, the infrastructure migration itself has **not** been applied. The rules layer still exists, and the current active files still contain the old references. Update this section only if a later operation explicitly records implementation status; do not silently turn this plan into a completion claim.
