# AI infrastructure vNext — предложение по multi-host архитектуре

**Статус:** проектное предложение, не решение о реализации
**Примечание о текущем состоянии (2026-10-09):** это предложение создано до утверждённого переноса rules в skills. Упоминания `.ai/rules/`, handoff skills первого уровня и `.ai/workflows/handoff/BOOTSTRAP.md` ниже описывают состояние репозитория на момент подготовки предложения и не отражают текущую маршрутизацию. Для актуальных путей owners используйте `.ai/INDEX.md` и `.ai/README.md`.
**Заменяет:** исследовательскую серию `agentic-ai-*` (2026-10-07…08), которая теперь
служит свидетельствами, а не планом
**Область:** как `.ai/` обслуживает два несовместимых класса AI-потребителей из одного
canonical source

---

## 1. Назначение

В этом документе предлагается следующая версия инфраструктуры `.ai/` для AIP Mirror,
и, что важнее, **переносимый шаблон** для других проектов.

Ключевое требование не изменилось: один проект — два AI-потребителя.

```text
                    .ai/  (one canonical source)
                            |
            +---------------+---------------+
            |                               |
     Chat AI + Connector            Agentic AI (DSH)
     no working copy                real working copy
     API read / full-content PUT    shell, git, local tools
     cannot follow symlinks         scans fixed discovery roots
```

Предыдущая исследовательская серия установила, что эти два класса различаются
механизмами discovery, packaging, activation и execution. Она **не** предложила
конкретный дизайн adapter. Этот документ предлагает его.

Этот документ — вспомогательный контекстный материал. Он не заменяет
`.ai/rules/`, `.ai/skills/`, `.ai/workflows/` или `.ai/INDEX.md`.

---

## 2. Основания и свидетельства

Всё изложенное ниже основано на фактах, проверенных в рабочем сеансе. Две категории
строго разделены.

### 2.1 Подтверждено по исходному коду или экспериментом

| № | Результат | Способ проверки |
|---|---|---|
| V1 | DSH discovers skills in six ranked roots; lower rank wins | DSH `dsh-skill-filesystem` source |
| V2 | `.ai/skills` is **not** a DSH discovery root | zero `.ai/skills` occurrences in DSH bundle |
| V3 | Skill discovery scans **one level only**; nested `**/SKILL.md` is invisible | source: `join(entry.path, "SKILL.md")` |
| V4 | DSH auto-loads `AGENTS.md` / `CLAUDE.md` / `*.local.md` by walking from the `.git` root down to cwd **and** to touched directories | `dsh-agent-instructions` source |
| V5 | `.ai/AGENTS.md` is **not** found from the project root unless the agent touches files inside `.ai/` | same source: discovery is directory-chain based |
| V6 | Committed symlink on Windows with `core.symlinks=false` materializes as a **plain text file** holding the target string — 12 bytes for `../.ai/rules`, 13 for `../.ai/skills`; `readdir` then fails `ENOTDIR` | experiment: clone round-trip, re-confirmed on `adobe/spectrum-web-components` |
| V7 | DSH treats `ENOTDIR` as "root absent" and **silently** skips it — no error | source: `isAbsentSkillPathError` |
| V8 | Directory **junction** works as a skill root and needs no admin rights | experiment |
| V9 | Git does **not** track a junction as a link — it indexes the files behind it, duplicating content | experiment: two identical blobs |
| V10 | GitHub API and `raw.githubusercontent` return **404** through a symlink; the symlink blob itself is readable as text | experiment against a live repo |
| V11 | The Connector reads `.ai/skills/<name>/SKILL.md` **directly**, with no symlink needed | API fetch of `explain-code/SKILL.md` |
| V12 | DSH ignores unknown front matter keys | experiment with `license`, `allowed-tools`, `metadata`, `paths` |
| V13 | DSH has no audience/agent-only field, and no user-facing prompt-editing API | DSH source |
| V14 | Directory junction may be created without elevation; symbolic link creation succeeded in this shell but Developer Mode is off, so it is **not** guaranteed for the user | registry + experiment |
| V15 | Symlink creation needs `SeCreateSymbolicLinkPrivilege`, **not** Developer Mode specifically. With `core.symlinks=true` a Windows clone materializes real `SymbolicLink` entries whose targets resolve to the same inode as the canonical directory; the privilege was enabled via `S-1-5-32-544` while Developer Mode stayed off | re-clone of `adobe/spectrum-web-components` + `whoami /priv` + `AppModelUnlock` probe |
| V16 | A checkout broken by `core.symlinks=false` is repaired in place; a re-clone is not required. `git restore -- .claude .cursor` rewrites the paths as real symlinks and leaves `git status` clean | experiment on a deliberately broken clone |
| V17 | `readlinkSync` returns **backslash-separated** targets on Windows, so the upstream `validate-symlinks.js` strict `!==` against `'../.ai/rules'` reports 3 false failures on a healthy Windows clone. Its CI runs `yarn lint:ai` on `ubuntu-latest`, where separators match | faithful replay of the upstream check |

