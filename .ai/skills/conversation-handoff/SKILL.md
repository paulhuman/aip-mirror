---
name: conversation-handoff
description: Create a durable state snapshot when an AIP Mirror conversation approaches a contextual limit, reaches a major milestone, or is being continued in a new chapter.
---

# Conversation handoff

Use this skill to preserve the working state of an AIP Mirror conversation before continuing in a new chapter.

The goal is continuity without requiring the next conversation to reconstruct important state from an old chat.

## Why handoffs exist

A conversation is a finite AI working context, not a durable execution environment. Handoffs exist to preserve project continuity when work moves from one bounded conversation to another.

A chapter may need to continue in a new conversation because of:

- a large accumulation of conversation history;
- approaching context limits;
- degradation of reasoning quality as context becomes large or distant;
- increasing risk of hallucination or reconstruction from incomplete context;
- browser or conversation instability;
- the need for a clean new conversation context;
- the need to preserve durable project state independently of the health or availability of the old conversation.

The repository handoff state must therefore outlive the conversation that created it. No old conversation or specialization is required to remain available in order for a later chapter to reconstruct or correct canonical handoff state.

## When to use

Use this skill when:

- contextual risk is becoming significant;
- the user asks to continue in a new chapter;
- a major milestone has been reached;
- the current conversation is becoming very long or technically dense;
- important working state exists only in the conversation.

Do not create a handoff for every ordinary message.

## Important limitation

Do not claim to know an exact remaining context percentage or exact number of remaining messages.

Use qualitative contextual-risk assessment instead.

## Repository write-capability self-check

Before any handoff operation that could modify the repository, the AI MUST determine which capability applies:

- **WRITE-CAPABLE AI** — the AI can create/update repository files and create commits in the target repository.
- **READ-ONLY AI** — the AI can inspect repository contents but cannot create/update repository files or create commits.
- **UNCERTAIN** — if write capability cannot be reliably established, treat the AI as READ-ONLY AI.

Follow exactly one capability branch in the relevant handoff procedure. A WRITE-CAPABLE AI must ignore READ-ONLY instructions; a READ-ONLY AI must ignore repository-write instructions.

An AI must never claim a repository operation or lifecycle transition occurred unless it actually performed and verified it.

## Output location

Create or update the applicable file under:

    docs/handoffs/

Naming convention:

    <specialization><chapter>-<short-name>.md

The current generic chapter identifier is:

    [0-9]{2}[A-Z]{2}

The final two uppercase letters form a continuous base-26 alphabetical sequence:

    AA → AB → ... → AZ → BA → BB → ... → BZ → CA → ... → ZZ

No letters are skipped.

The sequence is positional and mathematical:

    AA = chapter ordinal 1
    AB = chapter ordinal 2
    AC = chapter ordinal 3
    ...
    AE = chapter ordinal 5
    AF = chapter ordinal 6
    ...
    ZZ = chapter ordinal 676

### Legacy historical identifiers

The former Chapter Identifier Format was:

    [0-9]{2}[A-Z]

Identifiers created under that format remain valid historical identifiers. They MUST NOT be rewritten merely to conform to the current Chapter Identifier Format, and a legacy identifier MUST NOT be interpreted as a current-format identifier.

Legacy and current identifiers occupy different identifier namespaces by format. Historical handoff documents retain their original chapter identifiers and filenames.

Historical chapters occupy their existing ordinal positions when the current format is introduced. They are not renamed into the current format. New chapters continue from the next unused ordinal position.

For specialization `03`, the historical/current ordinal correspondence is:

    ordinal   legacy ID   current-format position

    1         03A         AA
    2         03B         AB
    3         03C         AC
    4         03D         AD
    5         03E         AE
    6         —           AF  ← first new-format Chapter

This is **ordinal correspondence only**. It does NOT establish identifier identity. In particular:

    03A ≠ 03AA
    03B ≠ 03AB
    03C ≠ 03AC
    03D ≠ 03AD
    03E ≠ 03AE

`03AA`–`03AE` are not historical aliases and are not physically used as current identifiers in this repository.

## Handoff structure

