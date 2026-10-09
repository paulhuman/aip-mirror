# AI-infrastructure rules-to-skills migration — Phase 0 baseline

**Date:** 2026-10-09  
**Chapter:** C0079 — Architecture & Research  
**Repository:** `paulhuman/aip-mirror`  
**Branch:** `main`  
**Purpose:** Evidence checkpoint before Phase 1 replacement-owner creation.

## 1. Baseline identity

- Baseline commit: `3f83e6a8e14b494c82ac169b39b1e0a582aacf43`
- Baseline commit message: `ai-docs(handoff): create C0079`
- Parent commit: `bd14360fcc2a690e0435ac0b0d183fe559add577`
- Baseline tree SHA: `e1c7fd628dafe29f4ac833c88d5780fe1f718ab2`
- Roadmap: `.ai/archives/docs/architecture/ai-infrastructure-rules-to-skills-roadmap.md`
- Roadmap blob SHA observed: `967fbc71e0e1e1a242312e6ebfce0fbae622ef22`
- Recursive Git tree response: 254 entries, 206 blobs, `truncated=false`.
- Active `.ai/` inventory definition for this record: blob paths under `.ai/`, excluding `.ai/archives/`. Count: 99.
- Current rule-layer files: 7.
- Existing handoff-material source files planned for relocation: 4.
- This evidence artifact is a post-inventory checkpoint created after the Phase 0 read-only inspection. No migration source was moved, rewritten, or deleted during the inventory.

## 2. Phase 0 acceptance

The roadmap's Phase 0 exit criterion is a complete, path-grounded source/dependency map with no writes during the inventory. The inspection is complete for the baseline recorded above.

- [x] Read the complete migration roadmap and its phase criteria, risks, and non-goals.
- [x] Re-fetch `main` HEAD and the recursive Git tree; use the current tree rather than the older bootstrap observation.
- [x] Inspect the complete contents of all seven current rule files and their corresponding existing skills/workflows.
- [x] Inspect routing/orientation files and identified active architecture/instruction files with old-owner references.
- [x] Classify operational references separately from historical test evidence and handoff snapshots.
- [x] Confirm no partial rules-to-skills migration is present in the baseline: all seven rule files and all four old handoff-material source files remain in the tree.
- [x] Finish inventory before any replacement-owner or routing mutation.

This checkpoint does not claim Phases 1–6 are complete.

## 3. Rule-to-owner map

| Current source | Planned canonical target | Required preservation/check |
|---|---|---|
| `.ai/rules/repository.md` | New `.ai/skills/repository/SKILL.md` plus concise always-on invariants in `.ai/AGENTS.md` | Identity/path resolution, repository boundaries, durability/taxonomy, write safety, complete-content API verification, diff/scope integrity. |
| `.ai/rules/workflow.md` | New `.ai/skills/workflow/SKILL.md` | Research before implementation, decision/documentation discipline, incremental changes, testing, reliable inspection. |
| `.ai/rules/commits.md` | Existing `.ai/skills/commits/SKILL.md` | Merge authorization, coherent commits, pre-commit verification, repository integrity, handoff commit convention; avoid duplicating commit-message construction. |
| `.ai/rules/developer-knowledge.md` | Existing `.ai/skills/knowledge-capture/SKILL.md` | Merge complete knowledge-format contract and capture procedure. |
| `.ai/rules/normative-language.md` | Existing `.ai/skills/normative-language/SKILL.md` | Sole ownership of BCP 14 keyword semantics, local procedural vocabulary, classification, normalization. |
| `.ai/rules/handoff/lifecycle.md` | `.ai/skills/conversational-only/handoff/SKILL.md` | Chapter identity, sequential migration, recovery, continuity, state requirements. |
| `.ai/rules/handoff/references.md` | `.ai/skills/conversational-only/handoff/reference-preservation/SKILL.md` | Material-reference criteria, roles, authority boundary, completeness checks. |

Do not concatenate sources blindly. Read and compare current complete contents, merge unique semantics, then read back and semantically verify each replacement before removing any source.

## 4. Handoff-material relocation map

