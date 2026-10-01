# Manual use of ACTIVATE, REFRESH, and TRACE

## Why this exists

The activation skill is part of the internal `.ai` infrastructure, but a user may sometimes want to explicitly ask the AI to perform or show these functions.

The important point is that these are **not new commands**. They are natural-language requests for behavior already defined by `.ai/skills/activation/SKILL.md`.

## How to think about them

- `ACTIVATE` = перечитай актуальные canonical owners.
- `REFRESH` = повтори ACTIVATE.
- `TRACE` = покажи evidence того, что ACTIVATE действительно выполнен.

The three concepts have different roles:

```text
ACTIVATE ≠ выполнение задачи
REFRESH  ≠ выполнение задачи
TRACE    ≠ выполнение задачи
```

ACTIVATE prepares current operational context. REFRESH rereads that context when it may have become stale. TRACE makes the observable activation result visible.

## ACTIVATE

ACTIVATE is not normally a user-facing command. It is the mechanism used before an operation when the current canonical context needs to be established.

A natural-language request can be as simple as:

> Активируй контекст для этой операции.

The AI should then:

1. identify the operation;
2. identify the canonical owners required for that operation;
3. reread their current repository versions;
4. treat those versions as authoritative;
5. continue with the actual operation.

For example:

```text
ACTIVATE
  operation: handoff lifecycle change
  owners:
    .ai/rules/handoff/lifecycle.md
  status: ACTIVATED
```

ACTIVATE itself does not execute the requested operation.

## REFRESH

REFRESH is simply another way to request ACTIVATE again.

A user can say:

> Сделай REFRESH текущего activation context.

or:

> Перечитай актуальные canonical owners перед тем, как продолжим.

This is useful when:

- a relevant canonical file has just changed;
- the conversation has been paused for a while;
- the user wants to make sure the AI is working from the current repository state;
- the user explicitly wants the activation context re-established.

The semantic sequence is:

```text
REFRESH
    ↓
ACTIVATE
    ↓
ACTIVATED
```

REFRESH does not introduce another capability.

## TRACE

TRACE is an observable presentation of activation, not another operation.

A user can ask:

> Покажи TRACE для ACTIVATE.

The AI may then show:

```text
TRACE
  operation: activation architecture research

  ACTIVATE
    owners:
      .ai/skills/activation/SKILL.md
      .ai/architecture/ai-infrastructure-restructuring.md
    status: ACTIVATED
```

TRACE should describe observable execution facts. It should not expose hidden reasoning.

For an operation-level TRACE, the presentation may also contain:

```text
OPERATION READS
  files:
    <additional unique repository files actually read>
```

ACTIVATE owners are not repeated under OPERATION READS.

## ACTIVATE + TRACE

The user can request both together:

> Сначала активируй контекст и покажи TRACE.

The resulting interaction is conceptually:

```text
user request
    ↓
ACTIVATE
    ↓
canonical owners reread
    ↓
TRACE
    ↓
actual operation
```

## Natural-language examples

The user does not need a special command syntax. Examples:

- «Активируй контекст для этой операции.»
- «Сделай REFRESH текущего context.»
- «Покажи TRACE последнего ACTIVATE.»
- «REFRESH и покажи TRACE.»
- «Давай сначала перечитаем актуальные canonical owners, прежде чем продолжать работу. Покажи, что именно активировалось.»

These requests should be interpreted through the existing activation semantics rather than through a new command registry.

## Practical rule of thumb

When the user says **ACTIVATE**, the AI should understand it as:

> перечитай актуальные canonical owners, необходимые для текущей операции.

When the user says **REFRESH**, the AI should understand it as:

> повтори ACTIVATE, потому что текущий context нужно перечитать заново.

When the user says **TRACE**, the AI should understand it as:

> покажи наблюдаемое evidence выполнения ACTIVATE.

The core model remains:

```text
ACTIVATE = перечитай актуальные canonical owners
REFRESH  = повтори ACTIVATE
TRACE    = покажи evidence того, что ACTIVATE действительно выполнен
```
