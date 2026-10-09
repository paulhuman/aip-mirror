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

1. DO read the current repository version.
2. DO treat that version as authoritative for the operation.
3. DO establish the reread owner set as the active operational context.

DO NOT substitute remembered content for the current repository version.

## Output

Activation is complete when the required canonical owners have been reread and the operational context is established.

    ACTIVATED

This skill does not execute the operation, mutate repository state, perform lifecycle transitions, create commits, or verify mutation or commit results.

Repository, project, lifecycle, commit, mutation, and verification semantics remain with their canonical owners.

## TRACE

For a user-facing `>>` command whose canonical routing requires ACTIVATE, operation-level TRACE MUST be inserted into the assistant response after the canonical operation is complete. This requirement is centralized here and MUST NOT be repeated as separate TRACE requirements in individual command owners.

For other operations, TRACE MAY be presented when useful for reasoning or review.

### TRACE presentation contract

TRACE is a response template, not a repository artifact or a separate operation.

TRACE is visible when the completed TRACE block is inserted into the assistant response content delivered to the user.

> TRACE = user-visible execution evidence inserted into the assistant response.

The operation-level TRACE MUST use this canonical response template:

    TRACE
      operation: <operation>

      ACTIVATE
        owners:
          <canonical owners reread>
        status: ACTIVATED

      OPERATION READS
        files:
          <additional unique repository files actually read>

The canonical TRACE response SHOULD be presented as a compact fenced monospace block in the assistant response.

The presentation contract is:

1. Execute the operation.
2. Accumulate the actual read set.
3. Assemble the TRACE using the canonical template.
4. Insert the completed TRACE into the assistant response.

`OPERATION READS` is REQUIRED for a user-facing `>>` command whose canonical routing requires ACTIVATE. For other operations it MAY be omitted.

`OPERATION READS` contains the unique repository files actually read as part of the operation. ACTIVATE owners are also members of that read set when they were read as part of the operation, but are omitted from the OPERATION READS presentation to avoid duplication.

The completed operation-level TRACE MUST be inserted into the assistant response after the operation ends. If the operation aborts or fails after ACTIVATE, insert a TRACE into the assistant response showing the activation and the OPERATION READS accumulated up to the failure point.

Human-readable TRACE output MUST deduplicate files even when a file is reread during the same operation.

The operation ends when all work required to produce and, where applicable, verify the requested substantive result is complete.

A repository read made only to report an already-completed result is not part of the operation. A read still required to complete or verify the result is part of the operation.

## Manual invocation

Users MAY request ACTIVATE or TRACE directly in natural language. These are not separate commands.

Examples:

- “Activate the context for this operation.”
- “Show the TRACE for ACTIVATE.”
- “Reread the current canonical owners before we continue and show what was activated.”

When ACTIVATE is requested manually, DO identify the current operation and reread the canonical owners required for that operation. When TRACE is requested, DO present observable activation evidence without exposing hidden reasoning.

See `.ai/docs/faq/manual-activation.md` for practical examples and usage guidance.

## Boundary

    INDEX / caller
        ↓
    ACTIVATE
        ↓
    canonical owner
        ↓
    operation
