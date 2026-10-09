# Manual use of ACTIVATE and TRACE

## Why this exists

The activation skill is part of the internal `.ai` infrastructure, but a user may sometimes want to explicitly ask the AI to perform or show these functions.

The important point is that these are **not new commands**. They are natural-language requests for behavior already defined by `.ai/skills/activation/SKILL.md`.

## How to think about them

- `ACTIVATE` = перечитай актуальные canonical owners.
- `TRACE` = покажи observable execution evidence в assistant response.

The two concepts have different roles:

```text
ACTIVATE ≠ выполнение задачи
TRACE    ≠ выполнение задачи
```

ACTIVATE prepares current operational context. TRACE makes the observable execution result visible.

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
    .ai/skills/conversational-only/handoff/SKILL.md
  status: ACTIVATED
```

ACTIVATE itself does not execute the requested operation.

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
      .ai/docs/architecture/ai-infrastructure-restructuring.md
    status: ACTIVATED
```

TRACE should describe observable execution facts. It should not expose hidden reasoning. For operation-level TRACE, the completed TRACE block is inserted into the assistant response after the operation is complete.

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
actual operation
    ↓
TRACE inserted into assistant response
```

## Natural-language examples

The user does not need a special command syntax. Examples:

- «Активируй контекст для этой операции.»
- «Покажи TRACE последнего ACTIVATE.»
- «Давай сначала перечитаем актуальные canonical owners, прежде чем продолжать работу. Покажи, что именно активировалось.»

These requests should be interpreted through the existing activation semantics rather than through a new command registry.

## Practical rule of thumb

When the user says **ACTIVATE**, the AI should understand it as:

> перечитай актуальные canonical owners, необходимые для текущей операции.

When the user says **TRACE**, the AI should understand it as:

> покажи observable execution evidence в assistant response.

The core model remains:

```text
ACTIVATE = перечитай актуальные canonical owners
TRACE    = вставь observable execution evidence в assistant response
```
