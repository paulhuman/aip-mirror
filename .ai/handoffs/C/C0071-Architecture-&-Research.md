# Conversation Handoff

**Conversation:**
C0071 — Architecture & Research

**Specialization:**
C

**Chapter:**
0071

**Previous chapter:**
0070

## Starting objective

Continue the Architecture & Research track from the completed C0070 context-mode implementation and validation checkpoint.

C0070 established and validated the `>>ai-infrastructure` context mode, including automatic normative-language dependency activation and explicit exclusion of `.ai/archives/**` from elevated active context. Preserve these boundaries unless new repository evidence requires a change.

## C0071 current objective

Design the architecture for a separate, project-independent personal developer knowledge repository: an educational archive for reusable technical understanding captured from real development work and AI-assisted conversations.

The user explicitly wants to preserve explanations, not merely copy/paste snippets. The proposed system should support knowledge across Git, PowerShell, DeepSeek Harness, Python, C++, CMake, Windows, and future technologies without making the current project repository the owner of that knowledge.

A new durable architecture note was created:

- `.ai/docs/architecture/developer-knowledge-archive.md`

This note is the current design starting point. It is intentionally a draft architecture design, not yet an active semantic owner or implemented workflow.

## Known starting implementation state

- Repository: `paulhuman/aip-mirror`
- Canonical branch: `main`
- Current chapter: C0071
- Previous chapter: C0070
- Specialization: C
- Short name: Architecture & Research
- Derived chapter identifier: C0071
- Canonical bootstrap workflow: `.ai/workflows/handoff/BOOTSTRAP.md`
- Repository write capability is available through the connected GitHub interface.
- C0069 Agentic AI Compatibility Phase 2 is complete with Final Gate 2 = PASS.
- C0070 implementation and validation of AI-infrastructure context mode are complete.
- The current repository version of all canonical owners MUST be reread before relying on remembered wording or procedure.

## C0070 durable checkpoint

Confirmed from the predecessor handoff:

### AI-infrastructure context mode

- `.ai/` is a portable, project-agnostic AI-infrastructure layer.
- `.ai/docs/` documents the AI-infrastructure; `docs/` documents project-specific knowledge.
- `.ai/archives/` is historical memory and MUST NOT be loaded automatically by `>>ai-infrastructure`.
- `>>ai-infrastructure` is a domain/context switch into AI-infrastructure work.
- `>>ai-infrastructure` MUST activate normative-language as a dependency.
- `.ai/rules/normative-language.md` remains the canonical semantic owner of normative-language semantics.
- The runtime/activation contract was verified at repository level: normative-language owners are reread and archive contents are excluded; only `.ai/archives/README.md` establishes the archive boundary.

### Repository correction

- `.ai/README.md` uses project-agnostic wording for the `.ai/` versus `docs/` boundary.
- `.ai/rules/normative-language.md` uses the current `.ai/archives/**` archive path in its scope exception.

## New architecture direction

### Separation of concerns

The proposed external repository is human-facing reusable knowledge, not another copy of `.ai/`.

```
Current project .ai/
    = how AI works with the project and its infrastructure

Developer Knowledge Repository
    = what the human learner wants to understand and remember
```

The repository should be independent of the project where a piece of knowledge was discovered.

### Educational target

The central design principle is:

> Do not preserve snippets merely because they are useful. Preserve understanding that makes the snippet reproducible.

The proposed knowledge model includes, at minimum:

- concepts;
- procedures;
- mental models;
- recipes;
- troubleshooting;
- reference/comparison material.

Entries should explain what, how, and why; identify assumptions, gotchas, verification steps, alternatives, version sensitivity, and provenance where relevant.

### Proposed future capability

A provisional new skill name is `knowledge-capture`.

It should eventually transform useful source material into durable educational entries by:

1. classifying the topic/domain;
2. determining the knowledge type;
3. checking for an existing related entry;
4. identifying claims that require verification;
5. normalizing the material into a consistent educational structure;
6. capturing provenance and version context;
7. writing/updating the configured knowledge repository;
8. verifying the resulting change.

The existing `.ai/skills/explain-code` remains a teaching capability and should not be repurposed as the storage/capture owner.

