# Conversation Handoff

**Conversation:**
C0072 — Architecture & Research

**Specialization:**
C

**Chapter:**
0072

**Previous chapter:**
0071

## Starting objective

Continue the Architecture & Research track from the completed C0071 provenance/language design checkpoint.

C0071 established the draft architecture for a separate, project-independent personal Developer Knowledge Repository and refined the universal provenance model plus the Russian explanatory-language / English canonical-terminology policy. Preserve these boundaries unless new repository evidence requires a change.

## C0072 current objective

Continue designing the Developer Knowledge Archive before implementing the external repository or future `knowledge-capture` skill.

The next bounded work should turn the draft architecture into a concrete minimum model using realistic fixtures, while keeping the knowledge repository independent from the current AIP Mirror project.

## Known starting implementation state

- Repository: `paulhuman/aip-mirror`
- Canonical branch: `main`
- Current chapter: C0072
- Previous chapter: C0071
- Specialization: C
- Short name: Architecture & Research
- Derived chapter identifier: C0072
- Canonical bootstrap workflow: `.ai/workflows/handoff/BOOTSTRAP.md`
- Repository write capability is available through the connected GitHub interface.
- C0069 Agentic AI Compatibility Phase 2 is complete with Final Gate 2 = PASS.
- C0070 implementation and validation of AI-infrastructure context mode are complete.
- C0071 bounded provenance/language design work is complete.
- The current repository version of canonical owners MUST be reread before relying on remembered wording or procedure.

## C0071 durable checkpoint

### Developer Knowledge Archive architecture

A draft architecture note exists:

- `.ai/docs/architecture/developer-knowledge-archive.md`

The proposed external repository is human-facing reusable knowledge, not another copy of `.ai/`.

```
Current project .ai/
    = how AI works with the project and its infrastructure

Developer Knowledge Repository
    = what the human learner wants to understand and remember
```

The repository is intended to be independent of the project where knowledge was discovered. Technology/domain is the leading taxonomy hypothesis; project and conversation are provenance.

### Educational target

The central design principle is:

> **Do not preserve snippets merely because they are useful. Preserve understanding that makes the snippet reproducible.**

Candidate knowledge types include:

- concepts;
- procedures;
- mental models;
- recipes;
- troubleshooting;
- reference/comparison.

Entries should explain what, how, and why; identify assumptions, gotchas, verification steps, alternatives, version sensitivity, and provenance where relevant.

### Provenance model

The current universal, source-oriented model is:

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

Important decisions:

- `kind` is the primary discriminator.
- `chapter` is NOT mandatory.
- `chapter` may eventually be removed entirely; its long-term retention remains OPEN.
- Provenance must work for sources with no project or chapter, including agentic AI, official documentation, personal experiments, and external articles.
- Source project/chapter are provenance metadata, not semantic ownership.
- One knowledge entry may have multiple provenance sources.

### Educational language policy

The future knowledge repository uses:

> **Russian is the explanatory language; English is the canonical vocabulary of professional terminology.**

Normative wording:

> **Учебные материалы пишутся на русском языке. Названия сущностей, профессиональная терминология, имена технологий, команд, API, параметров и устойчивые технические выражения сохраняются на English.**

This is an architectural rule for the future repository, not merely a formatting preference. It does not require every sentence to be English.

### Real-world fixtures

Two real source examples are retained as design fixtures:

1. Git branch cleanup:
   `git branch --format='%(refname:short)' | Where-Object { $_ -ne 'main' } | ForEach-Object { git branch -D $_ }`
   
   The future entry should teach the underlying Git and PowerShell concepts rather than merely preserve the command.

2. DSH Desktop / Harness / dshmarket material from Grok.
   
   This is source material requiring independent verification before permanent capture. Claims about exact version relationships, Desktop/Harness ownership, plugin semantics, and version-specific behavior must not be promoted to confirmed knowledge without evidence.

### Proposed future capability

A provisional future skill is `knowledge-capture`.

It should eventually:

1. classify the topic/domain;
2. determine the knowledge type;
3. check for an existing related entry;
4. identify claims requiring verification;
5. normalize material into an educational structure;
6. capture provenance and version context;
7. write/update the configured knowledge repository;
8. verify the resulting change.

The existing `.ai/skills/explain-code/SKILL.md` remains a teaching capability and should not be repurposed as the storage/capture owner.

### Configuration boundary

The external knowledge repository location should be configured in `.ai/config.yaml`, not hard-coded inside the future skill.

The exact configuration key and repository name remain open.

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

- `.ai/handoffs/C/C0071-Architecture-&-Research.md`

## Confirmed

- C0070 is complete for its planned implementation and validation scope.
- `>>ai-infrastructure` automatically activates normative-language as a dependency without absorbing its semantic ownership.
- Archive contents remain outside the normal elevated AI-infrastructure context.
- The project-specific documentation boundary remains `docs/`.
- C0071 bounded provenance/language design work is complete.
- `.ai/docs/architecture/developer-knowledge-archive.md` exists as the current draft architecture note.
- The external knowledge repository is intended to be project-independent.
- The future capture capability and existing `explain-code` capability have distinct responsibilities.
- Provenance uses a universal source-oriented model with `kind` as the primary semantic discriminator; `agent`, `project`, and `chapter` are contextual fields as applicable.
- `provenance.chapter` is optional and may be removed later.
- The future knowledge repository uses Russian as its explanatory language and English as the canonical vocabulary for professional terminology and technical identifiers.

## Inferred

- A dedicated `knowledge-capture` skill is preferable to expanding `explain-code` into a storage workflow.
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
- The final decision on `provenance.chapter` has not yet been made.

## Open

- Select the final conceptual and repository name.
- Design one ideal knowledge entry in detail.
- Use the Git branch cleanup and Grok DSH examples as realistic design fixtures.
- Derive the minimum metadata schema, including the final decision on `provenance.chapter`.
- Refine the taxonomy from real entries rather than precreating a large directory tree.
- Define the capture workflow and final `knowledge-capture` skill contract.
- Decide the exact `.ai/config.yaml` repository reference.
- Determine how duplicate/overlapping knowledge entries are detected.
- Determine how cross-topic and related-concept links are represented.
- Determine the validation and write-safety workflow for the external repository.

## Immediate next task

Continue the architecture design in C0072 before implementing the new repository or skill.

Recommended first bounded task:

1. design one ideal knowledge entry in concrete detail;
2. test that design against the Git branch cleanup and Grok DSH fixtures;
3. derive the minimum metadata/front-matter model;
4. make the explicit final decision on whether `provenance.chapter` survives as an optional field or is removed;
5. use the resulting model to refine the minimum `knowledge-capture` skill contract.

Do not start Agentic AI Compatibility Phase 3 unless the user explicitly reopens it.

## Recommended starting context

Start with this handoff, `.ai/docs/architecture/developer-knowledge-archive.md`, the current `.ai/workflows/handoff/BOOTSTRAP.md`, the active canonical owners, and the C0071 checkpoint. Treat C0070 and C0071 as completed baseline state and keep `.ai/archives/**` outside active elevated context.
