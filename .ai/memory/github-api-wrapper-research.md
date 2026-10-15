# Исследование GitHub API wrapper: полнота чтения файлов

**Дата фиксации:** 2026-10-12  
**Глава:** C0093 — Architecture & Research  
**Статус:** частично подтверждено; полнота чтения крупных файлов через wrappers не установлена  
**Назначение:** сохранить факты, ограничения доказательств, выводы и следующий план проверки для продолжения аудита `github-api-repository` и `github-api-workflow`. Это рабочая память, а не semantic owner и не доказательство поведения неиспытанных версий инструмента.

## Краткий вывод

Сейчас **не доказано**, что `fetch_file` всегда возвращает полное содержимое произвольного файла. Но также **не доказано**, что wrapper обрезает ответы на размере 1 МБ или использует конкретный ограниченный режим GitHub Contents API.

Важно не смешивать три уровня:

1. **Ограничения GitHub REST API**, описанные в официальной документации.
2. **Контракт доступного wrapper**, видимый в метаданных инструмента.
3. **Фактическая реализация и runtime-поведение wrapper**, которые пока не исследованы контролируемым тестом.

До появления новых доказательств нельзя переносить ограничения уровня 1 на wrapper как установленный факт. Нельзя и считать успешный вызов wrapper доказательством полноты: контракт не предоставляет явного размера исходного файла или признака усечения.

## 1. Контракт доступных wrappers

### `mcp__GitHub__fetch_file`

Из доступного описания инструмента подтверждены аргументы:

- `repository_full_name` — репозиторий;
- `path` — путь;
- `ref` — необязательная ветка, тег или commit ref;
- `encoding` — `utf-8` или `base64`;
- `start_line`, `end_line` — необязательный диапазон строк.

Возвращаемый объект содержит:

- `content: string`;
- `encoding: string`;
- `sha: string` — blob SHA;
- `display_url`;
- `display_title`.

Описание говорит, что без `ref` используется default branch.

В видимом контракте **нет**:

- поля с исходным размером файла;
- поля `truncated` или иного явного признака усечения;
- аргумента для выбора HTTP `Accept` / media type;
- документированного максимального размера файла;
- гарантий, что `content` полностью совпадает с blob при любом размере.

`start_line` и `end_line` намеренно позволяют получить частичный фрагмент. Такой ответ нельзя использовать как основу полной замены файла. Даже при запросе без диапазона контракт сам по себе не содержит формального доказательства полноты.

### `mcp__GitHub__fetch_blob`

Из доступного контракта подтверждены аргументы `repository_full_name` и `blob_sha`; результат содержит только `content: string`.

Видимый контракт не предоставляет:

- параметр кодировки или media type;
- размер blob;
- флаг усечения;
- явное поле SHA в результате, пригодное для сравнения с запрошенным blob.

Это делает `fetch_blob` возможным альтернативным путём для проверки, но пока **не подтверждённым способом гарантировать полноту**.

### Доступ к реализации

В описаниях доступных инструментов виден контракт, но не код адаптера, внутренний HTTP endpoint, заголовки запроса или способ декодирования ответа. По имеющимся данным нельзя определить, использует ли `fetch_file` Contents API, Git Blobs API или иной путь, а также как wrapper обрабатывает большие ответы.

При просмотре доступных инструментов не обнаружен отдельный инструмент чтения исходного кода реализации wrapper. Это означает только, что код не был найден через доступный каталог инструментов; не доказывает, что его нигде нельзя изучить.

## 2. Ограничения, документированные GitHub

Официальная документация GitHub Contents API указывает:

- для файлов размером до 1 МБ поддерживаются все возможности endpoint;
- для файлов больше 1 МБ и до 100 МБ поддерживаются только media types `raw` или `object`;
- в режиме `object` поле `content` для файлов больше 1 МБ может быть пустым, а `encoding` — `none`;
- файлы больше 100 МБ через Contents API не поддерживаются;
- listing каталога через Contents API ограничен 1 000 файлами.

Официальная документация Git Blobs API указывает, что endpoint получения blob поддерживает blobs размером до 100 МБ и имеет JSON/base64 и raw-варианты представления.

Источники:

- Contents API: https://docs.github.com/en/rest/repos/contents
- Git Blobs API: https://docs.github.com/en/rest/git/blobs
- GitHub changelog (2022-05-03), об увеличении лимита получения содержимого через Contents API до 100 МБ при использовании raw media type: https://github.blog/changelog/2022-05-03-increased-file-size-limit-when-retrieving-file-contents-via-rest-api/

**Граница доказательства:** это документация GitHub API, не спецификация поведения наших wrappers. Пока не установлен endpoint и формат запроса wrapper, нельзя утверждать, что перечисленные условия непосредственно описывают `fetch_file`.

Ограничение в 1 000 элементов каталога относится к listing Contents API; оно не является доказанным ограничением чтения одного файла через `fetch_file`.

## 3. Попытки runtime-проверки и их ограничения

