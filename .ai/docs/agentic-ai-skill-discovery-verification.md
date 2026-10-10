# Проверка обнаружения skills в Agentic AI — журнал результатов

**Статус:** рабочая запись. При расхождениях заменяет DSH-specific утверждения из серии
`agentic-ai-*`.
**Назначение:** сохранить достаточно подтверждённого состояния, чтобы новый сеанс мог
продолжить проверку без реконструкции контекста из истории переписки.
**Редакция:** второй проход. Обнаружение в контексте проекта подтверждено (V8),
задача A закрыта, задача B выполнена; список открытых вопросов теперь короткий и
содержит только действительно нерешённые пункты.

Сначала прочитайте этот файл, затем `.ai/docs/ai-infrastructure-vnext-proposal.md`,
где описана архитектура, для которой нужны эти результаты.

---

## 1. Как пользоваться этим файлом

Это запись о **состоянии и задачах**, а не архитектурное обоснование. В ней
сохранены:

- что проверено и какими свидетельствами это подтверждается;
- какие прежние выводы оказались неверными;
- точные следующие шаги и команды.

Это вспомогательный материал. Он не является владельцем каких-либо семантических правил.

---

## 2. Исходное состояние среды

| Факт | Значение |
|---|---|
| DSH Desktop | `0.11.0` |
| Harness / `@deepseek-ai/dsh` | `0.2.0-rc.2` (версия прочитана из `app.asar`) |
| `DSH_HOME` | `C:\Users\Paul\AppData\Roaming\dsh-desktop\harness` |
| Profile | `web` |
| Активный agent preset | `standard` |
| `dsh` в `PATH` | **нет** — используйте `npx --yes @deepseek-ai/dsh@0.2.0-rc.2`, предварительно задав `DSH_HOME` |
| ОС | Windows 10 |

`dsh` глобально не установлен. Каждую проверку CLI следует выполнять так:

```powershell
$env:DSH_HOME = "$env:APPDATA\dsh-desktop\harness"
npx --yes @deepseek-ai/dsh@0.2.0-rc.2 <args>
```

---

## 3. Подтверждённые результаты

Каждый вывод связан со своими свидетельствами. Не представляйте эти результаты как предположения.

> **Нумерация V локальна для этого файла.** Серия `agentic-ai-*` и
> `.ai/docs/ai-infrastructure-vnext-proposal.md` имеют независимую нумерацию `V`,
> и теперь номера пересекаются (этот файл `V10` — не тот же результат, что `V10`
> в proposal). При ссылке на результат указывайте файл. Перекрёстные ссылки ниже
> сформулированы явно именно по этой причине.

### V1 — Обнаружение skills выполняется в agent presets, а не на уровне host

Patch из bundle `dsh-web-app` **отключает** запись host-level:

```yaml
# from @deepseek-ai/dsh-web-app/cordis.patch.yml
# Only the per-agent rows move behind presets: the base host `skill-filesystem`
# row is disabled here (presets own local discovery)
- id: skill-filesystem
  disabled: true
```

Свидетельство: `--dump-config` показывает host-level запись с
`disabled: true`, а каждый preset (`standard`, `ptc`, `cordis`) содержит
собственную включённую запись `skill-filesystem` без конфигурации.

**Следствие:** для обнаружения skills используется значение `dshHome` по
умолчанию — `$DSH_HOME`, поскольку preset не передаёт `dshHome`.

### V2 — `$DSH_HOME/skills` читается без дополнительной конфигурации

Запись preset разрешается по цепочке
`resolveDshHome(undefined)` → `$DSH_HOME` → корень
`join($DSH_HOME, "skills")` = `...\harness\skills`
(rank 400, `user-dsh`).

**Эмпирически подтверждено в этом сеансе.** После того как в
`harness\skills` поместили skill с именем `explain-code`, содержащий в
front matter только `name` и `description`, DSH добавил его в живой каталог
доступных skills без перезапуска. Аналогично, `review-agent` появился после
изменения `disable-model-invocation` на `false`.

