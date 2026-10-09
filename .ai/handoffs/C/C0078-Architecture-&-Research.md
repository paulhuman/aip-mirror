# Conversation Handoff

**Conversation:**
C0078 — Architecture & Research

**Specialization:**
C

**Chapter:**
0078

**Previous chapter:**
0077

## Starting objective

Continue the Architecture & Research track after auditing the root `AGENTS.md` and investigating the rules-versus-skills distinction. The user approved a bounded restructuring of the AI infrastructure and asked to move the actual infrastructure mutations into the next conversation because this chapter had become long.

Before migrating, create a detailed roadmap under `.ai/archives/docs/architecture/` that records the accepted target model, exact source-to-destination mapping, execution phases, verification criteria, risks, and non-goals. Then update this chapter's handoff and generate the canonical bootstrap transport for C0079.

## Current repository state

- Repository: `paulhuman/aip-mirror`
- Canonical branch: `main`
- Current chapter: C0078
- Next chapter: C0079
- Specialization: C
- Short name: Architecture & Research
- Latest verified main commit at handoff preparation: `1cb918e7b1aecfde95b5d42244796e4e9f212522`
- Roadmap created and committed at: `.ai/archives/docs/architecture/ai-infrastructure-rules-to-skills-roadmap.md`
- Roadmap blob SHA: `967fbc71e0e1e1a242312e6ebfce0fbae622ef22`
- Roadmap commit: `1cb918e7b1aecfde95b5d42244796e4e9f212522`
- The rules-to-skills infrastructure migration has **not** been applied. The old rules and current paths still exist at this point.
- This handoff update is part of the `>>migrate 0079` operation; it does not create the C0079 receiving handoff in advance.

## Decisions carried forward

1. Eliminate `.ai/rules/` entirely; do not retain it as a parallel source type or compatibility layer.
2. Put all handoff-related skills and procedures under `.ai/skills/conversational-only/`, including the handoff skill, reference-preservation skill, bootstrap workflow, and human bootstrap template.
3. Do not create `.ai/skills/conversational-only/SKILL.md`. Handoff skills remain nested so DSH does not discover them as ordinary first-level skills.
4. Keep shared skills such as activation, commits, knowledge-capture, normative-language, deep-understanding, explain-code, repository, and workflow at `.ai/skills/<skill-name>/SKILL.md`.
5. Merge each rule's unique semantics into one canonical skill owner. Avoid blind concatenation and avoid duplicate semantic owners.
6. Preserve critical repository and mutation-safety invariants directly in `.ai/AGENTS.md` as a concise always-on contract. Detailed repository taxonomy and write-safety procedure belong in the repository skill.
7. Update root `AGENTS.md` to replace its installed-DSH-specific host-notes section with the agreed portable skill-adapter note. Do not claim that all AI hosts support the same discovery behavior.
8. Update active routing and documentation references before deleting the old rule files. Keep `.ai/INDEX.md` as a router/capability map, not a procedure owner.
9. Actual per-chapter state remains under `.ai/handoffs/`; only reusable handoff instructions, skills, and templates move.
10. Other AI hosts are out of scope. The confirmed DSH discovery behavior has already been tested and must not be re-tested without a concrete reason.
11. Do not treat archived architecture documents as active semantic owners. The roadmap is historical planning context; current active files remain authoritative until changed and verified.

## Confirmed

- `.ai/config.yaml` identifies `paulhuman/aip-mirror` as the repository, `main` as the default branch, and C's short name as Architecture & Research.
- The current chapter is C0078, and `>>migrate 0079` is the correct sequential migration assertion.
- The active infrastructure currently has seven files under `.ai/rules/`: repository, workflow, commits, developer-knowledge, normative-language, handoff/lifecycle, and handoff/references.
- Current related owners include `.ai/skills/commits/SKILL.md`, `.ai/skills/knowledge-capture/SKILL.md`, `.ai/skills/normative-language/SKILL.md`, `.ai/skills/handoff/SKILL.md`, `.ai/skills/handoff/reference-preservation/SKILL.md`, `.ai/workflows/handoff/BOOTSTRAP.md`, and `.ai/templates/handoff-bootstrap.md`.
- Current active references also exist in root `AGENTS.md`, `.ai/AGENTS.md`, `.ai/README.md`, `.ai/INDEX.md`, `.ai/docs/architecture/README.md`, `.ai/handoffs/README.md`, and `docs/PROJECT-INSTRUCTIONS.md`.
- DSH discovers skills one level deep at `.agents/skills/<skill-name>/SKILL.md`; the local `.agents/skills` adapter points to `.ai/skills/` and is gitignored/recreated by `.ai/scripts/adapters/New-SkillAdapters.ps1`.
- The roadmap was created at `.ai/archives/docs/architecture/ai-infrastructure-rules-to-skills-roadmap.md` and is intended as a detailed, phased execution plan.
- The roadmap creation commit succeeded and the `main` branch was updated using the expected prior SHA. Its content was read back from GitHub and its blob SHA matched the created blob.

