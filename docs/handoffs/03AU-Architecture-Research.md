# Conversation Handoff

Conversation:
AIP Mirror — 03AU — Architecture & Research

Specialization:
03 — Architecture & Research

Chapter:
03AU

Previous chapter:
03AT — Architecture & Research

Status:
DRAFT

## Current objective

03AU has pivoted from further MEC/semantic research to Iteration 2 of the practical AI project-instruction infrastructure.

The immediate task is to restructure the repository so that AIP Mirror documentation remains in `docs/`, while meta-agnostic AI working infrastructure moves into `.ai/`.

The guiding principle is:

> Do not design the architecture of an imaginary AI. Design the smallest practical external infrastructure that demonstrably helps the AI work on a real project.

## Key methodological decision

The AI's internal algorithms, memory mechanisms, context handling, and model state are treated as a black box.

We should work from observable interfaces only:

- human natural-language instructions, text, files, and links;
- AI conversation/context available to the current chapter;
- repository reads/writes/inspection;
- durable files used to preserve project and workflow state.

Do not infer an internal AI ontology merely because a repository artifact exists.

## Current practical findings

### Handoff

The handoff mechanism exists because we practically needed a file in which the state of work could be recorded before closing a conversation.

Therefore handoff is evidence of a practical workflow need, not evidence of a fundamental memory ontology.

### Conversation limit

Through repeated use across the current 03A-series, the practical reliability boundary has been established at approximately:

- 30 conversation turns/chats, and/or
- ~2500 total text across posts,

for the current Free-plan/current-model environment.

Near this length, reliability degradation has repeatedly appeared. One concrete example was miscounting 8 old-format handoff files as 7.

Treat this as a real project operational limit, not a universal claim about the model.

Prefer shorter chapters and earlier handoffs. Deliberately re-read critical instructions during longer chapters.

## Iteration 2 repository direction

`docs/` should contain AIP Mirror documentation:

- product architecture;
- implementation/design;
- Illustrator/FreeHand research;
- specifications;
- validated behavior;
- project decisions;
- project references.

`.ai/` should contain AI working infrastructure:

- rules;
- skills;
- workflows;
- central index;
- handoff state;
- small operational metadata.

Practical classification rule:

> If the primary subject is how AI should work with the project, it belongs in `.ai/`. If the primary subject is what AIP Mirror is or how it works, it belongs in `docs/`.

## Important target: `.ai` index

Iteration 2 should introduce one central index answering:

> What operations are available, when should they be used, and where is the exact instruction for performing them?

The future index should list at least:

- stable operation/command IDs;
- simple command syntax;
- short descriptions;
- applicability/trigger conditions;
- exact rule/skill/workflow locations;
- section/fragment targets where practical.

The exact format and command syntax are not yet decided.

## Command design

The future command vocabulary should remain small and simple.

Candidate operations include:

- initialize/bootstrap;
- read or refresh instructions;
- inspect state;
- create/update handoff;
- migrate chapter;
- verify repository state;
- consistency check.

These are candidates only.

Low-risk choices such as command naming, syntax, ID conventions, index layout, file naming, and document granularity should be proposed independently by Grok and Qwen in future work. Their proposals are alternatives for comparison, not authority.

## Bootstrap / re-read policy

Bootstrap should read compact initial context:

1. project instructions required for the chapter;
2. `.ai` index;
3. relevant bootstrap/lifecycle instructions;
4. current handoff;
5. only project documents needed for the specialization.

Do not require full reading of every rule and skill.

During longer chapters, re-read critical instructions:

- after substantial work;
- before high-risk repository operations;
- when switching workflows;
- near checkpoints;
- whenever the user requests it.

## Earlier semantic research

The MEC/dynamic-context work from 03AT remains historical context.

Useful surviving observation:

> Active context is dynamic and may change during work.

Do not continue the old semantic program merely because open questions remain.

Do not reintroduce `bootstrap kernel` as an architectural term.

Do not infer routing layers, discovery metadata, registries, routers, manifests, capability IDs, universal metadata schemas, dependency engines, precedence engines, or graph architectures without concrete evidence from practical work.

## Current file updated

`docs/architecture/ai-project-instruction-architecture.md` has been rewritten as the Iteration 2 working architecture.

It now explicitly:

- treats internal AI behavior as a black box;
- grounds the architecture in observable workflow;
- establishes the `docs/` versus `.ai/` boundary;
- records the empirical conversation limit;
- introduces the central-index direction;
- leaves command syntax open;
- delegates low-risk organizational design to Grok/Qwen;
- treats earlier semantic research as historical rather than as a filesystem blueprint.

## Immediate next task

Perform an inventory/classification pass of the current `.ai/`, `docs/`, and especially `docs/architecture/`.

Do not move or delete files yet.

First produce a target structure and identify:

- files that clearly belong in `.ai/`;
- files that clearly remain in `docs/`;
- duplicated instruction text;
- oversized files suitable for splitting;
- places where stable section/fragment IDs are preferable to additional files;
- candidate operations for the central index.

Then obtain Grok/Qwen alternatives for low-risk organization, naming, index format, and command syntax before choosing.

## Things not to redo

Do not restart the 03AS/03AT MEC bounded experiments merely because this chapter changed direction.

Do not attempt to prove a universal AI memory model.

Do not turn existing repository artifacts into evidence of hidden semantic layers.

Do not try to make Iteration 2 perfect in one pass.

## Repository safety

Any existing-file mutation must follow:

READ CURRENT FILE → minimal change → WRITE COMPLETE FILE → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT.

## Evidence / confidence

### Confirmed / observed

- 03AU is the current Architecture & Research chapter.
- The practical handoff mechanism emerged from the need to preserve state across conversations.
- Long chapters have repeatedly produced concrete reliability errors near the observed boundary.
- The current architecture document has been rewritten for Iteration 2.
- Grok/Qwen are to be used as independent proposal sources for low-risk organizational design.

### Inferred

- `.ai/` is the natural home for meta-agnostic AI working infrastructure.
- A central index can reduce repeated full-document reads if it can point to exact instruction fragments.
- Smaller chapters plus explicit handoffs are preferable to relying on very long conversation context.

### Open

- exact `.ai/` target tree;
- exact files to move from `docs/`;
- exact index representation;
- exact operation IDs;
- exact command syntax;
- file-versus-fragment granularity;
- which old instruction text is redundant or obsolete.

## Recommended starting context for next chapter

Start with:

1. `docs/PROJECT-INSTRUCTIONS.md`;
2. `.ai/skills/conversation-handoff/BOOTSTRAP.md`;
3. `.ai/skills/conversation-handoff/SKILL.md`;
4. `.ai/rules/conversation-lifecycle.md`;
5. `.ai/rules/workflow.md`;
6. `.ai/rules/repository.md`;
7. `.ai/rules/handoff-references.md`;
8. this handoff;
9. `docs/architecture/ai-project-instruction-architecture.md`.

Then inventory the repository before proposing structural changes.