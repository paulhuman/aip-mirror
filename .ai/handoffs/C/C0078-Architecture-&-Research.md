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

Continue the Architecture & Research track by performing a read-only architectural audit of the root `AGENTS.md`, then investigate whether the repository's distinction between `.ai/rules/` and `.ai/skills/` remains appropriate given the verified DSH loading behavior.

The audit must establish what belongs in the project-root entry point, whether it should remain project-agnostic and durable, and whether it may depend on temporary or version-sensitive DSH evidence. Do not edit files merely because a concern has been raised.

## Known starting implementation state

- Repository: `paulhuman/aip-mirror`
- Canonical branch: `main`
- Current chapter: C0078
- Previous chapter: C0077
- Specialization: C
- Short name: Architecture & Research
- Derived chapter identifier: C0078
- Canonical AI infrastructure lives under `.ai/`; project knowledge lives under `docs/`.
- Root `AGENTS.md` exists and currently describes itself as a DSH-loaded router pointing to canonical sources in `.ai/`.
- C0077 verified that DSH, when started at the repository root, discovers the eight top-level project skills through the local `.agents/skills` junction to `.ai/skills/`; the junction is gitignored and recreated by `.ai/scripts/adapters/New-SkillAdapters.ps1`.
- The DSH-specific verification is documented in `.ai/docs/architecture/agentic-ai-skill-discovery-verification.md`. These findings are version-sensitive evidence, not universal or timeless host behavior.
- The current root `AGENTS.md` directly instructs agents to read that DSH verification document before touching skill discovery and contains operational details about DSH version, profile, paths, and setup.
- The root entry point must be audited against `.ai/AGENTS.md`, `.ai/config.yaml`, and `.ai/rules/repository.md`, with the intended boundary `ROOT / AGENTS.md → .ai/ canonical source`.
- The architecture question about rules versus skills is open. Do not presume that rules should be deleted or copied into skills simply because DSH's loading model differs from a native rule mechanism.

## Decisions carried forward

- Preserve a single canonical semantic source; do not create duplicated rule/skill owners.
- Treat `.ai/INDEX.md` as an operational router/capability map, not a replacement for canonical owners.
- Supporting documents under `.ai/docs/` and handoffs provide context/evidence but are not active semantic owners.
- Distinguish semantic ownership from host-specific discovery and loading.
- Do not make structural changes to `.ai/rules/` or `.ai/skills/` until research and a proposed semantic model justify them.
- No repository changes are authorized merely by identifying a concern; inspect and establish the intended design first.

## Relevant files and references

### Root entry and canonical infrastructure

- `AGENTS.md` — current root-level agent entry/router; primary audit target.
- `.ai/AGENTS.md` — internal AI-infrastructure operating contract.
- `.ai/config.yaml` — canonical repository identity, default branch, references, and specialization vocabulary.
- `.ai/rules/repository.md` — repository boundaries, active-owner versus supporting-layer distinction, and write-safety requirements.
- `.ai/INDEX.md` — operational routing and capability map.
- `.ai/rules/workflow.md` — general workflow principles.
- `.ai/rules/handoff/lifecycle.md` — handoff continuity and naming semantics.
- `.ai/skills/activation/SKILL.md` — canonical activation and visible TRACE contract.
- `.ai/skills/handoff/SKILL.md` — handoff structure and operation.
- `.ai/workflows/handoff/BOOTSTRAP.md` — canonical chapter initialization workflow.

### DSH-specific evidence

- `.ai/docs/architecture/agentic-ai-skill-discovery-verification.md` — detailed, version-sensitive DSH discovery experiments and observations.
- `.ai/scripts/adapters/New-SkillAdapters.ps1` — creates/verifies the local adapter.
- `.gitignore` — ignores the local `.agents/` adapter.
- `.ai/docs/architecture/agentic-ai-compatibility-architecture.md` — broader host-compatibility architecture context.
- `.ai/docs/architecture/agentic-ai-dsh-observations.md` — DSH observations, subject to revalidation when relied upon operationally.

### External research references

- `paulhuman/codex` — declared in `.ai/config.yaml` as a research reference for coding-agent architecture, agent behavior, instruction handling, and repository-oriented workflows.
- `paulhuman/skills` — declared as a reference for reusable skill structure, discovery, and capability conventions.
- `paulhuman/agent.md` — declared as a reference for agent instruction-file conventions, instruction hierarchy, and durable repository guidance.