| Current source | Planned target |
|---|---|
| `.ai/skills/handoff/SKILL.md` | `.ai/skills/conversational-only/handoff/SKILL.md` |
| `.ai/skills/handoff/reference-preservation/SKILL.md` | `.ai/skills/conversational-only/handoff/reference-preservation/SKILL.md` |
| `.ai/workflows/handoff/BOOTSTRAP.md` | `.ai/skills/conversational-only/handoff/BOOTSTRAP.md` |
| `.ai/templates/handoff-bootstrap.md` | `.ai/skills/conversational-only/handoff/handoff-bootstrap.md` |

No `.ai/skills/conversational-only/SKILL.md` is to be created. Keep shared skills first-level under `.ai/skills/`. Actual chapter-state records remain under `.ai/handoffs/`.

## 5. Operational dependency map

These files are known active routing, operating, or procedural references that require targeted review/rerouting during Phases 1–3:

- `AGENTS.md` — replace DSH-specific host notes with the accepted portable adapter description; do not overclaim universal host behavior.
- `.ai/AGENTS.md` — remove dependency on `.ai/rules/repository.md`; state critical safety invariants directly; remove ordinary-agent chapter-bootstrap requirements.
- `.ai/INDEX.md` — route shared capabilities to first-level skills; handoff/migrate/bootstrap remain explicit conversational-only operations; remove active rule-owner references.
- `.ai/README.md` — update active-area taxonomy and handoff-material location.
- `.ai/docs/architecture/README.md` — update active semantic-owner taxonomy.
- `.ai/handoffs/README.md` — update links to relocated handoff instructions while retaining `.ai/handoffs/` as state storage.
- `docs/PROJECT-INSTRUCTIONS.md` — ensure ordinary project-agent instructions do not activate conversational-only procedures.
- `.ai/skills/ai-infrastructure/SKILL.md` — review current owner/path references.
- `.ai/skills/knowledge-capture/SKILL.md` — remove/replace any rule-owner dependency when merging.
- `.ai/skills/normative-language/SKILL.md` — remove/replace rule-owner indirection when merging.
- `.ai/skills/handoff/SKILL.md` and `.ai/workflows/handoff/BOOTSTRAP.md` — migrate to the nested conversational-only destinations.
- `.ai/templates/handoff-bootstrap.md` — move to the nested destination and preserve human-only versus AI-generated transport semantics.

Configuration and adapter code are not presumed to need edits: change `.ai/config.yaml`, `.ai/scripts/adapters/New-SkillAdapters.ps1`, or `docs/architecture/project-architecture.md` only if direct inspection reveals a concrete dependency requiring it.

## 6. Architecture/supporting references requiring individual review

These active architecture/FAQ documents contain owner/path claims or examples and must be assessed individually; matches are not automatically stale operational dependencies:

- `.ai/docs/architecture/agentic-ai-compatibility-capability-audit.md` — identifies `.ai/rules/` as canonical owner and cites rule files/bootstrap path.
- `.ai/docs/architecture/agentic-ai-owner-seam-audit.md` — owner table points to rule files and describes semantics as distributed among rules, skills, and workflows.
- `.ai/docs/architecture/ai-infrastructure-context-mode.md` — identifies the normative-language rule as canonical and references the old bootstrap path.
- `.ai/docs/faq/manual-activation.md` — example TRACE mentions `.ai/rules/handoff/lifecycle.md`.
- Other active architecture documents should be reviewed individually when the final repository-wide search is performed; do not infer that no reference exists merely because code search returned no reliable results.

## 7. Historical evidence: preserve unless there is a specific reason

Previous handoff snapshots and runtime/test results may legitimately document the former paths and former owner model. Do not blanket-replace historical references.

Inspected historical result/scenario paths include:

- `.ai/tests/scenarios/cold-start-command-trace.md`
- `.ai/tests/scenarios/migration-recovery.md`
- `.ai/tests/results/cold-start-command-trace/20261002-0900-cold-start-command-trace.md`
- `.ai/tests/results/cold-start-command-trace/20261002-1352-c0054-to-c0055-runtime.md`
- `.ai/tests/results/cold-start-command-trace/20261005-2054-c0067-five-command-runtime.md`
- `.ai/tests/results/migration-recovery/20261003-2245-migration-recovery.md`
- `.ai/tests/results/migration-recovery/20261003-2317-c0061-case1-runtime.md`
- `.ai/tests/results/migration-recovery/20261003-2337-c0061-case1-runtime.md`
- `.ai/tests/results/migration-recovery/20261003-c0061-case1-runtime-boundary.md`
- `.ai/tests/results/migration-recovery/20261004-1815-c0062-case2-runtime.md`
- `.ai/tests/results/migration-recovery/20261005-0022-c0063-case3-runtime.md`
- `.ai/tests/results/migration-recovery/20261005-0036-c0064-case4-runtime.md`
- `.ai/tests/results/migration-recovery/20261005-1412-c0064-case5-runtime.md`
- `.ai/tests/results/trace-runtime-presentation/20261002-1336-trace-runtime-presentation.md`
- Existing files under `.ai/handoffs/`, including the earlier C-series chapters.

Historical references are evidence of what the repository previously said, not automatically live routing instructions.

## 8. Complete active `.ai/` blob inventory at baseline

The list below is path inventory only; it does not claim every file has old-path dependencies. Archives are excluded by definition.

