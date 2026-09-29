# AI Infrastructure Restructuring Working Notes

Status: Durable architecture context / Iteration 2 and current entry-layer architecture
Scope: `.ai` infrastructure, repository entry points, semantic ownership, restructuring, verification

## 1. Purpose

This file preserves durable reasoning, decisions, open questions, and current architecture for Iteration 2. It is an architecture/research artifact, not a generic rule file.

Its purpose is to prevent later chapters from reconstructing important decisions from conversation history.

Central boundary:

> If the primary subject is how AI should work with the project, it belongs in `.ai/`. If the primary subject is what AIP Mirror is or how it works, it belongs in `docs/`.

## 2. Semantic decomposition model

Candidate document content is classified independently as:

- **MOVE** — correct semantic kind, wrong location;
- **RENAME** — correct semantic kind and location family, but obsolete/non-semantic naming;
- **DECOMPOSE** — multiple semantic responsibilities have been combined;
- **ARCHIVE** — useful historical evidence that is no longer active infrastructure;
- **REMOVE** — redundant content already represented by a canonical owner.

Semantic kinds:

- RULE = what must be true;
- SKILL = reusable capability;
- WORKFLOW = ordered procedure;
- README = orientation/navigation;
- PROJECT DOC = AIP Mirror-specific knowledge.

Do not create a file merely because a semantic unit can be named. A new file needs a stable subject, an owner, independent usefulness, and enough coherence to justify its existence.

## 3. Accepted infrastructure boundary

```text
.ai/
├── config.yaml
├── INDEX.md
├── AGENTS.md
├── rules/
│   ├── repository.md
│   ├── workflow.md
│   ├── commits.md
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

The `.ai` layer is intended to be reusable across projects. Generic rules, skills, and workflows must not quietly acquire AIP Mirror-specific assumptions, examples, paths, or product semantics.

### 3.1 Project-specific configuration boundary

Project-specific configuration is intentionally concentrated in `.ai/config.yaml` rather than being repeated throughout `.ai/rules/`, `.ai/skills/`, and `.ai/workflows/`.

This is an explicit portability strategy:

```text
.ai infrastructure
    = generic rules / skills / workflows

.ai/config.yaml
    = current project's configurable identity, references, and vocabulary
```

For AIP Mirror, `config.yaml` contains repository identity, external reference repositories, commit scopes, and project terminology.

This is **intentional project-specific configuration ownership**, not configuration leakage. It gives future projects a single configuration locus to replace or regenerate while keeping generic infrastructure portable.

The presence of project-specific state elsewhere in `.ai` (for example handoffs or architecture notes) does not contradict this boundary: those are project state/research artifacts, not generic infrastructure configuration.

Do not move `commit_scopes`, `project_terms`, or similar values out of `config.yaml` merely to make the file look more project-agnostic. The relevant portability question is whether generic rules/skills/workflows remain free of embedded project-specific assumptions.

## 4. Entry-layer architecture

The current Iteration 2 entry architecture is:

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

Operational routing:

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

Architectural boundary:

> **INDEX identifies and routes; canonical owners define and execute.**

`INDEX.md` must not become a second lifecycle rule, handoff skill, commit skill, bootstrap workflow, repository rule, or general workflow document.

No `ENTRY.md` exists in Iteration 2.

### 4.1 Future ENTRY concept — intentionally deferred

A future `ENTRY.md` may be justified if evidence shows that the repository needs a distinct **AI entry/initialization layer** above command routing.

If introduced, its semantic role should be different from both `INDEX.md` and `BOOTSTRAP.md`:

```text
.ai/ENTRY.md
    = how a new AI enters and activates the infrastructure

.ai/INDEX.md
    = how an already-entered AI routes a user command

.ai/workflows/handoff/BOOTSTRAP.md
    = how a receiving chapter is initialized as an ordered workflow
```

Potential future layering:

```text
ENTRY
  ↓
INDEX
  ↓
canonical owner
  ↓