Была предпринята попытка вызвать `fetch_file` для файлов `yarn.lock` и `README.md` в публичном репозитории `facebook/react`. Оба вызова завершились общей ошибкой:

`InvalidInputException: GitHub path did not return readable file content`

Эти результаты **не позволяют** заключить, что:

- причина — размер файла;
- wrapper обрезает файл;
- wrapper использует Contents API с конкретным media type;
- все публичные репозитории недоступны;
- любой крупный или любой малый файл будет обработан таким же образом.

Причина ошибки не установлена; возможно, проверка упёрлась в ограничения доступа/поддерживаемого контекста, а не в размер. Этот тест считается **неинформативным**, а не отрицательным доказательством полноты.

Текущие небольшие файлы приватного репозитория `paulhuman/aip-mirror` читаются через `fetch_file`, но успешное чтение маленьких файлов не доказывает поведение на больших.

## 4. Практические правила до завершения исследования

Для дальнейшей работы с `github-api-*`:

1. Не писать, что `fetch_file` обязательно обрезает файлы после 1 МБ: доказательств нет.
2. Не писать, что `fetch_file` гарантированно возвращает полный файл любого размера: такой гарантии в доступном контракте нет.
3. Не считать отсутствие ошибки, наличие blob SHA или непустое `content` самостоятельным доказательством полноты.
4. При неожиданном `encoding` (например, `none`), пустом `content` или ошибке считать чтение неподтверждённым и не интерпретировать это автоматически как пустой файл.
5. Перед полной заменой существующего файла получать содержимое без `start_line`/`end_line`; если полнота сомнительна, не выполнять запись на основании этого результата.
6. Сохранять blob SHA и фиксированную commit revision раздельно: blob SHA идентифицирует содержимое файла, но не доказывает, что чтение было полным или что ветка не сдвинулась.
7. При необходимости крупного чтения отдельно оценивать `fetch_blob`, но не объявлять его безопасной заменой, пока он не проверен.
8. Не менять семантику canonical skills на основании неподтверждённой гипотезы о размере. При необходимости можно добавить узкую оговорку только после определения полезного критерия проверки.

## 5. Открытые вопросы и следующий план

### TODO 1 — установить реализацию wrapper

**Ожидаемый результат:** выяснить, какой endpoint и формат ответа использует `fetch_file`, и как обрабатываются ответы больше 1 МБ.

**Проверка:** найти доступный исходный код/документацию адаптера либо получить авторитетное описание реализации. Зафиксировать endpoint, `Accept`/media type, декодирование, поведение на пустом `content` и ошибках. Если реализация недоступна, явно оставить это неизвестным.

### TODO 2 — провести контролируемый размерный тест

Если исходный код недоступен, создать или использовать известные текстовые файлы в контролируемом репозитории/ветке, например размеры около 100 КБ, чуть меньше 1 МБ, чуть больше 1 МБ и несколько мегабайт. Тестировать только на явно разрешённом disposable fixture, не меняя `main` и не затрагивая чужие репозитории.

Для каждого образца до чтения независимо записать:

- ожидаемый размер в байтах;
- ожидаемое содержимое или его проверяемую контрольную сумму;
- Git blob SHA;
- commit SHA и path.

Затем вызвать `fetch_file` без line range и, отдельно, `fetch_blob` по тому же blob SHA. Сравнить возвращённое содержимое с ожидаемым содержимым, учитывая кодировку и нормализацию строк. Проверить ошибки, длину результата, SHA и возможность выявить усечение. Тесты должны различать «полное содержимое», «пустой ответ», «ошибка» и «частичное содержимое».

**Критерий завершения:** результат воспроизводим и привязан к версии wrapper/инструмента и точному fixture; он позволяет сформулировать только те гарантии, которые действительно проверены. Несколько успешных тестов не доказывают универсальную гарантию для файлов произвольного размера.

**Статус:** PARTIALLY COMPLETED — размерные случаи от малых файлов до 5 MiB проверены на зафиксированных commits; версия/реализация wrapper не установлена, поэтому выводы ограничены наблюдавшейся конфигурацией.

### TODO 3 — решить, требуется ли изменение skills

После TODO 1 или TODO 2 вернуться к:

- `.ai/skills/github-api-repository/SKILL.md`;
- `.ai/skills/github-api-workflow/SKILL.md`.

Внести изменение только если установлен конкретный failure mode или полезный проверяемый критерий. При правке существующего файла соблюдать обязательную последовательность:

`READ CURRENT FILE → MAKE MINIMAL CHANGE → WRITE COMPLETE FILE → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT`.

Не интегрировать candidate branch в `main` без отдельного решения пользователя.

## 6. Текущая рабочая привязка