### 2.2 Непосредственно изученная reference implementation

Fork `paulhuman/spectrum-web-components` — практический образец, на котором
моделировалась эта инфраструктура. В нём непосредственно наблюдались следующие решения:

- canonical content in `.ai/`; tool directories are **thin adapters**;
- exactly **three** tracked symlinks, all mode `120000`: `.claude/rules` →
  `../.ai/rules`, `.claude/skills` → `../.ai/skills`, `.cursor/skills` →
  `../.ai/skills`. The two identical targets share one blob;
- `.github/instructions/*.instructions.md` and `.cursor/rules/*.mdc` are
  **generated** by `.ai/scripts/sync.js`, never hand-edited. The `.mdc` files
  were per-file symlinks until commit `4c97b0dd34`; they became generated files
  because Cursor reads `globs:` where Claude reads `paths:`, and one `.ai/`
  source must serve both;
- `AGENTS.md` at the repository root is a **thin router table**, not a
  knowledge dump;
- rules carry `paths:` front matter (path-scoped); skills are task-scoped;
- a validator enforces that **skills are exactly one level deep**, that `name`
  equals the directory, and that `description` fits the host limits;
- `yarn lint:ai` plus a pre-commit hook keep generated copies from drifting.

Повторное исследование этого репозитория в Windows выявило два предостережения
(V15–V17): для *создания* symlink требуется привилегия, а validator ссылок выдаёт
три ложных ошибки на исправном Windows clone, поскольку сравнивает цели с учётом
разделителей пути.

### 2.3 Здесь не проверялось

- URL upstream-документации DeepSeek Harness, указанные в прежнем обзоре.
- Читают ли Gemini CLI, Codex или Claude Code `.agents/skills`, как утверждалось
  в прежнем обзоре. Считайте это неподтверждённым.

---

## 3. Основная проблема

В инфраструктуре есть **один источник семантики и два несовместимых механизма доступа**.
Во всех предыдущих документах это рассматривалось как проблема переносимости.
На самом деле это проблема **discovery**, а discovery зависит от host.

```text
                     .ai/skills/<name>/SKILL.md
                              |
              +---------------+---------------+
              |                               |
      Connector can read it            DSH cannot find it
      (by explicit path)               (not in any scanned root)
```

Здесь сталкиваются два жёстких ограничения:

1. **DSH сканирует только фиксированные корни.** `.ai/skills` не входит в их число (V2).
2. **Очевидное решение — symlink в Git — ненадёжно именно в основной среде пользователя.**
   В Windows clone ссылка превращается в текстовый файл (V6), а DSH молча пропускает
   корень (V7). Ничто не сообщает об ошибке.

Третье ограничение исключает наивный обходной путь: junction решает проблему Windows,
но создаёт проблему для Git, поскольку Git добавляет связанное содержимое в index,
дублируя файлы (V9).

Следовательно, единого механизма, который одновременно не требует ссылок,
отслеживается Git, работает на разных ОС и доступен DSH, не существует — кроме
генерации настоящих файлов.

---

## 4. Принципы проектирования

