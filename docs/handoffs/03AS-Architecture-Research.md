# 03AS — Architecture & Research

## Chapter identity

- **Chapter:** 03AS
- **Specialization:** 03 — Architecture & Research
- **Previous chapter:** 03AR — Architecture & Research
- **Status:** DRAFT

## Starting objective

Continue the architecture/research work from 03AR while preserving the currently established context. The immediate purpose of this chapter is **not to design a new architecture yet**: first capture and integrate the remaining project constraints supplied by the project owner.

## Bootstrap state

03AR is the direct predecessor and was verified as `READY_FOR_HANDOFF` at bootstrap.

The current repository model remains:

- `paulhuman/aip-mirror` on `main` is the canonical project repository.
- `docs/handoffs/` is the temporary conversation context-transfer mechanism.
- Durable project knowledge belongs in authoritative project documentation.
- The 03 specialization is responsible for architecture, research, cross-workstream decisions, and project-wide architectural consistency.

## Current research context

03AR completed the first bounded inspection of intentional-acceptance practice. Existing repository conventions already make some semantic status observable through explicit wording, including accepted working semantics and formal `AD-*` decisions. No dedicated Acceptance entity or universal acceptance mechanism was introduced.

The earlier research direction toward a historical semantic trace is currently **paused**.

The latest constraints recorded by 03AR include:

1. Long conversations have produced observed contextual reliability degradation; this is evidence of a risk, not a finalized causal architecture claim.
2. Action-scoped refresh of relevant `RULE`/`SKILL` fragments is a candidate direction, not an accepted design.
3. Future project commands need a user-facing trigger that does not rely on leading `/` or `@`, because those prefixes are intercepted by the ChatGPT web UI. No command syntax has been selected.
4. `.ai/memory/` is currently considered unnecessary; do not introduce it merely as another knowledge store.
5. `docs/meta/` is being considered as a project-independent meta-system boundary, with a conceptual distinction between permanent reusable meta knowledge and temporary development/research material. This has not been accepted as a filesystem structure.
6. `docs/handoffs/` is currently understood as temporary context transfer, not permanent knowledge or a required runtime source of truth.
7. The eventual meta-system should be agnostic and reusable across projects, while AIP Mirror retains its project-specific authoritative documentation and implementation.
8. Repository restructuring and architecture changes must be deferred until the remaining constraints have been supplied and mapped.

## Important constraint for this chapter

**Do not resume the planned Phase 2 historical semantic trace yet.**

**Do not create `docs/meta/permanent/`, `docs/meta/temporary/`, `.ai/memory/`, a command registry, or a command prefix.**

**Do not begin a new C-series experiment merely because the current research ideas are visible.**

The first substantive task after bootstrap is to receive and consolidate the remaining user constraints into a bounded problem map, then determine what architectural uncertainty remains. Only after that should the next research step be selected.

## Evidence / confidence

### Confirmed / observed

- The canonical repository and branch are `paulhuman/aip-mirror` / `main`.
- 03AR was `READY_FOR_HANDOFF` at bootstrap.
- The current handoff lifecycle is `DRAFT → READY_FOR_HANDOFF → HANDED_OFF`.
- 03AR completed the intentional-acceptance bounded inspection described above.
- No dedicated Acceptance mechanism was introduced by that research.
- The user explicitly requested that this chapter preserve current context and wait for remaining constraints before designing architecture.

### Inferred

- The next highest-value step may be a bounded constraint/problem map rather than another semantic experiment.
- Existing documentary conventions may remain sufficient; whether additional mechanisms are necessary is still open.
- Context handling, action-scoped instruction refresh, handoff lifetime, and the project/meta boundary may be related architectural concerns, but their exact relationship is not yet established.

### Assumed / unverified

- The final shape of any reusable meta-system.
- Whether an action-scoped instruction registry is actually necessary.
- Whether `docs/meta/` is the correct durable boundary.
- Whether any replacement for or extension of handoffs is needed.
- Whether a command registry should exist at all.

### Open

- Remaining project constraints not yet supplied by the user.
- The minimum architectural changes, if any, required after those constraints are mapped.
- Whether the paused intentional-acceptance research remains the correct next research target.

## Immediate next task

**Wait for and capture the remaining project constraints.**

After they are supplied, consolidate them into a bounded problem map without prematurely choosing architecture, then identify which uncertainty should be reduced next.

## Things not to redo

Do not repeat merely for migration:

- the 03AR intentional-acceptance inspection;
- C-13;
- C-14;
- C-12;
- C-11.11–C-11.15;
- the 03AP Semantic Source & Authority Audit;
- the 03AP Intentional Acceptance Audit;
- the 03AP Architectural Bottleneck Audit;
- the 03AP Architectural Bottleneck Cross-Audit;
- the Post-C-13 Architectural Leverage Audit;
- the completed 03AQ lifecycle cleanup.

Do not reintroduce `SUPERSEDED` into the current lifecycle.

## Recommended starting context

Already read during bootstrap:

- `docs/PROJECT-INSTRUCTIONS.md`
- `.ai/skills/conversation-handoff/BOOTSTRAP.md`
- `.ai/skills/conversation-handoff/SKILL.md`
- `.ai/rules/conversation-lifecycle.md`
- `.ai/rules/workflow.md`
- `.ai/rules/handoff-references.md`
- `.ai/skills/commit-message/SKILL.md`
- `docs/handoffs/03AR-Architecture-Research.md`

Further architecture documents should be read selectively only when the user's remaining constraints make them relevant. Do not reload the full historical architecture corpus merely for migration.

## Last completed task

03AR completed its bounded intentional-acceptance inspection and finalized its handoff as `READY_FOR_HANDOFF`.

03AS has completed bootstrap initialization up to creation of this `DRAFT` handoff; the predecessor lifecycle transition remains to be performed and verified as part of bootstrap.

## Bootstrap note

This handoff is intentionally a compact live checkpoint. It preserves the active constraints and research pause without attempting to reproduce the accumulated architectural history.
