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

**Исключённые negative controls** (каждый проверен; ни один не объясняет все
восемь имён): `.dsh/skills` в репозитории (отсутствует), `~/.dsh` (отсутствует),
`C:\Users\Paul\.agents` (отсутствует), `$DSH_HOME\skills` (содержит только
`explain-code` и `review-agent`), bundled `dsh-agent-preset/skills` (4 посторонних
имени), office runtime skill pack (3 посторонних имени) и checkout skills market
(3818 файлов `SKILL.md`; совпадает только имя `handoff`, но описание другое,
на китайском языке, а кандидат с рангом 200 всё равно выигрывает по имени).

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

## 4. Текущее состояние соответствующих путей

Состояние повторно проверено в начале текущего сеанса.

| Путь | Состояние |
|---|---|
| `...\harness\skills` | существует — `explain-code`, `review-agent` (personal, ранг 400) |
| `...\harness\AGENTS.md` | существует — личные always-on инструкции на русском языке |
| `C:\Users\Paul\.dsh` | **удалён пользователем** (the `customSkillDirs` цель, теперь неактуальна) |
| `C:\Users\Paul\.agents` | **отсутствует** — ранг 500 ничего не добавляет |
| `E:\Projects\repos\aip-mirror\.dsh` | **отсутствует** — ранг 100 ничего не добавляет |
| `E:\Projects\repos\aip-mirror\.agents\skills` | exists — junction to `.ai\skills`, 8 skills, gitignored (V8) |
| `E:\Projects\repos\aip-mirror\.gitignore` | существует — 782 байта, `/.agents/` игнорируется, рецепт создания junction документирован |
| `E:\Projects\repos\aip-mirror\.ai\scripts\adapters\New-SkillAdapters.ps1` | существует — создаёт adapter и проверяет его (Task B) |
| `...\profiles\web\cordis.patch.yml` | переопределение `skill-filesystem` удалено; добавлен комментарий |

Состояние репозитория на момент записи: ветка `main` на `5e5d380`; до изменений
в этом сеансе рабочее дерево было чистым, `.agents/` присутствовал, но игнорировался.

---

## 5. Открытые задачи

### Task A — подтвердить обнаружение skills в пределах `aip-mirror` — **ЗАКРЫТА**

**Результат: подтверждено (V8).** Наблюдалось обнаружение в пределах проекта через
junction `.agents/skills` с рангом 200: живой каталог сессии, у которой `cwd` равен
`E:\Projects\repos\aip-mirror`, содержит все восемь имён из `.ai/skills`; тела
`knowledge-capture`, `activation` и `normative-language` загружаются через путь
junction, а контрольный запуск вне репозитория их не видит. В новом clone они
появляются только после создания adapter.

На единственный открытый подвопрос — восстанавливаются ли skills в новом clone —
теперь дан ответ: **нет, без шага настройки они не появляются**; этот шаг
автоматизирован скриптом (Task B).

### Task B — запись в `.gitignore` и шаг настройки adapter — **ПРИМЕНЕНЫ**

**Причина:** согласно V4, иначе в Git попали бы 9 дублирующих файлов; кроме того,
в новом clone вообще нет `.agents/`, поэтому project skills не обнаруживались бы
без каких-либо сообщений.

**Применено:**

1. `/.agents/` исключён из Git в `E:\Projects\repos\aip-mirror\.gitignore`; там же
   записаны обоснование и команда настройки. Commit: `5e5d380`.
2. `.ai/scripts/adapters/New-SkillAdapters.ps1` создаёт adapter и — что особенно
   важно — **проверяет** его. Если шаг настройки сообщает об успехе, а host молча
   пропускает корень, это лишь переносит точку отказа.

**Проверенное поведение скрипта** (все случаи проверены на настоящем новом clone
этого репозитория и на текущей рабочей копии):

| Сценарий | Результат |
|---|---|
| новый clone без adapter, запуск из постороннего `cwd` | junction created to the clone's `.ai\skills`, 8 skills visible, `SKILL.md` readable, exit 0 |
| повторный запуск при корректной настройке | сообщает `already correct`, ничего не меняет, exit 0 |
| ссылка указывает в другое место, без `-Force` | отказывается, выводит текущую и ожидаемую цель, ничего не меняет, exit 1 |
| ссылка указывает в другое место, с `-Force` | заменяет ссылку, exit 0 |
| по пути adapter находится **настоящий каталог** | отказывается удалять его, exit 1, содержимое каталога сохраняется |

Скрипт никогда не удаляет объект, который не является ссылкой, и сначала
определяет репозиторий по собственному расположению, поэтому рабочий каталог
вызывающей стороны не может случайно направить его на другой репозиторий.

