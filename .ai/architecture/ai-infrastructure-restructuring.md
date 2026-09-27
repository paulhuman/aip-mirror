# 03AU — AI Infrastructure Restructuring Working Notes

Status: Durable migration context / Iteration 2 — updated through 03BA
Specialization: 03 — Architecture & Research
Scope: .ai infrastructure, repository entry points, semantic ownership, restructuring, verification

## 1. Purpose

This file preserves the durable reasoning and decisions behind Iteration 2 of the AI-infrastructure restructuring.

It is a working architecture/research artifact, not a generic rule file. Its job is to prevent later chapters from reconstructing important decisions from conversation history.

The file records:
- the central .ai versus docs boundary;
- semantic decomposition principles;
- accepted target structure;
- completed physical moves and decompositions;
- the distinction between lifecycle, operations, and commits;
- the post-edit consistency-sweep procedure;
- remaining open questions and deferred experiments.

It must not become a second copy of operational rules that already have canonical owners.

## 2. Core architectural boundary

The observable working system is:

    HUMAN
      |
      | instructions / text / files / links
      v
    AI / CONVERSATION
      |
      | read / write / inspect
      v
    REPOSITORY

The AI's internal memory, routing, reasoning machinery, and model state remain a black box.

The practical architecture therefore concerns the external structures that make reliable project work easier across finite conversation contexts.

Central Iteration 2 rule:

> If the primary subject is how AI should work with the project, it belongs in .ai/. If the primary subject is what AIP Mirror is or how it works, it belongs in docs/.

This is a practical ownership boundary, not a theory of the AI.

## 3. Semantic decomposition model

Every candidate document unit is classified along three independent dimensions:

    LOCATION
       |
       | correct semantic kind, wrong directory
       v
      MOVE

    CONTENT BOUNDARY
       |
       | multiple semantic responsibilities in one file
       v
    DECOMPOSE

    LIFECYCLE
       |
       | useful evidence, no longer active infrastructure
       v
     ARCHIVE

Semantic kinds used in Iteration 2:

- RULE = what must be true;
- SKILL = reusable capability;
- WORKFLOW = ordered procedure;
- README = orientation/navigation;
- PROJECT DOC = AIP Mirror-specific knowledge.

Do not create a file merely because a semantic unit can be named. A new file needs a stable subject, an owner, independent usefulness, and enough coherence to justify its existence.

## 4. Accepted Iteration 2 target structure

The accepted conceptual structure is:

    aip-mirror/
    |
    +-- README.md
    +-- AGENTS.md
    +-- .ai/
    |   +-- INDEX.md
    |   +-- config.yaml
    |   +-- rules/
    |   |   +-- handoff/
    |   |   |   +-- lifecycle.md
    |   |   |   +-- references.md
    |   |   +-- repository.md
    |   |   +-- ...
    |   +-- skills/
    |   |   +-- handoff/
    |   |   +-- commits/
    |   |   +-- deep-understanding/
    |   |   +-- ...
    |   +-- workflows/
    |   |   +-- handoff-bootstrap/
    |   |   +-- independent-review/
    |   |   +-- ...
    |   +-- handoffs/
    |   |   +-- <specialization>/
    |   +-- architecture/
    |   +-- archive/
    |
    +-- docs/
    |   +-- PROJECT-INSTRUCTIONS.md
    |   +-- architecture/
    |   +-- ...
    |
    +-- references/

Important boundary:
- .ai/ = AI working infrastructure;
- docs/ = AIP Mirror project knowledge;
- root references/ = AIP Mirror-specific references;

AGENTS.md and .ai/INDEX.md now physically exist. Their final content architecture was analyzed in 03AZ; implementation of the full INDEX command surface remains the next chapter's task.

## 5. Entry-point layering