Это закрывает пробел, отмеченный в предыдущем сеансе: тогда `review-agent`
отсутствовал в каталоге, и подтвердить корень обнаружения не удалось.

### V3 — Переопределение `customSkillDirs` для host-row не работает

Переопределение было добавлено на уровне profile patch:

```yaml
# WRONG — merged onto a disabled row
- id: skill-filesystem
  config:
    customSkillDirs:
      - 'C:\\Users\\Paul\\.dsh\\skills'
```

`--dump-config` показал, что параметр слился с **отключённой** host-level записью:

```yaml
- id: skill-filesystem
  name: '@deepseek-ai/dsh-skill-filesystem'
  disabled: true                        # row is dropped
  config:
    customSkillDirs:                    # never read
      - C:\\Users\\Paul\\.dsh\\skills
```

**Следствие:** переопределение никогда не работало. Desktop не читал
`~/.dsh/skills` через этот параметр. Переопределение удалено из
`cordis.patch.yml`; вместо него добавлен комментарий с объяснением, почему
его нельзя возвращать.

> **Важно:** `--dump-config` показывает объединённую конфигурацию, а не то,
> что действительно загружено. Запись может присутствовать в dump вместе со
> своей конфигурацией, но при `disabled: true` она всё равно отбрасывается.
> Не делайте вывод, что patch работает, только по dump. Подтверждайте результат
> через живой каталог доступных skills.

### V4 — Junction `.agents/skills` работает, обнаруживается и исключён из Git

**Статус: поведение ПОДТВЕРЖДЕНО.** Структурная корректность проверялась ранее;
обнаружение через junction теперь также наблюдалось (V8). В
`E:\Projects\repos\aip-mirror`:

```
.agents\skills  →  Junction  →  E:\Projects\repos\aip-mirror\.ai\skills
```

Структурно подтверждено: `LinkType = Junction`; списки canonical-каталога и
adapter совпадают (8 каталогов skills); файлы `activation/SKILL.md` и
`normative-language/SKILL.md` имеют одинаковый SHA-256 при чтении через оба
пути. Копий содержимого нет.

Однако Git **не отслеживает junction как ссылку**. Команда
`git add --dry-run --all -f -- .agents` перечисляет **9 файлов** —
`.agents/skills/<name>/SKILL.md` для каждого skill, а также
`handoff/reference-preservation/SKILL.md` на втором уровне вложенности.
Без правила ignore первая команда `git add` добавила бы в репозиторий
дубликаты содержимого skills — именно то дублирование, которое запрещает
архитектура. Правило уже добавлено (`/.agents/`, commit `5e5d380`); после
этого `git status` остаётся чистым, а `git add --dry-run --all -- .agents`
показывает, что путь игнорируется.

### V5 — `.ai/skills` по-прежнему не является нативным корнем discovery в DSH

Ни один из шести корней обнаружения не содержит путь `.ai/skills`. Именно
junction из V4 делает содержимое доступным для DSH; canonical-путь сам по себе
не является корнем обнаружения.

### V6 — В разных presets skills загружаются по-разному

| Название в UI | ID preset | `skill-filesystem` | Skills загружаются |
|---|---|---|---|
| Standard mode | `standard` | да | **да** |
| PTC mode | `ptc` | да | **да** |
| Minimal mode | `minimal` | **нет** | **НЕТ** |
| Creator mode | `cordis` | да | да |

Отличие PTC от `standard` ровно в одной записи:
`@deepseek-ai/dsh-agent-tool-presentation` с `mode: ptc`. Это меняет **форму
вызова инструмента** (agent пишет TypeScript-программу для `run_code`), а не
обнаружение skills. В Minimal mode skills намеренно не загружаются.

**Оставайтесь в режиме `standard`.**

### V7 — Ранжирование по строкам agent presets не изменилось

Ранги по-прежнему задаются `dsh-skill-filesystem`; чем меньше значение, тем выше
приоритет. Данные прочитаны непосредственно из исходного кода установленного
пакета (`@deepseek-ai/dsh-skill-filesystem/lib/index.js`, `FileSystemSkillProvider.roots`):

