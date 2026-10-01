# AI Infrastructure Restructuring Working Notes

Status: Durable architecture context / Iteration 2 and current entry-layer architecture
Scope: `.ai` infrastructure, repository entry points, semantic ownership, restructuring, verification

## 1. Purpose

This file preserves durable reasoning, decisions, open questions, and current architecture for Iteration 2. It is an architecture/research artifact, not a generic rule file.

Its purpose is to prevent later chapters from reconstructing important decisions from conversation history.

Central boundary:

> If the primary subject is how AI should work with the project, it belongs in `.ai/`. If the primary subject is what AIP Mirror is or how it works, it belongs in `docs/`.

## 2. Semantic decomposition model

Candidate document content is classified independently as:

- **MOVE** — correct semantic kind, wrong location;
- **RENAME** — correct semantic kind and location family, but obsolete/non-semantic naming;
- **DECOMPOSE** — multiple semantic responsibilities have been combined;
- **ARCHIVE** — useful historical evidence that is no longer active infrastructure;
- **REMOVE** — redundant content already represented by a canonical owner.

Semantic kinds:

- RULE = what must be true;
- SKILL = reusable capability;
- WORKFLOW = ordered procedure;
- README = orientation/navigation;
- PROJECT DOC = AIP Mirror-specific knowledge.

DO NOT create a file merely because a semantic unit can be named. A new file needs a stable subject, an owner, independent usefulness, and enough coherence to justify its existence.

## 3. Accepted infrastructure boundary

```text
.ai/
├── config.yaml
├── INDEX.md
├── AGENTS.md
├── rules/
│   ├── repository.md
│   ├── workflow.md
│   ├── commits.md
│   └── handoff/
│       ├── lifecycle.md
│       └── references.md
├── skills/
│   ├── commits/
│   └── handoff/
├── workflows/
│   ├── handoff/
│   │   └── BOOTSTRAP.md
│   └── independent-review/
├── handoffs/
│   └── <specialization>/
├── architecture/
└── archive/

docs/
└── AIP Mirror project knowledge

references/
└── AIP Mirror-specific reference material
```

The important boundary is:

- `.ai/` = AI working infrastructure;
- `docs/` = AIP Mirror project knowledge;
- root `references/` = AIP Mirror-specific reference material.

The `.ai` layer is intended to be reusable across projects. Generic rules, skills, and workflows MUST NOT quietly acquire AIP Mirror-specific assumptions, examples, paths, or product semantics.

### 3.1 Project-specific configuration boundary

Project-specific configuration is intentionally concentrated in `.ai/config.yaml` rather than being repeated throughout `.ai/rules/`, `.ai/skills/`, and `.ai/workflows/`.

This is an explicit portability strategy:

```text
.ai infrastructure
    = generic rules / skills / workflows

.ai/config.yaml
    = current project's configurable identity, references, and vocabulary
```

For AIP Mirror, `config.yaml` contains repository identity, external reference repositories, commit scopes, and project terminology.

This is **intentional project-specific configuration ownership**, not configuration leakage. It gives future projects a single configuration locus to replace or regenerate while keeping generic infrastructure portable.

The presence of project-specific state elsewhere in `.ai` (for example handoffs or architecture notes) does not contradict this boundary: those are project state/research artifacts, not generic infrastructure configuration.

DO NOT move `commit_scopes`, `project_terms`, or similar values out of `config.yaml` merely to make the file look more project-agnostic. The relevant portability question is whether generic rules/skills/workflows remain free of embedded project-specific assumptions.

## 4. Entry-layer architecture

The current Iteration 2 entry architecture is:

```text
README.md
    = human repository orientation

.ai/AGENTS.md
    = compact always-on AI operating contract

.ai/INDEX.md
    = command routing + capability discovery

.ai/rules/
    = canonical semantic constraints

.ai/skills/
    = reusable capabilities

.ai/workflows/
    = ordered procedures
```

Operational routing for an already-initialized conversation:

```text
user command
    ↓
.ai/INDEX.md
    ↓
operation identification
    ↓
ACTIVATE
    ↓
canonical owner
    ↓
operation
```

New conversation initialization is a separate workflow boundary. `.ai/AGENTS.md` is the always-on entry contract; it does not itself initialize a chapter. When new chapter initialization is requested, AGENTS item 6 directs the AI to the canonical BOOTSTRAP workflow:

```text
new conversation
    ↓
.ai/AGENTS.md
    ↓
initialization requested?
    ├─ NO  → ordinary work
    └─ YES → item 6
               ↓
        .ai/workflows/handoff/BOOTSTRAP.md
               ↓
        validate bootstrap context
               ↓
        ACTIVATE
               ↓
        chapter initialization
               ↓
        substantive work
```

Architectural boundary:

> **AGENTS determines when new-chapter BOOTSTRAP is used; BOOTSTRAP determines how chapter initialization is performed; INDEX routes ordinary operations; ACTIVATE establishes the current canonical operational context; canonical owners define and execute their operations.**

`INDEX.md` MUST NOT become a second lifecycle rule, handoff skill, commit skill, bootstrap workflow, repository rule, or general workflow document.

No `ENTRY.md` exists in Iteration 2.

### 4.1 Chat initialization without ENTRY.md

The current evidence supports a reusable chat-initialization procedure, but not a separate `ENTRY.md`.

`.ai/workflows/handoff/BOOTSTRAP.md` is the canonical workflow owner for initializing a new conversation chapter. It covers both:

- receiving a chapter from a predecessor handoff; and
- starting the first chapter of a specialization with `PREVIOUS_CHAPTER = N/A`.

This does **not** make BOOTSTRAP a universal entry router. It is invoked specifically when a new chapter is being initialized and does not route ordinary user commands, define command IDs, or replace INDEX.

The resulting separation is:

```text
new conversation
    ↓
AGENTS
    ↓
is new-chapter initialization requested?
    ├─ NO  → normal conversation setup/work
    └─ YES → AGENTS item 6
               ↓
            BOOTSTRAP
               ↓
            ACTIVATE
               ↓
            chapter initialization

already-initialized conversation
    ↓
INDEX
    ↓
ACTIVATE
    ↓
operation
```

The presence of AGENTS item 6 does **not** mean that every new conversation must initialize a chapter. The AI MUST enter BOOTSTRAP only when new-chapter initialization is actually requested or explicitly invoked.

If initialization is requested but the bootstrap runtime values are absent or incomplete, BOOTSTRAP MUST inspect its own input contract and stop rather than guessing values or auto-initializing from defaults. It MUST report which required values are missing or malformed.

No `ENTRY.md` is justified by this boundary. A separate ENTRY would require evidence of a distinct semantic responsibility that AGENTS, INDEX, and BOOTSTRAP cannot own without becoming overloaded.

## 5. Current `.ai/INDEX.md` model

The `.ai/INDEX.md` architecture is an operational command router and capability-discovery surface.

Each command entry identifies:

1. current user-facing command phrase;
2. semantic operation;
3. canonical owner;
4. required reread targets;
5. activation context / required reread targets.

Repository-state effects, lifecycle outcomes, write authorization, commit policy, commit construction, and procedural steps are not INDEX routing metadata; they remain owned by the canonical rules, skills, and workflows.

Current user-facing handoff commands:

1. `Пора обновить handoff`
2. `Пора выполнить миграцию в чат XXYY`
3. `Пора восстановить handoff`
4. `Пора выполнить handoff lifecycle correction`
5. `Пора выдать bootstrap-инструкцию`

Exact future command IDs and command syntax are intentionally **not frozen**.

### 5.1 Current routing semantics

| Command | Semantic operation | Canonical owner | Activation context |
|---|---|---|---|---|---|
| `Пора обновить handoff` | checkpoint current chapter | handoff skill + lifecycle | lifecycle; handoff skill; current handoff | Yes; lifecycle remains `DRAFT` | Yes — checkpoint commit |
| `Пора выполнить миграцию в чат XXYY` | migration of current chapter | handoff skill + lifecycle; BOOTSTRAP for generated instruction | lifecycle; handoff skill; BOOTSTRAP | Yes; closing handoff may move `DRAFT → READY_FOR_HANDOFF`; bootstrap instruction is separate | Yes — migration commit |
| `Пора восстановить handoff` | Lifecycle Recovery | lifecycle rule | lifecycle; commit rule/skill when a write is required | Yes; bounded recovery | Yes, if recovery changes repository state |
| `Пора выполнить handoff lifecycle correction` | historical Lifecycle Correction | lifecycle rule | lifecycle; commit rule/skill | Yes; bounded correction | Yes — explicit correction commit |
| `Пора выдать bootstrap-инструкцию` | generate bootstrap instruction for future receiving chapter | handoff skill + BOOTSTRAP | handoff skill; BOOTSTRAP | No lifecycle change | No |

The table is routing metadata, not a procedural specification.

### 5.2 Critical distinction

```text
HANDOFF STATE
    ≠
HANDOFF OPERATION
    ≠
HANDOFF COMMIT
```

Checkpoint:

```text
checkpoint
    ↓
DRAFT → DRAFT
    ↓
repository content changes
    ↓
checkpoint commit
```

Migration:

```text
migration
    ↓
closing handoff: DRAFT → READY_FOR_HANDOFF
    ↓
migration commit
    ↓
bootstrap instruction
```

The receiving chapter later performs:

```text
READY_FOR_HANDOFF → HANDED_OFF
```

Migration MUST NOT be represented as completing the receiving chapter's lifecycle.

Recovery and Correction remain distinct exceptional operations. They are not collapsed into a generic `fix` command.

Bootstrap-instruction generation does not itself change lifecycle state or commit repository state.

## 6. Canonical ownership

```text
.ai/config.yaml
    → repository identity/configuration facts and configured project vocabulary

.ai/rules/repository.md
    → repository interpretation, path resolution, boundaries,
      taxonomy/hygiene, durable repository knowledge, write safety

.ai/rules/workflow.md
    → generic workflow principles

.ai/rules/handoff/lifecycle.md
    → handoff lifecycle semantics and exceptional lifecycle operations

.ai/rules/handoff/references.md
    → durable handoff reference preservation rules

.ai/skills/handoff/SKILL.md
    → reusable handoff capability and handoff operations

.ai/skills/commits/SKILL.md
    → reusable commit construction

.ai/rules/commits.md
    → commit policy

.ai/workflows/handoff/BOOTSTRAP.md
    → reusable new-conversation chapter initialization workflow, including receiving-chapter handoff bootstrap

.ai/INDEX.md
    → routing and capability discovery only
```

Other `.ai` rules, skills, and workflows consume these canonical definitions rather than redefining them.

## 7. Handoff lifecycle

The active lifecycle is exactly:

```text
DRAFT
  ↓
READY_FOR_HANDOFF
  ↓
HANDED_OFF
```

`SUPERSEDED` is not part of the handoff lifecycle.

Lifecycle, operation, and commit remain separate dimensions.

Handoff filenames encode specialization/chapter identity, and the chapter sequence provides the existing chronological ordering mechanism for handoff discovery. Removal of `SUPERSEDED` does not by itself require a new historical lifecycle state or separate status mechanism.