1. **Один semantic owner.** `.ai/` остаётся canonical source. Никаких вторых реестров
   или копий rules и procedures для отдельных hosts.
2. **Adapters можно удалить и восстановить.** Любой host-specific артефакт должен
   восстанавливаться из `.ai/` и безопасно удаляться.
3. **Discovery зависит от host, семантика — нет.** Не допускайте, чтобы формат
   packaging конкретного host проникал в canonical artifact.
4. **Сбои должны быть заметны.** Текущее поведение с молчаливым пропуском (V7) —
   худшая особенность существующего решения. Всё, что может незаметно исчезнуть,
   должно проверяться.
5. **Применимость определяется возможностями, а не ярлыками.** Поля audience нет (V13),
   поэтому skill, требующий агента с инструментами, должен указывать соответствующий
   инструмент.
6. **Сначала вариант без adapter.** Предпочитайте механизм, работающий везде без
   настройки; добавляйте adapters только тогда, когда удобство оправдывает хрупкость.

---

## 5. Предлагаемая архитектура

Три слоя при строгом условии: **смыслом владеет только Layer 1.**

```text
LAYER 1 — canonical semantics (host-agnostic, the only owner)
    .ai/config.yaml        project identity + configured references
    .ai/rules/             constraints
    .ai/skills/            task-scoped capabilities
    .ai/workflows/         ordered procedures
    .ai/INDEX.md           operation routing + capability map

LAYER 2 — host adapters (thin, generated or linked, never authoritative)
    AGENTS.md              universal entry point (all AGENTS.md-aware hosts)
    .agents/skills/        DSH rank 200 + cross-host convention
    .github/instructions/  generated for Copilot
    .cursor/rules/         generated for Cursor

LAYER 3 — host runtime (outside the repository)
    $DSH_HOME/profiles/web/cordis.patch.yml   personal skill roots, plugin config
    $DSH_HOME/AGENTS.md                       personal always-on instructions
    ~/.dsh/skills                             personal global skills
```

### 5.1 Структура репозитория

```text
<project>/
├── AGENTS.md                     ← universal router (COMMITTED, hand-written)
├── .ai/
│   ├── config.yaml
│   ├── INDEX.md                  ← operation routing (unchanged role)
│   ├── AGENTS.md                 ← internal operating contract (see §6.3)
│   ├── README.md                 ← catalog + authoring guide
│   ├── rules/                    ← *.md, optional paths: front matter
│   ├── skills/                   ← <name>/SKILL.md, EXACTLY one level
│   ├── workflows/
│   ├── templates/
│   ├── handoffs/
│   ├── docs/
│   ├── tests/
│   ├── scripts/                  ← NEW: sync + validate (see §9)
│   └── archives/
├── .agents/
│   └── skills/                   ← adapter: link OR generated pointers (see §7)
├── .github/instructions/         ← adapter: generated (optional)
└── .cursor/rules/                ← adapter: generated (optional)
```

`.ai/scripts/` — единственный действительно новый каталог. Он превращает adapters
из хрупких ссылок, обслуживаемых вручную, в проверяемые и восстанавливаемые артефакты.

---

## 6. `AGENTS.md` как универсальная точка входа

Это самое ценное изменение: данный файл автоматически читает **каждый** host
в области охвата (V4), ему не нужен adapter, и он уже является открытым
межвендорным стандартом.

### 6.1 Перенести файл в корень репозитория

Сейчас operating contract находится в `.ai/AGENTS.md`. Из корня репозитория DSH
не видит его, если только агент не обращается к файлу внутри `.ai/` (V5).

```text
today:  .ai/AGENTS.md        found only by accident
target: AGENTS.md            found always, by every host
```

### 6.2 Сохранить файл компактным

Корневой `AGENTS.md` должен быть **router**, а не хранилищем знаний. Его задачи:

1. указать, что `.ai/` — canonical source;
2. дать таблицу расположения материалов и условий их загрузки;
3. перечислить постоянно действующие обязательства (контекст репозитория, безопасность записи);
4. направить к `.ai/INDEX.md` для операций и `.ai/README.md` для каталога.

