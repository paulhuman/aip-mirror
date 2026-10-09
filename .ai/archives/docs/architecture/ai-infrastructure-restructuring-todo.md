# AI Infrastructure Restructuring TODO

Status: Active bounded TODO
Scope: `.ai` infrastructure, ACTIVATE / TRACE routing semantics, and deferred repository-history cleanup

The previous long-form restructuring notes were archived at:

`.ai/archive/docs/architecture/ai-infrastructure-restructuring.md`

This file is intentionally a small active TODO surface. Historical architectural reasoning MUST remain in the archive rather than being copied forward.

## TODO 1 — Make operation-level TRACE mandatory for user-facing `>>` commands

Decision:

> Every user-facing `>>` command that requires ACTIVATE MUST also expose operation-level TRACE.

Rationale:

`ACTIVATE` establishes the current canonical operational context. Operation-level `TRACE` makes that activation and the repository reads used by the operation observable. For these commands, both are part of correct execution.

Implementation direction:

- `.ai/skills/activation/SKILL.md` SHOULD become the single canonical owner of the exact operation-level TRACE semantics and presentation.
- `.ai/INDEX.md` SHOULD contain one shared routing rule stating that user-facing `>>` commands requiring ACTIVATE also require visible operation-level TRACE.
- Do NOT add a separate TRACE requirement column to the command table unless later evidence shows that per-command variation is genuinely needed.
- Do NOT duplicate TRACE requirements across individual command owners.
- BOOTSTRAP SHOULD be aligned with the same general model rather than retaining a separate, isolated TRACE concept.

Status: RESOLVED

The canonical activation skill now owns the operation-level TRACE semantics and presentation, INDEX contains the shared routing rule, and BOOTSTRAP follows the same model.

## TODO 2 — Preserve the ownership boundary

The intended ownership remains:

```text
INDEX
  = routing and capability discovery

activation/SKILL.md
  = ACTIVATE / TRACE semantics and TRACE response presentation

canonical operation owner
  = operation-specific execution semantics

BOOTSTRAP
  = ordered new-conversation initialization workflow
```

INDEX MUST NOT become a second activation or tracing owner.

Status: RESOLVED

The current activation skill, INDEX routing rule, and BOOTSTRAP alignment implement the required TRACE ownership model. Runtime verification remains separately tracked below because the new-chat initialization still requires investigation.

## TODO 3 — Re-run runtime command verification

After the active files are updated:

- exercise the user-facing commands documented by the current `.ai/INDEX.md`;
- note that the current `.ai/INDEX.md` documents five user-facing commands, while the reusable cold-start test files below currently enumerate only four;
- verify that each command requiring ACTIVATE visibly produces the required operation-level TRACE;
- verify that ACTIVATE owners are not duplicated under OPERATION READS;
- verify that OPERATION READS reflects actual repository reads for the operation;
- preserve the existing cold-start scenario as the stable test input until the discrepancy is classified;
- create a new result artifact rather than rewriting the historical simulation result.

Relevant test artifacts:

- `.ai/tests/scenarios/cold-start-command-trace.md` — reusable cold-start test scenario;
- `.ai/tests/results/cold-start-command-trace/20261002-0900-cold-start-command-trace.md` — historical structural-simulation result;
- `.ai/tests/results/cold-start-command-trace/20261005-2054-c0067-five-command-runtime.md` — genuine five-command runtime audit result.

Status: RESOLVED

The five-command runtime audit was executed against a disposable repository branch. All five commands currently documented by `.ai/INDEX.md` were exercised:

1. `>>handoff`
2. `>>migrate <chapter>`
3. `>>generate-bootstrap <chapter>`
4. `>>explain-code`
5. `>>normative-language`

The audit produced fresh observable operation-level TRACE for every command. ACTIVATE owners were not duplicated in OPERATION READS, and command-specific OPERATION READS were recorded from actual repository retrievals rather than reconstructed from the historical simulation.

The historical 20261002 result remains unchanged. The new runtime evidence is stored separately under `.ai/tests/results/cold-start-command-trace/`.

### Runtime audit result — C0067

Run ID: `20261005-2054-c0067-five-command-runtime`

