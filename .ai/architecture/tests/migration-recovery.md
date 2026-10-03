# Test: migration CURRENT_CHAPTER recovery

## Purpose

This file defines the bounded test scenario for the canonical `CURRENT_CHAPTER` recovery and `>>migrate <chapter>` validation contract.

The scenario is an input artifact. Test results MUST be recorded separately under:

    .ai/architecture/tests/results/migration-recovery/<run-id>.md

The scenario MUST NOT be treated as runtime evidence.

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

    CURRENT_CHAPTER + 1

Expected:

- migration MUST STOP;
- the argument MUST NOT override the sequential target;
- when current chapter context is not established, the user MUST be asked for `CURRENT_CHAPTER` using the same four-digit format.

### Case 5 — non-circular user recovery

After an UNKNOWN STOP, supply a valid four-digit `CURRENT_CHAPTER`.

Test two branches:

1. repository evidence remains absent;
2. repository evidence exists and is consistent.

Expected:

- the supplied value becomes RECOVERED conversation context;
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
- derived migration target;
- STOP conditions;
- successful continuation.

No result may claim runtime execution unless the command was actually exercised at the assistant-response boundary. Structural review or simulation MUST be labeled as such.

## Non-goals

The test MUST NOT:

- introduce a registry, manifest, dependency graph, command-ID layer, universal router, lifecycle state machine, or persistent current-chapter state file;
- change the documented `>>migrate <chapter>` syntax;
- treat `<chapter>` as a target selector;
- modify predecessor or future handoffs merely to simulate recovery;
- conflate duplicate active/archive evidence with contradiction.