Use this structure unless a project-specific format requires otherwise:

    # Conversation Handoff

    Conversation:
    AIP Mirror — XXYY — <Specialization>

    Specialization:
    <01 / 02 / 03 / 04>

    Chapter:
    <AA / AB / AC / ... / ZZ>

    Previous chapter:
    <chapter or N/A>

    Status:
    DRAFT

    ## Current objective

    ## Completed

    ## Current implementation state

    ## Decisions

    ## Open questions

    ## Current files

    ## Relevant references

    ## Important constraints

    ## Evidence / confidence

    ### Confirmed / observed

    ### Inferred

    ### Assumed / unverified

    ### Open

    ## Last completed task

    ## Immediate next task

    ## Things not to redo

    ## Recommended starting context for next chapter

## Lifecycle rules

Handoff status is a state machine, not an informal label:

    DRAFT
      ↓
    READY_FOR_HANDOFF
      ↓
    HANDED_OFF
      ↓
    SUPERSEDED

The valid forward transitions are:

- `DRAFT` → `READY_FOR_HANDOFF`
- `READY_FOR_HANDOFF` → `HANDED_OFF`
- `HANDED_OFF` → `SUPERSEDED`

Do not skip states.

### Ownership of transitions

The chapter that is closing prepares its handoff and may move it from `DRAFT` to `READY_FOR_HANDOFF` once the next chapter can continue without guessing.

The receiving chapter, not the previous chapter, owns the transition from `READY_FOR_HANDOFF` to `HANDED_OFF`. It must make this transition only after successfully starting from the previous handoff, except when an explicitly authorized Lifecycle Recovery establishes that the required terminal state already exists and must not be repeated.

A later chapter owns the transition from `HANDED_OFF` to `SUPERSEDED` when a newer handoff for the same specialization replaces the older one.

The previous chapter must never mark its own handoff `HANDED_OFF` merely because the handoff was written, committed, or communicated.

`SUPERSEDED` is a required historical transition, not an optional status. When a later handoff for the same specialization reaches `READY_FOR_HANDOFF`, the later chapter must mark the previously `HANDED_OFF` handoff `SUPERSEDED` and commit that lifecycle transition. The older handoff remains in the repository as historical state.

### READY_FOR_HANDOFF supersession invariant

The `SUPERSEDED` transition is an explicit precondition/postcondition of a later handoff becoming successfully `READY_FOR_HANDOFF`.

When the current chapter's handoff is about to move from `DRAFT` to `READY_FOR_HANDOFF` and a previous handoff for the same specialization is already `HANDED_OFF`:

1. the current chapter MUST identify that previous handoff;
2. the current chapter MUST own and perform `HANDED_OFF` → `SUPERSEDED` on that previous handoff;
3. the current chapter MUST verify the previous handoff now reads `SUPERSEDED`;
4. the current chapter MUST verify that the current handoff reads `READY_FOR_HANDOFF`;
5. the current chapter MUST NOT declare the `READY_FOR_HANDOFF` transition complete while the previous handoff remains `HANDED_OFF`;
6. the lifecycle result MUST be represented by Git commit(s), with one coherent commit containing both related changes preferred when practical.

If the previous handoff remains `HANDED_OFF`, the current chapter must treat the `READY_FOR_HANDOFF` transition as incomplete/invalid and stop before proceeding with migration.

This verification must inspect repository state, not rely on the AI remembering that the supersession step was performed.

### Non-negotiable handoff ownership invariants

These are mandatory lifecycle constraints, not recommendations:

1. **The closing chapter MUST modify only its own handoff during the closing/migration phase, except for the mandatory `HANDED_OFF` → `SUPERSEDED` transition on the previous same-specialization handoff required by the `READY_FOR_HANDOFF supersession invariant`.**
2. **The closing chapter MUST NOT create the receiving chapter's handoff file.**
3. **The closing chapter MUST NOT modify, finalize, or assign a lifecycle status to the receiving chapter's handoff.**
4. **The closing chapter MUST NOT change its own handoff from `READY_FOR_HANDOFF` to `HANDED_OFF`.**
5. **Only the receiving chapter MAY create and own its own initial `DRAFT` handoff.**
6. **Only the receiving chapter MAY perform `READY_FOR_HANDOFF` → `HANDED_OFF` on the previous chapter's handoff.**
7. **The migration command does NOT change the identity of the current conversation.** The current chapter remains the closing chapter until a new receiving conversation is actually initialized.
8. **The closing chapter MUST treat the next chapter as a future recipient, not as the current execution context.**
9. **A bootstrap instruction is a message for a future receiving conversation; generating that instruction MUST NOT be interpreted as having entered or initialized that next chapter.**
10. **If the current chapter has already created or modified the receiving chapter's handoff, the lifecycle procedure has been violated and the AI MUST stop before performing further lifecycle transitions and report the inconsistency.**
11. **The receiving chapter MUST correct its own handoff if bootstrap verification finds an inconsistency; another specialization MUST NOT repair that receiving handoff on its behalf.**
12. **A current chapter performing `DRAFT` → `READY_FOR_HANDOFF` MUST NOT leave an older same-specialization `HANDED_OFF` handoff in that state after the transition is declared complete.**

