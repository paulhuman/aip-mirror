# Developer Knowledge Archive — architecture design

**Status:** Draft architecture design  
**Chapter:** C0071 — Architecture & Research  
**Purpose:** Define the architecture of a separate, project-independent personal developer knowledge repository and the `.ai` capability required to capture, normalize, explain, and preserve useful technical knowledge.

## 1. Problem

During work on any project, the user frequently receives useful technical explanations, commands, procedures, troubleshooting steps, diagrams, and mental models from AI assistants.

These materials currently arise inside project conversations, but their long-term value is usually **not project-specific**.

For example, a PowerShell command used while maintaining `aip-mirror` may actually teach a reusable Git concept:

> enumerate branches → filter the result → execute an operation for each remaining branch.

The desired outcome is therefore not a collection of copy/paste snippets. It is a personal educational knowledge base that preserves:

- what a technique does;
- how it works;
- why it works;
- when it is appropriate;
- common mistakes and safety considerations;
- useful alternatives;
- version-sensitive assumptions;
- provenance and verification status.

The repository should remain useful even when the original project or conversation is no longer available.

## 2. Architectural boundary

The proposed system separates **AI working infrastructure** from **human developer knowledge**.

```
Current project repository
└── .ai/
    = AI working infrastructure
    = rules, skills, workflows, routing, handoffs, architecture context

Personal Developer Knowledge Repository
└── knowledge/
    = reusable knowledge for the human learner
    = concepts, procedures, recipes, mental models, troubleshooting,
      explanations, examples, and related references
```

The knowledge repository is not another copy of `.ai/`.

`.ai` answers:

> How should AI work with this project and its infrastructure?

The knowledge repository answers:

> What do I want to understand and remember as a developer?

## 3. Repository independence

The knowledge repository MUST be independent of the project in which a piece of knowledge was discovered.

Example:

```
Source project:
    paulhuman/aip-mirror

Knowledge:
    Git → Branches → deleting branches

Provenance:
    originally discovered while working on aip-mirror
```

The source project is metadata about the origin of the knowledge, not the semantic owner of that knowledge.

This permits the same knowledge base to serve:

- `aip-mirror`;
- future personal projects;
- experiments;
- maintenance tasks;
- other repositories;
- knowledge received from another AI assistant.

## 4. Proposed repository concept

The working concept is a **Personal Developer Knowledge Archive / Developer Knowledge Base**.

`FAQ` is intentionally treated as a possible presentation format, not the primary architectural name. The repository is broader than FAQ because a durable entry may contain a complete explanation, procedure, mental model, troubleshooting guide, or learning note.

Candidate repository names remain open.

The final repository name SHOULD be chosen after the taxonomy and interaction model are clearer.

## 5. Taxonomy principle

The primary taxonomy SHOULD follow the technology/domain being learned, not the project where the information originated.

A possible initial shape is:

```
knowledge/
├── git/
│   ├── branches/
│   ├── remotes/
│   ├── commits/
│   └── troubleshooting/
│
├── powershell/
│   ├── fundamentals/
│   ├── pipelines/
│   ├── objects/
│   └── commands/
│
├── deepseek-harness/
│   ├── concepts/
│   ├── installation/
│   ├── configuration/
│   ├── plugins/
│   └── maintenance/
│
├── github/
├── python/
├── cpp/
├── cmake/
├── windows/
└── ...
```

This is only a starting hypothesis. The architecture SHOULD avoid creating dozens of empty categories before real material requires them.

The taxonomy SHOULD evolve from actual knowledge entries.

## 6. Knowledge entry types

A knowledge entry SHOULD be classified by what the learner needs to accomplish.

### 6.1 Concept

Explains what something is.

Examples:

- What is a Git branch?
- What is a PowerShell pipeline?
- What is a DSH profile?

### 6.2 Procedure

Explains how to perform a concrete task.

Examples:

- Delete all local Git branches except `main`.
- Check installed DSH versions.
- Update a plugin after a Desktop upgrade.

### 6.3 Mental model

Explains the underlying mechanism so the learner can derive new solutions rather than memorize commands.

Examples:

- How Git branch references work.
- How PowerShell pipelines pass objects.
- How DSH Desktop, Harness, profiles, and plugins relate.

### 6.4 Recipe

Combines a goal-oriented sequence with prerequisites, verification, and explanation.

Examples:

- Clean up a finished Git feature branch.
- Rebuild a DSH environment after a Desktop update.

### 6.5 Troubleshooting

Explains a failure mode, diagnosis path, cause, and recovery.

### 6.6 Reference / comparison

Captures a durable comparison or lookup that is useful for learning.

These types MAY coexist in one entry when that produces a clearer educational document.

## 7. Educational language policy

The knowledge repository uses a deliberate two-layer language model:

> **Russian is the explanatory language; English is the canonical vocabulary of professional terminology.**

Educational materials SHOULD be written in Russian so that the explanatory layer minimizes cognitive load during learning.

The following SHOULD remain in their canonical English form:

- names of entities;
- professional terminology;
- technology and product names;
- command names;
- API names;
- parameter and option names;
- identifiers from source code;
- stable technical expressions.

Normative wording:

> **Учебные материалы пишутся на русском языке. Названия сущностей, профессиональная терминология, имена технологий, команд, API, параметров и устойчивые технические выражения сохраняются на English.**

A professional term SHOULD NOT be translated merely for the sake of translation. When a term benefits from explanation, introduce it in its canonical English form and explain its meaning in Russian.

For example:

> `branch` — это именованная movable reference на commit. В дальнейшем используется термин `branch`, а не «ветка», если контекст не требует русского описания.

This policy does **not** require English everywhere. Natural Russian phrasing remains appropriate when the concept is being described in ordinary explanatory language.

For example:

- «удалить ветку» is natural when describing an operation;
- «Git `branch` — это movable reference...» is preferable when teaching the canonical technical concept.

The objective is to preserve the vocabulary the learner will encounter in English-language documentation, CLI output, IDEs, source code, and other technical environments, while keeping the explanatory layer comfortable to read.

This language policy applies to the future knowledge repository itself and SHOULD be treated as a foundational architectural rule rather than a formatting preference.

## 8. Educational quality contract

The repository SHOULD optimize for **understanding and future recall**, not command density.

A good entry should answer, where applicable:

1. What problem are we solving?
2. What is the simplest useful solution?
3. What does each important part of the solution mean?
4. How does the underlying mechanism work?
5. Why does this solution work?
6. What assumptions does it make?
7. What can go wrong?
8. What should the learner verify?
9. Are there safer, simpler, or more maintainable alternatives?
10. Which parts are version-sensitive?
11. Where did this knowledge come from?
12. What related concepts are worth learning next?

The entry SHOULD prefer explanations that allow the learner to reconstruct the solution independently.

## 8. Relationship to `explain-code`

`.ai/skills/explain-code` and the proposed knowledge-capture capability have different responsibilities.

`explain-code` is a **teaching capability**:

```
code / technical material
        ↓
explanation
        ↓
human understanding
```

The proposed capability is a **knowledge-capture capability**:

```
useful explanation / procedure / external AI answer
        ↓
classify
        ↓
verify
        ↓
normalize
        ↓
add educational structure
        ↓
capture provenance
        ↓
knowledge repository
```

The new capability SHOULD reuse the pedagogical principles of `explain-code` rather than replace or redefine that skill.

In particular, the existing emphasis on:

- analogy;
- diagrams;
- step-by-step walkthroughs;
- common gotchas;

is a useful baseline for educational knowledge entries.

## 9. Proposed capture interaction

The user should be able to say, conceptually:

> Save this to my developer knowledge base.

or:

> Capture this as a learning note.

