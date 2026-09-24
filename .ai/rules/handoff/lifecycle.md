# Conversation lifecycle rules

## Repository path resolution

This rule inherits the canonical repository identity and path-resolution rule from docs/PROJECT-INSTRUCTIONS.md.

All unqualified repository-relative paths in this rule resolve from:

    REPOSITORY_ROOT = https://github.com/paulhuman/aip-mirror

on the main branch. Use paulhuman/aip-mirror@<ref>:/path when a specific branch, tag, or commit must be explicit for historical or reproducibility purposes.

Do not resolve repository paths from the current working directory, another repository, an attachment, or conversation context.

---

These rules define how AIP Mirror conversations are split into chapters and how work is handed from one conversation to the next.

## Repository path resolution

This rule inherits the canonical repository identity and path-resolution rule from docs/PROJECT-INSTRUCTIONS.md.

All unqualified repository-relative paths in this rule resolve from:

    REPOSITORY_ROOT = https://github.com/paulhuman/aip-mirror

on the main branch. Use paulhuman/aip-mirror@<ref>:/path when a specific branch, tag, or commit must be explicit for historical or reproducibility purposes.

Do not resolve repository paths from the current working directory, another repository, an attachment, or conversation context.

---

These rules define how AIP Mirror conversations are split into chapters and how work is handed from one conversation to the next.

## 1. Conversations are finite workspaces

A chat conversation is working context, not the durable memory of the project.

The repository is the durable project memory.

Do not rely on a long conversation remaining fully available forever. Important discoveries, decisions, specifications, implementation state, and handoff state must be captured in repository files.

### Why handoffs exist

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

## 2. Chapter naming

Each specialization uses a numeric identity followed by a two-letter chapter suffix.

The current Chapter Identifier Format is:

    [0-9]{2}[A-Z]{2}

The first two digits identify the specialization. The final two uppercase letters identify the chapter using a continuous base-26 alphabetical sequence:

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

The ordinal position of a chapter must not be confused with the identity of its identifier.

## 3. Current chapters

Project-wide rules use the current two-letter Chapter Identifier Format rather than hard-coding a single set of current chapter letters.

The concrete current chapter is determined by the active conversation and its corresponding handoff document.

## 4. Early warning

There is no reliable user-visible counter that tells the AI exactly how much conversation context remains.

Therefore, do not claim a precise percentage or number of remaining messages.

Instead, monitor for contextual risk, including:

- a very long conversation;
- a large accumulation of technical state;
- increasing reliance on distant conversation details;
- important decisions that exist only in chat;
- signs that context may no longer be safely retained;
- increasing risk of reconstructing details from incomplete context.

When contextual risk becomes significant, the AI must warn the user before continuing a large task and recommend creating a handoff checkpoint.

Do not wait until context has already been lost.

## 5. Normal checkpoints

Important state should be documented during long-running work when a meaningful milestone is reached.

A checkpoint does not need to be created after every message.

Prefer project documentation for durable knowledge and handoff documents for conversation-specific state.

A `DRAFT` handoff is the live checkpoint document for the current chapter. It may be updated repeatedly as meaningful state accumulates.

The standard user command is:

    Пора обновить handoff

When this command is used, update the current handoff, keep `DRAFT`, verify the result, and create a checkpoint commit. Handoff checkpoint commits are pre-authorized by this project workflow and do not require a separate approval step.

Checkpoint commits are not migration commits. They preserve working state while the chapter remains active.

The standard user migration command is:

    Пора выполнить миграцию в чат [0-9]{2}[A-Z]{2}

This command explicitly requests migration to the specified receiving chapter. When it is used, follow the migration procedure in the conversation-handoff skill and the rules below.

The temporary recovery command is:

    Пора восстановить handoff

This command is valid only inside a blocked receiving-chapter bootstrap whose cause has been identified as a pre-existing lifecycle violation. It is an explicit user authorization for the bounded `Lifecycle Recovery` procedure below. It is not a general-purpose handoff repair command and must not be interpreted outside that recovery context.

The lifecycle correction command is:

    Пора выполнить handoff lifecycle correction

This command is valid only after an active chapter has detected and reported an already-existing historical handoff lifecycle inconsistency, established that the correction is bounded and unambiguous under these rules, and identified itself as capable of performing the correction. It is an explicit user authorization for the bounded `Lifecycle Correction` procedure below. It is not a normal lifecycle transition and must not be interpreted as a general-purpose repository repair command.

## 6. Handoff trigger

A handoff is appropriate when:

- the current chapter is becoming too large or complex;
- a major milestone has been reached and work will continue later;
- the user explicitly requests a chapter migration;
- contextual risk is significant;
- the conversation should be closed without losing its current working state.

## 7. Handoff location

Conversation handoffs belong under:

    docs/handoffs/

Use one file per chapter:

    docs/handoffs/<specialization><chapter>-<short-name>.md

For current-format chapters, the chapter identifier uses `[0-9]{2}[A-Z]{2}`. Examples:

    docs/handoffs/01AA-JSX-Prototype.md
    docs/handoffs/02AB-Native-AIP-Plugin.md
    docs/handoffs/03AF-Architecture-Research.md
    docs/handoffs/04AA-Project-Workshop.md


When a chapter has completed handoff, retain its handoff as historical project state.

## 8. Handoff is a state snapshot, not a casual summary

A handoff must record enough information for the next chapter to continue without guessing.

Include, where applicable:

- current objective;
- completed work;
- current implementation state;
- important decisions;
- open questions;
- relevant files;
- relevant references;
- constraints;
- assumptions;
- unresolved risks;
- last completed task;
- immediate next task;
- things that must not be redone;
- recommended starting context for the next chapter.

## 9. Evidence and confidence

Handoff documents must distinguish:

- Confirmed / observed
- Inferred
- Assumed / unverified
- Open

A handoff must never silently promote an inference or assumption into a confirmed project fact.

## 10. Handoff status

Every handoff must contain an explicit lifecycle status:

- `DRAFT` — live checkpoint state for the current chapter
- `READY_FOR_HANDOFF` — safe starting point for the next chapter
- `HANDED_OFF` — the next chapter has successfully started from this handoff

### Allowed transitions

Handoff status changes follow this state machine:

    DRAFT
      ↓
    READY_FOR_HANDOFF
      ↓
    HANDED_OFF
      ↓

Only these forward transitions are valid:

- `DRAFT` → `READY_FOR_HANDOFF`
- `READY_FOR_HANDOFF` → `HANDED_OFF`

Do not skip states.


### Transition ownership

The responsibility for each transition is explicit:

- The current chapter owns `DRAFT` → `READY_FOR_HANDOFF`.
- The receiving chapter owns `READY_FOR_HANDOFF` → `HANDED_OFF`.

The previous chapter must not mark its own handoff `HANDED_OFF` merely because it has finished writing or delivering it.

### READY_FOR_HANDOFF supersession invariant


When the current chapter's handoff is about to move from `DRAFT` to `READY_FOR_HANDOFF` and a previous handoff for the same specialization is already `HANDED_OFF`:

1. the current chapter MUST identify that previous handoff;
4. the current chapter MUST verify that the current handoff reads `READY_FOR_HANDOFF`;
5. the current chapter MUST NOT declare the `READY_FOR_HANDOFF` transition complete while the previous handoff remains `HANDED_OFF`;
6. the lifecycle result MUST be represented by Git commit(s), with one coherent commit containing both related changes preferred when practical.

If the previous handoff remains `HANDED_OFF`, the current chapter must treat the `READY_FOR_HANDOFF` transition as incomplete/invalid and stop before proceeding with migration.

This verification must inspect repository state, not rely on the AI remembering that the supersession step was performed.

### Non-negotiable handoff ownership invariants

These are mandatory lifecycle constraints, not recommendations:

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

`Lifecycle Recovery` is a bounded procedure for restoring bootstrap preconditions after a pre-existing lifecycle violation is detected by the receiving chapter.

The governing principle is:

> **Detection does not imply authorization.**

Detection of a lifecycle violation does not grant the AI permission to correct it. The receiving chapter must stop and report the inconsistency until the user explicitly authorizes recovery.

Recovery is permitted only when **all** of the following conditions are true:

1. The current conversation is the receiving chapter.
2. Bootstrap is not yet complete.
3. The violation was detected before the current chapter performed any lifecycle transition.
4. The violation existed in the repository before bootstrap of the current chapter began.
5. The violation directly concerns the handoff/lifecycle state of the current migration.
6. The required recovery can be determined unambiguously from the canonical lifecycle rules.
7. The user has explicitly authorized recovery with the temporary compatibility command:

   Пора восстановить handoff

If any condition is false, **RECOVERY MUST NOT be performed**.

The recovery command is valid only in this blocked receiving-chapter recovery context. It must not be treated as a general-purpose request to repair handoffs or lifecycle state.

#### Recovery invariants

`RECOVERY` is not a new ordinary lifecycle transition. It is a controlled recovery procedure that may make only the minimum repository changes necessary to restore canonical bootstrap preconditions for the current receiving chapter.

