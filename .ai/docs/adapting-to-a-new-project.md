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
    .ai/config.yaml              ← заменить
    .ai/conversation-management/  ← явно вызываемые процедуры handoff/bootstrap
    .ai/skills/
    .ai/skills/workflow/SKILL.md  ← общие принципы workflow
    .ai/docs/README.md
    selected reusable documents from .ai/docs/  ← after reviewing project relevance
    .ai/tests/scenarios/     ← после проверки сценариев
    docs/                        ← заменить проектно-специфичные документы

Не копировать вслепую:
    .ai/handoffs/
    .ai/archives/
    старые ссылки на проект/
    старые результаты runtime-тестов/
    старая архитектура и исследования проекта
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
- `project.hosting`, если новый проект использует другого hosting provider

Эти значения используются инфраструктурой репозитория, разрешения путей и bootstrap.

### 3.2 `references.repositories`

Этот раздел тоже зависит от проекта.

В AIP Mirror здесь находятся ссылки на Illustrator SDK, Spectrum Web Components, Codex, Skills и agent.md.

Для Sprite Sheet Editor замените их ссылками, действительно относящимися к новому проекту, например:

- документация и reference repository Tauri;
- материалы экосистемы Rust;
- материалы Pillow/Python;
- исследовательские репозитории, относящиеся к конкретному проекту.

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

Например:

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

- предположения, связанные с Adobe Illustrator;
- целевые поведенческие характеристики FreeHand;
- workflow JSX-прототипа;
- реализация на native C++ / AIP;
- этапы, специфичные для Illustrator;
- терминология рабочих направлений AIP Mirror;
- ссылки на Illustrator SDK.

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

# 6. Файлы внутри `.ai/` с проектно-специфичным содержимым

Большинство файлов `.ai` намеренно универсальны. Некоторые из них не полностью универсальны.

## 6.1 `.ai/conversation-management/handoff/SKILL.md`

Этот файл в основном пригоден для повторного использования, но текущая версия содержит жёстко заданный locator репозитория:

```text
https://github.com/paulhuman/aip-mirror
```

Он встречается в примерах transport для generated/manual bootstrap.

В универсальном шаблоне это следует обобщить: фактический locator репозитория должен вычисляться из `.ai/config.yaml`, а не быть навсегда заданным URL AIP Mirror.

При адаптации инфраструктуры любые проектно-специфичные примеры следует сделать нейтральными или удалить.

Саму семантику процедуры handoff следует сохранить.

---

## 6.2 `.ai/conversation-management/handoff/BOOTSTRAP.md`

Это ещё один в основном универсальный файл, содержащий важную встроенную ссылку на проект.

It currently contains:

```text
https://github.com/paulhuman/aip-mirror
```

В workflow уже указано, что generated repository locators берутся из:

```text
project.hosting.base_url
project.repository
```

Поэтому универсальный workflow не должен содержать буквальный URL AIP Mirror, как будто это canonical locator нового проекта.

Его пример:

```text
SPECIALIZATION = A
SHORT_NAME = Project Workshop
```

— canonical нейтральный пример, который СЛЕДУЕТ оставить без изменений. Это пример, а не конфигурация проекта.

---

## 6.3 `.ai/tests/scenarios/cold-start-command-trace.md`

Сценарий тестирования концептуально универсален, но сейчас в нём жёстко задано:

```text
paulhuman/aip-mirror@main:/.ai/AGENTS.md
```

Для нового проекта это необходимо обобщить или параметризовать.

Сценарий также упоминает текущий набор из пяти команд. Этот список намеренно выводится из актуального `.ai/INDEX.md`, поэтому следует сохранить динамическое правило, а не жёстко фиксировать команды AIP Mirror как постоянный ожидаемый набор.

Правильный универсальный принцип:

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

Пример `A0001 / Project Workshop` — canonical нейтральный образец соглашения об имени файла и chapter.

Сохраните его при адаптации инфраструктуры к другому проекту. Это пример универсальной specialization `A`, а не название проектной технологии.

Сам формат chapter и правила lifecycle универсальны.

---

## 6.5 `.ai/handoffs/README.md`

Действует тот же принцип.