The input may be:

- an explanation produced in the current conversation;
- an answer copied from another AI;
- a command the user just learned;
- an existing note that needs normalization;
- a troubleshooting solution;
- a useful external explanation.

The AI SHOULD then determine:

```
What is this?
    ↓
Which technology/domain?
    ↓
Which knowledge entry type?
    ↓
Does an entry already exist?
    ↓
New entry or extension?
    ↓
What needs verification?
    ↓
Normalize into the educational schema
    ↓
Write to configured knowledge repository
```

The user should not have to manually decide the final directory or document format for every capture.

## 10. External AI material is source material, not authority

An answer from another AI MUST NOT automatically be treated as verified truth.

For example, the supplied DSH answer from Grok contains useful material, but before permanent capture the system should distinguish:

```
Claim
    ↓
Known / verified?
    ├── yes → preserve as confirmed
    ├── uncertain → mark as unverified / verify
    └── version-dependent → record version context
```

The capture process SHOULD be able to improve an imported answer by:

- correcting factual errors;
- removing obsolete instructions;
- adding missing explanations;
- adding safer alternatives;
- separating confirmed facts from assumptions;
- preserving useful original intent without preserving conversational filler.

The goal is not to archive another AI's response verbatim. The goal is to turn useful source material into a trustworthy learning artifact.

## 11. Provenance

Each entry SHOULD preserve enough provenance to answer:

> Where did this knowledge come from?

Provenance is a **universal source model**, not a project-chapter model.

The provenance model SHOULD distinguish:

```yaml
provenance:
  kind: ai-conversation
  agent: ChatGPT
  project: aip-mirror
  chapter: C0071
```

Semantic roles:

- `kind` → the semantic source category;
- `agent` → who or what provided the material, when applicable;
- `project` → where the material originated, when applicable;
- `chapter` → optional project-local context, when applicable.

The `kind` field SHOULD be the primary semantic discriminator. Candidate values include:

- `ai-conversation`;
- `agentic-ai`;
- `official-documentation`;
- `personal-experiment`;
- `github-issue` / `github-discussion`;
- `external-article` / `tutorial`;
- other source categories as the archive encounters them.

Additional provenance fields MAY be introduced where they materially improve traceability, for example:

- source URL;
- publication or capture date;
- version/context;
- author or organization;
- relevant identifier.

The `chapter` field is intentionally **not required** and its long-term retention is still an open design question. A chapter is a project-local organizational mechanism, not a universal unit of knowledge provenance. An agentic AI source, official documentation page, personal experiment, or external article may have no meaningful chapter at all.

The source project and source chapter are provenance metadata, not semantic ownership. A knowledge entry remains independent of the project in which it was discovered.

Provenance SHOULD support multiple sources for one entry when knowledge was assembled or verified from more than one origin.

## 12. Verification state

Knowledge entries SHOULD distinguish at least:

- **confirmed** — checked against reliable evidence or successfully tested;
- **inferred** — logically derived but not directly verified;
- **version-sensitive** — correct only within an identified version/context;
- **unverified** — useful candidate knowledge that still requires validation.

This prevents the archive from becoming a permanent store of plausible-sounding AI hallucinations.

## 13. Example: Git branch cleanup

The real-life example that motivated this design is:

```powershell
git branch --format='%(refname:short)' |
    Where-Object { $_ -ne 'main' } |
    ForEach-Object { git branch -D $_ }
```

The future knowledge entry should not merely preserve this command.

It should explain the pipeline:

```
git branch
    ↓
produce branch names
    ↓
--format='%(refname:short)'
    ↓
produce clean branch names
    ↓
PowerShell pipeline
    ↓
Where-Object
    ↓
remove main from the candidates
    ↓
ForEach-Object
    ↓
delete each remaining branch
```

It should then explain the important concepts separately:

- Git's branch references;
- `git branch --format`;
- PowerShell's pipeline;
- `Where-Object`;
- `ForEach-Object`;
- `git branch -D`;
- why this is different from deleting remote branches;
- what safety checks are appropriate.

The command becomes an example of a concept rather than the whole lesson.

## 14. Example: DSH Desktop maintenance material

The supplied DSH answer from Grok is a good candidate for a future entry, but it illustrates why capture needs verification.

Its useful subject matter includes:

```
DSH Desktop
    ↓
Harness runtime
    ↓
profile
    ↓
plugins / dependencies
    ↓
dshmarket
```

A durable entry could eventually cover:

- how to identify the Desktop-managed Harness version;
- how `DSH_HOME` changes the active Harness home;
- how profiles are structured;
- how to inspect installed plugin versions;
- what is managed by Desktop versus the user;
- how upgrades affect compatibility;
- safe update procedure;
- backup and rollback considerations;
- alternative inspection commands.

Before publication, claims such as “version X is embedded in Desktop” or exact update semantics SHOULD be checked against the actual DSH version and authoritative documentation/source, rather than copied from the AI response unchanged.

## 15. Proposed document shape

A first-pass entry schema could be:

```markdown
# <Title>

> Short statement of what the learner will understand or accomplish.

## Problem

## Short answer

## How it works

## Step-by-step

## Why it works

## Example

## Alternatives

## Common mistakes / gotchas

## Verification

## Version notes

## Related concepts

## Provenance
```

Not every section is mandatory.

The capture capability SHOULD select the sections that actually improve understanding rather than mechanically producing empty headings.

## 16. Configuration boundary

The location of the external knowledge repository SHOULD be configured in the current project's `.ai/config.yaml`.

Conceptually:

```yaml
references:
  repositories:
    developer_knowledge:
      repository: <configured repository>
      role: Personal developer knowledge archive
```

The skill MUST NOT hard-code the repository name or URL.

This preserves portability:

```
.ai/config.yaml
    ↓
where the knowledge repository lives

knowledge-capture skill
    ↓
how knowledge is captured and maintained
```

The exact configuration key remains to be finalized.

## 17. Future skill

The `knowledge-capture` skill was implemented in C0073. This section is retained as the original architectural responsibility definition; the active operational contract now lives in `.ai/skills/knowledge-capture/SKILL.md`.

A provisional conceptual name is:

`knowledge-capture`

Its responsibility would be to:

- accept knowledge from the current conversation or supplied source material;
- classify it;
- locate related existing entries;
- preserve or improve educational explanations;
- identify claims needing verification;
- capture provenance;
- select the appropriate taxonomy location;
- create or update the knowledge entry;
- maintain consistent formatting;
- verify the resulting repository change.

It SHOULD NOT become the canonical owner of the knowledge itself.

The knowledge repository remains the human-facing storage layer; the skill is the operational capability for interacting with it.

## 19. Open architecture questions

Before implementation, decide:

1. Final repository name.
2. Whether the repository root should contain `knowledge/` or use topic directories directly.
3. Exact metadata format.
4. Whether metadata belongs in front matter, a separate index, or both.
5. Exact verification-state vocabulary.
6. How `provenance.chapter` should be treated in the minimum provenance contract.
7. How duplicate / overlapping knowledge entries are detected.
7. How cross-topic concepts are linked.
8. How version-specific knowledge is represented.
9. Whether external source URLs are mandatory when available.
10. Whether the archive needs its own lightweight `.ai` infrastructure later.
11. Which operations should be exposed as explicit commands such as `>>capture`, `>>learn`, or another name.
12. How repository writes and validation should be authorized.

## 20. Initial design principle

The central principle for the whole system is:

> **Do not preserve snippets merely because they are useful. Preserve understanding that makes the snippet reproducible.**

A successful knowledge entry should make it possible for the learner to return later and answer:

> “What is this doing, why does it work, what assumptions does it make, and how could I derive or adapt it myself?”