Reference implementation делает именно это, и такой подход стоит взять за образец.
Длинные процедуры должны находиться в skills, а не здесь. Полезное правило:
выдавать предупреждение, если файл инструкций превышает примерно 12 KB.

### 6.3 Что делать с `.ai/AGENTS.md`

Сохранить его как **внутренний** operating contract для работы *внутри* `.ai/`
и сослаться на него из корневого файла. Это не дублирование: корневой файл
маршрутизирует, внутренний содержит подробности. Оба файла находятся на границе
Layer 1/2, и эту границу следует явно обозначить в обоих.

---

## 7. Skills: как сделать единый источник доступным для discovery

Это ключевой вопрос. Ниже четыре варианта, оценённые с учётом ограничений.

### 7.1 Варианты

**Вариант A — symlink на каталог, сохранённый в Git**
`.agents/skills` → `../.ai/skills`, tracked as mode `120000`.

- (+) Никакого дублирования; именно этот вариант использован в reference implementation.
- (+) На этой машине работоспособность подтверждена при `core.symlinks=true` и
  наличии у создающего ссылку пользователя `SeCreateSymbolicLinkPrivilege` (V15);
  Developer Mode не является определяющим фактором. Повреждённый checkout можно
  восстановить на месте командой `git restore` (V16), без повторного clone.
- (−) В Windows clone, где конфигурация приводит к `core.symlinks=false`, ссылка
  становится текстовым файлом (V6), а DSH **молча** пропускает её (V7). Это основная
  платформа пользователя, а создание зависит от привилегии, наличие которой нельзя
  вывести из состояния Developer Mode (V14, V15). Git и host не замечают отказ.
- (−) Наивный validator, проверяющий совпадение цели, чувствителен к разделителям
  в Windows (V17), поэтому проверка, призванная обнаружить сбой, сама может его пропустить.

**Вариант B — локальная junction, исключённая из Git и создаваемая скриптом**
`.agents/skills` — junction в Windows (или symlink в POSIX), исключённая из Git
и восстанавливаемая скриптом из `.ai/scripts/adapters`.

- (+) Работает в Windows без прав администратора (V8); содержимое не дублируется в Git (V9).
- (+) Нет незаметного отказа: скрипт либо выполняется успешно, либо сообщает об ошибке.
- (−) Не распространяется через Git; для каждого clone нужно выполнить одну команду настройки.

**Вариант C — генерируемые skills-указатели**
`.agents/skills/<name>/SKILL.md` — настоящий файл примерно из шести строк, хранящийся
в Git: он содержит `name` и `description` и указывает читателю загрузить
`.ai/skills/<name>/SKILL.md`.

- (+) Работает на разных ОС, отслеживается Git, читается Connector и обнаруживается DSH.
- (+) При проблемах деградирует корректно: указатель остаётся валидным Markdown.
- (−) При каждой activation требуется дополнительное чтение; дублированный `description`
  может разойтись с источником — это можно контролировать validator.

**Вариант D — без adapter, только `AGENTS.md`**
Корневой `AGENTS.md` содержит каталог skills с описаниями; агент при необходимости
читает соответствующий `.ai/skills/<name>/SKILL.md`.

- (+) Не требует настройки и новых файлов; подходит для всех hosts и ОС.
- (−) Skills are absent from the host's native skill listing, so automatic
  description-matching by the host registry does not happen. The agent must
  route through `AGENTS.md` first.

### 7.2 Рекомендация

**Использовать уровни: начать с D, добавить B, а C оставить переносимым резервным вариантом.**

```text
Tier 0  AGENTS.md catalog                    always on, zero setup   ← baseline
Tier 1  .agents/skills link (gitignored)     personal machine ergonomics
Tier 2  generated pointer files              when the repo must be self-sufficient
Tier 3  committed symlink                    POSIX-first teams only
```