```
100  <project>/.dsh/skills      источник project-dsh    ранг PROJECT_DSH_RANK
200  <project>/.agents/skills   источник project-agents ранг PROJECT_AGENTS_RANK
250  runtime provider           источник runtime        ранг RUNTIME_RANK (dsh-skill)
300  customSkillDirs            источник custom         ранг CUSTOM_RANK
400  $DSH_HOME/skills           источник user-dsh       ранг USER_DSH_RANK
500  $AGENTS_HOME/skills        источник user-agents    ранг USER_AGENTS_RANK
600  bundled                    источник bundled        ранг BUNDLED_SKILL_RANK
```

Строка 250 соответствует отдельному provider, зарегистрированному через
`ctx.skills`, а не файловому корню; она приведена для полноты порядка приоритетов.

В предыдущем списке не были зафиксированы ещё две детали:

- корень проекта определяется подъёмом от `cwd` до каталога, содержащего
  `.git` (`findProjectRoot`); если `.git` не найден, используется сам `cwd`,
  поэтому корень проекта разрешается и вне Git-репозитория;
- `$AGENTS_HOME` по умолчанию равен `~/.agents`; его можно переопределить
  переменной окружения `DSH_AGENTS_HOME`. На этой машине каталога
  `C:\Users\Paul\.agents` нет, поэтому ранг 500 ничего не добавляет.

### V8 — Обнаружение skills в пределах проекта через junction теперь ПОДТВЕРЖДЕНО

Это закрывает Task A. Свидетельства:

1. **Живой каталог целевой сессии.** Каталог доступных skills, внедрённый
   в работающую сессию DSH с рабочим каталогом `E:\Projects\repos\aip-mirror`
   (извлечён из `$DSH_HOME\sessions\--E-Projects-repos-aip-mirror--\session-4b41fea6-…\session.v4.jsonl.zstd`),
   содержит все восемь имён из `.ai/skills`: `activation`, `ai-infrastructure`,
   `commits`, `deep-understanding`, `explain-code`, `handoff`,
   `knowledge-capture`, `normative-language`.

2. **Загружается тело skill, а не только строка metadata.** Вызов инструмента
   `skill` для `knowledge-capture`, `activation` и `normative-language` вернул
   тела skills, базовый путь ресурсов которых проходит через junction:

   ```
   Base directory for this skill: E:\Projects\repos\aip-mirror\.agents\skills\knowledge-capture
   Base directory for this skill: E:\Projects\repos\aip-mirror\.agents\skills\activation
   Base directory for this skill: E:\Projects\repos\aip-mirror\.agents\skills\normative-language
   ```

   `knowledge-capture`, `activation` и `normative-language` **больше нигде** на
   этой машине не существуют (ни в `$DSH_HOME\skills`, ни среди bundled preset
   skills, ни в checkout skills market), поэтому ранг 400 не объясняет их
   появление. Неоднозначен только `explain-code` — это единственное имя,
   присутствующее в обоих корнях.

3. **Изолированный повторный запуск только для получения имён.** Headless-запуск
   DSH с `cwd`, равным репозиторию, показал те же восемь имён. Контрольный запуск
   вне любого Git-репозитория показал только `diagnose-windows-sandbox-acl`,
   `explain-code`, `review-agent`; `knowledge-capture` там отсутствовал (`NOT PRESENT`).
   Второй контроль из пустого каталога, содержащего только `.git`, дал тот же
   сокращённый каталог. Это подтверждает, что skills поступают из корня
   `.agents/skills`, а не просто из-за наличия `.git`.

4. **Результат воспроизводится в новом clone только после создания adapter.**
   В чистом `git clone` каталога `.agents/` **нет** (он исключён из Git, V4),
   поэтому доступны только personal и bundled skills. Создание junction в этом
   clone с помощью `New-SkillAdapters.ps1` снова сделало `knowledge-capture`
   доступным, причём базовый путь ресурсов разрешился внутри clone.