Qwen's suggestion to make chronological sorting an explicit new canonical lifecycle rule is therefore not accepted as a current architectural change. The existing filename/chapter ordering mechanism is sufficient unless future evidence shows otherwise.

## 8. BOOTSTRAP architecture decision

BOOTSTRAP retains independent ordered semantics:

```text
runtime inputs
    ↓
repository initialization
    ↓
capability detection
    ↓
ACTIVATE required canonical owners
    ↓
shared initialization steps
    ↓
first-chapter or receiving-chapter branch
    ↓
lifecycle handling when applicable
    ↓
post-bootstrap consistency verification
```

INDEX can route to this workflow but cannot replace its ordered procedure without becoming a second workflow owner.

Therefore the canonical workflow remains:

`.ai/workflows/handoff/BOOTSTRAP.md`

The former path `.ai/workflows/handoff-bootstrap/BOOTSTRAP.md` was removed.

This was an organizational path correction, not a semantic change.

Duplicated canonical material was removed from BOOTSTRAP where ownership had already moved to rules/skills. BOOTSTRAP references canonical owners instead of redefining them.

Independent review by both Grok and Qwen confirmed that BOOTSTRAP should remain an ordered workflow.

## 9. Major Iteration 2 restructuring completed

Established active locations include:

```text
docs/architecture/independent-review-{grok,qwen,deepseek}-onboarding.md
    → .ai/workflows/independent-review/

.ai/rules/conversation-lifecycle.md
    → .ai/rules/handoff/lifecycle.md

.ai/rules/handoff-references.md
    → .ai/rules/handoff/references.md

.ai/skills/conversation-handoff/SKILL.md
    → .ai/skills/handoff/SKILL.md

.ai/skills/conversation-handoff/BOOTSTRAP.md
    → .ai/workflows/handoff/BOOTSTRAP.md

.ai/skills/handoff-reference-preservation/SKILL.md
    → .ai/skills/handoff/reference-preservation/SKILL.md

docs/handoffs/
    → .ai/handoffs/<specialization>/
```

The handoff tree is grouped by specialization directories.

These moves were followed by semantic decomposition and consistency verification rather than being treated as purely physical refactoring.

## 10. Repository-rule consolidation

Repository configuration and repository rules have separate ownership:

- `.ai/config.yaml` owns repository identity/configuration facts;
- `.ai/rules/repository.md` owns repository interpretation and path resolution;
- `.ai/rules/repository.md` owns repository boundaries and taxonomy/hygiene;
- `.ai/rules/repository.md` owns repository-facing durable knowledge;
- `.ai/rules/repository.md` owns repository write safety.

The canonical mutation sequence remains:

```text
READ CURRENT FILE
    ↓
minimal intended change
    ↓
WRITE COMPLETE FILE
    ↓
READ BACK
    ↓
VERIFY CONTENT
    ↓
INSPECT DIFF
    ↓
VERIFY SCOPE
    ↓
COMMIT
    ↓
VERIFY RESULT
```

Commit policy and construction remain separate canonical concerns.

## 11. Post-edit semantic consistency sweep

Any move, rename, decomposition, or canonical-ownership change requires a post-edit semantic consistency sweep:

```text
EDIT
  ↓
verify edited file
  ↓
search old ownership / paths / terminology
  ↓
classify every relevant hit semantically
  ↓
repair stale dependencies
  ↓
read back
  ↓
diff + scope verification
  ↓
commit
  ↓
verify result
```

Minimum search targets include old paths, old owner references, moved filenames, duplicated normative wording, removed lifecycle concepts, obsolete identifiers, stale bootstrap instructions, and stale links/routing.

A textual match is not automatically an ownership violation. Each hit MUST be classified as active, historical, archival, descriptive, or genuinely stale.

## 12. Progressive disclosure / Minimum Sufficient Execution Context

The intended loading model is:

```text
Always-on
    ↓
AGENTS.md

User command
    ↓
INDEX.md

Operation selected
    ↓
canonical owner(s)

Execution detail
    ↓
skill / workflow

Semantic constraint
    ↓
rule
```

The goal is not merely fewer files. The goal is a repository whose surviving instructions agree, so that a new conversation does not have to reconstruct architecture from stale or contradictory context.

INDEX MUST provide enough routing metadata to activate the correct canonical capability, but MUST NOT become a dependency graph or duplicate procedural layer.

## 13. Current dependency direction

```text
config facts
    ↓
canonical rules
    ↓
reusable skills
    ↓
ordered workflows
    ↓
repository operation
```

INDEX sits above these as routing/discovery rather than as a semantic owner:

```text
user command
    ↓
INDEX
    ↓
canonical rule / skill / workflow
    ↓
execution
```

Avoid reciprocal dependencies that turn one file into an accidental aggregation point.

## 14. Iteration 2 discovery method

```text
inventory
   ↓
classify semantic ownership
   ↓
establish canonical owner
   ↓
MOVE / RENAME / DECOMPOSE / ARCHIVE / REMOVE
   ↓
post-edit consistency sweep
   ↓
verify repository coherence
   ↓
commit
   ↓
continue
```

A successful edit alone is insufficient evidence of architectural consistency.

## 15. Current architecture status

Completed:

- physical Iteration 2 restructuring;
- Repository Identity & Path Resolution ownership pass;
- lifecycle cleanup to `DRAFT → READY_FOR_HANDOFF → HANDED_OFF`;
- `.ai/AGENTS.md` as intended compact always-on operating contract;
- `.ai/INDEX.md` as operational command router and capability-discovery surface;
- five current user-facing handoff command routes;
- explicit separation of state, operation, and commit metadata in INDEX;
- BOOTSTRAP residual-core analysis;
- retention of BOOTSTRAP as an independent ordered workflow;
- BOOTSTRAP move to `.ai/workflows/handoff/BOOTSTRAP.md`;
- active path/reference consistency sweep after the BOOTSTRAP move.
- normative-language rule established as the canonical owner;
- bounded normative-language cleanup across the declared active scope;
- semantic review of cleanup false positives and preservation of legitimate ordinary-language uses;
- C029 final verification sequence defined: RULE self-test, negative lexical sweep, semantic spot-check, discoverability check, and final consistency verdict.
- C029 normative-language verification completed successfully, including targeted normalization of confirmed remaining normative/procedural lowercase forms and INDEX discoverability.

Status reconciliation — C030

A review of older architecture notes found that the historical C027 bounded next sequence is now complete in the repository state:

1. AGENTS contract implementation — complete.
2. The two stale docs/PROJECT-INSTRUCTIONS.md references — corrected and verified absent.
3. Lifecycle command-discovery classification/cleanup — completed; lifecycle remains the semantic owner while INDEX provides routing.
4. Targeted entry-layer consistency sweep — completed by subsequent restructuring and verification work.

These were previously left as a historical "next sequence" in section 25.5. They are now historical completed work rather than active TODOs. No additional C027 implementation work is implied.

Current entry-layer model:

```text
AGENTS
  ├─ new conversation → BOOTSTRAP → ACTIVATE → chapter initialization
  │
  └─ ordinary operation → INDEX → ACTIVATE → canonical owner → execution
```

## 16. Independent architecture review checkpoint

Grok and Qwen independently reviewed the current repository state after rereading the current `.ai` infrastructure. The review was treated as evidence against the repository state, not as a source for reconstructing chapter history.

The core result is strong convergence:

- `INDEX = routing / capability discovery` is correct;
- canonical owners retain procedural and normative authority;
- operation / state / commit separation is correct;
- BOOTSTRAP remains an independently justified ordered workflow;
- `ENTRY.md` is not currently needed;
- exact command IDs/syntax SHOULD remain unfrozen.

The reviews also produced actionable questions and findings recorded below.

## 17.8 Normative-language architecture and verification — C028/C029

C028 established a dedicated normative-language rule and completed a bounded consistency cleanup across the active AI infrastructure and project documentation.
The canonical rule is:

    .ai/rules/normative-language.md

Its purpose is to define one consistent distinction between:

- BCP 14 normative keywords: MUST, MUST NOT, SHOULD, SHOULD NOT, MAY;
- local procedural vocabulary: DO, DO NOT;
- ordinary English uses of must, should, may, and do not;
- ambiguous occurrences requiring semantic inspection.

The rule also establishes MUST NOT as the canonical normative prohibition form and rejects alternate normative forms such as SHALL, REQUIRED, RECOMMENDED, OPTIONAL, MUST NEVER, and MAY NOT for active normative wording.

### Completed work

C028 completed the following bounded work:

1. defined the normative-language model and its semantic classification;
2. added .ai/rules/normative-language.md as the canonical owner;
3. inventoried normative-language occurrences across the defined active scope;
4. performed a targeted semantic cleanup rather than blind capitalization;
5. normalized applicable normative and procedural wording;
6. explicitly preserved lowercase ordinary English, historical material, research conclusions, questions, and descriptive prose where they are not normative;
7. verified that .ai/archive/** and conversation-specific handoffs outside the declared scope were not mechanically rewritten.

The cleanup deliberately treated lexical matches as evidence for review rather than as automatic rewrite targets. In particular, false positives such as descriptive uses of must were reverted during semantic review.

### C029 verification plan

C029 now treats the normative-language rule as complete in substance but subject to a final bounded verification pass.

The verification sequence is:

```text
Phase 1
RULE self-test
    ↓
Phase 2
negative lexical sweep
    ↓
Phase 3
semantic spot-check of remaining lowercase forms
    ↓
Phase 4
discoverability / canonical-owner check
    ↓
Phase 5
final consistency verdict
```

The phases have distinct purposes:

- **Phase 1 — RULE self-test:** verify that the rule is internally consistent, uses its own vocabulary correctly, and does not introduce contradictory or alternative normative forms.
- **Phase 2 — negative lexical sweep:** search the active scope for alternate normative vocabulary, prohibition variants, contractions, and Markdown-emphasis forms that could indicate inconsistent syntax. Matches are inventory items, not automatic defects.
- **Phase 3 — semantic spot-check:** inspect remaining lowercase must, should, may, and do not, concentrating first on high-density rule, workflow, skill, and architecture files. The test asks whether each occurrence carries current normative/procedural force or is ordinary English, historical, research, descriptive, or ambiguous text.
- **Phase 4 — discoverability / canonical-owner check:** verify that the new rule is discoverable from the current AI entry architecture without duplicating its semantics into AGENTS.md or INDEX.md. The canonical-owner boundary remains: INDEX routes/discovers; the rule defines normative-language semantics.
- **Phase 5 — final consistency verdict:** record whether the verification found actionable defects. Only confirmed defects justify another repository edit; a zero-defect result is a valid completion state.

This verification is intentionally bounded. It MUST NOT become a second repo-wide capitalization campaign. Remaining lowercase words are not defects merely because they match the vocabulary; they require semantic evidence before change.

The expected completion criterion is therefore **semantic consistency and discoverability**, not zero lexical matches.

### Verification result — C029

The bounded verification completed with the following result:

- **Phase 1 — RULE self-test:** PASS. The rule is internally consistent with its own vocabulary and explicitly distinguishes normative, procedural, ordinary-English, and ambiguous uses.
- **Phase 2 — negative lexical sweep:** PASS. No unintended active use of SHALL, REQUIRED, RECOMMENDED, OPTIONAL, MUST NEVER, MAY NOT, contractions, or Markdown-emphasis variants was found. Intentional mentions remain only where the rule or this architecture note documents prohibited alternatives.
- **Phase 3 — semantic spot-check:** PASS after targeted normalization. Confirmed normative/procedural lowercase occurrences were normalized in the affected active infrastructure files. Remaining lowercase matches are documented ordinary-English, descriptive, historical/research, or terminology uses and were not mechanically changed.
- **Phase 4 — discoverability check:** PASS. The canonical rule is now exposed in the INDEX capability map without duplicating its semantics into AGENTS or INDEX routing logic.
- **Phase 5 — final consistency verdict:** PASS. The normative-language work is complete for the current bounded scope. No further capitalization sweep is justified without new evidence.

The final lexical criterion is semantic rather than numeric: lowercase matches are acceptable when they are not normative/procedural occurrences. This follows the project rule and the BCP 14 capitalization distinction clarified by RFC 8174. citeturn2view0

### Architectural relationship

The normative-language rule participates in the existing ownership model:

```text
AGENTS
  ↓
INDEX / capability discovery
  ↓
canonical rule / skill / workflow
  ↓
execution

normative-language.md
  = canonical constraint on normative expression
```

It does not replace repository rules, lifecycle rules, skills, or workflows, and those owners remain responsible for their own domain semantics.

Future normative-language changes SHOULD begin with evidence from actual repository usage rather than speculative vocabulary expansion.

## 17.9 Handoff chapter identity and header schema

The handoff chapter identity is now project-agnostic and uses:

    [A-Z][0-9]{3}

The first letter identifies the specialization and the three-digit number identifies the chapter within that specialization.

Handoff header formatting is canonicalized separately from the chapter identifier:

    # Conversation Handoff

    **Conversation:**
    E001 — Independent Review (Qwen)

    **Specialization:**
    E

    **Chapter:**
    001

    **Previous chapter:**
    000

    **Status:**
    HANDED_OFF

The project name is not repeated in the Conversation field. Chapter and Previous chapter contain only the three-digit chapter number; the specialization letter is carried by the Specialization field and by the full chapter identifier in Conversation, filenames, and cross-references.

The canonical formatting rules are owned by .ai/skills/handoff/SKILL.md; chapter identity and lifecycle naming constraints are owned by .ai/rules/handoff/lifecycle.md.

### Migration history

The repository was migrated from the previous chapter identity scheme to [A-Z][0-9]{3}. This migration intentionally replaces the historical naming convention rather than preserving it as an active infrastructure contract. The conversion mapping is historical context for this migration only and MUST NOT be copied into generic rules, skills, workflows, or other active project infrastructure.

The migration also renamed handoff specialization directories to their corresponding specialization letters and renamed existing handoff files to the new chapter identifiers. Git history remains the historical record of the former names.

## 17. Review-derived open questions and accepted decisions

### 17.1 Minimum semantic metadata in INDEX — DECIDED IN C027

Qwen challenged the inclusion of `Repository state may change` and `Commit` metadata because routing metadata could drift into shadow ownership.

C027 decision: **reduce command routing metadata to four fields**: command phrase, semantic operation, canonical owner, and activation context / required reread targets.

The four-field model is the current routing boundary. Canonical commit rules/skills retain ownership of commit semantics and construction.

The tested minimum routing model is:

```text
command → operation → owner → activation context
```

`Repository state may change` and `Commit` were useful operator warnings, but were not required for discovery or safe routing and risked adding canonical semantic density to INDEX. Their meanings remain owned elsewhere.

This is a durable C027 decision. Any future change would require new evidence and an explicitly bounded architecture question.

### 17.2 `Пора выдать bootstrap-инструкцию` — OPEN

The independent reviews raised a legitimate semantic question about the fifth command.

One interpretation is that bootstrap-instruction generation is a standalone, non-mutating capability. Another is that it is naturally the terminal output of migration and should not exist as a separately routable operation.

Current decision: **keep the command unchanged for now**.

Questions to resolve later:

- Is bootstrap-instruction generation a genuine independent capability or merely a migration output?
- Should it remain a user-facing command if it is read-only?
- If it remains, should it be explicitly defined as a preview/generation operation whose validity depends on an already completed migration?
- Should INDEX distinguish migration operations from chapter-initialization workflows more visibly?

DO NOT change the command or merge it into migration without new evidence.

### 17.3 Soft dual source in lifecycle.md — RESOLVED IN C027

Grok and Qwen both identified possible duplication of user-facing command phrases between `INDEX.md` and `.ai/rules/handoff/lifecycle.md`.

The intended boundary is:

```text
INDEX
    = user-facing command discovery

lifecycle.md
    = lifecycle semantics, authorization, constraints
```

The C027 cleanup was completed. Checkpoint and migration invocation discovery is routed through INDEX, while lifecycle.md retains operation semantics and authorization. Recovery and correction phrases remain in lifecycle.md because they are explicit authorization tokens for bounded procedures.

### 17.4 Historical handoffs after removal of SUPERSEDED — DECIDED

Qwen suggested explicitly adding a rule that historical discovery relies on chapter-ID chronological sorting.

Current decision: **no new rule is required at this time**.

Handoff filenames already encode specialization/chapter identity, and chapter sequence already provides chronological ordering. Removing `SUPERSEDED` does not make the current history model ambiguous enough to justify another lifecycle state or mandatory discovery mechanism.

Revisit only if actual discovery failures appear.

### 17.5 Chapter identifier format — current state

The active handoff chapter identifier format is:

```text
[A-Z][0-9]{3}
```

The specialization is encoded by the first letter and the chapter number by three decimal digits. For example, `C027` identifies specialization `C`, chapter `027`.

This is an active infrastructure convention. Historical identifiers from the previous scheme are migration history only and MUST NOT be used as current architectural references.

### 17.6 INDEX scalability — FUTURE DESIGN QUESTION

Current command surface is small. The realistic expected upper bound is roughly **10–15 user-facing commands**, not 30–50.

Even at that size, the current table presentation may become visually heavy.

Future question:

> How should INDEX be formatted so that approximately 10–15 command routes remain immediately discoverable without turning INDEX into a dense procedure catalogue?

Potential future solutions include grouping commands by operation family or introducing a secondary discovery presentation. No new layer is justified yet.

### 17.7 Future ENTRY.md — ITERATION 3 EXPERIMENT

The reviews confirmed that a separate ENTRY layer is not currently needed. The existing system should continue without `ENTRY.md`.

However, a future `ENTRY.md` could have a legitimate role if it answers a question that neither AGENTS nor INDEX should own:

> **How does a completely new AI enter and activate this `.ai` infrastructure?**

The intended distinction would be:

```text
AGENTS.md
    = always-on operating contract

ENTRY.md (future, if justified)
    = initial AI entry / activation guidance

INDEX.md
    = command and capability routing

canonical owners
    = semantics and execution

BOOTSTRAP.md
    = receiving-chapter ordered initialization
```

Important constraint:

> **Do not rename or move BOOTSTRAP.md to ENTRY.md.**

A future ENTRY MUST be a genuinely new semantic layer, not a relabelled bootstrap workflow.

## 18. Consolidated decision matrix — Grok + Qwen

The reviews are now consolidated against current repository evidence. The matrix distinguishes accepted work from questions deliberately left open.

| Finding / question | Evidence / review | Decision | Current disposition |
|---|---|---|---|
| `INDEX` routing model | Grok + Qwen converge | Accept | **Keep** |
| `INDEX` `Repository state may change` + `Commit` metadata | C027 tested their routing value against canonical owners | Remove from routing table | **Removed in C027; semantics remain canonical elsewhere** |
| Minimum semantic metadata before router becomes owner | C027 tested the routing boundary against canonical owners | Four-field boundary established | **Resolved in C027** |
| `Пора выдать bootstrap-инструкцию` as separate command | Both reviews raise semantic question | Keep unchanged | **Open; no merge with migration** |
| `BOOTSTRAP.md` as ordered workflow | Grok + Qwen converge | Accept | **Keep** |
| `SUPERSEDED` removal / historical ordering | Qwen suggestion; current filenames already encode chapter sequence | No new lifecycle rule | **No change** |
| User-facing command phrases duplicated in `lifecycle.md` | Grok + Qwen | Soft dual source | **Targeted cleanup candidate** |
| `.ai/AGENTS.md` effectively empty | Grok + Qwen + Phase 0/2 entry-path test | Real architecture/implementation gap | **Resolved in C027: minimal entry contract implemented** |
| Active chapter identifier format `[A-Z][0-9]{3}` | Current infrastructure state | Keep | **Current** |
| INDEX scalability / presentation | Grok + Qwen | Real design concern at ~10–15 commands | **Completed in C027** |
| `ENTRY.md` | Both reviews; future semantic role identified | Do not create now | **Iteration 3 experiment** |
| `config.yaml` contains project-specific scopes/terms | Qwen | Intentional configuration boundary | **No change** |
| Project-specific data spread across generic rules/skills/workflows | Architecture objective | MUST remain prohibited | **Ongoing consistency rule** |
| Physical Iteration 2 restructuring | Review checkpoint | Completed | **Do not restart** |

### 18.1 Bounded follow-up work — completed in C027

The review did **not** authorize another broad restructuring pass. The bounded follow-up was completed as follows:

1. design and create `.ai/AGENTS.md` as the compact always-on contract;
2. perform the targeted `lifecycle.md` command-discovery cleanup, preserving lifecycle semantics and authorization;
3. complete the INDEX presentation/minimum-routing analysis without changing its ownership boundary;
4. run the targeted post-edit semantic consistency sweep.

The following remain explicitly outside the current architecture scope unless new evidence appears:

- changing INDEX metadata semantics;
- merging bootstrap-instruction generation into migration;
- changing lifecycle history semantics;
- changing active chapter identifier format;
- creating `ENTRY.md`;
- moving project-specific configuration out of `config.yaml`;
- restarting physical Iteration 2 restructuring.

## 19. Independent review findings requiring concrete follow-up

### 19.1 AGENTS.md implementation gap — RESOLVED IN C027

Both reviewers independently identified `.ai/AGENTS.md` as effectively empty while the architecture described it as the always-on operating contract. C027 validated the minimum contract with a bounded entry-path experiment and implemented it.

The active AGENTS boundary is:

- establish the `.ai/` vs `docs/` boundary;
- establish repository/path context from `.ai/config.yaml` and `.ai/rules/repository.md`;
- route AI-infrastructure work through INDEX;
- route project work through `docs/PROJECT-INSTRUCTIONS.md`;
- reread the canonical owner before execution.

DO NOT let AGENTS grow into another INDEX or workflow.

### 19.2 config.yaml portability boundary — DECIDED

Qwen identified that `.ai/config.yaml` contains project-specific terminology such as commit scopes and project terms.

Current decision: **this is intentional and correct**.

`.ai/config.yaml` is the single intentional configuration locus for current-project-specific values within the `.ai` infrastructure. Keeping those values there, rather than embedding them across generic rules, skills, and workflows, is precisely what makes the `.ai` layer easier to port to another project.

Therefore:

```text
rules / skills / workflows
    = portable infrastructure

config.yaml
    = project-specific configuration
```

DO NOT move `commit_scopes`, `project_terms`, or configured external references merely because they are project-specific. The portability test is whether the generic infrastructure remains free of embedded project assumptions.

### 19.3 lifecycle command discovery cleanup — RESOLVED IN C027

C027 classified the repeated user-facing phrases and moved checkpoint/migration invocation discovery to INDEX while preserving lifecycle semantics and authorization in `lifecycle.md`. Recovery/correction phrases remain in the lifecycle rule because they are explicit authorization tokens for bounded recovery/correction procedures.

Target model:

```text
INDEX
    → exact user-facing invocation/discovery

lifecycle.md
    → operation semantics and authorization
```

### 19.4 Targeted consistency sweep

The independent review found the active architecture substantially consistent but identified the above implementation gaps. A targeted semantic sweep MUST be run after any resulting edits rather than treating reviewer text as an automatic rewrite list.

## 20. What should NOT be changed based on review

DO NOT currently:

- merge bootstrap-instruction generation into migration;
- reintroduce `SUPERSEDED`;
- add a new historical lifecycle state;
- add a mandatory chronological-sorting rule without evidence;
- create `ENTRY.md` in Iteration 2;
- rename BOOTSTRAP.md to ENTRY.md;
- dissolve BOOTSTRAP into INDEX;
- move procedures into INDEX;
- move project-specific configuration out of `config.yaml`;
- freeze exact command IDs/syntax;
- restart physical Iteration 2 restructuring.

## 21. Deferred experiments / TODO

### Handoff Content Extraction Test

Take a real handoff and classify every content unit, then test whether project knowledge can be moved to canonical project documentation while leaving a bounded conversation-state artifact.

### Iteration 3 Entry-Layer Test

Test whether a genuinely distinct `ENTRY.md` layer is justified. The candidate role is new-AI infrastructure activation, not bootstrap workflow execution.

### INDEX Presentation Test

Prototype a more compact presentation for approximately 10–15 commands while preserving routing metadata and avoiding procedural content.

### Future Identifier Migration Test

Historical chapter-identifier migration is complete; DO NOT preserve the former identifier scheme as an active architecture dependency.

### Operation / Commit Vocabulary

Keep exact operation IDs, final command syntax, and hard-MUST commit vocabulary deferred until sufficient evidence exists.

### Manual Bootstrap Template Test

Provide a dedicated Markdown file with two copy/paste bootstrap templates:

1. **First-chat initialization** — for starting a completely new specialization/chat when no predecessor chapter exists;
2. **Interrupted-chat recovery** — for continuing when migration was not completed, or migration completed but the bootstrap instruction was not emitted.

The templates MUST expose the required runtime values as explicit placeholders so the user can copy a template into a new chat and manually substitute the values without requiring a dedicated `init` or `new` command.

The template design SHOULD be validated against the canonical `.ai/workflows/handoff/BOOTSTRAP.md` contract before becoming active infrastructure.

## 22. Migration note

The current architecture state is represented by this file and the current `.ai` tree. Future chapters MUST start from current repository state rather than reconstructing earlier architecture chapters from conversation history.

The next architecture/research chapter should treat the independent Grok/Qwen review as evidence against the current model, distinguish accepted findings from open questions, and avoid broad restructuring without evidence.


## 23. C027 result — INDEX presentation and minimum routing boundary

C027 completed the bounded INDEX presentation/scalability task.

The durable command-routing boundary is:

```text
command
   ↓
operation
   ↓
owner
   ↓
activation context
```

Capability discovery remains a separate compact surface:

```text
capability
   ↓
owner
   ↓
purpose
```

The command-routing table therefore carries only those four fields. Repository-state effects, lifecycle outcomes, write authorization, commit policy, commit construction, and procedural steps remain canonical concerns outside INDEX.

This is sufficient for the expected approximately 10–15 command/capability surface without introducing a registry, manifest, command-ID schema, or additional filesystem layer. Further scaling pressure SHOULD first be addressed through presentation/grouping changes rather than additional semantic metadata.

### 23.1 AGENTS remains an active architecture task

The C027 INDEX work does not close the AGENTS architecture question.

.ai/AGENTS.md is still to be designed and created as a compact always-on operating contract. Its boundary remains:

```text
AGENTS
  ↓
INDEX
  ↓
canonical owners
```

AGENTS MUST NOT become a second INDEX, procedure catalogue, lifecycle rule, or capability owner.

## 24. Durable methodology — bounded architecture work

The current architecture process has demonstrated a reusable method that should remain durable context:

```text
current evidence
    ↓
bounded question
    ↓
semantic classification
    ↓
explicit decision
    ↓
minimal implementation
    ↓
consistency sweep
    ↓
verification
```

The key property is **boundedness**: a chapter should answer the smallest architectural question that current repository evidence can resolve, implement only the resulting decision, and avoid reopening settled architecture merely because older notes contain broader TODO lists or alternative proposals.

Classify old material before treating it as work:

- **historical TODO** — recorded for possible future investigation;
- **active architecture task** — currently assigned to the receiving chapter;
- **durable decision** — resolved boundary that later chapters should treat as current state unless new evidence invalidates it.

This prevents old review notes from becoming an implicit task queue.

### 24.1 Durable INDEX boundary

The current minimum routing boundary is:

```text
command → operation → owner → activation context
```

where command is the user-facing invocation, operation is the requested semantic operation, owner is the canonical rule/skill/workflow, and activation context is the canonical material that must be reread before execution.

INDEX identifies and routes. It does not authorize, define, or execute the operation.

Capability discovery remains distinct:

```text
capability → owner → purpose
```

### 24.2 Durable AGENTS boundary — IMPLEMENTED IN C027

The AGENTS role is a compact always-on operating contract. Its active implementation establishes the minimum context needed before command routing:

- `.ai/` vs `docs/` boundary;
- repository/path context from `.ai/config.yaml` and `.ai/rules/repository.md`;
- AI-infrastructure routing through INDEX;
- project-work routing through `docs/PROJECT-INSTRUCTIONS.md`;
- reread of the canonical owner before execution.

Its content MUST NOT grow into a second INDEX, procedure catalogue, lifecycle rule, or capability owner.

### 24.3 Durable portability boundary

The configuration conclusion remains:

```text
portable rules / skills / workflows
        +
project-specific .ai/config.yaml
        =
portable AI infrastructure adapted to a project
```

Project-specific handoffs and architecture notes remain project state/research artifacts and do not invalidate this configuration boundary.

### 24.4 Applying bounded architecture work

When an old note or external review proposes a change, first classify it as current evidence, already-decided state, open architectural question, or historical/deferred proposal. Only current evidence and genuinely open questions SHOULD normally drive the current chapter. A deferred proposal does not become active merely because it remains written down.



## 25. C027 Phase 2 — entry-path architecture result

C027 tested the minimum AGENTS entry contract against the current repository rather than reconstructing the architecture from earlier chapters.

### 25.1 Phase 0 baseline

The current AGENTS file contained only its heading. A fresh-AI entry-path test therefore failed: the file did not establish where to initialize repository context, how to distinguish AI infrastructure from project work, or where to route the resulting operation.

### 25.2 Phase 2 validated topology

The tested minimal contract passed both bounded entry scenarios.

AI-infrastructure work:

```
AGENTS
  ↓
config.yaml
  ↓
repository.md
  ↓
INDEX
  ↓
canonical owner
```

Project work:

```
AGENTS
  ↓
config.yaml
  ↓
repository.md
  ↓
PROJECT-INSTRUCTIONS
  ↓
canonical project sources
```

This establishes that `.ai/config.yaml` and `.ai/rules/repository.md` are genuine initialization-path nodes. They are not optional background context for a fresh AI.

### 25.3 Durable AGENTS boundary

The implementation baseline validated by the experiment is deliberately small:

1. establish the `.ai/` AI-infrastructure vs `docs/` project-knowledge boundary;
2. establish repository/path context from `.ai/config.yaml` and `.ai/rules/repository.md` before project or `.ai` work;
3. route AI-infrastructure operations through `.ai/INDEX.md`;
4. route project work through `docs/PROJECT-INSTRUCTIONS.md`;
5. reread the canonical rule, skill, workflow, or project source that owns the operation before execution.

The resulting topology is:

```
                         AGENTS
                           │
                  context initialization
                           │
             ┌─────────────┴─────────────┐
             ▼                           ▼
      AI infrastructure             Project work
             │                           │
       config + repository         config + repository
             │                           │
           INDEX                PROJECT-INSTRUCTIONS
             │                           │
     canonical AI owners       canonical project owners
```

AGENTS is an always-on entry contract. It is not an INDEX replacement, capability owner, lifecycle rule, commit policy, or procedure catalogue.

### 25.4 Architecture vs cleanup

The Phase 2 experiment exposed two stale references in `docs/PROJECT-INSTRUCTIONS.md`:

- the old chapter identifier model `[0-9]{2}[A-Z]{2}`;
- the old bootstrap path `.ai/workflows/handoff-bootstrap/BOOTSTRAP.md`.

These are consistency defects in the project instruction layer, not evidence that the AGENTS architecture should grow. They are therefore a separate cleanup task.

The lifecycle rule also contains user-facing command phrases that overlap with INDEX discovery. The bounded cleanup question is whether those discovery phrases can be reduced while preserving the lifecycle rule's operation semantics and explicit authorization. This is a cleanup/classification task, not an INDEX redesign.
### 25.5 C027 bounded next sequence

1. implement the tested AGENTS contract;
2. correct the two stale PROJECT-INSTRUCTIONS references;
3. classify and perform only the necessary lifecycle command-discovery cleanup;
4. run a targeted entry-layer consistency sweep.

DO NOT reopen the completed INDEX minimum-routing decision or restart Iteration 2 restructuring.


## 26. C030 — Activation, Refresh, and TRACE research

C030 tested the boundary between **discoverability** and **activation** using observable repository behavior.

### 26.1 T1/T2/T3 result

The bounded tests established:

    DISCOVER
        ↓
    canonical owner found
        ↓
    ACTIVATE / reread
        ↓
    EXECUTE

Discovery passed for:

- repository write-safety owner discovery through AGENTS/INDEX;
- INDEX-routed handoff operation discovery;
- semantic-owner routing from docs/PROJECT-INSTRUCTIONS.md to canonical project architecture.

Activation is a separate concern. C030 reproduced an actual failure in which the canonical repository rule was known/discoverable but was not reread before a mutation. This is directly observable from repository behavior and does not require claims about hidden model reasoning.

The existing AGENTS contract already states that the canonical owner MUST be reread before execution. Therefore the gap is not absence of a rule; it is lack of a reliable, user-visible activation mechanism that makes the required reread observable and easier to audit.

### 26.2 Archive reconciliation

Archived architecture research confirms that this question has prior evidence rather than being entirely new:

- .ai/archive/architecture/mec-dynamic-context.md models activation as a dynamic transition between available knowledge and active context and does not establish a mandatory routing layer, registry, manifest, capability-ID system, or permanent bootstrap kernel.
- .ai/archive/architecture/minimal-execution-context.md identifies concrete minimum execution-context cases for handoff bootstrap and safe repository modification and distinguishes ordinary context from conditional escalation context.
- .ai/archive/architecture/ai-project-instruction-architecture.md records AGENTS → INDEX → rules/skills/workflows, compact bootstrap/re-read, and deliberate rereading of critical instructions at meaningful checkpoints and before high-risk operations.
- .ai/archive/architecture/architectural-bottleneck-audit.md records progressive activation as a meta-architectural constraint: activate additional semantic machinery only when needed.

The archive supports progressive activation/re-read as a durable research direction, but does not establish a new semantic ENTRY, registry, router, or universal metadata layer.

### 26.3 Minimal working model

C030 now uses three provisional primitives for testing:

    ACTIVATE
        ↓
    REFRESH
        ↓
    TRACE

They are deliberately functional terms, not yet canonical semantic entities:

- ACTIVATE — establish the context required for the current operation, including actual reread of canonical owners;
- REFRESH — deliberately repeat activation during a long conversation or before a high-risk operation;
- TRACE — expose the observable activation, execution, and verification steps to the user in a compact terminal-like log.

TRACE is specifically an **observability mechanism**, not a transcript of hidden reasoning and not a semantic owner of the rules it reports.

A provisional activation trace can look like:

    [TRACE]
    READ  ✓ .ai/AGENTS.md
    READ  ✓ .ai/INDEX.md
    ROUTE → repository write safety
    READ  ✓ .ai/rules/repository.md
    READ  ✓ .ai/rules/commits.md
    READ  ✓ .ai/skills/commits/SKILL.md
    READY → mutation

Post-mutation TRACE can report read-back, content verification, diff/scope verification, commit, and result verification.

### 26.4 Coverage experiment

| Case | ACTIVATE | REFRESH | TRACE | Current gap |
|---|---|---|---|---|
| New chapter from handoff | Partially covered by BOOTSTRAP | Not a normal bootstrap step | Not standardized | Bootstrap initializes repository/lifecycle context, but does not expose a general activation trace |
| New specialization | Not covered by a general activation template | Not applicable initially | Not standardized | No reusable general entry/activation template exists for a specialization without a predecessor handoff |
| Ordinary continuation | Partially covered by AGENTS/INDEX + operation-specific reread | User can request reread, but no standard refresh operation | Not standardized | Activation is required but not externally visible as a repeatable protocol |
| Mid-conversation refresh | Historical guidance says to reread critical instructions at meaningful checkpoints | No explicit refresh command/template | Not standardized | Manual intent exists, but no compact reusable refresh invocation is defined |
| Before repository mutation | Canonical repository rule requires reread | Can be manually reactivated | Not standardized | C030 demonstrated that required reread can be skipped even when discoverable |

### 26.5 Bounded architectural conclusion

The current evidence justifies a **small activation interface**, but does not justify a new semantic router/registry or a new ENTRY.md yet.

The smallest currently supported model is:

    activation template / bootstrap input
                ↓
            ACTIVATE
                ↓
             TRACE
                ↓
            operation
                ↓
            VERIFY

    long conversation / risk boundary
                ↓
             REFRESH
                ↓
            ACTIVATE

The activation interface should remain separate from canonical semantic ownership:

- existing rules continue to define what MUST be reread and what execution/verification requires;
- the activation mechanism identifies and activates that context;
- TRACE reports what actually happened;
- REFRESH reuses the same activation path instead of creating a second set of rules.

At this point there is enough evidence to investigate a **general activation template plus a refresh invocation and TRACE convention** as the next minimal implementation candidate. There is not enough evidence to create ENTRY.md, a registry, manifest, capability-ID system, or a new universal routing layer.

### 26.6 Next bounded question

Before implementing the activation interface, test its semantic owner boundary:

> Can one small reusable activation procedure cover handoff bootstrap, new-specialization entry, ordinary continuation, refresh, and pre-mutation activation without duplicating lifecycle, repository, commit, or project semantics?

If yes, the next implementation can remain small and compositional. If no, the failing cases should identify the exact additional owner or workflow required.

C030 should not turn this research result into a broad .ai redesign without that final owner-boundary test.

### 26.7 Handoff content versus activation context — TODO

C030 identified a second boundary that must be tested before implementing the activation interface: **handoff content is not the same thing as generic activation context**.

The current C029 handoff contains a broad `Recommended starting context` list:

    .ai/AGENTS.md
    .ai/INDEX.md
    .ai/rules/repository.md
    .ai/rules/workflow.md
    .ai/rules/handoff/lifecycle.md
    .ai/rules/normative-language.md
    .ai/architecture/ai-infrastructure-restructuring.md
    docs/PROJECT-INSTRUCTIONS.md
    docs/architecture/project-architecture.md

This may be duplicating activation rather than preserving the actual continuity of the work. The bounded hypothesis to test is:

> A handoff should preserve the files in which the current chapter's work was actually performed and the durable context required to understand or continue that work; it should not serve as a generic re-activation checklist for the receiving AI.

The distinction is important for two reasons:

1. **Handoff continuity** should tell the receiving chapter where the material state of the previous work lives — the handoff itself plus the current working/durable files that contain the research, findings, decisions, or other material context.
2. **Activation** should independently establish and reread the canonical infrastructure required for the current operation. It should not be possible to mistake a large handoff reading list for evidence that the activation mechanism works correctly.

Therefore the next bounded test MUST compare a real handoff's current `Recommended starting context` against the files actually touched or materially relied upon by that chapter. Classify each entry as:

- **handoff continuity** — material current-work or durable-context reference that belongs in the handoff;
- **activation context** — canonical infrastructure that should be activated by the general activation mechanism rather than carried as a generic handoff checklist;
- **both** — genuinely needed in both contexts, with different reasons;
- **incidental / redundant** — not required for either purpose.

Do not change the handoff reference rule or activation architecture from this hypothesis alone. First test it against C029/C030 and at least one other real handoff. The goal is to determine whether handoff references can become a compact record of **where the work and durable context live**, while ACTIVATE/REFRESH independently provides the canonical operational context.

This test is specifically intended to prevent a false positive in which a receiving chapter appears to have activated the infrastructure simply because its handoff supplied a large list of canonical files.
### 26.8 C031 activation owner-boundary experiment — completed

C031 tested the bounded question from C030 against five concrete cases:

1. handoff bootstrap;
2. new-specialization entry;
3. ordinary continuation;
4. explicit REFRESH;
5. pre-mutation activation.

The experiment established one reusable semantic core:

    Activation Context
        ├── operation
        ├── required canonical owners
        └── optional mode/context

    ACTIVATE
        ↓
    reread required canonical owners
        ↓
    ACTIVATED

The same procedure is sufficient across all five cases when the caller supplies the operation-specific owner set. The cases differ in which owners are required and in what operation follows activation; they do not require different activation semantics.

The resulting ownership boundary is:

```text
INDEX / caller
    ↓
ACTIVATE
    ↓
canonical owner
    ↓
operation
```

Therefore:

- INDEX remains routing/discovery and identifies what should be activated;
- ACTIVATE establishes the current canonical operational context;
- canonical rules, skills, and workflows retain semantic ownership and execution;
- REFRESH is an invocation mode that reuses ACTIVATE;
- TRACE is optional observable evidence of activation, not persistent schema or repository state.

C031 also validated the boundary between handoff continuity and activation context. A handoff may identify material current-work and durable-context files, while canonical infrastructure required for the current operation is activated independently. A handoff Recommended starting context therefore MUST NOT be treated as proof that activation occurred.

### 26.9 Activation skill — first implementation

The bounded experiment justified one new reusable capability:

    .ai/skills/activation/SKILL.md

Its contract is intentionally small:

- input: operation + required canonical owners + optional invocation context;
- procedure: reread the current repository version of each required owner;
- output: ACTIVATED;
- optional TRACE for observability;
- no lifecycle, repository, project, mutation, commit, or verification ownership.

The first implementation was committed as:

    028ec2254d31a985149edcd1e7c32a79385e352e
    feat(architecture): add activation skill

The file was read back after creation and the commit diff was verified as a single new file with 69 added lines.

ACTIVATE was subsequently integrated at the INDEX routing boundary and validated against two real operations in C032. Direct ACTIVATE integration inside BOOTSTRAP was initially rejected because the earlier BOOTSTRAP scope was limited to receiving-chapter bootstrap and already owned ordered rereads. C033 then identified a concrete broader initialization need: the same new-conversation initialization boundary also applies to a first chapter, where no predecessor handoff exists.

### 26.10 Chat initialization owner-boundary result

The bounded question was:

> Does a new reusable chat-initialization procedure need to exist, and can the existing BOOTSTRAP workflow own it without becoming a universal entry router?

The result is **yes, without introducing a new ENTRY.md**.

The existing BOOTSTRAP workflow is the appropriate owner because its existing subject is chapter initialization. Its scope is expanded from only receiving a predecessor handoff to initializing a new chapter in either of two cases:

1. receiving chapter — `PREVIOUS_CHAPTER` identifies a predecessor handoff;
2. first chapter — `PREVIOUS_CHAPTER = N/A`.

The reusable initialization sequence is:

```text
new conversation
    ↓
establish repository + chapter context
    ↓
ACTIVATE required canonical owners
    ↓
execute applicable BOOTSTRAP branch
    ↓
bootstrap verification
    ↓
substantive chapter work
```

BOOTSTRAP remains an ordered workflow, not a router. It does not replace INDEX, define command IDs, maintain a registry, or absorb lifecycle/repository/commit semantics from their canonical owners.

ACTIVATE is now intentionally used at both boundaries:

```text
INDEX / caller
    ↓
ACTIVATE
    ↓
canonical owner
    ↓
operation

new conversation
    ↓
BOOTSTRAP
    ↓
ACTIVATE
    ↓
chapter initialization
```

This is a concrete integration justified by the initialization boundary rather than a speculative second routing layer.

No `ENTRY.md`, registry, manifest, dependency graph, command-ID layer, or universal router is justified by this result.

### 26.11 Bootstrap runtime-input normalization — completed

C033 identified a concrete transport-boundary defect: the canonical handoff schema correctly separates `Specialization` from the numeric `Chapter` and `Previous chapter` fields, but the bootstrap runtime-input contract did not explicitly define the representation of those values.

This allowed a bootstrap message to carry a full chapter identifier such as `C033` where BOOTSTRAP expected the numeric chapter component `033`. The recent C031/C032 header corrections provided direct evidence of the same representation ambiguity at the handoff boundary.

The bounded result is:

```text
handoff lifecycle identity
        ↓
Specialization + numeric chapter component
        ↓
BOOTSTRAP invocation format
        ↓
chapter context
```

The existing BOOTSTRAP workflow is the canonical owner of the invocation format. Its runtime contract is:

    PREVIOUS_CHAPTER = <three-digit previous chapter number or N/A>
    CURRENT_CHAPTER = <three-digit current chapter number>
    SPECIALIZATION = <single uppercase specialization letter>

Chapter number values MUST NOT include the specialization letter. For example:

    PREVIOUS_CHAPTER = 032
    CURRENT_CHAPTER = 033
    SPECIALIZATION = C

The handoff skill is the producer of this invocation and MUST emit the same normalized representation. BOOTSTRAP is the consumer and derives full chapter identifiers from the separate specialization and numeric chapter values.

This is a contract clarification, not a new architectural layer. No new entry file, template file, router, registry, or identity owner is required. Lifecycle semantics remain owned by `.ai/rules/handoff/lifecycle.md`; handoff structure and bootstrap-message generation remain owned by `.ai/skills/handoff/SKILL.md`; chat initialization and its invocation format remain owned by BOOTSTRAP.

The real C032 → C033 example is now represented canonically as:

    PREVIOUS_CHAPTER = 032
    CURRENT_CHAPTER = 033
    SPECIALIZATION = C

This closes the bounded normalization question without changing lifecycle state-machine semantics.

## 27. C034 — Handoff model simplification

C034 established a deliberate reduction of handoff cognitive and Git-history overhead.

The previous handoff architecture treated each handoff as a lifecycle-controlled object with three persistent states:

    DRAFT
      ↓
    READY_FOR_HANDOFF
      ↓
    HANDED_OFF

This model is now rejected as unnecessary infrastructure.

### 27.1 Handoff is a persistent context snapshot

A handoff is now defined as:

> **a persistent conversation-context snapshot for a chapter**

It is not a lifecycle-controlled transfer object.

The repository already provides the durable chronology needed to identify chapter progression:

- the handoff filename identifies specialization and chapter;
- the Conversation, Specialization, Chapter, and Previous chapter fields identify the chapter context;
- Git history records when the file was created and updated;
- the receiving chapter explicitly reads the predecessor handoff during initialization.

No additional Status field is required to represent whether a handoff is "draft", "ready", or "handed off".

The handoff schema therefore MUST NOT contain a lifecycle status field or any replacement state such as DRAFT, READY_FOR_HANDOFF, HANDED_OFF, or SUPERSEDED.

SUPERSEDED was already rejected as an active lifecycle state; this decision removes the remaining lifecycle-state model entirely.

### 27.2 Receiving-chapter creation is retained

The removal of lifecycle status does NOT remove the most useful bootstrap invariant:

> **The receiving chapter creates its own handoff at the beginning of the new conversation.**

The initialization model remains:

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

For a first chapter of a specialization, the predecessor remains N/A.

The receiving chapter owns its own handoff because that file is a snapshot of the receiving conversation's working context. The previous chapter MUST NOT create the receiving chapter's handoff in advance.

### 27.3 No closing transition is required

There is no longer a "closing" handoff state transition.

A current chapter SHOULD update its handoff whenever meaningful durable context accumulates. An update is a normal handoff-content operation, not a lifecycle transition.

In particular, the current chapter does not need to perform a special DRAFT → READY_FOR_HANDOFF operation before a new conversation can start.

This is intentional. Conversation termination is not a reliable event: a chat can hit a context limit, browser/session instability, or another interruption before the AI has an opportunity to perform a final housekeeping step. The handoff must remain useful even when the previous conversation ends abruptly.

Therefore:

> **Handoff freshness is maintained by meaningful updates, not by a required closing ceremony.**

### 27.4 No receiving transition is required

The receiving chapter also MUST NOT modify the predecessor handoff merely to mark that it has been consumed.

There is no READY_FOR_HANDOFF → HANDED_OFF operation.

Reading the predecessor handoff is sufficient. The fact that a new chapter has been initialized is represented by the existence of the new chapter's own handoff and by repository/Git history.

This removes an entire class of unnecessary mutations and commits.

### 27.5 Consequences for bootstrap

BOOTSTRAP remains the canonical new-conversation chapter initialization workflow.

Its relevant handoff behavior becomes:

1. establish repository and chapter context;
2. ACTIVATE required canonical owners;
3. read the predecessor handoff when PREVIOUS_CHAPTER is not N/A;
4. create the receiving chapter's own handoff;
5. commit the initial handoff;
6. verify the new handoff;
7. begin substantive work.

BOOTSTRAP MUST NOT contain lifecycle-state transitions for handoffs because there are no such states.

The existing BOOTSTRAP/runtime-input normalization remains valid:

    PREVIOUS_CHAPTER = <three-digit previous chapter number or N/A>
    CURRENT_CHAPTER = <three-digit current chapter number>
    SPECIALIZATION = <single uppercase specialization letter>

This decision changes handoff state semantics, not chapter identity or bootstrap invocation semantics.

### 27.6 Consequences for handoff skill and INDEX

.ai/skills/handoff/SKILL.md remains the canonical owner of handoff structure and handoff operations, but its operation set becomes smaller.

The current checkpoint, migration, recovery, and lifecycle correction machinery MUST be re-evaluated during the implementation phase because much of it exists solely to maintain the removed state machine.

.ai/INDEX.md MUST likewise be simplified so that it does not route obsolete lifecycle-state operations.

This architecture decision does not itself perform that migration. The next implementation pass MUST update the canonical owners and then run a repository-wide semantic consistency sweep for stale lifecycle terminology and procedures.

### 27.7 Handoff commit vocabulary

Handoff commits are infrastructure byproducts and MUST be visually distinguishable from project documentation commits.

The canonical short handoff commit forms are:

    ai-docs(handoff): create C033
    ai-docs(handoff): update C033

The message MUST remain this short for normal handoff creation/update commits.

Do NOT append conversation titles, task descriptions, rationale, milestone summaries, or other explanatory text to normal handoff commit messages.

Examples:

    ai-docs(handoff): create C034
    ai-docs(handoff): update C034

The ai-docs(handoff) scope identifies .ai/handoffs/ infrastructure. It prevents ordinary docs(...) history from mixing project documentation work with AI-context bookkeeping.

The broader ai-* namespace is a local repository convention for commits whose primary subject is .ai/ infrastructure. It is intentionally not presented as a replacement for Conventional Commits. Its purpose is semantic visibility in this project's history.

Project documentation remains under the normal project-facing vocabulary, for example:

    docs(plugin): document native AIP architecture
    docs(prototype): document Mirror behavior

The exact set of future ai-* types beyond ai-docs remains open unless a concrete need establishes them. The handoff create/update forms above are the currently fixed convention.

### 27.8 Git-history objective

This simplification is explicitly motivated by repository-history quality.

The previous model generated multiple commits whose sole purpose was changing handoff lifecycle metadata. Those commits added little durable project information while increasing:

- Git history noise;
- cognitive load during repository archaeology;
- opportunities for state-transition mistakes;
- bootstrap failure modes;
- pressure to perform end-of-chat housekeeping;
- the amount of AI infrastructure that must be remembered and activated.

The target history is instead:

    ai-docs(handoff): create C034
    ai-docs(handoff): update C034
    ai-docs(architecture): ...
    docs(plugin): ...
    feat(plugin): ...
    fix(plugin): ...

The distinction makes .ai infrastructure visible without pretending that handoff bookkeeping is project documentation.

### 27.9 Migration boundary

This is an architectural decision, not yet the full migration.

The following existing files are expected to require coordinated changes:

- .ai/rules/handoff/lifecycle.md
- .ai/skills/handoff/SKILL.md
- .ai/workflows/handoff/BOOTSTRAP.md
- .ai/INDEX.md
- existing .ai/handoffs/*/*.md