The canonical migration ownership model is therefore:

    CLOSING CHAPTER
        owns:
        current handoff DRAFT → READY_FOR_HANDOFF
        |
        +--> identifies and supersedes the previous HANDED_OFF handoff
        +--> generates bootstrap instruction only

    RECEIVING CHAPTER
        owns:
        creates own DRAFT handoff
        |
        +--> previous handoff READY_FOR_HANDOFF → HANDED_OFF

No step in the closing chapter's migration procedure transfers conversational identity or grants the closing chapter ownership of the receiving handoff.

### Lifecycle Recovery

`Lifecycle Recovery` is a bounded procedure for a receiving chapter whose bootstrap is blocked by a pre-existing lifecycle violation.

The governing principle is:

> **Detection does not imply authorization.**

A receiving chapter that detects a qualifying violation must stop and report it. It must not infer permission to repair the repository from the fact that the violation is understood.

Recovery is allowed only when all of these conditions are satisfied:

1. the current conversation is the receiving chapter;
2. bootstrap is not complete;
3. the violation was detected before the current chapter performed any lifecycle transition;
4. the violation existed in the repository before the current chapter's bootstrap began;
5. the violation directly concerns the handoff/lifecycle state of the current migration;
6. the required recovery is unambiguous under the canonical lifecycle rules;
7. the user explicitly authorizes recovery with the temporary compatibility command:

   Пора восстановить handoff

If any condition is not satisfied, do not perform RECOVERY.

The recovery command is valid only in this blocked recovery context. It is not a general-purpose command for repairing arbitrary handoff or lifecycle state.

### Recovery invariants

RECOVERY is not an ordinary lifecycle transition. It is a bounded recovery procedure that may change only the minimum repository state required to restore canonical bootstrap preconditions for the current receiving chapter.

RECOVERY must:

- never rewrite Git history;
- never use reset, force-push, or equivalent history rewriting to erase the violation;
- never change conversational identity;
- never recreate an already existing receiving handoff merely to simulate initial creation;
- never repeat a lifecycle transition that has already occurred;
- never introduce, remove, skip, or reinterpret lifecycle transitions except where this recovery procedure explicitly permits it;
- never repair unrelated or newly discovered violations;
- preserve correct existing repository state when no correction is necessary;
- use the minimum necessary repository changes;
- verify repository state and relevant Git history before changing anything;
- verify the resulting lifecycle state before declaring recovery complete.

If an existing repository state already satisfies the required final lifecycle condition, RECOVERY must not perform a redundant transition merely to establish or simulate ownership provenance.

For example, if the previous handoff is already `HANDED_OFF` because of a pre-existing violation, the receiving chapter must not repeat `READY_FOR_HANDOFF` → `HANDED_OFF`. If that terminal state is otherwise correct, it may be accepted as the existing state.

### Recovery procedure

After the explicit user recovery command, the receiving chapter must:

1. re-check repository state and relevant Git history before making changes;
2. confirm that the observed violation still matches the qualifying pre-existing recovery scenario;
3. stop and report a new inconsistency if the state changed or recovery is no longer unambiguous;
4. adopt and normalize its own pre-existing receiving handoff as the canonical `DRAFT` handoff rather than pretending that it was newly created during bootstrap;
5. preserve valid checkpoint and architectural context while making only minimum corrections required by the canonical handoff structure;
6. inspect the previous handoff's current status and do not repeat any lifecycle transition already performed;
7. accept an already-correct `HANDED_OFF` previous handoff without creating a redundant transition;
8. make only the minimum repository changes required for recovery;
9. verify every changed file, the diff, and changed-file scope before committing;
10. create only the recovery commit(s) actually required by the changes, using the commit-message rules and clearly identifying the commit as lifecycle recovery;
11. verify the resulting repository state and lifecycle pair;
12. declare `RECOVERY = COMPLETE` only after those checks succeed;
13. continue to the normal post-bootstrap consistency verification before declaring `BOOTSTRAP = COMPLETE` or beginning substantive work.

