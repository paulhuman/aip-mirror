# AI Infrastructure Restructuring TODO

Status: Active bounded TODO
Scope: `.ai` infrastructure, ACTIVATE / TRACE routing semantics, and deferred repository-history cleanup

The previous long-form restructuring notes were archived at:

`.ai/archive/architecture/ai-infrastructure-restructuring.md`

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

- `.ai/architecture/tests/cold-start-command-trace.md` — reusable cold-start test scenario; currently enumerates four commands;
- `.ai/architecture/tests/results/cold-start-command-trace/20261002-0900-cold-start-command-trace.md` — latest historical structural-simulation result; also reflects the four-command scope.

Status: OPEN

The canonical TRACE requirements and response presentation contract are implemented, but runtime verification remains open because the existing cold-start result does not test actual user-visible delivery. A new runtime result artifact is still required.

### Investigation result — TRACE response presentation contract

The investigation confirms three distinct facts:

1. The canonical requirement exists. `.ai/skills/activation/SKILL.md` defines operation-level TRACE semantics and response presentation, `.ai/INDEX.md` routes applicable user-facing commands to TRACE inserted into the assistant response, and `.ai/workflows/handoff/BOOTSTRAP.md` explicitly requires the completed TRACE to be inserted into the assistant response during bootstrap initialization.
2. The presentation contract is now explicitly defined at the assistant-response boundary: TRACE is visible when the completed TRACE block is inserted into the assistant response content delivered to the user. The canonical template is a compact fenced monospace block. The operation completes first, the actual read set is accumulated, the TRACE is assembled, and the completed TRACE is then inserted into the response.
3. The existing cold-start test still does not verify this presentation layer. Its result is explicitly a simulation and validates the scenario structure, not actual runtime delivery of TRACE into the user-visible assistant response.

Therefore the current architectural finding is:

> **The TRACE presentation contract is now explicit: completed TRACE is inserted into the assistant response. Runtime delivery remains unverified by the existing cold-start test.**

The next step is runtime verification of the four documented command paths and the new response-template behavior.

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

    TARGET_CHAPTER = CURRENT_CHAPTER + 1

The argument MUST therefore equal `TARGET_CHAPTER`. A mismatch MUST stop migration rather than override the sequential target.

### Canonical `CURRENT_CHAPTER` determination

`CURRENT_CHAPTER` has three possible states during migration preparation:

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

The prompt MUST explicitly require four digits, for example `0059`.

A valid user response becomes RECOVERED conversation context for the pending migration. It is **input**, not repository evidence.

The AI MUST validate that input against repository evidence when evidence exists:

- no evidence → accept the supplied value as recovered context; do not repeat the UNKNOWN STOP;
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

When `CURRENT_CHAPTER` is KNOWN or RECOVERED:

    USER_ASSERTED_NEXT_CHAPTER = <chapter>
    EXPECTED_TARGET = CURRENT_CHAPTER + 1

Migration is valid only when:

    USER_ASSERTED_NEXT_CHAPTER == EXPECTED_TARGET

A mismatch MUST stop migration rather than override sequential target selection.

If the migration argument mismatches and the current chapter is not established by active context, the AI MUST request `CURRENT_CHAPTER` in the same four-digit format. The supplied value is then recovery input and MUST be validated without requiring a new repository handoff.

Argumentless `>>migrate` is NOT an implicit alias and remains outside the documented command syntax.

No registry, manifest, dependency graph, command-ID layer, universal router, new lifecycle state machine, or separate persistent current-chapter state file is required for this recovery model.

Status: RESOLVED

Implementation is encoded in the canonical migration and lifecycle owners. Dedicated recovery test coverage is defined separately; runtime execution evidence remains subject to the existing test-result process.


## TODO 10 — Define the GitHub disposable-branch fallback for repository fixtures

Problem:

GitHub repository operations may allow creation of a commit object but reject moving an existing branch ref with `update_ref`. Treating the ref update as the only way to construct a disposable test state creates an unnecessary tool-level dead end.

Decision:

For isolated repository tests that require destructive or synthetic history, the test harness SHOULD prefer creating a new branch directly from the required commit SHA rather than moving an existing branch ref.

The canonical fixture flow is:

    known commit SHA
        ↓
    create disposable branch from that SHA
        ↓
    create / modify / delete fixture files on that branch
        ↓
    read back the resulting repository state
        ↓
    verify diff and fixture scope
        ↓
    exercise the test operation
        ↓
    create the next disposable branch from the resulting commit when another state is required

The important distinction is:

    create branch from commit
        ≠
    move existing branch ref

The first operation constructs a new isolated test path without rewriting or relocating an existing ref. The second mutates an existing ref and MAY be rejected by the connected GitHub tool even when the requested repository state is otherwise valid.

Rules to add to the canonical repository/GitHub workflow documentation:

- Test harnesses MUST prefer disposable branches created from known commit SHAs when isolated repository state is required.
- A blocked `update_ref` MUST NOT be treated as evidence that the required fixture state cannot be constructed.
- AI SHOULD decompose a fixture operation into commit-sized stages and create a new disposable branch from each resulting commit when ref movement is unavailable.
- Fixture branches MUST remain clearly isolated from canonical branches such as `main`.
- Repository-state verification MUST use the actual fixture branch/ref and MUST NOT infer the state from the intended commit operation alone.
- This fallback is a test/repository-operation strategy; it MUST NOT alter the project's canonical Git history or introduce a new persistent state mechanism.

Implementation target:

Add the concrete branch-from-commit fallback and the corresponding `update_ref` failure handling to the canonical repository rules/workflow documentation. Keep the architectural decision here as the concise rationale and routing rule; detailed operational procedure belongs in the repository owner.

Status: OPEN


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