The intended direction is:

                     repository
                         |
              +----------+----------+
              |                     |
          README.md             AGENTS.md
              |                     |
        human orientation     AI repository entry
                                    |
                                    v
                              .ai/INDEX.md
                                    |
                                    v
                         rules / skills / workflows

These must not become reciprocal copies.

Working roles:
- README.md = human repository orientation;
- AGENTS.md = compact always-on AI repository operating contract;
- .ai/INDEX.md = operational command router and capability-discovery surface for AI infrastructure;
- docs/PROJECT-INSTRUCTIONS.md = AIP Mirror-specific project instructions and coordination.

The approved command-routing model is:

    chat
      ↓
    user command
      ↓
    .ai/INDEX.md
      ↓
    identify operation
      ↓
    reread required canonical owner files
      ↓
    execute the owning rule / skill / workflow

INDEX.md must list the complete user-facing command surface with the new command syntax, identify the semantic operation, canonical owner, and required reread targets, while keeping detailed procedure in the owner files.

AGENTS.md must remain compact and must not become a second INDEX or bootstrap document.

A separate ENTRY.md is currently not justified and is deferred to Iteration 3.

## 6. Portability

The .ai layer is intended to be portable between projects.

When .ai is reused:
- reusable AI infrastructure should migrate;
- project-specific handoffs should be cleared or replaced;
- historical archive material should be retained only when deliberately useful;
- project-specific assumptions must not be hidden inside generic .ai rules.

This is why AIP Mirror product architecture belongs in docs/, even when an AI conversation first discovered it.

## 6.1 Project-agnostic .ai content

The `.ai` layer is project-agnostic infrastructure and must remain reusable without AIP Mirror-specific knowledge.

Therefore:

- generic `.ai` rules, skills, and workflows must not use AIP Mirror-specific names, paths, filenames, workstream labels, or product concepts as illustrative examples;
- examples inside `.ai` should be abstract enough to survive reuse in another project;
- when a concrete project-specific example is genuinely necessary to explain an infrastructure mechanism, prefer a reference to the project's `docs/` material rather than embedding project knowledge in `.ai`;
- project-specific examples discovered during restructuring are consistency-sweep findings and should be removed or generalized.

This is an architectural portability requirement, not merely a documentation-style preference.

## 7. Handoff architecture

Three dimensions must remain distinct:

    HANDOFF LIFECYCLE
        = state of the handoff

    HANDOFF OPERATION
        = action performed on the handoff

    HANDOFF COMMIT
        = durable Git record of an operation

Therefore:

    operation != lifecycle transition
    commit   != lifecycle transition

The active lifecycle is exactly:

    DRAFT
      |
      v
    READY_FOR_HANDOFF
      |
      v
    HANDED_OFF


Canonical operational ownership:
- lifecycle invariants → .ai/rules/handoff/lifecycle.md;
- reusable handoff capability → .ai/skills/handoff/;
- bootstrap sequence → .ai/workflows/handoff/;
- commit-message construction → .ai/skills/commits/;
- repository write safety → .ai/rules/repository.md.

## 8. Major physical restructuring completed

The following infrastructure moves/renames have been completed, with the final active locations shown below:

    AI infrastructure architecture
        -> .ai/architecture/ai-infrastructure-restructuring.md

    docs/architecture/independent-review-{grok,qwen,deepseek}-onboarding.md
        -> .ai/workflows/independent-review/

    .ai/rules/conversation-lifecycle.md
        -> .ai/rules/handoff/lifecycle.md

    .ai/rules/handoff-references.md
        -> .ai/rules/handoff/references.md

    .ai/skills/conversation-handoff/SKILL.md
        -> .ai/skills/handoff/SKILL.md

    .ai/skills/conversation-handoff/BOOTSTRAP.md
        -> .ai/workflows/handoff/BOOTSTRAP.md

    .ai/skills/handoff-reference-preservation/SKILL.md
        -> .ai/skills/handoff/reference-preservation/SKILL.md

    docs/handoffs/
        -> .ai/handoffs/<specialization>/

