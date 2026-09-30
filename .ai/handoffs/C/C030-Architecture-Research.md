# Conversation Handoff

**Conversation:**
C030 — Architecture & Research

**Specialization:**
C

**Chapter:**
030

**Previous chapter:**
029

**Status:**
DRAFT

## Current objective

Continue Architecture & Research from the verified C029 repository state.

C030 is the receiving chapter for C029. This handoff is the live checkpoint for the current conversation and will be updated as meaningful state accumulates.

## Starting state

C029 completed the bounded normative-language verification work and then began the next architecture question: progressive disclosure / Minimum Sufficient Execution Context (MEC).

The important correction made at the end of C029 was methodological: do not treat MEC as a pre-existing internal model architecture, and do not attempt to reason about the AI's hidden thinking process. Test only observable repository behavior: what context must actually be discovered to perform a concrete task correctly.

## Previous chapter

C029 — Architecture & Research.

Its handoff has been prepared as `READY_FOR_HANDOFF` during this self-migration and is expected to be transitioned to `HANDED_OFF` after this C030 handoff is created and verified.

## Important constraints

- Preserve the established AGENTS / INDEX / canonical-owner architecture.
- Do not recreate `ENTRY.md`.
- Do not reopen settled entry-layer decisions without new evidence.
- Preserve BOOTSTRAP ownership and lifecycle ordering.
- Treat `.ai/rules/normative-language.md` as the current canonical owner of normative-language conventions.
- Do not mechanically reopen the completed normative-language cleanup.
- Work from observable repository behavior, not speculation about hidden model reasoning.
- Treat MEC as a working research question, not as an already-established architecture component.
- Do not introduce a router, registry, manifest, command schema, or additional filesystem layer unless a bounded test demonstrates a concrete need.
- No repository changes for the MEC question until the tests produce a concrete architectural decision.
- Use current repository state as the source of truth.

## Evidence / confidence

### Confirmed / observed

- C028's normative-language work is complete and its handoff is `HANDED_OFF`.
- C029's normative-language verification was recorded in `.ai/architecture/ai-infrastructure-restructuring.md`.
- The current architecture model distinguishes AGENTS, INDEX, canonical rules/skills/workflows, and project-source routing.
- `docs/PROJECT-INSTRUCTIONS.md` explicitly defines workstreams as organizational boundaries rather than permanent knowledge ownership.
- `docs/PROJECT-INSTRUCTIONS.md` routes canonical project knowledge to its semantic owner and requires cross-workstream continuity through durable repository knowledge.
- No formal repository definition of `MEC`, `P-01`, `P-02`, or `P-03` was found; those labels are not established repository specifications.
- C029's final active research direction was to replace abstract MEC speculation with simple observable tests.

### Inferred

- The existing AGENTS → INDEX → canonical-owner topology may already provide sufficient progressive disclosure for concrete tasks.
- Any additional MEC layer should earn its existence through a demonstrated failure or discoverability gap.

### Open

- Whether the minimum context required for concrete operations can be measured from bounded tests.
- Whether the tests reveal any missing routing/discoverability mechanism.
- Whether the current architecture needs any change at all.

## Bounded activation experiment — C030

The first T1/T2/T3 pass produced a useful distinction:

- **Discovery:** INDEX and project-source routing can locate the canonical owner without prior path knowledge.
- **Activation:** finding the owner does not guarantee that the owner is actually reread before execution.

T1 exposed the concrete failure mode: a repository mutation was attempted without rereading `.ai/rules/repository.md`, even though AGENTS, INDEX, and the architecture explicitly required that reread. The resulting failure is observable and does not require any inference about hidden model reasoning.

The project therefore has evidence for a boundary between:

    canonical owner found
        ↓
    canonical owner actually activated / reread
        ↓
    operation

The current architecture solves the first transition but does not provide an observable activation trace for the second.

## TRACE / activation research

The user identified an older desired mechanism: small terminal/console-like mini-logs showing which infrastructure files were actually read and which canonical operation was activated. This is intended as **observability of activation**, not a new semantic owner and not exposure of hidden reasoning.

A useful provisional trace shape is:

    [TRACE]
    READ  ✓ .ai/AGENTS.md
    READ  ✓ .ai/INDEX.md
    ROUTE → repository write safety
    READ  ✓ .ai/rules/repository.md
    READ  ✓ .ai/rules/commits.md
    READ  ✓ .ai/skills/commits/SKILL.md
    READY → mutation

Post-operation tracing can similarly expose read-back, content verification, diff/scope verification, commit, and result verification.

This is a research hypothesis, not yet a repository architecture decision.

## Prior archive evidence recovered

The following archived architecture material is directly relevant:

- `.ai/archive/architecture/mec-dynamic-context.md` treats activation as a dynamic transition between available knowledge and active context, and explicitly rejects a mandatory routing layer, registry, manifest, capability-ID system, or permanent bootstrap kernel as established semantic entities.
- `.ai/archive/architecture/minimal-execution-context.md` contains bounded cases for handoff bootstrap and safe repository modification. It distinguishes required execution context from conditional/escalation context and notes that ordinary bootstrap should not activate all recovery/correction material.
- `.ai/archive/architecture/ai-project-instruction-architecture.md` records the earlier entry-layer model `AGENTS → INDEX → rules/skills/workflows`, a compact bootstrap/re-read practice, and guidance to reread critical instructions at meaningful checkpoints and before high-risk repository operations.
- `.ai/archive/architecture/architectural-bottleneck-audit.md` records progressive activation as a meta-architectural constraint: activate additional semantic machinery only when needed.

The archive therefore confirms that activation/re-read and progressive activation were already investigated, but it does not by itself justify creating a new `ENTRY`, registry, router, or universal metadata layer.

## Current bounded research question

Investigate the smallest externally observable activation mechanism that can bridge:

    DISCOVER
        ↓
    ACTIVATE / REREAD
        ↓
    TRACE
        ↓
    EXECUTE
        ↓
    VERIFY

The working primitives are currently:

- **ACTIVATE** — establish the context required for the current operation, including actual reread of canonical owners;
- **REFRESH** — deliberately repeat activation during a long conversation or before a high-risk operation;
- **TRACE** — report the observable activation/execution/verification steps to the user.

These names are research vocabulary, not yet canonical architecture terms.

## Coverage questions

The next bounded test must check whether the three primitives are sufficient to cover:

1. a new chapter received through handoff;
2. initialization of a completely new specialization;
3. ordinary continuation work after the initial bootstrap;
4. deliberate reactivation in the middle of a long conversation;
5. mandatory canonical-owner reread before repository mutation.

For each case, distinguish:
- what context is supplied by the user/bootstrap;
- what must be discovered from the repository;
- what must actually be reread/activated;
- what TRACE can make observable;
- where a manual user trigger is still required.

## Immediate next task

Run the activation coverage experiment above before creating or changing any new architecture component. Compare the smallest workable forms of:

- handoff bootstrap instruction;
- general activation template for a new specialization;
- explicit refresh command or direct reference to an activation template;
- mini TRACE output.

Do not create `ENTRY.md`, a new workflow, registry/router, or command schema until the bounded cases demonstrate a concrete semantic or operational need.
