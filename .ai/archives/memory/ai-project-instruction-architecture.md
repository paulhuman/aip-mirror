# AI Project-Instruction Architecture

**Status:** Iteration 2 — working architecture / migration context
**Purpose:** Practical repository infrastructure for reliable AI-assisted work across finite conversation contexts.
**Repository:** paulhuman/aip-mirror
**Scope:** Meta-agnostic AI working infrastructure; this is not AIP Mirror product architecture.

---

## 1. What This Architecture Is

This architecture concerns the observable external support needed for reliable AI-assisted project work.

The AI's internal algorithms, memory mechanisms, context handling, routing, and model state are treated as a black box.

The observable working surface is:

    HUMAN
      │ instructions / text / files / links
      ▼
    AI / CONVERSATION
      │ read / write / inspect
      ▼
    REPOSITORY
      │ durable project state and working instructions

The architecture therefore describes repository structure, reusable instructions, workflows, handoffs, and verification practices. It does not claim to describe the AI's internal architecture.

---

## 2. Why It Exists

The mechanisms in this architecture appeared because practical work required them.

A handoff exists because conversations end while project work continues. Rules and skills exist because recurring constraints and capabilities should not be reconstructed from conversation history. Workflows exist because some operations need an ordered, repeatable procedure.

These are engineering artifacts discovered through use.

The design principle is:

> Make continuation, reliable execution, and recovery easier without turning ordinary project work into meta-management.

---

## 3. Central Ownership Boundary

The primary Iteration 2 boundary is:

> If the primary subject is how AI should work with the project, it belongs in .ai/. If the primary subject is what AIP Mirror is or how it works, it belongs in docs/.

Therefore:

.ai/ contains:
- rules;
- reusable skills;
- ordered workflows;
- handoff state;
- AI-infrastructure references;
- AI-infrastructure architecture/research;
- operational indexes and small metadata.

docs/ contains:
- AIP Mirror architecture;
- implementation/design;
- Illustrator/FreeHand research;
- specifications;
- validated behavior;
- project decisions;
- project-specific development knowledge.

Root references/ remains AIP Mirror-specific.

This boundary is about semantic ownership, not about which conversation happened to discover the information.

---

## 4. Portability

The .ai/ layer is intended to be reusable across projects.

Conceptually:

    Project
      |
      +-- .ai/          reusable AI working infrastructure
      +-- docs/         project-specific knowledge
      +-- references/   project-specific references

When .ai/ is reused:
- generic infrastructure should migrate;
- current project handoffs should be cleared or replaced;
- historical archive material should be retained deliberately;
- project-specific assumptions must not remain hidden in generic rules.

AIP Mirror-specific architecture therefore belongs in docs/ even when an AI infrastructure conversation first discovered it.

---

## 5. Entry-Point Layers

The intended entry-point relationship is:

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

Roles:
- README.md = human-facing repository orientation;
- AGENTS.md = small AI repository entry point;
- .ai/INDEX.md = discovery/routing map of AI infrastructure;
- docs/PROJECT-INSTRUCTIONS.md = AIP Mirror project-specific instructions and coordination.

These files may reference one another but must not become copies.

A separate ENTRY.md is not currently justified. This remains a later Iteration 3 question.

---

## 6. Conversation Continuity

Conversation is temporary working context. The repository is durable external state.

    conversation N
         |
         | checkpoint / migration
         v
    .ai/handoffs/
         |
         | bootstrap
         v
    conversation N+1

The active handoff lifecycle is:

    DRAFT
      |
      v
    READY_FOR_HANDOFF
      |
      v
    HANDED_OFF

Do not introduce SUPERSEDED as a fourth lifecycle state.

Handoff lifecycle, handoff operations, and handoff commits are separate dimensions:

    lifecycle = state
    operation = action
    commit    = durable Git record

The detailed normative rules belong in .ai/rules/handoff/lifecycle.md and related handoff skills/workflows. This architecture document records the architectural distinction only.

---

## 7. Finite-Context Reliability

Long conversations have repeatedly produced a practical reliability boundary in this project.

The current operational estimate for the present environment is approximately:
- 30 conversation turns/chats;
- and/or roughly 2500 total post text.

This is a project-specific observation, not a universal model limit.

The architectural response is:
- keep chapters reasonably bounded;
- use explicit handoffs;
- bootstrap from durable repository state;
- re-read critical instructions at meaningful checkpoints;
- verify repository changes instead of trusting successful API operations;
- repair stale dependencies after structural changes.