## Inferred / rationale

- Moving handoff procedures under a nested conversational-only boundary is the simplest design consistent with the tested DSH first-level discovery behavior and the user's requirement that ordinary agents not discover handoff instructions.
- Because the existing rules contain critical safety semantics, deletion must be the final structural phase after replacement owners and all active references have been verified.
- The migration is a multi-file semantic refactor; it should be implemented in coherent groups and validated against the actual tree rather than performed as a blind path rename.

## Assumed / unverified

- No implementation mutation to the rules/skills structure has been applied yet.
- No root `AGENTS.md` rewrite has been applied yet.
- No claim has been made that every stale path is already known; C0079 must run a complete active-tree reference sweep.
- The roadmap's phase sequence is approved planning context, but each phase must still be verified against the actual repository state when executed.

## Relevant files

### Plan and current owners

- `.ai/archives/docs/architecture/ai-infrastructure-rules-to-skills-roadmap.md` — detailed execution roadmap; read this first in C0079.
- `.ai/AGENTS.md` — always-on AI-infrastructure contract.
- `.ai/INDEX.md` — command routing and capability discovery.
- `.ai/README.md` — active infrastructure orientation.
- `.ai/config.yaml` — repository identity and specialization vocabulary.
- `AGENTS.md` — root entry point; replace the DSH-specific section with the agreed generic adapter note.
- `.ai/docs/architecture/README.md` — active-owner/supporting-layer architecture description.
- `docs/PROJECT-INSTRUCTIONS.md` — project-level agent instructions; must not route ordinary agents into conversational-only handoff procedures.

### Rule sources to consolidate

- `.ai/rules/repository.md`
- `.ai/rules/workflow.md`
- `.ai/rules/commits.md`
- `.ai/rules/developer-knowledge.md`
- `.ai/rules/normative-language.md`
- `.ai/rules/handoff/lifecycle.md`
- `.ai/rules/handoff/references.md`

### Existing skills and handoff material to merge/move

- `.ai/skills/commits/SKILL.md`
- `.ai/skills/knowledge-capture/SKILL.md`
- `.ai/skills/normative-language/SKILL.md`
- `.ai/skills/handoff/SKILL.md`
- `.ai/skills/handoff/reference-preservation/SKILL.md`
- `.ai/workflows/handoff/BOOTSTRAP.md`
- `.ai/templates/handoff-bootstrap.md`
- `.ai/handoffs/README.md` — update references, but do not move the actual handoff-state tree.

## Open

- Execute the roadmap's phases 0–6 in C0079, beginning with a fresh tree and source-content baseline.
- Consolidate shared owners before deleting old rules.
- Move the handoff material into nested `.ai/skills/conversational-only/handoff/` paths and update every active reference.
- Keep the always-on invariants in `.ai/AGENTS.md` concise and self-contained.
- Remove `.ai/rules/` only after every rule section has a verified replacement and the active-tree reference sweep is clean.
- Read back changed files, inspect the complete diff, verify scope, commit coherently, and verify the final branch state.
- If an unexpected concurrent commit or semantic conflict appears, stop and reconcile against the actual repository state rather than forcing the planned patch.

## Immediate next task for C0079

1. Read the roadmap in full:
   `.ai/archives/docs/architecture/ai-infrastructure-rules-to-skills-roadmap.md`
2. Read the new C0079 handoff after its own bootstrap creates it, along with the current active infrastructure entry points and canonical owner files relevant to mutation safety, activation, and commits.
3. Fetch the actual current `main` tree and record its head SHA; the roadmap commit is the known baseline, but do not assume no intervening changes occurred.
4. Start with Phase 0: inspect all source files and active references in complete, bounded batches. Do not start by deleting or moving the rules directory.
5. Execute Phase 1 and Phase 2 by creating and verifying replacement owners; then update routing and references; delete `.ai/rules/` only after the specified exit criteria pass.
6. Follow the roadmap's Phase 5 acceptance checklist and Phase 6 read-back/diff/scope/published-result verification.

## Do not redo

- Do not reopen the user's accepted architectural decisions without a concrete contradiction in current repository evidence.
- Do not repeat the DSH nested-skill discovery experiment; the discovery boundary has already been tested.
- Do not treat `.ai/archives/` as normal active context or promote this roadmap into an active semantic owner.
- Do not change Illustrator plugin implementation as part of this infrastructure-only task.
- Do not claim the rules-to-skills migration is complete merely because the roadmap or handoff commit succeeds.
