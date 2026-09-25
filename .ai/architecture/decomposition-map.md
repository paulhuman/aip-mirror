# Decomposition Map

Status: Working map / Iteration 2 — DECOMPOSE
Scope: dependency and duplication analysis before physical decomposition

## Purpose

This document defines the semantic decomposition plan for mixed AI-infrastructure and AIP Mirror project documents.

The goal is not to turn every section into a separate file. A durable document should contain a coherent semantic unit with a clear canonical owner.

For each unit:
- one document is the canonical source;
- other documents may reference or route to that source;
- duplication is removed gradually;
- physical DECOMPOSE happens only after canonical ownership is clear.

This map is intentionally more detailed than the eventual filesystem. Several mapped units will remain together in one document.

## 1. Semantic model

A unit is durable when it has:
1. a stable subject;
2. a recognizable owner;
3. a reason to be referenced independently;
4. enough internal coherence to survive independently of its current source document.

A unit is not automatically a new file.

Kinds:
- RULE — what must be true;
- SKILL — reusable capability;
- WORKFLOW — ordered procedure;
- PROJECT DOC — what AIP Mirror is / how it works;
- ENTRY / ROUTING — navigation to canonical material.

# 2. .ai/rules/workflow.md

## 2.1 General development cycle
Current content: research → document → review → specify → prototype → validate → implement → test → document.

Classification:
- Kind: RULE / workflow principle
- Subject: generic AI-assisted development discipline
- Canonical owner: .ai/rules/workflow.md after decomposition
- Action: KEEP, but remove AIP Mirror-specific framing
- Dependencies: deep-understanding skill for substantial investigations; repository rule for write/commit safety

This is a reusable workflow principle. It must not contain the four AIP Mirror specializations.

## 2.2 Four project specializations
Current content:
- 01 JSX Prototype
- 02 Native AIP Plugin
- 03 Architecture & Research
- 04 Project Workshop
- chapter identifier format and examples

Classification:
- Kind: PROJECT DOC / routing
- Subject: AIP Mirror workstream model
- Canonical owner: docs/ project documentation
- Action: MOVE OUT OF .ai/rules/workflow.md
- Dependencies: project-specific architecture documentation

Duplication:
- duplicated in docs/PROJECT-INSTRUCTIONS.md
- chapter identifier rules also duplicated in .ai/rules/handoff/lifecycle.md

Decision:
- The existence and purpose of AIP Mirror specializations belongs to docs/.
- Generic handoff machinery may refer to a specialization identifier without defining AIP Mirror's four specializations.

## 2.3 Do not duplicate reasoning across conversations
Classification:
- Kind: RULE + routing principle
- Canonical ownership:
  - durable AI working rule → .ai/rules/workflow.md
  - handoff procedure/state → .ai/rules/handoff/lifecycle.md + .ai/skills/handoff/ + bootstrap workflow
  - AIP Mirror specialization routing → docs/
- Action: SPLIT BY SEMANTIC OWNER

The workflow rule says not to duplicate reasoning and to route work. Handoff rules define continuity. Project docs define the specializations.

## 2.4 JSX → native transition
Classification:
- Kind: PROJECT DOC
- Subject: AIP Mirror development architecture
- Canonical owner: docs/architecture/
- Action: MOVE OUT OF .ai/rules/workflow.md

Duplication:
- also represented in docs/PROJECT-INSTRUCTIONS.md
- related to docs/architecture/project-architecture.md

The .ai layer may contain generic validation-before-implementation rules. The specific JSX/native pipeline belongs only in AIP Mirror project documentation.

## 2.5 Research before major implementation
Classification:
- Kind: RULE / workflow principle
- Canonical owner: .ai/rules/workflow.md
- Action: KEEP
- Dependency: .ai/skills/deep-understanding/

AIP Mirror-specific examples should not be embedded here.

