# AI-infrastructure context mode and active/archive boundary

## Purpose

This note records the architectural direction agreed at the end of C0069 for making the repository's AI-infrastructure easier for both humans and AI environments to understand.

The immediate motivation is contextual: ordinary chapter bootstrap intentionally reads only the canonical initialization context. That is sufficient for project work, but it does not automatically provide enough orientation when the task itself concerns the AI-infrastructure.

The proposed response is a dedicated operation:

    >>ai-infrastructure

Its purpose is not merely to load more files. It switches the AI's working domain from project-specific implementation to the repository's AI-infrastructure itself and loads a deliberately broader infrastructure context.

## 1. `.ai/` as a portable AI-infrastructure layer

`.ai/` is intended to be a reusable AI-infrastructure layer that lives inside a software project repository.

It is not specific to AIP Mirror or to Adobe Illustrator. The same architectural role SHOULD remain applicable to applications, plugins and extensions, websites, libraries, services, tooling, and other software projects.

The project-specific meaning belongs primarily to `docs/` and the project source tree. The generic AI working system belongs in `.ai/`.

This boundary is important because an AI working on the project can otherwise mistake `.ai/docs/` for ordinary project documentation and move infrastructure documentation into `docs/`.

The intended distinction is:

    .ai/
        = how AI-assisted work is organized, constrained, routed, continued,
          verified, and documented

    docs/
        = how this particular project is designed, implemented,
          instructed, and documented

## 2. Root `.ai/README.md`

A root `.ai/README.md` now serves as the human- and AI-readable orientation document for the entire `.ai/` layer.

It SHOULD explain that `.ai/` is the project's reusable AI-infrastructure; that the infrastructure is project-agnostic in architectural intent; that it is not application source code; the semantic roles of the major `.ai/` subdirectories; the boundary between `.ai/` and project-specific `docs/`; the distinction between active infrastructure and historical archives; and that canonical semantic ownership remains in rules, skills, workflows, and other explicitly defined owners rather than in README files or architecture notes.

The root README is an orientation document, not a replacement for `.ai/INDEX.md`, `.ai/AGENTS.md`, or any canonical rule/skill/workflow.

## 3. `.ai/archive` → `.ai/archives`

The legacy `.ai/archive/` directory has been renamed to `.ai/archives/`.

`archives` is the clearer plural because the directory contains multiple historical collections, including archived architecture documentation and historical handoffs.

The renamed contents remain organized as historical material under `.ai/archives/docs/architecture/` and `.ai/archives/handoffs/`.

The rename is a taxonomy correction, not a change in semantic ownership.

## 4. Archives are disposable historical storage

`.ai/archives/` is not active AI-infrastructure context.

An AI working in normal project mode MUST NOT treat the archive as part of the active context by default.

The archive exists more like a controlled historical wastebasket than a permanent museum:

- completed or obsolete material can be moved there;
- historical material can remain available for recovery or audit when explicitly needed;
- old material MAY eventually be deleted when it no longer provides useful evidence;
- the archive is therefore not an eternal source of truth.

The active repository state MUST remain understandable without routine archive loading.

A dedicated `.ai/archives/README.md` SHOULD explain this lifecycle and MUST make clear that archived material is historical, non-active, and subject to eventual cleanup.

## 5. Archive README and `>>ai-infrastructure`

Although archive contents themselves are excluded from the elevated context, `.ai/archives/README.md` SHOULD be included in `>>ai-infrastructure`.

This gives the AI the archive boundary without loading the archive contents.

The intended behavior is therefore:

    >>ai-infrastructure
        ↓
    read active AI-infrastructure orientation
        ↓
    read archive boundary README
        ↓
    DO NOT load archive contents unless explicitly required

This preserves awareness without allowing historical material to pollute the active architectural context.

## 6. `>>ai-infrastructure` operation

The `>>ai-infrastructure` command is implemented as a context-loading and domain-switching operation through `.ai/INDEX.md` and `.ai/skills/ai-infrastructure/SKILL.md`.

Its semantic meaning is:

> Switch the AI's working domain to the repository's AI-infrastructure rather than project-specific implementation, and load elevated infrastructure context before proceeding.

The operation establishes at least:

### Normative-language activation

Because the elevated mode operates directly on active `.ai` infrastructure, `>>ai-infrastructure` MUST activate the normative-language capability as a required dependency. This does not create a second semantic owner: `.ai/rules/normative-language.md` remains the canonical owner of normative-language semantics.

### Repository-level orientation

- root `README.md`;
- `docs/PROJECT-INSTRUCTIONS.md`.

### AI-infrastructure orientation

- `.ai/README.md`;
- all active `.ai/**/README.md` files that define the structure of active infrastructure;
- `.ai/AGENTS.md`;
- `.ai/INDEX.md`;
- `.ai/config.yaml`;
- `.ai/skills/normative-language/SKILL.md`;
- `.ai/rules/normative-language.md`.

### Active infrastructure semantics

The operation SHOULD quickly survey `.ai/docs/` so the AI knows what durable architecture, FAQ, and other infrastructure documentation exists.

It SHOULD NOT automatically ingest every large document in full. The purpose is elevated orientation and correct domain selection; deeper documents can then be read when relevant.

### Archive boundary

- `.ai/archives/README.md` SHOULD be read;
- `.ai/archives/**` contents SHOULD NOT be loaded as part of the normal operation.

The operation is therefore intentionally broader than ordinary bootstrap but narrower than indiscriminate repository ingestion.

## 7. Why this is a separate operation

Ordinary chapter bootstrap and AI-infrastructure mode have different purposes.