workflow / execution
```

`ENTRY.md` must **not** be created merely by renaming `BOOTSTRAP.md`. BOOTSTRAP has irreducible receiving-chapter initialization semantics and remains a workflow. A future ENTRY would be a genuinely new semantic layer and must earn its existence through evidence.

## 5. Current `.ai/INDEX.md` model

The `.ai/INDEX.md` architecture is an operational command router and capability-discovery surface.

Each command entry identifies:

1. current user-facing command phrase;
2. semantic operation;
3. canonical owner;
4. required reread targets;
5. activation context / required reread targets.

Repository-state effects, lifecycle outcomes, write authorization, commit policy, commit construction, and procedural steps are not INDEX routing metadata; they remain owned by the canonical rules, skills, and workflows.

Current user-facing handoff commands:

1. `Пора обновить handoff`
2. `Пора выполнить миграцию в чат XXYY`
3. `Пора восстановить handoff`
4. `Пора выполнить handoff lifecycle correction`
5. `Пора выдать bootstrap-инструкцию`

Exact future command IDs and command syntax are intentionally **not frozen**.

### 5.1 Current routing semantics

| Command | Semantic operation | Canonical owner | Activation context |
|---|---|---|---|---|---|
| `Пора обновить handoff` | checkpoint current chapter | handoff skill + lifecycle | lifecycle; handoff skill; current handoff | Yes; lifecycle remains `DRAFT` | Yes — checkpoint commit |
| `Пора выполнить миграцию в чат XXYY` | migration of current chapter | handoff skill + lifecycle; BOOTSTRAP for generated instruction | lifecycle; handoff skill; BOOTSTRAP | Yes; closing handoff may move `DRAFT → READY_FOR_HANDOFF`; bootstrap instruction is separate | Yes — migration commit |
| `Пора восстановить handoff` | Lifecycle Recovery | lifecycle rule | lifecycle; commit rule/skill when a write is required | Yes; bounded recovery | Yes, if recovery changes repository state |
| `Пора выполнить handoff lifecycle correction` | historical Lifecycle Correction | lifecycle rule | lifecycle; commit rule/skill | Yes; bounded correction | Yes — explicit correction commit |
| `Пора выдать bootstrap-инструкцию` | generate bootstrap instruction for future receiving chapter | handoff skill + BOOTSTRAP | handoff skill; BOOTSTRAP | No lifecycle change | No |

The table is routing metadata, not a procedural specification.

### 5.2 Critical distinction

```text
HANDOFF STATE
    ≠
HANDOFF OPERATION
    ≠
HANDOFF COMMIT
```

Checkpoint:

```text
checkpoint
    ↓
DRAFT → DRAFT
    ↓
repository content changes
    ↓
checkpoint commit
```

Migration:

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

Migration must not be represented as completing the receiving chapter's lifecycle.

Recovery and Correction remain distinct exceptional operations. They are not collapsed into a generic `fix` command.

Bootstrap-instruction generation does not itself change lifecycle state or commit repository state.

## 6. Canonical ownership

```text
.ai/config.yaml
    → repository identity/configuration facts and configured project vocabulary

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

Lifecycle, operation, and commit remain separate dimensions.

Handoff filenames encode specialization/chapter identity, and the chapter sequence provides the existing chronological ordering mechanism for handoff discovery. Removal of `SUPERSEDED` does not by itself require a new historical lifecycle state or separate status mechanism.

Qwen's suggestion to make chronological sorting an explicit new canonical lifecycle rule is therefore not accepted as a current architectural change. The existing filename/chapter ordering mechanism is sufficient unless future evidence shows otherwise.

## 8. BOOTSTRAP architecture decision

BOOTSTRAP retains independent ordered semantics:

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

Therefore the canonical workflow remains:

`.ai/workflows/handoff/BOOTSTRAP.md`

The former path `.ai/workflows/handoff-bootstrap/BOOTSTRAP.md` was removed.

This was an organizational path correction, not a semantic change.

Duplicated canonical material was removed from BOOTSTRAP where ownership had already moved to rules/skills. BOOTSTRAP references canonical owners instead of redefining them.

Independent review by both Grok and Qwen confirmed that BOOTSTRAP should remain an ordered workflow.

## 9. Major Iteration 2 restructuring completed

Established active locations include:

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

The handoff tree is grouped by specialization directories.

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

Any move, rename, decomposition, or canonical-ownership change requires a post-edit semantic consistency sweep:

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

Minimum search targets include old paths, old owner references, moved filenames, duplicated normative wording, removed lifecycle concepts, obsolete identifiers, stale bootstrap instructions, and stale links/routing.

A textual match is not automatically an ownership violation. Each hit must be classified as active, historical, archival, descriptive, or genuinely stale.

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

INDEX must provide enough routing metadata to activate the correct canonical capability, but must not become a dependency graph or duplicate procedural layer.