`RECOVERY`:

- MUST NOT rewrite Git history;
- MUST NOT use reset, force-push, or history rewriting to hide or erase the violation;
- MUST NOT change conversational identity;
- MUST NOT create a receiving handoff again when it already exists;
- MUST NOT repeat a lifecycle transition that has already occurred;
- MUST NOT introduce, remove, skip, or reinterpret lifecycle transitions except where this recovery procedure explicitly permits it;
- MUST NOT repair unrelated or newly discovered lifecycle violations;
- MUST NOT grant the receiving chapter ownership of another chapter's handoff beyond the ownership explicitly defined by the normal lifecycle rules;
- MUST preserve correct existing repository state when no correction is necessary;
- MUST use the minimum necessary repository changes;
- MUST verify the repository state and relevant Git history before making recovery changes;
- MUST verify the resulting lifecycle state after recovery before declaring bootstrap complete.

If an existing state already satisfies the required final lifecycle condition, RECOVERY MUST NOT perform a redundant transition merely to establish or simulate ownership provenance.

For example, if the previous handoff is already `HANDED_OFF` because of a pre-existing violation, the receiving chapter MUST NOT repeat `READY_FOR_HANDOFF` → `HANDED_OFF`. If that terminal state is otherwise correct and the recovery conditions are satisfied, it may be accepted as the existing lifecycle state without an additional transition.

#### Recovery procedure

After explicit user authorization, the receiving chapter must:

1. Re-check the repository state and relevant Git history before changing anything.
2. Confirm that the originally detected violation still matches the pre-existing recovery scenario.
3. If the observed state has changed or the recovery scope is no longer unambiguous, stop and report the new inconsistency.
4. Adopt and normalize its own pre-existing receiving handoff as the canonical `DRAFT` handoff rather than pretending that it was newly created during bootstrap.
5. Preserve valid existing checkpoint and architectural context while making only the minimum corrections required by the canonical handoff structure.
6. Inspect the previous handoff's current status and do not repeat any transition that has already occurred.
7. If the previous handoff already has the required terminal `HANDED_OFF` state, accept that existing state when it is otherwise correct; do not create a redundant lifecycle transition.
8. Make only the minimum repository changes necessary for the recovery.
9. Verify each changed file, the diff, and the changed-file scope before committing.
10. Create only the recovery commit(s) required by the actual changes, using the project's commit-message rules and clearly identifying the commit as lifecycle recovery.
11. Verify the resulting repository state and lifecycle pair.
12. Only after recovery verification succeeds may the receiving chapter declare `RECOVERY = COMPLETE`.
13. Recovery completion does **not** by itself authorize substantive work. The receiving chapter must separately complete the normal post-bootstrap consistency verification before declaring `BOOTSTRAP = COMPLETE`.

Recovery does not erase the fact that the original violation occurred. Git history remains the authoritative record of that history.

### Lifecycle Correction

`Lifecycle Correction` is a separate, explicitly authorized procedure for repairing an already-existing historical handoff inconsistency that is discovered after the normal lifecycle moment has passed.

The governing principle remains:

> **Detection does not imply authorization.**

A lifecycle correction is appropriate when **all** of the following are true:

1. The violation is already present in repository state.
2. The historical lifecycle event that should have caused the correction has already occurred.
3. The canonical correct state can be determined unambiguously.
4. The current active chapter/specialization is capable of performing a bounded correction without relying on the old conversation.
5. The correction does not require rewriting or erasing Git history.
6. The correction scope is limited to the identified lifecycle inconsistency and directly required audit/verification updates.
7. The user explicitly authorizes the correction with:

   Пора выполнить handoff lifecycle correction

If any condition is false, **CORRECTION MUST NOT be performed**.

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

`CORRECTION`:

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

1. Re-check the current repository state and relevant Git history.
2. Confirm that the reported violation still exists and that the correction remains within the previously reported scope.
3. Confirm the canonical expected state from the lifecycle rules and the historical evidence.
4. Stop if the repository has changed in a way that makes the correction ambiguous or broader than the authorized scope.
5. Modify only the handoff state and directly required audit/verification content within the approved correction scope.
6. Read back every changed file from the repository.
7. Verify that unrelated content was preserved.
8. Inspect the resulting diff and changed-file scope.
9. Verify the corrected lifecycle chain, including all relevant predecessor and successor handoffs, not merely the immediate pair.
10. Create the correction commit with a clear lifecycle-correction message.
11. Verify the resulting commit/ref and repository state.
12. Declare `CORRECTION = COMPLETE` only after all checks succeed.


## 11. Starting a new chapter

