# 03AU — AI Infrastructure Restructuring Working Notes

Status: Durable migration context / Iteration 2 — updated through 03BA
Specialization: 03 — Architecture & Research
Scope: `.ai` infrastructure, repository entry points, semantic ownership, restructuring, verification

## 1. Purpose

This file preserves the durable reasoning, decisions, and current architecture of Iteration 2. It is an architecture/research artifact, not a generic rule file.

Its purpose is to prevent later chapters from reconstructing important decisions from conversation history.

The central Iteration 2 boundary is:

> If the primary subject is how AI should work with the project, it belongs in `.ai/`. If the primary subject is what AIP Mirror is or how it works, it belongs in `docs/`.

This is a practical ownership boundary.

## 2. Semantic decomposition model

Candidate document content is classified independently by:

- **MOVE** — correct semantic kind, wrong location;
- **RENAME** — correct semantic kind and location family, but obsolete/non-semantic naming;
- **DECOMPOSE** — multiple semantic responsibilities have been combined;
- **ARCHIVE** — useful historical evidence that is no longer active infrastructure;
- **REMOVE** — redundant content already represented by a canonical owner.

Semantic kinds used by Iteration 2:

- RULE = what must be true;
- SKILL = reusable capability;
- WORKFLOW = ordered procedure;
- README = orientation/navigation;
- PROJECT DOC = AIP Mirror-specific knowledge.

Do not create a file merely because a semantic unit can be named. A new file needs a stable subject, an owner, independent usefulness, and enough coherence to justify its existence.

## 3. Accepted infrastructure boundary

The active conceptual structure is:

```text
.ai/
├── config.yaml
├── INDEX.md
├── AGENTS.md
├── rules/
│   ├── repository.md
│   ├── workflow.md
│   └── handoff/
│       ├── lifecycle.md
│       └── references.md
├── skills/
│   ├── commits/
│   └── handoff/
├── workflows/
│   ├── handoff/
│   │   └── BOOTSTRAP.md
│   └── independent-review/
├── handoffs/
│   └── <specialization>/
├── architecture/
└── archive/

docs/
└── AIP Mirror project knowledge

references/
└── AIP Mirror-specific reference material
```

The important boundary is:

- `.ai/` = AI working infrastructure;
- `docs/` = AIP Mirror project knowledge;
- root `references/` = AIP Mirror-specific reference material.

The `.ai` layer is intended to remain project-agnostic. Generic rules, skills, and workflows must not quietly acquire AIP Mirror-specific assumptions, examples, paths, or product semantics.

## 4. Entry-layer architecture

The current entry architecture is deliberately layered:

```text
README.md
    = human repository orientation

.ai/AGENTS.md
    = compact always-on AI operating contract

.ai/INDEX.md
    = command routing + capability discovery

.ai/rules/
    = canonical semantic constraints

.ai/skills/
    = reusable capabilities

.ai/workflows/
    = ordered procedures
```

The operational routing model is:

```text
user command
    ↓
.ai/INDEX.md
    ↓
operation identification
    ↓
reread canonical owner files
    ↓
execute owning rule / skill / workflow
```

The architectural boundary is:

> **INDEX identifies and routes; canonical owners define and execute.**

`INDEX.md` must not become a second lifecycle rule, handoff skill, commit skill, bootstrap workflow, repository rule, or general workflow document.

A separate `ENTRY.md` is not part of Iteration 2. Its creation is deferred to a future iteration only if new evidence justifies it.

## 5. Current `.ai/INDEX.md` model

03BA implemented `.ai/INDEX.md` as an operational command router and capability-discovery surface.

Each command entry currently identifies:

1. current user-facing command phrase;
2. semantic operation;
3. canonical owner;
4. required reread targets;
5. whether repository state may change;
6. whether the operation normally produces a commit.

The `Commit` field is routing metadata only. It does not authorize a commit and does not define commit construction. Commit policy remains owned by the canonical commit rule/skill.

The currently documented user-facing handoff commands are:

1. `Пора обновить handoff`
2. `Пора выполнить миграцию в чат XXYY`
3. `Пора восстановить handoff`
4. `Пора выполнить handoff lifecycle correction`
5. `Пора выдать bootstrap-инструкцию`

