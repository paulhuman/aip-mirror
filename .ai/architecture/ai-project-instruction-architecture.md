# AI Project-Instruction Architecture

**Status:** Iteration 2 — working architecture
**Purpose:** Practical repository infrastructure for reliable AI-assisted work across finite conversation contexts.
**Repository:** paulhuman/aip-mirror
**Scope:** Meta-agnostic AI working infrastructure; this is not AIP Mirror product architecture.

---

## 1. What This Architecture Is

This architecture exists because real AI-assisted project work needs durable external support.

The AI's internal algorithms, memory mechanisms, context handling, and model state are treated as a black box. This project does not attempt to infer or specify those internal mechanisms.

The observable working surface is:

    HUMAN
      │ natural-language instruction / text / files / links
      ▼
    AI / conversation
      │ read / write / inspect
      ▼
    REPOSITORY
      │ durable project state and working instructions

The architecture therefore concerns observable workflow and repository structure, not a hypothetical internal architecture of the model.

## 2. Why It Exists

The mechanisms in this architecture appeared because practical work required them.

A handoff exists because we practically needed a file in which the state of work could be recorded before closing a conversation. Rules, skills, and supporting files likewise appeared because repeated work required reusable instructions and procedures.

They are engineering artifacts discovered through use, not evidence that corresponding abstract semantic layers must exist inside the AI.

> Make continuation, reliable execution, and recovery easier without turning ordinary project work into meta-management.

## 3. Repository Boundaries

`docs/` primarily documents AIP Mirror itself: product architecture, implementation design, Illustrator/FreeHand research, specifications, validated behavior, project decisions, and project references.

`.ai/` contains infrastructure for AI-assisted project work: rules, skills, workflows, indexes, handoff state, and other small operational metadata.

Practical rule:

> If the primary subject is how AI should work with the project, it belongs in `.ai/`. If the primary subject is what AIP Mirror is or how it works, it belongs in `docs/`.

This is the central boundary for Iteration 2 and will be applied to the current `docs/architecture` clutter.

## 4. Conversation and Durable State

Conversation is temporary working context. The repository is durable external project state.

    current conversation
          ↓
       handoff
          ↓
      repository
          ↓
    new conversation
          ↓
       bootstrap
          ↓
    restored working state

A handoff is therefore a practical state-transfer mechanism, not merely a summary.

## 5. Empirical Conversation Limit

Long conversations have produced a repeatable practical failure boundary in this project.

Current working limit for the current Free-plan/current-model environment:

- approximately 30 conversation turns/chats, and/or
- approximately 2500 total text across the posts.

At this length, reliability degradation has been observed repeatedly and is treated as a real operational boundary for this project, not merely a speculative warning.

One observed example: an earlier long chapter incorrectly counted 7 old-format handoff files when there were actually 8.

This is not claimed as a universal model limit. It is a project-specific operational limit established through repeated observation.

Therefore prefer shorter chapters, explicit handoffs, and deliberate re-reading of critical instructions. Do not wait for the boundary when reliability is already degrading.

## 6. Bootstrap and Re-Read

Bootstrap should establish compact initial working context rather than forcing the AI to read the entire instruction repository.

At chapter start, read the project instructions, the `.ai` index, relevant bootstrap/lifecycle instructions, the current handoff, and only the project documents required for the specialization.

During a long chapter, deliberately re-read critical instructions:

- after substantial work;
- before high-risk repository operations;
- when switching workflows;
- near a chapter checkpoint;
- whenever the user explicitly requests it.

The purpose is practical reliability. It does not model the AI's hidden memory algorithm.

## 7. The Index

Iteration 2 will introduce one central index for `.ai/`.

The index must answer:

> What operations are available, when should they be used, and where is the exact instruction for performing them?

The future index should contain at least:

- stable operation/command IDs;
- simple future command syntax;
- short descriptions;
- applicability or trigger conditions;
- exact rule/skill/workflow location;
- preferably a section or fragment target rather than a whole large document.

Conceptually:

    command ID
        ↓
    simple syntax
        ↓
    short purpose
        ↓
    exact instruction fragment
        ↓
    execution
        ↓
    verification

The exact index format is not decided yet.

## 8. Commands

The future command language should be small and simple.

Candidate operation families include:

- initialize/bootstrap;
- read or refresh instructions;
- inspect state;
- create/update handoff;
- migrate chapter;
- verify repository state;
- run a consistency check.

These are candidate operations, not a final command list or syntax.

Command naming and syntax are deliberately delegated to future independent design proposals from Grok/Qwen alongside the primary architecture work.

## 9. Practical Artifact Types

### Rule
A reusable constraint or invariant governing work.

### Skill
A reusable procedure or capability for performing a kind of work.