The migration MUST:

1. remove Status from active handoff files;
2. remove obsolete lifecycle-state procedures and commands;
3. preserve receiving-chapter handoff creation;
4. preserve chapter identity and bootstrap runtime-input normalization;
5. preserve meaningful handoff content and historical context;
6. normalize handoff commit messages to the short ai-docs(handoff): create/update <chapter> convention;
7. run a semantic consistency sweep for stale DRAFT, READY_FOR_HANDOFF, HANDED_OFF, recovery, correction, and related lifecycle terminology;
8. verify that no new state-machine mechanism has been introduced as a replacement.

Historical Git commits MUST NOT be rewritten. The simplification changes the active model from this point forward; old lifecycle commits remain historical evidence of the former architecture.

### 27.10 Architectural intent

The purpose is not merely to delete three strings.

The intended model is:

    Conversation chapter
            │
            │ produces / updates
            ▼
    Handoff context snapshot
            │
            │ consumed by
            ▼
    Next conversation

rather than:

    Handoff
      ├── DRAFT
      ├── READY_FOR_HANDOFF
      └── HANDED_OFF

The architecture is therefore optimized for the actual environment in which it operates: finite AI conversations whose termination can be abrupt, with Git serving as durable project memory.

The system should preserve useful context, not create bookkeeping work merely to prove that context was transferred.

