# Conversation Handoff

Conversation:
AIP Mirror — 03AW — Architecture & Research

Specialization:
03 — Architecture & Research

Chapter:
03AW

Previous chapter:
03AV — Architecture & Research

Status:
DRAFT

## Bootstrap state

The 03AV → 03AW receiving bootstrap has been completed from the canonical repository `paulhuman/aip-mirror@main`.

Read during bootstrap:
- `docs/PROJECT-INSTRUCTIONS.md`
- `.ai/skills/conversation-handoff/BOOTSTRAP.md`
- `.ai/skills/conversation-handoff/SKILL.md`
- applicable lifecycle/workflow/repository/handoff-reference rules
- `docs/handoffs/03AV-Architecture-Research.md`
- `.ai/architecture/03AU_ai-infrastructure-restructuring.md`
- `docs/architecture/ai-project-instruction-architecture.md`
- independent Grok and Qwen onboarding sources referenced by the 03AU research context.

The receiving handoff did not previously exist. It is being created as the normal bootstrap DRAFT.

The previous handoff `03AV` was `READY_FOR_HANDOFF` at bootstrap and is to be transitioned to `HANDED_OFF` by this receiving chapter.

## Current objective

Continue Iteration 2 AI-project-instruction infrastructure research.

The next research stage is:

> **SEMANTIC COMPARISON**

Do not begin physical restructuring and do not treat the preliminary target tree as approved.

The comparison must precede v2 target-tree construction.

## Completed before 03AW

- Local inventory/classification of the existing `.ai/` and `docs/` materials was completed in 03AV.
- Independent blind semantic reviews from Grok and Qwen were completed without showing them our target tree.
- The durable working architecture source `.ai/architecture/03AU_ai-infrastructure-restructuring.md` was updated with the resulting consensus and open questions.
- No physical restructuring of the repository has been performed.
- The central semantic boundary remains:
  > If the primary subject is how AI should work with the project, it belongs in `.ai/`. If the primary subject is what AIP Mirror is or how it works, it belongs in `docs/`.

## Accepted working decisions

### Semantic levels

- LOCATION — coherent semantic kind is in the wrong place → MOVE.
- CONTENT BOUNDARY — one file contains multiple semantic responsibilities → DECOMPOSE.
- LIFECYCLE — material is no longer active infrastructure → ARCHIVE.

### Semantic kinds

- RULE = what must be true
- SKILL = reusable capability
- WORKFLOW = ordered procedure
- README = orientation/navigation

README must not become a second canonical normative source.

### Ownership

Primary subject:
- how AI should work with the project → `.ai/`
- what AIP Mirror is or how it works → `docs/`

### Handoff model

Keep three distinct dimensions:

1. Handoff lifecycle:
   `DRAFT → READY_FOR_HANDOFF → HANDED_OFF → SUPERSEDED`
2. Handoff operations:
   actions performed on handoffs; full vocabulary is not yet fixed.
3. Handoff commits:
   durable Git recording of operations.

Key principle:

> Handoff lifecycle describes state; handoff operations describe actions; commits describe durable repository recording of those actions.

Therefore:
- operation ≠ state transition
- handoff commit ≠ lifecycle transition

Examples already accepted:
- UPDATE: `DRAFT → DRAFT`
- MARK_READY: `DRAFT → READY_FOR_HANDOFF`
- HAND_OFF: `READY_FOR_HANDOFF → HANDED_OFF`
- CORRECT: state may remain unchanged.

### Handoff location

Current working solution remains:

```
.ai/handoffs/
├── README.md
├── 01/
├── 02/
├── 03/
├── 04/
├── 05/
└── 06/
```

Do not replace this now with `active/archive`.

### BOOTSTRAP

Conceptually accepted as WORKFLOW material. Future restructuring should evaluate it under `.ai/workflows/`, not as an independent semantic kind.

### ENTRY

Do not introduce a separate `ENTRY.md` now.

Current working hypothesis:
`.ai/INDEX.md` may be sufficient as the AI entry/routing layer.

This remains deferred to iteration 3 and is not final proof.

### TODO

Do not create a separate TODO artifact now.

The TODO remains in `.ai/architecture/03AU_ai-infrastructure-restructuring.md` until semantic comparison demonstrates that it needs independent durable ownership.

## Preliminary classification to test during comparison

These are working classifications, not final physical instructions.

### `.ai/rules/`
- `conversation-lifecycle.md` → conceptually `.ai/rules/handoff/lifecycle.md`
- `handoff-references.md` → conceptually `.ai/rules/handoff/references.md`
- `project-architecture.md` → conceptually `docs/architecture/...`
- `workflow.md` → DECOMPOSE
- `repository.md` → DECOMPOSE

### `.ai/skills/`
- `commit-message/SKILL.md` → KEEP + DECOMPOSE
- `deep-understanding/SKILL.md` → KEEP
- `conversation-handoff/SKILL.md` → conceptually handoff skill
- `conversation-handoff/BOOTSTRAP.md` → WORKFLOW material
- `handoff-reference-preservation/SKILL.md` → conceptually handoff/reference-preservation skill

### `.ai/architecture/`
- `03AU_ai-infrastructure-restructuring.md` → KEEP as current working architecture research source.

### `docs/architecture/`
AI-infrastructure documents conceptually moving to `.ai/`:
- `ai-project-instruction-architecture.md`
- `independent-review-deepseek-onboarding.md`
- `independent-review-grok-onboarding.md`
- `independent-review-qwen-onboarding.md`