Обоснование: Tier 0 ничего не стоит и это единственный уровень, который не может
отказать незаметно. Tier 1 оправдан для workflow на одной машине с приоритетом Windows
(в этой среде B однозначно лучше A). Tier 2 нужен, когда шаблон должен работать у
другого пользователя на неизвестной ОС без дополнительной настройки.

**Не** используйте symlink в Git как основной механизм в проекте, ориентированном
на Windows. Именно этой ловушки и призвано избежать данное предложение.

### 7.3 Правило одного уровня вложенности

DSH сканирует только один уровень (V3), а validator из reference implementation
считает вложенность **ошибкой**. Текущая структура нарушает это правило:

```text
.ai/skills/handoff/SKILL.md                        depth 1  OK
.ai/skills/handoff/reference-preservation/SKILL.md depth 2  INVISIBLE to DSH
```

Перенесите skill в `handoff-reference-preservation/SKILL.md` либо используйте
принятое в reference implementation соглашение о соседних каталогах с префиксами
(`migration-prep`, `migration-review` и т. д.). Это простое и недорогое исправление;
его следует закрепить в validator.

---

## 8. Rules и что на самом деле должно означать «две ветви»

Постановка пользователя была такой: одни skills предназначены для chat AI, другие
для агента, а некоторые — для обоих. **Не реализуйте это разделением по audience.**
Поля audience нет (V13), а такое разделение породило бы именно то дублирование,
которое запрещает архитектура.

Вместо этого используйте три независимых различия.

### 8.1 По триггеру загрузки, а не по читателю

Заимствовано из reference implementation; это соглашение стоит принять без изменений:

| О чём инструкция | Форма | Когда загружается |
|---|---|---|
| конкретные пути файлов | rule с `paths:` | детерминированно, когда соответствующий файл находится в контексте |
| задача или намерение | skill | по запросу, при совпадении описания |
| обязательства, действующие всегда | корневой `AGENTS.md` | всегда |

Неправильный выбор вреден в обоих направлениях: инструкции для задач в rule
расходуют контекст или вообще не срабатывают; инструкции для файлов в skill
теряют детерминированный триггер.

### 8.2 По требуемым возможностям

Это и есть настоящий ответ на вопрос «для меня или для chat AI». Применимость
должна определяться возможностями, необходимыми для выполнения инструкции:

```markdown
## Процедуры только для agent

Эти процедуры применяются при работе в роли agent с инструментами, который может
проверять и изменять файлы репозитория. Они не предназначены для chat-only assistant
и не являются действиями, которые пользователь выполняет вручную.
```

Этот шаблон уже используется в `.ai/skills/knowledge-capture/SKILL.md` и работает.
Для chat AI, читающего файл без shell, этот раздел неактивен, а для agent он необходим.
Не нужны metadata, фильтрация или вторая копия.

Более строгий вариант — прямо указывать инструменты: инструкция, в которой упоминается
`pptd_render` или локальный инструмент `write`, очевидно предназначена для agent,
поскольку chat AI на базе Connector не может его вызвать.

### 8.3 По host — только на уровне adapter

Различия между hosts, которые нельзя выразить через требуемые возможности, относятся к Layer 2:

- правило изменения репозитория сохраняет host-neutral инварианты, а *механика* каждого
  host остаётся за его пределами: preconditions по blob SHA для GitHub API в Connector,
  read-back-and-diff для agent;
- `>>command` остаётся **соглашением транспортного уровня чата**. Оно не должно
  превращаться в семантический примитив всего проекта, а INDEX должен оставаться
  нейтральным к способу вызова.

---

## 9. Как поддерживать корректность adapters

Самая сильная идея reference implementation — **генерировать и проверять adapters**,
чтобы расхождение приводило к ошибке проверки, а не к незаметной регрессии. Этот
набор инструментов — профессиональное ядро предложения.

```text
.ai/scripts/
├── ai-files.js              shared: front matter parser, inventory, glob engine
├── adapters.js              generate Layer 2 from Layer 1
├── validate-frontmatter.js  contract checks (see below)
├── validate-links.js        every referenced .ai/ path resolves
└── validate.js              entry point
```

Проверки, которые стоит реализовать; каждая обнаруживает один из описанных выше реальных сбоев:

| Проверка | Что обнаруживает |
|---|---|
| глубина skill == 1 | V3 — skill, невидимый для discovery |
| `name` == имя каталога, kebab-case, ≤64 | host отклоняет skill с несовпадающими данными |
| `description` задано, ≤1024, указано когда использовать | host отклоняет skill или игнорирует его |
| adapters соответствуют источникам в `.ai/` | расхождение источника и копии |
| пути adapters действительно разрешаются в каталоги | V6/V7 — незаметный пропуск |
| все ссылки `.ai/...` в документах существуют | сломанная маршрутизация после рефакторинга |
| предупреждение при размере файла инструкций >12 KB | размывание контекста |

Особенно важна новая проверка **adapter-resolves**: она превращает ситуацию
«skills незаметно исчезли на этой машине» в явную ошибку проверки.

---

## 10. Personal и project scope

Уже принято и подтверждено на практике:

```text
~/.dsh/skills                    personal, all projects  (DSH rank 300 via customSkillDirs)
$DSH_HOME/AGENTS.md              personal always-on instructions
<project>/.agents/skills         project-scoped         (DSH rank 200)
<project>/.dsh/skills            project-scoped, DSH-only (rank 100)
```

Рекомендуемое разделение:

- **Personal (`~/.dsh/skills`)** — привычки, общие для разных проектов: стиль commit,
  стиль объяснений, review checklists, фиксация знаний.
- **Project (`.ai/skills/`)** — всё, что ссылается на пути, rules или терминологию конкретного проекта.
- **Не дублируйте** skills между этими областями: personal skill, которому нужен
  контекст проекта, должен читать его во время выполнения.

Обратите внимание на асимметрию, которую должен описывать шаблон проекта:
`customSkillDirs` — **глобальная** настройка (Layer 3), она не может быть привязана
к пути проекта, поэтому проект не может самостоятельно назначить себе custom root.
Для project discovery нужно использовать один из двух project-relative roots или Tier 0.

---

## 11. Последовательность миграции

Ограниченная по объёму, обратимая последовательность, упорядоченная по ценности.

```text
Step 1  Move the operating contract to the repository root AGENTS.md
        → makes the project legible to every host at once           (no risk)

Step 2  Flatten .ai/skills/handoff/reference-preservation
        → removes a skill that can never be discovered              (no risk)

Step 3  Add .ai/scripts/ with the depth, name, description and
        adapter-resolves checks; wire into the pre-commit path
        → makes silent failure impossible                           (low risk)

Step 4  Add Tier 0: a skill catalog inside the root AGENTS.md
        → agent can route to skills without any adapter              (low risk)

Step 5  Add Tier 1 on the local machine: .agents/skills as a
        gitignored link, created by .ai/scripts/adapters
        → native discovery, no git noise                            (reversible)

Step 6  Archive the superseded research series and record the
        decision (§13)                                              (documentation)
```

Шаги 1–4 составляют основную часть и не зависят от host. Шаг 5 повышает удобство,
но не является архитектурным требованием.

### Выделение шаблона

После выполнения шагов 1–4 шаблон состоит ровно из дерева `.ai/` и корневого
`AGENTS.md`, при этом `.ai/config.yaml` — единственный файл с настройками конкретного
проекта. Переносимая единица:

```text
AGENTS.md  +  .ai/{config.yaml,rules,skills,workflows,templates,scripts}
```

Это соответствует существующему правилу: общая инфраструктура не зависит от проекта,
а проектные особенности сосредоточены в `config.yaml`.

---

## 12. Что архивировать

Шесть документов `agentic-ai-*` теперь являются свидетельствами в рамках устаревшей
концепции. Согласно действующему lifecycle архива, переместите их туда, оставив
в активном дереве три материала.

