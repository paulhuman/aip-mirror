# Conversation Handoff

**Conversation:**
C0056 — Architecture & Research

**Specialization:**
C

**Chapter:**
0056

**Previous chapter:**
0055

## Starting objective

Continue Architecture & Research from the durable state established by C0055. Execute the fresh cold-start regression against the updated five-command surface, with particular attention to the renamed `>>normative-language` command and its skill-to-rule read boundary, without reopening resolved TRACE architecture questions.

## Known starting implementation state

- Repository: paulhuman/aip-mirror.
- Canonical branch: main.
- Current chapter: C0056.
- Previous chapter: C0055.
- Specialization: C.
- Resolved short name: Architecture & Research.
- `.ai/AGENTS.md` item 6 directs new-chapter initialization to `.ai/workflows/handoff/BOOTSTRAP.md`.
- `.ai/workflows/handoff/BOOTSTRAP.md` is the canonical new-conversation initialization workflow.
- `.ai/skills/activation/SKILL.md` owns ACTIVATE / TRACE semantics and the TRACE response presentation contract.
- `.ai/skills/handoff/SKILL.md` owns handoff structure and handoff operations.
- `.ai/rules/handoff/lifecycle.md` owns chapter identity and continuity semantics.
- `.ai/rules/handoff/references.md` owns material research-reference preservation.
- `.ai/rules/repository.md` owns repository identity/path resolution and write safety.
- `.ai/rules/workflow.md` owns general workflow and repository inspection guidance.
- `.ai/rules/commits.md` owns commit policy.
- `.ai/skills/commits/SKILL.md` owns commit-message construction and vocabulary.
- `.ai/INDEX.md` is the operational routing and capability-discovery surface.
- `.ai/config.yaml` resolves C to Architecture & Research.
- Repository write and commit capability is available.
- The predecessor handoff exists at `.ai/handoffs/C/C0055-Architecture-Research.md` and was read successfully.
- The centralized operation-level TRACE architecture is implemented.
- The TRACE presentation contract is explicit: execute the operation, accumulate actual reads, assemble the canonical fenced monospace TRACE, and insert it into the assistant response.
- The reusable cold-start command scenario covers the active five-command surface: `>>handoff`, `>>migrate <chapter>`, `>>generate-bootstrap <chapter>`, `>>explain-code`, and `>>normative-language`.
- The normative-language command entry is `.ai/skills/normative-language/SKILL.md`; its canonical semantic owner is `.ai/rules/normative-language.md`.
- `.ai/handoffs/README.md` and `.ai/architecture/README.md` are bootstrap orientation reads, not activation owners.
- New runtime test results belong under `.ai/architecture/tests/results/<test-name>/<run-id>.md`.
- The receiving C0056 handoff is this file.

## Decisions carried forward

- Repository state is the source of truth after an interrupted conversation.
- The receiving chapter creates its own handoff; the predecessor handoff is not modified merely because it has been consumed.
- New-chapter initialization follows AGENTS item 6 and the canonical BOOTSTRAP workflow.
- BOOTSTRAP is the ordered new-conversation initialization workflow; it is not a universal entry router.
- ACTIVATE and TRACE are natural-language interfaces/capabilities rather than separate command IDs.
- Every user-facing `>>` command requiring ACTIVATE uses the centralized operation-level TRACE model.
- OPERATION READS records unique repository files actually read during an operation and does not duplicate ACTIVATE owners.
- For repository-mutating bootstrap/handoff work, `.ai/rules/commits.md` is an operation dependency and is recorded in OPERATION READS, not an ACTIVATE owner.
- Architecture notes preserve durable reasoning but are not active semantic owners.
- Runtime verification must test the actual assistant-response presentation boundary rather than merely simulate repository command behavior.
- The canonical handoff filename contract is explicit: `CHAPTER_ID = SPECIALIZATION + CURRENT_CHAPTER`; handoff filenames use `CHAPTER_ID`, not `CURRENT_CHAPTER` alone.
- `FILENAME_SHORT_NAME` is derived from `SHORT_NAME` by replacing spaces with hyphens.
- The normative-language command is `>>normative-language`; the retired `>>activate-normative-language` phrase is not part of the active command surface.
- The normative-language skill is a thin command entry point; `.ai/rules/normative-language.md` remains the canonical semantic owner.
- The generic ACTIVATE architecture does not require every canonical owner to be a skill.
- `A / Project Workshop` and `A0001-Project-Workshop.md` are canonical neutral format examples only. They are not universal specialization requirements or handoffs to copy into a new project.

