# Conversation Handoff

**Conversation:**
C027 — Architecture & Research

**Specialization:**
C

**Chapter:**
027

**Previous chapter:**
026

**Status:**
HANDED_OFF

## Current objective

Complete the final entry-layer consistency verification after implementing the `.ai/AGENTS.md` contract and the separate cleanup work.

The bounded architecture target is:

    AGENTS
      ↓
    context initialization
      ↓
    AI infrastructure → INDEX → canonical owners
    project work      → PROJECT-INSTRUCTIONS → canonical project sources

AGENTS must remain a compact always-on contract, not a second INDEX, procedure catalogue, lifecycle rule, or capability owner.

## Starting state

- Physical Iteration 2 restructuring is complete.
- Repository Identity & Path Resolution ownership is established.
- The active chapter identifier format is `[A-Z][0-9]{3}`.
- `.ai/INDEX.md` now uses the four-field routing boundary: command, operation, owner, activation context.
- Capability discovery remains separate: capability, owner, purpose.
- The minimum routing analysis is complete; do not reopen it without new evidence.
- `.ai/AGENTS.md` now contains the tested minimal always-on entry contract.

## Immediate next task

The final consistency sweep found no remaining active entry-layer inconsistency. C027 is complete and ready for handoff to C028. The receiving chapter should begin from current repository state and use the bootstrap procedure below; do not reopen settled C027 architecture without new evidence.

Completed in this sequence:

1. Recorded the Phase 2 AGENTS result in this handoff and the durable architecture note.
2. Corrected the stale chapter format and bootstrap path in `docs/PROJECT-INSTRUCTIONS.md`.
3. Classified lifecycle command duplication: checkpoint/migration invocation discovery belongs to INDEX; lifecycle semantics remain canonical in `lifecycle.md`; recovery/correction phrases remain because they are explicit authorization tokens in the lifecycle procedures.
4. Implemented the tested minimal AGENTS contract.
5. Reconciled the durable architecture note with the completed INDEX decision.

The completed INDEX presentation analysis is not to be reopened.

### Phase 2 entry-path result

The empty `.ai/AGENTS.md` failed the Phase 0 entry-path test. The tested minimal AGENTS candidate then passed both bounded scenarios:

AI infrastructure:

    AGENTS → config.yaml → repository.md → INDEX → canonical owner

Project work:

    AGENTS → config.yaml → repository.md → PROJECT-INSTRUCTIONS → canonical project sources

The experiment confirms that `.ai/config.yaml` and `.ai/rules/repository.md` are genuine initialization-path nodes. The implementation baseline is the five-point minimal contract tested in Phase 2: establish `.ai` vs `docs` boundaries; initialize repository/path context from config and repository rule; route AI-infrastructure work through INDEX; route project work through PROJECT-INSTRUCTIONS; and reread the canonical owner before execution.

The tested candidate was implemented in `.ai/AGENTS.md` and verified during the final consistency sweep.

## Relevant files

Primary analysis:

- `.ai/INDEX.md`
- `.ai/architecture/ai-infrastructure-restructuring.md`
- `.ai/AGENTS.md`

Canonical owners for validation:

- `.ai/config.yaml`
- `.ai/rules/repository.md`
- `.ai/rules/workflow.md`
- `.ai/rules/handoff/lifecycle.md`
- `.ai/rules/handoff/references.md`
- `.ai/rules/commits.md`
- `.ai/skills/handoff/SKILL.md`
- `.ai/skills/commits/SKILL.md`
- `.ai/workflows/handoff/BOOTSTRAP.md`

Previous handoff:

- `.ai/handoffs/C/C026-Architecture-Research.md`

Earlier same-specialization handoff checked during bootstrap:

- `.ai/handoffs/C/C025-Architecture-Research.md`

## Decisions and constraints

