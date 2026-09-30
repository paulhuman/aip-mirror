# AI infrastructure index

`.ai/INDEX.md` is the operational entry surface for AI-assisted repository work.

It provides two bounded functions:

- **command routing** — map a user-facing command to the semantic operation and canonical owner needed to execute it;
- **capability discovery** — locate a canonical capability without reading the entire `.ai/` tree.

INDEX is a router and discovery surface. It is not a rule, skill, or workflow owner.

## Routing model

    user command
        ↓
    INDEX.md
        ↓
    operation identification
        ↓
    reread canonical owner files
        ↓
    execute canonical owner

INDEX MUST NOT reproduce the detailed procedure owned by the target rule, skill, or workflow.

## Command surface

The following are the currently documented user-facing command phrases. Their exact future command IDs/syntax remain provisional.

| Command phrase | Semantic operation | Canonical owner | Read before execution |
|---|---|---|---|
| `Пора обновить handoff` | checkpoint current chapter | `.ai/skills/handoff/SKILL.md` | `.ai/rules/handoff/lifecycle.md`; current handoff |
| `Пора выполнить миграцию в чат [A-Z][0-9]{3}` | migrate current chapter | `.ai/skills/handoff/SKILL.md` + `.ai/rules/handoff/lifecycle.md` | lifecycle; handoff skill; `.ai/workflows/handoff/BOOTSTRAP.md` |
| `Пора восстановить handoff` | Lifecycle Recovery | `.ai/rules/handoff/lifecycle.md` | lifecycle; commit rule/skill when a recovery write is required |
| `Пора выполнить handoff lifecycle correction` | historical Lifecycle Correction | `.ai/rules/handoff/lifecycle.md` | lifecycle; commit rule/skill when a correction write is required |
| `Пора выдать bootstrap-инструкцию` | generate bootstrap instruction for the future receiving chapter | `.ai/skills/handoff/SKILL.md` + `.ai/workflows/handoff/BOOTSTRAP.md` | handoff skill; bootstrap workflow |

The table records only information needed to recognize and activate the canonical operation. It does not define lifecycle transitions, write authorization, commit construction, or workflow steps.

### Routing rules

1. Match the user's command to the closest documented semantic operation.
2. Treat the command phrase as an invocation signal, not as the procedure itself.
3. Read the listed canonical owners and activation context before execution.
4. Follow the canonical owner's procedure; DO NOT substitute INDEX content for it.
5. Apply repository write-safety and commit rules from their canonical owners when the operation requires repository mutation.
6. If the command does not match a known operation, inspect the capability map and relevant canonical owners before inventing any new operation.

## Capability discovery

Use this map to find the canonical capability without reading the entire `.ai/` tree.

| Capability | Canonical owner | Purpose |
|---|---|---|
| Repository identity, path resolution, repository boundaries, write safety | `.ai/rules/repository.md` | canonical repository semantics and mutation safety |
| General workflow principles | `.ai/rules/workflow.md` | general AI development workflow constraints |
| Handoff lifecycle | `.ai/rules/handoff/lifecycle.md` | lifecycle states, transitions, Recovery, Correction |
| Handoff reference preservation | `.ai/rules/handoff/references.md` | material research references that survive handoff |
| Commit policy | `.ai/rules/commits.md` | commit policy and project commit vocabulary |
| Handoff capability | `.ai/skills/handoff/SKILL.md` | checkpoint and migration capability |
| Commit construction | `.ai/skills/commits/SKILL.md` | reusable commit-message construction |
| Conversation bootstrap | `.ai/workflows/handoff/BOOTSTRAP.md` | ordered new-chapter bootstrap procedure |

## Owner boundary

INDEX may identify and route to an owner.

INDEX MUST NOT become the owner of:

- lifecycle semantics;
- handoff procedures;
- commit policy or commit construction;
- repository path-resolution rules;
- bootstrap ordering;
- other reusable operational procedures.

When a routing entry needs more detail, add a pointer to the canonical owner rather than copying the owner's procedure.

## Metadata boundary

The command surface intentionally stops at:

    invocation
        ↓
    semantic operation
        ↓
    canonical owner
        ↓
    activation context

The activation context identifies which canonical owner files MUST be reread. It is a routing aid, not a dependency graph and not a copy of the referenced procedures.

INDEX does not record:

- repository-state effects;
- lifecycle outcomes;
- commit authorization;
- commit construction;
- procedural steps.

Those semantics remain owned by the canonical rules, skills, and workflows.

In particular:

- lifecycle states such as `DRAFT`, `READY_FOR_HANDOFF`, and `HANDED_OFF` are not operation IDs;
- an operation and any resulting repository change are distinct concepts;
- bootstrap-instruction generation does not initialize the receiving chapter or change lifecycle state.
