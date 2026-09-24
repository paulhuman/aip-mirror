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