## 2.6 Validate behavior before declaring it final
Classification:
- Kind: RULE
- Canonical owner: .ai/rules/workflow.md
- Action: KEEP

Generic evidence/specification discipline. Project-specific behavioral requirements belong in docs/.

## 2.7 Prefer small, reviewable changes
Classification:
- Kind: RULE
- Canonical owner: .ai/rules/workflow.md
- Action: KEEP

Do not duplicate this in project documentation unless a project-specific exception exists.

## 2.8 Testing
Current content mixes:
- a generic testing principle;
- an AIP Mirror-specific three-layer test model.

Classification:
- Generic principle → .ai/rules/workflow.md
- AIP Mirror testing architecture → docs/architecture/ or project testing documentation
- Action: SPLIT

Canonical boundary:
- .ai: test at the lowest appropriate level when practical.
- docs: geometry / behavior / Illustrator integration as the project's concrete test architecture.

The geometry → behavior → Illustrator integration ladder is not generic AI infrastructure. It must leave workflow.md.

## 2.9 Commit discipline
Classification:
- Kind: RULE
- Canonical owners:
  - repository safety → .ai/rules/repository.md
  - commit message construction → .ai/skills/commit-message/SKILL.md
  - generic pre-commit discipline → .ai/rules/workflow.md
- Action: KEEP ONLY ROUTING/PRINCIPLE HERE

Duplication:
- repository write safety is duplicated almost verbatim between workflow.md and repository.md;
- commit-message selection overlaps with commit-message/SKILL.md.

Decision:
- workflow.md should say that changes are verified before commit and route detailed mechanics to canonical owners.
- Do not maintain two copies of the API write-safety sequence.

## 2.10 Repository write verification
Classification:
- Kind: RULE
- Canonical owner: .ai/rules/repository.md
- Action: REMOVE DUPLICATE FROM workflow.md; leave a reference only.

Canonical sequence:

READ CURRENT FILE
→ minimal change
→ WRITE COMPLETE FILE
→ READ BACK
→ VERIFY CONTENT
→ INSPECT DIFF
→ VERIFY SCOPE
→ COMMIT
→ VERIFY RESULT

This is repository safety, not a general workflow definition.

## 2.11 User control over commits
Current content actually combines three distinct concerns.

### A. General commit authorization
Classification:
- Kind: RULE
- Canonical owner: .ai/rules/workflow.md
- Action: KEEP, but make it short and generic.

Generic rule:
- AI-assisted development changes are not committed automatically unless the user explicitly requests the commit or an established automated workflow authorizes it.

This belongs to the general development workflow because it governs ordinary project work.

### B. Handoff commit authorization
Classification:
- Kind: RULE / WORKFLOW
- Canonical owner: .ai/rules/handoff/lifecycle.md + .ai/workflows/handoff-bootstrap/BOOTSTRAP.md
- Action: REMOVE detailed exception from workflow.md; leave only a routing reference if needed.

The fact that handoff creation/checkpoint/lifecycle commits are pre-authorized is part of the handoff mechanism, not general commit discipline.

### C. Commit message formulation
Classification:
- Kind: SKILL
- Canonical owner: .ai/skills/commit-message/SKILL.md
- Action: reference only.

Conclusion: User control over commits stays in workflow.md only as the short general authorization rule. The handoff exception moves out completely.

## 2.12 Conversation lifecycle
Classification:
- Kind: RULE
- Canonical owner: .ai/rules/handoff/lifecycle.md
- Action: REMOVE DUPLICATE FROM workflow.md; route to handoff rules.

workflow.md should not define:
- lifecycle states;
- transition ownership;
- supersession;
- recovery;
- lifecycle correction;
- bootstrap state;
- handoff location.

Those belong to handoff infrastructure.

## 2.13 Documentation follows decisions
Classification:
- Kind: RULE
- Canonical owner: .ai/rules/workflow.md
- Action: KEEP

Generic durable-knowledge principle.

