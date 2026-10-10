# FAQ: адаптация `.ai/` к новому проекту

## Назначение

Этот FAQ объясняет, как перенести инфраструктуру `.ai/` из `aip-mirror` в другой репозиторий и адаптировать её, не перенося случайно в новый проект идентичность и специфику Illustrator.

Пример целевого проекта:

> **Sprite Sheet Editor** — desktop application using Rust + Tauri + Python + Pillow.

Основная идея:

```text
.ai/ = reusable AI infrastructure
config.yaml + docs/ + selected history = project-specific context
```

Не считайте текущий репозиторий `aip-mirror` чистым шаблоном проекта. В нём есть как повторно используемая инфраструктура, так и исторические и проектно-специфичные материалы.

---

## 1. Что необходимо изменить?

Есть четыре практические категории.

| Категория | Действие | Типичные примеры |
| --- | --- | --- |
| Идентичность проекта | ОБЯЗАТЕЛЬНО изменить | имя репозитория и проекта, ветка, hosting |
| Знания о проекте | ОБЯЗАТЕЛЬНО заменить | `docs/PROJECT-INSTRUCTIONS.md`, архитектура проекта |
| Встроенные ссылки на проект | ОБЯЗАТЕЛЬНО изменить или обобщить | жёстко заданные GitHub URL, test locators, примеры проекта |
| Исторические материалы | СЛЕДУЕТ удалить или сбросить | старые handoffs, результаты тестов, исследования AIP Mirror, старые references |

Самое важное заблуждение:

> `config.yaml` — основной файл проектной конфигурации, но проектные данные могут встречаться и в других местах.

---

# 2. Первый шаг: определите, что именно вы копируете

Полезная исходная структура для нового проекта:

```text
Копировать:
    .ai/AGENTS.md
    .ai/INDEX.md
    .ai/config.yaml              ← replace
    .ai/conversation-management/  ← explicitly invoked handoff/bootstrap material
    .ai/skills/
    .ai/skills/workflow/SKILL.md  ← general workflow principles
    .ai/docs/architecture/README.md
    .ai/docs/faq/
    .ai/tests/scenarios/     ← after checking scenarios
    docs/                        ← replace project-specific documents

Не копировать вслепую:
    .ai/handoffs/
    .ai/archives/
    old project references/
    old runtime test results/
    old project architecture/research
```

Если копируется весь репозиторий, перед началом работы над новым проектом выполните очистку.

---

# 3. `.ai/config.yaml` — основной файл конфигурации проекта

Его следует заменить в первую очередь.

Для Sprite Sheet Editor начало файла концептуально может выглядеть так:

```yaml
project:
  name: Sprite Sheet Editor
  repository: <owner>/sprite-sheet-editor
  default_branch: main
  hosting:
    type: github
    base_url: https://github.com/
```

### 3.1 `project`

Измените:

- `project.name`
- `project.repository`
- `project.default_branch`
- `project.hosting` if the new project uses another hosting provider

Эти значения используются инфраструктурой репозитория, разрешения путей и bootstrap.

### 3.2 `references.repositories`

Этот раздел тоже зависит от проекта.

В AIP Mirror здесь находятся ссылки на Illustrator SDK, Spectrum Web Components, Codex, Skills и agent.md.

Для Sprite Sheet Editor замените их ссылками, действительно относящимися к новому проекту, например:

- Tauri documentation/reference repository;
- Rust ecosystem references;
- Pillow/Python references;
- any project-specific research repositories.

Не сохраняйте ссылку только потому, что она присутствовала в шаблоне.

### 3.3 `specializations`

Specializations — это словарь конкретного проекта, а не универсальные константы AI-инфраструктуры.

Например, новый проект может определить:

```yaml
specializations:
  A:
    short_name: Project Workshop
  B:
    short_name: Tauri UI
  C:
    short_name: Architecture & Research
  D:
    short_name: Python Image Processing
```

Пара `A / Project Workshop` — canonical нейтральный пример из документации handoff. Это пример формата, а не обязательная специализация для всех проектов. Остальные буквы и названия специализаций зависят от проекта.

Если вы изменяете их, убедитесь, что старые handoff-файлы с несовместимыми именами не попали в новый репозиторий.

### 3.4 `terminology.commit_scopes`

Замените scopes AIP Mirror:

```text
mirror
geometry
plugin
adm
jsx
sdk
```

на scopes, подходящие новому проекту, например:

```text
core
tauri
ui
python
pillow
rust
docs
tests
```

### 3.5 `terminology.project_terms`

Замените терминологию Illustrator/FreeHand словарём нового проекта.

For example:

```text
sprite sheet
atlas
frame
texture region
Rust core
Tauri integration
Python tooling
Pillow
```

Этот раздел важен: commit skill использует настроенную терминологию при составлении commit messages и описаний, связанных с проектом.