## 13. Current dependency direction

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

INDEX sits above these as routing/discovery rather than as a semantic owner:

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

## 14. Iteration 2 discovery method

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

## 15. Current architecture status

Completed:

- physical Iteration 2 restructuring;
- Repository Identity & Path Resolution ownership pass;
- lifecycle cleanup to `DRAFT → READY_FOR_HANDOFF → HANDED_OFF`;
- `.ai/AGENTS.md` as intended compact always-on operating contract;
- `.ai/INDEX.md` as operational command router and capability-discovery surface;
- five current user-facing handoff command routes;
- explicit separation of state, operation, and commit metadata in INDEX;
- BOOTSTRAP residual-core analysis;
- retention of BOOTSTRAP as an independent ordered workflow;
- BOOTSTRAP move to `.ai/workflows/handoff/BOOTSTRAP.md`;
- active path/reference consistency sweep after the BOOTSTRAP move.

Current entry-layer model:

```text
AGENTS
  ↓
INDEX COMMAND SURFACE
  ↓
CANONICAL CAPABILITY / OWNER
  ↓
EXECUTION
```

## 16. Independent architecture review checkpoint

Grok and Qwen independently reviewed the current repository state after rereading the current `.ai` infrastructure. The review was treated as evidence against the repository state, not as a source for reconstructing chapter history.

The core result is strong convergence:

- `INDEX = routing / capability discovery` is correct;
- canonical owners retain procedural and normative authority;
- operation / state / commit separation is correct;
- BOOTSTRAP remains an independently justified ordered workflow;
- `ENTRY.md` is not currently needed;
- exact command IDs/syntax should remain unfrozen.

The reviews also produced actionable questions and findings recorded below.

## 17.9 Handoff chapter identity and header schema

The handoff chapter identity is now project-agnostic and uses:

    [A-Z][0-9]{3}

The first letter identifies the specialization and the three-digit number identifies the chapter within that specialization.

Handoff header formatting is canonicalized separately from the chapter identifier:

    # Conversation Handoff

    **Conversation:**
    E001 — Independent Review (Qwen)

    **Specialization:**
    E

    **Chapter:**
    001

    **Previous chapter:**
    000

    **Status:**
    HANDED_OFF

The project name is not repeated in the Conversation field. Chapter and Previous chapter contain only the three-digit chapter number; the specialization letter is carried by the Specialization field and by the full chapter identifier in Conversation, filenames, and cross-references.

The canonical formatting rules are owned by .ai/skills/handoff/SKILL.md; chapter identity and lifecycle naming constraints are owned by .ai/rules/handoff/lifecycle.md.

### Migration history

The repository was migrated from the previous chapter identity scheme to [A-Z][0-9]{3}. This migration intentionally replaces the historical naming convention rather than preserving it as an active infrastructure contract. The conversion mapping is historical context for this migration only and must not be copied into generic rules, skills, workflows, or other active project infrastructure.

The migration also renamed handoff specialization directories to their corresponding specialization letters and renamed existing handoff files to the new chapter identifiers. Git history remains the historical record of the former names.

## 17. Review-derived open questions and accepted decisions

### 17.1 Minimum semantic metadata in INDEX — DECIDED IN C027

Qwen challenged the inclusion of `Repository state may change` and `Commit` metadata because routing metadata could drift into shadow ownership.

C027 decision: **reduce command routing metadata to four fields**: command phrase, semantic operation, canonical owner, and activation context / required reread targets.

The metadata is useful discovery information, and current INDEX wording explicitly states that the `Commit` field does not authorize or construct commits. Canonical commit rules/skills retain ownership.

The tested minimum routing model is:

```text
command → operation → owner → activation context
```

`Repository state may change` and `Commit` were useful operator warnings, but were not required for discovery or safe routing and risked adding canonical semantic density to INDEX. Their meanings remain owned elsewhere.

This remains a review/Iteration 3 question. Any future change should be evidence-driven.

### 17.2 `Пора выдать bootstrap-инструкцию` — OPEN

The independent reviews raised a legitimate semantic question about the fifth command.

One interpretation is that bootstrap-instruction generation is a standalone, non-mutating capability. Another is that it is naturally the terminal output of migration and should not exist as a separately routable operation.

Current decision: **keep the command unchanged for now**.

Questions to resolve later:

- Is bootstrap-instruction generation a genuine independent capability or merely a migration output?
- Should it remain a user-facing command if it is read-only?
- If it remains, should it be explicitly defined as a preview/generation operation whose validity depends on an already completed migration?
- Should INDEX distinguish migration operations from chapter-initialization workflows more visibly?

Do not change the command or merge it into migration without new evidence.

### 17.3 Soft dual source in lifecycle.md — MODERATE CLEANUP CANDIDATE

Grok and Qwen both identified possible duplication of user-facing command phrases between `INDEX.md` and `.ai/rules/handoff/lifecycle.md`.

The intended boundary is:

```text
INDEX
    = user-facing command discovery

lifecycle.md
    = lifecycle semantics, authorization, constraints
```

The issue is classified as a **Moderate cleanup candidate**, not an urgent ownership violation.

Future cleanup should prefer a pointer in lifecycle.md to the INDEX command surface while preserving lifecycle semantics and authorization conditions there.

### 17.4 Historical handoffs after removal of SUPERSEDED — DECIDED

Qwen suggested explicitly adding a rule that historical discovery relies on chapter-ID chronological sorting.

Current decision: **no new rule is required at this time**.

Handoff filenames already encode specialization/chapter identity, and chapter sequence already provides chronological ordering. Removing `SUPERSEDED` does not make the current history model ambiguous enough to justify another lifecycle state or mandatory discovery mechanism.

Revisit only if actual discovery failures appear.

### 17.5 Chapter identifier format — current state

The active handoff chapter identifier format is:

```text
[A-Z][0-9]{3}
```

The specialization is encoded by the first letter and the chapter number by three decimal digits. For example, `C027` identifies specialization `C`, chapter `027`.

This is an active infrastructure convention. Historical identifiers from the previous scheme are migration history only and must not be used as current architectural references.

### 17.6 INDEX scalability — FUTURE DESIGN QUESTION

Current command surface is small. The realistic expected upper bound is roughly **10–15 user-facing commands**, not 30–50.

Even at that size, the current table presentation may become visually heavy.

Future question:

> How should INDEX be formatted so that approximately 10–15 command routes remain immediately discoverable without turning INDEX into a dense procedure catalogue?

Potential future solutions include grouping commands by operation family or introducing a secondary discovery presentation. No new layer is justified yet.

### 17.7 Future ENTRY.md — ITERATION 3 EXPERIMENT

The reviews confirmed that a separate ENTRY layer is not currently needed. The existing system should continue without `ENTRY.md`.

However, a future `ENTRY.md` could have a legitimate role if it answers a question that neither AGENTS nor INDEX should own:

> **How does a completely new AI enter and activate this `.ai` infrastructure?**

The intended distinction would be:

```text
AGENTS.md
    = always-on operating contract

ENTRY.md (future, if justified)
    = initial AI entry / activation guidance

INDEX.md
    = command and capability routing

canonical owners
    = semantics and execution

BOOTSTRAP.md
    = receiving-chapter ordered initialization
```

Important constraint:

> **Do not rename or move BOOTSTRAP.md to ENTRY.md.**

A future ENTRY must be a genuinely new semantic layer, not a relabelled bootstrap workflow.

## 18. Consolidated decision matrix — Grok + Qwen

The reviews are now consolidated against current repository evidence. The matrix distinguishes accepted work from questions deliberately left open.

| Finding / question | Evidence / review | Decision | Current disposition |
|---|---|---|---|
| `INDEX` routing model | Grok + Qwen converge | Accept | **Keep** |
| `INDEX` `Repository state may change` + `Commit` metadata | C027 tested their routing value against canonical owners | Remove from routing table | **Removed in C027; semantics remain canonical elsewhere** |
| Minimum semantic metadata before router becomes owner | C027 tested the routing boundary against canonical owners | Four-field boundary established | **Resolved in C027** |
| `Пора выдать bootstrap-инструкцию` as separate command | Both reviews raise semantic question | Keep unchanged | **Open; no merge with migration** |
| `BOOTSTRAP.md` as ordered workflow | Grok + Qwen converge | Accept | **Keep** |
| `SUPERSEDED` removal / historical ordering | Qwen suggestion; current filenames already encode chapter sequence | No new lifecycle rule | **No change** |
| User-facing command phrases duplicated in `lifecycle.md` | Grok + Qwen | Soft dual source | **Targeted cleanup candidate** |
| `.ai/AGENTS.md` effectively empty | Grok + Qwen + current repository state | Real architecture/implementation gap | **Still pending: design and create AGENTS.md** |
| Active chapter identifier format `[A-Z][0-9]{3}` | Current infrastructure state | Keep | **Current** |
| INDEX scalability / presentation | Grok + Qwen | Real design concern at ~10–15 commands | **Completed in C027** |
| `ENTRY.md` | Both reviews; future semantic role identified | Do not create now | **Iteration 3 experiment** |
| `config.yaml` contains project-specific scopes/terms | Qwen | Intentional configuration boundary | **No change** |
| Project-specific data spread across generic rules/skills/workflows | Architecture objective | Must remain prohibited | **Ongoing consistency rule** |
| Physical Iteration 2 restructuring | Review checkpoint | Completed | **Do not restart** |