- Репозиторий: `paulhuman/aip-mirror`.
- Исследование сохраняется в канонической ветке `main`.
- `ai-infra/six-skill-host-separation` — отдельная review-ветка с кандидатными изменениями архитектуры; её содержимое не считается интегрированным в `main`.
- Сохранение этого документа в `main` не переносит и не интегрирует изменения навыков из review-ветки.
- Ответственность: ChatGPT продолжает аудит `github-api-*`; DSH самостоятельно проверяет и дорабатывает `git-cli-*`.
- Не делать выводов о локальной рабочей копии по remote GitHub state.

## Краткая классификация

**Подтверждено**
- Контракт `fetch_file` включает `content`, `encoding`, blob `sha`, URL/title, опциональные line-range параметры.
- Контракт `fetch_blob` включает только SHA репозитория/запрашиваемого blob на входе и `content` на выходе.
- В видимых контрактах нет размера файла, явного флага усечения или выбора media type.
- GitHub публикует описанные выше ограничения Contents API и Git Blobs API.
- Проверка на `facebook/react` закончилась общей ошибкой чтения, причина неизвестна.

**Не подтверждено**
- Какой endpoint вызывает `fetch_file`.
- Используемые wrapper заголовки и media type.
- Наличие внутренних лимитов, обрезки или иной нормализации.
- Полнота `fetch_file` и `fetch_blob` для файлов больше 1 МБ.
- Причина ошибки при чтении файлов `facebook/react`.

**Рабочий вывод**
- Это пока пробел в доказательствах/контракте, а не доказанное ограничение wrapper на 1 МБ.
- Следующий полезный шаг — выяснить реализацию или провести контролируемый тест. До этого не превращать гипотезу в нормативное правило.


## Актуализация 2026-10-12 — результаты первой лабораторной серии

Эта запись дополняет предварительные выводы выше. Там, где ранние разделы говорят, что контролируемый размерный тест ещё не проведён, считать их историческим состоянием исследования на момент C0093; текущий результат описан здесь.

Отдельный репозиторий лаборатории зарегистрирован в `.ai/config.yaml` как `experiments.repositories.github_api_lab`:
https://github.com/paulhuman/github-api-lab

Результаты первой серии находятся в:
https://github.com/paulhuman/github-api-lab/blob/main/results/fetch-completeness-2026-10-12.md

Наблюдения в текущей конфигурации инструмента:

- `fetch_file` вернул точное содержимое для проверенных ASCII-фикстур до 1 048 575 байт включительно.
- На фикстурах размером 1 048 576 байт (как одна длинная строка, так и множество строк) и 1 153 440 байт `fetch_file` вернул пустое содержимое, но правильный blob SHA.
- `encoding="base64"` и запрос диапазона строк не устранили пустой ответ для проверенных фикстур около 1 MiB.
- `fetch_blob` вернул полное ожидаемое содержимое тех же blob до 1 153 440 байт включительно.
- Создание фикстуры 5 MiB завершилось транспортной ошибкой; фикстура не создана. Поведение чтения 5 MiB остаётся неизвестным.

Это эмпирическая граница для проверенных случаев, а не доказательство внутреннего endpoint, media type или универсального лимита wrapper. На момент первой серии стабильные данные ещё не были опубликованы в `docs/`; эта задача завершена в C0095 и зафиксирована в следующем разделе.

### Актуализация C0095 — независимый small-file control и публикация результатов

Независимый контрольный эксперимент выполнен на ветке `experiment/control-read-completeness-20261012` в `paulhuman/github-api-lab`.

- Fixture: `fixtures/control-independent-oracle-c0095.txt`.
- Immutable fixture commit: `405ef375f12cc6ea5ea92841a363b184b7b334c9`.
- Expected UTF-8 content was defined before either read: `C0095 independent oracle control\nASCII fixture\nExpected bytes are defined before either read method.\n`.
- Expected byte length: 101; character count: 101.
- Independently calculated UTF-8 SHA-256: `8ab2b9b5b4420c89120aec0c1f31307b84831ca2456aa4b87c22d66644566f4a`.
- Independently calculated Git blob SHA-1: `9e6338eec493037c8a5d0001a1e33e96b553fd41`.
- `fetch_file`, pinned to the fixture commit, returned 101 characters, exact expected content, and the expected blob SHA: PASS.
- `fetch_blob`, called with the independently calculated expected blob SHA, returned the exact expected content: PASS.
- This confirms the small-file control case only; it does not establish general completeness guarantees.

Canonical publication on laboratory `main`:

- `docs/README.md`: commit `29c849b5aa380ee6e377f7e805ab7daf96effd7d`.
- `docs/fetch-completeness-2026-10-12.md`: commit `04427c9ed073a906f38ed9cd93dc0dea90b7890b`.
- Root `README.md` canonical-documentation link: commit `4cb9093ae1598a02a773edfdbaad995ab9fd36af`.
- All three published paths were read back from `main`; the canonical summary contains the independent-oracle data, size-boundary table, and explicit INCONCLUSIVE status for the unperformed 5 MiB read.
- Published document: https://github.com/paulhuman/github-api-lab/blob/main/docs/fetch-completeness-2026-10-12.md

