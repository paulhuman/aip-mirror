# Conversation Handoff

**Conversation:**
C0076 — Architecture & Research

**Specialization:**
C

**Chapter:**
0076

**Previous chapter:**
0075

## Starting objective

Continue the Architecture & Research track from C0075 after establishing a more precise Agentic AI host boundary from DSH evidence.

The next bounded scope is a focused normalization pass over the parked `agentic-ai-*` architecture research and the Developer Knowledge architecture history, followed by the deferred natural-language knowledge-capture activation/discovery test.

## Known starting implementation state

- Repository: `paulhuman/aip-mirror`
- Canonical branch: `main`
- Current chapter: C0076
- Previous chapter: C0075
- Specialization: C
- Short name: Architecture & Research
- Derived chapter identifier: C0076
- C0075 completed the DeepSeek change audit at the semantic-boundary level and preserved useful changes rather than blindly reverting them.
- C0075 normalized repository mutation ownership and Developer Knowledge YAML-validation ownership.
- DSH evidence is recorded in `.ai/docs/architecture/agentic-ai-dsh-observations.md`.
- The broader Agentic AI compatibility boundary is recorded in `.ai/docs/architecture/agentic-ai-compatibility-architecture.md`.

## C0075 durable checkpoint

The current Agentic AI model is layered:

```text
portable instructional content
        ↓
host-specific always-on instruction channel
        ↓
host-specific skill packaging / metadata
        ↓
host-specific discovery
        ↓
host-specific activation / invocation
        ↓
host-specific execution capabilities
```

Important DSH findings:

- DSH does not have a native `.ai/rules/*.md` mechanism.
- DSH's observed always-on instruction channel is the `AGENTS.md` / `CLAUDE.md` family, with local variants and global `$DSH_HOME/AGENTS.md`.
- DSH exposes skill metadata at startup and loads skill bodies on invocation.
- A project-local `.ai/AGENTS.md` is not guaranteed to be always-on when DSH starts at repository root; applicability depends on its instruction-file discovery hierarchy or explicit reference.
- A skill can explicitly instruct DSH to read a project rule such as `.ai/rules/normative-language.md`, but this is a convention, not native rule-reference resolution.
- Global DSH skills MUST NOT assume that arbitrary projects contain `.ai/rules/...`.
- `.ai/rules/` is therefore an AIP Mirror organizational/semantic-ownership mechanism, not a portable AI-runtime ingestion channel.

These observations are version-sensitive and MUST be revalidated before implementation depends on them.

## Active ownership state

- `.ai/rules/repository.md` owns common repository mutation invariants and separates GitHub Connector mechanics from Agentic-host execution mechanics.
- `.ai/rules/developer-knowledge.md` owns the semantic invariant that Developer Knowledge front matter is valid YAML; parser choice is procedural.
- `.ai/skills/knowledge-capture/SKILL.md` owns the capture procedure and its agent-specific YAML-parser procedure.
- Architecture notes preserve evidence and rationale; they MUST NOT become second semantic/execution owners.
- `.ai/archives/` remains historical and MUST NOT be auto-loaded.

## Relevant files and references

### Agentic AI research

- `.ai/docs/architecture/agentic-ai-dsh-observations.md`
- `.ai/docs/architecture/agentic-ai-compatibility-architecture.md`
- remaining parked `agentic-ai-*` documents

### Developer Knowledge architecture

- `.ai/docs/architecture/developer-knowledge-archive.md`
- `.ai/rules/developer-knowledge.md`
- `.ai/skills/knowledge-capture/SKILL.md`

### Handoff / workflow infrastructure

- `.ai/workflows/handoff/BOOTSTRAP.md`
- `.ai/skills/handoff/SKILL.md`
- `.ai/skills/activation/SKILL.md`
- `.ai/rules/handoff/lifecycle.md`
- `.ai/rules/repository.md`

## Confirmed

- C0075 completed its bounded DSH architecture work.
- The DSH instruction-ingestion findings are now recorded in the C0075 handoff.
- The next chapter is C0076.
- The contextual natural-language knowledge-capture test remains unexecuted.
- No `>>capture` command has been introduced.

## Inferred

- The remaining parked Agentic AI documents may contain older assumptions that should be classified as historical, superseded, or still useful rather than rewritten indiscriminately.
- `.ai/docs/architecture/developer-knowledge-archive.md` may contain stale historical claims that should be separated from current active ownership.

## Assumed / unverified

- The exact set of parked `agentic-ai-*` documents requiring normalization has not yet been established for C0076.
- The DSH behavior remains subject to revalidation against the installed version before implementation work relies on it.
- Natural-language contextual activation may or may not reliably discover knowledge-capture capability.

## Open

- Inventory and normalize the remaining parked `agentic-ai-*` research documents against the C0075 host-boundary model.
- Revisit `.ai/docs/architecture/developer-knowledge-archive.md` for stale historical claims without turning it into an execution owner.
- Run the natural-language knowledge-capture activation/discovery test without explicitly activating the skill.
- If DSH implementation resumes, revalidate loader behavior against the installed DSH version.

## Immediate next task

Read and classify the remaining parked `agentic-ai-*` architecture documents and `.ai/docs/architecture/developer-knowledge-archive.md` against the C0075 boundary before making corrective edits.

## Recommended starting context

Start with this handoff, then read the C0075 handoff and the two current DSH/Agentic architecture notes. Inspect the parked research documents and Developer Knowledge architecture history from the repository before deciding what, if anything, needs normalization.

Do not introduce `>>capture` before the natural-language activation/discovery test provides evidence.