**Negative controls that were ruled out** (each examined, none can supply the
eight names): repository `.dsh/skills` (absent), `~/.dsh` (absent),
`C:\Users\Paul\.agents` (absent), `$DSH_HOME\skills` (only `explain-code` and
`review-agent`), the bundled `dsh-agent-preset/skills` (4 unrelated names), the
office runtime skill pack (3 unrelated names), and the skills-market checkout
(3818 `SKILL.md` files, only the name `handoff` collides — with a different,
Chinese description, and the rank-200 candidate wins on the name anyway).

**Следствие:** `.ai/skills` остаётся единственным canonical source, `.agents/skills`
— локальным adapter, исключённым из Git, а создание adapter теперь является
**документированным и автоматизированным шагом настройки**, а не недокументированной
ручной операцией (Task B).

### V9 — То же свидетельство подтверждает правило одного уровня вложенности

`.ai/skills/handoff/reference-preservation/SKILL.md` существует и отслеживается
Git, но `handoff-reference-preservation` не появляется **ни в живом каталоге, ни
в одном headless-запуске**. `discoverRoot` читает только непосредственные элементы
каждого корня, поэтому вложенный в другой skill skill не обнаруживается.
Утверждение из §7.3 vNext proposal теперь подтверждено напрямую; по этой же
причине в каталоге 8 skills, а не 9.

### V10 — Повторная проверка upstream-модели symlink в Windows

Повторная проверка выполнена на актуальном clone `adobe/spectrum-web-components`
(`E:\Projects\repos\spectrum-web-components`, `main` @ `be922808`). Именно эта
реализация служит образцом для vNext proposal, поэтому её режимы отказа имеют
непосредственное отношение к проекту.

**Что upstream действительно хранит в Git:**

- Ровно **три** отслеживаемых symlink, все с mode `120000`: `.claude/rules` →
  `../.ai/rules`, `.claude/skills` → `../.ai/skills`, `.cursor/skills` →
  `../.ai/skills`. Последние два используют один blob (`6838a116…`), поэтому
  одинаковая цель не создаёт дополнительных затрат.
- `.cursor/rules/*.mdc` и `.github/instructions/*.instructions.md` — это
  **сгенерированные файлы**, а не ссылки: Cursor нужен `globs:`, Claude — `paths:`,
  и один источник обслуживает оба формата. До commit `4c97b0dd34` они были
  symlink на каждый файл.

**Наблюдаемое поведение в Windows:**

- В clone, где конфигурация разрешила `core.symlinks=false`, три ссылки
  материализовались как **текстовые файлы размером 12/13 байт** со строкой цели
  — точное воспроизведение V6 из vNext proposal. `git status` всё время оставался
  чистым: Git не показывает это повреждение.
- После `git config --global core.symlinks true` и повторного clone все три пути
  стали настоящими reparse point типа `SymbolicLink`. Чтение через ссылки работает
  (35 skills, 8 rules), а `.claude/skills` разделяет **inode** с `.ai/skills` — это
  один объект, а не копия.
- **Developer Mode действительно выключен.** `AllowDevelopmentWithoutDevLicense`
  отсутствует в `HKLM\...\AppModelUnlock`. Тем не менее создание symlink работает,
  поскольку токен содержит `SeCreateSymbolicLinkPrivilege` (назначен
  `S-1-5-32-544`) и эта привилегия **включена** в текущей сессии. Для создания
  ссылки привилегия нужна; для чтения — нет.
- **Для восстановления сломанного checkout повторный clone не нужен.** Если
  локальное переопределение clone удалено, `git restore -- .claude .cursor`
  восстанавливает три настоящие symlink и оставляет `git status` чистым. Совет
  upstream («включить Developer Mode и выполнить clone заново») преувеличивает
  необходимый объём действий.