The objective is not to model hidden memory. It is to make the external workflow robust despite finite and uncertain context.

---

## 8. Bootstrap and Re-Read

Bootstrap should establish a compact non-empty initial active context rather than force the AI to read the entire instruction repository.

At chapter start, read:
- project instructions;
- .ai discovery/routing material;
- applicable lifecycle/bootstrap rules;
- the current handoff;
- only project documents required for the specialization.

During a long chapter, deliberately re-read critical instructions:
- after substantial restructuring;
- before high-risk repository operations;
- when switching workflows;
- near a checkpoint;
- whenever the user explicitly requests it.

This is a reliability practice, not a model-internal theory.

---

## 9. Practical Artifact Types

### Rule

A reusable constraint or invariant governing work.

### Skill

A reusable capability/procedure for performing a kind of work.

### Workflow

An ordered procedure with a defined operational purpose.

### Handoff

A durable transfer of conversation working state across a conversation boundary.

### README

Orientation/navigation material. It is not automatically a canonical normative source.

These categories are practical. Do not expand them into a larger ontology without evidence from real work.

---

## 10. Reliability Through External Structure

The reliability model is:

> Important behavior should be made structurally easier to perform correctly than incorrectly.

Useful mechanisms include:
- canonical ownership;
- central discovery/routing;
- explicit lifecycle state;
- handoffs;
- narrow workflows;
- deliberate re-reading;
- repository verification;
- post-edit consistency sweeps;
- human-controlled recovery.

The system should reduce ambiguity rather than add management overhead.

---

## 11. Repository Mutation Safety

For existing-file changes, the established sequence is:

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

A successful API write or Git commit does not prove that the intended content was preserved.

The detailed repository rule is canonical in .ai/rules/repository.md.

---

## 12. Canonical-Owner Change and Consistency Sweep

Iteration 2 established an additional required procedure.

A structural change can leave stale references in files that were not edited.

Observed pattern:

    OLD CANONICAL OWNER
           |
           | ownership moved
           v
    NEW CANONICAL OWNER
           |
           X
    stale dependent still points to old owner

Therefore every move, rename, decomposition, or canonical-ownership change requires a post-edit consistency sweep.

Procedure:

    CHANGE
      |
      v
    READ BACK EDITED FILE
      |
      v
    SEARCH REPOSITORY FOR OLD PATHS / OWNERS / TERMS
      |
      v
    CLASSIFY EACH HIT
      |
      +--> valid reference
      |
      +--> stale dependency
      |
      +--> duplicated normative content
      |
      +--> historical evidence
      |
      v
    REPAIR / REMOVE / RETAIN
      |
      v
    READ BACK
      |
      v
    DIFF + SCOPE VERIFICATION
      |
      v
    COMMIT
      |
      v
    VERIFY RESULT

Minimum search targets:
- old file paths;
- old filenames;
- old canonical-owner references;
- duplicated normative wording;
- removed lifecycle states/concepts;
- stale chapter or specialization identifiers;
- bootstrap references to moved files;
- routing/link targets.

The sweep is semantic rather than a requirement to reread every repository file. Every relevant search hit must be interpreted before being ignored.

This procedure exists because ownership changes alter the dependency graph, not merely one file.

---

## 13. Why the Consistency Sweep Is Architectural

The repository is a shared durable context.

If a new canonical owner is correct but stale dependents remain, the next conversation receives contradictory instructions:

    canonical source
          +
    stale source
          |
          v
    unnecessary ambiguity
          |
          v
    larger active context
          |
          v
    lower reliability

The consistency sweep therefore belongs to the architecture of reliable continuation, not merely to cleanup.

It is a practical form of dependency maintenance after semantic restructuring.

---

## 14. Decomposition Rules

For a mixed document:

    source document
          |
          v
    semantic classification
          |
     +----+----+----+----+
     |    |    |    |    |
    KEEP MOVE DECOMP ARCH REMOVE

Use:
- KEEP when one stable owner already fits;
- MOVE when the content is coherent but located in the wrong semantic layer;
- DECOMPOSE when one file contains multiple owners;
- ARCHIVE when useful historical evidence is no longer active infrastructure;
- REMOVE when the information is already canonically represented elsewhere or no longer needed.

Do not create one file per old section.

Do not relocate duplication merely to make a tree look cleaner.

---

## 15. Dependency Direction

The intended direction is:

    .ai/rules/workflow.md
        |
        +--> generic AI workflow principles

    .ai/rules/repository.md
        |
        +--> repository identity / path resolution / safety

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

