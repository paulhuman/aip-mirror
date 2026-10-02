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

## TODO 4 — Review historical commit messages

The following historical commits use commit messages that do not follow the current \`ai-docs(...)\` convention:

- \`e854cf2dbfdcb0f3802ec3b79df22410c3e59af8\`
- \`f7e6b63b30eb7ad797c6b0048e166ffee8acf6c8\`
- \`4ad2cd90f2fe08eb0fa0feba3a5aa5c3345ba912\`
- \`b523edff4bdc8b785b57c5e4834afdc1ac6b8cbd\`

Do NOT rewrite these commits as part of the current TRACE work. Any history rewrite or message correction requires a separate bounded decision.

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

## Deferred

This TODO file does not itself change the active routing, activation, or TRACE semantics. Those changes belong to the canonical owners listed above and SHOULD be handled as a separate bounded repository operation.