## 27.11 C034 continuation plan — semantic consistency sweep

The next bounded task after the handoff-state migration is a semantic consistency sweep. The purpose is to verify that the simplified handoff model is not merely implemented mechanically, but is also expressed consistently across the active canonical .ai infrastructure.

The sweep MUST distinguish between:

1. **active canonical semantics** — stale lifecycle-state behavior here must be removed; and
2. **historical architecture record** — historical descriptions of the former model are valid durable evidence and MUST NOT be erased merely because the model changed.

The inspection target is the active canonical .ai infrastructure, especially:

    .ai/rules/
    .ai/skills/
    .ai/workflows/
    .ai/INDEX.md

The sweep should look for stale references to:

    DRAFT
    READY_FOR_HANDOFF
    HANDED_OFF
    SUPERSEDED
    Status:
    Lifecycle Recovery
    Lifecycle Correction

It should also identify prose that still implies an active transfer/closure state machine even when the old state names are absent.

The handoff continuity rule has one small normative-language correction to make:

    A current chapter SHOULD update its own handoff whenever meaningful durable context accumulates.

SHOULD is intentional. Meaningful durable context should normally be checkpointed, but the simplified model must not turn handoff maintenance back into a rigid end-of-conversation ceremony.

The canonical handoff skill also contains a stale example from the former schema. The example MUST remain structurally useful while removing the obsolete Status field:

    # Conversation Handoff

    **Conversation:**
    E001 — Independent Review (Qwen)

    **Specialization:**
    E

    **Chapter:**
    001

    **Previous chapter:**
    000