### TODO 4 — опубликовать стабильные проверенные результаты в `github-api-lab/docs/` на `main`

**Ожидаемый результат:** стабильные, проверенные выводы и таблицы экспериментов находятся в канонической ветке `main` лабораторного репозитория, в предназначенном для документации каталоге `docs/`, независимо от жизненного цикла временных тестовых веток.

Действия:

1. Повторно проверить результаты по неизменяемым commit SHA фикстур, ожидаемым содержимым и Git blob SHA.
2. Подготовить документ в `docs/` с итоговой таблицей, методикой, ссылками на фикстуры/коммиты, точными размерами и ограничениями выводов.
3. Сохранить различие между стабильными выводами и временными/неполными экспериментами. Отдельно обозначить точный статус 5 MiB по имеющимся результатам, не повышая наблюдения до универсальной гарантии.
4. Записать документ в `main`, прочитать обратно, проверить содержимое, diff, родительский commit и scope.
5. Проверить, что README лаборатории ссылается на каноническую документацию, а таблицы и результаты не существуют только на временной ветке.

**Критерий завершения:** проверенная документация и таблицы доступны из `main/docs/`; их сохранность не зависит от временных экспериментальных веток.

**Статус:** COMPLETED — проверенный документ опубликован в `main/docs/`, перечитан обратно; root README ссылается на canonical summary. Commits и ссылки зафиксированы в разделе актуализации C0095 выше.

### TODO 5 — завершить проверку крупных фикстур и определить безопасный критерий полноты

**Ожидаемый результат:** дополнительные крупные случаи проверены, а практические рекомендации для `github-api-*` основаны на воспроизводимых данных, не на предположении о внутренней реализации.

Действия:

- Найти способ создать и прочитать фикстуру 5 MiB без повторения неудачной передачи огромного тела через текущий tool transport. **Выполнено:** manual workflow создал fixture на отдельной ветке, а `fetch_blob` вернул полное содержимое; SHA-256 независимо пересчитан и совпал.
- При необходимости проверить дополнительные формы ответа через доступный `fetch`/raw путь, но считать их независимыми методами только после установления, что путь действительно отличается.
- Не менять canonical skills до определения минимального проверяемого safeguard; после этого внести минимальное изменение в `.ai/skills/github-api-repository/SKILL.md` и/или `.ai/skills/github-api-workflow/SKILL.md`, если оно обосновано evidence.
- Каждый результат фиксировать на неизменяемом commit SHA, сравнивать с независимым эталоном и отдельно классифицировать как PASS, FAIL или INCONCLUSIVE.

**Критерий завершения:** границы подтверждённых результатов и неизвестного поведения документированы; никакой неудачный транспортный вызов не выдан за результат чтения.

**Статус:** PARTIALLY COMPLETED — 5 MiB fixture успешно прочитана через `fetch_blob` и подтверждена SHA-256; причина пустого `fetch_file.content` и точная реализация wrapper всё ещё неизвестны.

### TODO 6 — не удалять ветку до инвентаризации уникальных файлов и переноса durable evidence

Перед удалением любой ветки:

- сравнить её commits и изменённые пути с базовой и канонической ветками;
- установить, какие файлы/изменения являются единственными копиями;
- перенести нужные стабильные результаты и документацию в канонический `main/docs/` и прочитать их обратно;
- только после проверки сохранности durable artifacts рассматривать удаление временной ветки;
- если судьба уникальных данных не определена, остановиться и запросить решение владельца.

Это правило теперь также является общим инвариантом в `.ai/skills/repository/SKILL.md`; host-specific способы инвентаризации определяются соответствующим repository skill.

**Статус:** INVENTORY COMPLETED — текущие heads, merge bases, unique commits и changed paths перепроверены. Обе экспериментальные ветки сохранить: в них находятся уникальные fixture paths, а отдельного разрешения владельца на удаление нет.


### Актуализация C0095 — инвентаризация ветки эксперимента

На paulhuman/github-api-lab сравнение main с experiment/control-read-completeness-20261012 показало divergence: merge base 203f1b7dab82b8a014ccbca074a9d192790f0502, 11 commits только на экспериментальной ветке и 5 commits только на main после merge base. Цепочка от head до merge base проверена по parent SHA; каждый из 11 branch-only commits добавляет ровно один fixture path. Head на момент инвентаризации: 405ef375f12cc6ea5ea92841a363b184b7b334c9.

Канонический отчёт на lab main дополнен таблицей commit/path и статусом безопасного создания 5 MiB: https://github.com/paulhuman/github-api-lab/commit/28c7e26f21784559f409870090b5dd24832bc381. Файл прочитан обратно; содержимое совпало полностью. Никакой ветки или истории не удаляли и не переписывали.

Сохранение результатов в документации не означает, что исходные fixture blobs больше не нужны: ветку оставить. Удаление требует отдельного явного разрешения владельца. 5 MiB по-прежнему не создан и не прочитан; замена create_file на create_blob сама по себе не обходит транспорт, поскольку обе операции всё ещё передают большое тело. Вариант генерации фикстуры внутри GitHub Actions только предложен для оценки; он не запускался и не считается проверенным.