**Сознательно не сделано:** symlink не добавлялся в Git (в clone без нужной
привилегии его отказ незаметен — V10, а основной workflow ориентирован на Windows);
также не создавались generated pointer skills (резервный вариант Tier 2 из vNext,
пока не нужный, поскольку adapter работает, а его отказ заметен).

### Task C — расширить проверку на второй host, если он когда-либо появится

Сейчас DSH — единственный используемый agentic host. Архитектура из vNext proposal
оставляет host-specific механизмы в adapter layer. Не создавайте adapters для
гипотетических hosts.

---

## 6. Команды для следующего сеанса

Состояние репозитория и adapter:

```powershell
cd E:\Projects\repos\aip-mirror
git status --short --branch
(Get-Item .agents\skills -Force) | Select-Object LinkType,Target
Get-ChildItem .agents\skills -Directory | Select-Object -ExpandProperty Name
git add --dry-run --all -- .agents      # must report the path as ignored
```

Создать или восстановить adapter (идемпотентно; команду безопасно запускать повторно):

```powershell
cd E:\Projects\repos\aip-mirror
pwsh -File .ai/scripts/adapters/New-SkillAdapters.ps1
```

Итоговая конфигурация (помните V3: dump показывает объединённую конфигурацию,
а не фактически загруженные компоненты):

```powershell
$env:DSH_HOME = "$env:APPDATA\dsh-desktop\harness"
npx --yes @deepseek-ai/dsh@0.2.0-rc.2 --profile web --dump-config
```

Живой каталог сессии — фактическое свидетельство, более надёжное, чем dump:

```
<available_skills> ... </available_skills>
```

Он появляется в журнале сессии внутри user message с system reminder. Извлеките
его из `$DSH_HOME\sessions\--<cwd-with-dashes>--\<session-id>\session.v4.jsonl.zstd`.
Файл содержит несколько zstd frames; распакуйте каждый frame отдельно, находя
magic bytes `28 B5 2F FD`:

```powershell
$h = "$env:APPDATA\dsh-desktop\harness"
$f = "$h\sessions\--E-Projects-repos-aip-mirror--\<session-id>\session.v4.jsonl.zstd"
$out = Join-Path $env:TEMP 'session.jsonl'
node -e "const fs=require('fs'),z=require('zlib');const buf=fs.readFileSync(process.argv[1]);const offs=[];for(let i=0;i<=buf.length-4;i++){if(buf[i]===0x28&&buf[i+1]===0xB5&&buf[i+2]===0x2F&&buf[i+3]===0xFD)offs.push(i);}const p=[];for(let k=0;k<offs.length;k++){const e=k+1<offs.length?offs[k+1]:buf.length;try{p.push(z.zstdDecompressSync(buf.subarray(offs[k],e)));}catch(x){}}fs.writeFileSync(process.argv[2],Buffer.concat(p));" $f $out
# then read the line containing 'A skill is a reusable'
```

Personal skills находятся в `$DSH_HOME\skills`; каталог обновляется на лету,
перезапуск не требуется (V2).

**Повторный запуск только для получения имён, без воздействия на живую сессию.**
Профиль `headless` использует тот же provider `skill-filesystem` (host-level row,
без preset), но для него не настроен provider `llm-pi-ai`. Поэтому, чтобы назначить
ему модель, требуется patch overlay репозитория:

```powershell
$env:DSH_HOME = "$env:APPDATA\dsh-desktop\harness"
# patch file supplies llm-pi-ai (routerai) + agent-default-model; the ROUTERAI_API_KEY
# value is read from $DSH_HOME\.credentials.yaml by the credentials service
npx --yes @deepseek-ai/dsh@0.2.0-rc.2 headless --patch <patch.yml> "<task asking for the catalog + a skill load>"
```

Запустите команду с `cwd`, установленным в каталог репозитория, а затем повторите
её вне любого Git-репозитория как negative control. Контрольный запуск должен
показать строго меньший каталог. Учтите, что по умолчанию `headless` использует
`deepseek-official` и завершается с `MISSING_CREDENTIAL`, если overlay не применён.

---

## 7. Что остаётся неопределённым

1. **Действительно ли `.agents/skills` поддерживается разными hosts.** В прежнем
   исследовании утверждалось, что его читает Gemini CLI, но здесь это не проверялось.
   Пока это не подтверждено, считайте `.agents/skills` adapter для DSH, а не
   универсальным слоем переносимости.
