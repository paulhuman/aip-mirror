# Developer Knowledge Archive — architecture design

**Status:** Draft architecture design  
**Chapter:** C0071 — Architecture & Research  
**Purpose:** Define the architecture of a separate, project-independent personal developer knowledge repository and the \`.ai\` capability required to capture, normalize, explain, and preserve useful technical knowledge.

## 1. Problem

During work on any project, the user frequently receives useful technical explanations, commands, procedures, troubleshooting steps, diagrams, and mental models from AI assistants.

These materials currently arise inside project conversations, but their long-term value is usually **not project-specific**.

For example, a PowerShell command used while maintaining \`aip-mirror\` may actually teach a reusable Git concept:

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

\`\`\`
Current project repository
└── .ai/
    = AI working infrastructure
    = rules, skills, workflows, routing, handoffs, architecture context

Personal Developer Knowledge Repository
└── knowledge/
    = reusable knowledge for the human learner
    = concepts, procedures, recipes, mental models, troubleshooting,
      explanations, examples, and related references
\`\`\`

The knowledge repository is not another copy of \`.ai/\`.

\`.ai\` answers:

> How should AI work with this project and its infrastructure?

The knowledge repository answers:

> What do I want to understand and remember as a developer?

## 3. Repository independence

The knowledge repository MUST be independent of the project in which a piece of knowledge was discovered.

Example:

\`\`\`
Source project:
    paulhuman/aip-mirror

Knowledge:
    Git → Branches → deleting branches

Provenance:
    originally discovered while working on aip-mirror
\`\`\`

The source project is metadata about the origin of the knowledge, not the semantic owner of that knowledge.

This permits the same knowledge base to serve:

- \`aip-mirror\`;
- future personal projects;
- experiments;
- maintenance tasks;
- other repositories;
- knowledge received from another AI assistant.

## 4. Proposed repository concept

The working concept is a **Personal Developer Knowledge Archive / Developer Knowledge Base**.

\`FAQ\` is intentionally treated as a possible presentation format, not the primary architectural name. The repository is broader than FAQ because a durable entry may contain a complete explanation, procedure, mental model, troubleshooting guide, or learning note.

Candidate repository names remain open.

The final repository name SHOULD be chosen after the taxonomy and interaction model are clearer.

## 5. Taxonomy principle

The primary taxonomy SHOULD follow the technology/domain being learned, not the project where the information originated.

A possible initial shape is:

\`\`\`
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
\`\`\`

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

- Delete all local Git branches except \`main\`.
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

## 7. Educational quality contract

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

## 8. Relationship to \`explain-code\`

\`.ai/skills/explain-code\` and the proposed knowledge-capture capability have different responsibilities.

\`explain-code\` is a **teaching capability**:

\`\`\`
code / technical material
        ↓
explanation
        ↓
human understanding
\`\`\`

The proposed capability is a **knowledge-capture capability**:

\`\`\`
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
\`\`\`

The new capability SHOULD reuse the pedagogical principles of \`explain-code\` rather than replace or redefine that skill.

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

\`\`\`
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
\`\`\`

The user should not have to manually decide the final directory or document format for every capture.

## 10. External AI material is source material, not authority

An answer from another AI MUST NOT automatically be treated as verified truth.

For example, the supplied DSH answer from Grok contains useful material, but before permanent capture the system should distinguish:

\`\`\`
Claim
    ↓
Known / verified?
    ├── yes → preserve as confirmed
    ├── uncertain → mark as unverified / verify
    └── version-dependent → record version context
\`\`\`

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

Potential metadata:

\`\`\`yaml
topic: git/branches
type: procedure
source_project: paulhuman/aip-mirror
source_context: C0071
source_kind: ai-conversation
source_agent: ChatGPT
verified: true
verified_at: 2026-10-07
version_context:
  powershell: "7.x"
\`\`\`

The exact schema remains open.

Provenance SHOULD support multiple source kinds, including:

- current project conversation;
- another AI assistant;
- official documentation;
- personal experimentation;
- issue / discussion;
- external article or tutorial.

## 12. Verification state

Knowledge entries SHOULD distinguish at least:

- **confirmed** — checked against reliable evidence or successfully tested;
- **inferred** — logically derived but not directly verified;
- **version-sensitive** — correct only within an identified version/context;
- **unverified** — useful candidate knowledge that still requires validation.

This prevents the archive from becoming a permanent store of plausible-sounding AI hallucinations.

## 13. Example: Git branch cleanup

The real-life example that motivated this design is:

\`\`\`powershell
git branch --format='%(refname:short)' |
    Where-Object { $_ -ne 'main' } |
    ForEach-Object { git branch -D $_ }
\`\`\`

The future knowledge entry should not merely preserve this command.

It should explain the pipeline:

\`\`\`
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
\`\`\`

It should then explain the important concepts separately:

- Git's branch references;
- \`git branch --format\`;
- PowerShell's pipeline;
- \`Where-Object\`;
- \`ForEach-Object\`;
- \`git branch -D\`;
- why this is different from deleting remote branches;
- what safety checks are appropriate.

The command becomes an example of a concept rather than the whole lesson.

## 14. Example: DSH Desktop maintenance material

The supplied DSH answer from Grok is a good candidate for a future entry, but it illustrates why capture needs verification.

Its useful subject matter includes:

\`\`\`
DSH Desktop
    ↓
Harness runtime
    ↓
profile
    ↓
plugins / dependencies
    ↓
dshmarket
\`\`\`

A durable entry could eventually cover:

- how to identify the Desktop-managed Harness version;
- how \`DSH_HOME\` changes the active Harness home;
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

\`\`\`markdown
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
\`\`\`

Not every section is mandatory.

The capture capability SHOULD select the sections that actually improve understanding rather than mechanically producing empty headings.

## 16. Configuration boundary

The location of the external knowledge repository SHOULD be configured in the current project's \`.ai/config.yaml\`.

Conceptually:

\`\`\`yaml
references:
  repositories:
    developer_knowledge:
      repository: <configured repository>
      role: Personal developer knowledge archive
\`\`\`

The skill MUST NOT hard-code the repository name or URL.

This preserves portability:

\`\`\`
.ai/config.yaml
    ↓
where the knowledge repository lives

knowledge-capture skill
    ↓
how knowledge is captured and maintained
\`\`\`

The exact configuration key remains to be finalized.

## 17. Future skill

The proposed skill is currently a design target, not yet an implemented skill.

A provisional conceptual name is:

\`knowledge-capture\`

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

## 18. Open architecture questions

Before implementation, decide:

1. Final repository name.
2. Whether the repository root should contain \`knowledge/\` or use topic directories directly.
3. Exact metadata format.
4. Whether metadata belongs in front matter, a separate index, or both.
5. Exact verification-state vocabulary.
6. How duplicate / overlapping knowledge entries are detected.
7. How cross-topic concepts are linked.
8. How version-specific knowledge is represented.
9. Whether external source URLs are mandatory when available.
10. Whether the archive needs its own lightweight \`.ai\` infrastructure later.
11. Which operations should be exposed as explicit commands such as \`>>capture\`, \`>>learn\`, or another name.
12. How repository writes and validation should be authorized.

## 19. Initial design principle

The central principle for the whole system is:

> **Do not preserve snippets merely because they are useful. Preserve understanding that makes the snippet reproducible.**

A successful knowledge entry should make it possible for the learner to return later and answer:

> “What is this doing, why does it work, what assumptions does it make, and how could I derive or adapt it myself?”

That is the target quality bar for the future Developer Knowledge Archive.
