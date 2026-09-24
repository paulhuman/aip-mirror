# 03AU — AI Infrastructure Restructuring Working Notes

Status: Working research / migration context
Specialization: 03 — Architecture & Research
Chapter: 03AU
Scope: .ai infrastructure, repository entry points, classification, restructuring

## 1. Purpose

This file preserves the accumulated restructuring work of 03AU so the next chapter does not need to reconstruct it from conversation history.

It is a working architecture/research artifact, not yet the final architecture or final target tree.

It records:
- restructuring hypotheses;
- diagrams and boundary decisions;
- classification findings;
- target-tree sketches;
- README / AGENTS.md / .ai/INDEX.md discussion;
- naming conventions;
- unresolved questions;
- TODOs and next steps.

## 2. Core architectural pivot

The project has moved away from designing a theoretical or model-internal AI architecture.

The AI's internal memory, routing, context handling, reasoning machinery, and model state remain a black box.

The observable system is:

    HUMAN
      |
      | natural-language instructions / text / files / links
      v
    AI / CONVERSATION
      |
      | read / write / inspect
      v
    REPOSITORY

The practical question is:

> What external repository structure actually helps an AI continue reliable project work across finite conversation contexts?

The infrastructure is discovered from use rather than derived from an assumed internal ontology.

## 3. Central boundary: .ai versus docs

Working rule:

> If the primary subject is how AI should work with the project, it belongs in .ai. If the primary subject is what AIP Mirror is or how it works, it belongs in docs.

.ai is the meta-agnostic AI working layer:
- rules;
- skills;
- workflows;
- central index;
- handoff state;
- AI-infrastructure references;
- AI-infrastructure architecture/research;
- historical AI-infrastructure research/archive;
- small operational metadata.

docs is AIP Mirror project knowledge:
- product architecture;
- implementation/design;
- Illustrator/FreeHand research;
- specifications;
- validated behavior;
- project decisions;
- project-specific references;
- project-specific development knowledge.

## 4. Portability goal

The .ai directory should be portable between projects.

Desired model:

    Project A
    |
    +-- .ai/          reusable AI working infrastructure
    +-- docs/         project-specific knowledge
    +-- references/   project-specific references

When .ai is copied to a new project:
- reusable AI infrastructure should migrate;
- current project handoffs should be removed or cleared;
- .ai/archive/ should be cleared or selectively retained according to policy;
- project-specific assumptions must not remain embedded in supposedly generic .ai files.

The new project then fills its own docs/.

This is why current AIP Mirror-specific rules inside .ai are being reclassified.

## 5. First-iteration reality

The existing .ai structure was built incrementally while solving real problems. It was not designed perfectly from the beginning.

That is useful evidence, not failure.

We reached 03AU through real work even though the 01 and 02 streams have barely produced durable documentation.

01 has produced the first JSX prototype work, but does not yet have even its first handoff.

02 has not yet had substantial native-plugin chapter activity.

Much of the existing .ai structure was therefore discovered and shaped by the 03 research stream.

The restructuring should correct historical placement instead of preserving it merely for consistency.

## 6. Repository entry points

Three different entry points are being considered:

    README.md
        |
        +-- human-facing repository introduction

    AGENTS.md
        |
        +-- AI repository entry point

    .ai/INDEX.md
        |
        +-- internal map of AI working infrastructure

These must not become copies of one another.

### README.md

The current root README.md is empty.

Working role:

> Human-facing introduction to the repository.

Potential contents:
- what AIP Mirror is;
- why the repository exists;
- high-level repository orientation;
- where project documentation lives.

It should not be forced to contain AI operating instructions.

### AGENTS.md

Working hypothesis:

> AGENTS.md is the repository entry point for an AI working in this repository.

We are explicitly not required to reproduce conventions of Codex, Claude Code, Cursor, or another external agent framework. We may use the filename according to our own project rules.

The intended role is deliberately small:

    AGENTS.md
    |
    +-- What is this repository?
    +-- What is .ai?
    +-- What is docs?
    +-- What is references?
    +-- Where should an AI start?
    +-- Which .ai entry point should be read next?

It should point into .ai/INDEX.md rather than duplicate it.

No nested AGENTS.md files are currently needed. Create them only if a real future need appears.

### .ai/INDEX.md

This is the operational map of the .ai infrastructure.

It is not a README and not an AGENTS.md.

## 7. docs/PROJECT-INSTRUCTIONS.md

This file is deliberately not being moved yet.

It is mixed.