The architecture record itself must then be checked against the resulting canonical files. It should not merely describe the intended model while the active rules, skill, workflow, or routing still express a different one.

The intended bounded sequence is:

    semantic consistency sweep
        ↓
    MAY → SHOULD in handoff continuity
        ↓
    remove stale Status example from handoff skill
        ↓
    verify architecture record matches active semantics
        ↓
    final verification
        ↓
    inspect whether any concrete architectural contradiction remains

Do not invent a new infrastructure layer during this sweep. In particular, do not introduce a registry, manifest, dependency graph, command-ID system, universal router, or replacement lifecycle state machine unless a concrete contradiction demonstrates that one is necessary.

Only after final verification should the project decide whether any specific architectural contradiction remains. The absence of such a contradiction is itself a valid result; no follow-up architecture mechanism should be created merely to produce another task.



## 28. C036 — Command-surface semantics and migration composition

C036 introduced a concrete operational observation about the command surface and chat continuity.

The user explicitly reported that the separate command:

    Пора выдать bootstrap-инструкцию

was introduced because the migration command:

    Пора выполнить миграцию в чат XXYY

was sometimes executed without the AI actually emitting the required bootstrap instruction at the end.

This is not merely a wording preference. It identifies a reliability boundary in the migration procedure:

> **Generating the bootstrap instruction is a required terminal step of migration, not an optional follow-up.**