That is the target quality bar for the future Developer Knowledge Archive.


## 20. Concrete minimum knowledge entry

The first concrete model is deliberately a **single educational entry**, not a rigid document template. The entry has a small metadata envelope and a variable explanatory body.

### 20.1 Minimum metadata

The minimum metadata is:

```yaml
---
title: <human-readable title>
type: <concept | procedure | mental-model | recipe | troubleshooting | reference>
topics:
  - <technology/domain>
status: <draft | verified | version-sensitive | unverified>
provenance:
  - kind: <source category>
    agent: <optional>
    project: <optional>
    chapter: <optional>
    source: <optional URL or other locator>
    captured: <optional ISO date>
version:
  <optional version/context>
---
```

Required semantic fields:

- `title` — stable human-facing identity of the entry;
- `type` — primary educational form;
- `topics` — technology/domain taxonomy;
- `status` — current trust/verification state;
- `provenance` — one or more sources.

The body remains intentionally flexible. Sections are selected by educational need rather than generated mechanically.

### 20.2 Why these fields are enough

The minimum model separates four different questions:

```
What is it?
    title + type

Where does it belong?
    topics

How much should I trust it?
    status + version

Where did it come from?
    provenance[]
```

Nothing in this minimum metadata makes the source project the semantic owner of the entry.

A procedure discovered in `aip-mirror` can therefore live under `git` without becoming an AIP Mirror document.

### 20.3 Ideal body shape

A strong entry SHOULD normally follow this conceptual order:

```
Goal / problem
    ↓
Short answer
    ↓
How it works
    ↓
Step-by-step
    ↓
Why it works
    ↓
Gotchas / safety
    ↓
Verification
    ↓
Alternatives
    ↓
Version notes
    ↓
Related concepts
```

Sections MAY be omitted when they do not add educational value.

The important distinction is between **answer** and **understanding**:

- the short answer lets the learner solve the immediate problem;
- the explanation makes the solution reproducible;
- the mental model makes adaptation possible.

## 21. Fixture test: Git branch cleanup

The Git fixture fits naturally as a `procedure` with a strong `mental-model` component.

Conceptual entry:

```yaml
title: Delete all local Git branches except main
type: procedure
topics:
  - git
  - powershell
status: verified
provenance:
  - kind: ai-conversation
    agent: ChatGPT
    project: aip-mirror
    chapter: C0071
```

The body should not begin and end with the command. It should teach the reusable mechanism:

```
Git produces branch names
        ↓
--format turns refs into clean names
        ↓
PowerShell pipeline carries each name
        ↓
Where-Object excludes main
        ↓
ForEach-Object performs an operation per branch
        ↓
git branch -D deletes each selected local branch
```

The command remains a concrete application of this model.

The entry should also explicitly distinguish:

- local branch deletion from remote branch deletion;
- `-D` from the safer `-d`;
- filtering by branch name from checking whether a branch contains unmerged work;
- a reusable PowerShell pipeline from this one destructive operation.

This fixture therefore validates that the schema can preserve both the immediate recipe and the underlying concepts without creating separate mandatory documents for every sub-concept.

## 22. Fixture test: DSH Desktop / Harness material

The DSH fixture demonstrates the opposite pressure: the source material is useful but contains claims whose exact truth depends on version and implementation.

A candidate entry can therefore start with:

```yaml
title: DSH Desktop, Harness, profiles, and plugins
type: mental-model
topics:
  - deepseek-harness
status: unverified
provenance:
  - kind: ai-conversation
    agent: Grok
    project: <optional if the original project is known>
    source: <optional source locator>
```

The body should separate:

1. **Observed / verified facts** — backed by installed files, commands, source, or authoritative documentation.
2. **Working model** — the relationship the learner currently uses to reason about Desktop, Harness, profiles, and plugins.
3. **Version-sensitive claims** — statements that must name the relevant DSH/Desktop version.
4. **Open claims** — useful assertions that still require verification.