Пример `A0001 / Project Workshop` демонстрирует формат и не является активной зависимостью проекта.

Сохраните этот пример без изменений при адаптации инфраструктуры к другому проекту.

Не копируйте сами handoff-файлы AIP Mirror.

---

# 7. `.ai/INDEX.md`

Обычно этот файл почти не требует проектных изменений или не требует их вовсе.

Его задача — направлять команды к canonical owners инфраструктуры.

Однако после адаптации проверьте:

- command names;
- canonical owner paths;
- capability map;
- structural references.

Не добавляйте в INDEX описание архитектуры или технологий только потому, что новый проект использует Rust, Tauri, Python и т. п.

Технологии проекта следует описывать в `docs/PROJECT-INSTRUCTIONS.md` и документации архитектуры проекта.

---

# 8. `.ai/AGENTS.md`

Обычно этот файл следует оставить без изменений.

Он описывает always-on operating contract. Обычный запуск agent не инициирует создание chapter; принимающий разговор следует явно переданной bootstrap-инструкции и вложенной процедуре BOOTSTRAP.

Не добавляйте сюда инструкции, специфичные для Sprite Sheet Editor, если только они не являются настоящим требованием AI-инфраструктуры всего репозитория.

Различие следующее:

```text
AGENTS
    = how the AI infrastructure enters the repository

PROJECT-INSTRUCTIONS
    = what this particular project is
```

---

# 9. Каноническое владение семантикой

В целевой архитектуре нет отдельного слоя `.ai/rules/`. Общая операционная семантика принадлежит соответствующим canonical skills первого уровня, включая:

- `.ai/skills/repository/SKILL.md`;
- `.ai/skills/workflow/SKILL.md`;
- `.ai/skills/commits/SKILL.md`;
- `.ai/skills/knowledge-capture/SKILL.md`;
- `.ai/skills/normative-language/SKILL.md`.

Lifecycle разговора и процедуры handoff намеренно находятся в `.ai/conversation-management/handoff/`, отдельно от обычного skill discovery. Не переносите эти процедуры в пространство имён `.ai/skills/` первого уровня.

При адаптации этих owners проверяйте примеры и ссылки на проект, но сохраняйте универсальную семантику. Не создавайте дублирующие owners и не копируйте старые пути механически.

---

# 10. `.ai/skills/`

Общие skills — это повторно используемые возможности и canonical owners. Оставляйте общие возможности на первом уровне `.ai/skills/`:

- activation;
- ai-infrastructure;
- commits;
- deep-understanding;
- explain-code;
- knowledge-capture;
- normative-language;
- repository;
- workflow.

Материалы handoff и reference-preservation относятся к `.ai/conversation-management/handoff/`; их НЕЛЬЗЯ считать обычными обнаруживаемыми skills первого уровня.

Проверьте каждый skill на проектно-специфичные примеры и жёстко заданные repository locators. Изменяйте примеры и ссылки на проект, а не универсальную семантику возможностей.

---

# 11. Процедуры workflow и conversation management

Общие принципы AI workflow принадлежат `.ai/skills/workflow/SKILL.md`. Шаблоны onboarding для независимой проверки человеком находятся в `.ai/conversation-management/templates/` и регулируются соответствующими процедурами conversation management.

Процедура bootstrap для принимающего chapter принадлежит `.ai/conversation-management/handoff/BOOTSTRAP.md`. Оставьте её в conversation management, не перемещая в пространство имён `.ai/skills/` первого уровня.

---

# 12. `.ai/docs/`

Текущий каталог `.ai/docs/` плоский: тематических подкаталогов `architecture/` и `faq/` в актуальной структуре нет. Документы следует оценивать по их назначению и переносимости, а не по прежнему расположению.

## Повторно используемые материалы об инфраструктуре

Сохранить:

- `.ai/docs/README.md` — описание структуры и назначения документации;
- отдельные документы из `.ai/docs/`, если их содержание переносимо в новый проект;
- повторно используемые test scenarios после проверки их актуальности.

## Материалы с контекстом и историей AIP Mirror

Ранее здесь указывался файл `.ai/docs/architecture/ai-infrastructure-restructuring.md`, но такого пути в текущей структуре больше нет. `ai-infrastructure-context-mode.md` находится в `.ai/docs/` и содержит архитектурный контекст, часть которого относится к истории этого репозитория.