These external repositories are research references, not authority over this project's canonical owners.

## Confirmed

- Bootstrap context identifies the receiving chapter as C0078, specialization C, previous chapter 0077, short name Architecture & Research.
- `.ai/config.yaml` identifies `paulhuman/aip-mirror` as the repository, `main` as the default branch, and C's short name as Architecture & Research.
- `.ai/AGENTS.md` item 6 directs new-chapter initialization to `.ai/workflows/handoff/BOOTSTRAP.md`.
- The canonical predecessor handoff is `.ai/handoffs/C/C0077-Architecture-&-Research.md`; it was read successfully.
- C0077 records the DSH-first adapter path as behaviorally verified and identifies the root `AGENTS.md` audit as C0078's immediate task.
- The current root `AGENTS.md` contains a section explicitly titled “Agentic environment (DSH)” and points directly to the version-sensitive verification document.
- The current repository rules explicitly distinguish active semantic owners from supporting/contextual layers and prohibit active owners from depending on supporting layers as sources of active semantics.
- `.ai/skills/activation/SKILL.md` requires visible operation-level TRACE for operations routed through ACTIVATE, using the actual files read.
- The current receiving handoff did not exist at the canonical path when checked during bootstrap.

## Inferred

- The root `AGENTS.md` may be carrying too much host-specific operational content for a durable, project-agnostic entry point. The audit must determine this from the intended root-entry contract and actual host behavior, not assume the conclusion.
- A more durable design may keep root instructions minimal and route host-specific setup details to an appropriate adapter or supporting document, but the correct location and loading guarantees remain to be established.
- The rules/skills distinction may still be valuable as semantic ownership even if a particular host loads only skills by default. Whether any critical semantics require a host-loading adapter or dedicated skill is an evidence-driven design question.

## Assumed / unverified

- Whether DSH automatically loads root `AGENTS.md` in every relevant launch context has not been independently revalidated in this chapter.
- Whether another current Agentic AI host is in scope has not been established; do not design speculative adapters without a concrete target.
- No proposed rewrite of root `AGENTS.md` has been accepted.
- No decision has been made to move, duplicate, wrap, or eliminate any existing rule semantics.

## Open

- Audit root `AGENTS.md` against `.ai/AGENTS.md`, `.ai/config.yaml`, `.ai/rules/repository.md`, and the ROOT → `.ai/` canonical-source boundary.
- Classify root `AGENTS.md` content into durable router guidance, duplicated canonical semantics, host-specific mechanics, and temporary/version-sensitive evidence references.
- Determine whether the DSH-specific section belongs in the root entry point, and whether the direct dependency on the verification artifact violates the intended ownership boundary.
- Decide whether root `AGENTS.md` needs changes. Keep this audit read-only until the user approves or requests a change.
- Establish the current semantic responsibility of `.ai/rules/`, `.ai/skills/`, and `.ai/workflows/` from their canonical owners.
- Research the actual DSH skill-loading contract and compare it with the project's intended semantics; separate evidence about host loading from the question of semantic ownership.
- Identify any rule whose semantics are not reliably delivered to the relevant host context, and evaluate minimal remedies without duplicating owners.
- Produce a bounded architectural recommendation before making structural changes.

## Immediate next task

Perform the requested **read-only audit** of the actual root `AGENTS.md`. Compare it directly with `.ai/AGENTS.md`, `.ai/config.yaml`, and `.ai/rules/repository.md`, and report what is correct, redundant, host-specific, or inconsistent with the intended ROOT → `.ai/` boundary. Explicitly evaluate the direct link to the DSH verification artifact. Do not mutate any file during this audit.

After that, investigate the rules-versus-skills architecture as a separate, evidence-driven question. Do not start by moving or deleting rules.

## Recommended starting context

Read this handoff, then use the already-read root `AGENTS.md`, `.ai/AGENTS.md`, `.ai/config.yaml`, and `.ai/rules/repository.md` as the starting comparison set. Re-read any canonical owner before executing a subsequent operation. Use the DSH verification artifact as supporting evidence only, and revalidate version-sensitive claims if they materially affect a recommendation.