**Upstream validator не проходит в Windows.** `validate-symlinks.js` сравнивает
результат `readlinkSync()` оператором `!==` с буквальной строкой `'../.ai/skills'`.
В Windows `readlinkSync` возвращает `'..\\.ai\\skills'`, поэтому все три проверки
сообщают `points to "..\.ai\rules", expected "../.ai/rules"`. Ссылки работают;
проверка чувствительна к разделителям путей. CI этого не обнаруживает, потому что
`yarn lint:ai` выполняется на `ubuntu-latest` (`lint.yml`).

**Следствие для этого репозитория:** Option A (symlink, хранящийся в Git) на этой
машине *работоспособен* — утверждение «в Windows это невозможно» слишком категорично.
Но механизм зависит от наличия у пользователя, создающего ссылку, соответствующей
привилегии, а отказ остаётся **тихим** (vNext proposal `V6`/`V7`: вместо каталога
получается текстовый файл, а DSH пропускает корень без сообщения). Для workflow,
ориентированного на Windows, остаётся выбран вариант junction + adapter, исключённый
из Git, именно потому, что его отказ заметен. Если Option A когда-либо будет принят,
**не копируйте** это строгое сравнение разделителей в Windows-проверку.

---

## 4. Current state of relevant paths

State re-verified at the start of the current session.

| Path | State |
|---|---|
| `...\harness\skills` | exists — `explain-code`, `review-agent` (personal, rank 400) |
| `...\harness\AGENTS.md` | exists — personal always-on instructions, Russian |
| `C:\Users\Paul\.dsh` | **removed** by the user (the `customSkillDirs` target, now moot) |
| `C:\Users\Paul\.agents` | **absent** — rank 500 contributes nothing |
| `E:\Projects\repos\aip-mirror\.dsh` | **absent** — rank 100 contributes nothing |
| `E:\Projects\repos\aip-mirror\.agents\skills` | exists — junction to `.ai\skills`, 8 skills, gitignored (V8) |
| `E:\Projects\repos\aip-mirror\.gitignore` | exists — 782 bytes, `/.agents/` ignored, junction recipe documented |
| `E:\Projects\repos\aip-mirror\.ai\scripts\adapters\New-SkillAdapters.ps1` | exists — creates the adapter, verifies it (Task B) |
| `...\profiles\web\cordis.patch.yml` | `skill-filesystem` override removed; comment added |

Repository state at the time of writing: branch `main` at `5e5d380`, working tree
clean before this session's edits, `.agents/` present but ignored.

---

## 5. Open tasks

### Task A — prove project-scoped discovery in `aip-mirror` — **CLOSED**

**Result: confirmed (V8).** Project-scoped discovery through the rank-200
`.agents/skills` junction is observed: the live catalog of a session whose `cwd`
is `E:\Projects\repos\aip-mirror` lists all eight `.ai/skills` names, the bodies
of `knowledge-capture`, `activation`, and `normative-language` load from the
junction path, and an out-of-repository control cannot see them. A fresh clone
reproduces them only after the adapter is created.

The one open sub-question — whether a fresh clone recovers the skills — is now
answered **no, not without the setup step**, and the step is scripted (Task B).

### Task B — the `.gitignore` entry and the adapter setup step — **APPLIED**

**Why:** V4 — 9 duplicate files would otherwise be committed; and a fresh clone
has no `.agents/` at all, so project skills would silently not be discovered.

**Applied:**

1. `/.agents/` is ignored in `E:\Projects\repos\aip-mirror\.gitignore`, with the
   rationale and the setup command recorded in the file itself. Committed as
   `5e5d380`.
2. `.ai/scripts/adapters/New-SkillAdapters.ps1` creates the adapter and — this is
   the part that matters — **verifies** it. A setup step that reports success
   while the host silently skips the root would just move the failure.

**Verified behaviour of the script** (all cases exercised against a real fresh
clone of this repository, and against this working copy):

| Case | Result |
|---|---|
| fresh clone, no adapter, run from an unrelated cwd | junction created to the clone's `.ai\skills`, 8 skills visible, `SKILL.md` readable, exit 0 |
| re-run when already correct | reports `already correct`, no change, exit 0 |
| link points somewhere else, no `-Force` | refuses, prints current and expected target, target unchanged, exit 1 |
| link points somewhere else, `-Force` | replaces the link, exit 0 |
| a **real directory** sits at the adapter path | refuses to delete it, exits 1, directory contents survive |