Result: **PASS**

The canonical command surface and the reusable scenario discrepancy are now classified: the scenario remains a reusable cold-start input, while the new result artifact records the current five-command runtime surface and its observed TRACE/read behavior.

## TODO 4 — Review historical commit messages

The following historical commits use commit messages that do not follow the current `ai-docs(...)` convention:

- `e854cf2dbfdcb0f3802ec3b79df22410c3e59af8`
- `f7e6b63b30eb7ad797c6b0048e166ffee8acf6c8`
- `4ad2cd90f2fe08eb0fa0feba3a5aa5c3345ba912`
- `b523edff4bdc8b785b57c5e4834afdc1ac6b8cbd`

Do NOT rewrite these commits as part of the current TRACE work. Any history rewrite or message correction requires a separate bounded decision.

Status: RESOLVED

The historical messages have been identified and the required boundary is documented: no history rewrite is part of the current TRACE work. Any future correction remains a separate bounded decision.

## TODO 5 — Document GitHub commit signature verification

The `VERIFIED` label observed on commit `4ad2cd90...` is GitHub's cryptographic signature verification indicator, not the project's semantic verification state.

Observed GitHub text:

> This commit was created on GitHub.com and signed with GitHub's verified signature.

The displayed GPG Key ID was:

`B5690EEEBB952194`

The project MUST continue to distinguish:

```text
GitHub signature verification
    ≠
project content verification
    ≠
ACTIVATE / TRACE evidence
```

No architecture change is required for this distinction. The topic is recorded here so it is not accidentally conflated with repository workflow verification later.

Status: RESOLVED

The distinction is documented and requires no further architecture change.


## TODO 9 — Define `CURRENT_CHAPTER` recovery and `>>migrate <chapter>` validation

Decision:

Keep the explicit numeric argument in the active migration command:

    >>migrate <chapter>

The argument MUST NOT become a direct target selector. Its role is a user assertion of the expected next chapter and a safety/validation input.

Canonical migration semantics remain:

    TARGET_CHAPTER = CURRENT_CHAPTER_CONTEXT + 1

The argument MUST therefore equal `TARGET_CHAPTER`. A mismatch MUST stop migration rather than override the sequential target.

### Canonical migration-context determination

`CURRENT_CHAPTER_CONTEXT` has three possible states during migration preparation:

    KNOWN
    RECOVERED
    UNKNOWN

**KNOWN** is established by active conversation/bootstrap context.

When that context is unavailable, repository recovery MUST inspect both:

    .ai/handoffs/<SPECIALIZATION>/
    .ai/archive/handoffs/<SPECIALIZATION>/

Both are evidence sources. A handoff header is authoritative for the semantic candidate:

    Specialization = <SPECIALIZATION>
    Chapter = <four-digit chapter>

The recovery procedure MUST explicitly handle:

1. **Active evidence** — a valid active handoff establishes the candidate when continuity is unambiguous.
2. **Archive-only evidence** — a valid archived handoff establishes the candidate when active evidence is absent and continuity is unambiguous.
3. **First-chapter / no-handoff evidence** — absence of handoffs does not itself establish a current chapter. `0001` is the only valid first chapter. When the migration assertion is `0002`, candidate predecessor `0001` MAY be validated directly under the first-chapter invariant without a predecessor handoff.
4. **Duplicate evidence** — active and archived copies of the same semantic chapter are one chapter with duplicate-location evidence, not two competing current chapters.
5. **Contradictory evidence** — different semantic chapters, malformed identity, or continuity conflicts that cannot be reconciled MUST remain contradictory. Recovery MUST NOT resolve them by choosing the latest path or numerically latest handoff.
6. **No usable evidence** — if no deterministic case establishes the chapter, the state is UNKNOWN.

A stale or missing handoff does not by itself prove that the current conversation has not advanced.

### UNKNOWN and user recovery

If recovery is UNKNOWN, the AI MUST STOP and request:

    CURRENT_CHAPTER = <four-digit numeric value>

The prompt MUST explicitly require four digits, for example `0059`. The supplied value MUST be recorded internally as `USER_SUPPLIED_CURRENT_CHAPTER` and validated before it establishes RECOVERED `CURRENT_CHAPTER_CONTEXT`.

