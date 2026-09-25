# 03AU — AI Infrastructure Restructuring Working Notes

Status: Durable migration context / Iteration 2 — updated through 03AW
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

AGENTS.md and .ai/INDEX.md are accepted future entry points, but their final contents are still open.

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
- AGENTS.md = small AI repository entry point;
- .ai/INDEX.md = discovery/routing map for AI infrastructure;
- docs/PROJECT-INSTRUCTIONS.md = AIP Mirror-specific project instructions and coordination.

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

Do not reintroduce SUPERSEDED as a lifecycle state.

A prior handoff may cease to be the active handoff through a READY_FOR_HANDOFF invariant, but that is not a fourth lifecycle state.

Canonical operational ownership:
- lifecycle invariants → .ai/rules/handoff/lifecycle.md;
- reusable handoff capability → .ai/skills/handoff/;
- bootstrap sequence → .ai/workflows/handoff-bootstrap/;
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
        -> .ai/workflows/handoff-bootstrap/BOOTSTRAP.md

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
- exact .ai/INDEX.md contents;
- exact AGENTS.md contents;
- whether a distinct ENTRY.md is ever justified;
- exact command syntax and operation IDs;
- exact fragment/section ID conventions;
- complete handoff operation vocabulary;
- exact operation-to-commit mapping;
- whether every handoff operation requires a commit;
- long-term handoff retention/archive policy;
- whether TODO should eventually become an independent durable artifact;
- exact long-term .ai/architecture taxonomy;
- whether any remaining mixed rule files require another decomposition pass.

ENTRY currently appears to be a redundant semantic layer and is deferred to Iteration 3.

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

## 18. Deferred experiments

### Handoff Content Extraction Test

Take a real handoff and classify every content unit, then attempt to move project knowledge to its canonical owners.

The test asks whether the remainder is a bounded conversation-state artifact.

### Iteration 3 entry-layer test

Revisit whether .ai/INDEX.md is sufficient as discovery/routing or whether a separate ENTRY document has a justified role.

Current working position: no separate ENTRY.md.

## 19. Historical terminology

Do not reintroduce:
- bootstrap kernel as an architecture term;
- SUPERSEDED as a handoff lifecycle state;
- permanent specialization ownership of knowledge;
- autonomous workstream/agent semantics.

Useful historical research such as MEC/dynamic-context work remains context, not current filesystem authority.

## 20. Migration note for the next chapter

The next chapter must start from the current repository state, not from the old 03AU/03AV physical plan.

The critical Iteration 2 pattern to preserve is:

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

This procedure must be treated as part of normal restructuring work, not as an optional cleanup discovered by chance.

