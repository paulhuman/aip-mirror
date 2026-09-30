# Conversation Handoff

**Conversation:**
C034 — Architecture & Research

**Specialization:**
C

**Chapter:**
034

**Previous chapter:**
033

## Starting objective

Continue the bounded Architecture & Research work from C033. C033 closed the bootstrap runtime-input normalization question and C034 first corrected the historical C031 handoff header defect. The current bounded objective is to substantially simplify the handoff model by removing lifecycle status bookkeeping while preserving receiving-chapter handoff creation and durable context continuity.

## Starting state

C034 verified that the canonical handoff-header rule already requires the Previous chapter field to contain only the three-digit chapter number. No additional canonical rule gap was found. The historical C031 defect was corrected from:

    Previous chapter:
    030 — Architecture & Research

to:

    Previous chapter:
    030

The correction was committed as:

    aec5211f7c2346d93471bb17f0e03b8e9c9ae5ba
    fix(handoff): normalize C031 previous chapter

The current handoff architecture was then reviewed from a broader operational perspective. The three-state lifecycle:

    DRAFT
      ↓
    READY_FOR_HANDOFF
      ↓
    HANDED_OFF

creates substantial bookkeeping overhead and Git-history noise without preserving information that cannot already be represented by the handoff file, chapter identity, and Git history.

## Confirmed / observed

- Repository: `paulhuman/aip-mirror`, branch `main`.
- Current chapter: C034.
- Previous chapter: C033.
- Specialization: C.
- The receiving chapter creates its own handoff at the beginning of a new conversation. This invariant is retained.
- Handoff status transitions are the source of a large class of unnecessary lifecycle-only mutations and commits.
- Conversation termination may be abrupt because of context limits, browser/session instability, or other interruption; a required final status transition is therefore operationally fragile.
- Handoff commits are AI-infrastructure bookkeeping and should be visually distinguishable from project documentation commits.
- The desired normal handoff commit vocabulary is intentionally short:

  ai-docs(handoff): create C033
  ai-docs(handoff): update C033

- Normal handoff commit messages MUST NOT append conversation titles, task descriptions, rationale, milestone summaries, or other explanatory suffixes.

## Architectural decision

C034 adopts the following target model:

> **A handoff is a persistent conversation-context snapshot for a chapter, not a lifecycle-controlled transfer object.**

The active handoff schema MUST NOT contain a Status field.

The following lifecycle states are removed from the active architecture:

    DRAFT
    READY_FOR_HANDOFF
    HANDED_OFF

No replacement state machine is introduced.

The receiving chapter still creates its own handoff at initialization:

    new conversation
        ↓
    establish repository + chapter context
        ↓
    read predecessor handoff when applicable
        ↓
    create current chapter handoff
        ↓
    commit initial handoff
        ↓
    substantive work

A current chapter may update its handoff whenever meaningful durable context accumulates. There is no required closing transition before the conversation ends.

The receiving chapter reads the predecessor handoff but does not modify it merely to mark it as consumed. There is no receiving transition equivalent to READY_FOR_HANDOFF → HANDED_OFF.

Chapter identity and bootstrap runtime-input normalization remain unchanged:

    PREVIOUS_CHAPTER = <three-digit previous chapter number or N/A>
    CURRENT_CHAPTER = <three-digit current chapter number>
    SPECIALIZATION = <single uppercase specialization letter>

## Consequences

The canonical handoff skill, BOOTSTRAP workflow, INDEX routing, and existing handoff files now require a coordinated migration.

The migration must:

1. remove Status from active handoff files;
2. remove lifecycle-state procedures and commands that exist solely to maintain the removed state machine;
3. preserve receiving-chapter creation of its own handoff;
4. preserve chapter identity and bootstrap invocation normalization;
5. preserve meaningful handoff content and historical context;
6. use the short `ai-docs(handoff): create/update <chapter>` commit convention;
7. perform a repository-wide semantic consistency sweep for stale lifecycle terminology;
8. avoid introducing a replacement state machine.

The existing lifecycle recovery/correction machinery is expected to become obsolete if its only purpose is repairing the removed status model. This must be established by the implementation pass rather than assumed without inspection.

Historical Git commits MUST NOT be rewritten. Existing lifecycle commits remain historical evidence of the former architecture.

## Handoff commit convention

For normal handoff creation and content updates, use exactly these forms:

    ai-docs(handoff): create C034
    ai-docs(handoff): update C034

Keep these messages short. The handoff commit itself is the durable Git trace; the handoff file contains the useful context.

The local `ai-docs` namespace is an intentional repository convention for `.ai/` infrastructure. It is not presented as a replacement for Conventional Commits.

Project documentation remains under the normal project-facing `docs(...)` vocabulary.

## Important constraints

- Preserve the established AGENTS → INDEX → ACTIVATE → canonical-owner architecture.
- Treat `.ai/skills/handoff/SKILL.md` as the canonical owner of handoff structure unless repository evidence identifies a more specific owner.
- BOOTSTRAP remains the canonical ordered new-conversation chapter initialization workflow.
- Do not reintroduce a lifecycle status field under another name.
- Do not create a new handoff state machine merely to replace the removed one.
- Do not remove the receiving chapter's responsibility to create its own handoff.
- Do not conflate full chapter identifiers such as C034 with the numeric chapter component 034.
- Preserve historical Git commits; this is an active-architecture migration, not history rewriting.
- Use the repository write-safety procedure for every existing-file mutation.

## Immediate next task

Migrate the work to C035 and continue with the bounded semantic consistency sweep over the active .ai infrastructure.

The C034 continuation plan has been recorded in:

    .ai/architecture/ai-infrastructure-restructuring.md

The next chapter MUST:

1. inspect active canonical .ai rules, skills, workflows, and INDEX for stale lifecycle-state semantics;
2. distinguish active stale behavior from valid historical descriptions in the architecture record;
3. change the handoff continuity wording from MAY to SHOULD:
   
       A current chapter SHOULD update its own handoff whenever meaningful durable context accumulates.

4. remove the stale Status field from the example in .ai/skills/handoff/SKILL.md;
5. verify that the architecture record matches the resulting active canonical semantics;
6. perform final content/scope verification;
7. only then determine whether any concrete architectural contradiction remains.

The sweep MUST NOT introduce a replacement lifecycle state machine or a new infrastructure layer merely to create another task.

The mass removal of legacy Status fields from remaining handoffs was completed manually by the user in:

    3985ac491462effe68cc5e1fd93485a08ec9c821
    ai-refactor(handoff): remove legacy status fields

C034's continuation plan is therefore the next bounded piece of work, not another handoff-lifecycle migration.