A valid user response becomes `USER_SUPPLIED_CURRENT_CHAPTER` and, after validation, RECOVERED `CURRENT_CHAPTER_CONTEXT` for the pending migration. It is **input**, not repository evidence.

The AI MUST validate that input against repository evidence when evidence exists:

- no evidence → accept the supplied value as recovered context; DO NOT repeat the UNKNOWN STOP;
- consistent evidence → accept and continue;
- direct contradiction → STOP and explain the contradiction.

This is the explicit non-circular rule:

    UNKNOWN
      ↓
    STOP + ask CURRENT_CHAPTER
      ↓
    user supplies four digits
      ↓
    validate against available evidence
      ↓
    RECOVERED
      ↓
    continue migration validation

The absence of repository evidence after the user response MUST NOT send the operation back to UNKNOWN solely because the evidence is still absent.

### Migration argument validation

When `CURRENT_CHAPTER_CONTEXT` is KNOWN or RECOVERED:

    USER_ASSERTED_NEXT_CHAPTER = <chapter>
    EXPECTED_TARGET = CURRENT_CHAPTER_CONTEXT + 1

Migration is valid only when:

    USER_ASSERTED_NEXT_CHAPTER == EXPECTED_TARGET

A mismatch MUST stop migration rather than override sequential target selection.

If the migration argument mismatches and `CURRENT_CHAPTER_CONTEXT` is not established by active context, the AI MUST request `CURRENT_CHAPTER` in the same four-digit format. The supplied value is then `USER_SUPPLIED_CURRENT_CHAPTER` and MUST be validated before establishing `CURRENT_CHAPTER_CONTEXT`; it MUST NOT require a new repository handoff.

Argumentless `>>migrate` is NOT an implicit alias and remains outside the documented command syntax.

No registry, manifest, dependency graph, command-ID layer, universal router, new lifecycle state machine, or separate persistent current-chapter state file is required for this recovery model.

Status: RESOLVED

Implementation is encoded in the canonical migration and lifecycle owners. Dedicated recovery test coverage is defined separately; runtime execution evidence remains subject to the existing test-result process.


## TODO 10 — Define the GitHub disposable-branch fallback for repository fixtures

Decision:

For isolated repository tests that require synthetic repository state, the test harness MUST prefer creating a disposable branch directly from the required commit SHA rather than moving an existing branch ref.

The detailed operational procedure is now canonical in:

    .ai/rules/repository.md
        §8 Disposable repository fixtures

The architectural distinction remains:

    create branch from commit
        ≠
    move existing branch ref

Runtime migration-recovery Cases 1–5 already exercised this strategy successfully through disposable fixture branches. The rule is therefore documentation of an observed repository-testing workflow.

Status: RESOLVED


## TODO 11 — Prepare C0061 for the migration-recovery runtime test

Decision:

The planned C0061 migration-recovery runtime exercise was completed and expanded into the full five-case suite. Cases 1–5 are individually runtime-verified PASS.

Evidence:

- .ai/tests/results/migration-recovery/20261003-2337-c0061-case1-runtime.md
- .ai/tests/results/migration-recovery/20261004-1815-c0062-case2-runtime.md
- .ai/tests/results/migration-recovery/20261005-0022-c0063-case3-runtime.md
- .ai/tests/results/migration-recovery/20261005-0036-c0064-case4-runtime.md
- .ai/tests/results/migration-recovery/20261005-1412-c0064-case5-runtime.md

The suite verifies active/archive recovery, first-chapter handling, duplicate and contradictory evidence, UNKNOWN/STOP behavior, four-digit user recovery input, non-circular recovery, and sequential migration-argument validation.

The canonical migration rules and durable terminology are now encoded in:

- .ai/skills/handoff/SKILL.md
- .ai/rules/handoff/lifecycle.md
- .ai/tests/scenarios/migration-recovery.md
- this architecture record

The durable terminology includes CURRENT_CHAPTER, CURRENT_CHAPTER_CONTEXT, USER_SUPPLIED_CURRENT_CHAPTER, USER_ASSERTED_NEXT_CHAPTER, and EXPECTED_TARGET.