### Configuration boundary

The external knowledge repository location should be configured in `.ai/config.yaml`, rather than hard-coded inside the future skill.

The exact configuration key and repository name remain open.

### Provenance model

C0071 refined provenance into a universal, source-oriented model:

```yaml
provenance:
  kind: ai-conversation
  agent: ChatGPT
  project: aip-mirror
  chapter: C0071
```

Semantic roles:

- `kind` → semantic source category;
- `agent` → who or what provided the material, when applicable;
- `project` → where the material originated, when applicable;
- `chapter` → optional project-local context, when applicable.

Important architectural decisions:

- `kind` is the primary discriminator.
- `chapter` is NOT mandatory.
- `chapter` may eventually be removed entirely; its long-term retention remains OPEN.
- Provenance must work for sources that have no project or chapter, including agentic AI, official documentation, personal experiments, and external articles.
- Source project/chapter are provenance metadata, not semantic ownership.
- One knowledge entry may have multiple provenance sources.

### Educational language policy

C0071 also established the intended language model for the future knowledge repository:

> **Russian is the explanatory language; English is the canonical vocabulary of professional terminology.**

The normative wording is:

> **Учебные материалы пишутся на русском языке. Названия сущностей, профессиональная терминология, имена технологий, команд, API, параметров и устойчивые технические выражения сохраняются на English.**

Professional terms should not be translated merely for translation's sake. Canonical English terminology should be retained and explained in Russian when useful. This does not require English everywhere; natural Russian remains appropriate in ordinary explanatory phrasing.

The language policy is an architectural rule for the future repository, not merely a formatting preference.

## Real-world source example

The user supplied a real answer from Grok about maintaining DSH Desktop / Harness / dshmarket on Windows.

The material is a useful candidate for a future knowledge entry because it contains:

- version inspection commands;
- `DSH_HOME` usage;
- Desktop versus CLI distinction;
- profile/plugin relationships;
- upgrade procedure;
- maintenance checklist;
- a system diagram.

However, the answer MUST be treated as source material rather than unquestioned authority. Claims about exact Desktop/Harness version relationships, update ownership, plugin semantics, and version-specific behavior should be verified before being marked as confirmed knowledge.

This example is important to the architecture because it demonstrates the intended capture workflow:

```
external AI answer
    ↓
useful educational material
    ↓
fact/version verification
    ↓
correction or enrichment
    ↓
normalized learning entry
    ↓
developer knowledge repository
```

The future system should be able to preserve the useful explanation while correcting errors, adding alternatives, and distinguishing confirmed facts from assumptions.

## Relevant files and references

### Canonical infrastructure owners

- `.ai/config.yaml`
- `.ai/AGENTS.md`
- `.ai/INDEX.md`
- `.ai/rules/repository.md`
- `.ai/rules/workflow.md`
- `.ai/rules/handoff/lifecycle.md`
- `.ai/rules/handoff/references.md`
- `.ai/rules/commits.md`
- `.ai/skills/activation/SKILL.md`
- `.ai/skills/handoff/SKILL.md`
- `.ai/workflows/handoff/BOOTSTRAP.md`
- `.ai/handoffs/README.md`
- `.ai/docs/architecture/README.md`

### Current architecture context

- `.ai/docs/architecture/ai-infrastructure-context-mode.md`
- `.ai/docs/architecture/agentic-ai-compatibility-architecture.md`
- `.ai/docs/architecture/agentic-ai-environment-survey.md`
- `.ai/docs/architecture/agentic-ai-owner-seam-audit.md`
- `.ai/docs/architecture/agentic-ai-compatibility-boundaries.md`
- `.ai/docs/architecture/agentic-ai-compatibility-capability-audit.md`
- `.ai/docs/architecture/developer-knowledge-archive.md`

### Relevant existing skill

- `.ai/skills/explain-code/SKILL.md`

### Predecessor

- `.ai/handoffs/C/C0070-Architecture-&-Research.md`

## Confirmed

