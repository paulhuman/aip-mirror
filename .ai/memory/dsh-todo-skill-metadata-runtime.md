# ЗАКРЫТО: runtime-семантика skill metadata в DSH

**Статус:** CLOSED — проверка выполнена, evidence приложены  
**Тип:** результат технической проверки DSH  
**Владелец технической проверки:** DSH  
**Потребитель результата:** AIP Mirror — AI-infrastructure integration

## Окружение проверки

| Параметр | Значение |
|---|---|
| DSH Desktop | 0.11.0 |
| Harness (`@deepseek-ai/dsh`) | 0.2.0-rc.2 |
| Источник кода | распакованные пакеты `@deepseek-ai/*` из npx-кэша |
| ОС | Windows 10 |
| Проект проверки | `aip-mirror`, адаптер `.agents/skills` (junction) |

Все выводы ниже получены двумя независимыми способами: чтением реализации
пакетов и воспроизводимыми runtime-пробами в живой сессии DSH. Пробы создавались
как реальные skills в `.ai/skills/`, наблюдались в живом каталоге и в логе, затем
удалялись. Итоговое состояние: `.ai/skills/` содержит ровно 9 канонических skills,
`git status` чист.

## 1. `whenToUse` — парсится и хранится, но до модели не доходит

### Что делает реализация

Поле читается из front matter:

```
dsh-skill-filesystem/lib/index.js:699
    ...optionalString(parsed.data, "whenToUse"),
```

Переносится через типы и валидируется как строка:

```
dsh-skill/lib/index.js:458   throw new TypeError(... "non-string whenToUse")
dsh-skill/lib/index.js:485   throw new TypeError(... "whenToUse must be a string")
dsh-skill/lib/types/index.d.ts:52    readonly whenToUse?: string;   (SkillEntry)
```

Но **нигде не выводится модели**. Проверены оба model-facing пути:

```
dsh-skill/lib/index.js  renderSkillContent(skill)
    → выводит: name, resourceBase, content
    → whenToUse отсутствует

dsh-tool-skill/lib/index.js:42  catalogSourceEntries(skills, maxLen)
    → skills.map(skill => ({ name, description }))
    → whenToUse отсутствует
```

Широкий поиск по всем пакетам `@deepseek-ai/*` не нашёл ни одного потребителя,
который бы отображал `whenToUse` в каталог, подсказку или UI.

### Runtime-проба

Создан skill с маркером в поле:

```yaml
name: zz-probe-whentouse
description: Probe A. Use when testing whenToUse visibility.
whenToUse: PROBE_MARKER_WHENTOUSE_9F3A
```

Наблюдение:

- в живом каталоге появилась **только** строка `description`, маркер
  `PROBE_MARKER_WHENTOUSE_9F3A` не появился;
- результат вызова `skill` для этого skill содержал `name`, base directory и
  тело, но не содержал `whenToUse`;
- ошибок и предупреждений в логе нет — поле принято молча.

### Вывод

`whenToUse` принимается, валидируется по типу и сохраняется в метаданных skill,
но **не влияет на discovery, ранжирование, выбор skill или автоматический
invocation**. Со стороны модели поле инертно.

> **Важно, чтобы не спутать.** Поле `whenToUse` существует и **активно
> используется** в другом, не связанном механизме — workflow:
> `dsh-workflow`, `dsh-tool-workflow` (строка 293 — поле схемы, строка 295 —
> описание: `Optional guidance on when this workflow applies.`),
> `dsh-workflow-ptc`. Там это поле схемы `WorkflowMeta`, а не front matter
> skill. Утверждение «`whenToUse` не влияет ни на что» было бы неверным;
> верное — «не влияет в контексте skill front matter».

## 2. `disable-model-invocation` — рабочий механизм скрытия от модели

### Что делает реализация

```
dsh-skill-filesystem/lib/index.js:853-856
    const disableModelInvocation = frontmatterBoolean(data, "disable-model-invocation");
    modelInvocable: disableModelInvocation !== true
```

Значение по умолчанию — **model-invocable** (skill виден модели), скрытие
включается только явным `true`.

Фильтрация выполняется в двух местах:

```
dsh-tool-skill/lib/index.js:217   const skills = snapshot.skills.filter(isModelInvocable);
        → skill не попадает в каталог вообще

dsh-tool-skill/lib/index.js:147,150
        → throw new Error(`skill "${args.name}" is not available for model invocation`)
        → skill нельзя загрузить и через tool, даже зная имя
```

### Runtime-проба

```yaml
name: zz-probe-modeloff
description: Probe B. Use when testing disable-model-invocation.
disable-model-invocation: true
```

Наблюдение:

- skill **отсутствовал** в живом каталоге;
- прямой вызов `skill` вернул ошибку дословно:
  `skill "zz-probe-modeloff" is not available for model invocation`.

### Вывод

Это подтверждённый механизм скрытия skill от модели. Он закрывает **оба** пути
(model-facing каталог и tool-загрузку), поэтому его достаточно, чтобы полностью
убрать skill из поля зрения модели без выноса каталога из сканируемых корней.

## 3. `user-invocable` — другой путь, модель не скрывает

### Что делает реализация

```
dsh-skill-filesystem/lib/index.js:854,857
    const userInvocable = frontmatterBoolean(data, "user-invocable");
    userInvocable: userInvocable !== false
```

По умолчанию — **user-invocable** (`true`); отключение требует явного `false`.

Единственное найденное применение:

```
dsh-tool-skill/lib/index.js:183
    if (skill === void 0 || !isUserInvocable(skill)) continue;
```