---

# 4. `docs/PROJECT-INSTRUCTIONS.md` необходимо переписать

Это самый большой проектно-специфичный документ за пределами `config.yaml`.

Версия для AIP Mirror содержит:

- Adobe Illustrator assumptions;
- FreeHand behavioral targets;
- JSX prototype workflow;
- native C++ / AIP implementation;
- Illustrator-specific milestones;
- AIP Mirror workstream language;
- Illustrator SDK references.

Для Sprite Sheet Editor замените весь документ соответствующим контрактом нового проекта.

Например, в нём следует описать:

```text
Project purpose
    ↓
Rust application core
    ↓
Tauri integration
    ↓
frontend/UI
    ↓
Python/Pillow tooling
    ↓
validation/tests
```

Не пытайтесь сохранить цепочку разработки AIP Mirror, просто переименовав технологии. Сама архитектура будет другой.

Документ должен оставаться компактным. В нём следует описать:

- project orientation;
- project-specific constraints;
- project behavioral requirements;
- workstream coordination;
- routing to canonical project documentation.

Он НЕ должен превращаться во второй `.ai/INDEX.md`, свод правил репозитория или руководство по handoff.

---

# 5. `docs/architecture/project-architecture.md` необходимо заменить

Этот документ тоже зависит от проекта.

Текущий файл описывает архитектуру AIP Mirror, включая:

- JSX prototype versus production plugin;
- C++ + Illustrator AIP;
- Illustrator SDK boundary;
- mirror geometry;
- FreeHand behavior;
- Illustrator integration;
- four AIP Mirror specializations.

Для Sprite Sheet Editor здесь следует описать реальную архитектуру проекта, например:

```text
Rust
  = application/core logic

Tauri
  = desktop application boundary

Frontend
  = presentation and interaction

Python + Pillow
  = image-processing/tooling boundary
```

Конкретная архитектура относится к новому проекту, а не к повторно используемой инфраструктуре `.ai`.

---

# 6. Files inside `.ai/` that contain project-specific material

Most `.ai` files are intentionally generic. A few are not completely generic.

## 6.1 `.ai/conversation-management/handoff/SKILL.md`

This file is mostly reusable, but the current version contains a hardcoded repository locator:

```text
https://github.com/paulhuman/aip-mirror
```

It appears in generated/manual bootstrap transport examples.

For a reusable template, this should be generalized so the actual repository locator is derived from `.ai/config.yaml`, rather than being permanently embedded as an AIP Mirror URL.

Any project-specific illustrative sentence should be neutralized or removed when adapting the infrastructure.

The semantic handoff procedure itself should remain.

---

## 6.2 `.ai/conversation-management/handoff/BOOTSTRAP.md`

This is another mostly reusable file with an important embedded project reference.

It currently contains:

```text
https://github.com/paulhuman/aip-mirror
```

The workflow already states that generated repository locators come from:

```text
project.hosting.base_url
project.repository
```

Therefore the reusable workflow should not contain a literal AIP Mirror URL as if it were the new project's canonical locator.

Its example:

```text
SPECIALIZATION = A
SHORT_NAME = Project Workshop
```

is the canonical neutral example and SHOULD remain unchanged. It is an example, not project configuration.

---

## 6.3 `.ai/tests/scenarios/cold-start-command-trace.md`

The test scenario is conceptually reusable, but it currently hardcodes:

```text
paulhuman/aip-mirror@main:/.ai/AGENTS.md
```

For a new project, this must be generalized or parameterized.

The scenario also mentions the current five-command surface. That list is intentionally derived from the current `.ai/INDEX.md`, so the scenario should retain that dynamic rule rather than hardcoding AIP Mirror commands as the expected permanent command set.

The correct reusable principle is:

```text
explicit repository locator
    ↓
AGENTS
    ↓
bootstrap
    ↓
current INDEX command surface
    ↓
cold-start test
```

---

## 6.4 `.ai/conversation-management/handoff/SKILL.md`

The `A0001 / Project Workshop` example is the canonical neutral example of the filename/chapter contract.

Keep it when adapting the infrastructure to another project. It is an example of the required generic `A` specialization, not a project-specific technology name.

The actual chapter format and lifecycle rules are reusable.

---

## 6.5 `.ai/handoffs/README.md`

Same principle.

Its `A0001 / Project Workshop` example is a neutral format example, not an active project dependency.

Keep this example unchanged when adapting the infrastructure to another project.

Do not copy the actual AIP Mirror handoff files themselves.

---

# 7. `.ai/INDEX.md`

Normally this should require little or no project-specific editing.

Its role is to route commands to canonical infrastructure owners.

However, verify it after adapting:

- command names;
- canonical owner paths;
- capability map;
- structural references.

Do not add project architecture or project technology descriptions to INDEX merely because the new project uses Rust, Tauri, Python, etc.

