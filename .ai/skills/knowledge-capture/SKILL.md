---
name: knowledge-capture
description: Capture durable, project-independent developer knowledge into the configured external knowledge repository while preserving educational structure, verification state, provenance, and repository safety.
---

# Knowledge capture

Use this skill when durable developer knowledge needs to be created or updated in the configured external knowledge repository.

The skill owns the **capture workflow**, not the knowledge itself. The external repository remains the durable human-facing knowledge store.

## Boundary

```
source material
    ↓
knowledge-capture
    ↓
configured developer knowledge repository
```

The source may be:

- useful material from the current conversation;
- an answer supplied by another AI;
- a procedure or command the user wants to preserve;
- an existing knowledge entry that needs normalization or correction;
- verified external technical material.

The skill MUST NOT treat source material as authoritative merely because it came from an AI.

## Repository resolution

The target repository MUST be resolved from the current project's `.ai/config.yaml`.

The skill MUST use the declared `references.repositories.developer_knowledge` entry and MUST NOT hard-code a repository name, URL, or local filesystem path.

If the configured reference is missing or ambiguous, STOP and report the configuration problem rather than guessing.

The developer knowledge repository is project-independent. The source project MAY appear in provenance, but it is not the semantic owner of the captured knowledge.

## Minimum entry model

Each entry MUST use Markdown with YAML front matter.

Required metadata:

```yaml
---
title: <human-readable title>
type: <concept | procedure | mental-model | recipe | troubleshooting | reference>
topics:
  - <technology/domain>
status: <draft | verified | version-sensitive | unverified>
provenance:
  - kind: <source category>
    agent: <optional>
    project: <optional>
    chapter: <optional>
    source: <optional locator>
    captured: <optional ISO date>
---
```

Optional `version` context SHOULD be recorded when software or tool version materially affects correctness.

The body is educational and variable. It SHOULD answer, where applicable:

1. What problem are we solving?
2. What is the simplest useful solution?
3. What does each important part mean?
4. How does the underlying mechanism work?
5. Why does the solution work?
6. What assumptions does it make?
7. What can go wrong?
8. What should the learner verify?
9. Are there safer or simpler alternatives?
10. Which parts are version-sensitive?
11. What related concepts are useful next?

Do not create empty headings merely to satisfy a template.

## Educational principle

The objective is reproducible understanding, not snippet preservation.

Prefer:

```
goal / problem
    ↓
short answer
    ↓
how it works
    ↓
step-by-step
    ↓
why it works
    ↓
gotchas / safety
    ↓
verification
    ↓
alternatives
    ↓
version notes
    ↓
related concepts
```

The exact section set MUST follow the educational needs of the entry.

Before writing an entry, the skill MUST read `.ai/rules/developer-knowledge.md`. That rule is the canonical owner of the active educational language and quality constraints for knowledge capture.

The skill SHOULD reuse the pedagogical principles of `.ai/skills/explain-code/SKILL.md` when explaining technical mechanisms.

## Capture procedure

For each capture operation:

1. **Capture** — identify the exact source material selected for preservation.
2. **Classify** — determine the primary `type` and `topics`.
3. **Discover** — search the target repository for related or overlapping entries before creating a new one.
4. **Normalize** — transform source material into a self-contained educational artifact; DO NOT copy conversational filler or another AI's answer verbatim.
5. **Verify** — distinguish confirmed facts, inferences, version-sensitive claims, and unverified claims.
6. **Provenance** — preserve one or more useful sources.
7. **Version context** — record relevant tool/software versions when they affect correctness.
8. **Write** — create a new entry or minimally update an existing entry in the configured repository.
9. **Read back** — reread the resulting entry from the repository.
10. **Verify scope** — inspect the resulting change and confirm that only the intended knowledge entry or entries changed.
11. **Report** — state what was captured, what was verified, and what remains uncertain.

## Provenance

Provenance is source-oriented metadata.

The `chapter` field is optional and MUST NOT be treated as:

- taxonomy;
- entry identity;
- semantic ownership;
- a universal source requirement.

Include `chapter` only when it materially improves traceability to a project conversation.

A source with no meaningful project or chapter context MAY omit both fields.

Useful provenance kinds include:

- `ai-conversation`;
- `agentic-ai`;
- `official-documentation`;
- `personal-experiment`;
- `github-issue`;
- `github-discussion`;
- `external-article`;
- `tutorial`.

The list is extensible as real entries require additional source categories.

## Verification state

Use:

- `verified` — checked against reliable evidence or successfully tested;
- `version-sensitive` — correct only within an identified version/context;
- `unverified` — useful material that still requires validation;
- `draft` — captured working material not yet ready as a durable learning artifact.

DO NOT promote plausible AI-generated claims to `verified` without evidence.

## Taxonomy

Filesystem path is the primary semantic topic.

Prefer flat-by-default, hierarchical-by-need organization. Create topic directories when real entries justify them.

Do not create empty taxonomy trees in advance.

The source project MUST NOT determine the primary taxonomy merely because it was the place where the knowledge was discovered.

## Repository mutation safety

For an existing knowledge entry, follow the repository's canonical mutation safety rules:

```
READ CURRENT FILE
    ↓
MAKE MINIMAL CHANGE
    ↓
WRITE COMPLETE FILE
    ↓
READ BACK
    ↓
VERIFY CONTENT
    ↓
INSPECT DIFF
    ↓
VERIFY SCOPE
    ↓
COMMIT
    ↓
VERIFY RESULT
```

For a new entry, verify that the target path does not already exist before creating it.

A successful API write or commit MUST NOT be treated as sufficient evidence of correctness.

The skill MUST NOT modify the source project merely to preserve knowledge unless the current operation explicitly requires a project-side provenance or configuration change.

## First-entry fixture

The first real fixture is a small Git + PowerShell procedure entry defined by the architecture note `.ai/docs/architecture/developer-knowledge-archive.md`.

It is expected to be a `procedure` with a strong mental-model component. The entry MUST teach the reusable concepts behind the operation rather than merely preserve a command.

## Output

A completed capture operation SHOULD leave:

1. a valid knowledge entry in the configured repository;
2. verified metadata and educational structure;
3. explicit provenance;
4. an honest verification state;
5. a read-back and scope verification record.

If any of these cannot be established, the operation MUST report the incomplete state rather than claiming successful capture.