The entry must not silently promote a plausible AI explanation into a confirmed fact.

This fixture validates two architectural requirements:

- `status` cannot be inferred solely from the fact that a source is an AI answer;
- `version` belongs alongside provenance when behavior depends on a concrete software version.

## 23. Final decision: `provenance.chapter`

**Decision: retain `provenance.chapter` as an optional provenance field.**

The field survives because a project conversation chapter can materially improve reconstruction of how a knowledge item was discovered, tested, or explained. This is especially useful for knowledge captured from long-running project work.

However, the field has strict boundaries:

1. It is **never required**.
2. It is **not part of taxonomy**.
3. It is **not a knowledge-entry identifier**.
4. It is **not the semantic owner of the knowledge**.
5. It MUST be omitted when the source has no meaningful chapter.
6. A future capture workflow SHOULD include it only when it materially improves traceability.

Therefore:

```
kind
    = what kind of source is this?

project
    = where did the source originate?

chapter
    = optional locator inside that project context
```

This resolves the earlier tension between chapter-free universal provenance and useful project-conversation traceability.

An agentic AI response, official documentation page, personal experiment, or external article can have provenance with no `project` and no `chapter`.

## 24. Refined `knowledge-capture` contract

The minimum operational skill contract is now:

1. **Capture** — accept the material selected by the user.
2. **Classify** — determine `type` and primary `topics`.
3. **Discover** — search for related existing entries before creating a new one.
4. **Normalize** — turn the source into an educational artifact rather than copying it verbatim.
5. **Verify** — distinguish confirmed, inferred, version-sensitive, and unverified claims.
6. **Provenance** — preserve one or more sources; include `chapter` only when useful.
7. **Version context** — record concrete software/tool versions when they affect correctness.
8. **Write** — create or minimally update the configured knowledge repository.
9. **Read back** — verify the written artifact.
10. **Report** — tell the user what was captured, what was verified, and what remains uncertain.

The skill therefore owns the **capture workflow**, not the knowledge model itself.

The repository owns the durable knowledge. The entry schema defines its semantic envelope. The skill is the controlled mechanism for producing and maintaining entries.

## 25. Resulting minimum architecture

The C0072 model can now be summarized as:

```
source material
    ↓
knowledge-capture
    ├── classify → type + topics
    ├── discover → related entries
    ├── normalize → educational body
    ├── verify → status + version
    ├── provenance → source-oriented trace
    └── write/verify → knowledge repository
```

With this model, the archive is no longer primarily a place to save useful snippets. It is a place to preserve **reproducible understanding**.

The external repository and `knowledge-capture` capability are now implemented at the minimum bounded level. Further changes remain evidence-driven.


## 26. Implementation checkpoint: C0073

C0073 moved the design into the first bounded implementation step.

### 26.1 External repository configuration

The external Developer Knowledge Repository is now referenced through the existing `.ai/config.yaml` repository-reference layer:

```yaml
references:
  repositories:
    developer_knowledge:
      repository: paulhuman/developer-knowledge
      role: Project-independent repository for durable developer knowledge
```

This is intentionally the minimum configuration boundary.

The configuration does not introduce capture-specific paths, taxonomy settings, or workflow switches. The repository remains project-independent; `aip-mirror` is provenance when relevant, not semantic ownership.

### 26.2 Initial `knowledge-capture` capability

The first operational skill is now implemented at:

```
.ai/skills/knowledge-capture/SKILL.md
```

The skill owns the capture workflow rather than the knowledge model.

Its minimum operational contract is:

```
capture
    ↓
classify
    ↓
discover
    ↓
normalize
    ↓
verify
    ↓
provenance
    ↓
version context
    ↓
write
    ↓
read back
    ↓
verify scope
    ↓
report
```

The skill resolves the target repository from `.ai/config.yaml` and MUST NOT hard-code the external repository identity.