- C0070 is complete for its planned implementation and validation scope.
- `>>ai-infrastructure` automatically activates normative-language as a dependency without absorbing its semantic ownership.
- Archive contents remain outside the normal elevated AI-infrastructure context.
- The project-specific documentation boundary remains `docs/`.
- C0071 is now explicitly focused on Developer Knowledge Archive architecture.
- `.ai/docs/architecture/developer-knowledge-archive.md` exists as a draft architecture note describing the proposed system.
- The external knowledge repository is intended to be project-independent.
- The future capture capability and the existing `explain-code` capability have distinct responsibilities.
- Provenance uses a universal source-oriented model with `kind` as the primary semantic discriminator; `agent`, `project`, and `chapter` are contextual fields as applicable.
- `provenance.chapter` is optional and may be removed later; a chapter is not a universal provenance requirement.
- The future knowledge repository uses Russian as its explanatory language and English as the canonical vocabulary for professional terminology and technical identifiers.

## Inferred

- A dedicated knowledge-capture skill is preferable to expanding `explain-code` into a storage workflow.
- Technology/domain should generally be the primary taxonomy, while project and conversation are provenance.
- External AI answers should be treated as source material requiring verification rather than as authoritative knowledge.
- The knowledge repository should prioritize learner understanding and mental models over snippet accumulation.
- Repository location belongs in configuration, while capture behavior belongs in the skill.
- A universal provenance model is more durable than a chapter-centric model because not all future sources will belong to an AIP Mirror chapter.
- The Russian explanatory layer plus canonical English terminology should reduce learning friction without disconnecting the learner from real technical documentation, CLI, IDE, and source-code vocabulary.

## Assumed / unverified

- Final repository name is not selected.
- Exact repository structure is not selected.
- Exact metadata/front-matter schema is not selected.
- Exact verification-state vocabulary is not selected.
- Exact command/interaction name (`>>capture`, `>>learn`, etc.) is not selected.
- It is not yet decided whether the external knowledge repository needs its own lightweight `.ai` infrastructure.
- The supplied Grok DSH material has not yet been independently fact-checked or converted into a final learning entry.

## Open

- Select the final conceptual and repository name.
- Refine the taxonomy using realistic entries rather than precreating a large directory tree.
- Define the canonical knowledge-entry schema.
- Define the final provenance metadata schema; specifically decide whether `provenance.chapter` survives as an optional field or is removed.
- Define the capture workflow and future `knowledge-capture` skill contract.
- Decide the exact `.ai/config.yaml` repository reference.
- Determine how duplicate/overlapping knowledge entries are detected.
- Determine how cross-topic and related-concept links are represented.
- Determine the validation and write-safety workflow for the external repository.
- Later, use the Grok DSH example and the Git branch cleanup example as concrete design fixtures.

## C0071 final checkpoint

The bounded C0071 provenance/language design task is complete.

Implemented in `.ai/docs/architecture/developer-knowledge-archive.md`:

- universal provenance model with `kind` as the primary semantic source discriminator;
- optional contextual fields for `agent`, `project`, and `chapter`;
- explicit recognition that `chapter` may be removed later;
- support for sources without a project-local chapter, including agentic AI;
- formal Russian explanatory-language / English canonical-terminology policy;
- clarification that English terminology is canonical vocabulary, not a requirement to write every sentence in English.

Verified repository commit:

`0a755a8fb16b3464840a2ae11a4af9e645e4f232`

## Immediate next task

Continue the architecture design in the receiving chapter before implementing the new repository or skill.

Recommended next bounded work:

1. settle the repository concept/name;
2. design one ideal knowledge entry in detail;
3. use the Git branch cleanup and Grok DSH examples as fixtures;
4. derive the minimum metadata schema, including the final decision on `provenance.chapter`;
5. derive the minimum `knowledge-capture` skill contract;
6. only then decide the initial external repository skeleton and `.ai/config.yaml` integration.

Do not start Agentic AI Compatibility Phase 3 unless the user explicitly reopens it.

## Recommended starting context

Start with this handoff, `.ai/docs/architecture/developer-knowledge-archive.md`, the current `.ai/workflows/handoff/BOOTSTRAP.md`, the active canonical owners, and the C0070 checkpoint. Treat C0070 implementation and validation as completed baseline state and keep `.ai/archives/**` outside active elevated context.
