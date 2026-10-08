# DSH Desktop — Agentic AI observations

## Purpose

This document preserves the DSH observations discussed during C0075 so later
chapters do not have to reconstruct the findings from conversation history.
They describe the inspected DSH Desktop environment and MUST be treated as
version-sensitive observations rather than a timeless DSH specification.

## 1. Audience labels are semantic, not technical

DSH does not provide an observed skill metadata field such as `audience` or
`agent-only` that filters instruction content by reader. `user-invocable` and
`disable-model-invocation` control invocation permissions, not the semantic
audience of instructions inside a skill.

Therefore a note such as `Agent-only rules` can be useful as an explicit
semantic boundary, but it is not a technical filter. A stronger pattern is
to make applicability follow from the required capability or tool itself.

Observed examples discussed with DSH included instructions referring to tools
that exist only in the tool-using environment. This lets the required
capability act as an objective applicability condition.

## 2. Observed DSH skill discovery and packaging

The inspected DSH skill loader was reported to search these roots, in priority
order:

1. `<project>/.dsh/skills`
2. `<project>/.agents/skills`
3. configured `customSkillDirs`
4. `%APPDATA%\\dsh-desktop\\harness\\skills`
5. `~/.agents/skills`
6. bundled skills

The exact roots and precedence are version-sensitive observations.

`.ai/skills` is not an observed native DSH discovery root. The AIP Mirror
`.ai/skills/` tree therefore MUST NOT be described as a universal Agentic AI
skill directory.

Observed supported package shapes included:

```text
skills/my-skill/SKILL.md
skills/flat-skill.md
```

Observed required front matter:

```yaml
---
name: my-skill-name
description: What the skill does and when to use it.
---
```

Observed optional DSH-specific fields included:

- `whenToUse`
- `disable-model-invocation`
- `user-invocable`

Legacy camelCase variants such as `disableModelInvocation` and
`modelInvocable` should not be assumed to be equivalent.

Invalid YAML or missing required `name` / `description` was reported as a
reason for the loader to skip a skill, with a log warning.

## 3. `openai.yaml` is not a universal skill contract

DSH was reported not to require `openai.yaml` for its native skill loading.
`openai.yaml` associated with a `review-agent` package should therefore not be
used as evidence for a universal rule that skills require an `agents/`
subdirectory or OpenAI-specific metadata.

Platform metadata and skill instruction content are separate concerns.

## 4. Repository mutation safety

DSH has a real working copy and can use mechanisms such as local `write`,
`edit`, shell commands, and Git. Its tool layer was reported to enforce
read-before-edit behavior.

That does not make the mutation mechanism identical to the GitHub Connector.
The common architecture is therefore:

```text
.ai/rules/repository.md
        ↓
canonical repository mutation invariants
        ↓
    +----------------------+
    |                      |
ChatGPT + Connector     Agentic AI
    |                      |
GitHub API mechanics    host-specific execution
```

Host-specific mechanics MUST NOT be copied into the repository-wide rule as a
second universal procedure.

## 5. Front matter parsing boundary

Valid YAML front matter is a semantic invariant of Developer Knowledge.
Using an actual YAML parser is a validation procedure appropriate to a
tool-using capture workflow. The parser implementation and loader contract
remain host-specific.

This distinction is now reflected in the active owners:

- `.ai/rules/developer-knowledge.md` owns the semantic metadata contract;
- `.ai/skills/knowledge-capture/SKILL.md` owns the capture procedure and
  contains the Agent-specific YAML-parser procedure.

## 6. Architectural consequence

Agentic AI compatibility must not be modeled as one universal skill folder or
one universal metadata format.

The durable boundary is:

```text
portable instructional content
        ↓
host-specific packaging
        ↓
host-specific discovery
        ↓
host-specific activation / invocation
        ↓
host-specific execution capabilities
```

Shared content can therefore be portable without requiring identical host
contracts.

## 7. DSH-specific adaptation

A DSH adaptation of a shared capability may need a DSH-native package or
discovery location. This does not justify changing the ChatGPT-oriented
`.ai/skills/` owner to contain DSH-specific runtime assumptions.

The same principle applies to Codex, Claude Code, and other Agentic AI hosts:
first separate portable instructional semantics from the host's packaging,
discovery, activation, metadata, and execution contracts.

## 8. Evidence status

These findings are a durable research checkpoint, not a normative DSH
specification. Before implementation work depends on a DSH-specific detail,
revalidate it against the installed DSH version and, where practical, its
source code or current primary documentation.
