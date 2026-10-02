# Conversation Handoff

**Conversation:**
D0001 — Project Workshop

**Specialization:**
D

**Chapter:**
0001

**Previous chapter:**
N/A

## Current objective

Maintain D0001 as the practical Project Workshop for AIP Mirror using the repository's current `.ai` AI-infrastructure architecture. The current focus is practical tooling, Codex/Codex Desktop, IDE/toolchain work, Git/GitHub mechanics, and controlled observation of AI-assisted repository behavior.

## Completed

- Initialized D0001 as `AIP Mirror — D0001 — Project Workshop`.
- Performed a controlled repository context refresh against the current `main` state rather than relying only on stale conversation context.
- Verified the current repository HEAD as `21fb38ad00f3dd77f85cbb9fca4064b7cf7f67b9`.
- Reviewed the current instruction architecture relevant to D0001, including lifecycle, handoff, repository safety, deep-understanding, and project-architecture guidance.
- Confirmed that C0003 Lifecycle Recovery is already represented in repository history and that recovery remains explicitly authorization-gated.
- Confirmed that the current D0001 conversation is the first chapter in specialization D, so it requires its own initial handoff.
- Confirmed that the repository has migrated from the former 04A-era `docs/handoffs/` model to the current `.ai/handoffs/<specialization>/` model.
- Confirmed that the current handoff model has no required lifecycle-state transitions; handoffs are durable chapter snapshots.
- Confirmed that `>>handoff` is now a checkpoint/update operation on the current handoff.

## Current implementation state

No source-code or production implementation work is currently in progress in D0001.

D0001 is a practical workshop. Its expected scope includes:

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

D0001 does not own AIP Mirror architecture, FreeHand research, JSX behavioral implementation, or native AIP implementation.

## Current AI-infrastructure model

The current repository establishes this operational chain:

```text
user command
    ↓
.ai/INDEX.md
    ↓
operation identification
    ↓
ACTIVATE required canonical owners
    ↓
canonical owner procedure
    ↓
operation
    ↓
operation-level TRACE when required
```

Key current boundaries:

- `.ai/AGENTS.md` is the AI operating contract and new-chapter entry point.
- `.ai/INDEX.md` routes user-facing commands and discovers capabilities; it is not a procedure owner.
- `.ai/config.yaml` establishes repository identity, default branch, and specialization vocabulary before repository-relative paths are resolved.
- `.ai/rules/repository.md` owns repository identity/path resolution and write safety.
- `.ai/rules/handoff/lifecycle.md` owns chapter identity and continuity semantics.
- `.ai/skills/activation/SKILL.md` owns ACTIVATE and the user-visible operation-level TRACE presentation contract.
- `.ai/skills/handoff/SKILL.md` owns handoff structure and handoff operations.
- `.ai/workflows/handoff/BOOTSTRAP.md` owns ordered new-chapter initialization.
- `docs/PROJECT-INSTRUCTIONS.md` is the thin project-specific instruction layer.
- Architecture notes are durable knowledge/reference material, not automatically active semantic owners.

`ACTIVATE` and `TRACE` are capabilities/natural-language interfaces, not separate command IDs. TRACE is response content: for a user-facing `>>` command whose routing requires ACTIVATE, the completed operation-level TRACE is inserted into the assistant response after the operation.

## Decisions

- Chapter identity and model selection are separate concerns. A model is selected by task complexity/capability, not by chapter number.
- D0001 may investigate practical tooling behavior and report architectural findings, but it must not silently replace decisions owned elsewhere.
- Codex experiments should begin with read-only observation before any production write.
- A Codex write is not considered safe merely because an API/write operation succeeds; resulting file content, diff, changed-file scope, commit, and final repository state must be verified.
- Do not add new `.ai` rules merely because Codex fails to understand an existing instruction. First determine whether the cause is architecture, discovery, activation, tool/environment behavior, or model capability.
- The current repository write-safety procedure remains: read → edit → write → read back → verify → diff → scope → commit → verify.
- Handoffs are durable conversation-context snapshots and do not use the former `DRAFT → READY_FOR_HANDOFF → HANDED_OFF → SUPERSEDED` lifecycle in the current architecture.
- `>>handoff` updates the current handoff and commits the checkpoint; it does not change conversation identity.
- `>>migrate <chapter>` updates the current handoff and generates bootstrap transport for the future receiving chapter; it does not create the future receiving handoff.
- `>>generate-bootstrap <chapter>` generates transport only.


## Open questions

- How accurately does Codex Desktop discover and apply the current `.ai` architecture in a local checkout?
- Which canonical owners does Codex actually discover automatically, and which require explicit prompting?
- How does Codex Desktop behave during controlled repository writes under the current write-safety rules?
- How does Codex Desktop compare with the VS Code Codex integration?
- Which model and reasoning controls are actually exposed by the installed Codex environment at test time?
- Which practical tooling observations should be transferred into durable project documentation or architecture work rather than remaining D0001-only knowledge?



