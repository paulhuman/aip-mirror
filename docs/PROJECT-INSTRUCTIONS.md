# Illustrator AIP Mirror — Project Instructions

## 1. Project purpose

AIP Mirror is a native Adobe Illustrator plugin project intended to reproduce and extend the interactive mirror workflow associated with Macromedia FreeHand MX.

The project uses the same `aip-mirror` repository for all workstreams. Workstreams are organizational boundaries, not permanent ownership of all knowledge they produce.

## 2. Workstreams

The project uses multiple complementary workstreams. Here, a **workstream** is simply a project work area represented by one or more separate AI conversations. It is not an autonomous agent, service, or process that can communicate with other workstreams directly.

The user coordinates work between conversations and AI services. Cross-workstream communication therefore happens through the user and through durable repository files when the user asks an AI conversation to read or update them.

Workstreams are organizational boundaries, not permanent ownership of all knowledge they produce. Additional workstreams may exist as the project grows. Do not assume that a particular numeric specialization permanently owns a kind of project knowledge.

Each workstream may span multiple conversation chapters. Chapter identifiers use:

```text
[0-9]{2}[A-Z]{2}
```

The two-letter suffix advances continuously:

```text
AA → AB → ... → AZ → BA → ... → ZZ
```

Conversation lifecycle, chapter transitions, and handoff state are defined by:

`.ai/rules/handoff/lifecycle.md`

The handoff procedure is defined by:

`.ai/skills/handoff/SKILL.md`

The bootstrap procedure is defined by:

`.ai/workflows/handoff-bootstrap/BOOTSTRAP.md`

Do not duplicate those procedures here.

## 3. Project operating model

The intended development chain is:

```text
research
   ↓
behavioral specification
   ↓
JSX prototype
   ↓
validation
   ↓
native design
   ↓
C++ / AIP implementation
```

The JSX prototype is an executable behavioral reference, not the production architecture. Native implementation should be designed from validated behavior and project specifications rather than by mechanically translating JSX.

For substantial unfamiliar work, use the `deep-understanding` skill and record durable findings in the appropriate project documentation.

## 4. Native implementation target

The production plugin is native C++ using the Illustrator AIP SDK.

The initial native milestone should prioritize:

1. Illustrator integration;
2. interactive mouse handling;
3. responsive live preview;
4. mirror geometry;
5. object/path handling;
6. undo/cancel behavior;
7. stable plugin lifecycle.

A simple native ADM settings UI is acceptable for the first milestone. CEP, UXP, NUXP, Spectrum, or another web UI technology is not a prerequisite for the native plugin. Any later web-based UI is a separate architectural decision.

The interactive geometry loop belongs in the native tool rather than in the UI layer.

Detailed architectural boundaries belong in:

```text
docs/architecture/project-architecture.md
```

## 5. Behavioral target

The project is intended to reproduce an interactive mirror workflow, not merely provide a static reflection command.

Research and validation should establish behavior for:

- mirror-axis placement and manipulation;
- source-side behavior;
- live preview;
- object/path transformation;
- selection;
- repeated interaction;
- cancellation and confirmation;
- modifier keys;
- coordinates and snapping;
- visual feedback.

The tool must not assume that the source is always on the left. The current intended interaction also allows drawing past/across the mirror axis where appropriate.

These are project behavioral requirements to validate against the FreeHand target and the JSX prototype; unresolved behavior must not be silently treated as final.

## 6. Cross-workstream coordination

Use these principles when work crosses boundaries:

1. Workstreams are organizational boundaries, not permanent ownership of all knowledge they produce.
2. Results produced by one workstream may become inputs to another.
3. Canonical project knowledge belongs to its semantic owner, not to the workstream that happened to discover it.
4. Cross-workstream continuity must use durable repository knowledge rather than conversation history alone.

An architectural finding discovered in any workstream belongs in the appropriate project architecture/research document when it becomes durable. Do not route all architecture through a permanently privileged workstream merely because it was discovered there.

If a workstream detects a lifecycle or handoff inconsistency belonging to another workstream, it cannot notify that workstream directly. The finding must be carried through the user or recorded in a repository file for the other conversation to read. The other workstream remains responsible for correcting its own handoff.

## 7. Canonical project-source routing

Use the semantic owner rather than duplicating project knowledge:

- **Project architecture and durable architectural decisions** → `docs/architecture/`
- **Project specifications and behavioral requirements** → appropriate project specification documents under `docs/`
- **Reverse-engineering findings** → appropriate research documents under `docs/`
- **Conversation migration state** → `.ai/handoffs/`
- **AI infrastructure rules** → `.ai/rules/`
- **Reusable AI capabilities** → `.ai/skills/`
- **Ordered AI procedures** → `.ai/workflows/`

Repository identity, repository boundaries, repository taxonomy, write safety, and commit policy are defined by:

```text
.ai/rules/repository.md
.ai/rules/commits.md
```

Do not reproduce those rules here.

The canonical Adobe Illustrator SDK remains external to this repository:

```text
paulhuman/adobe-illustrator-2026-sdk
```

Use it as the SDK reference; do not copy the complete SDK into `aip-mirror`.

## 8. Scope of this document

`PROJECT-INSTRUCTIONS.md` is the thin project-specific instruction layer.

It provides:

- project orientation;
- project-specific operating constraints;
- project behavioral targets;
- workstream coordination;
- routing to canonical project knowledge.

It is not:

- a second AI infrastructure index;
- a repository rules document;
- a handoff lifecycle document;
- a complete architecture document;
- a workstream registry;
- a copy of the deep-understanding methodology.

When a rule or knowledge item has a more specific canonical owner, reference that owner instead of duplicating the content here.