The intended migration flow is therefore:

    >>migrate <chapter>
        ↓
    update current handoff
        ↓
    verify handoff content and scope
        ↓
    commit handoff update
        ↓
    invoke bootstrap-instruction generation
        ↓
    emit bootstrap instruction for the receiving chapter

The separate bootstrap-instruction operation remains useful because it is independently callable when a previous migration was interrupted or its final instruction was omitted. However, normal migration MUST invoke that operation as part of its own completion procedure rather than merely mentioning it as a possible next action.

### 28.1 Command versus workflow

The distinction between the command surface and the canonical workflow remains explicit:

    command
        = user-facing invocation of an operation

    .ai/workflows/handoff/BOOTSTRAP.md
        = canonical ordered workflow for initializing a new conversation chapter

The existence of BOOTSTRAP.md does not require the command surface to expose a command named "bootstrap". Conversely, a command that generates a bootstrap instruction does not itself execute the receiving chapter's BOOTSTRAP workflow.

This distinction is important because the word "bootstrap" currently refers to two related but different things:

1. the generated instruction that tells a future conversation how to initialize; and
2. the receiving conversation's canonical initialization workflow.

The command surface should name the first operation precisely enough that it is not mistaken for execution of the second.

### 28.2 Migration and bootstrap-instruction generation are compositional

The current architecture supports a small compositional relationship rather than a command-router hierarchy:

    >>migrate <chapter>
        ↓
    migration operation
        ↓
    bootstrap-instruction generation

The second operation is a reusable terminal operation of migration. It is not a subcommand syntax, command registry, or universal router.

Therefore this does NOT imply a syntax such as:

    >>migrate bootstrap <chapter>
    >>bootstrap migrate <chapter>

and does not justify introducing flags, subcommands, command IDs, or a command orchestration layer.

The migration procedure owns the fact that bootstrap-instruction generation must occur at its end; the canonical owner of bootstrap-instruction generation retains the details of how that instruction is constructed.

### 28.3 "init" versus "new" remains intentionally unresolved

C036 also exposed a second semantic distinction that must remain explicit before command names are finalized.

A new conversation can represent at least two different situations:

**Continuation / receiving chapter**

    PREVIOUS_CHAPTER = 036
    CURRENT_CHAPTER  = 037
    SPECIALIZATION   = C

This continues an existing chapter sequence.

**First chapter of a new specialization stream**

    PREVIOUS_CHAPTER = N/A
    CURRENT_CHAPTER  = 000
    SPECIALIZATION   = C
    SHORT_NAME       = Architecture & Research

This starts a new chapter sequence.

The command surface may eventually need a dedicated operation for the second case, but the name is deliberately not decided in C036. In particular, "init" and "new" remain candidates rather than accepted architecture.

No new command should be introduced merely to resolve the naming question. The distinction must first be defined semantically and then named.

### 28.4 Abrupt chat termination and recovery

C036 also recorded an operational failure mode that matters to command semantics: a conversation can terminate because of contextual limits or other interruption before the migration procedure reaches its final bootstrap-instruction step.

The architecture therefore MUST NOT assume that the previous conversation always completed migration cleanly.

A receiving conversation may instead need to continue from repository state when the predecessor ended before emitting migration/bootstrap instructions. This is a continuation/recovery condition, not evidence that the predecessor's intended operation completed.

The current architectural question is therefore bounded to:

    normal migration
        = explicit migration + mandatory bootstrap-instruction generation

    interrupted migration
        = receiving conversation recovers/continues from durable repository state

    first chapter
        = initializes a new specialization stream

Whether interrupted migration requires a separate user-facing command or is fully handled by the existing BOOTSTRAP initialization workflow remains open. No recovery command is introduced by this record.

### 28.5 Short-name as chapter initialization data

The existing handoff naming convention is:

    <chapter>-<short-name>.md

C036 confirmed that the short conversation name is therefore operational input when a new chapter handoff is created. For the current specialization:

    SPECIALIZATION = C
    SHORT_NAME = Architecture & Research

The current BOOTSTRAP runtime contract explicitly defines PREVIOUS_CHAPTER, CURRENT_CHAPTER, and SPECIALIZATION, but does not currently list SHORT_NAME as a bootstrap input.

This is a concrete contract question to inspect before changing the bootstrap command surface. The next bounded analysis SHOULD determine whether SHORT_NAME is:

- derived from canonical handoff/reference configuration;
- supplied as an explicit bootstrap input; or
- otherwise resolved by the receiving workflow.

No new runtime field is introduced by this architecture record alone.

### 28.6 C036 decision boundary

Confirmed in C036:

- ">>" is the stable command prefix.
- ">>operation [arguments...]" is the minimal command grammar.
- ">>handoff" represents the current handoff checkpoint operation.
- ">>migrate <chapter>" represents migration to the specified receiving chapter.
- Bootstrap-instruction generation is a required final step of normal migration.
- The bootstrap-instruction operation remains independently callable when needed.
- The command that generates a bootstrap instruction MUST NOT be conflated with execution of the receiving chapter's BOOTSTRAP workflow.
- "init" versus "new" remains unresolved.
- Interrupted migration/recovery remains an open semantic question.
- No command registry, subcommand hierarchy, flag layer, or universal router is justified by these observations.

The next architecture work SHOULD first resolve the semantic operation set and naming boundary, then update INDEX/SKILL/BOOTSTRAP only after the command meanings are stable.


## 29. C037 — SHORT_NAME resolution and specialization vocabulary

C037 resolved the SHORT_NAME question at the configuration and bootstrap-contract boundary.

### 29.1 Specialization vocabulary is configuration

The specialization-to-short-name mapping is now recorded in .ai/config.yaml:

    specializations:
      A:
        short_name: JSX Prototype
      B:
        short_name: Native AIP Plugin
      C:
        short_name: Architecture & Research
      D:
        short_name: Project Workshop
      E:
        short_name: Independent Review (Qwen)
      F:
        short_name: Independent Review (Grok)

This mapping is project configuration/vocabulary, not a new command registry or routing layer.

Its purpose is to provide a single canonical lookup for the stable short name associated with each specialization. Generic handoff rules and workflows may resolve the short name from this vocabulary without embedding the AIP Mirror specialization names directly.

### 29.2 Canonical bootstrap inputs remain three values

The canonical BOOTSTRAP runtime contract remains:

    PREVIOUS_CHAPTER
    CURRENT_CHAPTER
    SPECIALIZATION

SHORT_NAME does not become a required fourth canonical runtime input merely because it appears in generated or manually prepared bootstrap messages.

Instead, the receiving workflow uses this resolution rule:

    supplied SHORT_NAME
        ↓ if omitted
    configured specialization vocabulary
        ↓
    resolved SHORT_NAME

This preserves the minimal three-value runtime contract while allowing explicit context to be supplied when useful.

### 29.3 Generated bootstrap messages may expose resolved SHORT_NAME

A generated bootstrap instruction SHOULD include the resolved short name as explicit context:

    PREVIOUS_CHAPTER = 037
    CURRENT_CHAPTER = 038
    SPECIALIZATION = C
    SHORT_NAME = Architecture & Research

The four-line message is therefore self-contained for human inspection and copy/paste, while only the first three values remain canonical BOOTSTRAP runtime inputs.

The receiving workflow MAY use the supplied SHORT_NAME directly when valid and SHOULD resolve it from .ai/config.yaml when the value is omitted.

The generated value is contextual data, not a new command argument or command-routing mechanism.

### 29.4 Manual bootstrap templates

Manual bootstrap templates SHOULD expose all practical context values explicitly, including:

    PREVIOUS_CHAPTER
    CURRENT_CHAPTER
    SPECIALIZATION
    SHORT_NAME

The user can substitute these values manually before pasting the template into a new conversation.

This does not change the canonical BOOTSTRAP runtime-input contract. The template is a human-facing convenience and recovery mechanism; BOOTSTRAP remains the semantic owner of chapter initialization.

Two dedicated template cases remain planned:

1. first-chat initialization when no predecessor chapter exists;
2. interrupted-chat recovery when migration was not completed or its final bootstrap instruction was not emitted.

### 29.5 Next implementation sequence

The next bounded implementation sequence is:

1. Update .ai/workflows/handoff/BOOTSTRAP.md to document SHORT_NAME as optional supplied context with configuration fallback.
2. Verify .ai/rules/handoff/lifecycle.md and .ai/skills/handoff/SKILL.md remain consistent with that contract; update only where stale semantics are found.
3. Define the exact generated bootstrap-message format and its data source.
4. Update the active command references in .ai/INDEX.md and .ai/skills/handoff/SKILL.md only after command semantics are stable.
5. Decide whether the standalone bootstrap-instruction generation operation needs a user-facing command name.
6. Re-evaluate whether first-chapter initialization needs a dedicated init/new operation at all.
7. Determine whether interrupted migration needs a separate recovery command or is fully handled by receiving-chapter BOOTSTRAP from durable repository state.
8. Validate the two manual bootstrap templates against the canonical BOOTSTRAP contract.
9. Perform a semantic consistency sweep and only then update historical architecture references where an active reference is genuinely stale.

### 29.6 C037 decision boundary

Confirmed:

- .ai/config.yaml is an appropriate canonical source for stable specialization vocabulary.
- The six current specialization mappings are now recorded there.
- Canonical BOOTSTRAP runtime inputs remain PREVIOUS_CHAPTER, CURRENT_CHAPTER, and SPECIALIZATION.
- SHORT_NAME can be supplied as contextual data without becoming a fourth required runtime input.
- When SHORT_NAME is omitted, the receiving workflow should resolve it from configured specialization vocabulary.
- Generated bootstrap messages SHOULD expose the resolved SHORT_NAME for self-contained human-readable context.
- Manual bootstrap templates MAY expose SHORT_NAME explicitly for copy/paste.
- No command registry, universal router, command-ID layer, subcommand hierarchy, or new lifecycle mechanism follows from this decision.

Still open:

- exact BOOTSTRAP wording and implementation of the supplied/fallback SHORT_NAME contract;
- exact generated bootstrap-message format;
- standalone bootstrap-instruction generation command name;
- whether first-chapter initialization needs init, new, or no dedicated command;
- whether interrupted migration needs a separate recovery command;
- exact active command-reference migration after these semantic questions are settled.


## 23. C038 entry-layer and bootstrap transport decisions

