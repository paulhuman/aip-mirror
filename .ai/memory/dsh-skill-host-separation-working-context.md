# Рабочий контекст: разделение skills по host-механизму

**Дата фиксации:** 2026-10-11  
**Исходная глава:** C0090 — Architecture & Research  
**Назначение:** сохранить накопленные выводы и ссылки для продолжения в C0091. Это временная рабочая запись, а не новый semantic owner и не разрешение на интеграцию.

## Краткий итог

Исследуем, как организовать AI-infrastructure AIP Mirror для двух разных сред исполнения: Conversational AI, работающего с репозиторием через GitHub Connector / remote API, и Agentic AI в DSH, работающего с локальной Git working copy.

Принятое направление:

1. **Инструкции для remote API и local Git необходимо размещать в разных файлах.** Явная пометка адресата внутри одного файла недостаточна: если хост загружает весь skill, нерелевантная процедура всё равно попадает в его контекст.
2. Это относится не только к `.ai/skills/repository/SKILL.md`, но и к `.ai/skills/workflow/SKILL.md`: несмотря на общую методологию разработки, хост читает файл целиком, поэтому host-specific workflow также нужно разнести по отдельным файлам.
3. Дублирование общих сведений между файлами допустимо, если оно снижает риск смешения инструкций и загрязнения контекста другого вида AI.
4. Следующие изменения пока **не интегрировать**. В C0091 сначала прочитать два дополнительных DSH-аудита, сопоставить все четыре отчёта и уже затем выбрать лучшие предложения из материалов. Не копировать review branch целиком и не применять его автоматически.
5. В текущей рабочей сессии содержимое двух файлов ниже намеренно не анализировалось, по прямому указанию пользователя; их нужно прочитать в новом чате:
   - `.ai/memory/dsh-audit-repository-skill.md`
   - `.ai/memory/dsh-audit-workflow-skill.md`

## Контекст и мотивация

Один репозиторий AIP Mirror используется из разных host-сред, но инструменты и механизмы доступа у них существенно различаются.

- **Remote / Conversational AI:** репозиторий рассматривается как удалённый объект. Изменения могут идти через GitHub Contents API; важны current blob SHA как precondition, полная замена содержимого файла, чтение актуальной версии и проверка результата.
- **Local / Agentic AI (DSH):** репозиторий существует как локальная working copy. Существенны working tree, index, refs, незакоммиченные изменения, ignored/untracked файлы и риск уничтожения пользовательской работы.
- **Host-neutral contract:** общие инварианты безопасности, семантические границы и принципы проверки результата могут быть общими.

Главная проблема — не только техническая корректность инструкций. Если один skill содержит инструкции для обоих хостов, DSH всё равно читает remote API-механику, а Conversational AI — локальные Git-процедуры. Метки «только для такого-то host» не устраняют лишний текст из контекста. Поэтому граница должна быть выражена структурой файлов, а не только подзаголовками.

## Решения пользователя, подтверждённые в C0090

- Remote и local operational guidance обязательно разнести по отдельным файлам.
- Для workflow также нужны отдельные host-specific файлы; общий текст внутри одного skill не считается достаточным решением, поскольку файл целиком загружается в контекст.
- Дублирование допустимо; предотвращение путаницы между типами AI важнее устранения повторов.
- Пока пользователь не планирует другие Agentic AI помимо DSH. Выводы о metadata нужно оценивать применительно к DSH, не тратить текущую работу на абстрактную кросс-хостовую совместимость.
- `disable-model-invocation: true` может использоваться для сокрытия DSH skill от модели, если это подтверждается runtime-исследованием и подходит назначению конкретного skill. Это средство управления видимостью, но не замена архитектурному разделению host-specific инструкций.
- До изучения двух дополнительных аудитов и оценки всех материалов не менять canonical owners и не интегрировать review branch.

## Уже прочитанные временные аудиты DSH

### `dsh-report-repository-skill.md`

Ссылка: https://github.com/paulhuman/aip-mirror/blob/main/.ai/memory/dsh-report-repository-skill.md

Аудит относится к редакции `repository/SKILL.md` на `a0fbc8d` и оценивает её с точки зрения DSH с локальным Git.

Полезные инварианты, которые следует сохранить при разделении:

- последовательность read → change → read back → verify → diff → scope → commit;
- успешный вызов инструмента или валидный commit сами по себе не доказывают корректность содержимого;
- active semantic owners не должны зависеть от supporting/contextual layers;
- репозиторий — durable project record, чат — временный рабочий контекст;
- внешние reference repositories объявляются конфигурацией, а не копируются целиком.

Замеченные проблемы host-смешения и local-Git безопасности:

- путь к файлу на диске ошибочно описывался через hosting URL; необходимо отдельно описывать локальный поиск файла и построение URL для документации;
- GitHub Contents API механика (`update_ref`, blob SHA, полная замена файла) не должна попадать в local-Git operational context;
- disposable fixtures не должны затрагивать основную working copy и незакоммиченную работу; изоляция через отдельный `git worktree` или clone безопаснее;
- tracked tree, working tree, untracked и ignored содержимое — разные множества; одного `git ls-files` недостаточно для проверки полного локального scope;
- сам skill содержал устаревшее самоописание как `rule`, неканоничное `Never commit:` и формулировку `prototypes/` так, будто каталог обязателен или уже существует.

