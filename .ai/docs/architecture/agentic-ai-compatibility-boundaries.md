# Agentic AI compatibility boundaries — skill portability and evidence model

## Purpose

This document records the concrete Phase 2 compatibility test performed against an existing AIP Mirror skill and defines the smallest transport-neutral evidence model justified by that test.

It is an architecture verification artifact. It does not create a runtime interface layer and does not replace any canonical rule, skill, workflow, or routing owner.

## Baseline

- Repository: `paulhuman/aip-mirror`
- Branch: `main`
- Chapter: C0069
- Phase: Phase 2 — Agentic environment compatibility
- Tested skill: `.ai/skills/activation/SKILL.md`
- Related architecture evidence:
  - `.ai/docs/architecture/agentic-ai-environment-survey.md`
  - `.ai/docs/architecture/agentic-ai-owner-seam-audit.md`

## Concrete skill portability test

### Existing package shape

The tested skill has:

1. a YAML front matter block with `name` and `description`;
2. a Markdown instruction body;
3. no required executable script or bundled asset;
4. references to repository-local canonical owners.

This is directly compatible with the common Agent Skills package shape documented by OpenAI: a skill is a directory containing `SKILL.md` with `name` and `description`, with optional references, scripts, templates, and assets. OpenAI's current skill discovery can expose the metadata first and load the full `SKILL.md` when the skill is selected.

### Portability result

**PASS — package semantics are portable; discovery and context are environment-specific.**

The tested skill can be represented as a standard Agent Skill without changing its core instruction package:

```
activation/
└── SKILL.md
```

However, the skill is intentionally **not standalone**. Its instructions depend on AIP Mirror repository semantics such as:

- `.ai/rules/repository.md`;
- `.ai/rules/workflow.md`;
- canonical operation owners;
- repository-relative `.ai/...` paths.

Therefore portability means:

> the skill package can be transported and discovered by an Agent Skills-compatible environment while retaining AIP Mirror semantic ownership in the repository.

It does **not** mean:

> the skill can be copied into another environment and executed correctly without the AIP Mirror repository context.

This distinction is desirable.

### What the environment must adapt

A future environment adapter may need to provide:

| Concern | Environment responsibility | AIP Mirror responsibility |
|---|---|---|
| Discovery root | expose the skill directory through its native skill mechanism | keep canonical skill content in `.ai/skills/` |
| Metadata loading | read `name` / `description` | define the authoritative metadata |
| Full instruction loading | load `SKILL.md` when selected | define the skill procedure |
| Repository context | establish the correct repository/workspace | define repository-relative semantics |
| Canonical-owner reads | provide filesystem/tool access | define which owners MUST be read |
| Invocation | translate native invocation to skill/operation selection | keep semantic operation independent of syntax |

No additional semantic registry is required by this test.

### Negative result

The test provides no evidence for:

- copying skills into an environment-specific `.ai` subtree;
- adding a second AIP Mirror skill registry;
- adding environment-specific copies of `SKILL.md`;
- creating `.ai/interfaces/`;
- making `/`, `@`, or another punctuation convention part of skill semantics.

## Transport-neutral evidence model

The second Phase 2 question is whether the current TRACE concept can survive outside a chat response.

The answer is **yes, if TRACE is treated as presentation rather than the evidence model itself**.

The smallest reusable evidence record is:

```text
operation
  identity
  status

activation
  canonical owners
  activation status

reads
  repository files actually read

execution
  environment/tool actions relevant to the operation

verification
  observed result
  scope/diff/result evidence

authorization
  environment approval/policy state, when applicable

artifacts
  durable result references, when applicable
```

Not every operation needs every field.

### Required distinction

The semantic evidence is:

```
operation + activation + reads + execution + verification
```

The transport-specific presentation is:

```
chat TRACE
CLI output
event stream
structured result
session record
test result artifact
```

Therefore the existing `.ai/skills/activation/SKILL.md` TRACE presentation contract can remain unchanged for the current `>>` transport while future environments render equivalent evidence through their own result surfaces.

### Repository mutation evidence

For operations that mutate the repository, the evidence model MUST remain compatible with the existing repository safety contract:

```
READ
  ↓
CHANGE
  ↓
WRITE
  ↓
READ BACK
  ↓
VERIFY
  ↓
DIFF
  ↓
SCOPE
  ↓
COMMIT
  ↓
VERIFY RESULT
```

The environment may add approval or sandbox evidence around this sequence, but it must not replace the repository mutation contract.

## Minimal adapter contract

The Phase 2 evidence now supports the following minimal adapter boundary:

```
environment transport
    ↓
invocation / context adapter
    ↓
existing AIP Mirror semantic owner
    ↓
environment execution capability
    ↓
transport-neutral evidence
    ↓
environment-native presentation
```

The adapter is responsible only for translation between environment capabilities and existing AIP Mirror owners.

It MUST NOT become a second owner of:

- routing semantics;
- rules;
- skills;
- workflows;
- repository mutation safety;
- lifecycle semantics;
- verification semantics.

## Phase 2 decision

The concrete skill portability test and evidence-model test do **not** reveal a missing semantic layer.

They establish two bounded compatibility requirements for Phase 3:

1. **Skill discovery adapter:** map environment-native discovery/invocation to the existing `.ai/skills/` packages without duplicating them.
2. **Evidence adapter:** map the reusable evidence record to the environment's native result/event presentation without changing canonical verification semantics.

These are adapter specifications, not a new `.ai` semantic namespace.

**Decision: no `.ai/interfaces/` directory is justified by the completed Phase 2 evidence.**

## Phase 3 input

Phase 3 SHOULD specify only:

- the invocation/context adapter boundary;
- the skill discovery/packaging mapping;
- the transport-neutral evidence fields;
- the mapping of repository mutation verification into environment-native evidence;
- the minimum conformance test needed to prove that an environment preserves the existing semantic owners and repository safety contract.

No implementation of a universal transport layer is required by the current evidence.