AIP Mirror project knowledge belongs in docs/.

AI infrastructure instructions belong in .ai/.

Repository entry-point material may belong in AGENTS.md.

Likely operation:

    docs/PROJECT-INSTRUCTIONS.md
             |
             +-- project knowledge ------> docs/...
             +-- AI infrastructure ------> .ai/...
             +-- repository entry point -> AGENTS.md

The file may or may not survive in reduced form. Decide after content-level decomposition.

## 8. Working .ai target structure

Conceptual target:

    .ai/
    +-- INDEX.md
    +-- rules/
    |   +-- handoff/
    |   |   +-- lifecycle.md
    |   |   +-- references.md
    |   +-- repository/
    |   +-- ...
    +-- skills/
    |   +-- handoff/
    |   +-- commit-message/
    |   +-- deep-understanding/
    |   +-- ...
    +-- workflows/
    |   +-- handoff-bootstrap/
    |   +-- independent-review/
    |   +-- ...
    +-- references/
    +-- handoffs/
    +-- architecture/
    +-- archive/

.ai/architecture/ is now accepted conceptually. Exact internal taxonomy and filenames remain open.

archive/ is preferred to temporary/ because retained material is historical research, not merely disposable scratch work.

.ai/references/ is for external repositories, websites, and resources relevant to AI infrastructure. Root references/ remains AIP Mirror-specific.

## 9. Current .ai/rules classification

### .ai/rules/conversation-lifecycle.md

Primary subject: handoff/conversation lifecycle.

Candidate:

    .ai/rules/handoff/lifecycle.md

### .ai/rules/handoff-references.md

Primary subject: preserving references through handoff.

Candidate:

    .ai/rules/handoff/references.md

### .ai/rules/project-architecture.md

This is not project-agnostic.

It defines AIP Mirror itself:
- JSX prototype versus production;
- native C++ + Illustrator AIP;
- project-owned geometry;
- FreeHand behavior reproduction;
- native implementation priorities;
- CEP/UXP policy;
- AIP Mirror conversation specializations.

Candidate:

    .ai/rules/project-architecture.md
        |
        v
    docs/architecture/...

### .ai/rules/workflow.md

This is substantially AIP Mirror-specific:
- AIP Mirror development cycle;
- four project specializations;
- specialization responsibilities;
- project chapter numbering;
- Workshop boundaries;
- project documentation behavior.

It likely requires decomposition rather than a blind move:

    .ai/rules/workflow.md
        |
        +-- AIP Mirror project workflow -> docs/...
        +-- genuinely generic AI workflow -> .ai/...

### .ai/rules/repository.md

This mixes repository-specific facts with AI working behavior.

It requires content-level decomposition. Project-specific repository facts must not become mandatory infrastructure for a future project.

## 10. Current .ai/skills classification

### commit-message

Reusable commit-message procedure. Keep as an .ai skill.

### conversation-handoff

The folder name is unnecessarily verbose.

Working rename:

    .ai/skills/conversation-handoff/
        |
        v
    .ai/skills/handoff/

### BOOTSTRAP.md

Bootstrap is operationally a workflow entry point rather than merely a reusable skill description.

Candidate:

    .ai/workflows/handoff-bootstrap/

Exact organization remains open.

### handoff SKILL.md

The reusable handoff procedure belongs under:

    .ai/skills/handoff/

### deep-understanding

Remains a candidate .ai skill. No evidence currently requires moving it.

### handoff-reference-preservation

Reusable preservation procedure.

Candidate:

    .ai/skills/handoff/reference-preservation/

It is a procedure, not a permanent reference registry.

## 11. docs/architecture classification

### Clearly .ai

docs/architecture/ai-project-instruction-architecture.md

Primary subject:
- AI working infrastructure;
- .ai;
- handoffs;
- rules;
- skills;
- workflows;
- bootstrap;
- central index;
- context/reliability;
- AI/repository boundary.

Candidate:

    .ai/architecture/ai-project-instruction-architecture.md

Exact filename remains open.

### .ai/workflows candidates

These are AI initialization/workflow material:

    docs/architecture/
    +-- independent-review-deepseek-onboarding.md
    +-- independent-review-grok-onboarding.md
    +-- independent-review-qwen-onboarding.md

Candidate:

    .ai/workflows/independent-review/...

The fact that these workflows are used while researching AIP Mirror does not make them AIP Mirror documentation.

### Historical .ai research

Strong candidates for .ai/archive/:

- architectural-bottleneck-audit-03AP.md
- architectural-bottleneck-cross-audit-03AP.md
- c-13-authority-vs-effective-outcome-03AP.md
- c-14-override-semantic-dimension-03AP.md
- constraint-problem-map-03AS.md
- intentional-acceptance-audit-03AP.md
- mec-dynamic-context-03AT.md
- minimal-execution-context-03AS.md
- post-c-13-architectural-leverage-audit-03AP.md
- prerequisite-dependency-semantics.md
- semantic-source-authority-audit-03AP.md

Reason: much of this work concerns abstract AI/project-instruction infrastructure rather than AIP Mirror product architecture.

Retain it as historical research, but do not let it dictate the new .ai filesystem.

MEC remains historical. Do not reintroduce "bootstrap kernel" as an architecture term.

### AIP Mirror architecture

Documents whose primary subject is the actual AIP Mirror product remain in docs/architecture/.

The exact docs taxonomy will be decided separately.

## 12. docs/handoffs

Current handoffs are AI conversation state, not AIP Mirror project documentation.

Candidate:

    docs/handoffs/
        |
        v
    .ai/handoffs/

When .ai is migrated to another project, current project handoffs can be removed or cleared while the infrastructure remains.

Do not confuse handoffs with archive/: handoffs have an operational lifecycle.

## 13. Root references

No restructuring is proposed for root references/.

It contains AIP Mirror-specific material such as FreeHand documentation, Illustrator JavaScript documentation, and AIP Mirror test media.

.ai/references/ is a different category: external material used to understand or operate the AI infrastructure itself.

## 14. Three entry points

Working model:

                     repository
                         |
              +----------+----------+
              |                     |
          README.md             AGENTS.md
              |                     |
        human orientation     AI orientation
                                    |
                                    v
                              .ai/INDEX.md
                                    |
                                    v
                         rules / skills / workflows

README.md is human-facing.

AGENTS.md is the AI repository entry point.

.ai/INDEX.md is the operational map of .ai.

No file should become a duplicate of another.

## 16. Diagrams / working model

### Portable infrastructure

    PROJECT
      |
      +-- .ai/          reusable AI working infrastructure
      |
      +-- docs/         project-specific knowledge
      |
      +-- references/   project-specific references

### Conversation continuity

    conversation N
         |
         | checkpoint / migration
         v
    .ai/handoffs/
         |
         | bootstrap
         v
    conversation N+1

### Classification

                 DOCUMENT
                    |
                    v
          What is its primary subject?
                    |
             +------+------+
             |             |
             v             v
        How AI works    What project is /
        with project?   does?
             |             |
             v             v
           .ai/          docs/

### Mixed document decomposition

                 mixed document
                       |
             +---------+---------+
             |         |         |
             v         v         v
          AI rules  project info entry point
             |         |         |
             v         v         v
           .ai/      docs/    AGENTS.md

## 17. Accepted working decisions

1. .ai is a meta-agnostic AI working layer.
2. docs is AIP Mirror project knowledge.
3. AIP-specific root references/ stays outside .ai.
4. AI-infrastructure references may live in .ai/references/.
5. .ai/architecture/ exists conceptually; exact taxonomy remains open.
6. .ai/archive/ is preferred for retained historical AI-infrastructure research.
7. .ai/handoffs/ is the likely durable home for handoff state.
8. conversation-handoff is unnecessarily verbose as a directory name.
9. .ai/skills/handoff/ is preferred.
10. .ai/rules/handoff/lifecycle.md is preferred over .ai/rules/conversation-lifecycle.md.
11. AGENTS.md is a small AI repository entry point, not a copy of .ai/INDEX.md.
12. No nested AGENTS.md is currently needed.
13. docs/PROJECT-INSTRUCTIONS.md should be decomposed rather than blindly renamed.
14. .ai/rules/project-architecture.md is AIP Mirror-specific and should move toward docs/architecture/.
15. docs/architecture/ai-project-instruction-architecture.md belongs conceptually under .ai/architecture/.
16. AI-infrastructure onboarding files belong conceptually under .ai/workflows/.
17. Historical MEC/semantic infrastructure research belongs conceptually under .ai/archive/.
18. The first structural pass must classify before moving.
19. Independent Grok/Qwen review happens after local inventory/classification and before final target-tree selection.
20. No physical restructuring has yet been performed in this pass.
22. Independent Grok and Qwen reviews have now been completed as blind semantic reviews; neither was shown our target tree.
23. Both independent reviews independently support the core .ai versus docs ownership boundary and the treatment of handoffs as conversation state rather than project documentation.
24. Handoff lifecycle, handoff operations, and handoff commits are distinct semantic dimensions and must not be collapsed into one model.
25. Lifecycle describes handoff state; operations describe actions performed on handoffs; commits describe durable repository recording of those actions.
26. A handoff-related operation does not necessarily imply a lifecycle transition, and a handoff-related commit does not necessarily represent a lifecycle transition.
27. The handoffs README is navigation/orientation material, not a lifecycle event or canonical lifecycle rule.
28. BOOTSTRAP is accepted as WORKFLOW material and should be evaluated for placement under .ai/workflows/ rather than .ai/skills/.
29. The current .ai/handoffs/ model with README.md plus numbered specialization directories 01–06 remains the working choice for now; active/archive subdivision is deferred.
30. A separate TODO file is not yet required. Keep the expanding TODO in this working architecture document until the semantic-comparison stage shows that TODO has become an independent durable artifact with its own ownership boundary.