### 18.1 Bounded follow-up work

The review did **not** authorize another broad restructuring pass. The bounded follow-up was:

1. design and create `.ai/AGENTS.md` as the compact always-on contract;
2. perform the targeted `lifecycle.md` command-discovery cleanup, preserving lifecycle semantics and authorization;
3. complete the INDEX presentation/minimum-routing analysis without changing its ownership boundary;
4. run a targeted post-edit semantic consistency sweep after resulting edits.

The following remain explicitly outside the current architecture scope unless new evidence appears:

- changing INDEX metadata semantics;
- merging bootstrap-instruction generation into migration;
- changing lifecycle history semantics;
- changing active chapter identifier format;
- creating `ENTRY.md`;
- moving project-specific configuration out of `config.yaml`;
- restarting physical Iteration 2 restructuring.

## 19. Independent review findings requiring concrete follow-up

### 19.1 AGENTS.md implementation gap

Both reviewers independently identified `.ai/AGENTS.md` as effectively empty while the architecture describes it as the always-on operating contract.

This is a real implementation gap, not a reason to redesign the entry architecture.

The intended future content should remain compact and should establish only:

- repository identity/configuration pointer;
- `AGENTS → INDEX → canonical owners` model;
- `INDEX` as routing surface;
- canonical owners as execution/semantic authority;
- pointer to INDEX capability discovery;
- a minimal reminder not to invent operations.

Do not let AGENTS grow into another INDEX or workflow.

### 19.2 config.yaml portability boundary — DECIDED

Qwen identified that `.ai/config.yaml` contains project-specific terminology such as commit scopes and project terms.

Current decision: **this is intentional and correct**.

`.ai/config.yaml` is the single intentional configuration locus for current-project-specific values within the `.ai` infrastructure. Keeping those values there, rather than embedding them across generic rules, skills, and workflows, is precisely what makes the `.ai` layer easier to port to another project.

Therefore:

```text
rules / skills / workflows
    = portable infrastructure

config.yaml
    = project-specific configuration
```

Do not move `commit_scopes`, `project_terms`, or configured external references merely because they are project-specific. The portability test is whether the generic infrastructure remains free of embedded project assumptions.

### 19.3 lifecycle command discovery cleanup

When the next cleanup pass begins, inspect `.ai/rules/handoff/lifecycle.md` specifically for repeated user-facing phrases. Classify each occurrence semantically before editing.

Target model:

```text
INDEX
    → exact user-facing invocation/discovery

lifecycle.md
    → operation semantics and authorization
```

### 19.4 Targeted consistency sweep

The independent review found the active architecture substantially consistent but identified the above implementation gaps. A targeted semantic sweep must be run after any resulting edits rather than treating reviewer text as an automatic rewrite list.

## 20. What should NOT be changed based on review

Do not currently:

- remove `Commit` metadata from INDEX;
- remove repository-state metadata from INDEX;
- merge bootstrap-instruction generation into migration;
- reintroduce `SUPERSEDED`;
- add a new historical lifecycle state;
- add a mandatory chronological-sorting rule without evidence;
- create `ENTRY.md` in Iteration 2;
- rename BOOTSTRAP.md to ENTRY.md;
- dissolve BOOTSTRAP into INDEX;
- move procedures into INDEX;
- move project-specific configuration out of `config.yaml`;
- freeze exact command IDs/syntax;
- restart physical Iteration 2 restructuring.

## 21. Deferred experiments / TODO

### Handoff Content Extraction Test

Take a real handoff and classify every content unit, then test whether project knowledge can be moved to canonical project documentation while leaving a bounded conversation-state artifact.

