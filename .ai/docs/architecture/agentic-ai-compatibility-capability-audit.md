# Existing .ai architecture capability audit

## Purpose

This document records the Phase 1 audit for C0068 — Agentic AI compatibility architecture research.

Research objective:

> Determine whether the existing .ai architecture can support multiple AI-environment transport interfaces without duplicating semantic ownership, and identify the minimal architecture required for Agentic AI compatibility.

This audit evaluates the current main repository state only. It does not redesign the active .ai architecture.

## Baseline

- Repository: paulhuman/aip-mirror
- Canonical branch: main
- Audited main revision: 49219bca289291f03135ae549f9ba5995c95c446
- Current chapter: C0068
- Previous chapter: C0067
- Specialization: C — Architecture & Research
- Phase 0 research plan: .ai/docs/architecture/agentic-ai-compatibility-architecture.md
- C0067 runtime evidence: .ai/tests/results/cold-start-command-trace/20261005-2054-c0067-five-command-runtime.md

The current .ai architecture was inspected from repository contents, not reconstructed from conversation memory.

## Phase 0 — branch hygiene finding

The repository currently contains 39 remote branches: main plus 38 non-main branches.

The non-main branch names are all historical audit, migration-test, runtime-test, fixture, or temporary-work branches. No ordinary active feature branch was identified by branch naming.

| Branch | Observed state relative to main | Interpretation |
|---|---|---|
| audit-c0067-command-trace-20261005 | diverged; 2 commits ahead, 17 behind | historical disposable audit branch |
| migration/handoff-one-based | heavily diverged; 192 commits ahead, 209 behind | historical migration/restructuring branch |
| test/c0061-case1-runtime-active | diverged; 2 commits ahead, 62 behind | disposable runtime fixture |
| test/migration-recovery-case3-contradiction | diverged; 2 commits ahead, 34 behind | disposable recovery fixture |
| test/migration-recovery-case3-malformed | diverged; 1 commit ahead, 34 behind | disposable recovery fixture |
| test/migration-recovery-case4-mismatch | behind; 0 commits ahead, 31 behind | stale test branch |
| tmp-* | share an old temporary-work tip | historical temporary branches |

The available GitHub repository interface provides branch discovery, ref creation/update, and read/compare operations, but no branch-delete operation. Therefore remote branch deletion cannot be completed through the available repository interface in this chapter.

The branches MUST NOT be force-moved to main as a substitute for deletion.

### Phase 0 exit status

**PARTIAL — baseline verified; branch deletion deferred because the available repository interface has no branch-delete capability.**

## Phase 1 — current architecture audit

### 1. Operational routing

**Canonical owner:** .ai/INDEX.md

Observed model:

    user command
        ↓
    .ai/INDEX.md
        ↓
    operation identification
        ↓
    canonical owner reread / ACTIVATE
        ↓
    canonical operation

INDEX explicitly defines itself as a router and discovery surface, not as a rule, skill, or workflow owner.

The current command table maps user-facing >> phrases to semantic operations and canonical owners.

**Transport dependency:** The current documented invocation surface is explicitly >>-based.

**Reuse potential:** High.

The semantic operation is already separated from the command phrase: INDEX states that the command phrase is an invocation signal, not the procedure itself.

**Evidence:** .ai/INDEX.md.

### 2. Rules

**Canonical owner:** .ai/rules/

Observed active rule families include workflow, repository, commits, handoff lifecycle, handoff reference preservation, and normative language.

Rules define constraints and semantics independently of the >> command syntax.

**Transport dependency:** None observed in the rule semantics audited.

**Reuse potential:** High.

Repository write safety, documentation durability, lifecycle semantics, and commit policy are not defined as chat-command behavior.

**Evidence:** .ai/rules/repository.md, .ai/rules/workflow.md, .ai/rules/commits.md, .ai/rules/handoff/lifecycle.md, .ai/rules/handoff/references.md, .ai/rules/normative-language.md.

### 3. Skills

**Canonical owner:** .ai/skills/

Observed skills include activation, handoff, commits, deep-understanding, explain-code, and normative-language.

The activation skill establishes canonical operational context by rereading owner files. Its boundary is:

    INDEX / caller
        ↓
    ACTIVATE
        ↓
    canonical owner
        ↓
    operation

The activation procedure does not itself depend on >>. The >> requirement appears in the presentation contract for user-facing command TRACE.

**Transport dependency:** Low.

**Reuse potential:** High.

**Evidence:** .ai/skills/activation/SKILL.md.

### 4. Workflows

**Canonical owner:** .ai/workflows/

The principal current workflow is .ai/workflows/handoff/BOOTSTRAP.md.

BOOTSTRAP owns the ordered new-chapter initialization procedure and explicitly separates the entry path from the workflow.

    new conversation
        ↓
    .ai/AGENTS.md
        ↓
    new-chapter initialization requested?
        ↓
    AGENTS item 6
        ↓
    BOOTSTRAP workflow

**Transport dependency:** The entry boundary is chat-oriented, but the substantive bootstrap procedure is not a definition of >> command semantics.

**Reuse potential:** High for operational procedure; medium for the entry/transport boundary.

**Evidence:** .ai/workflows/handoff/BOOTSTRAP.md.

### 5. Repository mutation safety

**Canonical owner:** .ai/rules/repository.md

Observed safety contract:

    READ CURRENT FILE
        ↓
    MAKE MINIMAL CHANGE
        ↓
    WRITE COMPLETE FILE
        ↓
    READ BACK
        ↓
    VERIFY CONTENT
        ↓
    INSPECT DIFF
        ↓
    VERIFY SCOPE
        ↓
    COMMIT
        ↓
    VERIFY RESULT

