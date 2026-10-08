# Conversation Handoff

**Conversation:**
C0077 — Architecture & Research

**Specialization:**
C

**Chapter:**
0077

**Previous chapter:**
0076

## Starting objective

Continue the Architecture & Research track from C0076 by implementing and verifying the agreed DSH-first skill-discovery adapter path without duplicating the canonical `.ai/skills/` semantic source.

The immediate scope is to verify the user's local `.gitignore` and `.agents/skills` junction state, then perform a real DSH skill-discovery/invocation test against the canonical `.ai/skills/` content.

## Known starting implementation state

- Repository: `paulhuman/aip-mirror`
- Canonical branch: `main`
- Current chapter: C0077
- Previous chapter: C0076
- Specialization: C
- Short name: Architecture & Research
- Derived chapter identifier: C0077
- Root `AGENTS.md` exists and is currently empty.
- `.gitignore` was empty at the end of C0076; no repository-side ignore rule for `.agents/skills/` had been added at that checkpoint.
- The canonical skill source is `.ai/skills/`.
- C0076 established the intended near-term architecture:

  `ROOT / AGENTS.md → .ai/ canonical source → .ai/skills/ → .agents/skills (DSH adapter) → DSH`

- The project-local `.agents/skills` adapter is intended to be a Windows junction to `.ai/skills`. It is a local deployment detail and SHOULD be gitignored rather than represented as duplicated repository content.
- Global DSH `customSkillDirs` is already configured outside the repository for the user's `C:\Users\Paul\.dsh\skills` path.

## Decisions carried forward

- Prefer one canonical `.ai/skills/` source with host-specific discovery/packaging adapters.
- Do not introduce speculative multi-host adapter infrastructure yet; DSH is the immediate Agentic AI target.
- Do not modify the parked `agentic-ai-*` architecture research merely to make the new adapter model fit.
- Do not add `.ai/scripts/`, generated pointer layers, or other additional infrastructure before the DSH adapter has been exercised and verified.
- Root `AGENTS.md` should remain minimal until the DSH adapter path is proven; do not populate it speculatively.

## Relevant files and references

### DSH / Agentic architecture

- `.ai/docs/architecture/agentic-ai-dsh-observations.md`
- `.ai/docs/architecture/agentic-ai-compatibility-architecture.md`
- `.ai/skills/activation/SKILL.md`
- `.ai/skills/*/SKILL.md`

The DSH observations are version-sensitive evidence, not a timeless DSH specification. Before relying on a DSH-specific discovery or metadata detail operationally, revalidate it against the installed DSH version and, where practical, current primary evidence.

### Handoff / workflow infrastructure

- `.ai/workflows/handoff/BOOTSTRAP.md`
- `.ai/skills/handoff/SKILL.md`
- `.ai/rules/handoff/lifecycle.md`
- `.ai/rules/repository.md`
- `.ai/rules/commits.md`

### External research reference

- `paulhuman/developer-knowledge` — C0076 identified a DSH skills-discovery lesson here as useful research context. The exact lesson path was not resolvable through the available repository search during bootstrap and MUST be located before relying on it as an evidence source.

## Confirmed

- The receiving chapter identity is C0077 / specialization C.
- The predecessor handoff is `.ai/handoffs/C/C0076-Architecture-&-Research.md`.
- C0076 completed the immediate restructuring needed before DSH-first adapter work.
- The canonical architecture intentionally separates portable skill content from host-specific discovery and packaging.
- The DSH observation document states that `.ai/skills` is not an observed native DSH discovery root.
- The local `.agents/skills` junction had not been created or verified by C0076.
- At the C0076 checkpoint, `.gitignore` was empty and root `AGENTS.md` was empty.

## Inferred

- A Windows junction from `.agents/skills` to `.ai/skills` can provide the intended DSH discovery adapter without creating a second semantic skill source, if DSH's current loader behavior matches the recorded observations.
- The smallest useful repository-side change is likely limited to ignoring the local adapter path; this MUST be confirmed against the user's actual local state before mutation.

## Assumed / unverified

- The user's local `.agents/skills` junction may have been created after C0076; this chapter MUST inspect the actual local state rather than assume either outcome.
- The user may have already changed `.gitignore` after C0076; repository state MUST be reread before modifying it.
- Current DSH skill discovery and invocation behavior MUST be tested against the installed version before becoming an implementation assumption.
- The exact DSH skills-discovery lesson path in `paulhuman/developer-knowledge` remains unresolved.

## Open

