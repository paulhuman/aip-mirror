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
DRAFT

## Current objective

Design and implement the `.ai/AGENTS.md` entry-layer contract from current repository evidence, then perform a separate targeted semantic cleanup of `docs/PROJECT-INSTRUCTIONS.md` and the handoff lifecycle command-discovery surface.

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
- `.ai/INDEX.md` currently combines a user-facing command table with a capability-discovery map.
- Current command-table metadata includes command phrase, semantic operation, canonical owner, required reread targets, repository-state effect, and commit indication.
- The architecture record explicitly leaves the minimum semantic metadata boundary and scalable INDEX presentation open for this chapter.
- `.ai/AGENTS.md` currently contains only its heading and is therefore not to be treated as a substantive operating-contract source during this analysis unless the repository state changes later.

## Immediate next task

1. Record the Phase 2 AGENTS entry-path result in this handoff and the durable architecture note.
2. Separately clean up the two stale references exposed by the Phase 2 test in `docs/PROJECT-INSTRUCTIONS.md`:
   - old chapter format `[0-9]{2}[A-Z]{2}` / `AA → AB → ... → ZZ` → current `[A-Z][0-9]{3}`;
   - old bootstrap path `.ai/workflows/handoff-bootstrap/BOOTSTRAP.md` → `.ai/workflows/handoff/BOOTSTRAP.md`.
3. Inspect `.ai/rules/handoff/lifecycle.md` for repeated user-facing command phrases. Preserve lifecycle semantics and authorization; the target boundary is INDEX for invocation discovery and lifecycle.md for operation semantics/authorization.
4. Implement the tested minimal AGENTS contract in `.ai/AGENTS.md`.
5. Run a targeted entry-layer consistency sweep.

The completed INDEX presentation analysis is not to be reopened.

### Phase 2 entry-path result

The empty `.ai/AGENTS.md` failed the Phase 0 entry-path test. The tested minimal AGENTS candidate then passed both bounded scenarios:

AI infrastructure:

    AGENTS → config.yaml → repository.md → INDEX → canonical owner

Project work:

    AGENTS → config.yaml → repository.md → PROJECT-INSTRUCTIONS → canonical project sources

The experiment confirms that `.ai/config.yaml` and `.ai/rules/repository.md` are genuine initialization-path nodes. The implementation baseline is the five-point minimal contract tested in Phase 2: establish `.ai` vs `docs` boundaries; initialize repository/path context from config and repository rule; route AI-infrastructure work through INDEX; route project work through PROJECT-INSTRUCTIONS; and reread the canonical owner before execution.

The candidate has not yet been written to AGENTS.

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

- Which current INDEX fields are required for discovery?
- Which fields are required for safe routing once an operation is identified?
- Is `Repository state may change` necessary routing metadata, or can it be represented more compactly without becoming a shadow owner?
- Is `Commit` useful as routing metadata, or does its current wording risk owning commit semantics?
- Are `Required reread targets` routing metadata or a partial dependency graph, and what is the minimum useful form?
- Can command discovery and capability discovery share a compact presentation without creating a second registry/manifest layer?
- What presentation remains immediately usable at approximately 10–15 entries?

## Evidence / confidence

### Confirmed / observed

- Repository identity is `paulhuman/aip-mirror`, default branch `main`, from `.ai/config.yaml`.
- C026 was `READY_FOR_HANDOFF` before this bootstrap.
- `.ai/INDEX.md` is explicitly defined as a router/discovery surface.
- The current INDEX metadata set is intentionally preserved pending the minimum-semantic-metadata analysis.
- `.ai/workflows/handoff/BOOTSTRAP.md` is the canonical ordered bootstrap workflow.
- The lifecycle is `DRAFT → READY_FOR_HANDOFF → HANDED_OFF`.

### Inferred

- The INDEX presentation can likely be made more compact without introducing a new filesystem layer, but this must be demonstrated by analysis rather than assumed.
- The minimum semantic boundary may be smaller than the current table, but no field should be removed merely for visual compactness.

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


## C027 bounded follow-up

The INDEX routing decision is complete. Current work is now split deliberately into two categories:

1. **Architecture:** record and implement the minimal AGENTS entry contract.
2. **Cleanup:** correct stale project-instruction references and reduce command-discovery duplication in the lifecycle rule without changing lifecycle semantics.

Do not mix these scopes into a new redesign.
