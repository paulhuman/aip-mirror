# Agent bootstrap — aip-mirror

This file is the repository entry point. It orients a fresh session and routes
to the canonical sources; every rule, procedure, and skill lives in `.ai/`.

This file owns only what it states itself. It does not own the rules, skills, or
workflows it routes to.

## What this repository is

An Adobe Illustrator plugin project that also carries a project-independent AI
working infrastructure.

```
.ai/     = AI working infrastructure (rules, skills, workflows, handoffs)
docs/    = project knowledge
```

Infrastructure work and plugin work are different domains. DO NOT mix them.

## Read in this order

1. `.ai/config.yaml` — repository identity and configured references.
2. `.ai/rules/repository.md` — repository semantics, ownership boundary, write
   safety.
3. `.ai/AGENTS.md` — the internal operating contract for work inside `.ai/`.
4. `.ai/INDEX.md` — operation routing and the capability map.

Then read the specific owner for the operation at hand. `INDEX.md` routes; it
does not replace the owner.

For project work rather than infrastructure work, start from
`docs/PROJECT-INSTRUCTIONS.md`.

## Ownership

The infrastructure separates **active semantic owners** from **supporting
layers**. Active owners define behaviour. Supporting layers explain and record;
they own nothing. `.ai/rules/repository.md` owns the canonical list and the
boundary between them.

An active owner MUST NOT require a supporting file in order to be understood.
When a supporting note and an active owner disagree, the owner governs.

## Operating rules

- DO NOT infer conventions from memory; DO read the current file.
- DO reread the owner before executing its operation; the repository version is
  authoritative, not remembered wording.
- A successful write or commit does not prove correct content. DO read back,
  inspect the diff, and verify scope.
- DO distinguish confirmed from inferred from unverified. An AI MUST NOT promote
  a plausible claim to `verified` without evidence, including a claim it made
  itself in an earlier turn.

## Language

Active rule, skill, and workflow files are written in **English**. Two
intentional exceptions: `.ai/docs/faq/` MAY explain in Russian, and
`.ai/rules/developer-knowledge.md` quotes Russian because the policy it owns is
*about* Russian prose. That knowledge-capture policy applies to the external
knowledge repository, not to this infrastructure.

## Host notes — DSH

Host-specific; not part of the portable contract. These facts describe the
installed build and are version-sensitive. DO revalidate them against the
running host before relying on them.

DSH auto-loads this file for the repository root. `.ai/skills/` is not a DSH
discovery root: the project adapter `.agents/skills` is a Windows junction to
it, and discovery through it is confirmed working. That adapter is gitignored,
so a fresh clone has to recreate it with
`pwsh -File .ai/scripts/adapters/New-SkillAdapters.ps1`. Whether any other host
reads `.agents/skills` is unverified.

`dsh` is not on `PATH`; run it as `npx --yes @deepseek-ai/dsh@0.2.0-rc.2` with
`DSH_HOME` set to `%APPDATA%\dsh-desktop\harness`.