## 18. Deliberately open

Do not silently resolve:
- exact .ai/architecture subfolders;
- exact architecture filenames;
- exact rules taxonomy;
- exact skills taxonomy;
- exact workflows taxonomy;
- whether .ai/handoffs replaces docs/handoffs immediately;
- exact long-term retention/archive policy for handoffs;
- whether docs/PROJECT-INSTRUCTIONS.md survives in reduced form;
- exact AGENTS.md contents;
- exact .ai/INDEX.md contents;
- whether a separate ENTRY.md has any justified role; currently it appears to be a possible redundant semantic layer and is deferred to a later iteration;
- command syntax;
- complete handoff operation vocabulary;
- stable operation IDs;
- exact mapping from handoff operations to commit-message vocabulary;
- whether every handoff operation requires a commit;
- section/fragment ID conventions;
- exact split of .ai/rules/repository.md;
- exact split of .ai/rules/workflow.md;
- exact destination/name of AIP Mirror-specific project-architecture content;
- whether historical filenames should eventually be converted.

## 19. Next work package

The local inventory/classification and two independent blind reviews are now complete.

Do not jump to physical restructuring.

The next stage is **semantic comparison**, not target-tree construction:

1. **Consensus** — findings independently supported by our model, Grok, and Qwen.
2. **Grok-only** — proposals or distinctions introduced only by Grok.
3. **Qwen-only** — proposals or distinctions introduced only by Qwen.
4. **Our-only** — findings present in our model but not independently raised by either reviewer.
5. **Contradictions** — genuine differences in semantic ownership or architecture, excluding mere naming/layout variants.
6. **Architecture questions** — distinguish questions resolvable by principle from questions requiring empirical experiments.
7. Only after that, produce the **v2 target tree**.
8. Only after the v2 target tree is accepted, perform physical moves/merges/splits.

### Handoff TODO

The handoff model requires a dedicated follow-up analysis of:

- lifecycle states and transitions;
- handoff operations;
- handoff commits;
- which operations are lifecycle transitions;
- which operations can occur without a state transition;
- which operations require durable Git recording;
- complete normative handoff commit vocabulary;
- ownership of each operation and transition between current and receiving chapters;
- lifecycle correction/recovery semantics;
- navigation-only edits such as handoff README changes.

Working distinction:

    HANDOFF LIFECYCLE
        = state of the handoff

    HANDOFF OPERATION
        = action performed on the handoff

    HANDOFF COMMIT
        = durable Git record of an operation

Do not freeze the complete operation list or commit vocabulary until this analysis is performed.

### Deferred experiments / research

- Handoff Content Extraction Test: take a real handoff and semantically classify every content unit, attempting to move project knowledge to its canonical owners and testing whether the remainder is bounded conversation state.
- Later iteration: revisit whether .ai/INDEX.md alone is sufficient as the AI infrastructure entry/routing document or whether a distinct ENTRY.md has a justified semantic role. Current working position: no separate ENTRY.md.
- Later: evaluate whether TODO remains appropriately embedded in this architecture working document or has grown into an independent durable artifact.

## 20. Safety

No physical file moves or deletions are authorized by this working document.

For existing-file mutations:

    READ CURRENT FILE
          |
    minimal change
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

## 21. North star

> Keep the AI working on the project instead of making the AI manage an elaborate system for working on the project.

The .ai structure must earn each additional component through actual use.

The new organization should allow reusable AI infrastructure to migrate to another project without carrying AIP Mirror-specific assumptions with it.