## 2.14 Keep the project understandable
Classification:
- Kind: RULE
- Canonical owner: .ai/rules/workflow.md
- Action: KEEP

Keep the rule generic: explicit solutions over clever systems; AI infrastructure must not become development overhead.

The AIP Mirror-specific project statement belongs in project documentation.

## 2.15 Project Workshop routing rule
Classification:
- Kind: PROJECT DOC / routing
- Canonical owner: docs/
- Action: MOVE OUT OF .ai/rules/workflow.md

The existence and boundary of specialization 04 is project-specific.

# 3. Dependency / duplication map

## 3.1 Specialization model
Sources:
- .ai/rules/workflow.md
- docs/PROJECT-INSTRUCTIONS.md
- docs/architecture/project-architecture.md

Canonical:
- AIP Mirror specialization model → docs/

Other documents:
- .ai handoff infrastructure may consume the specialization identifier;
- it must not redefine the AIP Mirror specialization model.

## 3.2 Chapter identifier format
Sources:
- .ai/rules/workflow.md
- docs/PROJECT-INSTRUCTIONS.md
- .ai/rules/handoff/lifecycle.md

Canonical:
- generic chapter identifier semantics required by handoff infrastructure → .ai/rules/handoff/lifecycle.md
- AIP Mirror chapter naming examples / specialization names → docs/

The regex and base-26 sequence should have one normative owner for the operational handoff mechanism.

## 3.3 Repository write safety
Sources:
- .ai/rules/workflow.md
- .ai/rules/repository.md
- .ai/skills/commit-message/SKILL.md

Canonical:
- .ai/rules/repository.md

References:
- workflow.md → repository rule
- commit-message/SKILL.md → repository rule

No second copy of the full verification sequence.

## 3.4 Commit message construction
Sources:
- .ai/rules/workflow.md
- .ai/skills/commit-message/SKILL.md

Canonical:
- .ai/skills/commit-message/SKILL.md

workflow.md only routes to the skill when message formulation is needed.

## 3.5 Handoff lifecycle
Sources:
- .ai/rules/workflow.md
- .ai/rules/handoff/lifecycle.md
- .ai/skills/handoff/SKILL.md
- .ai/workflows/handoff-bootstrap/BOOTSTRAP.md
- .ai/skills/commit-message/SKILL.md

Canonical layering:
- lifecycle invariants → .ai/rules/handoff/lifecycle.md
- reusable handoff operation/capability → .ai/skills/handoff/SKILL.md
- bootstrap sequence → .ai/workflows/handoff-bootstrap/BOOTSTRAP.md
- handoff commit-message vocabulary → .ai/skills/commit-message/SKILL.md

workflow.md should not duplicate these detailed mechanisms.

## 3.6 Project architecture / JSX → native
Sources:
- .ai/rules/workflow.md
- docs/PROJECT-INSTRUCTIONS.md
- docs/architecture/project-architecture.md

Canonical:
- docs/architecture/

workflow.md may retain only generic research-before-implementation and validation principles.

# 4. Proposed post-decomposition shape of workflow.md

The resulting file should remain a small generic AI workflow rule:

1. General development cycle
2. Research before major implementation
3. Validate behavior before declaring final
4. Prefer small, reviewable changes
5. Generic testing principle
6. Commit discipline (short)
7. General user control over commits (authorization rule only)
8. Documentation follows decisions
9. Keep the AI workflow understandable and lightweight

It should route to, rather than duplicate:
- repository safety → .ai/rules/repository.md
- commit messages → .ai/skills/commit-message/SKILL.md
- handoff lifecycle → .ai/rules/handoff/lifecycle.md
- handoff capability → .ai/skills/handoff/SKILL.md
- bootstrap → .ai/workflows/handoff-bootstrap/BOOTSTRAP.md
- AIP Mirror project workflow → docs/

This is deliberately a compact rule document, not a catalogue of every project convention.