Это ветка **инъекции по явному упоминанию**: когда пользователь называет skill в
сообщении, DSH подставляет его содержимое в контекст. При `user-invocable: false`
подстановка пропускается.

### Runtime-проба

```yaml
name: zz-probe-useroff
description: Probe C. Use when testing user-invocable.
user-invocable: false
```

Наблюдение:

- skill **присутствовал** в живом каталоге;
- вызов `skill` успешно загрузил его тело.

### Вывод

`user-invocable` **не** скрывает skill от модели. Это подтверждает, что
model invocation и user invocation — **разные пути** с независимыми фильтрами:
каталог и tool фильтруются по `isModelInvocable`, инъекция по упоминанию — по
`isUserInvocable`.

## 4. Смежные факты, обнаруженные при проверке

### 4.1 Legacy camelCase-ключи приводят к полному игнорированию skill

Реализация явно отвергает старые имена:

```
dsh-skill-filesystem/lib/index.js:850-852
    rejectLegacyInvocationKey(data, "disableModelInvocation", "disable-model-invocation");
    rejectLegacyInvocationKey(data, "modelInvocable",          "disable-model-invocation");
    rejectLegacyInvocationKey(data, "userInvocable",           "user-invocable");
```

Это не мягкое предупреждение: skill **исключается целиком**. Запись в
`harness.log`:

```
warn skill-filesystem: skill file ...\zz-legacy-key\SKILL.md ignored:
invalid invocation frontmatter: Error: frontmatter field "disableModelInvocation"
is unsupported; use "disable-model-invocation"
```

Runtime подтвердил: skill с `disableModelInvocation: true` отсутствовал в каталоге.

### 4.2 Boolean-значения принимаются в нескольких формах

```
dsh-skill-filesystem/lib/index.js  frontmatterBoolean(data, key)
    boolean            → как есть
    1 / "1" / 0 / "0"  → true / false
    строка (без регистра) → true/yes/on | false/no/off
```

Проверено runtime на строковых значениях:

| Значение | Ожидание | Наблюдение |
|---|---|---|
| `disable-model-invocation: "no"` | `false` → виден | skill **в каталоге** |
| `disable-model-invocation: "yes"` | `true` → скрыт | skill **не в каталоге** |

Это подтверждает разбор строк. Любое иное значение даёт `TypeError` и
игнорирование skill.

## 5. Версионная область действия

| Утверждение | Область |
|---|---|
| Поведение всех трёх полей | DSH Harness `0.2.0-rc.2` · DSH Desktop `0.11.0` |
| Значения по умолчанию (`modelInvocable: true`, `userInvocable: true`) | та же версия |
| Отказ на camelCase-ключи | та же версия |
| Разбор строковых boolean | та же версия |

Это версионно-чувствительные наблюдения, а не гарантия для будущих версий DSH.
Проверяются повторно чтением `dsh-skill-filesystem` и `dsh-skill` в установленной
версии.

## 6. Что осталось неопределённым

1. **Влияние `whenToUse` вне model-facing путей.** Потребитель не найден ни в
   одном установленном пакете, но нельзя исключить будущее или внешнее
   использование (например, сторонним клиентом). Утверждение ограничено:
   «в проверенной версии не влияет на discovery, ранжирование, выбор и
   invocation».
2. **Кросс-хост переносимость имён полей.** `disable-model-invocation` и
   `user-invocable` проверены только для DSH. Используют ли другие хосты те же
   имена и ту же семантику — не проверялось.
3. **Каталог и гонка обновления.** Наблюдалось, что живой каталог обновляется
   без перезапуска, но точная задержка между появлением файла и обновлением
   каталога не измерялась.

## 7. Что это означает для интеграции в AIP Mirror

Ниже — следствия, значимые для собственной архитектуры AIP Mirror. Формулировки
интеграционных правил остаются за AIP Mirror.

1. **Скрытие conversation-management skills возможно метаданными, а не только
   расположением.** `disable-model-invocation: true` убирает skill из каталога и
   блокирует tool-загрузку. Это рабочая альтернатива выносу в отдельный каталог.
   Ограничение: метаданные скрывают от **DSH**; навык остаётся физически в
   сканируемом корне и виден любому хосту, который этот фильтр не соблюдает.
2. **`user-invocable: false` — не средство скрытия от модели.** Если цель —
   убрать skill из поля зрения модели, это поле не подходит.
3. **`whenToUse` не следует использовать как механизм управления выбором
   skill.** В проверенной версии он не влияет на выбор; guidance о том, когда
   применять skill, принадлежит `description`.
4. **Имена полей нужно писать строго в kebab-case.** Опечатка в camelCase
   приводит не к предупреждению, а к полному исчезновению skill, причём
   единственный след — запись в `harness.log`.

## Граница ответственности

- **DSH:** точность приведённых выше утверждений о реализации и runtime-поведении
  для указанной версии, вместе с приложенным evidence.
- **AIP Mirror:** интерпретация этих сведений для своих semantic owners,
  activation/workflow правил и документации интеграции. Изменения выполняются
  отдельно и только в объёме, подтверждённом evidence.

## Контекст AIP Mirror

Связанная документация:

- `.ai/docs/agentic-ai-dsh-observations.md`
- `.ai/docs/agentic-ai-skill-discovery-verification.md`

Внешняя техническая проверка завершена. Эта запись больше не отслеживает открытый
вопрос и может быть перенесена в `.ai/archives/memory/` при следующей уборке
каталога.
