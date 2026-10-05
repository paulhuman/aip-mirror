# Migration recovery test result

**Run:** 2026-10-03 22:45 local chapter context
**Scenario:** `.ai/tests/scenarios/migration-recovery.md`
**Status:** INCOMPLETE — bounded runtime verification performed; full five-case PASS not established.

## Runtime boundary

The migration command behavior was exercised at the assistant-response boundary against the live repository state.

Repository evidence observed before the test:

- active handoff: `.ai/handoffs/C/C0060-Architecture-Research.md`;
- `Specialization = C`;
- `Chapter = 0060`;
- no archived C0059 handoff was found at `.ai/archive/handoffs/C/C0059-Architecture-Research.md`.

No temporary predecessor or future handoff was created merely to manufacture test evidence.

## Case 1 — active/archive evidence

### Active evidence

**Input:** live repository, specialization C.

**Observed:** active C0060 handoff has a valid canonical header.

**Result:** RECOVERED/KNOWN candidate `0060`; active-evidence branch is exercised.

### Archive-only evidence

**Input:** live repository.

**Observed:** no archived C0059 handoff exists at the checked path.

**Result:** archive-only recovery could not be exercised against actual archive evidence in this run.

### Active + archive duplicate

**Input:** same-chapter active/archive pair.

**Result:** structural contract check only. The canonical rules specify that equal semantic identity is duplicate-location evidence, not contradiction. No duplicate fixture was created because the scenario explicitly forbids modifying predecessor/future handoffs merely to simulate recovery.

## Case 2 — first chapter / no handoff

**Input:** migration assertion `>>migrate 0002` with no specialization handoff evidence.

**Result:** structural contract check only. The canonical rule accepts candidate predecessor `0001` under the first-chapter invariant and does not require a predecessor handoff. A non-first candidate with no evidence remains UNKNOWN.

No real repository handoff was created for this synthetic case.

## Case 3 — duplicate / contradictory evidence

**Inputs:** same semantic chapter; different chapters; malformed identity; unreconcilable continuity.

**Result:** structural contract check only.

Expected canonical classification:

- same specialization + same chapter in active/archive = duplicate;
- different chapter / malformed identity / unreconcilable continuity = contradiction;
- contradiction = UNKNOWN/STOP;
- newest path or numerically latest handoff is not a valid tie-breaker.

No contradictory fixture was injected into the live handoff directories.

## Case 4 — UNKNOWN / mismatch STOP

### Migration mismatch

**Input:** `CURRENT_CHAPTER = 0060`, command `>>migrate 0062`.

**Observed runtime behavior:** STOP. Expected target is `0061`; `0062` does not override sequential derivation. No repository mutation was performed for the mismatch.

### Valid migration

**Input:** `CURRENT_CHAPTER = 0060`, command `>>migrate 0061`.

**Observed runtime behavior:** accepted. Derived target is `0061`.

The current C0060 handoff was updated as the real migration checkpoint and committed as:

`38a7049a292edc72e83bc47c6773dc418b1f4416`

Commit message:

`ai-docs(handoff): update C0060`

The migration did not create or modify a future C0061 handoff.

## Case 5 — non-circular user recovery

**Input:** UNKNOWN followed by a syntactically valid four-digit user-supplied CURRENT_CHAPTER.

**Result:** structural contract check only in this run.

The canonical rule requires:

1. valid user input becomes RECOVERED conversation context;
2. it is not promoted to repository evidence;
3. absent repository evidence MUST NOT cause another UNKNOWN STOP;
4. consistent evidence permits continuation;
5. direct contradiction causes one explicit STOP.

The prohibited loop remains:

`UNKNOWN → ask user → valid user response → UNKNOWN → ask user`

No live UNKNOWN state was induced by deleting or corrupting repository handoffs.

## Repository mutation summary

Only the intended C0060 migration checkpoint was mutated.

No predecessor handoff, future C0061 handoff, duplicate fixture, or contradictory fixture was created.

## Verification

- Migration checkpoint commit scope: one file, `.ai/handoffs/C/C0060-Architecture-Research.md`.
- Read-back after write: successful.
- Commit comparison against prior HEAD: one commit, one modified file.
- Full five-case runtime PASS: **not established**.

## Next test requirement

To obtain a genuine five-case PASS, the repository needs a bounded test harness or disposable repository/branch fixture mechanism that can exercise active/archive duplicate, archive-only, contradictory, and no-handoff recovery without altering canonical predecessor/future handoffs. The current run deliberately does not manufacture those states in the live handoff directories.