The script never deletes a non-link, and it resolves the repository from its own
location first so that it cannot be aimed at the wrong repository by the caller's
working directory.

**Deliberately not done:** no committed symlink (its failure mode is silent on a
clone without the privilege — V10 — and this workflow is Windows-primary), and no
generated pointer skills (the vNext Tier 2 fallback — unnecessary while the
adapter works and the failure mode is loud rather than silent).

### Task C — extend the verification to any second host, if one is ever used

Currently DSH is the only agentic host in use. The design in the vNext proposal
keeps host-specific mechanics in an adapter layer. Do not build adapters for
hypothetical hosts.

---

## 6. Commands for the next session

Repository and adapter state:

```powershell
cd E:\Projects\repos\aip-mirror
git status --short --branch
(Get-Item .agents\skills -Force) | Select-Object LinkType,Target
Get-ChildItem .agents\skills -Directory | Select-Object -ExpandProperty Name
git add --dry-run --all -- .agents      # must report the path as ignored
```

Recreate or repair the adapter (idempotent; safe to re-run):

```powershell
cd E:\Projects\repos\aip-mirror
pwsh -File .ai/scripts/adapters/New-SkillAdapters.ps1
```

Effective composition (remember V3 — the dump shows merged, not loaded):

```powershell
$env:DSH_HOME = "$env:APPDATA\dsh-desktop\harness"
npx --yes @deepseek-ai/dsh@0.2.0-rc.2 --profile web --dump-config
```

Live catalog for a session (the ground truth, better than the dump):

```
<available_skills> ... </available_skills>
```

It appears in the session log, in the system-reminder user message. Extract it
from
`$DSH_HOME\sessions\--<cwd-with-dashes>--\<session-id>\session.v4.jsonl.zstd`,
which is written in multiple zstd frames — decompress frame by frame by
scanning for the `28 B5 2F FD` magic:

```powershell
$h = "$env:APPDATA\dsh-desktop\harness"
$f = "$h\sessions\--E-Projects-repos-aip-mirror--\<session-id>\session.v4.jsonl.zstd"
$out = Join-Path $env:TEMP 'session.jsonl'
node -e "const fs=require('fs'),z=require('zlib');const buf=fs.readFileSync(process.argv[1]);const offs=[];for(let i=0;i<=buf.length-4;i++){if(buf[i]===0x28&&buf[i+1]===0xB5&&buf[i+2]===0x2F&&buf[i+3]===0xFD)offs.push(i);}const p=[];for(let k=0;k<offs.length;k++){const e=k+1<offs.length?offs[k+1]:buf.length;try{p.push(z.zstdDecompressSync(buf.subarray(offs[k],e)));}catch(x){}}fs.writeFileSync(process.argv[2],Buffer.concat(p));" $f $out
# then read the line containing 'A skill is a reusable'
```

Personal skills live in `$DSH_HOME\skills`; the catalog updates live, no
restart needed (V2).

**Name-only replay without touching the live session.** The `headless` profile
reads the same `skill-filesystem` provider (host-plane row, no preset) but has no
`llm-pi-ai` provider configured, so a repository patch overlay is required to
give it a model:

```powershell
$env:DSH_HOME = "$env:APPDATA\dsh-desktop\harness"
# patch file supplies llm-pi-ai (routerai) + agent-default-model; the ROUTERAI_API_KEY
# value is read from $DSH_HOME\.credentials.yaml by the credentials service
npx --yes @deepseek-ai/dsh@0.2.0-rc.2 headless --patch <patch.yml> "<task asking for the catalog + a skill load>"
```

Run it with `cwd` set to the repository, then repeat in a directory outside any
git repository as the negative control. The control must show a strictly smaller
catalog. Note that `headless` uses `deepseek-official` by default and fails with
`MISSING_CREDENTIAL` unless the overlay is applied.

---

## 7. What remains uncertain