Status: RESOLVED

## TODO 12 — Restructure .ai taxonomy by semantic role

Decision:

> Classify repository locations by semantic role, not by file extension or by whether a file happens to be documentation-shaped.

Accepted semantic model:

```text
                         ┌─ operational entry
                         │
.ai/ ────────────────────┼─ canonical semantic owner
                         │
                         ├─ operational subsystem
                         │
                         ├─ meta documentation
                         │
                         ├─ verification
                         │
                         └─ historical archive
```

Project boundary:

```text
.ai/   = project-agnostic AI infrastructure
docs/  = AIP Mirror project-specific knowledge
```

Accepted active taxonomy:

| Semantic role | Canonical location |
|---|---|
| Operational entry | .ai/AGENTS.md, .ai/INDEX.md, .ai/config.yaml |
| Canonical semantic owner | .ai/rules/ |
| Capabilities | .ai/skills/ |
| Procedures | .ai/workflows/ |
| Operational subsystem / continuity | .ai/handoffs/ |
| Meta documentation | .ai/docs/ |
| Verification | .ai/tests/ |
| Historical archive | .ai/archive/ |
| Project-specific knowledge | docs/ |

The taxonomy is semantic. A README.md inside an operational subsystem remains part of that subsystem when its location carries operational meaning; conversely, durable architecture documentation for the AI infrastructure belongs to .ai/docs/.

Migration mapping:

| Old path | New path | Semantic result |
|---|---|---|
| .ai/architecture/README.md | .ai/docs/architecture/README.md | meta documentation |
| .ai/architecture/ai-infrastructure-restructuring.md | .ai/docs/architecture/ai-infrastructure-restructuring.md | meta documentation |
| .ai/architecture/faq/ | .ai/docs/faq/ | meta documentation |
| .ai/architecture/tests/ | .ai/tests/scenarios/ | reusable verification scenarios |
| .ai/architecture/tests/results/ | .ai/tests/results/ | historical verification evidence |
| .ai/archive/architecture/ | .ai/archive/docs/architecture/ | historical meta documentation |

Historical archive content is preserved. The archive taxonomy changes its semantic container; historical documents are not rewritten merely to modernize their prose.

Reference-impact inventory completed before mutation:

| Reference class | Update |
|---|---|
| Active architecture documentation | update to .ai/docs/... |
| FAQ documentation | update to .ai/docs/faq/... |
| Verification scenarios/results | update to .ai/tests/... |
| Operational routing/bootstrap references | update architecture README reference to .ai/docs/architecture/README.md |
| Historical archive documents | preserve historical content; no bulk rewrite |
| Project-specific docs/ | no taxonomy move; remains project-specific |

Migration scope:

- move all active files under .ai/architecture/ into their accepted semantic destinations;
- move all archived architecture files under .ai/archive/architecture/ to .ai/archive/docs/architecture/;
- preserve file contents for moved artifacts except required path-reference updates;
- preserve verification result artifacts as historical evidence;
- do not change canonical ownership of rules, skills, workflows, or handoffs;
- do not change project-specific docs/ taxonomy;
- update active references so the new taxonomy is self-consistent;
- do not introduce a registry, manifest, or new state mechanism.

Resulting active structure:

```text
.ai/
├── AGENTS.md
├── INDEX.md
├── config.yaml
├── docs/
│   ├── architecture/
│   └── faq/
├── tests/
│   ├── scenarios/
│   └── results/
├── rules/
├── skills/
├── workflows/
├── handoffs/
└── archive/
    ├── docs/
    │   └── architecture/
    └── handoffs/

docs/
├── PROJECT-INSTRUCTIONS.md
└── architecture/
```

Normative follow-up:

The accepted semantic taxonomy MUST later be encoded in the canonical repository/infrastructure rules so a receiving AI can determine the boundary from semantic role alone. The future rule MUST distinguish:

```text
project-agnostic AI infrastructure
    .ai/
        operational entry
        canonical semantic owner
        operational subsystem
        meta documentation
        verification
        historical archive

project-specific knowledge
    docs/
```

Status: RESOLVED

