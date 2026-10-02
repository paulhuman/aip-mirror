---
name: activation
description: Establish the canonical operational context required before executing an operation by rereading its current canonical owners.
---

# Activation

Use this skill to establish an operation's current canonical context before execution.

## Input

- the operation being prepared for execution;
- the canonical owner files required for that operation;
- optional invocation context when the entry point affects the required owners.

The activation context is supplied by the caller. This skill does not create a dependency graph or persistent owner registry.

## Procedure

For each required canonical owner:

1. Read the current repository version.
2. Treat that version as authoritative for the operation.
3. Establish the reread owner set as the active operational context.

Do not substitute remembered content for the current repository version.

## Output

Activation is complete when the required canonical owners have been reread and the operational context is established.

    ACTIVATED

This skill does not execute the operation, mutate repository state, perform lifecycle transitions, create commits, or verify mutation or commit results.

Repository, project, lifecycle, commit, mutation, and verification semantics remain with their canonical owners.

## REFRESH

REFRESH is an invocation mode, not a separate capability.

    REFRESH
        ↓
    ACTIVATE
        ↓
    ACTIVATED

Re-invoke ACTIVATE when the current canonical context needs to be reread.

## TRACE

For a user-facing `>>` command whose canonical routing requires ACTIVATE, operation-level TRACE MUST be visible before canonical operation execution. This requirement is centralized here and MUST NOT be repeated as separate TRACE requirements in individual command owners.

For other operations, TRACE MAY be made visible when useful for reasoning or review.

The visible operation-level TRACE MUST use this structure:

    TRACE
      operation: <operation>

      ACTIVATE
        owners:
          <canonical owners reread>
        status: ACTIVATED

      OPERATION READS
        files:
          <additional unique repository files actually read>

This trace is observable execution evidence, not a persistent repository schema or repository state.

`OPERATION READS` is REQUIRED for a user-facing `>>` command whose canonical routing requires ACTIVATE. For other operations it MAY be omitted.

`OPERATION READS` contains the unique repository files actually read as part of the operation. ACTIVATE owners are also members of that read set when they were read as part of the operation, but are omitted from the OPERATION READS presentation to avoid duplication.

The operation-level TRACE MUST be emitted before the canonical operation begins. If the operation aborts or fails after ACTIVATE, the TRACE MUST still show the activation and the OPERATION READS accumulated up to that point.

Human-readable TRACE output MUST deduplicate files even when a file is reread during the same operation.

The operation ends when all work required to produce and, where applicable, verify the requested substantive result is complete.

A repository read made only to report an already-completed result is not part of the operation. A read still required to complete or verify the result is part of the operation.

## Manual invocation

Users MAY request ACTIVATE, REFRESH, or TRACE directly in natural language. These are not separate commands or capabilities.

Examples:

- “Activate the context for this operation.”
- “Refresh the current activation context.”
- “Show the TRACE for ACTIVATE.”
- “REFRESH and show TRACE.”
- “Reread the current canonical owners before we continue and show what was activated.”

When ACTIVATE is requested manually, identify the current operation and reread the canonical owners required for that operation. When REFRESH is requested, repeat ACTIVATE. When TRACE is requested, present observable activation evidence without exposing hidden reasoning.

See `.ai/architecture/faq/manual-activation.md` for practical examples and usage guidance.

## Boundary

    INDEX / caller
        ↓
    ACTIVATE
        ↓
    canonical owner
        ↓
    operation
