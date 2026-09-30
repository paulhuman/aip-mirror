# Conversation Handoff

**Conversation:**
C038 — Architecture & Research

**Specialization:**
C

**Chapter:**
038

**Previous chapter:**
037

## Starting objective

Continue the bounded Architecture & Research work from C037 by formalizing the `SHORT_NAME` contract in the canonical BOOTSTRAP workflow and then resolving the remaining semantic questions around generated bootstrap instructions, first-chapter initialization, and interrupted migration before changing active command references.

Do not reopen the accepted `>>` syntax decision.

## Starting state

- Repository: `paulhuman/aip-mirror`.
- Canonical branch: `main`.
- Current chapter: C038.
- Previous chapter: C037.
- Specialization: C.
- Resolved short name: `Architecture & Research`.
- Bootstrap runtime inputs supplied for this chapter:

  ```
  PREVIOUS_CHAPTER = 037
  CURRENT_CHAPTER = 038
  SPECIALIZATION = C
  SHORT_NAME = Architecture & Research
  ```

The canonical BOOTSTRAP runtime contract remains three inputs:

```
PREVIOUS_CHAPTER
CURRENT_CHAPTER
SPECIALIZATION
```

`SHORT_NAME` is supplied context. When omitted, the receiving workflow resolves it through the `specializations → <letter> → short_name` vocabulary in `.ai/config.yaml`.

## Confirmed / observed

- C037 resolved `SHORT_NAME` at the configuration and bootstrap-contract boundary.
- `.ai/config.yaml` contains the specialization vocabulary, including `C → Architecture & Research`.
- `.ai/workflows/handoff/BOOTSTRAP.md` is the canonical ordered receiving/first-chapter initialization workflow.
- `.ai/rules/handoff/lifecycle.md` defines handoffs as durable conversation-context snapshots without lifecycle status transitions.
- `.ai/skills/handoff/SKILL.md` owns handoff capability and structure.
- `.ai/rules/repository.md` owns repository identity/path resolution and repository write safety.
- `.ai/skills/activation/SKILL.md` defines ACTIVATE as rereading the required canonical owners.
- C037 predecessor handoff was read successfully.
- This C038 handoff is being created by a WRITE-CAPABLE AI during bootstrap.
- The active architecture record is `.ai/architecture/ai-infrastructure-restructuring.md`, especially section 29.

## C037 decisions carried forward

### SHORT_NAME

The canonical resolution model is:

```
supplied SHORT_NAME
    ↓ if omitted
.ai/config.yaml specialization vocabulary
    ↓
resolved SHORT_NAME
```

Generated bootstrap instructions SHOULD expose the resolved short name explicitly for human-readable, self-contained context.

Manual bootstrap templates SHOULD expose `SHORT_NAME` explicitly as practical copy/paste context.

No fourth required BOOTSTRAP runtime input has been introduced.

### Command syntax

```
>>
>>operation [arguments...]
```

This decision is accepted and MUST NOT be reopened in this chapter.

The known semantic operations include:

```
>>handoff
>>migrate <chapter>
```

Normal migration MUST invoke bootstrap-instruction generation as its terminal step.

## Relevant canonical owners

- `.ai/config.yaml`
- `.ai/rules/repository.md`
- `.ai/rules/workflow.md`
- `.ai/rules/handoff/lifecycle.md`
- `.ai/rules/handoff/references.md`
- `.ai/skills/activation/SKILL.md`
- `.ai/skills/handoff/SKILL.md`
- `.ai/workflows/handoff/BOOTSTRAP.md`
- `.ai/INDEX.md`
- `.ai/architecture/ai-infrastructure-restructuring.md`
- `.ai/handoffs/README.md`
- `.ai/handoffs/C/C037-Architecture-Research.md`

## Important constraints

- Preserve the `.ai/AGENTS.md` → `.ai/INDEX.md` → ACTIVATE → canonical-owner architecture.
- Keep BOOTSTRAP as the canonical new-conversation initialization workflow.
- Do not introduce a command registry, universal router, command-ID layer, subcommand hierarchy, flag layer, dependency graph, or replacement lifecycle mechanism without concrete evidence.
- Do not migrate active command references until their semantics are stable.
- Distinguish active semantics from historical architecture evidence.
- Preserve the distinction between generated bootstrap instructions and execution of the receiving chapter's BOOTSTRAP workflow.
- For every existing-file mutation, follow repository write safety: read current content, make the minimal intended change, write the complete file, read back, verify content, inspect diff, verify scope, commit, and verify the result.
- Do not create the next receiving-chapter handoff in advance.
- Do not silently treat `SHORT_NAME` as a fourth required canonical runtime input.

