# Conversation Handoff

**Conversation:**
D001 — Project Workshop

**Specialization:**
D

**Chapter:**
001

**Previous chapter:**
N/A

## Current objective

Establish D001 as the practical Project Workshop for AIP Mirror and maintain a synchronized working context for developer tooling, repository mechanics, Codex, IDE/toolchain work, and related practical development questions.

The current immediate objective is to prepare D001 for controlled observation of Codex Desktop for Windows and, later, the VS Code Codex integration, without prematurely changing the project instruction architecture.

## Completed

- Initialized D001 as `AIP Mirror — D001 — Project Workshop`.
- Performed a controlled repository context refresh against the current `main` state rather than relying only on stale conversation context.
- Verified the current repository HEAD as `21fb38ad00f3dd77f85cbb9fca4064b7cf7f67b9`.
- Reviewed the current instruction architecture relevant to D001, including lifecycle, handoff, repository safety, deep-understanding, and project-architecture guidance.
- Confirmed that C003 Lifecycle Recovery is already represented in repository history and that recovery remains explicitly authorization-gated.
- Confirmed that the current D001 conversation is the first chapter in specialization D, so it requires its own initial handoff rather than a previous 04-series handoff.

## Current implementation state

No source-code or production implementation work is currently in progress in D001.

D001 is a practical workshop. Its expected scope includes:

- Git/GitHub workflow and repository mechanics;
- PowerShell;
- IDEs and developer tooling;
- Visual Studio / JetBrains tooling;
- CMake and build setup;
- SDK/tooling setup;
- Codex and Codex Desktop;
- VS Code Codex integration;
- developer-environment troubleshooting;
- practical development workflow experiments.

D001 does not own AIP Mirror architecture, FreeHand research, JSX behavioral implementation, or native AIP implementation.

## Decisions

- Chapter identity and model selection are separate concerns. A model is selected by task complexity/capability, not by chapter number.
- D001 may investigate practical tooling behavior and report architectural findings, but it must not silently replace decisions owned by C003 or another responsible specialization.
- Codex experiments should begin with read-only observation before any production write.
- A Codex write is not considered safe merely because an API/write operation succeeds; resulting file content, diff, changed-file scope, commit, and final repository state must be verified.
- Do not add new `.ai` rules merely because Codex fails to understand an existing instruction. First determine whether the cause is architecture, discovery, activation, tool/environment behavior, or model capability.
- The current repository write-safety procedure remains: read → edit → write → read back → verify → diff → scope → commit → verify.
- `HANDOFF` is a lifecycle mechanism, not a core semantic instruction type.

## Open questions

- How well does Codex Desktop actually discover and apply the repository's current instruction architecture?
- What repository visibility does Codex Desktop provide for `.ai/`, `docs/`, `references/`, and source files?
- How accurately does it understand current Git state, history, diffs, and changed-file scope?
- Does it follow the repository write-safety procedure during a controlled write test?
- How does Codex Desktop's behavior compare with the later VS Code integration?
- Which current model and reasoning controls are actually exposed by the installed Codex environment at test time?

These questions are intentionally unresolved until observed in the actual tooling environment.

## Current files

Primary repository areas relevant to D001:

- `.ai/rules/`
- `.ai/skills/`
- `docs/PROJECT-INSTRUCTIONS.md`
- `.ai/handoffs/`
- `.ai/handoffs/D/D001-Project-Workshop.md`
- project source and build/tooling files as required by individual workshop tasks

Canonical external SDK reference:

- `paulhuman/adobe-illustrator-2026-sdk`

The complete SDK must not be copied into `aip-mirror`.

## Relevant references

- `.ai/rules/repository.md`
- `.ai/rules/workflow.md`
- `.ai/rules/conversation-lifecycle.md`
- `.ai/rules/project-architecture.md`
- `.ai/skills/conversation-handoff/SKILL.md`
- `.ai/skills/conversation-handoff/BOOTSTRAP.md`
- `.ai/skills/commit-message/SKILL.md`
- `.ai/skills/deep-understanding/SKILL.md`
- `docs/PROJECT-INSTRUCTIONS.md`
- `.ai/handoffs/README.md`
- `.ai/handoffs/C/C003-Architecture-Research.md`

## Important constraints

- Do not use D001 as a substitute for 01 JSX prototyping, 02 native AIP implementation, or 03 architecture/research/specification work.
- Durable project-wide decisions discovered during workshop work belong in the appropriate project documentation, not only in the D001 conversation.
- Do not perform Lifecycle Recovery automatically. Detection does not imply authorization.
- The compatibility Recovery command is `Пора восстановить handoff` and is separate from the ordinary handoff workflow.
- Do not rewrite history, force-push, perform blind overwrites, or perform unrelated cleanup during repository work.
- For existing files, always preserve the current content and independently verify the resulting content and diff.
- Do not claim exact remaining conversation context percentage or exact remaining message count.
- Keep communication in Russian while retaining entity names, established terminology, and stable technical expressions in English.

## Evidence / confidence

### Confirmed / observed

- Current repository HEAD is `21fb38ad00f3dd77f85cbb9fca4064b7cf7f67b9`.
- D001 is the first chapter in specialization D; no previous 04-series handoff is required.
- The current repository contains the lifecycle recovery rules and recovery history introduced after the earlier lifecycle violation.
- C003 remains the architecture/research specialization and owns architecture-level questions such as authority, lifecycle semantics, OVERRIDE, TRACE, and project-agnosticity.
- D001 owns practical Project Workshop concerns.
- No D001 production source implementation has been started in this chapter.

### Inferred

- The first useful Codex evaluation is a read-only repository/instruction inspection rather than a production modification.
- Comparing Codex Desktop and VS Code behavior can provide evidence about whether differences originate from the instruction architecture, execution environment, tool integration, or model capability.

### Assumed / unverified

- The exact Codex Desktop model/effort configuration available to the user at test time is not established by this handoff.
- The exact degree of automatic instruction discovery/activation performed by Codex Desktop is not established.

### Open

- Actual Codex Desktop behavior must be observed before conclusions are drawn about instruction architecture changes.

## Last completed task

Performed the D001 Context Refresh and created this initial `DRAFT` handoff because D001 is the first chapter in specialization D.

## Immediate next task

Wait for the user's explicit command to begin the first controlled Codex Desktop observation experiment.

Recommended first test:

> Read and summarize the current repository instruction architecture. Do not modify any files.

Then, separately:

> Inspect current Git status and recent commits. Do not modify anything.

Then:

> Explain which rules would apply before editing an existing repository file. Do not modify anything.

Do not begin a production write test until the read-only observations are reviewed.

## Things not to redo

- Do not repeat the completed repository Context Refresh unless repository state has materially changed or the user explicitly requests another refresh.
- Do not automatically perform Lifecycle Recovery.
- Do not redesign `.ai` architecture merely because Codex behavior is initially imperfect.
- Do not re-establish the specialization boundaries unless a new repository rule changes them.
- Do not treat the model recommendations from conversation context as immutable repository policy.

## Recommended starting context for next chapter

D001 is the first Project Workshop chapter. Its durable baseline is the current repository instruction architecture plus the practical Workshop boundary recorded above. If a later D chapter is created, the receiving chapter should read this handoff, inspect the current repository state, and only then transition this handoff through the normal lifecycle as required.