A new chapter must immediately create its own handoff file with status `DRAFT`.

This is mandatory for every new chapter and is part of chapter initialization.

The initial `DRAFT` handoff creation and its bootstrap commit are pre-authorized parts of the handoff procedure. They must be completed immediately rather than waiting for a separate approval step.

The initial `DRAFT` may be incomplete. At minimum it must identify the new chapter, specialization, previous chapter, starting objective, and starting state established during bootstrap.

For a chapter created from a previous handoff, the receiving chapter must read:

1. `.ai/skills/conversation-handoff/BOOTSTRAP.md`;
2. the applicable project rules;
3. the previous chapter's handoff;
4. any files identified as current implementation state.

After successfully starting from the previous handoff, the receiving chapter must update that previous handoff from `READY_FOR_HANDOFF` to `HANDED_OFF` and commit that transition, **unless a previously authorized Lifecycle Recovery procedure has explicitly established that the required terminal state already exists and must not be repeated**.

### Post-bootstrap consistency verification

The receiving chapter must not declare bootstrap complete immediately after writing the previous handoff's `HANDED_OFF` transition. Before considering bootstrap complete, it must verify the resulting state as a coherent lifecycle chain, not only an immediate pair.

At minimum, the receiving chapter must:

1. read back its own handoff after creation or recovery;
2. confirm that its own handoff still has `Status: DRAFT`;
3. confirm that its `Previous chapter` identifies the handoff from which it actually started;
4. confirm that its `Immediate next task` describes the first real task after bootstrap, not an already-completed bootstrap action;
5. read back the previous handoff after the normal lifecycle transition or authorized recovery;
6. confirm that the previous handoff is now `HANDED_OFF`;
7. confirm that the previous and receiving handoffs form a consistent lifecycle pair;
8. inspect the relevant earlier handoff for the same specialization when one exists;
9. if a predecessor handoff is `HANDED_OFF` even though the current receiving handoff has already replaced it, treat that as a lifecycle-chain inconsistency and stop/report rather than silently repairing it;
10. if any of these checks fail, treat bootstrap as incomplete and correct the receiving chapter's own handoff before beginning substantive chapter work, or stop if the inconsistency is outside the authorized recovery scope.

A bootstrap is therefore complete only after the lifecycle state and the post-bootstrap consistency verification succeed.

The receiving chapter owns correction of its own handoff when this verification detects stale or contradictory bootstrap state. A different specialization may detect and report such an inconsistency, but must not edit the receiving chapter's handoff on its behalf.

The new chapter must not assume that every detail from the previous chat remains available.

## 12. Handoff lifecycle and Git traceability

Every lifecycle transition must be represented by a Git commit.

Initial creation of a new chapter's `DRAFT` handoff and subsequent `DRAFT` updates are also Git-traceable checkpoint commits. They are not migration commits.

A lifecycle transition may be combined with logically related handoff content changes in one coherent commit.

Lifecycle Recovery commits are also Git-traceable. They must record only the actual recovery changes performed and must not rewrite or erase the historical commits that caused the violation.

Lifecycle Correction commits are also Git-traceable. They must record the later correction without rewriting or erasing the historical commits that caused the violation. A correction commit is an audit record of the correction, not a replacement for the missed historical transition.

The repository history should therefore make the workflow auditable:

    new chapter starts → DRAFT handoff created
    checkpoint → DRAFT handoff updated/committed
    receiving chapter starts → HANDED_OFF
    pre-existing violation → blocked bootstrap → user-authorized Lifecycle Recovery → minimal recovery commit(s)
    post-bootstrap consistency verification → bootstrap complete
    historical inconsistency discovered later → report → user-authorized Lifecycle Correction → minimal correction commit → corrected lifecycle chain verified

Use the `commit-message` skill for the required commit-message vocabulary and style.

## 13. Avoid duplicated state

Project knowledge belongs in normal project documentation.

Conversation-specific migration state belongs in `docs/handoffs/`.

Do not turn handoffs into a second, competing documentation system.

## 14. User control

Do not silently migrate a conversation or create a new chapter without telling the user.

When contextual risk makes a handoff advisable, the AI must warn the user and should recommend creating a handoff checkpoint. The user decides when the next chapter is started unless the user has explicitly delegated that decision.

Handoff bootstrap and checkpoint actions that are explicitly defined as pre-authorized by these rules are not subject to an additional approval step.

Lifecycle Recovery and Lifecycle Correction are different: neither is pre-authorized. Each requires the explicit user command defined above after the qualifying violation has been detected, reported, and shown to be within the bounded procedure.