| Документ | Решение |
|---|---|
| `agentic-ai-compatibility-architecture.md` | **Archive.** Its Phase 1–4 apparatus is closed; the chapter pinning (C0068) is stale by several chapters. Keep only the host-contract layering. |
| `agentic-ai-compatibility-boundaries.md` | **Keep the evidence model** (§ its transport-neutral record), archive the rest. Its "without duplicating" conclusion is unexecutable as written without a discovery mechanism. |
| `agentic-ai-compatibility-capability-audit.md` | **Archive.** Branch-hygiene section is factually wrong (39 branches vs 1), and its inventories predate two skills and one rule. |
| `agentic-ai-dsh-observations.md` | **Keep and upgrade.** The most accurate document in the set. Promote "was reported" to "verified (source)", add the `metadata` field, the hard rejection of legacy camelCase keys, the one-level rule, and the `.system` / `includeDefaultRoots` details. |
| `agentic-ai-environment-survey.md` | **Archive**, retaining the capability-seam matrix and the Finding set. Source URLs for upstream DSH were never verified here. |
| `agentic-ai-owner-seam-audit.md` | **Archive** after folding its gap list into this note. Its owner inventory is missing `ai-infrastructure`, `knowledge-capture`, and `developer-knowledge.md`. |

В активной документации должны остаться три артефакта:

1. это предложение;
2. обновлённая запись наблюдений о DSH (только подтверждённые факты);
3. транспортно-нейтральная модель свидетельств, перенесённая сюда или в отдельный
   короткий файл.

Консолидация — часть ценности этой работы: сейчас один и тот же контракт изменения
репозитория повторяется в четырёх из шести документов.

---

## 13. Сводка решений

| Вопрос | Рекомендация |
|---|---|
| Где должен находиться `AGENTS.md`? | В корне репозитория как компактный router; `.ai/AGENTS.md` сохраняется как внутренний контракт |
| Сохраняется ли `INDEX.md`? | Да, его роль не меняется. Корневой `AGENTS.md` ссылается на него; `>>` остаётся соглашением чата |
| Разделять skills по audience? | Нет. Разделы одного skill ограничиваются требуемыми возможностями |
| Как обеспечить нативный discovery `.ai/skills` в DSH? | Через adapter `.agents/skills`; базовый вариант — Tier 0 (каталог в `AGENTS.md`) |
| Symlink в Git? | Не как основной вариант для Windows — отказ незаметен. Используйте ссылку, исключённую из Git, или generated pointers |
| Нужен ли новый слой `.ai/interfaces/`? | Нет. Свидетельства этого не обосновывают, и для данного дизайна он не нужен |
| Что действительно новое? | `.ai/scripts/` (генерация и проверка) и корневой `AGENTS.md` |
| Самое ценное одиночное изменение? | Корневой `AGENTS.md`: один файл, который сразу делает проект понятным каждому host |

---

## 14. Открытые вопросы

1. Какой host, кроме DSH, если такой вообще есть, действительно будет использоваться
   здесь в роли agent? Набор adapters должен определяться реальным использованием,
   а не предположениями.
2. Должен ли шаблон включать настройку Tier 1 или остаться на Tier 0, предоставив
   каждому clone возможность подключить его по желанию?
3. Действительно ли `.agents/skills` поддерживается разными hosts (как утверждалось
   в прежнем обзоре для Gemini) или фактически предназначен только для DSH? От этого
   зависит, является ли он compatibility layer или DSH adapter.
4. Нужен ли `.ai/rules/` front matter `paths:`? Он обеспечивает детерминированную
   загрузку в hosts, учитывающих пути, но в DSH нет понятия rules, поэтому польза
   зависит от host.
5. Следует ли закрепить разделение personal/global с помощью validator или оставить
   его соглашением?

---

## 15. Связь с текущим semantic ownership

Это архитектурная записка, а не execution owner.

Rules, skills и workflows, которые сейчас владеют поведением, остаются авторитетными.
Если предложение подразумевает новое поведение, его определение должно быть размещено
в соответствующем canonical owner на этапе реализации. Например, проверка глубины
вложенности skills и adapters относится к repository rules, а контракт корневого
`AGENTS.md` — к тому owner, которому инфраструктура поручит discovery инструкций.

Эта записка не даёт разрешения на изменения в `main`.
