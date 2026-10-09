---
name: knowledge-capture
description: Capture durable, project-independent developer knowledge into the configured external knowledge repository while preserving educational structure, verification state, provenance, and repository safety.
---

# Knowledge capture

Use this skill when durable developer knowledge needs to be created or updated in the configured external knowledge repository.

This skill owns both the knowledge-entry model and the capture workflow. The external repository remains the durable human-facing knowledge store. The model governs entries created or updated by this skill; it does not become semantic content of the external repository itself.

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

## Knowledge model and entry contract

The following requirements are the canonical model for entries created or updated by this skill. The metadata contract, body genres, single-source-mention policy, ASCII diagram rules, and educational language policy are defined here rather than delegated to a separate rule file.

## 2. Educational language policy

The knowledge repository uses a deliberate two-layer language model:

> **Russian is the explanatory language; English is the canonical vocabulary of professional terminology.**

Knowledge entries MUST use Russian for explanatory prose.

The following SHOULD remain in their canonical English form:

- names of entities;
- professional terminology;
- technology and product names;
- command names;
- API names;
- parameter and option names;
- identifiers from source code;
- stable technical expressions.

A professional term SHOULD NOT be translated merely for the sake of translation. When a term benefits from explanation, introduce it in its canonical English form and explain its meaning in Russian.

This policy does not require English everywhere. Natural Russian phrasing remains appropriate when describing an operation or concept in ordinary explanatory language.

This skill is written in English, consistent with the active AI-infrastructure owners. Only the captured knowledge entries use the Russian explanatory layer.

## 3. Educational quality

Knowledge capture MUST optimize for durable understanding rather than snippet preservation.

Entries SHOULD explain, where applicable:

- the problem being solved;
- the simplest useful solution;
- the meaning of important parts;
- the underlying mechanism;
- why the solution works;
- assumptions and limitations;
- gotchas and safety considerations;
- verification;
- alternatives;
- version-sensitive behavior;
- related concepts.

The exact structure MUST follow the educational needs of the entry. Empty headings MUST NOT be created merely to satisfy a template.

## 4. Source material is not authority

AI-generated or externally supplied material MUST NOT be treated as verified merely because it is useful or plausible.

Knowledge capture MUST distinguish confirmed facts, inferences, version-sensitive claims, and unverified material.

## 5. Entry metadata contract

Every entry MUST begin with a YAML front matter envelope of four required fields and two optional fields:

```yaml
---
title: <human-readable title>
type: <concept | procedure | mental-model | recipe | troubleshooting | reference>
topics: [<technology/domain>, <technology/domain>]
status: <draft | verified | version-sensitive | unverified>
env: <one-line environment context>        # optional
origin: <one-line human-readable source>   # optional
---
```

Field semantics:

- `title` — stable human-facing identity of the entry;
- `type` — primary educational form;
- `topics` — technology/domain taxonomy; a flat inline list, not a nested block;
- `status` — current trust/verification state;
- `env` — the concrete environment in which the entry is known to hold; include it whenever correctness depends on versions, OS, or runtime;
- `origin` — compact human-readable source, for example `ChatGPT · <project-repository>` or `Git documentation`. When the entry is captured from a project repository, the repository name identifies that project context without making it the semantic owner.

Constraints:

1. The envelope MUST NOT exceed these six fields.
2. Nested provenance objects, `provenance[]` arrays, `version:` sub-blocks, and unrelated metadata fields MUST NOT be introduced as front matter fields.
3. Source URLs MUST NOT appear in front matter. They belong in the body under a single `## Источники` section.
4. Every scalar value MUST be written so that it parses as a plain YAML scalar. A value MUST NOT contain a `": "` (colon followed by a space) sequence, because YAML reads it as the start of a nested mapping. Use `·` to separate parts, or `—` instead of a colon.
5. `title`, `env`, and `origin` are the fields most likely to carry a colon, because they contain natural language. When a colon is genuinely needed in one of them, the value MUST be wrapped in double quotes.
6. A field MUST be omitted rather than filled with a placeholder when the value is unknown.
7. Front matter MUST be valid YAML and MUST parse successfully as YAML before the entry is committed. The specific parser and validation mechanism are execution details of the active capture procedure or host.

The envelope now carries only what is needed to answer four questions:

```
What is it?          title + type
Where does it belong?  topics
How much to trust it?  status + env
Where did it come from? origin
```

## 6. Body genres

An entry MUST follow one of two distinct genres. The genre is determined by `type`.

### 6.1 Reference genre (cheat sheet)

Used for `type: reference`. Optimized for fast return to already-understood material.

