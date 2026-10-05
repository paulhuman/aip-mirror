# Test: migration CURRENT_CHAPTER recovery

## Purpose

This file defines the bounded test scenario for the canonical external/bootstrap `CURRENT_CHAPTER` input, internal `CURRENT_CHAPTER_CONTEXT` recovery, and `>>migrate <chapter>` validation contract.

The scenario is an input artifact. Test results MUST be recorded separately under:

    .ai/tests/results/migration-recovery/<run-id>.md

The scenario MUST NOT be treated as runtime evidence.

## Test fixture boundary

A complete run MUST use disposable Git branches or equivalent isolated repository fixtures when a case requires handoff evidence that does not exist in the canonical history.

Fixture mutations MAY create, remove, or alter handoff files inside the isolated test environment. They MUST NOT be treated as canonical project history.

The test result MUST record the fixture branch or equivalent isolation boundary used for each mutated case.

## Canonical cases

A complete run MUST exercise all five recovery cases below.

### Case 1 — active/archive evidence

Start without active conversation chapter context.

Test:

- valid active handoff evidence for one chapter;
- archive-only valid handoff evidence for one chapter;
- active + archive copies of the same semantic chapter.

Expected:

- active evidence can recover the chapter when continuity is unambiguous;
- archive-only evidence can recover the chapter when active evidence is absent;
- active + archive copies of the same chapter are duplicate-location evidence, not contradictory chapters.

### Case 2 — first chapter / no handoff

Start with no handoffs for the specialization.

Test the migration assertion:

    >>migrate 0002

Expected:

- candidate predecessor `0001` is considered;
- `0001` is valid as the first chapter under lifecycle rules;
- no predecessor handoff is required solely to establish the first-chapter invariant;
- the case MUST NOT invent a registry or persistent current-chapter state.

Also test a non-first candidate with no evidence.

Expected:

- it remains UNKNOWN rather than being guessed.

### Case 3 — duplicate / contradictory evidence

Test:

- active and archive copies whose headers identify the same specialization and chapter;
- evidence whose headers identify different chapters;
- malformed or specialization-mismatched handoff identity;
- continuity that cannot be reconciled.

Expected:

- same-chapter copies are duplicates;
- unreconcilable identity or continuity is contradictory;
- contradictory evidence produces UNKNOWN/STOP;
- recovery MUST NOT choose the newest path or numerically latest handoff merely as a tie-breaker.

### Case 4 — UNKNOWN / mismatch STOP

Test UNKNOWN recovery.

Expected STOP prompt:

    CURRENT_CHAPTER = <four-digit numeric value>

The prompt MUST explicitly show a four-digit example such as `0059`.

Then test a migration argument that does not equal:

    CURRENT_CHAPTER_CONTEXT + 1

Expected:

- migration MUST STOP;
- the argument MUST NOT override the sequential target;
- when current chapter context is not established, the user MUST be asked for `CURRENT_CHAPTER` using the same four-digit format.

### Case 5 — non-circular user recovery

After an UNKNOWN STOP, supply a valid four-digit `CURRENT_CHAPTER`; internally record that value as `USER_SUPPLIED_CURRENT_CHAPTER` and use it to establish `CURRENT_CHAPTER_CONTEXT` after validation.

Test two branches:

1. repository evidence remains absent;
2. repository evidence exists and is consistent.

Expected:

- the supplied value becomes `USER_SUPPLIED_CURRENT_CHAPTER` and, after validation, RECOVERED `CURRENT_CHAPTER_CONTEXT`;
- it is not treated as repository evidence;
- absent evidence MUST NOT trigger another UNKNOWN STOP;
- consistent evidence allows continuation;
- direct contradiction produces one explicit STOP explaining the contradiction.

The following sequence MUST NOT occur:

    UNKNOWN → ask user → valid user response → UNKNOWN → ask user

## Pass criteria

A run PASSES only when all five cases behave as specified, including the non-circular user recovery branch.

The result MUST distinguish:

- repository evidence;
- user-supplied recovery input;
- `CURRENT_CHAPTER_CONTEXT`;
- `USER_SUPPLIED_CURRENT_CHAPTER`;
- `USER_ASSERTED_NEXT_CHAPTER`;
- `EXPECTED_TARGET`;
- STOP conditions;
- successful continuation.

No result MUST claim runtime execution unless the command was actually exercised at the assistant-response boundary. Structural review or simulation MUST be labeled as such.

## Non-goals

The test MUST NOT:

- introduce a registry, manifest, dependency graph, command-ID layer, universal router, lifecycle state machine, or persistent current-chapter state file;
- change the documented `>>migrate <chapter>` syntax;
- treat `<chapter>` as a target selector;
- mutate canonical handoff history merely to simulate recovery;
- conflate duplicate active/archive evidence with contradiction.
