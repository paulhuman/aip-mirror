# Repository rules

These rules define how AIP Mirror relates to its external repositories and how project files should be organized.

## 1. AIP Mirror repository

The production project repository is:

    paulhuman/aip-mirror

Project source code, prototypes, documentation, tests, experiments, and project-specific tooling belong here.

## 2. Adobe Illustrator SDK repository

The canonical Adobe Illustrator 2026 SDK repository is:

    paulhuman/adobe-illustrator-2026-sdk

It is a reference repository.

Use it when exact Illustrator AIP API information, SDK documentation, original Adobe samples, headers, suites, PiPL information, or other SDK material is required.

## 3. Never copy the Adobe SDK into AIP Mirror

Do not duplicate the complete Adobe Illustrator SDK inside `aip-mirror`.

The two repositories have separate purposes:

    adobe-illustrator-2026-sdk
        = canonical SDK reference

    aip-mirror
        = project source and documentation

Project-specific adaptations of SDK samples may be placed in `aip-mirror` when needed, but the original SDK remains in its canonical repository.

## 4. References versus project code

Use these categories consistently.

### `references/`

External reference material needed to understand or validate the project.

Examples:

- Illustrator JavaScript reference PDF
- FreeHand MX documentation
- screenshots
- videos
- reference test data

### `prototypes/`

Executable experimental implementations.

The JSX mirror prototype belongs under:

    prototypes/jsx/

### `docs/`

Human-readable project documentation.

Examples:

- architecture
- specifications
- reverse-engineering findings
- project instructions
- conversation handoffs

### `.ai/`

AI workflow instructions and project-specific AI rules.

These files describe how AI-assisted work should be performed.

They are not application source code.

## 5. Conversation state and durable memory

Conversation history is temporary working context.

The repository is the durable technical memory of the project.

Stable knowledge belongs in normal documentation. Conversation-specific migration state belongs in `docs/handoffs/`.

Do not rely on a previous chat remaining fully available to a future chapter.

## 6. Do not commit local build output

Build products and machine-specific generated files should normally remain outside version control.

The repository should contain source, configuration, documentation, tests, and intentional project artifacts rather than local build output.

## 7. Do not commit secrets

Never commit:

- API keys
- access tokens
- passwords
- private credentials
- personal authentication data
- machine-specific secrets

Use appropriate local or CI configuration instead.

## 8. Keep commits coherent

A commit should represent one logical change.

Avoid mixing unrelated features, fixes, refactors, documentation changes, and experiments when they can reasonably be separated.

## 9. Preserve traceability

Important architectural decisions should be represented in repository documentation rather than existing only in chat.

When a decision materially affects implementation, record it in the appropriate documentation.

## 10. Avoid unnecessary repository growth

Do not create large directory trees or placeholder files before they are needed.

Directories should generally appear when their contents have a real purpose.

The initial repository should remain intentionally small, while justified infrastructure such as `docs/handoffs/` should be created when the workflow requires it.

## 11. External projects remain separate

Other external repositories, libraries, and projects should not be copied into AIP Mirror unless there is a clear project requirement and the licensing and maintenance implications are understood.

In particular, the Adobe Illustrator SDK remains external and canonical.

## 12. Repository is the durable project memory

Conversation history is useful for collaboration, but the repository is the durable technical record.

Important behavior, architecture, specifications, research findings, decisions, and validated handoff state should eventually be captured in files under version control.