This contract is repository-operation semantics rather than chat transport semantics.

It also defines disposable repository fixture construction from known commit SHAs, which is directly relevant to future Agentic proof-of-concept work.

**Transport dependency:** None observed.

**Reuse potential:** Very high.

**Evidence:** .ai/rules/repository.md.

### 6. Verification and TRACE

**Canonical owner:** .ai/skills/activation/SKILL.md for activation/TRACE presentation semantics, with operation-specific verification owned by the applicable rules, skills, and workflows.

The TRACE contract distinguishes canonical owners reread for ACTIVATE, additional repository files actually read, deduplication, and completed-operation evidence.

The key transport-specific element is the requirement that operation-level TRACE be inserted for a user-facing >> command whose routing requires ACTIVATE.

This is evidence that the current TRACE presentation trigger is transport-specific, while the underlying read-set and activation evidence are more general.

**Transport dependency:** Presentation trigger is >>-specific; activation/read-set semantics are transport-independent.

**Reuse potential:** High for the underlying verification model; another transport may need a different presentation adapter.

**Evidence:** .ai/skills/activation/SKILL.md.

## Evidence summary

| Area | Current owner | Transport dependency | Reuse potential | Evidence |
|---|---|---|---|---|
| operation routing | .ai/INDEX.md | current invocation table uses >> | High | INDEX separates invocation from semantic operation |
| rules | .ai/rules/ | none observed | High | rule files contain transport-neutral constraints |
| skills | .ai/skills/ | low; TRACE presentation has >> | High | activation establishes owner context independently |
| workflows | .ai/workflows/ | entry boundaries may be chat-specific | High | BOOTSTRAP owns procedure, not command syntax |
| repository mutation safety | .ai/rules/repository.md | none observed | Very high | explicit mutation/verification contract |
| verification / TRACE | .ai/skills/activation/SKILL.md + operation owners | TRACE presentation partly >>-specific | High | evidence model is separable from presentation |

## Key Phase 1 findings

### Finding 1 — semantic ownership is already separated from command syntax

The strongest architectural evidence is the existing INDEX boundary:

    invocation
        ↓
    semantic operation
        ↓
    canonical owner
        ↓
    activation context

This is substantially compatible with multiple transport interfaces.

### Finding 2 — the current >> surface is a transport convention, not the semantic owner

The documented >> commands identify operations, but their procedures live in rules, skills, and workflows.

This means replacing or supplementing the invocation surface does not inherently require duplicating the underlying operation.

### Finding 3 — verification has one transport-specific presentation edge

The activation skill attaches mandatory TRACE presentation to user-facing >> commands.

This does not prove that Agentic environments require a second verification system. It indicates a likely future adapter question: how should the same activation/read-set evidence be surfaced in an Agentic environment?

### Finding 4 — repository safety is already transport-neutral

The repository write-safety contract is particularly suitable for Agentic execution because it already describes an observable sequence of read, write, readback, diff, scope, commit, and result verification.

### Finding 5 — no .ai/interfaces/ layer is currently justified by Phase 1 alone

The audit found no existing semantic duplication that requires an interface layer.

A future interface layer MAY still be useful, but its necessity MUST be established by Phase 2 environment evidence rather than assumed now.

## Gate 1 result

**PASS.**

The existing architecture can be described without introducing a second semantic source of truth.

The current evidence supports continuing to Phase 2 — Agentic environment survey.

This is a research finding, not an implementation decision.

## Confirmed / observed

- .ai/INDEX.md is explicitly a router/discovery surface rather than a semantic owner.
- Current user-facing command entries use >>.
- Canonical rules, skills, and workflows own the substantive procedures.
- Activation rereads current canonical owners before operation execution.
- Repository mutation safety is explicitly transport-neutral.
- TRACE contains a transport-specific presentation condition for >> commands.
- C0067's five-command runtime audit provides current runtime evidence for the existing command surface.

## Inferred

- A second AI-environment transport can probably target the existing semantic operations without duplicating their procedures.
- A future Agentic transport adapter, if needed, is more likely to be a routing/presentation boundary than a second semantic owner.

These are inferences and MUST be validated against real Agentic environment behavior.

## Assumptions / unverified

- Agentic environments can consume enough of the current repository-local infrastructure to reach the same canonical owners.
- Agentic command syntaxes such as / can be mapped cleanly to the same semantic operation vocabulary.
- Agentic environment handling of @ is compatible with keeping it environment-specific.

These remain unverified until Phase 2.

## Open questions for Phase 2

1. Which Agentic environments automatically discover repository-local instruction files?
2. Which support a reusable skill abstraction?
3. What do / and @ actually mean in each environment?
4. Can environment-specific commands map to project-defined semantic operations without duplicating procedures?
5. How are tool execution, repository writes, confirmation, and verification exposed?
6. Can the existing repository safety contract be enforced naturally in each environment?
7. How should activation evidence and TRACE be represented outside the current chat response model?
8. Does any environment require a real transport/interface layer, or is instruction/routing guidance sufficient?

## Phase 1 conclusion

The current .ai architecture is **promisingly transport-independent at its semantic core**.

The architecture already contains the most important separation required by the hypothesis:

    transport / invocation
            ↓
    semantic operation
            ↓
    canonical rules / skills / workflows
            ↓
    repository execution
            ↓
    verification

However, Phase 1 alone cannot establish Agentic compatibility. Phase 2 must test whether real Agentic environments can actually enter and execute this structure without introducing environment-specific semantic duplication.

## Chapter continuity

The current durable chapter checkpoint is maintained in:

- `.ai/handoffs/C/C0069-Architecture-&-Research.md`

Future chapters continuing this research SHOULD read that handoff as the current chapter continuity snapshot before relying on this architecture note alone.