C0066 migration scope is the completed taxonomy migration described above. Normative-rule encoding is intentionally deferred to a separate bounded scope so this migration does not conflate structural reorganization with canonical rule redesign.

## Deferred

## Retired activation mode — historical note

The former `REFRESH` mode has been removed from the active AI-infrastructure protocol.

Historically, `REFRESH` was a convenience invocation for repeating `ACTIVATE` when the current canonical context might have become stale. Its semantic sequence was:

    REFRESH
        ↓
    ACTIVATE
        ↓
    ACTIVATED

It did not introduce a different capability or operation. Its purpose was to reread the current canonical owners and re-establish the active operational context.

This note preserves the historical intent only. `REFRESH` is not an active capability, command, or response protocol. If a future architecture needs equivalent behavior, this note provides the original semantic reference point.

This TODO file does not itself change the active routing, activation, or TRACE semantics. Those changes belong to the canonical owners listed above and SHOULD be handled as a separate bounded repository operation.

## TODO 6 — Align BOOTSTRAP activation with commit-rule ownership

Observation:

The current BOOTSTRAP initialization owner set explicitly activates:

- `.ai/rules/workflow.md`;
- `.ai/rules/handoff/lifecycle.md`;
- `.ai/skills/handoff/SKILL.md`;
- `.ai/workflows/handoff/BOOTSTRAP.md`.

However, bootstrap also contains repository commit semantics, including the required handoff commit convention, while `.ai/rules/commits.md` is not currently included in the canonical ACTIVATE owner set for conversation initialization.

Action:

- Review whether `.ai/rules/commits.md` MUST be added to the conversation-initialization ACTIVATE owner set in `.ai/workflows/handoff/BOOTSTRAP.md`.
- If added, keep the commit skill and commit-rule ownership boundaries explicit: `.ai/rules/commits.md` owns general commit policy, while `.ai/skills/commits/SKILL.md` owns commit-message construction and vocabulary.
- Re-run the bootstrap consistency check after the decision.

Status: RESOLVED

The decision is to keep `.ai/rules/commits.md` outside the ACTIVATE owner set. For WRITE-CAPABLE BOOTSTRAP it is a required operation dependency and MUST be read before repository mutation, so it appears in OPERATION READS.

## TODO 7 — Distinguish activation-boundary ownership from operation dependency

Observation:

The investigation needs to distinguish two different roles for a canonical rule file:

- **activation boundary** — the file is part of the canonical owner set that MUST be reread by ACTIVATE before the operation begins;
- **operation dependency** — the file is not an ACTIVATE owner, but the operation MUST read it before performing the relevant work and therefore it belongs in `OPERATION READS`.

For repository-mutating handoff/bootstrap work, `.ai/rules/commits.md` MUST be included at minimum as an operation read before repository work is performed.

Action:

- Explain later how these two roles differ operationally and what concrete file-structure changes would be required for each choice.
- In particular, compare the consequences of adding `.ai/rules/commits.md` to an ACTIVATE owner set versus keeping it as an operation dependency recorded in `OPERATION READS`.
- Resolve this together with TODO 6 rather than prematurely changing the activation boundary.

Status: RESOLVED

The boundary is now explicit: `.ai/rules/commits.md` is an operation dependency for WRITE-CAPABLE BOOTSTRAP, not an ACTIVATE owner. `.ai/workflows/handoff/BOOTSTRAP.md` now requires that read before repository mutation and records it in the completed TRACE.

## TODO 8 — Normalize normative-language command entry

Observation:

The command `>>activate-normative-language` exposed an avoidable ambiguity at the activation entry point: although the canonical normative-language owner is a rule, the `activate-*` command shape can bias an AI toward looking for a `.ai/skills/.../SKILL.md` entry.

Investigation:

- `.ai/skills/activation/SKILL.md` is already owner-agnostic: ACTIVATE receives canonical owner files and rereads them; it does not require the owner to be a skill.
- `.ai/rules/workflow.md` does not define an activation-to-skill mapping.
- `.ai/AGENTS.md` requires rereading the canonical rule, skill, workflow, or project source that owns an operation.
- `.ai/INDEX.md` previously routed `>>activate-normative-language` directly to `.ai/rules/normative-language.md`.
- No repository evidence was found that the active activation machinery itself requires every `activate-*` target to be a skill.

