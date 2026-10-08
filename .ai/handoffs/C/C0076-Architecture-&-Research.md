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
## C0076 completed bounded work

C0076 completed the immediate AI-infrastructure restructuring needed before DSH-first adapter work:

- `.ai/docs/architecture/developer-knowledge-archive.md` was moved unchanged to `.ai/archives/docs/architecture/developer-knowledge-archive.md` as historical material. Source and archive content were verified identical before the source was removed.
- The six parked `.ai/docs/architecture/agentic-ai-*` documents were intentionally left unchanged. Their C0069/C0075 historical references are preserved as evidence and MUST NOT be treated as stale operational routing merely because newer architecture decisions exist.
- Root `AGENTS.md` was created as an empty repository entry point. It is intentionally not populated yet; its exact universal-router role will be defined before adding content.
- DSH Desktop global skill discovery is already configured through `customSkillDirs` for the user's global `C:\Users\Paul\.dsh\skills` path.
- The agreed near-term architecture is DSH-first and deliberately simple:

  `ROOT / AGENTS.md → .ai/ canonical source → .ai/skills/ → .agents/skills (DSH adapter) → DSH`

- The project-local `.agents/skills` adapter is expected to be a Windows junction to `.ai/skills`. The junction is a local deployment detail and SHOULD be gitignored rather than represented as duplicated repository content.
- The user will create the local junction and its `.gitignore` handling; the next chapter MUST verify the resulting repository state rather than assuming the adapter is correct.

## C0076 decisions carried forward

- Prefer one canonical `.ai/skills/` source with host-specific discovery/packaging adapters instead of maintaining separate semantic copies for Chat AI and Agentic AI.
- Do not introduce speculative multi-host adapter infrastructure yet. DSH is the immediate Agentic AI target.
- Do not modify the parked `agentic-ai-*` architecture research merely to make the new adapter model fit; preserve those documents as historical/research evidence until a bounded review explicitly requires changes.
- Do not add `.ai/scripts/`, generated pointer layers, or other additional infrastructure before the DSH adapter has been exercised and verified.

## C0076 final state

### Confirmed

- Main is the canonical repository branch.
- Root `AGENTS.md` exists and is currently empty.
- `.gitignore` is currently empty; no repository-side ignore rule for `.agents/skills/` has been added yet.
- The global DSH `customSkillDirs` connection is already configured outside the repository.
- The canonical skill source remains `.ai/skills/`.
- The local `.agents/skills` junction has not been created or verified by this AI.

### Open

- Define and verify the exact `.gitignore` entry for the local `.agents/skills` junction.
- Create the local Windows junction from `.agents/skills` to `.ai/skills`.
- Verify that DSH actually discovers the project skills through that adapter.
- Inspect existing `.ai/skills/*/SKILL.md` metadata against the observed DSH discovery requirements and correct only concrete incompatibilities.
- Define the minimal root `AGENTS.md` router after the DSH adapter path is proven, rather than filling it speculatively.

## Immediate next task for C0077

Continue with the DSH-first adapter implementation and verification. Start by checking the user's `.gitignore` change and local `.agents/skills` junction, then perform a real DSH skill-discovery/invocation test against the canonical `.ai/skills/` content.

Do not resume the deferred `agentic-ai-*` normalization task unless the user explicitly reopens it.

## Recommended starting context for C0077

Read this handoff first, then `.ai/docs/architecture/agentic-ai-dsh-observations.md`, the DSH skills-discovery lesson in the external `paulhuman/developer-knowledge` repository, `.ai/skills/activation/SKILL.md`, and the currently discovered `.ai/skills/*/SKILL.md` files. Treat DSH discovery facts as version-sensitive evidence from the user's installed environment and revalidate them before relying on them operationally.