## Recent work completed in C0056

The FAQ audit and correction for adapting the `.ai` infrastructure to a new project is complete.

Updated:
- `.ai/architecture/faq/adapting-to-a-new-project.md`

Corrections:
- Removed the false requirement that every project MUST reserve specialization A for Project Workshop.
- Clarified that `A / Project Workshop` is the canonical neutral format example and that other specialization letters and names remain project-specific.
- Removed the inaccurate `shown above` wording from the filename-example explanation.

Commit:
`4633fe1bf687fde49fff1e0d63fe15c3d7106822`
`ai-docs(architecture): clarify specialization example`

The FAQ was also re-audited against the current handoff skill, lifecycle rule, BOOTSTRAP workflow, and handoff README. The four-digit chapter contract is consistent: first chapter `0001`, `0000` invalid, and `CHAPTER_ID = SPECIALIZATION + CURRENT_CHAPTER`.

## Relevant files and references

### Canonical infrastructure

- `.ai/AGENTS.md` — always-on AI operating contract and new-chapter entry path.
- `.ai/config.yaml` — repository identity, default branch, and specialization vocabulary.
- `.ai/rules/repository.md` — repository identity, path resolution, and write safety.
- `.ai/rules/workflow.md` — general workflow and repository inspection guidance.
- `.ai/rules/handoff/lifecycle.md` — chapter identity and continuity semantics.
- `.ai/rules/handoff/references.md` — material reference preservation.
- `.ai/rules/commits.md` — commit policy.
- `.ai/skills/activation/SKILL.md` — ACTIVATE / TRACE capability and presentation contract.
- `.ai/skills/handoff/SKILL.md` — handoff structure and command semantics.
- `.ai/skills/commits/SKILL.md` — commit-message construction and handoff commit convention.
- `.ai/skills/normative-language/SKILL.md` — command entry point for normative-language.
- `.ai/rules/normative-language.md` — canonical normative-language semantic owner.
- `.ai/workflows/handoff/BOOTSTRAP.md` — canonical new-conversation chapter initialization workflow.
- `.ai/INDEX.md` — current routing and capability-discovery surface.

### Architecture and test context

- `.ai/architecture/ai-infrastructure-restructuring.md` — active bounded TODO surface; runtime command verification remains the relevant open work.
- `.ai/architecture/README.md` — architecture-note ownership and usage boundary.
- `.ai/architecture/faq/adapting-to-new-project.md` — FAQ explaining project-specific adaptation boundaries and canonical neutral examples.
- `.ai/architecture/tests/cold-start-command-trace.md` — reusable cold-start test scenario covering the current five-command surface.
- `.ai/architecture/tests/results/cold-start-command-trace/20261002-1352-c0054-to-c0055-runtime.md` — previous real runtime migration result.
- `.ai/handoffs/C/C0055-Architecture-Research.md` — predecessor checkpoint.
- `.ai/handoffs/C/C0056-Architecture-Research.md` — current chapter checkpoint.

## Important constraints

- Do not infer repository or project conventions from memory when canonical repository sources can be read.
- Preserve complete file contents when updating existing files through the GitHub API.
- Do not treat architecture notes as active semantic owners.
- Keep the handoff lightweight and focused on chapter-continuity state.
- Do not claim simulated repository-mutating command behavior as observed runtime evidence.
- Any new runtime test result MUST be recorded under `.ai/architecture/tests/results/<test-name>/<run-id>.md`.
- If canonical files are modified, follow the repository read → minimal change → full write → read-back → verify → diff → scope → commit → result verification sequence.
- Do not reopen resolved TRACE architecture questions without new evidence.
- Do not introduce a registry, manifest, dependency graph, command-ID layer, universal router, new lifecycle state machine, or ENTRY.md without a concrete architectural need.
- For bootstrap/migration evidence, distinguish ACTIVATE owners from additional OPERATION READS and do not duplicate owners in the latter.
- The cold-start test scenario is a reusable input artifact; runtime result evidence belongs in a separate result file.
- Historical noncanonical handoff filename artifacts remain a separate cleanup concern and MUST NOT be mixed into unrelated runtime verification.

