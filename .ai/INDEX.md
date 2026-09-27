# AI infrastructure index

`.ai/INDEX.md` is the operational entry surface for AI-assisted repository work.

It answers:

- which user command or capability is being invoked;
- what semantic operation that command represents;
- which canonical owner defines the operation;
- which owner files must be reread before execution;
- whether execution may change repository state.

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

| Current command phrase | Semantic operation | Canonical owner | Required reread targets | Repository state may change |
|---|---|---|---|---|
| `Пора обновить handoff` | checkpoint current chapter | `.ai/skills/handoff/SKILL.md` | `.ai/rules/handoff/lifecycle.md`; `.ai/skills/handoff/SKILL.md`; current handoff | Yes — checkpoint commit; handoff remains `DRAFT` |
| `Пора выполнить миграцию в чат XXYY` | migrate current chapter | `.ai/skills/handoff/SKILL.md` + `.ai/rules/handoff/lifecycle.md`; bootstrap procedure for the generated receiving instructions | lifecycle; handoff skill; `.ai/workflows/handoff/BOOTSTRAP.md` | Yes — closing handoff may move to `READY_FOR_HANDOFF` |
| `Пора восстановить handoff` | Lifecycle Recovery | `.ai/rules/handoff/lifecycle.md` | lifecycle; commit policy/skill when a recovery write is required | Yes — bounded recovery only |
| `Пора выполнить handoff lifecycle correction` | historical Lifecycle Correction | `.ai/rules/handoff/lifecycle.md` | lifecycle; commit policy/skill when a correction write is required | Yes — bounded correction only |
| `Пора выдать bootstrap-инструкцию` | generate bootstrap instruction for the future receiving chapter | `.ai/skills/handoff/SKILL.md` + `.ai/workflows/handoff/BOOTSTRAP.md` | handoff skill; bootstrap workflow | No lifecycle change |

### Routing rules

1. Match the user's command to the closest documented semantic operation.
2. Treat the command phrase as an invocation signal, not as the procedure itself.
3. Reread every listed canonical owner before executing the operation.
4. Follow the canonical owner's procedure; do not substitute INDEX content for it.
5. If the operation may change repository state, apply the repository write-safety and commit rules owned by the relevant canonical files.
6. If the command does not match a known operation, do not invent an operation ID or procedure. Inspect the capability map and relevant owners first.

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

INDEX must not become the owner of:

- lifecycle semantics;
- handoff procedures;
- commit policy or commit construction;
- repository path-resolution rules;
- bootstrap ordering;
- other reusable operational procedures.

When a routing entry needs more detail, add a pointer to the canonical owner rather than copying the owner's procedure.

## State-change meaning

`Repository state may change` is a routing warning, not a permission.

A "Yes" entry means that the operation can mutate repository state when its canonical procedure permits or requires it.

A "No" entry means the operation itself is not a repository lifecycle mutation. It does not authorize unrelated writes.

In particular:

- `DRAFT`, `READY_FOR_HANDOFF`, and `HANDED_OFF` are lifecycle states, not operation IDs.
- An operation and its resulting commit are distinct concepts.
- Bootstrap-instruction generation does not initialize the receiving chapter and does not change lifecycle state.