Bootstrap establishes:

    who am I?
    which chapter?
    what predecessor state?
    which canonical initialization owners?
    what must be done to start this conversation safely?

`>>ai-infrastructure` establishes:

    what is this AI-infrastructure?
    what are its boundaries?
    what are its active semantic owners?
    what infrastructure documentation exists?
    what is project-specific and what is infrastructure-level?
    how should I reason about changes to `.ai/` itself?

The second operation therefore SHOULD NOT be implemented by silently expanding every ordinary bootstrap.

That would make every project task pay the context cost of the entire AI-infrastructure and would blur the initialization boundary.

## 8. Relationship to Agentic AI compatibility work

This context-mode proposal is independent of the Phase 3 Agentic AI compatibility track, but it provides a useful infrastructure capability for that work.

The two current research directions are:

### Track A — Agentic AI adaptation

Continue from the completed C0069 Phase 2 result:

    environment transport
        →
    invocation/context adapter
        →
    existing AIP Mirror semantic owner
        →
    environment execution capability
        →
    transport-neutral evidence
        →
    environment-native presentation

Phase 3 SHOULD specify the minimal adapter/conformance contract without introducing a second semantic registry or speculative `.ai/interfaces/` layer.

### Track B — AI-infrastructure orientation

The minimal infrastructure-context operation `>>ai-infrastructure` is implemented with `.ai/README.md`, active README discovery, root project README awareness, `docs/PROJECT-INSTRUCTIONS.md` awareness, `.ai/docs/` orientation, `.ai/archives/README.md` archive-boundary awareness, and explicit exclusion of archive contents from normal elevated context.

The two tracks MAY be developed independently and SHOULD NOT be conflated.

## 9. Minimality principle

The new operation SHOULD remain a thin context-loading capability. Required normative-language activation is part of that context contract, not a separate routing layer.

It SHOULD NOT create:

- a second routing registry;
- a second semantic owner for `.ai/`;
- duplicated project instructions;
- an `.ai/interfaces/` namespace merely for this operation;
- a permanent requirement to read every architecture document in full;
- a requirement to read historical archives as active context.

The semantic ownership model already established by the existing `.ai` architecture remains authoritative.

## 10. Migration and implementation sequence

The implementation sequence has now reached the validation stage:

1. **COMPLETE** — add `.ai/README.md`;
2. **COMPLETE** — rename `.ai/archive/` to `.ai/archives/`;
3. **COMPLETE** — add `.ai/archives/README.md`;
4. **COMPLETE** — update active archive-path references;
5. **COMPLETE** — define `.ai/skills/ai-infrastructure/SKILL.md` and route `>>ai-infrastructure` through `.ai/INDEX.md`;
6. **COMPLETE** — define the elevated-context read set, normative-language activation, and explicit archive exclusion;
7. **COMPLETE** — update relevant README and architecture references;
8. **VALIDATED** — ordinary bootstrap contains no archive-context expansion and retains its intended initialization workflow;
9. **VALIDATED** — `>>ai-infrastructure` routing, activation owners, elevated-context reads, and explicit archive exclusion were executed and inspected;
10. **COMPLETE** — this architecture note remains the durable record of the implementation and validation result.

The current chapter remains the owner of this implementation checkpoint.

## 11. Validation result

The C0070 implementation check confirms:

- `.ai/README.md` exists as the active root AI-infrastructure orientation document.
- `.ai/archive/` no longer exists; historical material is under `.ai/archives/`.
- `.ai/archives/README.md` exists and defines the archive as historical, non-active, disposable context.
- `.ai/skills/ai-infrastructure/SKILL.md` is the canonical skill for the new context mode.
- `.ai/INDEX.md` routes `>>ai-infrastructure` to that skill and lists the activation owners.
- The elevated read set includes repository orientation, active AI-infrastructure orientation, active README discovery, `.ai/docs/` survey, and `.ai/archives/README.md`.
- Archive contents were not loaded during the operation.
- The current `.ai/workflows/handoff/BOOTSTRAP.md` contains no archive-path reference and does not expand ordinary bootstrap into archive loading.

The operation therefore satisfies the intended minimality boundary: it adds a thin domain/context-loading capability without introducing a second semantic registry, a second owner for `.ai/`, or automatic historical-context loading.
## 11. Architectural intent

The intended long-term model is:

    ordinary project work
        →
    ordinary bootstrap / relevant canonical owners
        →
    project-specific task

    AI-infrastructure work
        →
    >>ai-infrastructure
        →
    elevated AI-infrastructure context
        →
    .ai/ semantic owners
        →
    infrastructure change / research / verification

This is a domain switch, not merely a larger context window.

## Chapter continuity

The current durable chapter checkpoint is:

`.ai/handoffs/C/C0070-Architecture-&-Research.md`

Future chapters continuing this work SHOULD read that handoff first and then this architecture note.

## Current owner-path addendum (2026-10-09)

The C0070 implementation and validation statements above are a historical snapshot of the repository before the approved rules-to-skills migration. Their old paths are retained as evidence of the state inspected at that time; they are not current routing instructions.

The current canonical owners for this context mode are:

- Repository identity, path resolution, boundaries, and mutation safety: `.ai/skills/repository/SKILL.md`.
- General development workflow: `.ai/skills/workflow/SKILL.md`.
- Normative-language semantics and normalization: `.ai/skills/normative-language/SKILL.md`.
- AI-infrastructure context mode: `.ai/skills/ai-infrastructure/SKILL.md`.
- Receiving-chapter bootstrap: explicitly invoked, nested `.ai/conversation-management/handoff/BOOTSTRAP.md`.

This addendum records current routing only. It does not turn this architecture note into an operational owner or require normal context loading to ingest the historical validation material above.