# 5. Decomposition invariants

1. Do not create one file per source section.
2. Do not preserve duplicated normative text merely because it currently exists in several files.
3. Establish canonical ownership before deleting duplicated text.
4. References/routing must point toward canonical owners, not create reciprocal semantic dependencies.
5. Generic .ai rules must not encode AIP Mirror-specific specialization facts.
6. Project-specific docs must not redefine generic AI infrastructure rules.
7. Handoff lifecycle, handoff operations, and commit recording remain separate semantic layers.
8. A file may remain composite when its units share one stable semantic owner.
9. Physical DECOMPOSE is complete only when the resulting files are smaller semantically, not merely smaller physically.
10. Generic workflow rules must not acquire project-specific examples merely because they are useful examples.

# 6. Next physical operation

After this map is accepted:

1. Decompose .ai/rules/workflow.md first.
2. Keep the generic workflow rule as the canonical .ai rule.
3. Move project-specific material to its canonical docs/ owner rather than creating another temporary file.
4. Replace duplicated mechanics with references/routing.
5. Read back every resulting file.
6. Inspect the diff and changed-file scope.
7. Commit the decomposition as one coherent refactor.
8. Then repeat the same analysis for .ai/rules/repository.md.
9. Then decompose docs/PROJECT-INSTRUCTIONS.md.

Do not perform ARCHIVE as part of this step.

# 7. Dependency-graph review — second pass

This pass confirms several stronger boundaries before physical DECOMPOSE.

## 7.1 workflow.md is currently too project-specific

The current file begins with “preferred development workflow for AIP Mirror” and then defines AIP Mirror's four specializations, JSX/native architecture, Illustrator-specific testing layers, and Project Workshop routing.

That is a boundary violation for the intended .ai / docs split.

After decomposition, .ai/rules/workflow.md should be reusable infrastructure. It may be used by AIP Mirror, but it should not need to know that AIP Mirror has 01, 02, 03, or 04.

## 7.2 User control over commits has a clean three-way split

The dependency graph is:

    general commit authorization
        → .ai/rules/workflow.md

    repository content/write safety
        → .ai/rules/repository.md

    handoff commit authorization
        → .ai/rules/handoff/lifecycle.md
          + .ai/workflows/handoff-bootstrap/BOOTSTRAP.md

    commit message construction
        → .ai/skills/commit-message/SKILL.md

This avoids making workflow.md the hub for all commit-related policy.

## 7.3 Commit discipline itself should remain thin

workflow.md needs only the general principle:

- verify the intended change before committing;
- keep commits coherent;
- use the commit-message skill when needed.

The full API write-safety sequence belongs exclusively to repository.md.

The handoff-specific commit rules belong exclusively to handoff infrastructure.

## 7.4 Testing also has a clean split

The generic rule is:

    test at the lowest appropriate level when practical.

The concrete AIP Mirror ladder:

    geometry
       ↓
    behavior
       ↓
    Illustrator integration

is project architecture and belongs in docs/.

This is a good example of why semantic decomposition is preferable to file splitting: one source section contains both a portable rule and a project-specific realization.

## 7.5 New dependency direction

