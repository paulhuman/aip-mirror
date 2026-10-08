# Agent bootstrap — aip-mirror

DSH auto-loads this file for the repository root. It is a **router**, not an
owner: it orients a fresh session and points to the canonical sources. Every
rule, procedure, and skill lives in `.ai/`.

## What this repository is

An Adobe Illustrator plugin project that also carries a project-independent AI
working infrastructure.

```
.ai/     = AI working infrastructure (rules, skills, workflows, handoffs)
docs/    = project knowledge
```

Infrastructure work and plugin work are different domains with different
owners. Do not mix them.

## Read in this order

1. `.ai/config.yaml` — repository identity and configured references.
2. `.ai/rules/repository.md` — repository semantics, ownership boundary, write
   safety.
3. `.ai/AGENTS.md` — the internal operating contract for work inside `.ai/`.
4. `.ai/INDEX.md` — operation routing and the capability map.

Then read the specific owner for the operation at hand. `INDEX.md` routes; it
never replaces the owner.

## Ownership

**Active owners** — behaviour is defined here:

- `.ai/rules/` — semantic constraints
- `.ai/skills/` — reusable capabilities
- `.ai/workflows/` — ordered procedures
- `.ai/INDEX.md` — routing and discovery

**Supporting layers** — explain and record, own nothing: `.ai/handoffs/`,
`.ai/docs/`, `.ai/archives/`.

An active owner MUST NOT require a supporting file in order to be understood.
When a supporting note and an active owner disagree, the owner governs.

## Operating rules

- DO NOT infer conventions from memory. Read the current file.
- Re-read the owner before executing its operation; the repository version is
  authoritative, not remembered wording.
- A successful write or commit does not prove correct content. Read back,
  inspect the diff, verify scope.
- Distinguish confirmed from inferred from unverified. Never promote a
  plausible claim to `verified` without evidence — including a claim you made
  yourself in an earlier turn.

## Agentic environment (DSH)

Detailed, evidence-backed facts and open tasks live in
`.ai/docs/architecture/agentic-ai-skill-discovery-verification.md`. Read it
before touching skill discovery. The four things most likely to cost time:

1. `.ai/skills/` is **not** a discovery root. The project adapter
   `.agents/skills` is a Windows junction to it — structurally verified,
   **behaviourally unproven** (discovery through it has not been observed yet).
2. A `customSkillDirs` override on the `skill-filesystem` id does nothing: the
   host-plane row is disabled by `dsh-web-app`, which moved discovery into agent
   presets. Personal skills need no config — they live in `$DSH_HOME/skills`.
3. `--dump-config` shows the merged tree, not what loads. Confirm against the
   live available-skills catalog.
4. The **Minimal** preset loads no skills at all. Use **Standard**.

`dsh` is not on `PATH`. Use `npx --yes @deepseek-ai/dsh@0.2.0-rc.2` with
`DSH_HOME` set to `%APPDATA%\dsh-desktop\harness`.

## Language

Active rule, skill, and workflow files are written in **English**. Two
intentional exceptions: `.ai/docs/faq/` may explain in Russian, and
`.ai/rules/developer-knowledge.md` quotes Russian because the policy it owns is
*about* Russian prose. That knowledge-capture policy applies to the external
knowledge repository, not to this infrastructure.