### C0095 — подготовлен manual-only генератор 5 MiB fixture

В `paulhuman/github-api-lab` добавлен `.github/workflows/create-5m-fixture.yml` (commit `92a952eb91e0269c95acaaf7cc5ec0b6aca00dd0`), затем усилена проверка Git blob SHA (`5f978093a34975cf3296327c22a6663ddfefe77c`). Workflow доступен только через `workflow_dispatch`, использует standard `ubuntu-latest`, `timeout-minutes: 5`, `contents: write` и не имеет автоматических триггеров. Он генерирует детерминированный ASCII fixture размером ровно 5,242,880 bytes, вычисляет SHA-256 и Git blob SHA-1, сравнивает blob SHA с `git hash-object`, затем публикует новую ветку `experiment/fixture-5m-c0095-<run-id>` от `main`. Существующий branch/path перезаписывать не должен.

Workflow и его итоговый отчёт перечитаны обратно; изменения задокументированы в canonical lab report commit `d471f0f73b73063eb2bc1fa04ba9aee885eec235`. Workflow ещё не запускался: создание ветки, commit и 5 MiB read не подтверждены. Поскольку lab repo private, перед запуском владелец должен проверить Actions usage/budget. GitHub Free включает 2,000 standard runner minutes/month для private repos, но текущий остаток квоты неизвестен. До ручного запуска не считать тест пройденным.

Official refs: https://docs.github.com/en/billing/concepts/product-billing/github-actions and https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax.


### C0095 — 5 MiB read test completed (2026-10-12)

Manual workflow `paulhuman/github-api-lab/.github/workflows/create-5m-fixture.yml` successfully generated and published the deterministic fixture:

- Branch: `experiment/fixture-5m-c0095-38260305834`
- Commit: `0a55aeac7948e2dd9984795cbd968c134a731ad7`
- Path: `fixtures/size-5m-c0095.txt`
- Expected size: 5,242,880 bytes; all bytes are ASCII.
- Workflow-reported SHA-256: `01aa375d43dba8abfb1c996c495aae9a07e94c330ed01dda316aa5365fe66bd6`
- Independently verified Git blob SHA-1: `5c1cb4d9f4cdaa984ecb4a42f9cdc8032fbcf339`

Read tests against this generated fixture:

- `fetch_file(repository_full_name="paulhuman/github-api-lab", path="fixtures/size-5m-c0095.txt", ref="experiment/fixture-5m-c0095-38260305834", encoding="utf-8")` returned an empty string (0 characters) but reported the expected blob SHA-1. Assessment: **FAIL — content missing**.
- `fetch_blob(repository_full_name="paulhuman/github-api-lab", blob_sha="5c1cb4d9f4cdaa984ecb4a42f9cdc8032fbcf339")` returned 5,242,880 ASCII characters. A separate local calculation of Git's blob SHA-1 over the returned bytes plus the `blob <length> NUL` header matched the expected SHA-1 exactly. Assessment: **PASS**.

This is the first verified 5 MiB read case; replace prior “5 MiB untested” status where summarizing current state. The observation extends the tested pattern for the current wrapper/tool configuration, but does not establish a universal GitHub API limit or prove which internal endpoint/adapter is used. The successful workflow showed Node.js 20 deprecation and future `ubuntu-latest` migration notices; treat those as maintenance items, not failures of this run.

Canonical lab report updated and read back exactly: https://github.com/paulhuman/github-api-lab/commit/883ca4bb68d3211acd45472642779adfb29802e7. No branch was deleted. Preserve both this generated fixture branch and the earlier experiment branch until separate inventory/preservation review and explicit owner authorization.


### TODO 7 — восстановить bootstrap discovery и полную активацию необходимых skills

**Проблема:** TRACE инициализации C0096 перечисляет прочитанные файлы, но не показывает чтение `.ai/INDEX.md`. При этом `.ai/skills/github-api-repository/SKILL.md` был указан как `OPERATION READS`, а не как `ACTIVATE owner`; `.ai/skills/github-api-workflow/SKILL.md` в списке чтения отсутствует. Сам TRACE не доказывает, что необходимые специализированные skills были обнаружены и активированы по текущему контракту.

**Уточнение по текущему нормативному тексту:** `BOOTSTRAP.md` не включает `INDEX` в минимальный список `ACTIVATE owners` и одновременно говорит, что bootstrap не заменяет `.ai/INDEX.md`; он также требует активировать другие applicable canonical skills. Поэтому само отсутствие `INDEX` в TRACE пока не доказывает нарушение прямого требования. Неясно именно то, каким обязательным шагом bootstrap должен обнаруживать дополнительные host-specific owners и включать их в ACTIVATE.

**Действия:**