The handoff tree is now physically grouped by specialization directories (for example `02/`, `03/`, `04/`, `05/`, and `06/`).

Architecture filenames were also simplified by removing historical chapter suffixes/prefixes where they no longer carried semantic value.

These operations were followed by content-level decomposition of several rule files rather than treating moves as the end of the work.

## 9. Repository-rule consolidation

Repository configuration and repository rules now have separate ownership:
- `.ai/config.yaml` is the canonical owner of project repository identity;
- `.ai/rules/repository.md` is the canonical owner of external repository boundaries;
- `.ai/rules/repository.md` is the canonical owner of repository path resolution;
- `.ai/rules/repository.md` is the canonical owner of repository taxonomy/hygiene;
- `.ai/rules/repository.md` is the canonical owner of repository-facing durable knowledge;
- `.ai/rules/repository.md` is the canonical owner of repository write safety.

The canonical mutation sequence is:

    READ CURRENT FILE
          |
    minimal intended change
          |
    WRITE COMPLETE FILE
          |
    READ BACK
          |
    VERIFY CONTENT
          |
    INSPECT DIFF
          |
    VERIFY SCOPE
          |
    COMMIT
          |
    VERIFY RESULT

Commit policy is owned separately by .ai/rules/commits.md and .ai/skills/commits/SKILL.md.

Handoff lifecycle is owned separately by .ai/rules/handoff/lifecycle.md.

## 10. PROJECT-INSTRUCTIONS decomposition

docs/PROJECT-INSTRUCTIONS.md has been reduced to a thin AIP Mirror project-specific instruction layer.

It now retains:
- project orientation;
- project operating model;
- project-specific native implementation target;
- project behavioral target;
- cross-workstream coordination;
- canonical project-source routing.

It no longer owns generic repository path resolution, generic repository safety, generic commit policy, or handoff lifecycle mechanics.

The workstream model is explicitly non-autonomous:

> A workstream is a project work area represented by one or more separate AI conversations. It is not an autonomous agent, service, or process that can communicate directly with other workstreams.

The user coordinates between conversations and AI services. Durable repository files provide the shared project record.

## 11. The important Iteration 2 discovery: post-edit consistency sweep

A physical move or decomposition can expose stale dependencies in files that were not edited.

This is not an edge case. It is a normal consequence of changing canonical ownership.

Observed example:

    PROJECT-INSTRUCTIONS.md
          |
          | previously owned path resolution
          v
    lifecycle.md

After path resolution moved to repository.md, lifecycle.md still contained the old dependency twice.

The inconsistency was invisible if the changed file alone was inspected.

Therefore Iteration 2 adds a required **post-edit consistency sweep** after any move, rename, decomposition, or canonical-ownership change.

The purpose is:

    EDIT
      |
      v
    verify edited file
      |
      v
    SEARCH FOR OLD OWNERSHIP / OLD PATHS / OLD TERMS
      |
      v
    inspect dependent references
      |
      v
    repair stale dependencies
      |
      v
    read back
      |
      v
    diff + scope verification
      |
      v
    commit
      |
      v
    verify result

This sweep is repository-wide at the semantic level, not necessarily a full reread of every file.

Minimum search targets:
- old file paths;
- old canonical-owner references;
- moved/renamed filenames;
- duplicated normative wording;
- references to removed lifecycle states or concepts;
- obsolete chapter/specialization identifiers;
- stale bootstrap instructions;
- links/routing that still point to the previous location.

The sweep must be performed after the primary edit and before declaring the refactor complete.

## 12. Canonical-owner change protocol

When changing the owner of a piece of information:

1. identify the new canonical owner;
2. update the canonical owner first or as part of the same coherent change;
3. update direct dependents;
4. search for stale references to the old owner;
5. inspect every relevant hit semantically;
6. remove or reroute stale duplication;
7. read back changed files;
8. inspect diff and changed-file scope;
9. commit;
10. verify the resulting repository state.

