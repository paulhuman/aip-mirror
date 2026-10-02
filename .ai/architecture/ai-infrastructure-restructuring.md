# AI Infrastructure Restructuring TODO

Status: Active bounded TODO
Scope: \`.ai\` infrastructure, ACTIVATE / TRACE routing semantics, and deferred repository-history cleanup

The previous long-form restructuring notes were archived at:

\`.ai/archive/architecture/ai-infrastructure-restructuring.md\`

This file is intentionally a small active TODO surface. Historical architectural reasoning MUST remain in the archive rather than being copied forward.

## TODO 1 — Make operation-level TRACE mandatory for user-facing \`>>\` commands

Decision:

> Every user-facing \`>>\` command that requires ACTIVATE MUST also expose operation-level TRACE.

Rationale:

\`ACTIVATE\` establishes the current canonical operational context. Operation-level \`TRACE\` makes that activation and the repository reads used by the operation observable. For these commands, both are part of correct execution.

Implementation direction:

- \`.ai/skills/activation/SKILL.md\` SHOULD become the single canonical owner of the exact operation-level TRACE semantics and presentation.
- \`.ai/INDEX.md\` SHOULD contain one shared routing rule stating that user-facing \`>>\` commands requiring ACTIVATE also require visible operation-level TRACE.
- Do NOT add a separate TRACE requirement column to the command table unless later evidence shows that per-command variation is genuinely needed.
- Do NOT duplicate TRACE requirements across individual command owners.
- BOOTSTRAP SHOULD be aligned with the same general model rather than retaining a separate, isolated TRACE concept.

Status: RESOLVED

The canonical activation skill now owns the operation-level TRACE semantics and presentation, INDEX contains the shared routing rule, and BOOTSTRAP follows the same model.

## TODO 2 — Preserve the ownership boundary

The intended ownership remains:

\`\`\`text
INDEX
  = routing and capability discovery

activation/SKILL.md
  = ACTIVATE / REFRESH / TRACE semantics and TRACE presentation

canonical operation owner
  = operation-specific execution semantics

BOOTSTRAP
  = ordered new-conversation initialization workflow
\`\`\`

INDEX MUST NOT become a second activation or tracing owner.

Status: RESOLVED

The current activation skill, INDEX routing rule, and BOOTSTRAP alignment implement the required TRACE ownership model. Runtime verification remains separately tracked below because the new-chat initialization still requires investigation.

## TODO 3 — Re-run runtime command verification

After the active files are updated:

- exercise the four documented user-facing commands:
  - \`>>handoff\`
  - \`>>migrate <chapter>\`
  - \`>>generate-bootstrap <chapter>\`
  - \`>>explain-code\`
- verify that each command requiring ACTIVATE visibly produces the required operation-level TRACE;
- verify that ACTIVATE owners are not duplicated under OPERATION READS;
- verify that OPERATION READS reflects actual repository reads for the operation;
- preserve the existing cold-start scenario as the stable test input;
- create a new result artifact rather than rewriting the historical simulation result.

Status: RESOLVED

The boundary is now explicit: `.ai/rules/commits.md` is an operation dependency for WRITE-CAPABLE BOOTSTRAP, not an ACTIVATE owner. `.ai/workflows/handoff/BOOTSTRAP.md` now requires that read before TRACE and repository mutation.

The canonical TRACE requirements are implemented, but runtime verification remains open because the new-chat BOOTSTRAP initialization has again failed to produce the required user-visible TRACE. This requires a separate investigation and a new runtime result artifact.

## TODO 4 — Review historical commit messages

The following historical commits use commit messages that do not follow the current \`ai-docs(...)\` convention:

- \`e854cf2dbfdcb0f3802ec3b79df22410c3e59af8\`
- \`f7e6b63b30eb7ad797c6b0048e166ffee8acf6c8\`
- \`4ad2cd90f2fe08eb0fa0feba3a5aa5c3345ba912\`
- \`b523edff4bdc8b785b57c5e4834afdc1ac6b8cbd\`

Do NOT rewrite these commits as part of the current TRACE work. Any history rewrite or message correction requires a separate bounded decision.

Status: RESOLVED

The historical messages have been identified and the required boundary is documented: no history rewrite is part of the current TRACE work. Any future correction remains a separate bounded decision.

## TODO 5 — Document GitHub commit signature verification

The \`VERIFIED\` label observed on commit \`4ad2cd90...\` is GitHub's cryptographic signature verification indicator, not the project's semantic verification state.

Observed GitHub text:

> This commit was created on GitHub.com and signed with GitHub's verified signature.

The displayed GPG Key ID was:

\`B5690EEEBB952194\`

The project MUST continue to distinguish:

\`\`\`text
GitHub signature verification
    ≠
project content verification
    ≠
ACTIVATE / TRACE evidence
\`\`\`

No architecture change is required for this distinction. The topic is recorded here so it is not accidentally conflated with repository workflow verification later.

Status: RESOLVED

The distinction is documented and requires no further architecture change.

## Deferred

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

The decision is to keep `.ai/rules/commits.md` outside the ACTIVATE owner set. For WRITE-CAPABLE BOOTSTRAP it is a required operation dependency and MUST be read before operation-level TRACE and repository mutation, so it appears in OPERATION READS.

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

Status: OPEN