1. Сверить актуальные `.ai/INDEX.md`, `.ai/conversation-management/handoff/BOOTSTRAP.md`, `.ai/skills/activation/SKILL.md` и применимые host-specific skills, чтобы определить нормативную последовательность discovery → activation → operation reads.
2. Установить, каким предусмотренным механизмом bootstrap должен обнаруживать `INDEX` и дополнительные skills после изменений архитектуры. Не считать прежнее поведение гарантией текущего контракта.
3. Проверить, какие skills обязательны для bootstrap и последующих операций через GitHub API; отдельно различать «прочитан» и «активирован».
4. При подтверждении пробела внести минимальную согласованную поправку в канонический owner (не дублировать процедуру в INDEX), затем проверить bootstrap на новом контролируемом проходе.
5. Убедиться, что user-visible TRACE включает фактически перечитанные activation owners и отдельно перечисляет только дополнительные operation reads без дубликатов.

**Критерий завершения:** канонический контракт однозначно определяет начальное обнаружение skills и необходимые activation owners; повторный bootstrap показывает проверяемую последовательность, а TRACE не смешивает чтение с активацией.

**Результат аудита C0099:**

- Текущий `.ai/conversation-management/handoff/BOOTSTRAP.md` задаёт порядок discovery: конфигурация → `.ai/AGENTS.md` → `.ai/INDEX.md` → `.ai/skills/repository/SKILL.md` как первый semantic owner → остальные применимые canonical owners.
- BOOTSTRAP требует использовать INDEX для выбора применимых owners, а не читать все перечисленные в INDEX skills без разбора.
- Инициализационный ACTIVATE имеет минимальный набор owners и допускает дополнительные owners, применимые к операции; BOOTSTRAP отдельно требует выбрать дополнительные canonical owners через INDEX и прочитать их до выполнения операции. Host-specific GitHub API skills не обязаны быть частью минимального списка для каждой возможной операции, но применимые skills должны быть выбраны и активированы для соответствующей работы.
- `.ai/INDEX.md` — discovery/router, а не обязательный ACTIVATE owner сам по себе. Его отсутствие в списке ACTIVATE owners не является нормативным нарушением. Если INDEX действительно прочитан в ходе операции, он должен учитываться в `OPERATION READS`, а не дублироваться среди ACTIVATE owners.
- TRACE C0096 не подтверждает, что INDEX был прочитан, но сам по себе не устанавливает, была ли причина в пропуске чтения или в неполной фиксации TRACE. Это ограничение исторического evidence, а не доказанный пробел текущего нормативного контракта.

Канонические skills не менялись: достаточного свидетельства нормативного пробела не найдено.

**Статус:** CLOSED — аудит текущего контракта не подтвердил нормативный пробел discovery → activation; вывод и границы исторического evidence зафиксированы выше.

 
### Актуализация C0096 — проверка branch inventory и SHA-256 (2026-10-12)

Проверки привязаны к текущим immutable refs лабораторного репозитория `paulhuman/github-api-lab`:

- `main` HEAD: `883ca4bb68d3211acd45472642779adfb29802e7`; root tree: `d25612000afec0e98eac8436259dab59b86ef60b`.
- `experiment/control-read-completeness-20261012` HEAD: `405ef375f12cc6ea5ea92841a363b184b7b334c9`.
- `experiment/fixture-5m-c0095-38260305834` HEAD: `0a55aeac7948e2dd9984795cbd968c134a731ad7`.

Сравнение текущего `main` с `experiment/control-read-completeness-20261012`:
- merge base: `203f1b7dab82b8a014ccbca074a9d192790f0502`;
- 11 commits only on experiment branch и 10 commits only on `main` после merge base (status: diverged);
- parent links всех 11 experiment-only commits проверены до merge base;
- каждый из 11 commits меняет ровно один ожидаемый fixture path, совпадающий с canonical inventory table в `docs/fetch-completeness-2026-10-12.md`.

Для ветки 5 MiB:
- fixture commit `0a55aeac7948e2dd9984795cbd968c134a731ad7` имеет parent `d471f0f73b73063eb2bc1fa04ba9aee885eec235`;
- текущий `main` HEAD `883ca4bb68d3211acd45472642779adfb29802e7` имеет тот же parent, поэтому refs разошлись на один commit с каждой стороны;
- unique path: `fixtures/size-5m-c0095.txt`; branch-only commit меняет только этот путь.

Независимый SHA-256 пересчёт содержимого `fetch_blob`:
- length: 5,242,880 ASCII bytes/characters;
- Git blob SHA-1: `5c1cb4d9f4cdaa984ecb4a42f9cdc8032fbcf339`;
- SHA-256: `01aa375d43dba8abfb1c996c495aae9a07e94c330ed01dda316aa5365fe66bd6`, совпадает с independently recorded expected digest.

Итог: evidence сохранено в canonical lab report; обе experiment branches и их уникальные fixture objects оставить без изменений. Удаление не разрешено. Точная причина пустого `fetch_file.content` не установлена; видимый wrapper contract не раскрывает endpoint/media type/внутреннее декодирование, и гипотеза о Free plan остаётся неподтверждённой. TODO 1 и TODO 3 остаются открытыми до получения авторитетной информации о реализации или иного конкретного evidence.


