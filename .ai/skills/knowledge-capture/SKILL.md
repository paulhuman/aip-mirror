---
name: knowledge-capture
description: Capture durable, project-independent developer knowledge into the configured external knowledge repository while preserving educational structure, verification state, provenance, and repository safety.
---

# Knowledge capture

Use this skill when durable developer knowledge needs to be created or updated in the configured external knowledge repository.

The skill owns the **capture workflow**, not the knowledge model. The external repository remains the durable human-facing knowledge store.

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

## Canonical policy owner

Before writing any entry, this skill MUST read `.ai/rules/developer-knowledge.md`.

That rule is the active semantic owner of:

- the entry metadata contract (front matter fields and their constraints);
- the two body genres and their section sets;
- the single-source-mention rule;
- the ASCII diagram rules;
- the educational language policy.

This skill MUST NOT restate, extend, or override those requirements. When the rule and this skill appear to disagree, the rule governs.

## Agent-specific procedures

These procedures apply when working as a tool-using agent that can inspect
and modify repository files. They are not instructions for a chat-only
assistant and are not something a user performs manually.

### Parse front matter

Parse YAML front matter with an actual YAML parser before processing or
committing the knowledge entry. A visual check or a hand-written pattern
check is not sufficient evidence that the metadata is valid YAML.

The skill owns only the capture procedure below.

## Capture procedure

For each capture operation:

1. **Capture** — identify the exact source material selected for preservation.
2. **Classify** — determine the primary `type` and `topics` under the metadata contract.
3. **Discover** — search the target repository for related or overlapping entries before creating a new one.
4. **Normalize** — transform source material into a self-contained educational artifact; DO NOT copy conversational filler or another AI's answer verbatim.
5. **Select genre** — choose the reference or educational body genre from `type` and follow the section set owned by the rule.
6. **Verify** — distinguish confirmed facts, inferences, version-sensitive claims, and unverified claims.
7. **Provenance** — record traceable origin in the compact `origin` value; place source URLs once under `## Источники`. When the source is a project repository, identify that repository by name in `origin`, for example `origin: ChatGPT · <project-repository>`.
8. **Version context** — record the environment in `env` when it affects correctness.
9. **Write** — create a new entry or minimally update an existing entry in the configured repository.
10. **Validate front matter** — verify the entry against the active metadata contract; the Agent-specific parser procedure above applies when this skill is executed by a tool-using agent.
11. **Read back** — reread the resulting entry from the repository.
12. **Verify scope** — inspect the resulting change and confirm that only the intended knowledge entry or entries changed.
13. **Report** — state what was captured, what was verified, and what remains uncertain.

## Verification state

Use the `status` vocabulary owned by the rule:

- `verified` — checked against reliable evidence or successfully tested;
- `version-sensitive` — correct only within an identified version/context;
- `unverified` — useful material that still requires validation;
- `draft` — captured working material not yet ready as a durable learning artifact.

DO NOT promote plausible AI-generated claims to `verified` without evidence.