```text
.ai/AGENTS.md
.ai/INDEX.md
.ai/README.md
.ai/config.yaml
.ai/docs/architecture/README.md
.ai/docs/architecture/agentic-ai-compatibility-architecture.md
.ai/docs/architecture/agentic-ai-compatibility-boundaries.md
.ai/docs/architecture/agentic-ai-compatibility-capability-audit.md
.ai/docs/architecture/agentic-ai-dsh-observations.md
.ai/docs/architecture/agentic-ai-environment-survey.md
.ai/docs/architecture/agentic-ai-owner-seam-audit.md
.ai/docs/architecture/agentic-ai-skill-discovery-verification.md
.ai/docs/architecture/ai-infrastructure-context-mode.md
.ai/docs/architecture/ai-infrastructure-vnext-proposal.md
.ai/docs/faq/adapting-to-a-new-project.md
.ai/docs/faq/manual-activation.md
.ai/handoffs/A/A0001-JSX-Prototype.md
.ai/handoffs/A/A0002-JSX-Prototype.md
.ai/handoffs/B/B0001-Native-AIP-Plugin.md
.ai/handoffs/B/B0002-Native-AIP-Plugin.md
.ai/handoffs/C/C0048-Architecture-Research.md
.ai/handoffs/C/C0049-Architecture-Research.md
.ai/handoffs/C/C0050-Architecture-Research.md
.ai/handoffs/C/C0051-Architecture-Research.md
.ai/handoffs/C/C0052-Architecture-Research.md
.ai/handoffs/C/C0053-Architecture-Research.md
.ai/handoffs/C/C0054-Architecture-Research.md
.ai/handoffs/C/C0055-Architecture-Research.md
.ai/handoffs/C/C0056-Architecture-Research.md
.ai/handoffs/C/C0057-Architecture-Research.md
.ai/handoffs/C/C0058-Architecture-Research.md
.ai/handoffs/C/C0059-Architecture-Research.md
.ai/handoffs/C/C0060-Architecture-Research.md
.ai/handoffs/C/C0061-Architecture-Research.md
.ai/handoffs/C/C0062-Architecture-Research.md
.ai/handoffs/C/C0063-Architecture-Research.md
.ai/handoffs/C/C0064-Architecture-Research.md
.ai/handoffs/C/C0065-Architecture-&-Research.md
.ai/handoffs/C/C0066-Architecture-&-Research.md
.ai/handoffs/C/C0067-Architecture-&-Research.md
.ai/handoffs/C/C0068-Architecture-&-Research.md
.ai/handoffs/C/C0069-Architecture-&-Research.md
.ai/handoffs/C/C0070-Architecture-&-Research.md
.ai/handoffs/C/C0071-Architecture-&-Research.md
.ai/handoffs/C/C0072-Architecture-&-Research.md
.ai/handoffs/C/C0073-Architecture-&-Research.md
.ai/handoffs/C/C0074-Architecture-&-Research.md
.ai/handoffs/C/C0075-Architecture-&-Research.md
.ai/handoffs/C/C0076-Architecture-&-Research.md
.ai/handoffs/C/C0077-Architecture-&-Research.md
.ai/handoffs/C/C0078-Architecture-&-Research.md
.ai/handoffs/C/C0079-Architecture-&-Research.md
.ai/handoffs/D/D0001-Project-Workshop.md
.ai/handoffs/E/E0001-Independent-Review-Qwen.md
.ai/handoffs/E/E0002-Independent-Review-Qwen.md
.ai/handoffs/E/E0003-Independent-Review-Qwen.md
.ai/handoffs/E/E0004-Independent-Review-Qwen.md
.ai/handoffs/E/E0005-Independent-Review-Qwen.md
.ai/handoffs/E/E0006-Independent-Review-Qwen.md
.ai/handoffs/E/E0007-Independent-Review-Qwen.md
.ai/handoffs/F/F0001-Independent-Review-Grok.md
.ai/handoffs/F/F0002-Independent-Review-Grok.md
.ai/handoffs/README.md
.ai/rules/commits.md
.ai/rules/developer-knowledge.md
.ai/rules/handoff/lifecycle.md
.ai/rules/handoff/references.md
.ai/rules/normative-language.md
.ai/rules/repository.md
.ai/rules/workflow.md
.ai/scripts/adapters/New-SkillAdapters.ps1
.ai/skills/activation/SKILL.md
.ai/skills/ai-infrastructure/SKILL.md
.ai/skills/commits/SKILL.md
.ai/skills/deep-understanding/SKILL.md
.ai/skills/explain-code/SKILL.md
.ai/skills/handoff/SKILL.md
.ai/skills/handoff/reference-preservation/SKILL.md
.ai/skills/knowledge-capture/SKILL.md
.ai/skills/normative-language/SKILL.md
.ai/templates/handoff-bootstrap.md
.ai/tests/results/cold-start-command-trace/20261002-0900-cold-start-command-trace.md
.ai/tests/results/cold-start-command-trace/20261002-1352-c0054-to-c0055-runtime.md
.ai/tests/results/cold-start-command-trace/20261005-2054-c0067-five-command-runtime.md
.ai/tests/results/migration-recovery/20261003-2245-migration-recovery.md
.ai/tests/results/migration-recovery/20261003-2317-c0061-case1-runtime.md
.ai/tests/results/migration-recovery/20261003-2337-c0061-case1-runtime.md
.ai/tests/results/migration-recovery/20261003-c0061-case1-runtime-boundary.md
.ai/tests/results/migration-recovery/20261004-1815-c0062-case2-runtime.md
.ai/tests/results/migration-recovery/20261005-0022-c0063-case3-runtime.md
.ai/tests/results/migration-recovery/20261005-0036-c0064-case4-runtime.md
.ai/tests/results/migration-recovery/20261005-1412-c0064-case5-runtime.md
.ai/tests/results/trace-runtime-presentation/20261002-1336-trace-runtime-presentation.md
.ai/tests/scenarios/cold-start-command-trace.md
.ai/tests/scenarios/migration-recovery.md
.ai/workflows/handoff/BOOTSTRAP.md
.ai/workflows/independent-review/independent-review-grok-onboarding.md
.ai/workflows/independent-review/independent-review-qwen-onboarding.md
```

## 9. Phase 1 gate and mutation constraints

Phase 1 may begin only against the recorded baseline or a newly re-fetched/reconciled HEAD.

Recommended logical groups:
1. New repository skill + minimal always-on `.ai/AGENTS.md` invariants.
2. New workflow skill.
3. Merge commits and knowledge-capture owners.
4. Merge normative-language owner.
5. Then Phase 2's nested conversational-only handoff material.

For every existing file: READ CURRENT FILE → MAKE MINIMAL CHANGE → WRITE COMPLETE INTENDED CONTENT → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT.

Do not delete or move anything in `.ai/rules/` until replacement owners have been read back and semantically verified and active references have been rerouted. A successful API write or a valid commit is not proof of correct content.