1. **Whether `.agents/skills` is genuinely cross-host.** Earlier research
   claimed Gemini CLI reads it; that was never verified here. Until it is,
   treat `.agents/skills` as a DSH adapter, not a portability layer.
2. **Upstream DSH documentation URLs** cited by the older survey were never
   opened. All DSH facts here come from the installed bundle, from the installed
   package sources under the npx cache (`@deepseek-ai/dsh-skill-filesystem`), and
   from experiments.
3. **Duplication between the personal root and the project root.** `explain-code`
   exists in both roots and the two files are byte-identical (same length 771,
   same SHA-256), so rank 200 currently makes it harmless — but the copies can
   drift, and §10 of the vNext proposal says never to duplicate a skill between
   the two scopes. `review-agent`, by contrast, exists **only** in
   `$DSH_HOME\skills`; `git log --all` shows it was never in this repository's
   history. Either the personal `explain-code` should be removed, or the
   duplication should be a deliberate, documented exception.
4. **Notification of skill-catalog changes to an already-running session.** V8
   establishes discovery at session start; whether a newly created adapter
   appears in a **live** session without a restart (the way the personal root
   does, V2) was not tested.

---

## 8. Corrections to earlier documents

Apply these when the `agentic-ai-*` series is next revised.

| Earlier claim | Corrected state |
|---|---|
| `customSkillDirs` is the way to add a personal root | It is dead on the host row (V3). Use `$DSH_HOME/skills`, which needs no config (V2). |
| `~/.dsh/skills` is a usable personal root | Only for a standalone CLI, not for Desktop. The user removed the folder. |
| `.ai/skills` may be reused "without duplicating" via ranking | True only through a link or generated pointers; the canonical path is not a root (V5), and a committed junction duplicates content in git (V4). |
| Skill discovery roots and precedence | Roots and ranks unchanged (V7), but the **owning row moved into agent presets**, and Minimal mode loads no skills at all (V1, V6). |
| `review-agent` absence from the catalog was unexplained | It was `disable-model-invocation: true`; the catalog filters on model-invocability (V2). |
| Discovery through `.agents/skills` is "structurally verified, behaviourally unproven" (root `AGENTS.md`) | **Now behaviourally confirmed** (V8). The root `AGENTS.md` sentence was updated in this session to say so and to name the setup command. |
| `.gitignore` is empty and the entry is still pending (Task B of the previous revision) | `/.agents/` was added and committed as `5e5d380`; the setup command is documented in the ignore file itself and scripted at `.ai/scripts/adapters/New-SkillAdapters.ps1`. |
| `@deepseek-ai/dsh-skill-filesystem` is only observable through experiments | The package source is readable in the npx cache and was read directly this session (V7, V9). Ranks, root order, the one-level scan, and the `.git`-walk project-root resolution are all source facts now, not inferences. |

### 8.1 A correction to the conversation, not to these documents

In the session that added V8/V9, the difference between the two adapter
mechanisms was summarised to the user as: *"a committed symlink is not an option
because git duplicates the content; only a junction does that."* **That summary
was wrong, and these documents did not say it.**

- This file's V4 and §7.1 of the vNext proposal correctly attribute git-side
  duplication to the **junction** (`git add` walks through it and indexes 9 real
  files), and correctly describe the symlink's own failure as "materializes as a
  text file" — the proposal's `V6`, re-confirmed in this file's V10.
- The two mechanisms fail differently and neither is a superset of the other:

  | | committed symlink (mode `120000`) | junction |
  |---|---|---|
  | content in git | none — the blob is the 12-byte target | none, but only because it is ignored |
  | `git add` behaviour | stores the link | walks through, indexes every real file |
  | needs a setup step per clone | no | yes |
  | needs a privilege to create | **yes** | no |
  | failure mode when unavailable | **silent** text file | loud, the script reports |

The rule that follows is narrower than "symlinks are bad": **do not rely on a
mechanism whose failure is silent.** The junction was chosen for its loud
failure, not because committing a symlink duplicates content.

---