2. **URL документации upstream DSH**, указанные в прежнем обзоре, не открывались.
   Все приведённые здесь сведения о DSH получены из установленного bundle,
   исходников пакетов в npx cache (`@deepseek-ai/dsh-skill-filesystem`) и экспериментов.
3. **Дублирование между personal root и project root.** `explain-code` существует
   в обоих корнях, а файлы побайтно идентичны (длина 771, одинаковый SHA-256),
   поэтому сейчас ранг 200 делает дублирование безвредным. Однако копии могут
   разойтись, а §10 vNext proposal запрещает дублировать skill между этими областями.
   `review-agent`, напротив, существует **только** в `$DSH_HOME\skills`; `git log --all`
   показывает, что его никогда не было в истории этого репозитория. Следует либо
   удалить personal-копию `explain-code`, либо оформить дублирование как намеренное
   и документированное исключение.
4. **Уведомление уже работающей сессии об изменении каталога skills.** V8
   подтверждает обнаружение при старте сессии; не проверялось, появляется ли новый
   adapter в **уже работающей** сессии без перезапуска (как это происходит с
   personal root, V2).

---

## 8. Исправления для более ранних документов

Внесите эти исправления при следующем обновлении серии `agentic-ai-*`.

| Прежнее утверждение | Исправленное состояние |
|---|---|
| `customSkillDirs` используется для добавления personal root | На host-level row он не работает (V3). Используйте `$DSH_HOME/skills`, который не требует конфигурации (V2). |
| `~/.dsh/skills` — подходящий personal root | Только для standalone CLI, не для Desktop. Пользователь удалил этот каталог. |
| `.ai/skills` можно повторно использовать «без дублирования» благодаря ranking | Это возможно только через ссылку или generated pointers; canonical path не является корнем discovery (V5), а junction, добавленная в Git, дублирует содержимое (V4). |
| Корни discovery и порядок приоритетов skills | Корни и ранги не изменились (V7), но **владеющая строка перемещена в agent presets**, а Minimal mode вообще не загружает skills (V1, V6). |
| Отсутствие `review-agent` в каталоге не было объяснено | Причиной было `disable-model-invocation: true`; каталог фильтруется по возможности вызова моделью (V2). |
| Обнаружение через `.agents/skills` «структурно подтверждено, поведенчески не доказано» (корневой `AGENTS.md`) | **Теперь поведение подтверждено** (V8). В этом сеансе фраза в корневом `AGENTS.md` была обновлена, чтобы отразить это и указать команду настройки. |
| `.gitignore` пуст, запись ещё не добавлена (Task B предыдущей редакции) | `/.agents/` добавлен и закоммичен как `5e5d380`; команда настройки указана в `.gitignore` и реализована в `.ai/scripts/adapters/New-SkillAdapters.ps1`. |
| `@deepseek-ai/dsh-skill-filesystem` можно изучить только экспериментально | Исходный код пакета доступен в npx cache и был прочитан напрямую в этом сеансе (V7, V9). Ранги, порядок корней, обход на один уровень и поиск корня проекта подъёмом по `.git` теперь являются фактами из исходников, а не выводами по косвенным признакам. |

### 8.1 Исправление в истории обсуждения, а не в документах

В сеансе, в котором были добавлены V8/V9, различие между двумя механизмами
adapter было описано пользователю так: *«symlink нельзя хранить в Git, потому что
Git дублирует содержимое; это происходит только с junction».* **Это резюме было
ошибочным; в самих документах такого утверждения не было.**

- V4 этого файла и §7.1 vNext proposal правильно связывают дублирование в Git
  с **junction** (`git add` проходит по ней и индексирует 9 обычных файлов), а
  отказ symlink описывают как «материализацию в текстовый файл» — это V6 proposal,
  повторно подтверждённый в V10 этого файла.
- Эти два механизма дают разные сбои, и ни один не является полным надмножеством другого:

  | | symlink в Git (mode `120000`) | junction |
  |---|---|---|
  | содержимое в Git | отсутствует — blob содержит 12-байтовую цель | отсутствует только потому, что путь исключён из Git |
  | поведение `git add` | сохраняет ссылку | проходит по ссылке и индексирует каждый обычный файл |
  | нужен шаг настройки для каждого clone | нет | да |
  | нужна привилегия для создания | **да** | нет |
  | поведение при невозможности создать | **тихий сбой** — текстовый файл | заметный сбой, о котором сообщает скрипт |

Из этого следует более узкое правило, чем «symlink — это плохо»: **не полагайтесь
на механизм, который отказывает незаметно**. Junction выбрана из-за заметного
поведения при отказе, а не потому, что symlink при хранении в Git дублирует содержимое.

---