The desired dependency direction after decomposition is:

    .ai/rules/workflow.md
        ↓
    generic AI workflow principles

    .ai/rules/repository.md
        ↓
    repository safety

    .ai/rules/handoff/lifecycle.md
        ↓
    lifecycle invariants

    .ai/skills/*
        ↓
    reusable capabilities

    .ai/workflows/*
        ↓
    ordered procedures

    docs/
        ↓
    AIP Mirror project semantics

The .ai layer may route into project documentation when necessary, but project facts should not be copied back into generic .ai rules.

## 7.6 New physical target for workflow.md

After decomposition, workflow.md should contain approximately 9 compact principles:

1. general development cycle;
2. research before major implementation;
3. validate behavior before declaring it final;
4. prefer small, reviewable changes;
5. generic testing principle;
6. thin commit discipline;
7. general user control over commits;
8. documentation follows decisions;
9. keep the AI workflow understandable and lightweight.

Everything else currently in workflow.md has a more specific canonical owner.

## 7.7 One more important observation

The current workflow.md is not merely composite; it is acting as an accidental aggregation point for several unrelated policies.

The decomposition should therefore not preserve a shortened version of every old section.

Instead, each old section should either:

- remain as one of the nine generic principles;
- move to a canonical project/infrastructure owner;
- or disappear when its content is already fully represented elsewhere.

That last option is important for eliminating historical duplication rather than relocating it.


# 8. .ai/rules/repository.md

## 8.1 Repository identity

Current content defines the canonical AIP Mirror repository and the external Adobe Illustrator SDK repository.

Classification:
- Kind: RULE / repository identity
- Subject: which repositories are canonical
- Canonical owner: .ai/rules/repository.md
- Action: KEEP

This is repository infrastructure and does not belong in workflow.md or project architecture docs.

## 8.2 Repository boundary: AIP Mirror vs external SDK

Current content defines that the Adobe Illustrator SDK remains external and canonical and must not be copied wholesale into AIP Mirror.

Classification:
- Kind: RULE
- Subject: repository boundary and external reference ownership
- Canonical owner: .ai/rules/repository.md
- Action: KEEP

Related project-specific SDK usage may be documented in docs/, but the repository boundary itself belongs here.

## 8.3 Repository content taxonomy

Current content defines:
- references/
- prototypes/
- docs/
- .ai/

Classification:
- Kind: RULE / routing
- Subject: repository directory ownership
- Canonical owner: .ai/rules/repository.md, unless a more specific repository-layout document is later established
- Action: KEEP for now

Dependency:
- docs/PROJECT-INSTRUCTIONS.md also describes project structure and may duplicate parts of this taxonomy.
- Before moving this content, compare both documents and establish one canonical repository-layout owner.

Do not create a new file merely to hold these few categories unless the comparison proves a stable independent semantic owner is needed.

## 8.4 Conversation state / durable project memory

Current content contains two overlapping sections:
- “Conversation state and durable memory”
- “Repository is the durable project memory”

Classification:
- Kind: RULE
- Subject: repository as durable technical memory
- Canonical owner: split by semantic scope:
  - generic AI continuity / conversation durability → .ai/rules/handoff/lifecycle.md
  - repository-level documentation persistence → .ai/rules/repository.md
- Action: DE-DUPLICATE / SPLIT

The repository rule should retain only the repository-facing principle:
important technical knowledge that must survive conversations belongs in version-controlled project files.

Conversation-specific migration state belongs to handoff infrastructure and should not be redefined here.

The two current repository.md sections must not survive as duplicated formulations.

## 8.5 Generated output and secrets

Current content defines:
- do not commit local build output;
- do not commit secrets.

Classification:
- Kind: RULE
- Subject: repository hygiene
- Canonical owner: .ai/rules/repository.md
- Action: KEEP

These are concrete repository integrity rules and are not commit-message rules.

The distinction is:
- repository.md → what must not enter the repository;
- commits.md → how to create and verify a commit.

## 8.6 Commit coherence

Current content has a “Keep commits coherent” rule.

Classification:
- Kind: RULE
- Canonical owner: .ai/rules/commits.md
- Action: REMOVE FROM repository.md

This is now fully represented by the commit rules.

repository.md should not repeat it.

## 8.7 Traceability / decisions in documentation

Current content requires important architectural decisions to be represented in repository documentation.

Classification:
- Kind: RULE
- Canonical ownership: potentially overlaps with .ai/rules/workflow.md
- Action: KEEP only if repository-specific; otherwise route to workflow.md

Boundary:
- workflow.md → general principle that stable decisions should be documented;
- repository.md → repository durability/mechanics only.

Avoid keeping two near-identical “document decisions” rules.

## 8.8 Repository growth

Current content discourages unnecessary directory trees and placeholder files.

Classification:
- Kind: RULE
- Subject: repository structure hygiene
- Canonical owner: .ai/rules/repository.md
- Action: KEEP

This is a repository-specific constraint and should not move into generic workflow.

## 8.9 External projects

Current content repeats the Adobe SDK boundary in broader terms.

Classification:
- Kind: RULE
- Canonical owner: .ai/rules/repository.md
- Action: MERGE with 8.2

Do not preserve two versions of the same external-repository boundary.

## 8.10 Repository write safety

Current content defines the canonical full-content API safety sequence and integrity requirements.

Classification:
- Kind: RULE
- Subject: repository mutation safety
- Canonical owner: .ai/rules/repository.md
- Action: KEEP as the sole normative sequence

The sequence is:

READ CURRENT FILE
→ minimal change
→ WRITE COMPLETE FILE
→ READ BACK
→ VERIFY CONTENT
→ INSPECT DIFF
→ VERIFY SCOPE
→ COMMIT
→ VERIFY RESULT

Other rules may route to this section but must not reproduce it.

## 8.11 Accidental aggregation summary

repository.md currently contains several semantic groups:

1. repository identity and external boundaries;
2. repository directory taxonomy;
3. durable-memory policy;
4. repository hygiene;
5. commit policy;
6. documentation traceability;
7. repository growth;
8. write safety.

The physical DECOMPOSE should not automatically create eight files.

Target:
- keep stable repository-owned rules together;
- remove commit policy because it has a canonical owner in commits.md;
- merge duplicate external-boundary sections;
- eliminate duplicate durable-memory text;
- remove workflow-level documentation duplication where appropriate;
- retain write safety as the canonical repository mutation rule.

## 8.12 Dependency direction after repository decomposition

Desired routing:

    workflow.md
        ↓
    generic development principles

    commits.md
        ↓
    commit policy

    repository.md
        ↓
    repository identity, layout, hygiene, and write safety

    handoff/lifecycle.md
        ↓
    conversation lifecycle and handoff continuity

    docs/
        ↓
    AIP Mirror project semantics

repository.md may be referenced by commits.md, workflow.md, and handoff infrastructure, but should not absorb their semantic policies.

## 8.13 Physical decomposition target

Do not split repository.md mechanically yet.

First:
1. compare its repository taxonomy with docs/PROJECT-INSTRUCTIONS.md;
2. identify the canonical owner for shared directory-layout facts;
3. remove commit coherence;
4. merge the duplicate external-repository rules;
5. collapse the duplicate durable-memory sections;
6. separate repository-specific traceability from generic workflow documentation;
7. preserve write safety as the sole canonical mutation-safety sequence;
8. then rewrite repository.md as the smallest coherent repository rule set.

No new file is justified by the current map yet.

# 9. docs/PROJECT-INSTRUCTIONS.md

## 9.1 Repository and handoff infrastructure

Repository identity, path resolution, repository structure/hygiene, commit policy, chapter identifier semantics, conversation lifecycle, and handoff mechanics have stronger canonical owners in .ai/rules/repository.md, .ai/rules/commits.md, .ai/rules/handoff/lifecycle.md, .ai/skills/handoff/, and .ai/workflows/handoff-bootstrap/.

Action: REMOVE duplicated infrastructure policy from PROJECT-INSTRUCTIONS.md. Do not create new files merely to receive these sections.

## 9.2 Project orientation

PROJECT-INSTRUCTIONS.md may retain genuinely project-specific orientation: what AIP Mirror is, its purpose, and the minimum project context needed to work correctly.

Action: KEEP only material without a stronger canonical owner. Do not turn this into a second project architecture document.

## 9.3 Workstream / specialization model

The historical closed list of 01–04 must leave PROJECT-INSTRUCTIONS.md. The project now has at least 01–06, and future workstreams may be added.

Canonical meaning of workstreams belongs to project documentation, not AI infrastructure.

Distinction:
- workstream model → project documentation;
- workstream coordination → PROJECT-INSTRUCTIONS.md;
- chapter identifier mechanics → handoff lifecycle.

PROJECT-INSTRUCTIONS.md must not become the canonical registry of workstream names.

## 9.4 Project architecture and JSX → native pipeline

Research → specification → JSX → validation → native C++, native AIP strategy, geometry, interactive behavior, and UI technology decisions belong to docs/architecture/ or a more specific existing project-document owner.

Action: REMOVE duplicated project architecture from PROJECT-INSTRUCTIONS.md; route to the canonical project documents.

## 9.5 Testing

The generic principle belongs to .ai/rules/workflow.md. The concrete AIP Mirror testing model, including geometry → behavior → Illustrator integration, belongs to project architecture/documentation.

Action: REMOVE duplicated testing policy; do not create a new testing file without evidence that a durable owner is needed.

## 9.6 Documentation/evidence discipline

Observed fact, inference, assumption, specification, and implementation detail already form part of the reusable methodology in .ai/skills/deep-understanding/SKILL.md, which applies to JSX, C++, SDK study, reverse engineering, and other non-trivial work.

Action: DO NOT create a second canonical evidence/documentation model merely because PROJECT-INSTRUCTIONS.md contains similar wording. Do not add a project-specific reference to deep-understanding unless a genuine AIP Mirror-specific documentation model is established.

## 9.7 Cross-workstream coordination

Four principles are genuine project-wide instructions and may remain in PROJECT-INSTRUCTIONS.md:

1. Workstreams are organizational boundaries, not permanent ownership of all knowledge they produce.
2. Results produced by one workstream may become inputs to another.
3. Canonical project knowledge belongs to its semantic owner, not to the workstream that happened to discover it.
4. Cross-workstream continuity must use durable repository knowledge rather than conversation history alone.

These principles do not depend on the current number or names of workstreams.

## 9.8 Architectural ownership across workstreams

Do not preserve a rule equivalent to “03 owns architecture” merely because 03 historically carried Architecture & Research.

Any workstream may discover architectural evidence or identify an architectural decision. Canonical architectural knowledge belongs to the appropriate semantic owner in docs/architecture/, regardless of which workstream discovered it.

## 9.9 PROJECT-INSTRUCTIONS.md versus AGENTS.md and INDEX.md

Working semantic distinction:

    AGENTS.md
        ↓
    agent entry point

    .ai/INDEX.md
        ↓
    AI infrastructure discovery / routing

    docs/PROJECT-INSTRUCTIONS.md
        ↓
    AIP Mirror project-specific instructions / coordination

These documents may reference one another, but none should become a general-purpose duplicate of the others. Additional AGENTS.md files may later exist in subdirectories without changing this distinction.

## 9.10 Final semantic role

PROJECT-INSTRUCTIONS.md should become a thin project instruction layer containing:
- project orientation;
- genuinely project-specific operating instructions;
- project-level canonical-source routing where useful;
- the small set of cross-workstream coordination principles above.

It must not become a second INDEX, repository rules document, handoff document, complete architecture document, workstream registry, or copy of deep-understanding methodology.

## 9.11 Physical DECOMPOSE precondition

Before rewriting PROJECT-INSTRUCTIONS.md:
1. read the current file again;
2. read the current canonical owners;
3. apply KEEP / REMOVE / REFERENCE decisions section by section;
4. verify that removed material has not merely been moved into a new duplicate file;
5. keep the resulting file small and semantically coherent;
6. read it back;
7. inspect diff and changed-file scope;
8. commit the decomposition as one coherent refactor.

Do not archive material as part of this physical DECOMPOSE.