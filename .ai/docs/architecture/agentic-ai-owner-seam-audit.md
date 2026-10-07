# Agentic AI owner-by-seam audit

## Purpose

This document records the C0069 Phase 2 owner-by-seam audit.

The purpose is to test the Phase 2 environment matrix against the actual canonical owners in the active `.ai` architecture and determine whether any capability seam lacks a semantic owner.

This is an architecture verification artifact. It does not create a new runtime interface layer.

## Baseline

- Repository: `paulhuman/aip-mirror`
- Branch: `main`
- Chapter: C0069
- Phase: Phase 2 — Agentic environment compatibility
- Input survey: `.ai/docs/architecture/agentic-ai-environment-survey.md`
- Phase 1 audit: `.ai/docs/architecture/agentic-ai-compatibility-capability-audit.md`

## Canonical owner model

The active architecture establishes these boundaries:

| Semantic area | Canonical owner | Owner role |
|---|---|---|
| Routing / capability discovery | `.ai/INDEX.md` | identifies the semantic operation and canonical owner |
| Repository identity / path resolution / mutation safety | `.ai/rules/repository.md` | repository semantics and safe mutation contract |
| General workflow | `.ai/rules/workflow.md` | development workflow constraints |
| Lifecycle continuity | `.ai/rules/handoff/lifecycle.md` | chapter and handoff lifecycle semantics |
| Handoff reference preservation | `.ai/rules/handoff/references.md` | durable research-reference requirements |
| Commit policy | `.ai/rules/commits.md` | authorization and commit policy |
| Activation | `.ai/skills/activation/SKILL.md` | rereads canonical owners and establishes operational context |
| Reusable handoff capability | `.ai/skills/handoff/SKILL.md` | handoff/migration capability |
| Commit-message construction | `.ai/skills/commits/SKILL.md` | reusable commit-message construction |
| Normative-language activation | `.ai/skills/normative-language/SKILL.md` | activation entry point for normative-language semantics |
| Code explanation | `.ai/skills/explain-code/SKILL.md` | reusable explanation capability |
| Bootstrap procedure | `.ai/workflows/handoff/BOOTSTRAP.md` | ordered new-chapter initialization |
| Durable architecture context | `.ai/docs/architecture/` | research, rationale, historical architectural context; not an execution owner |
| Reusable architecture tests | `.ai/tests/scenarios/` | test definitions |
| Historical test evidence | `.ai/tests/results/` | per-run verification evidence |

## Seam-by-seam audit

### 1. Repository / project instruction discovery

**Environment capability:** Codex `AGENTS.md`, Claude Code `CLAUDE.md`/`AGENTS.md`, DeepSeek Harness `AGENTS.md`, Gemini `GEMINI.md`.

**Existing AIP Mirror owner:** The semantic content remains distributed across `.ai/rules/`, `.ai/skills/`, `.ai/workflows/`, and project routing.

**Result:** **COVERED.**

Environment-specific instruction filenames are entry/context mechanisms. They do not require a second AIP Mirror semantic owner.

**Adapter responsibility, if needed:** expose or point the environment's instruction-discovery mechanism at the existing canonical repository-local infrastructure.

### 2. Operation routing / invocation

**Environment capability:** slash commands, CLI commands, skill invocation, automation protocols, or other environment-owned invocation surfaces.

**Existing AIP Mirror owner:** `.ai/INDEX.md`.

INDEX explicitly separates invocation from semantic operation and routes the invocation to a canonical owner.

**Result:** **COVERED.**

The `>>` syntax is a current transport convention, not the semantic owner.

**Adapter responsibility, if needed:** translate an environment invocation into the operation vocabulary already routed by INDEX.

### 3. Reusable task capability

**Environment capability:** Agent Skills / Skills / skill registries / plugin-provided reusable capabilities.

**Existing AIP Mirror owner:** `.ai/skills/`.

The existing skills already use a portable instruction-package shape with YAML `name` and `description` metadata and a `SKILL.md` body.

**Result:** **COVERED.**

The survey found no missing semantic skill layer.

**Compatibility note:** environment-specific skill discovery may require metadata, location, or activation adapters. That is a packaging/discovery concern, not a new semantic owner.

### 4. Canonical semantic constraints

**Environment capability:** environment instructions, policies, hooks, tool constraints, or agent guidance.

**Existing AIP Mirror owner:** `.ai/rules/`.

Repository safety, workflow, lifecycle, references, commit policy, and normative-language semantics are already separated from transport syntax.

**Result:** **COVERED.**

No environment-specific rule namespace is justified by the current evidence.

### 5. Ordered procedure

**Environment capability:** agent workflow, automation sequence, slash command procedure, or task orchestration.

**Existing AIP Mirror owner:** `.ai/workflows/`.

BOOTSTRAP is the clearest current example: it owns the procedure while the invocation boundary remains outside the workflow.

**Result:** **COVERED.**

An environment may enter an existing workflow through a different transport without duplicating its steps.

### 6. Repository execution and mutation safety

**Environment capability:** filesystem, shell, Git, tool calls, sandbox, approval.

**Existing AIP Mirror owner:** `.ai/rules/repository.md` plus the applicable operation owner.

The repository rule already defines the observable mutation contract:

`READ → CHANGE → WRITE → READ BACK → VERIFY → DIFF → SCOPE → COMMIT → VERIFY RESULT`.