Exact future command IDs and command syntax are intentionally **not frozen**.

### 5.1 Current routing semantics

| Command | Semantic operation | Canonical owner | Reread | Repository state | Commit |
|---|---|---|---|---|---|
| `Пора обновить handoff` | checkpoint current chapter | handoff skill + lifecycle | lifecycle; handoff skill; current handoff | Yes; lifecycle remains `DRAFT` | Yes — checkpoint commit |
| `Пора выполнить миграцию в чат XXYY` | migration of current chapter | handoff skill + lifecycle; bootstrap workflow for generated instruction | lifecycle; handoff skill; bootstrap workflow | Yes; closing handoff may move `DRAFT → READY_FOR_HANDOFF`; bootstrap instruction is separate | Yes — migration commit |
| `Пора восстановить handoff` | Lifecycle Recovery | lifecycle rule | lifecycle; commit rule/skill when a write is required | Yes; bounded recovery | Yes, if recovery changes repository state |
| `Пора выполнить handoff lifecycle correction` | historical Lifecycle Correction | lifecycle rule | lifecycle; commit rule/skill | Yes; bounded correction | Yes — explicit correction commit |
| `Пора выдать bootstrap-инструкцию` | generate bootstrap instruction for future receiving chapter | handoff skill + bootstrap workflow | handoff skill; bootstrap workflow | No lifecycle change | No |

The table is routing metadata, not a procedural specification.

### 5.2 Critical distinction

The architecture explicitly separates:

```text
HANDOFF STATE
    ≠
HANDOFF OPERATION
    ≠
HANDOFF COMMIT
```

For example:

```text
checkpoint
    ↓
DRAFT → DRAFT
    ↓
repository content changes
    ↓
checkpoint commit
```

Migration is distinct:

```text
migration
    ↓
closing handoff: DRAFT → READY_FOR_HANDOFF
    ↓
migration commit
    ↓
bootstrap instruction
```

The receiving chapter later performs:

```text
READY_FOR_HANDOFF → HANDED_OFF
```

Therefore migration must not be represented as completing the receiving chapter's lifecycle.

Recovery and Correction remain distinct exceptional operations. They are not currently collapsed into a generic `fix` command.

Bootstrap-instruction generation is not itself a lifecycle operation. It does not create the receiving chapter, change lifecycle state, or commit repository state.

## 6. Canonical ownership

Current canonical ownership is:

```text
.ai/config.yaml
    → project repository identity/configuration facts

.ai/rules/repository.md
    → repository interpretation, path resolution, boundaries,
      taxonomy/hygiene, durable repository knowledge, write safety

.ai/rules/workflow.md
    → generic workflow principles

.ai/rules/handoff/lifecycle.md
    → handoff lifecycle semantics and exceptional lifecycle operations

.ai/rules/handoff/references.md
    → durable handoff reference preservation rules

.ai/skills/handoff/SKILL.md
    → reusable handoff capability and handoff operations

.ai/skills/commits/SKILL.md
    → reusable commit construction

.ai/rules/commits.md
    → commit policy

.ai/workflows/handoff/BOOTSTRAP.md
    → ordered receiving-chapter bootstrap procedure

.ai/INDEX.md
    → routing and capability discovery only
```

Other `.ai` rules, skills, and workflows consume these canonical definitions rather than redefining them.

## 7. Handoff lifecycle

The active lifecycle is exactly:

```text
DRAFT
  ↓
READY_FOR_HANDOFF
  ↓
HANDED_OFF
```

`SUPERSEDED` is not part of the handoff lifecycle.

Lifecycle, operation, and commit remain separate dimensions. This distinction is intentionally preserved for later operation-vocabulary and commit-vocabulary analysis.

## 8. BOOTSTRAP decision in 03BA

03BA compared the new INDEX routing model with the residual semantics of the bootstrap procedure.

The residual BOOTSTRAP semantics remain independently useful because they are sequence-dependent:

```text
runtime inputs
    ↓
repository initialization
    ↓
capability detection
    ↓
shared bootstrap steps
    ↓
write/read-only branch
    ↓
receiving handoff initialization
    ↓
lifecycle handling
    ↓
post-bootstrap consistency verification
```

