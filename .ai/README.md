# AI infrastructure

The `.ai/` directory is the repository's AI working infrastructure.

Its architectural purpose is project-agnostic: it defines how AI-assisted work is organized, constrained, routed, continued, verified, and documented. It is not application source code and it is not the project's ordinary documentation layer.

## Semantic boundary

```text
.ai/
    = AI-assisted working infrastructure

docs/
    = project-specific knowledge
```

Project-specific meaning belongs primarily in `docs/` and the project source tree. Generic AI infrastructure belongs in `.ai/`.

Project-specific configuration that generic infrastructure needs is intentionally concentrated in `.ai/config.yaml`. This does not make the generic rules, skills, or workflows project-specific.

## Major active areas

- `.ai/config.yaml` — repository identity, configured references, and project-specific configuration facts used by the infrastructure.
- `.ai/AGENTS.md` — compact always-on AI operating contract.
- `.ai/INDEX.md` — operational command routing and capability discovery.
- `.ai/rules/` — canonical semantic constraints.
- `.ai/skills/` — reusable AI capabilities.
- `.ai/workflows/` — ordered AI procedures.
- `.ai/handoffs/` — conversation continuity state.
- `.ai/docs/` — durable documentation and architecture context for the AI infrastructure.
- `.ai/tests/` — reproducible infrastructure test scenarios and historical test results.
- `.ai/templates/` — human-oriented templates owned by their applicable workflows.
- `.ai/archives/` — historical/disposable storage; not active infrastructure context.

The README files inside active subdirectories provide orientation only. They MUST NOT replace canonical semantic owners.

## Active infrastructure versus archives

Active infrastructure is the material used to understand and execute the current AI working system.

`.ai/archives/` is different. It contains historical material that is retained for recovery, audit, or reference when explicitly needed. Archived content is not part of normal active context and is not a permanent source of truth.

The `>>ai-infrastructure` operation is the explicit context switch for work on the AI infrastructure itself. Its elevated context includes active infrastructure orientation, normative-language activation, and the archive boundary, but it MUST NOT automatically load archive contents.

## Canonical ownership

Semantic ownership remains with the appropriate canonical rule, skill, workflow, or other explicitly defined owner.

In particular:

- `.ai/AGENTS.md` does not replace bootstrap or operation routing.
- `.ai/INDEX.md` routes operations and discovers capabilities; it does not become a second procedure owner.
- `.ai/docs/` architecture notes preserve durable reasoning and decisions; they are not runtime execution owners.
- README files orient humans and AI but MUST NOT redefine canonical procedures.

When this README conflicts with a canonical owner, the canonical owner governs.

## Where to start

For new conversation chapter initialization, follow:

`.ai/AGENTS.md` item 6 → `.ai/workflows/handoff/BOOTSTRAP.md`

For ordinary AI-infrastructure operations, start with:

`.ai/INDEX.md`

For work specifically about the AI infrastructure as a domain, use:

`>>ai-infrastructure`

For project-specific work, read:

`docs/PROJECT-INSTRUCTIONS.md`
