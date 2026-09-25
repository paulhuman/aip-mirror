# Iteration 2 — Repository Consistency Sweep

Status: Active migration research / 03AX
Specialization: 03 — Architecture & Research

## Purpose

Record the findings from the repository-wide consistency sweep performed after the physical restructuring and architecture archive pass.

This document is project migration knowledge. It records observations, classifications, unresolved architectural questions, and the next repair plan. It is not a generic `.ai` rule.

## Current state

The physical restructuring is substantially complete. The active `.ai/architecture/` layer now contains only the current `ai-infrastructure-restructuring.md`; historical architecture research was moved to `.ai/archive/architecture/`.

The sweep therefore focuses on semantic residue rather than target-tree planning.

## Sweep order

1. Inventory active `.ai`.
2. Search for project-specific leakage.
3. Search for stale paths, owners, and filenames.
4. Search for duplicated normative instructions.
5. Search for stale lifecycle, chapter, and specialization terms.
6. Check routing and link targets.
7. Classify each relevant hit.
8. Repair only genuine inconsistencies.
9. Run a second sweep after repairs.
10. Verify scope and commit.

## Findings

### Clean / already consistent

The following searches produced no active residue requiring repair:

- `SUPERSEDED` as a lifecycle state;
- `bootstrap kernel` as an architectural term;
- `ENTRY.md` as an active layer;
- old `docs/handoffs/` routing;
- old active `.ai/architecture/` paths for the archived architecture documents.

Historical references in archive material are intentionally historical and are not treated as active dependencies.

### Finding A — repository identity inside `.ai/rules/repository.md`

Classification: **ARCHITECTURAL / DEFERRED REPAIR**

The repository rule contains the concrete AIP Mirror repository identity and the Adobe Illustrator SDK repository identity. It also owns repository path resolution and write safety.

This is not safe to fix by simple string replacement because repository identity is operationally useful to the current project while the Iteration 2 target is project-agnostic `.ai` infrastructure.

Question to resolve:

> Where should project-specific repository identity live when `.ai` is reusable across projects, while generic repository safety and path-resolution mechanics remain reusable infrastructure?

Do not silently resolve this during a mechanical cleanup pass.

### Finding B — project identity in `.ai/rules/handoff/references.md`

Classification: **STALE PROJECT-SPECIFIC CONTENT**

The generic handoff reference rule contains the concrete AIP Mirror repository identity. This is project configuration embedded in reusable infrastructure and is a repair candidate.

### Finding C — project name in `.ai/rules/handoff/lifecycle.md`

Classification: **STALE PROJECT-SPECIFIC WORDING**

The lifecycle semantics are generic, but the introductory wording identifies AIP Mirror conversations specifically. The semantic rule should be project-agnostic.

### Finding D — project name in `.ai/rules/workflow.md`

Classification: **STALE PROJECT-SPECIFIC WORDING**

The workflow guidance is generic, but its framing still identifies AIP Mirror. The reusable workflow rule should not depend on the current project name.

### Finding E — project-specific material in `.ai/skills/commits/SKILL.md`

Classification: **MIXED**

The skill contains generic commit procedure mixed with AIP Mirror / JSX / FreeHand references. Each occurrence must be inspected in context before deciding whether it is a valid example, stale project knowledge, or necessary operational context.

### Finding F — project-specific material in `.ai/skills/deep-understanding/SKILL.md`

Classification: **MIXED / PROBABLE PROJECT LEAKAGE**

The skill contains AIP Mirror, Adobe Illustrator SDK, JSX, and FreeHand references. Because this is a reusable capability, these references are suspicious. They require semantic inspection rather than blind deletion.

### Finding G — project-specific material in `.ai/skills/handoff/SKILL.md`

Classification: **MIXED / PROBABLE PROJECT LEAKAGE**

The handoff skill still contains AIP Mirror-specific wording. Most of the skill is generic; only the project-specific residue should be removed or generalized.

### Finding H — independent-review onboarding

Classification: **PROJECT-SPECIFIC WORKFLOW CONFIGURATION**

The active `independent-review` onboarding files describe concrete AIP Mirror specializations, architecture work, and model onboarding. They are not generic reusable workflow instructions in their current form.

The next step is to determine whether these belong under project documentation/configuration rather than generic `.ai/workflows/`, or whether a smaller generic workflow plus project-specific configuration should be separated.

The removed DeepSeek onboarding is not to be restored.

## Architectural principle confirmed during the sweep

The project-agnostic requirement is stronger than merely avoiding project names in headings.

Generic `.ai` rules, skills, and workflows must not contain project facts disguised as examples or embedded operational configuration.

The useful distinction is:

    REUSABLE MECHANISM
        -> `.ai`

    CURRENT PROJECT CONFIGURATION / KNOWLEDGE
        -> project-owned documentation/configuration

A concrete example is acceptable only when it explains a reusable mechanism and remains abstract enough to survive reuse. A project fact that an AI needs for the current repository is not automatically a reusable `.ai` rule.

## Repair plan

1. Inspect the mixed findings in context.
2. Decide the ownership boundary for repository identity before editing `repository.md`.
3. Generalize genuinely generic rules and skills.
4. Separate project-specific independent-review configuration from reusable workflow mechanics if warranted.
5. Run the post-edit consistency sweep again.
6. Only after the second sweep move to entry-surface work (`AGENTS.md` / `.ai/INDEX.md`).

## Explicit non-goals

- Do not restart semantic-comparison or target-tree planning.
- Do not introduce `ENTRY.md`.
- Do not restore `SUPERSEDED`.
- Do not use `bootstrap kernel` as an architectural term.
- Do not mechanically remove every project name without checking semantic ownership.
- Do not solve the handoff operation / commit vocabulary TODO during this sweep.

## Migration graph

    physical restructuring
            |
            v
    archive obsolete architecture
            |
            v
    repository-wide semantic sweep
            |
            +--> clean residue
            |
            +--> stale project leakage
            |
            +--> mixed ownership
            |
            +--> architectural boundary question
            |
            v
    targeted repair
            |
            v
    second consistency sweep
            |
            v
    entry-surface review
            |
            v
    Iteration 2 final audit
