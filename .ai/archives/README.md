# AI infrastructure archives

This directory contains historical AI-infrastructure material that is no longer part of the active working context.

## Purpose

Archives preserve useful historical evidence for:

- recovery;
- audit;
- understanding why an older structure or decision existed;
- explicitly requested historical research.

Archived material is not an active semantic owner and is not a permanent source of truth.

## Active-context boundary

`.ai/archives/` MUST NOT be loaded as active infrastructure context by default.

In particular, the `>>ai-infrastructure` operation reads this README to establish the archive boundary, but does not automatically ingest the contents of `.ai/archives/`.

Historical material MAY be read when a specific operation explicitly requires it. Such a read is an exceptional historical-context action, not a change to the active infrastructure boundary.

## Lifecycle

Archive storage is disposable historical memory:

1. completed or obsolete material MAY be moved here;
2. historical material MAY remain available for recovery or audit;
3. useful decisions SHOULD be represented by the appropriate active semantic owner or durable architecture documentation;
4. archived material MAY eventually be deleted when it no longer provides useful evidence.

The archive therefore does not need to remain complete forever. The active repository state MUST remain understandable without routine archive loading.

## Ownership boundary

This README is orientation and lifecycle guidance. It is not a replacement for the canonical rule, skill, workflow, or other owner governing the material being archived.

When historical evidence is needed, prefer the current active owner first and use the archive only to answer a bounded historical question.