В отчёте указано, что его рекомендации отражены в `repository/SKILL.md` на review branch. Это не означает, что эти правки уже попали в `main`.

### `dsh-report-workflow-skill.md`

Ссылка: https://github.com/paulhuman/aip-mirror/blob/main/.ai/memory/dsh-report-workflow-skill.md

Аудит относится к редакции `workflow/SKILL.md` на `a0fbc8d`.

Общие методологические положения признаны полезными:

- исследовать перед реализацией;
- различать факты, выводы, предположения, спецификацию, детали реализации и открытые вопросы;
- менять небольшими, проверяемыми шагами;
- тестировать на минимальном подходящем уровне;
- фиксировать решения в durable документации;
- не превращать AI workflow в лишнюю административную нагрузку.

Host-specific проблемы:

- раздел repository-wide inspection описывал только remote API-процедуру;
- использовался несуществующий путь `.ai/docs/architecture/*` вместо плоского `.ai/docs/*`;
- список для пакетного чтения пропускал часть структуры, в частности memory и другие инфраструктурные области;
- для local Git полезнее `git rev-parse`, `git ls-tree -r` и `git status --porcelain --ignored`;
- нужно явно различать tracked commit tree и фактическое состояние working copy;
- нужны safeguards против разрушения незакоммиченной работы.

В отчёте указано, что предложения отражены в `workflow/SKILL.md` на review branch. Эти правки не интегрированы в `main`.

## Runtime-исследование DSH metadata

### Закрытая рабочая запись

`.ai/memory/dsh-todo-skill-metadata-runtime.md`  
https://github.com/paulhuman/aip-mirror/blob/main/.ai/memory/dsh-todo-skill-metadata-runtime.md

Текущий документ имеет заголовок «ЗАКРЫТО: runtime-семантика skill metadata в DSH» и больше не описывает открытый TODO. Результаты привязаны к DSH Desktop `0.11.0` и Harness `0.2.0-rc.2`, включая изученные пакеты `dsh-skill-filesystem`, `dsh-skill`, `dsh-tool-skill`, `dsh-tool-workflow` и runtime-пробы.

Подтверждённое в этой версии поведение:

- `whenToUse` в skill front matter читается/сохраняется, но не отображается в model-facing каталоге или теле загруженного skill и не влияет на discovery/выбор в исследованных model-facing путях. Не переносить это утверждение на workflow metadata с таким же именем: это отдельный механизм.
- `disable-model-invocation: true` скрывает skill из каталога модели и блокирует загрузку через skill tool.
- `user-invocable: false` не скрывает skill из каталога и не блокирует tool-загрузку; оно отключает инъекцию при явном упоминании пользователем.
- `description` — единственный текст о skill, доступный модели в каталоге; guidance о том, когда применять skill, следует выражать там.
- Некорректные invocation keys в camelCase приводят к игнорированию skill; причина может быть видна только в `harness.log`.
- Семантика зависит от версии. Кросс-хостовая переносимость не проверялась.

Архитектурное следствие для текущей задачи: `disable-model-invocation: true` можно рассматривать как DSH-specific механизм управления видимостью, когда skill должен вызываться иначе. Но он не заменяет разнесение remote/local instructions по разным файлам: metadata управляет тем, видит ли DSH skill, а не тем, сколько чужих инструкций содержится внутри видимого skill.

## Справочные документы

### Оформление skills

`.ai/docs/skill-authoring-reference.md`  
https://github.com/paulhuman/aip-mirror/blob/main/.ai/docs/skill-authoring-reference.md

Подробная запись об исследованной DSH-реализации front matter: обязательные `name` и `description`, допустимые необязательные поля, формы skills на диске, правила boolean parsing, ошибки YAML и диагностические сообщения. Источник полезен для DSH packaging, но не является универсальной спецификацией других хостов.

### Общие наблюдения об Agentic AI и DSH

`.ai/docs/agentic-ai-dsh-observations.md`  
https://github.com/paulhuman/aip-mirror/blob/main/.ai/docs/agentic-ai-dsh-observations.md

Ключевой архитектурный принцип документа: переносимое содержимое инструкций нужно отличать от host-specific упаковки, discovery, activation, metadata и execution.

### Журнал проверки discovery

`.ai/docs/agentic-ai-skill-discovery-verification.md`  
https://github.com/paulhuman/aip-mirror/blob/main/.ai/docs/agentic-ai-skill-discovery-verification.md

Содержит version-scoped наблюдения о DSH skill discovery, presets, `$DSH_HOME/skills`, project-local discovery через Windows junction и ограничениях доказательств. Перед повторным использованием отдельного результата проверить его контекст и версию.

### Организация документации и memory