## Current files

Primary repository areas relevant to D0001:

- `.ai/AGENTS.md`
- `.ai/config.yaml`
- `.ai/INDEX.md`
- `.ai/rules/`
- `.ai/skills/`
- `.ai/workflows/handoff/BOOTSTRAP.md`
- `.ai/handoffs/D/D0001-Project-Workshop.md`
- `docs/PROJECT-INSTRUCTIONS.md`
- project source and build/tooling files as required by individual workshop tasks
- project source and build/tooling files as required by individual workshop tasks

Canonical external SDK reference:

- `paulhuman/adobe-illustrator-2026-sdk`

The complete SDK must not be copied into `aip-mirror`.

## Relevant references

- `.ai/rules/repository.md`
- `.ai/rules/workflow.md`
- `.ai/INDEX.md`
- `.ai/rules/repository.md`
- `.ai/rules/workflow.md`
- `.ai/rules/handoff/lifecycle.md`
- `.ai/rules/handoff/references.md`
- `.ai/rules/commits.md`
- `.ai/skills/activation/SKILL.md`
- `.ai/skills/handoff/SKILL.md`
- `.ai/skills/commits/SKILL.md`
- `.ai/workflows/handoff/BOOTSTRAP.md`
- `docs/PROJECT-INSTRUCTIONS.md`
- `.ai/handoffs/D/D0001-Project-Workshop.md`

## Important constraints

- Do not use D0001 as a substitute for 01 JSX prototyping, 02 native AIP implementation, or 03 architecture/research/specification work.
- Durable project-wide decisions discovered during workshop work belong in the appropriate project documentation, not only in the D0001 conversation.
- Do not perform Lifecycle Recovery automatically. Detection does not imply authorization.
- The compatibility Recovery command is `Пора восстановить handoff` and is separate from the ordinary handoff workflow.
- Do not rewrite history, force-push, perform blind overwrites, or perform unrelated cleanup during repository work.
- For existing files, always preserve the current content and independently verify the resulting content and diff.
- Do not claim exact remaining conversation context percentage or exact remaining message count.
- Keep communication in Russian while retaining entity names, established terminology, and stable technical expressions in English.

## Evidence / confidence

### Confirmed / observed

- Current repository HEAD is `bd1c54b53927db4cf90b3e4b9e2e281994953ca2`.
- D0001 is the first chapter in specialization D; no previous specialization-D handoff is required.
- The current repository contains the new `.ai/` infrastructure layout and current handoff model.
- D0001 owns practical Project Workshop concerns.
- No D0001 production source implementation has been started in this chapter.
- The current handoff path is `.ai/handoffs/D/D0001-Project-Workshop.md`.
- The current handoff model has no required lifecycle-state transitions.
- `>>handoff` is a checkpoint/update operation for the current handoff.
- `.ai/skills/activation/SKILL.md` centralizes the operation-level TRACE presentation contract.

### Inferred

- The first useful Codex evaluation is a read-only repository/instruction inspection rather than a production modification.
- Comparing Codex Desktop and VS Code behavior can provide evidence about whether differences originate from the instruction architecture, execution environment, tool integration, or model capability.

### Assumed / unverified

- The exact Codex Desktop model/effort configuration available to the user at test time is not established by this handoff.
- The exact degree of automatic instruction discovery/activation performed by Codex Desktop is not established.

### Open

- Actual Codex Desktop behavior must be observed before conclusions are drawn about instruction architecture changes.

## Last completed task

Refreshed D0001 against the current `main` AI-infrastructure architecture, reread the canonical routing/activation/handoff/repository sources, and updated this handoff to replace obsolete 04A-era assumptions with the current D0001 baseline.

## Immediate next task

Continue with the next explicitly requested Project Workshop experiment, preferably a read-only Codex Desktop inspection of the current `.ai` architecture before any controlled write test.

Recommended first test:

> Read and summarize the current repository instruction architecture. Do not modify any files.

Then, separately:

> Inspect current Git status and recent commits. Do not modify anything.

Then:

> Explain which rules would apply before editing an existing repository file. Do not modify anything.

Do not begin a production write test until the read-only observations are reviewed.

## Things not to redo

- Do not repeat the previous 04A-era architecture refresh or lifecycle model.
- Do not recreate the former `docs/handoffs/` chapter structure for current handoff work.
- Do not automatically perform Lifecycle Recovery.
- Do not redesign `.ai` merely because Codex behavior is imperfect.
- Do not introduce a new command registry or universal routing layer without concrete need.
- Do not begin a production AIP implementation from D0001.

## Recommended starting context for next chapter

D0001 is the first Project Workshop chapter. Its durable baseline is the current repository instruction architecture plus the practical Workshop boundary recorded above. If a later D chapter is created, the receiving chapter should read this handoff, inspect the current repository state, and create/update its own handoff according to the current BOOTSTRAP and handoff procedures.