The .ai layer may route to project documentation when necessary. Project facts should not be copied back into generic .ai rules.

Avoid reciprocal dependencies that turn a file into an accidental aggregation point.

---

## 16. Iteration 2 Execution Record

Iteration 2 has moved from planning into physical restructuring.

Completed:
- AI-infrastructure architecture/research documents moved from docs/architecture/ into .ai/architecture/ or .ai/workflows/ according to semantic ownership;
- handoff infrastructure moved under .ai/;
- architecture filenames were simplified;
- .ai/rules/workflow.md was decomposed so commit policy has its canonical owner;
- .ai/rules/commits.md was established;
- .ai/skills/commit-message/SKILL.md was renamed to .ai/skills/commits/SKILL.md;
- .ai/rules/repository.md was consolidated;
- repository path resolution was established as a repository-rule responsibility;
- .ai/rules/handoff/lifecycle.md was updated to route path resolution to repository.md;
- docs/PROJECT-INSTRUCTIONS.md was reduced to a thin project-specific layer;
- workstream semantics were clarified as non-autonomous conversation-based work areas;
- .ai/architecture/decomposition-map.md was used to record semantic dependencies before physical changes.

The important outcome is not only the resulting tree. It is the method of finding and removing stale ownership after the tree changes.

---

## 17. Lessons from Iteration 2

The restructuring exposed a recurring pattern:

> Removing an accidental aggregation point reveals dependencies that were previously hidden by duplication.

Example:

    PROJECT-INSTRUCTIONS.md
          |
          | old owner
          v
    repository path resolution

After the ownership moved to:

    .ai/rules/repository.md

a stale dependency remained in lifecycle.md, twice.

The stale text was found only by following the new ownership boundary and searching for the old dependency.

This validates the need for the post-edit consistency sweep as a normal procedure.

---

## 18. Independent Review

Independent Grok and Qwen reviews were completed as blind semantic reviews before the physical restructuring.

Their role is comparative, not authoritative:

    define constraints
          |
    independent proposals
          |
       compare
          |
    human/project decision

Do not treat an external proposal as a decision merely because it is well argued.

---

## 19. Historical Research

Earlier MEC/dynamic-context research remains historical context.

Useful observation:
- active context is dynamic and changes during work.

Do not turn historical semantic hypotheses into filesystem requirements without current evidence.

Do not use bootstrap kernel as an architecture term.

---

## 20. Iteration 2 Goals — Updated

The original goals have been refined by actual execution:

1. separate AI infrastructure from AIP Mirror project knowledge;
2. establish canonical ownership before removing duplication;
3. reduce accidental aggregation points;
4. keep generic .ai infrastructure project-agnostic;
5. keep project-specific semantics in docs/;
6. keep bootstrap compact;
7. make discovery/routing explicit without inventing unnecessary layers;
8. verify structural changes with a post-edit consistency sweep;
9. use real repository work as the validation of the architecture;
10. preserve important migration decisions in durable architecture/handoff files.

---

## 21. Design Test

For every proposed .ai component ask:

1. What concrete failure or recurring task requires it?
2. Can an existing owner or procedure solve the problem?
3. Does it reduce work or add work?
4. Can the AI find the relevant instruction quickly?
5. Can the human understand and repair it?
6. Can the idea be validated through real use?
7. Will the component create another aggregation point or duplicate an existing owner?

If the only justification is theoretical necessity, keep it as a proposal rather than infrastructure.

---

## 22. Current Frontier

The current frontier is no longer the initial target-tree design.

The repository is in the physical Iteration 2 restructuring / consistency-repair stage.

Next chapters should:
- inspect the current repository state;
- use the decomposition map and canonical owners;
- apply the post-edit consistency sweep after structural changes;
- avoid reconstructing earlier planning from chat history;
- continue only where a real semantic or consistency issue remains.

Iteration 3 can revisit:
- the necessity of a separate ENTRY layer;
- command syntax/IDs;
- fragment-ID conventions;
- further empirical tests of the handoff and index model.

---

## 23. North-Star

> Keep the AI working on the project instead of making the AI manage an elaborate system for working on the project.

The repository supplies durable external structure.

The conversation supplies temporary working context.

Rules and skills supply reusable instructions. Workflows supply repeatable procedures. Handoffs bridge conversation boundaries. The index makes those mechanisms discoverable. The human remains the final decision-maker.

Every additional layer must earn its place through observed utility.