INDEX can route to this workflow but cannot replace its ordered procedure without becoming a second workflow owner.

Therefore the BOOTSTRAP workflow is retained at:

`.ai/workflows/handoff/BOOTSTRAP.md`

The old path:

`.ai/workflows/handoff-bootstrap/BOOTSTRAP.md`

was removed.

This was an organizational path correction, not a change of BOOTSTRAP semantics.

Duplicated canonical material was removed from BOOTSTRAP where ownership had already moved to canonical rules/skills. In particular, migration completion remains owned by `handoff/SKILL.md` rather than being duplicated in the bootstrap workflow.

## 9. Major Iteration 2 restructuring completed

The following active locations are established:

```text
docs/architecture/independent-review-{grok,qwen,deepseek}-onboarding.md
    → .ai/workflows/independent-review/

.ai/rules/conversation-lifecycle.md
    → .ai/rules/handoff/lifecycle.md

.ai/rules/handoff-references.md
    → .ai/rules/handoff/references.md

.ai/skills/conversation-handoff/SKILL.md
    → .ai/skills/handoff/SKILL.md

.ai/skills/conversation-handoff/BOOTSTRAP.md
    → .ai/workflows/handoff/BOOTSTRAP.md

.ai/skills/handoff-reference-preservation/SKILL.md
    → .ai/skills/handoff/reference-preservation/SKILL.md

docs/handoffs/
    → .ai/handoffs/<specialization>/
```

The handoff tree is grouped by specialization directories such as `02/`, `03/`, `04/`, `05/`, and `06/`.

These moves were followed by semantic decomposition and consistency verification rather than being treated as purely physical refactoring.

## 10. Repository-rule consolidation

Repository configuration and repository rules have separate ownership:

- `.ai/config.yaml` owns repository identity/configuration facts;
- `.ai/rules/repository.md` owns repository interpretation and path resolution;
- `.ai/rules/repository.md` owns repository boundaries and taxonomy/hygiene;
- `.ai/rules/repository.md` owns repository-facing durable knowledge;
- `.ai/rules/repository.md` owns repository write safety.

The canonical mutation sequence remains:

```text
READ CURRENT FILE
    ↓
minimal intended change
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
```

Commit policy and construction remain separate canonical concerns.

## 11. Post-edit semantic consistency sweep

Iteration 2 established that changing one canonical owner can leave stale dependencies elsewhere.

Therefore any move, rename, decomposition, or canonical-ownership change requires a post-edit semantic consistency sweep.

The pattern is:

```text
EDIT
  ↓
verify edited file
  ↓
search old ownership / paths / terminology
  ↓
classify every relevant hit semantically
  ↓
repair stale dependencies
  ↓
read back
  ↓
diff + scope verification
  ↓
commit
  ↓
verify result
```

The sweep is semantic, not a demand to reread every repository file.

Minimum search targets include:

- old file paths;
- old canonical-owner references;
- moved/renamed filenames;
- duplicated normative wording;
- removed lifecycle states/concepts;
- obsolete chapter/specialization identifiers;
- stale bootstrap instructions;
- stale links/routing.

A textual match is not automatically an ownership violation. Each hit must be classified according to whether it is active, historical, archival, descriptive, or genuinely stale.

## 12. Progressive disclosure / Minimum Sufficient Execution Context

The intended loading model is:

```text
Always-on
    ↓
AGENTS.md

User command
    ↓
INDEX.md

Operation selected
    ↓
canonical owner(s)

Execution detail
    ↓
skill / workflow

Semantic constraint
    ↓
rule
```

The goal is not merely fewer files. The goal is a repository whose surviving instructions agree, so that a new conversation does not have to reconstruct architecture from stale or contradictory context.

INDEX must therefore provide enough routing metadata to activate the correct canonical capability, but must not become a dependency graph or a duplicate procedural layer.

## 13. Current dependency direction

The intended direction is:

```text
config facts
    ↓
canonical rules
    ↓
reusable skills
    ↓
ordered workflows
    ↓
repository operation
```

`INDEX.md` sits above these as routing/discovery rather than as a semantic owner:

```text
user command
    ↓
INDEX
    ↓
canonical rule / skill / workflow
    ↓
execution
```

Avoid reciprocal dependencies that turn one file into an accidental aggregation point.

Project-specific facts may be referenced from `.ai` when necessary, but generic infrastructure must not absorb project knowledge that belongs in `docs/`.

## 14. Iteration 2 discovery method

The durable restructuring method is:

```text
inventory
   ↓
classify semantic ownership
   ↓
establish canonical owner
   ↓
MOVE / RENAME / DECOMPOSE / ARCHIVE / REMOVE
   ↓
post-edit consistency sweep
   ↓
verify repository coherence
   ↓
commit
   ↓
continue
```

A successful edit alone is insufficient evidence of architectural consistency.

## 15. Current status after 03BA

Completed:

- physical Iteration 2 restructuring;
- Repository Identity & Path Resolution ownership pass;
- lifecycle cleanup to `DRAFT → READY_FOR_HANDOFF → HANDED_OFF`;
- `.ai/AGENTS.md` as compact always-on operating contract;
- `.ai/INDEX.md` as operational command router and capability-discovery surface;
- five current user-facing handoff command routes;
- explicit separation of state, operation, and commit metadata in INDEX;
- BOOTSTRAP residual-core analysis;
- retention of BOOTSTRAP as an independent ordered workflow;
- BOOTSTRAP move to `.ai/workflows/handoff/BOOTSTRAP.md`;
- active path/reference consistency sweep after the BOOTSTRAP move.

Current entry-layer model:

```text
ENTRY LAYER
    ↓
INDEX COMMAND SURFACE
    ↓
CANONICAL CAPABILITY / OWNER
    ↓
EXECUTION
```

## 16. Independent architecture review checkpoint

The current INDEX architecture is intentionally being treated as a reviewable hypothesis rather than as permanently frozen architecture.

Grok and Qwen are to independently review the **current repository state** after rereading the current `.ai` infrastructure. They should not reconstruct previous chapters from conversation history or rely on stale onboarding assumptions.

The review should test, in particular:

- whether INDEX contains sufficient routing metadata without becoming another owner;
- whether `AGENTS.md → INDEX.md → canonical owners` is a clean boundary;
- whether command, operation, lifecycle state, and commit remain distinct;
- whether all five current handoff commands route correctly;
- whether BOOTSTRAP remains independently justified as an ordered workflow;
- whether the new paths and ownership model are internally consistent;
- whether the `.ai` layer remains project-agnostic;
- whether progressive disclosure actually reduces active context rather than moving complexity around.

The reviewers must provide criticism and concrete evidence. They must not modify repository files during the review.

This review is a validation checkpoint for the current entry-layer design, not permission to restart physical Iteration 2 restructuring.

## 17. Remaining open questions

Do not silently resolve the following before review/evidence:

- exact command IDs and final command syntax;
- exact command-entry/fragment ID conventions;
- complete handoff operation vocabulary;
- final operation-to-commit mapping and hard-MUST commit vocabulary;
- long-term handoff retention/archive policy;
- exact long-term `.ai/architecture/` taxonomy;
- whether any remaining mixed rule files require another decomposition pass;
- whether future evidence justifies a separate `ENTRY.md` layer.

The fate of `.ai/workflows/handoff/BOOTSTRAP.md` is **no longer open in Iteration 2**: 03BA established that it remains a canonical ordered workflow at that path. It should only be reconsidered if independent review produces concrete contradictory evidence.

## 18. Deferred experiments

### Handoff Content Extraction Test

Take a real handoff and classify every content unit, then test whether project knowledge can be moved to canonical project documentation while leaving a bounded conversation-state artifact.

### Iteration 3 Entry-Layer Test

Revisit whether the existing `INDEX.md` is sufficient as the long-term discovery/routing surface or whether a separate entry document has a justified role. Current Iteration 2 position: no `ENTRY.md`.

## 19. Migration note

The current architecture state is represented by this file and the current `.ai` tree. Future chapters must start from the current repository state rather than reconstructing 03AU–03BA from conversation history.

The next architecture/research chapter should treat the independent Grok/Qwen review as evidence against the current model, not as an invitation to redesign the entire infrastructure without evidence.