Historical AI-infrastructure research is conceptually ARCHIVE under `.ai/archive/`.

### `docs/handoffs/`
Conceptually MOVE to `.ai/handoffs/`.

Do not mechanically copy `docs/handoffs/README.md`; it is navigation/orientation material.

### `docs/PROJECT-INSTRUCTIONS.md`
Treat as composite and DECOMPOSE:
- AI-infrastructure material → `.ai/`
- AIP Mirror project knowledge → `docs/`
- repository entry-point material → `AGENTS.md`

Avoid duplicate canonical ownership.

## Commit-message issue

Base vocabulary currently agreed:
- `docs(handoff): add <chapter>`
- `docs(handoff): update <chapter>`
- `docs(handoff): mark <chapter> ready for handoff`
- `docs(handoff): mark <chapter> handed off`

This is not the complete normative MUST-set.

Do not invent the complete handoff commit vocabulary before semantic comparison and the dedicated handoff analysis.

## Semantic comparison protocol

Perform these stages in order:

1. **Consensus**
   - findings independently supported by our model, Grok, and Qwen.
2. **Grok-only**
   - substantive ideas or distinctions introduced only by Grok.
3. **Qwen-only**
   - substantive ideas or distinctions introduced only by Qwen.
4. **Our-only**
   - substantive conclusions present in our model but not independently raised by Grok/Qwen.
5. **Contradictions**
   - genuine contradictions in semantic ownership, architecture, or lifecycle.
   - differences that are only names or physical layout are not contradictions.
6. **Architecture questions**
   - determine which questions are resolvable by semantic reasoning/principle;
   - separate questions requiring an experiment or empirical validation.
7. Only after this comparison, construct the **v2 target tree**.
8. Only after the v2 target tree is accepted, perform physical restructuring.

## Handoff-specific open analysis

Still requires dedicated analysis of:
- lifecycle states and transitions;
- operation vocabulary;
- operations that do not change lifecycle state;
- which operations require durable Git recording;
- complete normative handoff commit vocabulary;
- ownership of operations/transitions between current and receiving chapters;
- correction/recovery semantics;
- navigation-only README changes.

Deferred experiment:
- Handoff Content Extraction Test.

## Deliberately unresolved

Do not silently resolve:
- exact `.ai/architecture/` taxonomy;
- exact architecture filenames;
- exact `.ai/rules/`, `.ai/skills/`, and `.ai/workflows/` taxonomy;
- exact physical handoff target;
- exact decomposition of `docs/PROJECT-INSTRUCTIONS.md`;
- exact split of `.ai/rules/repository.md`;
- exact split of `.ai/rules/workflow.md`;
- exact `AGENTS.md` contents;
- exact `.ai/INDEX.md` contents;
- `INDEX.md` vs separate `ENTRY.md`;
- complete handoff operation vocabulary;
- stable operation IDs;
- exact operation-to-commit mapping;
- whether every handoff operation requires a commit;
- section/fragment ID conventions;
- long-term handoff retention/archive policy;
- whether a separate TODO artifact is warranted;
- exact commit-message MUST-set;
- exact final physical layout.

## Important constraints

- No physical restructuring.
- Do not move, rename, merge, split, or delete files merely because a target location is proposed.
- Keep `.ai/` portable across projects.
- Keep AIP Mirror project knowledge in `docs/`.
- Use KEEP / MOVE / DECOMPOSE / ARCHIVE as classification labels.
- Do not use “bootstrap kernel” as an architecture term.
- Human remains the final decision-maker.
- Existing-file mutations must use:
  READ CURRENT FILE → minimal change → WRITE COMPLETE FILE → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT.

## Evidence discipline

Distinguish:
- Confirmed / observed
- Inferred
- Assumed / unverified
- Open

Do not promote a proposal into a decision merely because it appears in a preliminary target tree.

## Last completed task

Completed the 03AV bootstrap-stage work and reached the next research frontier: semantic comparison of the local model against the independent Grok and Qwen reviews.

## Immediate next task

Start **SEMANTIC COMPARISON**.

The first deliverable should be a structured comparison, not a v2 filesystem tree and not a physical repository change.

## Things not to redo

- Do not reconstruct 03AU reasoning from conversation history.
- Do not restart MEC theory.
- Do not re-derive the `.ai/` versus `docs/` boundary unless new evidence contradicts it.
- Do not redo the completed local inventory.
- Do not redo the blind Grok/Qwen reviews.
- Do not treat the preliminary target tree as approved.
- Do not physically restructure the repository.
- Do not reintroduce “bootstrap kernel”.

## Recommended starting context

1. `.ai/architecture/03AU_ai-infrastructure-restructuring.md`
2. `docs/handoffs/03AV-Architecture-Research.md`
3. `docs/PROJECT-INSTRUCTIONS.md`
4. `.ai/skills/conversation-handoff/BOOTSTRAP.md`
5. `.ai/skills/conversation-handoff/SKILL.md`
6. `.ai/rules/conversation-lifecycle.md`
7. `.ai/rules/workflow.md`
8. `.ai/rules/repository.md`
9. `.ai/rules/handoff-references.md`
10. `docs/architecture/ai-project-instruction-architecture.md`
11. `docs/architecture/independent-review-grok-onboarding.md`
12. `docs/architecture/independent-review-qwen-onboarding.md`