C038 resolved the remaining ambiguity around the relationship between `.ai/AGENTS.md` and `.ai/workflows/handoff/BOOTSTRAP.md`.

### 23.1 Entry responsibility

The stable boundary is:

> **AGENTS determines when BOOTSTRAP is used; BOOTSTRAP determines how initialization is performed.**

`.ai/AGENTS.md` is the always-on AI infrastructure entry contract. Its item 6 is the explicit trigger/routing instruction for new conversation chapter initialization.

BOOTSTRAP MUST NOT call, re-enter, or redefine AGENTS. AGENTS is upstream entry context; BOOTSTRAP is the downstream ordered initialization workflow.

The presence of item 6 MUST NOT cause every new conversation to initialize automatically. A normal new conversation can read AGENTS and continue ordinary work without chapter initialization.

The intended entry model is:

```text
new conversation
    ↓
.ai/AGENTS.md
    ↓
is new-chapter initialization requested?
    ├─ NO  → ordinary work
    └─ YES → AGENTS item 6
               ↓
        .ai/workflows/handoff/BOOTSTRAP.md
               ↓
        validate inputs
               ↓
        ACTIVATE canonical owners
               ↓
        initialize chapter
```

### 23.2 Missing runtime values

When new-chapter initialization is requested, BOOTSTRAP is responsible for determining the required runtime context.

If the user explicitly requests initialization but does not provide the required runtime values, the AI MUST enter BOOTSTRAP through AGENTS item 6, inspect the canonical input contract, and stop bootstrap before repository mutation. It MUST report the missing or malformed values and MUST NOT guess, infer, or silently substitute chapter values.

This distinction is intentional:

```text
AGENTS present
    ≠
bootstrap requested

bootstrap requested
    +
missing runtime inputs
    =
bootstrap STOP + report missing inputs
```

### 23.3 Bootstrap transport message

The generated migration message and future manual templates are transport mechanisms for entering the canonical BOOTSTRAP workflow. They are not alternative initialization procedures.

A generated or manual bootstrap message MUST explicitly state that it is an instruction to initialize a new conversation chapter and MUST direct the receiving AI to follow the new-chapter initialization procedure specified by AGENTS item 6 and then use `.ai/workflows/handoff/BOOTSTRAP.md`.

The standard generated transport contains exactly these four lines:

```text
PREVIOUS_CHAPTER = <previous chapter>
CURRENT_CHAPTER = <current chapter>
SPECIALIZATION = <specialization>
SHORT_NAME = <resolved short name>
```

The semantic contract remains three canonical runtime inputs:

```text
PREVIOUS_CHAPTER
CURRENT_CHAPTER
SPECIALIZATION
```

`SHORT_NAME` remains contextual data, not a fourth canonical runtime input. For generated migration transport, the value is already resolved from the specialization vocabulary. For manual transport, the value MAY be supplied explicitly; if omitted, BOOTSTRAP applies its documented configuration fallback.

For C038 → C039, the generated transport values are:

```text
PREVIOUS_CHAPTER = 038
CURRENT_CHAPTER = 039
SPECIALIZATION = C
SHORT_NAME = Architecture & Research
```

The transport MUST NOT include `NEXT_CHAPTER`, filename/path metadata, extra routing metadata, or a second procedural framework.

### 23.4 Source hierarchy for generated transport

For normal migration:

| Value | Source |
|---|---|
| `PREVIOUS_CHAPTER` | current chapter |
| `CURRENT_CHAPTER` | migration target |
| `SPECIALIZATION` | current chapter |
| `SHORT_NAME` | resolved specialization vocabulary |

The generated message is therefore self-contained enough for the receiving chapter to enter the canonical initialization workflow without requiring the user to repeat specialization or short-name context.

### 23.5 C038 → C039 migration boundary

C038 resolves the semantic design questions below before active command-reference migration:

1. The stable command prefix remains `>>` and MUST NOT be reopened.
2. `>>migrate <chapter>` is the intended migration invocation shape; specialization and short name are resolved automatically.
3. Normal migration MUST generate the bootstrap transport as its terminal output.
4. Generated bootstrap transport and receiving-chapter BOOTSTRAP execution remain separate concerns.
5. First-chapter initialization and interrupted-migration recovery remain bounded follow-up questions; neither receives a new command solely from this decision.
6. Two manual bootstrap templates remain future work and MUST be validated against BOOTSTRAP before becoming active infrastructure.
7. Active command references in `.ai/INDEX.md` and `.ai/skills/handoff/SKILL.md` SHOULD be migrated only after the command semantics are fully stabilized.

### 23.6 Next bounded work for C039

C039 SHOULD continue with:

1. verify the updated AGENTS → BOOTSTRAP entry boundary and missing-input behavior;
2. verify the generated four-line bootstrap transport against BOOTSTRAP;
3. decide the standalone bootstrap-instruction generation operation name, without reopening `>>`;
4. decide whether first-chapter initialization needs a dedicated operation or is sufficiently expressed by BOOTSTRAP;
5. decide whether interrupted migration needs a dedicated recovery operation or is fully recoverable from durable repository state;
6. design and validate the two manual bootstrap templates;
7. only then migrate active command references in `.ai/INDEX.md` and `.ai/skills/handoff/SKILL.md`;
8. run a semantic consistency sweep covering AGENTS, INDEX, BOOTSTRAP, handoff skill/rules, configuration vocabulary, and historical references.

Do not begin a broad infrastructure refactor.

### 23.7 Architectural invariants

The following statements are now the bounded C038 conclusions:

- **AGENTS determines when BOOTSTRAP is used; BOOTSTRAP determines how initialization is performed.**
- BOOTSTRAP MUST NOT call or redefine AGENTS.
- Reading AGENTS alone MUST NOT trigger chapter initialization.
- An explicit initialization request with missing runtime values MUST stop bootstrap and report the missing values.
- The generated migration bootstrap transport MUST explicitly identify itself as new-chapter initialization and direct the receiving AI to the AGENTS item 6 path.
- The generated transport contains four lines: the three canonical runtime inputs plus resolved `SHORT_NAME`.
- `SHORT_NAME` is not a fourth canonical runtime input.
- The generated transport is context, not a second bootstrap procedure.
- `>>` remains accepted and MUST NOT be reopened.


### 23.8 C039 command and initialization decisions

C039 resolved the remaining semantic questions from the C038 follow-up sequence.

#### Standalone bootstrap-instruction generation

The accepted standalone operation is:

    >>generate-bootstrap <chapter>

This operation generates the bootstrap transport for a future receiving chapter. It does not execute `.ai/workflows/handoff/BOOTSTRAP.md` and does not initialize the receiving chapter.

The distinction is intentional:

```text
>>migrate <chapter>
    ↓
update current handoff
    ↓
verify
    ↓
commit
    ↓
generate bootstrap transport
    ↓
emit transport to the user
```

The standalone form exists so the terminal transport can be generated or regenerated without repeating the migration operation.

The name `generate-bootstrap` is preferred over `bootstrap` because `bootstrap` alone could be interpreted as execution of the canonical BOOTSTRAP workflow rather than generation of its transport. `generate-bootstrap` names the artifact-producing operation directly.

The accepted active command surface is therefore:

    >>handoff
    >>migrate <chapter>
    >>generate-bootstrap <chapter>

No dedicated `>>init`, `>>new`, or `>>recover` operation is introduced.

#### First-chapter initialization

A first chapter does not require a dedicated `>>init` or `>>new` operation.

The existing BOOTSTRAP workflow already has an explicit FIRST CHAPTER branch using:

    PREVIOUS_CHAPTER = N/A

Adding another operation would duplicate the existing initialization semantic owner without solving a concrete routing problem.

#### Interrupted migration

Interrupted migration does not require a dedicated `>>recover` operation.

Recovery is a transport/input condition for the canonical new-chapter BOOTSTRAP workflow, not a distinct lifecycle operation. The durable repository state and the receiving-chapter BOOTSTRAP procedure are sufficient to continue when a predecessor conversation ended before completing its migration transport.

Recovery context is therefore expressed by a manual bootstrap template rather than by a new command.

#### Manual bootstrap templates

Two manual templates are part of the accepted transport surface:

1. **Template A — first chapter**

       Initialize a new conversation chapter. Follow the new-chapter initialization procedure specified by `.ai/AGENTS.md`, item 6, and use `.ai/workflows/handoff/BOOTSTRAP.md` as the canonical chat-initialization workflow.

       PREVIOUS_CHAPTER = N/A
       CURRENT_CHAPTER = <three-digit chapter>
       SPECIALIZATION = <single uppercase specialization letter>
       SHORT_NAME = <short conversation name>

2. **Template B — interrupted migration recovery**

       Initialize a new conversation chapter as a recovery from an interrupted migration. Follow the new-chapter initialization procedure specified by `.ai/AGENTS.md`, item 6, and use `.ai/workflows/handoff/BOOTSTRAP.md` as the canonical chat-initialization workflow.

       PREVIOUS_CHAPTER = <three-digit previous chapter>
       CURRENT_CHAPTER = <three-digit current chapter>
       SPECIALIZATION = <single uppercase specialization letter>
       SHORT_NAME = <short conversation name>

The recovery wording is descriptive transport context only. It does not create a new recovery operation or lifecycle state.

Both templates remain human-facing convenience mechanisms. Their canonical semantic owner is BOOTSTRAP.

If `SHORT_NAME` is omitted from either manual template, BOOTSTRAP MUST resolve it from `.ai/config.yaml` using:

    SPECIALIZATION → specializations.<SPECIALIZATION>.short_name

Therefore the omission of `SHORT_NAME` does not create a fourth required runtime input. If it cannot be resolved from configuration, BOOTSTRAP MUST stop and report the unresolved short name rather than guessing.

Generated migration transport remains stricter: it MUST include the already-resolved `SHORT_NAME`.

#### C039 architectural result

The minimal accepted model is:

```text
one canonical chapter-initialization workflow
        +
three user-facing operations
        +
two manual bootstrap transport templates
```

This resolves the C038 open questions without introducing a command registry, universal router, dedicated initialization layer, recovery operation, or additional lifecycle mechanism.


### 23.9 C039 semantic consistency sweep

C039 performed the bounded semantic consistency sweep after stabilizing the command and bootstrap decisions.

The active command surface is consistent across .ai/INDEX.md and .ai/skills/handoff/SKILL.md:

    >>handoff
    >>migrate <chapter>
    >>generate-bootstrap <chapter>

The active initialization path is consistent across .ai/AGENTS.md and .ai/workflows/handoff/BOOTSTRAP.md:

    AGENTS item 6 → BOOTSTRAP

The canonical BOOTSTRAP runtime contract remains three values, with optional contextual SHORT_NAME resolved from .ai/config.yaml when omitted.

No active references to the retired Пора... command phrases, >>init, >>new, >>recover, NEXT_CHAPTER, or the removed handoff lifecycle status model were found in the reviewed active owners.

Historical architecture sections and older handoff snapshots retain earlier unresolved decisions where those decisions were true at the time. They are intentionally preserved as historical record and are not active command definitions.

No additional infrastructure or corrective layer is required by this sweep.