- INDEX identifies and routes; canonical owners define and execute.
- Do not duplicate canonical procedures inside INDEX.
- Do not create `ENTRY.md`.
- Do not change lifecycle semantics.
- Do not change BOOTSTRAP ownership or ordering.
- Do not change the chapter identifier format.
- Do not move project-specific configuration out of `.ai/config.yaml`.
- Do not restart physical Iteration 2 restructuring.
- Do not start the deferred handoff-operation / commit-vocabulary work.
- Do not freeze exact command IDs or final command syntax.
- Do not edit INDEX before the presentation and metadata analysis is settled.
- Preserve the distinction between discovery information, routing metadata, and canonical execution semantics.

## Open questions

- Does the final entry-layer consistency sweep reveal any remaining stale or contradictory active references?
- Does the implemented AGENTS contract remain sufficiently small after real use, without growing into a second INDEX?
- Are any additional lifecycle command-discovery duplicates present beyond the classified checkpoint/migration phrases?

## Evidence / confidence

### Confirmed / observed

- Repository identity is `paulhuman/aip-mirror`, default branch `main`, from `.ai/config.yaml`.
- C026 was `READY_FOR_HANDOFF` before this bootstrap.
- `.ai/INDEX.md` is a router/discovery surface with the four-field routing boundary.
- `.ai/workflows/handoff/BOOTSTRAP.md` is the canonical ordered bootstrap workflow.
- The lifecycle is `DRAFT → READY_FOR_HANDOFF → HANDED_OFF`.
- Phase 2 validated the two entry paths and the minimal AGENTS contract.
- `docs/PROJECT-INSTRUCTIONS.md` now uses the current chapter format and canonical bootstrap path.
- Lifecycle checkpoint/migration invocation discovery is routed through INDEX; recovery/correction authorization phrases remain in the lifecycle rule.

### Inferred

- AGENTS can remain small if it only establishes entry topology and initialization pointers.
- The project branch should remain separate from the AI-infrastructure command router.

### Assumed / unverified

- The current six-field routing metadata set is not yet proven minimal.
- The final scalable presentation structure has not been selected.
- It is not yet known whether an INDEX edit will be justified.

## Things not to redo

- Physical Iteration 2 restructuring.
- Repository Identity & Path Resolution ownership pass.
- The decision to retain BOOTSTRAP as an independent ordered workflow.
- The decision not to create `ENTRY.md`.
- The current chapter identifier migration.
- The prior decision to preserve INDEX metadata pending evidence.

## Recommended starting context

Use the user-provided C027 bootstrap order as the authoritative starting sequence. Start with the current INDEX and architecture note, then validate against AGENTS, lifecycle, handoff skill, and BOOTSTRAP before consulting additional owners as needed.

The durable architectural question is:

> What is the minimum semantic information an INDEX router needs to discover and safely activate the canonical capability while remaining only a router and never becoming a shadow owner?


## C027 analysis result — INDEX presentation and metadata boundary

### Current presentation inventory

The pre-edit INDEX had two distinct surfaces:

1. a five-command routing table;
2. an eight-capability discovery map.

The routing table carried six semantic fields beyond the command itself: operation, owner, reread targets, repository-state effect, and commit indication. The capability map separately provided capability, canonical owner, and purpose.

### Discovery vs routing

The two surfaces serve different questions:

- **Capability discovery:** “Where is the canonical capability for this kind of work?”
- **Command routing:** “Which canonical operation should this user command activate, and what must be reread before execution?”

The capability map therefore needs only capability → owner → purpose.

The command table needs invocation → semantic operation → canonical owner → activation context.

### Minimum semantic metadata test