The skill is registered in `.ai/INDEX.md` as a capability. No dedicated `>>capture` command is introduced yet. Command-surface expansion remains deferred until actual usage demonstrates that an explicit invocation boundary is useful.

### 26.3 First-entry validation result

The first real knowledge entry was created and verified in `paulhuman/developer-knowledge`.

The final path is:

`git/branches/delete-branches.md`

The entry validates that the capture model can preserve:

- an immediate practical procedure;
- the reusable Git + PowerShell mental model behind it;
- safety and verification considerations;
- project-independent taxonomy;
- provenance back to the originating project conversation when useful.

The original fixture path in earlier design text is therefore historical; the final entry groups the simple Git deletion commands and the two mass-deletion pipelines in one educational document.

### 26.5 C0073 correction: educational language policy

The first implementation exposed a validation gap: the initial real knowledge entry was written predominantly in English even though section 7 defines Russian as the explanatory language and English as the canonical technical vocabulary.

The entry was corrected in `paulhuman/developer-knowledge` to use Russian explanatory prose while retaining canonical English technical terms.

The `knowledge-capture` skill was also strengthened with an explicit pre-write language-policy validation gate.

This correction is important because the language policy was already an architectural rule; the implementation failure was a **validation failure**, not a new architecture decision.


### 26.4 C0073 implementation boundary

The implementation intentionally does not yet add:

- a dedicated capture command;
- capture-specific configuration sections;
- a rigid universal document template;
- a pre-created knowledge taxonomy;
- a separate AI infrastructure inside the external knowledge repository.

These remain future decisions that should be driven by real entry creation and validation rather than speculative architecture.


### 26.6 C0073 correction: policy ownership

The first implementation placed an active educational-language validation policy directly in `.ai/skills/knowledge-capture/SKILL.md` while the architectural source was an architecture note.

This conflicted with the architecture README's ownership boundary: architecture notes are durable context and MUST NOT become replacements for active `.ai/rules/`, `.ai/skills/`, or `.ai/workflows/` owners.

The educational language policy and related active capture constraints were therefore moved to the canonical rule:

`.ai/rules/developer-knowledge.md`

The `knowledge-capture` skill now acts as the operational capability and explicitly reads that rule before writing an entry. The architecture note remains the durable rationale and history.

This correction is an **ownership-boundary correction**, not a change to the educational policy itself.


## 27. C0074 remaining work after first implementation

C0074 records the remaining work for this architecture note after the C0073 implementation baseline.

The current implementation is intentionally sufficient for the first real capture. The remaining work is primarily **validation and cleanup of the architecture model**, not expansion of the infrastructure:

1. **Validate the model against additional real knowledge entries.** The first Git fixture proved the minimum capture path, but the architecture should be tested against materially different knowledge, especially a version-sensitive or troubleshooting entry such as the DSH Desktop / Harness material described in §22.
2. **Resolve only the remaining open repository-model questions when real usage requires them.** In particular, observe whether additional taxonomy structure, cross-topic linking, external-source requirements, or version representation need stronger rules. Do not pre-create infrastructure without evidence.
3. **Keep the architecture note synchronized with active owners.** `.ai/rules/developer-knowledge.md` is the active semantic owner of educational-language and capture-policy constraints; `.ai/skills/knowledge-capture/SKILL.md` is the operational owner of the capture procedure. This note records rationale, design history, and remaining architectural questions rather than replacing either owner.
4. **Reconcile and retire stale design wording as implementation evolves.** Historical sections may describe earlier hypotheses, but current implementation checkpoints should remain explicit enough that the document does not imply that implemented capabilities are still merely proposed.
5. **Defer a dedicated `>>capture` command and additional external-repository infrastructure** until real usage demonstrates a concrete need.

No broader redesign is required by C0074. The next bounded work should be driven by an actual second knowledge-capture case or by a concrete inconsistency discovered in the current model.