### Iteration 3 Entry-Layer Test

Test whether a genuinely distinct `ENTRY.md` layer is justified. The candidate role is new-AI infrastructure activation, not bootstrap workflow execution.

### INDEX Presentation Test

Prototype a more compact presentation for approximately 10–15 commands while preserving routing metadata and avoiding procedural content.

### Future Identifier Migration Test

Historical chapter-identifier migration is complete; do not preserve the former identifier scheme as an active architecture dependency.

### Operation / Commit Vocabulary

Keep exact operation IDs, final command syntax, and hard-MUST commit vocabulary deferred until sufficient evidence exists.

## 22. Migration note

The current architecture state is represented by this file and the current `.ai` tree. Future chapters must start from current repository state rather than reconstructing earlier architecture chapters from conversation history.

The next architecture/research chapter should treat the independent Grok/Qwen review as evidence against the current model, distinguish accepted findings from open questions, and avoid broad restructuring without evidence.


## 23. C027 result — INDEX presentation and minimum routing boundary

C027 completed the bounded INDEX presentation/scalability task.

The durable command-routing boundary is:

```text
command
   ↓
operation
   ↓
owner
   ↓
activation context
```

Capability discovery remains a separate compact surface:

```text
capability
   ↓
owner
   ↓
purpose
```

The command-routing table therefore carries only those four fields. Repository-state effects, lifecycle outcomes, write authorization, commit policy, commit construction, and procedural steps remain canonical concerns outside INDEX.

This is sufficient for the expected approximately 10–15 command/capability surface without introducing a registry, manifest, command-ID schema, or additional filesystem layer. Further scaling pressure should first be addressed through presentation/grouping changes rather than additional semantic metadata.

### 23.1 AGENTS remains an active architecture task

The C027 INDEX work does not close the AGENTS architecture question.

.ai/AGENTS.md is still to be designed and created as a compact always-on operating contract. Its boundary remains:

```text
AGENTS
  ↓
INDEX
  ↓
canonical owners
```

AGENTS must not become a second INDEX, procedure catalogue, lifecycle rule, or capability owner.

## 24. Durable methodology — bounded architecture work

The current architecture process has demonstrated a reusable method that should remain durable context:

```text
current evidence
    ↓
bounded question
    ↓
semantic classification
    ↓
explicit decision
    ↓
minimal implementation
    ↓
consistency sweep
    ↓
verification
```

The key property is **boundedness**: a chapter should answer the smallest architectural question that current repository evidence can resolve, implement only the resulting decision, and avoid reopening settled architecture merely because older notes contain broader TODO lists or alternative proposals.

Classify old material before treating it as work:

- **historical TODO** — recorded for possible future investigation;
- **active architecture task** — currently assigned to the receiving chapter;
- **durable decision** — resolved boundary that later chapters should treat as current state unless new evidence invalidates it.

This prevents old review notes from becoming an implicit task queue.

### 24.1 Durable INDEX boundary

The current minimum routing boundary is:

```text
command → operation → owner → activation context
```

where command is the user-facing invocation, operation is the requested semantic operation, owner is the canonical rule/skill/workflow, and activation context is the canonical material that must be reread before execution.

INDEX identifies and routes. It does not authorize, define, or execute the operation.

Capability discovery remains distinct:

```text
capability → owner → purpose
```

### 24.2 Durable AGENTS boundary

The intended AGENTS role remains a compact always-on operating contract. It should establish only the minimum context needed before command routing, including:

- repository/configuration pointer;
- AGENTS → INDEX → canonical owners model;
- INDEX as the routing/discovery surface;
- canonical owners as semantic/procedural authority;
- pointer to capability discovery;
- minimal prohibition against inventing operations or duplicating canonical semantics.

Its detailed content is still an active architecture task and must be designed from current repository evidence before the file is created.

### 24.3 Durable portability boundary

The configuration conclusion remains:

```text
portable rules / skills / workflows
        +
project-specific .ai/config.yaml
        =
portable AI infrastructure adapted to a project
```

Project-specific handoffs and architecture notes remain project state/research artifacts and do not invalidate this configuration boundary.

### 24.4 Applying bounded architecture work

When an old note or external review proposes a change, first classify it as current evidence, already-decided state, open architectural question, or historical/deferred proposal. Only current evidence and genuinely open questions should normally drive the current chapter. A deferred proposal does not become active merely because it remains written down.