The previous \`Repository state may change\` and \`Commit\` columns were useful as operator warnings but were not required to discover or safely route the operation. Their meanings are already canonically defined elsewhere, and retaining their detailed wording creates a soft risk that INDEX becomes a secondary owner for lifecycle/commit semantics.

The minimum useful command-routing boundary is therefore:

    command phrase
        ↓
    semantic operation
        ↓
    canonical owner
        ↓
    activation context / reread targets

\`Required reread targets\` remain useful because they tell the receiving AI what canonical context must be activated before execution. They are treated as routing/activation metadata, not as a dependency graph.

### Scalable presentation decision

The current presentation is better represented by:

- a compact four-column command-routing table;
- a separate capability-discovery table;
- a short explicit metadata-boundary statement.

This preserves fast discovery while reducing the width and semantic density of the command table. It does not introduce a registry, manifest, command-ID schema, new filesystem layer, or procedural catalogue.

### INDEX edit

The INDEX was edited only after the above analysis.

The edit:

- removed repository-state and commit-effect columns;
- retained command phrase, semantic operation, canonical owner, and reread/activation context;
- explicitly states that INDEX does not define lifecycle outcomes, write authorization, commit construction, or procedures;
- keeps the existing capability map and owner boundaries;
- preserves provisional command syntax/IDs.

Verified commit:

\`f32274d6ab251e74f8d4ac712121b2dd135eaa3b\`

Scope verification shows the INDEX commit changed only \`.ai/INDEX.md\`.

## Updated evidence / confidence

### Confirmed / observed

- The pre-edit routing table was semantically denser than necessary for routing.
- \`Repository state may change\` and \`Commit\` were not required for the minimum routing path.
- Capability discovery and command routing can remain separate presentations within the same INDEX file.
- \`Required reread targets\` have a distinct activation value and can remain without turning INDEX into a procedural owner.
- The edited INDEX was read back successfully.
- The INDEX edit commit changed only \`.ai/INDEX.md\`.

### Inferred

- The four-field routing boundary should remain usable as the command surface grows toward approximately 10–15 entries because the table avoids embedding operation effects and commit semantics.
- Further scaling pressure, if it appears, should be addressed through presentation changes before adding new metadata layers.

### Open

- Whether the exact command syntax/IDs should ever be frozen remains intentionally deferred.
- Whether future capabilities outside the current handoff domain need additional discovery grouping remains open.
- Future MEC / P-01 / P-02 / P-03 analysis is outside the completed C027 scope and is a likely next architecture question.


## C027 bounded follow-up

The INDEX routing decision is complete. Current work is now split deliberately into two categories:

1. **Architecture:** record and implement the minimal AGENTS entry contract.
2. **Cleanup:** correct stale project-instruction references and reduce command-discovery duplication in the lifecycle rule without changing lifecycle semantics.

Do not mix these scopes into a new redesign.

## Final consistency sweep result

The active entry layer is now consistent:

```
AGENTS
  ↓
config + repository
  ↓
┌──────────────────────┬────────────────────────┐
│ AI infrastructure    │ Project work           │
│ ↓                    │ ↓                      │
│ INDEX                │ PROJECT-INSTRUCTIONS   │
│ ↓                    │ ↓                      │
│ canonical AI owners  │ canonical project      │
│                      │ sources                │
└──────────────────────┴────────────────────────┘
```

Verified:

- `.ai/AGENTS.md` contains only the tested entry contract.
- `.ai/INDEX.md` uses the current `[A-Z][0-9]{3}` migration placeholder and retains only routing/discovery semantics.
- `.ai/config.yaml` remains the intentional project-specific configuration locus.
- `.ai/rules/repository.md` remains canonical for identity, path resolution, boundaries, and write safety.
- `docs/PROJECT-INSTRUCTIONS.md` uses the current chapter format and canonical bootstrap path.
- `.ai/rules/handoff/lifecycle.md` retains lifecycle semantics and authorization; checkpoint/migration invocation discovery is routed through INDEX.
- `.ai/workflows/handoff/BOOTSTRAP.md` remains the canonical ordered bootstrap workflow.
- durable architecture notes now mark AGENTS and lifecycle cleanup as resolved in C027 rather than pending.
- no active entry-layer document inspected in the sweep retains the former chapter format or former bootstrap path.
- `docs/architecture/project-architecture.md` was additionally found to retain the former chapter identifier format during migration preparation; this was corrected in commit `6ffef19d779a6874c21a609ee57f558469131a73` before handoff.

Historical occurrences of old identifiers/paths remain only where the architecture document explicitly records migration history or cleanup evidence; they are not active instructions.

### C027 scope conclusion

The bounded AGENTS architecture question, INDEX minimum-routing question, targeted project-instruction cleanup, lifecycle command-discovery cleanup, targeted architecture-document consistency correction, and final entry-layer consistency sweep are complete.

No Iteration 2 redesign is justified by the resulting evidence.