### TODO 8 — документировать Git tree snapshot через универсальный `mcp__GitHub__fetch`

**Ожидаемый результат:** `.ai/skills/github-api-workflow/SKILL.md` описывает проверенный способ получить полный repository tree через универсальный GET-инструмент `mcp__GitHub__fetch`, не предполагая наличие отдельного `fetch_tree`.

**Шаги, которые нужно закрепить в skill:**

1. Получить целевой ref и закрепить его на точном commit SHA.
2. Вызвать `mcp__GitHub__fetch` через GitHub REST API: `GET /repos/{owner}/{repo}/git/commits/{commit_sha}`; извлечь `commit.tree.sha` как root tree SHA.
3. Вызвать `mcp__GitHub__fetch` для `GET /repos/{owner}/{repo}/git/trees/{tree_sha}?recursive=1`.
4. Проверить, что возвращённый `tree.sha` совпадает с запрошенным SHA, записать количество entries и явно проверить `truncated`.
5. Считать recursive snapshot полным только при `truncated: false`. Если `truncated: true`, пройти дерево через bounded non-recursive GET-запросы для root tree и всех необходимых поддеревьев, пока все entries в scope не будут учтены.
6. Последующие чтения файлов и проверки привязать к тому же commit SHA; tree подтверждает структуру, но сам по себе не заменяет чтение содержимого файлов.
7. В качестве evidence фиксировать ref, commit SHA, root tree SHA, число entries, `truncated` и результаты проверки coverage.

**Статус:** CLOSED — процедура добавлена в `.ai/skills/github-api-workflow/SKILL.md`, перечитана обратно и проверена по diff и changed-file scope. Commit: `a55ed27fd319eceac94d897b2fe11fa43093a67b`; финальная правка форматирования skill: `77e1d6ab7ed7e7b071d1ab862d0c76730fbdd7d1`.



### C0099 — поиск авторитетной информации о реализации wrapper

Поиск по точным именам `mcp__GitHub__fetch_file` и `mcp__GitHub__fetch_blob` не обнаружил публичного исходного кода или авторитетной документации, которая связывала бы эти конкретные инструменты с внутренним endpoint, заголовками, media type или алгоритмом декодирования.

Публичный репозиторий официального GitHub MCP Server (`https://github.com/github/github-mcp-server`) документирует другой инструментальный контракт, включая `get_file_contents`. Его нельзя считать реализацией подключённых здесь `mcp__GitHub__fetch_file` / `mcp__GitHub__fetch_blob` без доказательства, что текущая интеграция действительно использует этот сервер и соответствующий путь кода.

Подтверждено для текущего окружения:

- Метаданные инструментов определяют доступные аргументы и поля результата, но не раскрывают внутреннюю реализацию wrappers.
- Универсальный `mcp__GitHub__fetch` успешно выполнил GET к Git Data API и вернул полный recursive tree для C0099: 294 entries, `truncated: false`, возвращённый tree SHA совпал с запрошенным.
- Успех `mcp__GitHub__fetch` подтверждает пригодность этого метода для данного Git-tree запроса, но ничего не доказывает о внутреннем пути `fetch_file`.

**Вывод:** авторитетный источник реализации конкретных wrappers пока не найден. Не приписывать им endpoint или media type по аналогии с публичными MCP-серверами; не менять canonical skills на основании этого поиска. TODO 1 остаётся OPEN до появления прямого источника реализации или иного воспроизводимого evidence, отвечающего на вопрос о внутреннем пути.


### Актуализация C0100 — сравнение независимых read surfaces (2026-10-15)

**Вопрос:** одинаково ли ведут себя `mcp__GitHub__fetch_file` и универсальный `mcp__GitHub__fetch` при чтении одного и того же закреплённого fixture около 1 MiB?

**Фиксированный образец:**
- Repository: `paulhuman/github-api-lab`.
- Path: `fixtures/size-1m-exact.txt`.
- Immutable commit: `c5260555959547432c68c47b1ffb0be807d74164`.
- Ожидаемый размер: 1,048,576 ASCII bytes; ожидаемый Git blob SHA-1: `396a8f9f5ff50e576448505bf03d425aa38ac72f`, независимо зафиксирован в предыдущем отчёте.

**Новые наблюдения текущего окружения:**

1. `mcp__GitHub__fetch` был вызван с URL `https://api.github.com/repos/paulhuman/github-api-lab/contents/fixtures/size-1m-exact.txt?ref=c5260555959547432c68c47b1ffb0be807d74164`.
   - Возвращённый `content` имел длину ровно 1,048,576 символов.
   - Проверка всего возвращённого текста подтвердила ожидаемый повторяющийся ASCII-шаблон `0123456789abcdef` по всей длине.