- `.ai/docs/README.md`: https://github.com/paulhuman/aip-mirror/blob/main/.ai/docs/README.md
- `.ai/memory/README.md`: https://github.com/paulhuman/aip-mirror/blob/main/.ai/memory/README.md

`.ai/memory/` предназначен для временных рабочих записей, незавершённых исследований и задач; новые записи пишутся на русском, сохраняя технические обозначения в оригинальном виде. Не переносить временный аудит в постоянные docs автоматически: сначала определить, какие выводы стали устойчивыми и где их canonical owner.

## Review branch: использовать как материал, не интегрировать автоматически

Ветка: `ai-infra/host-mechanics-review`  
https://github.com/paulhuman/aip-mirror/tree/ai-infra/host-mechanics-review

Базовая точка разветвления / merge base: `a0fbc8d385b40378b2c676cc2d1a2318d68f0833`.

Ветки diverged. Последнее сравнение на момент записи:

- `main` ahead by 6 commits;
- review branch ahead of `main` by 2 commits;
- изменения review branch включают два старых отчёта и предлагаемые правки `repository/SKILL.md` и `workflow/SKILL.md`;
- в `main` есть более свежие материалы, в том числе `skill-authoring-reference.md`, обновлённый metadata TODO и два новых DSH audit файла.

Review branch не реализует полностью принятое решение о разделении на разные файлы: host-specific разделы в предложенной версии по-прежнему находятся внутри тех же skills. Поэтому даже полезные исправления из ветки нужно адаптировать к выбранной архитектуре, а не принимать целиком. Не выполнять merge/cherry-pick без отдельного решения.

## Два новых аудита — обязательное чтение в C0091

Пользователь прямо указал отложить чтение этих документов до нового чата. В C0090 их наличие в `main` подтверждено listing каталога, но **их содержимое не читалось и выводы из них не делались**.

1. `.ai/memory/dsh-audit-repository-skill.md`  
   https://github.com/paulhuman/aip-mirror/blob/main/.ai/memory/dsh-audit-repository-skill.md
2. `.ai/memory/dsh-audit-workflow-skill.md`  
   https://github.com/paulhuman/aip-mirror/blob/main/.ai/memory/dsh-audit-workflow-skill.md

В начале C0091 прочитать оба документа целиком. Сопоставить их с `dsh-report-repository-skill.md` и `dsh-report-workflow-skill.md`, отделяя новые свидетельства от повторов и рекомендаций. Только после этого определить минимальный целевой набор файлов и содержание shared contract / remote operational skills / local operational skills. До такого сравнения не изменять canonical owners и не интегрировать review branch.

## Предварительная целевая архитектура для обсуждения

Это рабочее направление, не спецификация и не разрешение на реализацию:

- Общий контракт: host-neutral инварианты, границы ответственности, безопасность и ожидаемая проверка результата.
- Remote repository operation skill/file: GitHub Connector / Contents API mechanics.
- Local repository operation skill/file: локальные Git, working tree/index/refs, ignored/untracked и защита незакоммиченной работы.
- Отдельные host-specific workflow files: общая методология разработки должна быть представлена там, где нужна каждому хосту; не помещать remote и local repository-inspection procedures в один загружаемый файл.
- DSH discovery/visibility: применять подтверждённую семантику DSH metadata осознанно; не считать metadata заменой правильной структуры файлов.

Названия, расположение и точные границы файлов пока не выбраны. Нужно избегать чрезмерного числа слоёв и дублирования с разными формулировками, но повтор допустим, если он необходим для независимого и непротиворечивого контекста каждого хоста.

## Следующая работа и ограничения

1. В C0091 первым делом прочитать два новых аудита из раздела выше.
2. Проверить текущий `main` HEAD и перечитать актуальные canonical owners перед проектированием.
3. Сопоставить все четыре аудита, текущие файлы `repository/SKILL.md` и `workflow/SKILL.md`, metadata evidence и review branch.
4. Сформировать решение по структуре файлов до правок.
5. Только после согласования архитектуры вносить минимальные изменения, соблюдая процедуру:
   READ CURRENT FILE → MAKE MINIMAL CHANGE → WRITE COMPLETE FILE → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT.
6. Не сливать review branch автоматически, не менять старые документы по памяти, не считать отчёт доказательством, что его предложения уже интегрированы.
7. Сохранять разграничение: DSH отвечает за свидетельства о собственном runtime; AIP Mirror — за интерпретацию и решения в своих canonical owners.

## Состояние на момент миграции

- Текущая глава: C0090 — Architecture & Research.
- Запрошенный successor: C0091; последовательность корректна.
- Repository: `paulhuman/aip-mirror`; default branch: `main`.
- HEAD до создания этой записи: `ba89847d4457f6c3c16621d5e1eba639bed03fc3` (`ai-docs(memory): record DSH audits of repository and workflow skills`).
- Интеграция изменений: не выполнялась.
- Новые аудиты `dsh-audit-repository-skill.md` и `dsh-audit-workflow-skill.md`: наличие подтверждено, чтение отложено до C0091 по просьбе пользователя.