Этот материал может быть полезен как свидетельство развития AIP Mirror, но его нельзя автоматически переносить в новый проект Sprite Sheet Editor.

При адаптации переносите только обобщаемые решения и rationale. Исторические детали AIP Mirror не следует включать в новый проект; при необходимости создайте отдельную историю архитектуры нового проекта.

---

# 13. `.ai/tests/scenarios/results/`

Не копируйте старые результаты runtime-тестов в новый проект.

For example:

```text
.ai/tests/scenarios/results/cold-start-command-trace/...
.ai/tests/scenarios/results/trace-runtime-presentation/...
```

— свидетельства о предыдущих запусках инфраструктуры этого репозитория.

Это исторические записи, а не повторно используемая конфигурация проекта.

Для нового проекта:

1. сохранить универсальный тестовый сценарий;
2. удалить старые артефакты результатов;
3. запустить тест в новом репозитории;
4. создать новые артефакты с revision нового репозитория и контекстом runtime.

---

# 14. `.ai/handoffs/`

При создании нового проекта на основе этого репозитория считайте текущие handoffs временным состоянием проекта.

Не переносите существующие handoff-файлы проекта в новый репозиторий.

Пример `A0001-Project-Workshop.md` показывает только формат. Это не handoff, который следует копировать в новый проект.

Вместо этого:

1. определить названия специализаций нового проекта в `.ai/config.yaml`;
2. начать первую главу каждой необходимой специализации с chapter `0001`;
3. использовать canonical bootstrap procedure;
4. создавать новые handoffs на основе реальной работы над новым проектом.

README можно оставить как универсальное вводное описание.

---

# 15. `.ai/archives/`

Не считайте архив активной инфраструктурой.

Текущий архив содержит исторические материалы архитектуры AIP Mirror и handoffs.

При создании нового проекта на основе этого репозитория самый безопасный вариант по умолчанию:

```text
.ai/archives/
    = remove from the new project
```

Если архив содержит действительно универсальное решение по инфраструктуре, вручную перенесите эти знания в соответствующий общий rule/skill/workflow/FAQ вместо копирования всего исторического архива.

Так исторические решения AIP Mirror не станут незаметно требованиями Sprite Sheet Editor.

---

# 16. `references/`

Текущий репозиторий содержит исследовательские материалы AIP Mirror, например:

- FreeHand manuals;
- Illustrator JavaScript documentation;
- Illustrator test screenshots;
- FreeHand test videos.

Это исследовательские ссылки и материалы конкретного проекта.

Не копируйте их в Sprite Sheet Editor, если конкретный материал не имеет самостоятельной ценности для нового проекта.

Для нового проекта замените их актуальными материалами, например:

```text
references/
    tauri/
    rust/
    python/
    pillow/
    image-formats/
    test-data/
```

Точная классификация каталогов определяется проектом.

---

# 17. Файлы AIP Mirror за пределами `.ai/`

Об этом легко забыть, поскольку задача может звучать как перенос только `.ai`.

В текущем репозитории также есть проектно-специфичные файлы в каталогах:

```text
docs/
references/
```

а по мере развития реализации — возможно, и в каталогах исходного кода, прототипов и тестов.

Наличие инфраструктуры `.ai` не делает эти файлы универсальными.

Поэтому скопированный репозиторий требует двух отдельных аудитов:

```text
Audit A
.ai/
AI infrastructure + embedded project references

Audit B
repository root / docs / references / source
actual project implementation and knowledge
```

---

# 18. Рекомендуемый порядок адаптации для Sprite Sheet Editor

Практическая последовательность:

### Шаг 1 — Копирование

Скопируйте структуру репозитория в новый репозиторий.

### Шаг 2 — Сброс идентичности проекта

Замените `.ai/config.yaml`.

### Шаг 3 — Замена инструкций проекта

Перепишите:

```text
docs/PROJECT-INSTRUCTIONS.md
docs/architecture/project-architecture.md
```

### Шаг 4 — Обобщение встроенных repository locators

Проверьте:

```text
.ai/conversation-management/handoff/SKILL.md
.ai/conversation-management/handoff/BOOTSTRAP.md
.ai/tests/scenarios/cold-start-command-trace.md
```

на наличие URL старого репозитория и сделайте эти ссылки зависимыми от конфигурации либо нейтральными.

### Шаг 5 — Сброс состояния conversation

Удалите старые:

```text
.ai/handoffs/<old-specializations>/*
.ai/archives/handoffs/*
```

При необходимости оставьте только универсальный handoff README.

### Шаг 6 — Сброс исторических архитектурных свидетельств

Удалите историю архитектуры AIP Mirror и результаты runtime-тестов.

### Шаг 7 — Замена исследовательских материалов

Удалите материалы FreeHand/Illustrator и добавьте ссылки на материалы, относящиеся к новому приложению.

### Шаг 8 — Определение терминологии нового проекта

Обновите:

```text
specializations
terminology.commit_scopes
terminology.project_terms
references.repositories
```

в `.ai/config.yaml`.

### Шаг 9 — Проверка активного набора команд

Check `.ai/INDEX.md`.

Сохраните команды инфраструктуры, полезные новому проекту. Не создавайте новые команды только потому, что изменился технологический стек.

### Шаг 10 — Bootstrap первой реальной главы

Используйте canonical путь:

```text
.ai/AGENTS.md
    ↓
.ai/conversation-management/handoff/BOOTSTRAP.md
```

path.

Не придумывайте отдельную команду «инициализация нового проекта».

---

# 19. Итоговый checklist адаптации

Перед началом реальной разработки проверьте:

- [ ] `.ai/config.yaml` содержит идентичность нового репозитория.
- [ ] `references.repositories` содержит только релевантные внешние ссылки.
- [ ] `specializations` описывает направления работы нового проекта.
- [ ] `terminology.commit_scopes` использует терминологию нового проекта.
- [ ] `terminology.project_terms` использует терминологию нового проекта.
- [ ] `docs/PROJECT-INSTRUCTIONS.md` полностью заменён.
- [ ] `docs/architecture/project-architecture.md` полностью заменён.
- [ ] Ни один активный workflow не содержит URL старого репозитория.
- [ ] Ни один активный тестовый сценарий не содержит locator старого репозитория.
- [ ] Старые handoffs удалены.
- [ ] Старый архив и история удалены либо осознанно сохранены с объяснением причины.
- [ ] Старые ссылки на проект удалены.
- [ ] Старые результаты runtime-тестов удалены.
- [ ] `.ai/AGENTS.md` по-прежнему указывает на canonical bootstrap workflow.
- [ ] `.ai/INDEX.md` по-прежнему указывает на действующие canonical owners.
- [ ] Универсальные rules остались универсальными.
- [ ] Универсальные skills остались универсальными.
- [ ] Bootstrap по-прежнему получает идентичность репозитория из `.ai/config.yaml`.
- [ ] Первую chapter нового проекта можно инициализировать без догадок о данных AIP Mirror.

---

# 20. Краткая ментальная модель

При превращении `aip-mirror` в другой проект мыслите тремя слоями:

```text
┌─────────────────────────────────────────────┐
│ УНИВЕРСАЛЬНАЯ AI-ИНФРАСТРУКТУРА             │
│                                             │
│ AGENTS / INDEX / rules / skills / workflows │
│                                             │
│ В основном сохранить                        │
└─────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────┐
│ ИДЕНТИЧНОСТЬ ПРОЕКТА + КОНТРАКТ ПРОЕКТА     │
│                                             │
│ config.yaml                                 │
│ docs/PROJECT-INSTRUCTIONS.md                │
│ docs/architecture/                          │
│                                             │
│ Заменить                                    │
└─────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────┐
│ ИСТОРИЯ ПРОЕКТА + ИССЛЕДОВАНИЯ              │
│                                             │
│ handoffs / archive / references / results   │
│                                             │
│ Сбросить, удалить или осознанно заменить    │
└─────────────────────────────────────────────┘
```

Самое опасное состояние — гибридное: у нового проекта правильный `config.yaml`, но старые предположения AIP Mirror всё ещё скрыты в `docs/`, handoff transport, тестовых сценариях, архивах или references.
