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

When useful for reasoning or review, activation MAY be made observable with:

    ACTIVATE
      operation: <operation>
      owners: <canonical owners reread>
      status: ACTIVATED

This trace is evidence of activation, not a persistent schema or repository state.

## Boundary

    INDEX / caller
        ↓
    ACTIVATE
        ↓
    canonical owner
        ↓
    operation