## C038 checkpoint

The first bounded implementation step is complete.

### BOOTSTRAP contract

Updated `.ai/workflows/handoff/BOOTSTRAP.md` to formalize:

- supplied `SHORT_NAME` as optional contextual input;
- canonical runtime inputs remaining limited to `PREVIOUS_CHAPTER`, `CURRENT_CHAPTER`, and `SPECIALIZATION`;
- resolution priority: supplied `SHORT_NAME` → configured specialization vocabulary;
- fallback lookup: `specializations.<SPECIALIZATION>.short_name` in `.ai/config.yaml`;
- bootstrap failure when neither a supplied nor configured `SHORT_NAME` is usable;
- use of the resolved `SHORT_NAME` for the receiving handoff filename and conversation title.

Commit: `1efd2d2c585a5b750884158b8f48fcc05d4b9885`.

### Canonical-owner consistency check

Read the current versions of:

- `.ai/rules/handoff/lifecycle.md`
- `.ai/skills/handoff/SKILL.md`

No stale `SHORT_NAME` semantics were found that require changes at this stage. Both continue to delegate chapter initialization to BOOTSTRAP and use the established handoff filename/header model.

The next bounded question remains the exact generated bootstrap-message format and its authoritative data source. Do not yet migrate active command references.

## Confirmed versus uncertain

### Confirmed

- C038 is the receiving chapter.
- C037 is the predecessor.
- `C → Architecture & Research` is configured in `.ai/config.yaml`.
- The canonical BOOTSTRAP runtime contract remains `PREVIOUS_CHAPTER`, `CURRENT_CHAPTER`, and `SPECIALIZATION`.
- `SHORT_NAME` may be supplied as contextual data and otherwise resolved from configuration.
- Generated bootstrap messages SHOULD expose the resolved `SHORT_NAME`.
- `>>` and `>>operation [arguments...]` are accepted.
- Normal migration MUST end with bootstrap-instruction generation.
- The receiving BOOTSTRAP workflow and generated bootstrap instruction are separate concerns.

### Inferred

- BOOTSTRAP should explicitly distinguish supplied `SHORT_NAME` from configuration fallback without changing the three-value runtime contract.
- The exact generated bootstrap-message format should be specified once and then reused by migration and any standalone generation operation.
- First-chapter initialization may not require a dedicated `init` or `new` command if the canonical BOOTSTRAP workflow already expresses the case unambiguously.

### Open

- Exact wording and placement of the supplied/fallback `SHORT_NAME` contract in BOOTSTRAP.
- Exact generated bootstrap-message format and authoritative data source.
- Name and exact semantics of the standalone bootstrap-instruction generation operation.
- Whether first-chapter initialization needs a dedicated user-facing operation at all; if so, whether `init` or `new` is semantically appropriate.
- Whether interrupted migration requires a separate recovery operation or is fully handled by receiving-chapter BOOTSTRAP from durable repository state.
- Validation of the two manual bootstrap templates.
- Exact active command-reference changes in `.ai/INDEX.md` and `.ai/skills/handoff/SKILL.md`.

## Immediate next task

1. Update `.ai/workflows/handoff/BOOTSTRAP.md` to formalize supplied `SHORT_NAME` and fallback through `.ai/config.yaml`.
2. Verify `.ai/rules/handoff/lifecycle.md` and `.ai/skills/handoff/SKILL.md` for consistency; change only stale semantics.
3. Define the exact generated bootstrap-message format and its data source.
4. Determine the standalone bootstrap-instruction generation operation name.
5. Re-evaluate whether first-chapter initialization needs `init`, `new`, or no dedicated operation.
6. Determine whether interrupted migration needs a separate recovery operation or is fully handled by BOOTSTRAP.
7. Validate the two manual bootstrap templates.
8. Only after semantic stabilization, migrate active command references in `.ai/INDEX.md` and `.ai/skills/handoff/SKILL.md`.
9. Finish with a semantic consistency sweep, including `.ai/handoffs/README.md`.

## Recommended starting context

Read:

1. `.ai/workflows/handoff/BOOTSTRAP.md`
2. section 29 of `.ai/architecture/ai-infrastructure-restructuring.md`
3. `.ai/rules/handoff/lifecycle.md`
4. `.ai/skills/handoff/SKILL.md`
5. `.ai/INDEX.md`

Then perform the bounded analysis above. Do not begin a broad infrastructure refactor.