### Workflow
An ordered procedure with a defined operational purpose. A workflow may physically live under a skill directory; physical location does not define its semantic role.

### Handoff
A durable transfer of chapter working state across conversation boundaries.

These categories are practical distinctions. They must not be expanded into a larger ontology unless real work demonstrates a need.

## 10. Reliability by External Structure

The reliability model is not: The AI will remember everything.

It is:

> Important behavior should be made structurally easier to perform correctly than incorrectly.

Useful mechanisms include canonical instructions, a central index, explicit lifecycle state, handoffs, narrow workflow entry points, instruction re-reads, repository verification, short chapters, and human-triggered recovery.

The objective is to make the observable workflow robust despite unknown and finite model context.

## 11. Repository Safety

For an existing file, the established safety pattern remains:

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

## 12. Handoff Lifecycle

The current lifecycle remains:

    DRAFT
      ↓
    READY_FOR_HANDOFF
      ↓
    HANDED_OFF

The detailed lifecycle procedure belongs in `.ai` workflow/rule files. This document records only the architectural purpose.

## 13. Independent Design Review

Low-risk organizational design should not all be invented inside the primary architecture conversation.

For Iteration 2, Grok and Qwen should be asked for alternative proposals concerning:

- file organization;
- directory structure;
- naming;
- index format;
- command syntax and naming;
- document granularity;
- ID/section conventions;
- other repository ergonomics.

Their proposals are alternatives for comparison, not authority. The human/project decision process chooses what to adopt.

    define problem and constraints
              ↓
        Grok proposal
              +
        Qwen proposal
              ↓
          compare
              ↓
       human decision

This delegation keeps the main architecture work focused while still using independent models for straightforward design choices.

## 14. Explicit Non-Claims

This document does not establish:

- a model-internal memory architecture;
- a routing layer inside the AI;
- a universal discovery protocol;
- a bootstrap kernel;
- a universal metadata ontology;
- a registry/router/manifest architecture;
- a universal dependency engine;
- a universal precedence engine;
- a generic graph architecture;
- a semantic theory of the AI.

Do not use `bootstrap kernel` as an architecture term.

Earlier research established only a practical observation that reasoning requires some available context to begin. That does not justify a permanent semantic component.

## 15. Relationship to Earlier Semantic Research

Earlier MEC/dynamic-context research remains historical research context.

Its useful practical observation is that active context is dynamic and may change during work.

Its more ambitious semantic hypotheses do not automatically determine the Iteration 2 filesystem or workflow.

Repository restructuring should proceed from observed workflow needs, not from forcing an old semantic model into the filesystem.

## 16. Iteration 2 Goals

1. Separate AIP Mirror documentation in `docs/` from AI working infrastructure in `.ai/`.
2. Remove duplicated instructions and obsolete structures.
3. Split oversized instruction files where targeted reading benefits; otherwise use stable section/fragment IDs.
4. Create one central `.ai` index.
5. Make the index point to exact operational instructions rather than whole large files where practical.
6. Establish a simple future command vocabulary.
7. Keep bootstrap compact.
8. Use deliberate re-reading of critical instructions during long chapters.
9. Use the empirical ~30-turn/~2500-post-text boundary conservatively.
10. Validate the new structure by real use rather than trying to make it perfect in one pass.

## 17. Design Test

When proposing a new `.ai` component, ask:

1. What concrete failure or recurring task requires it?
2. Can an existing file or procedure solve the problem?
3. Does it reduce work or add work?
4. Can the AI find the relevant instruction quickly?
5. Can the human understand and repair it?
6. Can we validate it by actually using it?

If the only justification is theoretical necessity, keep it as a proposal rather than infrastructure.

## 18. Current Next Step

Iteration 2 begins with an inventory and classification pass:

1. inspect current `.ai/`;
2. inspect current `docs/`;
3. inspect `docs/architecture/`;
4. classify rules, skills, workflows, handoffs, and research documents;
5. identify duplicated instruction text;
6. identify documents that belong under `.ai/`;
7. propose a target structure;
8. obtain independent Grok/Qwen proposals for low-risk organization, naming, indexing, and command design;
9. compare proposals;
10. only then perform moves, merges, splits, or rewrites.

## 19. North-Star

> Keep the AI working on the project instead of making the AI manage an elaborate system for working on the project.

The repository supplies durable external structure.

The conversation supplies temporary working context.

Rules and skills supply reusable instructions. Workflows supply repeatable procedures. Handoffs bridge conversation boundaries. The index makes those mechanisms discoverable. Commands provide a simple explicit control surface. Independent reviewers provide alternative low-risk organizational designs. The human remains the final decision-maker.

Everything else is implementation detail that must earn its place through real use.