Important:

> A successful edit proves only that the edited file changed. It does not prove that the repository is internally consistent with the new ownership.

This procedure is now a required Iteration 2 restructuring practice.

## 13. Why this matters for finite-context reliability

The consistency sweep is also a context-reliability mechanism.

Without it, a long migration can produce a repository where:
- the new owner is correct;
- old dependents still describe the previous architecture;
- the next conversation reads both;
- the model must resolve a contradiction from stale text.

That recreates exactly the kind of context burden Iteration 2 is trying to remove.

Therefore:

    canonical ownership change
              |
              v
      repository-wide consistency
              |
              v
       smaller active context

The goal is not merely a smaller filesystem. It is a repository whose surviving instructions agree with one another.

## 14. Decomposition principle: remove, do not merely relocate

When a source document is decomposed, each old unit must be classified as:

    KEEP
    MOVE
    DECOMPOSE
    ARCHIVE
    REMOVE

REMOVE is important.

If content is already represented by a canonical owner, it should disappear rather than be copied into another file.

Do not create one file per old section.

Do not turn every useful sentence into infrastructure.

## 15. Current dependency direction

The intended dependency direction is:

    .ai/config.yaml
        |
        +--> project identity / configuration facts

    .ai/rules/workflow.md
        |
        +--> generic AI workflow principles

    .ai/rules/repository.md
        |
        +--> repository boundaries / path resolution / safety

    .ai/rules/handoff/lifecycle.md
        |
        +--> lifecycle invariants

    .ai/skills/*
        |
        +--> reusable capabilities

    .ai/workflows/*
        |
        +--> ordered procedures

    docs/
        |
        +--> AIP Mirror project semantics

The .ai layer may reference project documentation when necessary, but project facts must not be copied back into generic .ai rules.

Avoid reciprocal dependencies that turn one file into an accidental aggregation point.

## 16. What was learned from the decomposition

The important result of Iteration 2 is not just the new directory tree.

It is the discovery method:

    inventory
       |
       v
    classify semantic ownership
       |
       v
    establish canonical owner
       |
       v
    move / decompose / remove
       |
       v
    post-edit consistency sweep
       |
       v
    verify repository coherence
       |
       v
    commit
       |
       v
    continue

This is now part of the durable migration knowledge.

## 17. Remaining open questions

Do not silently resolve:
- exact command syntax and operation IDs;
- exact fragment/section ID conventions;
- complete handoff operation vocabulary;
- exact operation-to-commit mapping;
- whether every handoff operation requires a commit;
- long-term handoff retention/archive policy;
- whether TODO should eventually become an independent durable artifact;
- exact long-term .ai/architecture taxonomy;
- whether any remaining mixed rule files require another decomposition pass;
- final fate of `.ai/workflows/handoff/BOOTSTRAP.md` after the upper-surface and residual-core analysis;
- if BOOTSTRAP remains, rename it to `.ai/workflows/handoff/BOOTSTRAP.md` to align workflow grouping with `rules/handoff/` and `skills/handoff/`.

The entry-layer architecture is no longer an open structural question for Iteration 2:
- `.ai/AGENTS.md` exists as the compact always-on AI operating contract;
- `.ai/INDEX.md` exists as the command/capability routing surface;
- no `ENTRY.md` is planned in Iteration 2.

The exact content and command IDs of INDEX.md remain intentionally unfrozen.

### 17.1 Archived TODO-A — handoff operations and commit vocabulary

Recovered from an earlier 03-series architecture discussion and preserved here as durable TODO context. This section is archival/analytical context, not an instruction to execute the listed operations now.

The missing semantic model is:

    HANDOFF LIFECYCLE
        = state

    HANDOFF OPERATION
        = action

    HANDOFF COMMIT
        = durable Git record of an operation

These dimensions must remain separate.

An operation does not necessarily change lifecycle state:

    UPDATE / CHECKPOINT
        DRAFT → DRAFT

    CORRECT
        X → X

Likewise, a commit is the durable recording of an operation; it does not itself define the lifecycle transition.

The intended decision model is:

    handoff operation
          ↓
    commit classification
          ↓
    commit message

Lifecycle transition is an attribute of the operation, not the primary source of commit-message vocabulary.

Archived examples of the distinction:

| Operation | Lifecycle transition | Commit |
|---|---|---|
| CREATE DRAFT | no | yes |
| CHECKPOINT | no | yes |
| MARK READY | yes | yes |
| HAND OFF | yes | yes |
| CORRECT | no | yes |
| RECOVER | possible | yes |
| ARCHIVE | no | yes |
| read/inspect only | no | no |

This table is evidence from the earlier discussion, not yet the final normative operation set.

### 17.2 Commit-message vocabulary TODO

The previously discussed base vocabulary was intentionally only a starting point, not a complete hard-MUST set:

    docs(handoff): add <chapter>
    docs(handoff): update <chapter>
    docs(handoff): mark <chapter> ready for handoff
    docs(handoff): mark <chapter> handed off

The shorter <chapter> form is the intended direction for these messages. Do not expand this into a complete normative vocabulary yet.

The unresolved task is to derive the complete operation vocabulary from the actual handoff workflow/rules/skills and then define the corresponding commit classification and hard-MUST message vocabulary.

Required future analysis:

1. enumerate actual handoff operations from the current workflow/rules/skills;
2. distinguish lifecycle transitions from non-transition operations;
3. determine which operations require durable commits;
4. map operations to commit classifications;
5. define the minimal normative commit-message vocabulary;
6. verify that the vocabulary matches actual repository operations rather than an invented operation list.

Until that work is completed, the exact operation set, operation-to-commit mapping, and complete commit-message vocabulary remain open.

## 17.3 Completed semantic-ownership pass: Repository Identity & Path Resolution

The 03AZ chapter completed the focused ownership analysis.

Canonical boundary:

    .ai/config.yaml
        = WHAT / WHERE
        = project repository identity and configuration facts

    .ai/rules/repository.md
        = HOW
        = repository interpretation, path resolution, boundaries, taxonomy/hygiene,
          durable repository knowledge, and write safety

    other .ai rules / skills / workflows
        = USE / REFERENCE
        = consume canonical definitions without redefining them

The pass produced the following verified results:

- `.ai/rules/handoff/references.md` was cleaned so repository identity/path resolution is delegated to `.ai/rules/repository.md`.
- Commit: `69145e5bfd73a43ea464008d1060b0a8662f61b4`.
- The commit layer was re-verified: `.ai/rules/commits.md` owns policy; `.ai/skills/commits/SKILL.md` owns reusable commit construction; configuration terminology remains data.
- Stale commit/handoff naming references were removed in bounded corrective commits.
- The `handoff/SKILL.md` frontmatter was normalized to `name: handoff`.
- The duplicate migration-completion section was removed from `.ai/workflows/handoff/BOOTSTRAP.md`, leaving migration ownership in `.ai/skills/handoff/SKILL.md`.
- Commit: `9caf822259ad11587346c62981cbcc3981dc0a75`.
- A durable TODO was recorded: if BOOTSTRAP remains after residual-core analysis, rename it to `.ai/workflows/handoff/BOOTSTRAP.md`.
- Commit: `c40375b2f84d99eab30f3a932ac77f1159152d09`.

The resulting ownership model is coherent enough to move the architecture work upward to the repository entry/command-routing layer.

### 17.4 Entry-layer architecture established in 03AZ

03AZ also established the provisional entry-layer model:

    README.md
        = HUMAN ORIENTATION

    .ai/AGENTS.md
        = AGENT OPERATING CONTRACT
        = compact, always-on, mandatory context

    .ai/INDEX.md
        = AI INFRASTRUCTURE INDEX
        = command surface
        = capability discovery
        = canonical-owner routing
        = "what to reread before executing a command"

    .ai/rules/
        = CANONICAL SEMANTICS / CONSTRAINTS

    .ai/skills/
        = REUSABLE CAPABILITIES

    .ai/workflows/
        = ORDERED PROCEDURES

The command-routing model is explicitly:

    user command
        ↓
    INDEX.md
        ↓
    command / operation identification
        ↓
    reread canonical owner files
        ↓
    execute

Five currently documented user-facing handoff commands were identified:

1. `Пора обновить handoff`
2. `Пора выполнить миграцию в чат XXYY`
3. `Пора восстановить handoff`
4. `Пора выполнить handoff lifecycle correction`
5. `Пора выдать bootstrap-инструкцию`

The exact new command syntax and operation IDs are intentionally not frozen yet.

Current routing model:

| User command | Semantic operation | Canonical owner | Required reread | Repository state |
|---|---|---|---|---|
| `Пора обновить handoff` | checkpoint current chapter | `skills/handoff/SKILL.md` + lifecycle | lifecycle + handoff skill | yes; DRAFT remains DRAFT |
| `Пора выполнить миграцию в чат XXYY` | migrate current chapter | `skills/handoff/SKILL.md` + lifecycle + bootstrap workflow | lifecycle + handoff skill + bootstrap workflow | yes; closing handoff becomes READY_FOR_HANDOFF |
| `Пора восстановить handoff` | Lifecycle Recovery | `rules/handoff/lifecycle.md` | lifecycle + commit rules/skill when needed | bounded recovery only |
| `Пора выполнить handoff lifecycle correction` | historical Lifecycle Correction | `rules/handoff/lifecycle.md` | lifecycle + commit rules/skill | bounded correction only |
| `Пора выдать bootstrap-инструкцию` | generate bootstrap instruction | `skills/handoff/SKILL.md` + bootstrap workflow | handoff skill + bootstrap workflow | no lifecycle change |

Important distinctions:
- HANDOFF STATE != OPERATION != COMMIT.
- `Пора обновить handoff` is a checkpoint operation; it does not change lifecycle state.
- Migration ends the closing chapter at `READY_FOR_HANDOFF`; the receiving chapter later performs the `HANDED_OFF` transition.
- Recovery and Correction are separate exceptional operations.
- Bootstrap-instruction generation is not a lifecycle operation and does not initialize the next chapter.

### 17.5 BOOTSTRAP residual-core decision in 03BA

03BA compared the completed INDEX routing model with the remaining semantics of the bootstrap procedure.

The residual BOOTSTRAP semantics are independently useful as an ordered workflow:
- runtime bootstrap inputs: `CURRENT_CHAPTER`, `NEXT_CHAPTER`, `SPECIALIZATION`;
- receiving-chapter initialization;
- write-capability branch selection;
- ordered bootstrap sequence;
- mandatory post-bootstrap consistency verification;
- the gate that prevents substantive work before bootstrap completion.

These are sequence-dependent execution rules. INDEX can route to them, but cannot replace them without becoming a second workflow owner.

The duplicated canonical content remains delegated:
- repository identity/path resolution → `.ai/rules/repository.md`;
- handoff lifecycle semantics → `.ai/rules/handoff/lifecycle.md`;
- handoff capability/migration → `.ai/skills/handoff/SKILL.md`;
- commit construction → `.ai/skills/commits/SKILL.md`.

Decision:

`.ai/workflows/handoff-bootstrap/BOOTSTRAP.md` is renamed to:

`.ai/workflows/handoff/BOOTSTRAP.md`

The move is organizational, not semantic: BOOTSTRAP remains the canonical ordered bootstrap workflow, while INDEX remains only its routing/discovery surface.

### 17.6 INDEX command-router model established in 03BA

03BA implemented the first operational INDEX model.

`.ai/INDEX.md` now defines a compact routing contract:

    user command
        ↓
    operation identification
        ↓
    canonical owner
        ↓
    required reread targets
        ↓
    execute owner

Each documented command entry identifies:
- current user-facing command phrase;
- semantic operation;
- canonical owner;
- required reread targets;
- whether repository state may change.

The INDEX also contains a capability-discovery map for the canonical rules, skills, and workflow owners.

The model deliberately does not freeze new command IDs or alternate command syntax. The existing user-facing phrases are represented as the current command surface; future exact syntax remains an open architectural TODO.

The critical boundary is:

> INDEX identifies and routes; canonical owners define and execute.

INDEX therefore does not own lifecycle semantics, handoff procedures, commit policy, repository path-resolution rules, bootstrap ordering, or other reusable procedures.

### 17.7 Iteration 2 current frontier after 03BA

The active entry-layer model is now:

    ENTRY LAYER
       |
       v
    INDEX COMMAND SURFACE
       |
       v
    CANONICAL CAPABILITY / OWNER
       |
       v
    EXECUTION

The BOOTSTRAP residual-core question is resolved: BOOTSTRAP remains an ordered workflow under `.ai/workflows/handoff/BOOTSTRAP.md`.

The remaining Iteration 2 questions are bounded:
- exact command IDs/syntax;
- exact command-entry/fragment ID conventions;
- complete handoff operation vocabulary and operation-to-commit mapping;
- long-term handoff retention/archive policy;
- exact long-term `.ai/architecture/` taxonomy;
- whether any remaining mixed rule files require another decomposition pass.

## 18. Deferred experiments

### Handoff Content Extraction Test

Take a real handoff and classify every content unit, then attempt to move project knowledge to its canonical owners.

The test asks whether the remainder is a bounded conversation-state artifact.

### Iteration 3 entry-layer test

Revisit whether .ai/INDEX.md is sufficient as discovery/routing or whether a separate ENTRY document has a justified role.

Current working position: no separate ENTRY.md.

## 19. Migration note for the next chapter

03AZ closes the Repository Identity & Path Resolution ownership pass and hands the work upward to the entry/command-routing layer.

The receiving chapter is **03BA — Architecture & Research**.

It must start from the current repository state and this durable architecture note, not reconstruct earlier chapters from chat history.

### 03BA result

03BA completed the assigned entry-layer design and residual BOOTSTRAP decision.

Completed:
1. Designed and implemented `.ai/INDEX.md` as an operational command router and capability-discovery surface.
2. Defined the command-entry information model without freezing new command IDs.
3. Preserved canonical ownership by routing to rules, skills, and workflows rather than copying their procedures.
4. Compared INDEX with the residual BOOTSTRAP core.
5. Confirmed BOOTSTRAP remains an independently useful ordered workflow.
6. Renamed BOOTSTRAP to `.ai/workflows/handoff/BOOTSTRAP.md`.
7. Updated direct canonical references to the new workflow path.
8. Performed a post-edit semantic consistency verification of the affected active infrastructure.

Do not:
- repeat physical Iteration 2 restructuring;
- reopen the completed Repository Identity & Path Resolution ownership decision without new evidence;
- create `ENTRY.md`;
- turn `.ai/INDEX.md` into a second rule/skill/workflow;
- duplicate detailed procedure in INDEX;
- start the handoff-operation/commit-vocabulary TODO unless explicitly authorized later.

The critical Iteration 2 pattern remains:

    CHANGE CANONICAL OWNER
              |
              v
    SEARCH FOR STALE DEPENDENCIES
              |
              v
    REPAIR INCONSISTENCIES
              |
              v
    VERIFY REPOSITORY COHERENCE

The immediate architectural question is no longer "where should repository identity live?" It is "how should the entry layer route a user command to the canonical capability without becoming another owner?"