```
Заголовок
  + blockquote: what this document contains
  + Окружение (one line)
Карта темы (ASCII diagram of the whole system)
Таблица сущностей (name/path → role)
Рецепты: [why] → command → what happens → common mistakes
Диагностика: symptom → cause → treatment
Мини-схема «как устроено» at the end
```

The reference genre SHOULD be dense and tabular. It SHOULD NOT carry long explanatory prose, analogies, or step-by-step mechanism walkthroughs.

### 6.2 Educational genre

Used for `type: concept`, `procedure`, `mental-model`, `recipe`, or `troubleshooting`. Optimized for a learner who does not yet understand the material.

```
Заголовок
  + blockquote: what the learner will be able to do after reading
  + Окружение (one line)
Аналогия из бытовой жизни
ASCII-диаграмма общей картины
Проблема / зачем это нужно
Короткий ответ (что можно применить сразу)
Разбор по частям (таблица: часть → что делает → почему так)
Как это работает — пошагово, по одной диаграмме на шаг
Почему это работает
Что может пойти не так / безопасность
Как проверить, что получилось
Альтернативы
Version notes
Связанные понятия
Мини-словарь (canonical English term → Russian explanation)
Источники
```

Educational genre requirements:

1. An analogy SHOULD be present unless it would be artificial for the topic.
2. The analogy MUST lead the entry: it comes before the mechanism, not after it. Explain the everyday comparison first, then map it onto the technical material.
3. A complex concept SHOULD be supported by more than one analogy when a single comparison cannot carry the whole mechanism. An analogy that breaks down part-way MUST be followed by another one rather than stretched past its limits.
4. An analogy MUST be marked as an analogy. It is a teaching device, not evidence: it MUST NOT be presented as proof that the mechanism works the way the comparison suggests.
5. The explanatory tone SHOULD stay conversational. Prose is addressed to a learner, not written as a specification.
6. Every command SHOULD be broken down by its options in a table (option → effect → difference from related options).
7. At least one «что будет, если…» scenario SHOULD illustrate an incorrect or unsafe usage. The scenario SHOULD name the likely misconception, not only the misuse.
8. Callout blockquotes SHOULD be used for the important cases: `> **Важно**`, `> **Частая ошибка**`, `> **Проверь**.
9. Sections MUST be omitted when they add nothing. A short entry is preferable to a padded one.

## 7. Single source mention

Every source, insight, or verification reference MUST appear in the entry exactly once.

Consequences:

1. When provenance is summarized in `origin`, the body MUST NOT repeat it under a `## Provenance` heading.
2. The `## Источники` section MUST be the single place where source URLs appear.
3. A verification section MUST describe *what was checked* (for example «поведение `-d`/`-D` сверено с `git-branch` documentation»), not re-list the URLs.
4. Redundant section pairs such as `## Sources` + `## Provenance` + `## Verification` MUST NOT all be present.

## 8. ASCII diagram rules

Diagrams SHOULD be used where the material has flow, hierarchy, state, or decisions, and MUST NOT be used where a list is sufficient.

Appropriate:

- data flow — `git branch -r → filter → strip prefix → push --delete`;
- hierarchy / nesting — `DSH Desktop → Harness → profile web → node_modules`;
- before/after state — a branch list before and after filtering;
- decision tree — symptom → cause → treatment;
- step ordering — `Update Desktop → About → DSH_HOME → plugin add`.

Constraints:

1. Maximum width is 80 characters.
2. Use the box-drawing and arrow set: `│ ├ └ ─ → ↓ ≠`.
3. Labels are Russian; canonical technical terms remain English.
4. A diagram MUST be readable as plain text, without Markdown rendering.

The pedagogical baseline comes from `.ai/skills/explain-code/SKILL.md`: analogy, diagram, step-by-step walkthrough, gotcha.

## 9. Taxonomy

Filesystem path is the primary semantic topic.

Prefer flat-by-default, hierarchical-by-need organization. Create topic directories when real entries justify them.

Do not create empty taxonomy trees in advance.

The source project MUST NOT determine the primary taxonomy merely because it was the place where the knowledge was discovered.

File names MUST be lowercase kebab-case.


## Agent-specific procedures

These procedures apply when working as a tool-using agent that can inspect
and modify repository files. They are not instructions for a chat-only
assistant and are not something a user performs manually.

### Parse front matter

Parse YAML front matter with an actual YAML parser before processing or
committing the knowledge entry. A visual check or a hand-written pattern
check is not sufficient evidence that the metadata is valid YAML.

The capture procedure below operationalizes the knowledge model defined above.

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