Project technology belongs in `docs/PROJECT-INSTRUCTIONS.md` and project architecture documentation.

---

# 8. `.ai/AGENTS.md`

Normally this should remain unchanged.

It describes the always-on operating contract. Ordinary agent startup does not trigger chapter initialization; a receiving conversation follows the explicitly supplied bootstrap instruction and nested BOOTSTRAP procedure.

Do not put Sprite Sheet Editor-specific instructions here unless there is a genuine repository-wide AI infrastructure requirement.

The distinction is:

```text
AGENTS
    = how the AI infrastructure enters the repository

PROJECT-INSTRUCTIONS
    = what this particular project is
```

---

# 9. Canonical semantic ownership

There is no separate `.ai/rules/` layer in the target architecture. Shared operational semantics belong to their canonical first-level skills, including:

- `.ai/skills/repository/SKILL.md`;
- `.ai/skills/workflow/SKILL.md`;
- `.ai/skills/commits/SKILL.md`;
- `.ai/skills/knowledge-capture/SKILL.md`;
- `.ai/skills/normative-language/SKILL.md`.

Conversation lifecycle and handoff procedures are deliberately kept under `.ai/conversation-management/handoff/`, separate from ordinary skill discovery. Do not move these procedures into the first-level `.ai/skills/` namespace.

When adapting these owners, inspect examples and project references, but preserve reusable semantics. Do not create duplicate owners or mechanically copy old path references.

---

# 10. `.ai/skills/`

Shared skills are reusable capabilities and canonical owners. Keep the shared capabilities at the first level of `.ai/skills/`:

- activation;
- ai-infrastructure;
- commits;
- deep-understanding;
- explain-code;
- knowledge-capture;
- normative-language;
- repository;
- workflow.

Conversation handoff and reference-preservation material belongs under `.ai/conversation-management/handoff/`; it MUST NOT be treated as an ordinary first-level discovered skill.

Check each skill for project-specific examples or hardcoded repository locators. Change project-specific examples and references, not reusable capability semantics.

---

# 11. Workflow and conversation-management procedures

General AI workflow principles are owned by `.ai/skills/workflow/SKILL.md`. Human-facing independent-review onboarding templates live under `.ai/conversation-management/templates/` and are governed by the corresponding conversation-management procedures.

The receiving-chapter bootstrap procedure is owned by `.ai/conversation-management/handoff/BOOTSTRAP.md`. Keep it under conversation management rather than moving it into the first-level `.ai/skills/` namespace.

---

# 12. `.ai/docs/architecture/`

This directory has two different kinds of content.

## Reusable infrastructure material

Keep:

- `.ai/docs/architecture/README.md`
- reusable FAQ material;
- reusable architecture test scenarios after checking them.

## AIP Mirror historical material

The current:

```text
.ai/docs/architecture/ai-infrastructure-restructuring.md
```

is an architecture-history document for this repository's infrastructure evolution.

It is useful as historical evidence for AIP Mirror, but it should not automatically become part of a fresh Sprite Sheet Editor project.

For a copied template, remove it or replace it with the new project's own architecture-history document if one is needed.

---

# 13. `.ai/tests/scenarios/results/`

Do not copy old runtime results into a new project.

For example:

```text
.ai/tests/scenarios/results/cold-start-command-trace/...
.ai/tests/scenarios/results/trace-runtime-presentation/...
```

are evidence about previous runs of this repository's infrastructure.

They are historical records, not reusable project configuration.

For a new project:

1. keep the reusable test scenario;
2. remove old result artifacts;
3. run the test against the new repository;
4. create new result artifacts with the new repository revision and runtime context.

---

# 14. `.ai/handoffs/`

Treat the current handoffs as disposable project state when creating a new project from this repository.

Do not carry the existing project handoff files into the new repository.

The `A0001-Project-Workshop.md` example is a format example only. It is not a handoff to copy into the new project.

Instead:

1. create the new project's specialization vocabulary in `.ai/config.yaml`;
2. start the first chapter of each required specialization from chapter `0001`;
3. use the canonical bootstrap procedure;
4. let new handoffs be generated from the new project's actual work.

The README may remain as generic orientation.

---

# 15. `.ai/archives/`

Do not treat the archive as active infrastructure.

The current archive contains historical AIP Mirror architecture and handoffs.

When creating a new project from this repository, the safest default is:

```text
.ai/archives/
    = remove from the new project
```

If the archive contains a genuinely reusable infrastructure decision, manually extract that knowledge into the corresponding generic rule/skill/workflow/FAQ instead of copying the entire historical archive.

This prevents historical AIP Mirror decisions from silently becoming requirements of Sprite Sheet Editor.

---

# 16. `references/`

The current repository contains AIP Mirror research material such as:

- FreeHand manuals;
- Illustrator JavaScript documentation;
- Illustrator test screenshots;
- FreeHand test videos.

These are project-specific research references.

They should not be copied into Sprite Sheet Editor unless a reference is independently relevant.

For the new project, replace them with relevant material, for example:

```text
references/
    tauri/
    rust/
    python/
    pillow/
    image-formats/
    test-data/
```

The exact taxonomy is a project decision.

---

# 17. AIP Mirror-specific files outside `.ai/`

This is easy to miss because the request may sound like an `.ai` migration.

The current repository also has project-specific files under:

```text
docs/
references/
```

and potentially project source/prototype/test directories as the implementation grows.

The `.ai` infrastructure does not make those files reusable.

A copied repository therefore needs two separate audits:

```text
Audit A
.ai/
AI infrastructure + embedded project references

Audit B
repository root / docs / references / source
actual project implementation and knowledge
```

---

# 18. Recommended Sprite Sheet Editor adaptation

A practical sequence is:

### Step 1 — Copy

Copy the repository structure into the new repository.

### Step 2 — Reset project identity

Replace `.ai/config.yaml`.

### Step 3 — Replace project instructions

Rewrite:

```text
docs/PROJECT-INSTRUCTIONS.md
docs/architecture/project-architecture.md
```

### Step 4 — Generalize embedded repository locators

Check:

```text
.ai/conversation-management/handoff/SKILL.md
.ai/conversation-management/handoff/BOOTSTRAP.md
.ai/tests/scenarios/cold-start-command-trace.md
```

for the old repository URL and make those references configuration-driven or neutral.

### Step 5 — Reset conversation state

Remove old:

```text
.ai/handoffs/<old-specializations>/*
.ai/archives/handoffs/*
```

Keep only the generic handoff README if desired.

### Step 6 — Reset historical architecture evidence

Remove old AIP Mirror architecture history and runtime test results.

### Step 7 — Replace research references

Remove FreeHand/Illustrator material and add references relevant to the new application.

### Step 8 — Define the new project vocabulary

Update:

```text
specializations
terminology.commit_scopes
terminology.project_terms
references.repositories
```

in `.ai/config.yaml`.

### Step 9 — Review the active command surface

Check `.ai/INDEX.md`.

Keep the infrastructure commands that are useful for the new project. Do not create new commands merely because the technology stack changed.

### Step 10 — Bootstrap the first real chapter

Use the canonical:

```text
.ai/AGENTS.md
    ↓
.ai/conversation-management/handoff/BOOTSTRAP.md
```

path.

Do not invent a special "new project initialization" command.

---

# 19. Final adaptation checklist

Before starting real development, verify:

- [ ] `.ai/config.yaml` contains the new repository identity.
- [ ] `references.repositories` contains only relevant external references.
- [ ] `specializations` describes the new project's work areas.
- [ ] `terminology.commit_scopes` uses the new project's vocabulary.
- [ ] `terminology.project_terms` uses the new project's vocabulary.
- [ ] `docs/PROJECT-INSTRUCTIONS.md` has been completely replaced.
- [ ] `docs/architecture/project-architecture.md` has been completely replaced.
- [ ] No active workflow contains the old repository URL.
- [ ] No active test scenario contains the old repository locator.
- [ ] Old handoffs have been removed.
- [ ] Old archive/history has been removed or deliberately retained with a reason.
- [ ] Old project references have been removed.
- [ ] Old runtime test results have been removed.
- [ ] `.ai/AGENTS.md` still points to the canonical bootstrap workflow.
- [ ] `.ai/INDEX.md` still points to valid canonical owners.
- [ ] Generic rules remain generic.
- [ ] Generic skills remain generic.
- [ ] Bootstrap still resolves repository identity from `.ai/config.yaml`.
- [ ] A first new chapter can be initialized without guessing any AIP Mirror-specific data.

---

# 20. The shortest mental model

When turning `aip-mirror` into another project, think in three layers:

```text
┌─────────────────────────────────────────────┐
│ GENERIC AI INFRASTRUCTURE                   │
│                                             │
│ AGENTS / INDEX / rules / skills / workflows │
│                                             │
│ Mostly keep                                 │
└─────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────┐
│ PROJECT IDENTITY + PROJECT CONTRACT         │
│                                             │
│ config.yaml                                 │
│ docs/PROJECT-INSTRUCTIONS.md                │
│ docs/architecture/                          │
│                                             │
│ Replace                                    │
└─────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────┐
│ PROJECT HISTORY + RESEARCH                  │
│                                             │
│ handoffs / archive / references / results   │
│                                             │
│ Reset, remove, or deliberately replace      │
└─────────────────────────────────────────────┘
```

The most dangerous state is the hybrid one: a new project with a correct `config.yaml` but old AIP Mirror assumptions still hiding in `docs/`, handoff transport, test scenarios, archives, or references.
