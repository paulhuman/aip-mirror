# Conversation Handoff

**Conversation:**
C032 — Architecture & Research

**Specialization:**
C

**Chapter:**
032

**Previous chapter:**
C031

**Status:**
DRAFT

## Starting objective

Continue the bounded architecture work on ACTIVATE after C031 established and implemented the smallest reusable activation capability. Determine where that capability can be integrated into one real existing operation with the smallest useful change, without duplicating routing, lifecycle, repository, commit, or project semantics.

## Starting state

C031 completed the owner-boundary experiment for five cases:

1. handoff bootstrap;
2. new-specialization entry;
3. ordinary continuation;
4. explicit REFRESH;
5. pre-mutation activation.

The experiment established that one reusable ACTIVATE procedure is semantically sufficient across all five cases when the caller supplies the operation-specific canonical owner set.

The first implementation now exists at:

    .ai/skills/activation/SKILL.md

Its contract is intentionally small:

    Activation Context
        ├── operation
        ├── required canonical owners
        └── optional mode/context

    ACTIVATE
        ↓
    reread required canonical owners
        ↓
    ACTIVATED

ACTIVATE does not own lifecycle, repository, project, mutation, commit, or verification semantics. REFRESH reuses ACTIVATE as an invocation mode. TRACE remains optional observability evidence.

C031 also established that handoff continuity and activation context are distinct. A handoff should preserve material current-work and durable-context references; activation independently establishes the canonical operational context required for the current operation.

## Previous chapter

C031 — Architecture & Research.

C031 is the verified source of the completed activation owner-boundary experiment and is transitioned to HANDED_OFF as part of C032 bootstrap.

## Important constraints

- Preserve the established AGENTS → INDEX → canonical-owner architecture.
- INDEX remains routing/discovery; it MUST NOT become a second procedural owner.
- Do not create ENTRY.md.
- Do not introduce a registry, manifest, dependency graph, command-ID layer, or universal router without a bounded test demonstrating a concrete need.
- Preserve BOOTSTRAP ownership and lifecycle ordering.
- Keep ACTIVATE small and compositional.
- ACTIVATE MUST NOT absorb lifecycle, repository, project, mutation, commit, or verification semantics.
- Treat REFRESH as an invocation mode over ACTIVATE unless new evidence proves otherwise.
- Treat TRACE as observability evidence, not persistent schema or hidden-reasoning transcript.
- Do not treat a handoff Recommended starting context as proof that activation occurred.
- Use current repository state as the source of truth.
- Do not redo the completed five-case owner-boundary experiment unless new evidence specifically requires revalidation.

## Evidence / confidence

### Confirmed / observed

- C031 completed the bounded five-case ACTIVATE owner-boundary experiment.
- .ai/skills/activation/SKILL.md exists and was read back after creation.
- Activation skill commit: 028ec2254d31a985149edcd1e7c32a79385e352e.
- Architecture notes were updated with the C031 result: 7047eb0a43b515025ed6b6b42e7340a59e6e2769.
- The activation skill is not yet wired into INDEX.md or BOOTSTRAP.
- The next bounded question is an integration test against one real existing operation.

### Inferred

- A small integration may be possible by having an existing operation invoke ACTIVATE after its routing/owner set is known and before execution.
- The first useful integration candidate is likely a small handoff operation, but this must be tested rather than assumed.

### Open

- Which existing operation provides the cleanest first integration point.
- Whether INDEX needs any minimal discoverability change to point to the activation skill, or whether the owning skill/workflow can invoke it without INDEX changes.
- Whether BOOTSTRAP should invoke ACTIVATE directly, indirectly through an owning capability, or remain unchanged until a concrete integration case proves the need.
- Whether the current activation contract needs any refinement after real operational use.

## Immediate next task

Run one bounded real-operation integration test.

Preferred starting point:

    Пора обновить handoff

For that operation:

1. reread the current INDEX routing entry and canonical handoff/lifecycle owners;
2. identify the exact owner set required before execution;
3. invoke the activation procedure conceptually or through the new skill;
4. determine the smallest integration change needed to make the activation explicit and reusable;
5. verify that the change does not duplicate routing, lifecycle, repository, commit, or project semantics;
6. only then consider whether INDEX.md or BOOTSTRAP.md needs a minimal update.

Do not broaden the experiment into a general entry-layer redesign.

## Things not to redo

- C027 entry-layer restructuring.
- The AGENTS entry-contract decision.
- The INDEX minimum-routing decision.
- The decision not to create ENTRY.md.
- BOOTSTRAP ownership and ordering.
- The current chapter identifier format.
- The completed normative-language cleanup.
- C030 discovery-versus-activation observation.
- C031 five-case activation owner-boundary experiment.
- The distinction between handoff continuity and activation context.
- The first activation skill implementation.

## Recommended starting context

- .ai/AGENTS.md
- .ai/INDEX.md
- .ai/rules/repository.md
- .ai/rules/workflow.md
- .ai/rules/handoff/lifecycle.md
- .ai/rules/commits.md
- .ai/skills/activation/SKILL.md
- .ai/skills/handoff/SKILL.md
- .ai/workflows/handoff/BOOTSTRAP.md
- .ai/architecture/ai-infrastructure-restructuring.md
- .ai/handoffs/C/C031-Architecture-Research.md
- docs/PROJECT-INSTRUCTIONS.md