Decision:

Use a thin skill as the explicit command entry point rather than changing the general ACTIVATE model.

Implementation:

- Added `.ai/skills/normative-language/SKILL.md`.
- The new skill MUST read `.ai/rules/normative-language.md` before executing the normative-language operation.
- The rule remains the canonical owner of normative-language semantics.
- Renamed the user-facing command from `>>activate-normative-language` to `>>normative-language`.
- Updated `.ai/INDEX.md` to route `>>normative-language` to `.ai/skills/normative-language/SKILL.md`.

This preserves the existing generic activation architecture while making the normative-language command discoverable through an explicit skill entry point.

Regression follow-up:

- The fresh cold-start regression SHOULD include the renamed `>>normative-language` command.
- The regression SHOULD verify that the skill is read first as the command owner and that `.ai/rules/normative-language.md` is read as its required canonical semantic owner.
- The regression SHOULD verify that the retired `>>activate-normative-language` phrase is no longer part of the active command surface.

Status: RESOLVED

## TODO 13 — Correct the manual-activation guidance path

Observation:

`.ai/skills/activation/SKILL.md` currently points to:

`.ai/architecture/faq/manual-activation.md`

That path is stale. The current repository location is:

`.ai/docs/faq/manual-activation.md`

Action:

- Update the reference in `.ai/skills/activation/SKILL.md` to use `.ai/docs/faq/manual-activation.md`.
- Read back the changed skill and verify the corrected path exists in the repository tree.

Status: OPEN

## TODO 14 — Clean stale and duplicated infrastructure index entries

Observed defects to correct after the current bounded migration work:

- `.ai/README.md` lists `.ai/conversation-management/` twice with overlapping descriptions. Consolidate this into one accurate entry.
- `.ai/README.md` still lists `.ai/templates/`, although that directory is no longer present. Remove or replace the entry according to the verified active taxonomy.
- `.ai/INDEX.md` duplicates the `Commit policy` and `Commit construction` rows, both pointing to `.ai/skills/commits/SKILL.md`. Determine the intended capability distinction and represent it without duplicate rows.
- The current `.ai/skills/repository/SKILL.md` also treats `.ai/templates/` as an active owner and refers to it in the active-owner boundary. Check this reference against the actual tree and reconcile it with the final taxonomy rather than fixing only the README.

Action:

- Inspect the current active tree and relevant canonical owners before editing.
- Make the smallest consistent corrections to the README, INDEX, and any affected canonical taxonomy owner.
- Read back every changed file; verify all referenced active paths exist and that no unrelated content changed.
- Inspect the resulting diff and changed-file scope before committing.

Status: OPEN

## TODO 15 — Verify and adopt the three-level semantic-role model

Proposed model to evaluate before changing canonical taxonomy rules:

### Level 1 — Canonical semantic owners

These define the authoritative meaning and requirements of a domain or operation. When different AI hosts perform the same operation, these sources determine what the operation means and which requirements apply.

Candidate examples must be checked against the current tree and ownership assignments; historical paths are not evidence that a file is still active. Previously discussed examples included `.ai/rules/repository.md`, `.ai/skills/handoff/SKILL.md`, and `.ai/workflows/handoff/BOOTSTRAP.md`, but the recent restructuring moved or replaced some of these paths.

### Level 2 — Entry, routing, and discovery surfaces

These provide entry points, discover capabilities, and route invocations to the appropriate semantic owner. They may own their limited local entry/routing semantics, but MUST NOT duplicate the target operation's semantics.

Candidate examples: root `AGENTS.md`, `.ai/AGENTS.md`, and `.ai/INDEX.md`.

### Level 3 — Supporting and contextual layers

These preserve rationale, research, evidence, historical state, and context. They can inform work but MUST NOT replace the active semantic owner.

Candidate examples: `.ai/docs/`, `.ai/handoffs/`, `.ai/archives/`, and test-result artifacts as evidence rather than normative owners.

### INDEX ownership boundary