2. `mcp__GitHub__fetch_file` был вызван с тем же repository, path и commit SHA.
   - `content` имел длину 0.
   - `sha` равнялся ожидаемому blob SHA `396a8f9f5ff50e576448505bf03d425aa38ac72f`.
   - `encoding` был `utf-8`.

**Вывод ограниченного scope:** два доступных read surfaces дали разные результаты для одного path на одном immutable commit: универсальный `fetch` вернул полный ожидаемый текст, а `fetch_file` вернул пустой текст с правильным blob SHA. Это уточняет, что известный failure mode не означает, что само содержимое Git-объекта недоступно через все доступные инструменты.

**Чего этот опыт не доказывает:**
- что `fetch_file` внутри вызывает GitHub Contents API;
- какой `Accept` header или media type использует `fetch_file`;
- почему два read surfaces отличаются;
- что универсальный `fetch` надёжно возвращает файлы произвольного размера или бинарные данные;
- что результат переносим на другие версии инструмента/окружения.

**Источники и границы авторитетности:**
- Контракт OpenAI GitHub integration описывает live repository access на уровне продукта, но не публикует реализацию конкретных wrappers: https://help.openai.com/en/articles/11145903-connecting-github-to-chatgpt
- Независимый публичный аудит другого пользователя также сообщает об ограничениях `fetch_blob` при бинарном содержимом и успешном чтении через `fetch_file(..., encoding="base64")`, но это стороннее наблюдение из другого окружения, а не спецификация текущей реализации: https://github.com/zaidifm/chatgpt/blob/39cc5f99c69a353d4d0bdc970a44c4bd3c1a5606/audits/2026-07-26-GITHUB-CONNECTOR-CAPABILITY-AUDIT.md

**Следующий исследовательский шаг:** продолжить поиск прямого источника реализации; если его нет, проверять отдельную гипотезу только контролируемым сравнением поведения разных read surfaces. Не повторять завершённые size-boundary tests, не менять защищённые лабораторные ветки и не выводить внутренний endpoint по внешнему сходству поведения.

**Дополнительное публичное свидетельство (найдено после записи выше):**
- В `openai/codex` открыт issue [#52739 — ChatGPT GitHub connector cannot read ~60 MB PDF from private repo](https://github.com/openai/codex/issues/52739), опубликованный 2026-10-10. Автор сообщает о корректных метаданных/blob SHA и пустом `content` у `fetch_file(..., encoding="base64")`, а также об ограничении generic `fetch` для крупных binary/non-UTF-8 ответов.
- Issue фиксирует похожий наблюдаемый симптом в другом сценарии, но сам автор отмечает, что точная стадия сбоя/root cause не подтверждены. Это issue/репродукция, не исходный код и не доказательство реализации нашего wrapper.
### Актуализация C0100 — публичные issue и контракт generic fetch (2026-10-15)

**Проверка публичных сообщений:**
- Открытый issue `openai/codex#52739`, созданный 2026-10-10: https://github.com/openai/codex/issues/52739.
- Автор сообщает о `fetch_file(encoding="base64")`, который для PDF около 60 MB возвращает валидные blob SHA/encoding, но пустой `content`; generic fetch в описанном сценарии не поддерживает большие binary/non-UTF-8 ответы.
- Issue содержит `performed_via_github_app.slug = chatgpt-codex-connector`, 0 комментариев на момент чтения, и прямо говорит, что точная стадия сбоя/root cause не подтверждены. Это независимый report о симптоме, не реализационный источник.
- Дополнительный GitHub code search по точным именам `mcp__GitHub__fetch_file`, `mcp__GitHub__fetch_blob` и комбинациям с ошибкой не выявил публичного исходного кода именно этих wrappers. Результаты преимущественно упоминают имена инструментов в сторонних заметках/каталогах.

**Уточнение доступного контракта инструмента в текущем окружении:**
- Метаданные `mcp__GitHub__fetch` прямо описывают его как GET к разрешённым public GitHub repository resources и говорят, что oversized или non-UTF-8 responses rejected; binary downloads не поддерживаются.
- Это прямое свидетельство ограничения generic `fetch` в текущем tool contract. Оно не определяет endpoint или implementation path `fetch_file` / `fetch_blob`.
- Публичная справка OpenAI по GitHub connector описывает retrieval разрешённого repository content on demand, но не раскрывает внутреннюю реализацию wrappers: https://help.openai.com/en/articles/11145903-connecting-github-to-chatgpt.
- Официальный `github/github-mcp-server` остаётся отдельной публичной реализацией; совпадение предметной области или имён не доказывает, что текущие wrappers вызывают его.

**Итог:** публичные reports подтверждают, что похожий симптом наблюдался и в другом сценарии, а текущий контракт generic `fetch` явно исключает oversized/non-UTF-8 responses. Ни один из этих фактов не устанавливает причину пустого `fetch_file.content` для текстового fixture размером 1 MiB и не раскрывает его внутренний endpoint/media type. TODO 1 остаётся OPEN; менять canonical skills на основании этого свидетельства не следует.