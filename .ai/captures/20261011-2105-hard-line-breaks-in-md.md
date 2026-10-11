---
title: Коммит-сообщения для правки hard line breaks
date: 2026-10-11
source: DSH · сессия
status: raw
---

Проверил соглашение в обоих репозиториях — оно устойчивое.

## Дефолтный текст

Если правишь breaks в **обоих** каталогах сразу:

```
ai-docs: use hard line breaks in bold header blocks
```

Если только в одном месте — с scope:

| Где правил           | Текст                                                     |
| -------------------- | --------------------------------------------------------- |
| только `.ai/docs/`   | `ai-docs(docs): use hard line breaks in document headers` |
| только `.ai/memory/` | `ai-docs(memory): use hard line breaks in report headers` |

Все три формы имеют прецедент в истории: `ai-docs(docs)` — 6 раз, `ai-docs(memory)` — 11 раз, `ai-docs` без scope — 3 раза. Scope `docs` разрешён явно как generic в `.ai/skills/commits/SKILL.md`.

## Команда целиком

```powershell
cd E:\Projects\repos\aip-mirror
git add -- .ai/docs .ai/memory
git commit -m "ai-docs: use hard line breaks in bold header blocks"
```

## Почему именно так

- **Императив, строчная после двоеточия, без точки** — прямые требования владельца `commits`.
- **Что сделано, а не что сломано.** `use hard line breaks` описывает результат; `fix markdown` описывает проблему расплывчато.
- **Без rationale.** По правилу «Keep these messages short. Do not append … rationale» — чем вызван дефект, в сообщение не тащим. Кому надо, посмотрит diff.

## Чего не писать

| Плохо                                                                               | Почему                                                                               |
| ----------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| `fix typo`                                                                          | не говорит, что именно                                                               |
| `ai-docs: minor fixes` / `cleanup` / `polish`                                       | пустое; в истории есть `unify source-verification language` — вот так информативно   |
| `ai-docs(memory): fix markdown hard line break formatting issues in report headers` | пересказ реализации; владелец прямо просит «avoid unnecessary implementation trivia» |
| с точкой в конце                                                                    | запрещено style rules                                                                |
| `fix: markdown`                                                                     | `fix` — не из `ai-*` namespace для `.ai/`                                            |

## Если breaks — часть более крупной правки

Не делай отдельный коммит. Правило: «one coherent change». Если ты в том же файле правишь ещё и содержание — опиши **основную** цель, а breaks просто войдут в неё. Отдельный коммит только за пробелы имеет смысл, когда это единственное изменение.

Прецедент для проверки, что всё сделано аккуратно: `git show --stat HEAD` — там должно быть только ожидаемое число строк, `N insertions, N deletions` при равном счёте (только пробелы добавлены).