## Confirmed / observed

- `.ai/config.yaml` confirms repository paulhuman/aip-mirror, default branch main, and C → Architecture & Research.
- C0055 exists at `.ai/handoffs/C/C0055-Architecture-Research.md` and was read successfully.
- The applicable WRITE-CAPABLE handoff/migration branch applies.
- The centralized TRACE requirements and presentation contract are implemented.
- The current INDEX documents five active user-facing commands.
- The reusable cold-start scenario explicitly names the five-command surface and requires the exact active list to be derived from INDEX at test execution time.
- `.ai/skills/normative-language/SKILL.md` requires reading `.ai/rules/normative-language.md` before executing the normative-language operation.
- The normative-language rule explicitly distinguishes normative, procedural, ordinary-English, and ambiguous uses and forbids blind search-and-replace.
- The FAQ adaptation audit found and corrected the universal-specialization wording and the inaccurate filename-reference wording.
- The FAQ correction commit changed only `.ai/architecture/faq/adapting-to-a-new-project.md`.
- The current FAQ read-back confirmed the corrected wording and absence of the superseded formulations.

## Inferred

- The next bounded architecture task remains the fresh five-command cold-start regression.
- The most useful regression evidence will explicitly verify the `>>normative-language` skill-to-rule boundary and exclusion of the retired command phrase.
- The existing C0054 → C0055 runtime result is evidence for the migration path but is not sufficient evidence for the complete five-command regression.

## Assumed / unverified

- The fresh five-command cold-start regression has not yet been executed in C0056.
- The five-command regression has not yet produced a new result artifact for C0056.
- The runtime behavior of the renamed `>>normative-language` command has not yet been independently verified in this chapter.

## Open

- Execute the fresh five-command cold-start regression from the current INDEX and record the runtime result under `.ai/architecture/tests/results/cold-start-command-trace/`.
- Verify the `>>normative-language` command reads its skill entry point and then its canonical normative-language rule.
- Verify the retired `>>activate-normative-language` phrase is excluded from the active command surface.
- Re-run relevant consistency verification after any active routing, bootstrap, activation, or handoff change.
- Review remaining active TODO items only within their existing bounded scope.
- Separately decide how to reconcile historical noncanonical `0001-JSX Prototype.md` / `0002-JSX Prototype.md` artifacts after the filename-contract regression work, without mixing that cleanup into unrelated runtime verification.

## Immediate next task

Run the fresh five-command cold-start regression against the current `.ai/INDEX.md`, then record the runtime result under `.ai/architecture/tests/results/cold-start-command-trace/` without reopening the resolved generic ACTIVATE architecture.

## Recommended starting context

1. `.ai/architecture/ai-infrastructure-restructuring.md` — TODO 3
2. `.ai/architecture/tests/cold-start-command-trace.md`
3. `.ai/architecture/tests/results/cold-start-command-trace/20261002-1352-c0054-to-c0055-runtime.md`
4. `.ai/skills/activation/SKILL.md`
5. `.ai/workflows/handoff/BOOTSTRAP.md`
6. `.ai/skills/handoff/SKILL.md`
7. `.ai/INDEX.md`
8. `.ai/skills/normative-language/SKILL.md`
9. `.ai/rules/normative-language.md`
10. `.ai/rules/handoff/lifecycle.md`
11. `.ai/rules/repository.md`
12. `.ai/rules/commits.md`
13. `.ai/skills/commits/SKILL.md`

## Handoff checkpoint verification

- C0056 is the current chapter being migrated to C0057.
- The chapter header uses the required four-digit chapter format.
- The C0055 predecessor handoff was read successfully before updating this handoff.
- Required handoff, bootstrap, activation, repository, and commit owners were reread before migration.
- The write-capability branch was verified as WRITE-CAPABLE.
- The C0056 handoff content was updated with the latest durable state, including the completed FAQ audit and correction.
- Post-update read-back and content verification are required before migration is considered complete.