**Result:** **COVERED — strongly.**

This is one of the strongest transport-independent seams in the architecture.

The environment may provide authorization and execution mechanisms around this contract; it does not replace the contract.

### 7. Authorization / sandbox / policy

**Environment capability:** approval modes, sandbox boundaries, policy engines, permission presets.

**Existing AIP Mirror owner:** repository and operation semantics; environment authorization remains environment-owned.

**Result:** **COVERED without a new AIP Mirror semantic owner.**

Authorization answers whether an execution may occur. Repository rules answer how an allowed repository mutation MUST be performed and verified.

These concerns must not be conflated.

### 8. Session / chapter / continuity state

**Environment capability:** sessions, transcripts, resumability, compaction, worktrees, event streams.

**Existing AIP Mirror owner:** `.ai/rules/handoff/lifecycle.md` and `.ai/handoffs/`.

**Result:** **COVERED at the project semantic level.**

Environment session state is runtime context. AIP Mirror handoff state is durable chapter continuity. They are related but are not the same state model.

No transport-specific session owner is required.

### 9. Verification evidence

**Environment capability:** diffs, tool results, plans, events, transcripts, structured output, approval records.

**Existing AIP Mirror owners:** operation-specific rules/skills/workflows plus `.ai/tests/results/` for durable test evidence; activation/TRACE semantics are owned by `.ai/skills/activation/SKILL.md`.

**Result:** **COVERED, with one transport presentation edge.**

The underlying evidence concept is reusable. The current presentation contract has a `>>`-specific condition for operation-level TRACE.

This is an **adapter/presentation concern**, not a semantic verification gap.

### 10. Durable architecture evidence

**Environment capability:** external research, environment-specific observations, architectural comparisons.

**Existing AIP Mirror owner:** `.ai/docs/architecture/`.

**Result:** **COVERED.**

Architecture notes explicitly preserve reasoning and evidence without becoming runtime owners.

## Coverage matrix

| Seam | Existing owner | Transport dependency | Gap? | Likely future adapter |
|---|---|---:|---:|---|
| Instruction discovery | rules / skills / workflows | Medium | No | instruction/context mapping |
| Operation routing | `.ai/INDEX.md` | High | No | invocation adapter |
| Skills | `.ai/skills/` | Medium | No | discovery/metadata adapter |
| Rules | `.ai/rules/` | Low | No | none |
| Workflows | `.ai/workflows/` | Low–Medium | No | invocation adapter |
| Repository mutation | repository rule + operation owner | Low | No | execution wrapper |
| Authorization | environment-owned + repository contract | High | No | policy/approval wrapper |
| Session continuity | handoff lifecycle + environment session | Medium | No | state bridge only if required |
| Verification | operation owners + tests/results + activation | Medium | No | evidence/presentation adapter |
| Architecture research | `.ai/docs/architecture/` | Low | No | none |

## The actual gaps found

### Gap A — environment invocation adapter

There is currently no project artifact that defines how an external Agentic environment maps its native invocation surface to AIP Mirror operations.

**Classification:** potential future adapter concern, not a semantic-owner gap.

Do not create an interface directory solely for this observation. First demonstrate a concrete environment integration that needs a durable mapping artifact.

### Gap B — TRACE presentation outside `>>`

The current activation skill requires operation-level TRACE presentation when the user-facing invocation is a `>>` command.

An Agentic environment may have a different event/result surface.

**Classification:** presentation adaptation gap.

The underlying activation evidence remains reusable. A future transport may render the same evidence through its own native result/event mechanism.

### Gap C — skill packaging/discovery portability

The current `.ai/skills/` shape is already close to the cross-environment Agent Skills model, but discovery roots and activation mechanisms differ.

**Classification:** packaging/discovery compatibility question.

This should be tested with a concrete skill before adding metadata or duplicate skill copies.

## Negative findings

The audit found no evidence requiring:

- `.ai/interfaces/`;
- a second command registry;
- a second skill registry;
- environment-specific copies of canonical rules;
- environment-specific copies of workflows;
- a universal project meaning for `/`;
- a universal project meaning for `@`;
- an AIP Mirror-owned sandbox or approval system;
- an environment-owned replacement for `.ai/INDEX.md`.

## Architectural result

The owner-by-seam audit supports the following dependency direction:

`environment transport → adapter/context → existing AIP Mirror owner → environment execution capability → evidence`

Not:

`environment transport → duplicated semantic implementation`

The existing architecture therefore has **semantic coverage for every surveyed capability seam**.

The remaining work is compatibility validation at the adapter boundary, not expansion of semantic ownership.

## Phase 2 conclusion candidate

**Current status: PASS — semantic coverage confirmed; adapter boundaries remain to be validated.**

Phase 2 can be considered complete after:

1. preserving this audit as durable evidence;
2. recording the concrete adapter boundaries that Phase 3 must specify;
3. deciding whether a minimal transport-neutral compatibility convention is needed for skill discovery or TRACE evidence;
4. ensuring no proposed convention creates a second semantic owner.

Until those checks are performed, `.ai/interfaces/` remains unjustified.


## Chapter continuity

The current durable chapter checkpoint is maintained in:

- `.ai/handoffs/C/C0069-Architecture-&-Research.md`

Future chapters continuing this research SHOULD read that handoff as the current chapter continuity snapshot before relying on this architecture note alone.
