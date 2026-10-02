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

## Project references

For project-level work, the first project-level source is:

- `docs/PROJECT-INSTRUCTIONS.md` — project-specific instructions, operating constraints, behavioral targets, and routing to canonical project knowledge.

Project work MUST read `docs/PROJECT-INSTRUCTIONS.md` before following project-specific routing. It is a project-level orientation and routing source, not an AI-infrastructure owner.

## Command surface

The current documented user-facing command surface is:

| Command phrase                   | Semantic operation                                              | Canonical owner                                                      | Read before execution                              |
| -------------------------------- | --------------------------------------------------------------- | -------------------------------------------------------------------- | -------------------------------------------------- |
| `>>handoff`                      | checkpoint current chapter                                      | `.ai/skills/handoff/SKILL.md`                                        | `.ai/rules/handoff/lifecycle.md`; current handoff  |
| `>>migrate <chapter>`            | migrate current chapter                                         | `.ai/skills/handoff/SKILL.md` + `.ai/workflows/handoff/BOOTSTRAP.md` | handoff skill; bootstrap workflow; current handoff |
| `>>generate-bootstrap <chapter>` | generate bootstrap instruction for the future receiving chapter | `.ai/skills/handoff/SKILL.md` + `.ai/workflows/handoff/BOOTSTRAP.md` | handoff skill; bootstrap workflow; current handoff |
| `>>explain-code`                 | explain code or codebase behavior                               | `.ai/skills/explain-code/SKILL.md`                                   | explain-code skill                                 |
| `>>normative-language`          | activate normative-language context                              | `.ai/skills/normative-language/SKILL.md`                             | normative-language skill                           |

The table records only information needed to recognize and activate the canonical operation. It does not define write authorization, commit construction, or workflow steps.

### Routing rules

1. Match the user's command to the closest documented semantic operation.
2. Treat the command phrase as an invocation signal, not as the procedure itself.
3. For project-level work, read `docs/PROJECT-INSTRUCTIONS.md` first and use its canonical project-source routing.
4. Invoke ACTIVATE with the operation and listed canonical owners, rereading those owners before execution.
5. Follow the canonical owner's procedure; DO NOT substitute INDEX content for it.
6. For every user-facing `>>` command whose routing requires ACTIVATE, the completed operation-level TRACE MUST be inserted into the assistant response after canonical operation execution. The exact TRACE response template and presentation contract are owned by `.ai/skills/activation/SKILL.md`; individual command entries MUST NOT duplicate this requirement.
7. Apply repository write-safety and commit rules from their canonical owners when the operation requires repository mutation.
8. If the command does not match a known operation, inspect the capability map and relevant canonical owners before inventing any new operation.

## Capability discovery

Use this map to find the canonical capability without reading the entire `.ai/` tree.

| Capability                                                                | Canonical owner                      | Purpose                                                                            |
| ------------------------------------------------------------------------- | ------------------------------------ | ---------------------------------------------------------------------------------- |
| Repository identity, path resolution, repository boundaries, write safety | `.ai/rules/repository.md`            | canonical repository semantics and mutation safety                                 |
| General workflow principles                                               | `.ai/rules/workflow.md`              | general AI development workflow constraints                                        |
| Activation                                                                | `.ai/skills/activation/SKILL.md`     | establish the current canonical operational context before executing an operation  |
| Normative language                                                        | `.ai/skills/normative-language/SKILL.md` | command entry point; the skill requires `.ai/rules/normative-language.md`       |
| Conversation continuity                                                   | `.ai/rules/handoff/lifecycle.md`     | chapter naming, handoff continuity, and context preservation                       |
| Handoff reference preservation                                            | `.ai/rules/handoff/references.md`    | material research references that survive handoff                                  |
| Commit policy                                                             | `.ai/rules/commits.md`               | commit policy and project commit vocabulary                                        |
| Handoff capability                                                        | `.ai/skills/handoff/SKILL.md`        | checkpoint and migration capability                                                |
| Commit construction                                                       | `.ai/skills/commits/SKILL.md`        | reusable commit-message construction                                               |
| Conversation bootstrap                                                    | `.ai/workflows/handoff/BOOTSTRAP.md` | ordered new-chapter bootstrap procedure                                            |
| Code explanation                                                          | `.ai/skills/explain-code/SKILL.md`   | explain code with analogies, ASCII diagrams, step-by-step walkthrough, and gotchas |

## Structural references

- `.ai/handoffs/README.md` — handoff tree structure and orientation. Read when inspecting or navigating the handoff structure; it is not a runtime activation owner.
- `.ai/architecture/README.md` — architecture tree structure and orientation. Read when inspecting or navigating durable architecture context; it is not a runtime activation owner.

## Owner boundary

INDEX identifies and routes to an owner.

INDEX MUST NOT become the owner of:

- handoff continuity semantics;
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
- repository-state effects;
- commit authorization;
- commit construction;
- procedural steps.

Those semantics remain owned by the canonical rules, skills, and workflows.

In particular:

- an operation and any resulting repository change are distinct concepts;
- bootstrap-instruction generation does not initialize the receiving chapter or change the current conversation identity.