Recovery does not erase the original violation. Git history remains the authoritative record of what happened.

### Lifecycle Correction

`Lifecycle Correction` is a separate, explicitly authorized procedure for repairing an already-existing historical handoff inconsistency that is discovered after the normal lifecycle moment has passed.

The governing principle remains:

> **Detection does not imply authorization.**

A lifecycle correction is appropriate when all of the following are true:

1. the violation is already present in repository state;
2. the historical lifecycle event that should have caused the correction has already occurred;
3. the canonical correct state can be determined unambiguously;
4. the current active chapter/specialization is capable of performing a bounded correction without relying on the old conversation;
5. the correction does not require rewriting or erasing Git history;
6. the correction scope is limited to the identified lifecycle inconsistency and directly required audit/verification updates;
7. the user explicitly authorizes the correction with:

   Пора выполнить handoff lifecycle correction

If any condition is false, CORRECTION MUST NOT be performed.

The correction command is not a normal lifecycle transition and is not interchangeable with `Пора восстановить handoff`.

#### Correction ownership

The current active chapter/specialization that discovers the violation and can determine and execute the bounded correction under the canonical lifecycle rules owns the correction.

The chapter that originally caused or failed to perform the historical transition does not automatically retain correction ownership. An old conversation is not required for correction and must not be treated as a prerequisite.

Detection does not grant permission. The detecting chapter must first report:

- the historical violation;
- the canonical state that should exist;
- why the correction is unambiguous;
- why the current chapter has ownership and capability to perform it;
- the exact bounded repository scope;
- how historical traceability will be preserved.

It must then wait for the explicit user correction command.

#### Correction invariants

CORRECTION:

- MUST NOT rewrite, delete, reset, force-push, or otherwise conceal Git history;
- MUST NOT pretend that the missed historical transition happened at its original historical time;
- MUST NOT skip lifecycle states in the recorded history;
- MUST preserve the fact that the original lifecycle violation occurred;
- MUST change only the minimum repository state required to restore the canonical recorded state;
- MUST be limited to the identified lifecycle inconsistency and directly necessary audit/verification information;
- MUST NOT repair unrelated violations merely because they are discovered during correction;
- MUST NOT require the original chapter or conversation to remain available;
- MUST verify repository state and relevant Git history before changing anything;
- MUST verify every changed file, the resulting diff, and changed-file scope before committing;
- MUST verify the corrected lifecycle chain after the correction;
- MUST create an explicit Git commit for the correction;
- MUST use the project's commit-message rules and clearly identify the commit as a lifecycle correction;
- MUST retain the original violating commits in Git history.

A correction restores the repository's current canonical state; it does not rewrite the historical sequence that led to the inconsistency.

#### Correction procedure

After explicit user authorization, the active correcting chapter must:

1. re-check the current repository state and relevant Git history;
2. confirm that the reported violation still exists and that the correction remains within the previously reported scope;
3. confirm the canonical expected state from the lifecycle rules and the historical evidence;
4. stop if the repository has changed in a way that makes the correction ambiguous or broader than the authorized scope;
5. modify only the handoff state and directly required audit/verification content within the approved correction scope;
6. read back every changed file from the repository;
7. verify that unrelated content was preserved;
8. inspect the resulting diff and changed-file scope;
9. verify the corrected lifecycle chain, including all relevant predecessor and successor handoffs, not merely the immediate pair;
10. create the correction commit with a clear lifecycle-correction message;
11. verify the resulting commit/ref and repository state;
12. declare `CORRECTION = COMPLETE` only after all checks succeed.

For a missed `HANDED_OFF` → `SUPERSEDED` transition, the correction must record the affected older handoff as `SUPERSEDED` while preserving the historical commits that show the transition was missed. The corrective commit is the audit trail of the later correction; it must not be presented as the original lifecycle transition.

## New chapter initialization

When a new chapter is initialized, it must immediately create its own handoff file with status `DRAFT`.

This is mandatory for every new chapter, including the first chapter of a specialization and every later alphabetical chapter.

The new chapter may create this initial `DRAFT` handoff without asking the user for permission. The initialization is part of the standard bootstrap procedure, not an optional development change.

If a pre-existing receiving handoff is discovered during bootstrap, do not silently recreate or overwrite it as though it were a normal initial-DRAFT creation. Apply the lifecycle rules and, if the bootstrap is blocked by a qualifying pre-existing violation, wait for the explicit Lifecycle Recovery command before making recovery changes.