INDEX need not own the operation's semantic meaning. Its limited routing function maps an invocation to an operation and its canonical owner.

Keep these concepts distinct during the review:

- **routing semantics** — how an invocation maps to an operation;
- **operation semantics** — what the operation means;
- **execution semantics** — how its procedure is carried out;
- **host mechanics** — how a specific AI host discovers instructions, obtains tools, and performs actions.

Host mechanics MUST NOT automatically become a fourth level in the semantic-role taxonomy. They may be implemented through adapters, settings, or local scripts without becoming canonical semantic owners.

Action:

- Compare this three-level model with the current active files and the existing owner/supporting-layer model in `.ai/skills/repository/SKILL.md`.
- Verify the role and boundaries of each category, including exceptions and hybrid files, against current repository paths and actual content.
- Reconcile obsolete examples and stale paths introduced by restructuring.
- Keep routing, operation, execution, and host-mechanics distinctions explicit.
- Do NOT modify `.ai/skills/repository/SKILL.md` to adopt the proposed model until this boundary review is complete.
- Record the evidence and any unresolved exceptions before deciding whether the model should be adopted.

Status: OPEN

## TODO 16 — Reconcile active documentation with the current infrastructure paths

The active repository tree no longer contains `.ai/skills/conversational-only/`, `.ai/workflows/`, or `.ai/templates/`. Current conversation-management procedures and templates live under `.ai/conversation-management/`.

The initial audit found stale path references in these active files:

- `docs/PROJECT-INSTRUCTIONS.md` — handoff and bootstrap references still use `.ai/skills/conversational-only/handoff/`; ordered AI procedures still point to `.ai/workflows/`.
- `.ai/skills/activation/SKILL.md` — manual-activation FAQ reference still points to `.ai/architecture/faq/manual-activation.md` rather than `.ai/docs/faq/manual-activation.md`. This overlaps TODO 13 and SHOULD be resolved there.
- `.ai/docs/architecture/README.md` — ownership examples still refer to `.ai/skills/conversational-only/`, `.ai/workflows/`, and `.ai/templates/`.
- `.ai/handoffs/README.md` — canonical handoff owner still points to `.ai/skills/conversational-only/handoff/SKILL.md`.
- `.ai/docs/faq/manual-activation.md` — its handoff-owner example still uses the removed `.ai/skills/conversational-only/handoff/SKILL.md` path.
- `.ai/docs/faq/adapting-to-a-new-project.md` — multiple sections describe the removed `.ai/skills/conversational-only/` and `.ai/workflows/` layout. Review the whole document because these references are structural guidance, not just isolated links.

Active architecture notes also contain old `.ai/workflows/` references. Some may be intentionally historical or explicitly superseded; classify their intended temporal status before editing rather than mechanically replacing every occurrence. In particular, review `.ai/docs/architecture/agentic-ai-compatibility-architecture.md`, `.ai/docs/architecture/agentic-ai-compatibility-capability-audit.md`, `.ai/docs/architecture/agentic-ai-owner-seam-audit.md`, `.ai/docs/architecture/ai-infrastructure-context-mode.md`, and `.ai/docs/architecture/ai-infrastructure-vnext-proposal.md`.

Action:

- Verify each cited file and line against the current `main` tree before mutation.
- Distinguish actionable stale references from historical descriptions that must remain as evidence.
- Update active instructions and practical orientation docs to the current paths and semantic boundaries.
- Where an architecture proposal intentionally describes an earlier state, add or correct a clear temporal/status note instead of rewriting history.
- Read back each changed file and verify every active path it names exists.
- Inspect diff and scope before committing.

Status: OPEN

## TODO 17 — Decide whether the empty repository-root README is intentional

Observation:

The root `README.md` exists in the current tree but has an empty blob (zero bytes). The repository has a substantive root `AGENTS.md`, but it serves as the AI bootstrap entry point rather than a human-facing project overview.

Action:

- Determine whether an empty root README is intentional for this repository.
- If not intentional, decide on a concise human-facing repository overview and canonical links; do not duplicate the AI operating contract or project architecture.
- Keep this decision separate from the AI-infrastructure semantic taxonomy review.

Status: OPEN