- Verify the current `.gitignore` state and define the exact ignore entry for the local `.agents/skills` junction if required.
- Verify the local Windows junction from `.agents/skills` to `.ai/skills`.
- Perform a real DSH skill-discovery test using the adapter and canonical skill content.
- Perform a real DSH skill-invocation test and record observable evidence.
- Inspect current `.ai/skills/*/SKILL.md` front matter against the observed DSH loader contract and change only concrete incompatibilities.
- Locate and inspect the relevant DSH skills-discovery research in `paulhuman/developer-knowledge`.
- Define the minimal root `AGENTS.md` router only after the adapter path is proven.

## Immediate next task

Start by checking the user's current `.gitignore` change and local `.agents/skills` junction. Then run a real DSH skill-discovery/invocation test against the canonical `.ai/skills/` content and record the observed result before deciding whether any repository changes are necessary.

Do not resume the deferred `agentic-ai-*` normalization task unless the user explicitly reopens it.

## Recommended starting context

Read this handoff first, then revalidate the DSH observations, inspect the local adapter state, and perform the smallest reproducible discovery/invocation test. Treat DSH behavior as version-sensitive evidence and keep the canonical semantic source in `.ai/skills/`.

## C0077 late-chapter checkpoint

C0077 completed the DSH-first adapter verification. The following state is now confirmed and should be treated as the starting point for C0078:

- The canonical semantic skill source remains `.ai/skills/`.
- The local `.agents/skills` Windows junction successfully exposes the canonical skills to DSH without duplicating their contents.
- `.agents/` is gitignored.
- DSH, when started from the repository root, discovered all eight top-level project skills through the adapter and successfully invoked project skills including `knowledge-capture`, `activation`, and `normative-language`.
- The DSH verification and adapter implementation are recorded in `.ai/docs/architecture/agentic-ai-skill-discovery-verification.md` and `.ai/scripts/adapters/New-SkillAdapters.ps1`.
- Root `AGENTS.md` was populated during this work. Its current content must be audited rather than accepted as final architecture.

### New audit task for C0078

Perform the previously proposed **read-only audit** of the actual root `AGENTS.md` and compare it with:

- `.ai/AGENTS.md`;
- `.ai/config.yaml`;
- `.ai/rules/repository.md`;
- the intended architectural boundary:

  `ROOT / AGENTS.md → .ai/ canonical source`.

The audit must determine what in root `AGENTS.md` is correct, what is unnecessary or violates the intended boundary, and whether anything should be changed. Do not mutate files merely to perform the audit.

### New architectural concern: root AGENTS.md

The user explicitly questions the current root `AGENTS.md` because it is not sufficiently **project-agnostic** and because it directly references `.ai/docs/architecture/agentic-ai-skill-discovery-verification.md`, which was created as a temporary/version-sensitive verification artifact.

C0078 must therefore evaluate:

- whether root `AGENTS.md` should contain only durable, project-agnostic entry/router semantics;
- whether DSH-specific implementation details belong outside the root entry point;
- whether references from an active entry/owner to temporary or version-sensitive architecture evidence violate the intended ownership boundary;
- what the minimal durable root router should be, if any change is justified.

No correction is authorized merely by recording this concern; inspect the current files and establish the intended design before editing.

### New architectural question: rules versus skills

The user also questions the current `.ai/rules/` architecture in light of DSH behavior:

- DSH appears to force-load only skills.
- DSH can load rule content when a skill explicitly references a rule, but this is an optional convention rather than a host-enforced rule mechanism.
- Therefore, merely keeping semantics in `.ai/rules/` does not guarantee that an Agentic AI host will receive them.
- The user asks whether the repository should instead:
  - move rule semantics into skills where they must be loaded;
  - convert some existing rules into dedicated skills;
  - possibly eliminate `.ai/rules/` entirely.

C0078 must treat this as an **open architectural research question**, not as a predetermined migration plan. First establish the current semantic ownership model and actual host-loading behavior, then determine whether the rules/skills split still serves the architecture.

Important constraint: do not collapse rules into skills simply because DSH has no native rules mechanism. The decision must preserve the distinction between semantic ownership and host-specific loading, avoid duplicated owners, and be based on evidence.

## C0078 starting focus

1. Audit the current root `AGENTS.md` against the canonical `.ai/` sources and the ROOT → `.ai/` boundary.
2. Decide whether the root entry point can remain project-agnostic and durable without depending on temporary DSH verification documents.
3. Review the current `.ai/rules/` versus `.ai/skills/` ownership/loading model in light of the verified DSH behavior.
4. Identify which rule semantics, if any, genuinely need dedicated skills or another always-loaded mechanism.
5. Do not make structural changes to `.ai/rules/` or `.ai/skills/` until the architectural question has been researched and specified.