The initial handoff must capture the chapter identity, previous chapter, starting objective, known starting state, and any other information already established during bootstrap. It may be incomplete because its purpose is to become the live checkpoint document for the new chapter.

The initial creation must be committed immediately. This is an explicit exception to the normal user-review-before-commit rule for AI-assisted changes.

## Checkpoint updates

A handoff in `DRAFT` is a live checkpoint document for the current chapter.

The user may request a checkpoint update with:

    Пора обновить handoff

When this command is used, the current chapter must:

1. create the handoff if it does not yet exist;
2. update it with the current chapter state;
3. keep its status as `DRAFT`;
4. verify the resulting content and scope;
5. commit the checkpoint without asking for separate user permission.

Checkpoint commits are not migrations. They are ordinary, auditable `DRAFT` checkpoint commits that preserve the current working state.

Checkpoint updates may be repeated throughout the chapter. A checkpoint should be created when meaningful state has accumulated, not after every ordinary message.

## Migration

When the user requests migration to the next chapter, for example:

    Пора выполнить миграцию в чат 02AB

first perform the repository write-capability self-check above.

### WRITE-CAPABLE AI migration branch

A WRITE-CAPABLE AI must finish the current work, update the current handoff, and move it from `DRAFT` to `READY_FOR_HANDOFF` only when the next chapter can continue without guessing.

The current chapter owns this transition and must commit it.

Before declaring `DRAFT` → `READY_FOR_HANDOFF` complete, apply the `READY_FOR_HANDOFF supersession invariant` above. If a previous same-specialization handoff is `HANDED_OFF`, it must be changed to `SUPERSEDED` and physically verified before the migration transition is considered complete.

After that, generate the standard bootstrap instruction for the receiving chapter using `.ai/skills/conversation-handoff/BOOTSTRAP.md`.

Do not mark the handoff `HANDED_OFF` in the closing chapter.

### READ-ONLY AI migration branch

A READ-ONLY AI must not modify or commit the repository.

Instead, it must prepare the complete current handoff as it should exist for migration, including `DRAFT` → `READY_FOR_HANDOFF` only as the **proposed manual repository state** when that transition is appropriate. It must return the entire proposed handoff file content to the user and provide the exact commit message for the manual handoff update.

A READ-ONLY AI must not claim that the handoff was changed to `READY_FOR_HANDOFF`, that any supersession transition was performed, or that any commit occurred.

A READ-ONLY AI must not append the separate bootstrap instruction to this long handoff response. If the user needs the missing bootstrap instruction, use the explicit `Пора выдать bootstrap-инструкцию` command separately.

A READ-ONLY AI may identify the lifecycle transition(s) that the user must apply manually, but must not represent those transitions as completed.

### Common migration rule

No migration branch may mark the handoff `HANDED_OFF` in the closing chapter.

### Bootstrap instruction recovery command

The standard migration workflow must generate the bootstrap instruction for the future receiving chapter. If the AI completed or discussed the migration but forgot to provide that instruction, the user may explicitly issue:

    Пора выдать bootstrap-инструкцию

Treat this as a direct request to generate the missing bootstrap instruction for the receiving chapter using `.ai/skills/conversation-handoff/BOOTSTRAP.md`.

This command does **not** initialize the next chapter, does **not** change lifecycle state, and does **not** authorize repository writes by itself.

The generated instruction must contain the required runtime values for the receiving chapter:

    CURRENT_CHAPTER = <current chapter>
    NEXT_CHAPTER = <next chapter>
    SPECIALIZATION = <specialization>

The instruction is for a future receiving conversation. It must not be presented as evidence that the receiving chapter has already started.

This command may be used both by WRITE-CAPABLE and READ-ONLY AI. A READ-ONLY AI must generate only the bootstrap instruction requested by this command and must not claim that the receiving chapter was initialized or that any repository lifecycle operation occurred.

## Writing rules

Be concrete.

Prefer:

    `src/.../MirrorTool.cpp` currently handles mouse tracking.

over:

    "We worked on the mirror tool."

Record decisions and their rationale when that rationale matters to future work.

Record unresolved questions rather than inventing answers.

Do not hide uncertainty.

Do not copy the entire conversation into the handoff.

Do not duplicate stable project documentation unnecessarily.

## Project knowledge versus conversation state

Put durable project knowledge in the appropriate project documentation.

Use the handoff for temporary or chapter-specific state such as:

- what was being investigated;
- what was just changed;
- what remains unfinished;
- what the next chapter should do first;
- which conversation-specific assumptions still need validation.

## Before marking READY_FOR_HANDOFF

Verify that the handoff answers:

1. What were we trying to accomplish?
2. What is already complete?
3. What is the current state of the implementation?
4. What decisions were made?
5. What remains unresolved?
6. Where are the relevant files?
7. What should happen next?
8. Which statements are confirmed versus uncertain?

Also verify the `READY_FOR_HANDOFF supersession invariant` before declaring the transition complete.

Only mark the handoff `READY_FOR_HANDOFF` when the next chapter can reasonably continue without guessing and the previous same-specialization handoff, when applicable, is already verified as `SUPERSEDED`.

## Receiving a handoff

When a new chapter starts from a previous handoff, first read `.ai/skills/conversation-handoff/BOOTSTRAP.md` and perform its repository write-capability self-check.

Then follow exactly one of the capability branches defined by BOOTSTRAP.md:

- A **WRITE-CAPABLE AI** performs the repository-writing bootstrap procedure and its post-bootstrap verification.
- A **READ-ONLY AI** performs only the read-only branch: it does not create, update, or commit repository files; it prepares the complete proposed receiving handoff with status `DRAFT` and provides the exact manual initial-DRAFT commit message to the user.
- An AI that cannot establish write capability must treat itself as READ-ONLY.

A READ-ONLY AI must not claim that `DRAFT` creation, `HANDED_OFF`, a commit, post-bootstrap verification, or `BOOTSTRAP = COMPLETE` occurred.

If a read-only bootstrap is being performed, do not append the separate bootstrap-instruction command to the handoff response. The complete handoff file and its manual commit message are the required output of the read-only bootstrap branch.

If the receiving handoff already exists, do not pretend that normal initial creation occurred. Apply the capability-specific rules in BOOTSTRAP.md. A qualifying pre-existing lifecycle violation blocks normal bootstrap; a READ-ONLY AI must report it and cannot perform Lifecycle Recovery.

If Lifecycle Recovery is authorized, follow the recovery procedure above. Do not repeat a lifecycle transition that the repository already contains in the required final state.

### Post-bootstrap consistency verification

The receiving chapter must verify the resulting state as a coherent lifecycle chain, not only an immediate pair, after both required bootstrap commits have completed or after authorized recovery where applicable.

At minimum:

1. read back the receiving chapter's own handoff;
2. confirm that its own status remains `DRAFT`;
3. confirm that `Previous chapter` identifies the handoff from which it actually started;
4. confirm that `Immediate next task` describes the first real task after bootstrap, not an action already completed during bootstrap or recovery;
5. read back the previous handoff after the lifecycle transition or authorized recovery;
6. confirm that the previous handoff is now `HANDED_OFF`;
7. confirm that the previous and receiving handoffs form a consistent lifecycle pair;
8. inspect the relevant earlier handoff for the same specialization when one exists;
9. if a predecessor handoff is `HANDED_OFF` even though the current receiving handoff has already replaced it, treat that as a lifecycle-chain inconsistency and stop/report rather than silently repairing it;
10. if any check fails, treat bootstrap as incomplete and correct only the receiving chapter's own handoff when the correction is within normal ownership or explicitly authorized recovery scope; otherwise stop and report the inconsistency;
11. re-read the corrected handoff and repeat the verification until it passes.

The receiving chapter owns correction of its own handoff. Another specialization may detect and report an inconsistency, but must not edit the receiving chapter's handoff on its behalf.

Bootstrap is complete only after this verification succeeds.

Recovery completion is not itself bootstrap completion and does not by itself authorize substantive work.

## After migration

A handoff remains `HANDED_OFF` after successful migration until a later handoff for the same specialization reaches `READY_FOR_HANDOFF`. At that point, the later chapter must update the older handoff to `SUPERSEDED` and commit that lifecycle transition. The later chapter must physically verify the superseded state before declaring its own `READY_FOR_HANDOFF` transition complete.

## Project Workshop boundary

The `04` specialization may help with IDE configuration, build systems, Git commands, repository mechanics, SDK/tooling setup, ChatGPT interface questions, and general development learning.

When a Workshop discussion produces a durable project decision, record it in the appropriate project documentation rather than leaving it only in the Workshop conversation.

Do not use `04` as a substitute for:

- `01` JSX behavioral prototyping;
- `02` native C++/AIP implementation;
- `03` architecture, research, specifications, or project-wide decisions.
