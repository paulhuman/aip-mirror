# FAQ: Adapting `.ai/` to a New Project

## Purpose

This FAQ explains how to copy the `.ai/` infrastructure from `aip-mirror` into a different repository and adapt it without accidentally carrying the Illustrator-specific project identity into the new project.

Example target project:

> **Sprite Sheet Editor** — desktop application using Rust + Tauri + Python + Pillow.

The key idea is:

```text
.ai/ = reusable AI infrastructure
config.yaml + docs/ + selected history = project-specific context
```

Do not treat the current `aip-mirror` repository as a clean project template. It contains both reusable infrastructure and historical/project-specific material.

---

## 1. What must change?

There are four practical categories.

| Category | Action | Typical examples |
| --- | --- | --- |
| Project identity | MUST change | repository name, project name, branch, hosting |
| Project knowledge | MUST replace | `docs/PROJECT-INSTRUCTIONS.md`, project architecture |
| Embedded project references | MUST change or generalize | hardcoded GitHub URLs, test locators, project examples |
| Historical material | SHOULD remove/reset | old handoffs, old test results, AIP Mirror research, old references |

The most important misconception is:

> `config.yaml` is the main project-specific configuration file, but it is not the only place where project-specific data can appear.

---

# 2. First step: decide what you are actually copying

A useful new-project starting point is:

```text
Copy:
    .ai/AGENTS.md
    .ai/INDEX.md
    .ai/config.yaml              ← replace
    .ai/rules/
    .ai/skills/
    .ai/workflows/
    .ai/architecture/README.md
    .ai/architecture/faq/
    .ai/architecture/tests/     ← after checking scenarios
    docs/                        ← replace project-specific documents

Do NOT blindly copy:
    .ai/handoffs/
    .ai/archive/
    old project references/
    old runtime test results/
    old project architecture/research
```

If the entire repository is copied, perform a cleanup pass before starting the new project.

---

# 3. `.ai/config.yaml` is the primary project configuration

This is the first file to replace.

For Sprite Sheet Editor, the beginning might conceptually become:

```yaml
project:
  name: Sprite Sheet Editor
  repository: <owner>/sprite-sheet-editor
  default_branch: main
  hosting:
    type: github
    base_url: https://github.com/
```

### 3.1 `project`

Change:

- `project.name`
- `project.repository`
- `project.default_branch`
- `project.hosting` if the new project uses another hosting provider

These values are used by repository/path-resolution and bootstrap infrastructure.

### 3.2 `references.repositories`

This section is also project-specific.

For AIP Mirror it contains Illustrator SDK, Spectrum Web Components, Codex, Skills, and agent.md references.

For Sprite Sheet Editor, replace these with references actually relevant to the new project, for example:

- Tauri documentation/reference repository;
- Rust ecosystem references;
- Pillow/Python references;
- any project-specific research repositories.

Do not keep a reference merely because it existed in the template.

### 3.3 `specializations`

Specializations are project vocabulary, not universal AI-infrastructure constants.

For example, a new project could define:

```yaml
specializations:
  A:
    short_name: Project Workshop
  B:
    short_name: Tauri UI
  C:
    short_name: Architecture & Research
  D:
    short_name: Python Image Processing
```

Every project using this infrastructure MUST reserve specialization `A` for `Project Workshop`. Other specialization letters and names are project-specific.

If you change them, make sure existing handoff files are not copied into the new repository with incompatible names.

### 3.4 `terminology.commit_scopes`

Replace the AIP Mirror scopes:

```text
mirror
geometry
plugin
adm
jsx
sdk
```

with scopes meaningful to the new project, for example:

```text
core
tauri
ui
python
pillow
rust
docs
tests
```

### 3.5 `terminology.project_terms`

Replace Illustrator/FreeHand terminology with the vocabulary of the new project.

For example:

```text
sprite sheet
atlas
frame
texture region
Rust core
Tauri integration
Python tooling
Pillow
```

This section is important because the commit skill explicitly uses configured terminology when constructing project-facing commit messages and descriptions.

---

# 4. `docs/PROJECT-INSTRUCTIONS.md` must be rewritten

This is the largest project-specific document outside `config.yaml`.

The AIP Mirror version contains:

- Adobe Illustrator assumptions;
- FreeHand behavioral targets;
- JSX prototype workflow;
- native C++ / AIP implementation;
- Illustrator-specific milestones;
- AIP Mirror workstream language;
- Illustrator SDK references.

For Sprite Sheet Editor, replace the entire document with the equivalent project contract.

For example, it should describe things such as:

```text
Project purpose
    ↓
Rust application core
    ↓
Tauri integration
    ↓
frontend/UI
    ↓
Python/Pillow tooling
    ↓
validation/tests
```

Do not try to preserve AIP Mirror's development chain and simply rename technologies. The architecture itself is different.

Keep the document thin. It should provide:

- project orientation;
- project-specific constraints;
- project behavioral requirements;
- workstream coordination;
- routing to canonical project documentation.

It should NOT become a second `.ai/INDEX.md`, repository rulebook, or handoff manual.

---

# 5. `docs/architecture/project-architecture.md` must be replaced

This is also project-specific.

The current file contains AIP Mirror architecture such as:

- JSX prototype versus production plugin;
- C++ + Illustrator AIP;
- Illustrator SDK boundary;
- mirror geometry;
- FreeHand behavior;
- Illustrator integration;
- four AIP Mirror specializations.

For Sprite Sheet Editor this should become the project's actual architecture, for example:

```text
Rust
  = application/core logic

Tauri
  = desktop application boundary

Frontend
  = presentation and interaction

Python + Pillow
  = image-processing/tooling boundary
```

The exact architecture belongs to the new project, not to the reusable `.ai` infrastructure.

---

# 6. Files inside `.ai/` that contain project-specific material

Most `.ai` files are intentionally generic. A few are not completely generic.

## 6.1 `.ai/skills/handoff/SKILL.md`

This file is mostly reusable, but the current version contains a hardcoded repository locator:

```text
https://github.com/paulhuman/aip-mirror
```

It appears in generated/manual bootstrap transport examples.

For a reusable template, this should be generalized so the actual repository locator is derived from `.ai/config.yaml`, rather than being permanently embedded as an AIP Mirror URL.

Any project-specific illustrative sentence should be neutralized or removed when adapting the infrastructure.

The semantic handoff procedure itself should remain.

---

## 6.2 `.ai/workflows/handoff/BOOTSTRAP.md`

This is another mostly reusable file with an important embedded project reference.

It currently contains:

```text
https://github.com/paulhuman/aip-mirror
```

The workflow already states that generated repository locators come from:

```text
project.hosting.base_url
project.repository
```

Therefore the reusable workflow should not contain a literal AIP Mirror URL as if it were the new project's canonical locator.

Its example:

```text
SPECIALIZATION = A
SHORT_NAME = Project Workshop
```

is the canonical neutral example and SHOULD remain unchanged. It is an example, not project configuration.

---

## 6.3 `.ai/architecture/tests/cold-start-command-trace.md`

The test scenario is conceptually reusable, but it currently hardcodes:

```text
paulhuman/aip-mirror@main:/.ai/AGENTS.md
```

For a new project, this must be generalized or parameterized.

The scenario also mentions the current five-command surface. That list is intentionally derived from the current `.ai/INDEX.md`, so the scenario should retain that dynamic rule rather than hardcoding AIP Mirror commands as the expected permanent command set.

The correct reusable principle is:

```text
explicit repository locator
    ↓
AGENTS
    ↓
bootstrap
    ↓
current INDEX command surface
    ↓
cold-start test
```

---

## 6.4 `.ai/rules/handoff/lifecycle.md`

The `A0001 / Project Workshop` example is the canonical neutral example of the filename/chapter contract.

Keep it when adapting the infrastructure to another project. It is an example of the required generic `A` specialization, not a project-specific technology name.

The actual chapter format and lifecycle rules are reusable.

---

## 6.5 `.ai/handoffs/README.md`

Same principle.

Its `A0001 / Project Workshop` example is a neutral format example, not an active project dependency.

Keep this example unchanged when adapting the infrastructure to another project.

Do not copy the actual AIP Mirror handoff files themselves.

---

# 7. `.ai/INDEX.md`

Normally this should require little or no project-specific editing.

Its role is to route commands to canonical infrastructure owners.

However, verify it after adapting:

- command names;
- canonical owner paths;
- capability map;
- structural references.

Do not add project architecture or project technology descriptions to INDEX merely because the new project uses Rust, Tauri, Python, etc.

Project technology belongs in `docs/PROJECT-INSTRUCTIONS.md` and project architecture documentation.

---

# 8. `.ai/AGENTS.md`

Normally this should remain unchanged.

It describes the AI infrastructure entry contract and points new-chapter initialization to BOOTSTRAP.

Do not put Sprite Sheet Editor-specific instructions here unless there is a genuine repository-wide AI infrastructure requirement.

The distinction is:

```text
AGENTS
    = how the AI infrastructure enters the repository

PROJECT-INSTRUCTIONS
    = what this particular project is
```

---

# 9. `.ai/rules/`

The rules are intended to be reusable.

Normally keep:

- `repository.md`
- `workflow.md`
- `commits.md`
- `handoff/lifecycle.md`
- `handoff/references.md`
- `normative-language.md`

After copying, check them for:

1. literal repository URLs;
2. project names;
3. project technology assumptions;
4. examples that could be mistaken for active configuration.

Do not rewrite a generic rule merely because its examples use AIP Mirror terminology.

The goal is to separate **example data** from **semantic rules**.

---

# 10. `.ai/skills/`

The skills are mostly reusable capabilities.

Keep the infrastructure skills:

- activation;
- commits;
- deep-understanding;
- explain-code;
- handoff;
- reference-preservation;
- normative-language.

Then check each skill for project-specific examples or hardcoded repository locators.

The important rule is:

> Change project-specific examples and references, not the reusable capability semantics.

For example, the handoff skill needs repository-locator generalization because that locator is part of its transport procedure. A generic code-explanation skill does not need to be rewritten just because the new project uses Rust instead of C++.

---

# 11. `.ai/workflows/`

The handoff bootstrap workflow is reusable, but its repository locator examples must not become a hidden dependency on AIP Mirror.

The independent-review onboarding files are optional infrastructure.

If the new project will not use Qwen/Grok independent-review conversations, they can be removed. If they are retained, verify that their wording describes a generic review role rather than AIP Mirror-specific responsibilities.

---

# 12. `.ai/architecture/`

This directory has two different kinds of content.

## Reusable infrastructure material

Keep:

- `.ai/architecture/README.md`
- reusable FAQ material;
- reusable architecture test scenarios after checking them.

## AIP Mirror historical material

The current:

```text
.ai/architecture/ai-infrastructure-restructuring.md
```

is an architecture-history document for this repository's infrastructure evolution.

It is useful as historical evidence for AIP Mirror, but it should not automatically become part of a fresh Sprite Sheet Editor project.

For a copied template, remove it or replace it with the new project's own architecture-history document if one is needed.

---

# 13. `.ai/architecture/tests/results/`

Do not copy old runtime results into a new project.

For example:

```text
.ai/architecture/tests/results/cold-start-command-trace/...
.ai/architecture/tests/results/trace-runtime-presentation/...
```

are evidence about previous runs of this repository's infrastructure.

They are historical records, not reusable project configuration.

For a new project:

1. keep the reusable test scenario;
2. remove old result artifacts;
3. run the test against the new repository;
4. create new result artifacts with the new repository revision and runtime context.

---

# 14. `.ai/handoffs/`

Treat the current handoffs as disposable project state when creating a new project from this repository.

Do not carry the existing project handoff files into the new repository.

The canonical `A0001-Project-Workshop.md` shown above is a format example only. It is not a handoff to copy into the new project.

Instead:

1. create the new project's specialization vocabulary in `.ai/config.yaml`;
2. start the first chapter of each required specialization from chapter `0001`;
3. use the canonical bootstrap procedure;
4. let new handoffs be generated from the new project's actual work.

The README may remain as generic orientation.

---

# 15. `.ai/archive/`

Do not treat the archive as active infrastructure.

The current archive contains historical AIP Mirror architecture and handoffs.

When creating a new project from this repository, the safest default is:

```text
.ai/archive/
    = remove from the new project
```

If the archive contains a genuinely reusable infrastructure decision, manually extract that knowledge into the corresponding generic rule/skill/workflow/FAQ instead of copying the entire historical archive.

This prevents historical AIP Mirror decisions from silently becoming requirements of Sprite Sheet Editor.

---

# 16. `references/`

The current repository contains AIP Mirror research material such as:

- FreeHand manuals;
- Illustrator JavaScript documentation;
- Illustrator test screenshots;
- FreeHand test videos.

These are project-specific research references.

They should not be copied into Sprite Sheet Editor unless a reference is independently relevant.

For the new project, replace them with relevant material, for example:

```text
references/
    tauri/
    rust/
    python/
    pillow/
    image-formats/
    test-data/
```

The exact taxonomy is a project decision.

---

# 17. AIP Mirror-specific files outside `.ai/`

This is easy to miss because the request may sound like an `.ai` migration.

The current repository also has project-specific files under:

```text
docs/
references/
```

and potentially project source/prototype/test directories as the implementation grows.

The `.ai` infrastructure does not make those files reusable.

A copied repository therefore needs two separate audits:

```text
Audit A
.ai/
AI infrastructure + embedded project references

Audit B
repository root / docs / references / source
actual project implementation and knowledge
```

---

# 18. Recommended Sprite Sheet Editor adaptation

A practical sequence is:

### Step 1 — Copy

Copy the repository structure into the new repository.

### Step 2 — Reset project identity

Replace `.ai/config.yaml`.

### Step 3 — Replace project instructions

Rewrite:

```text
docs/PROJECT-INSTRUCTIONS.md
docs/architecture/project-architecture.md
```

### Step 4 — Generalize embedded repository locators

Check:

```text
.ai/skills/handoff/SKILL.md
.ai/workflows/handoff/BOOTSTRAP.md
.ai/architecture/tests/cold-start-command-trace.md
```

for the old repository URL and make those references configuration-driven or neutral.

### Step 5 — Reset conversation state

Remove old:

```text
.ai/handoffs/<old-specializations>/*
.ai/archive/handoffs/*
```

Keep only the generic handoff README if desired.

### Step 6 — Reset historical architecture evidence

Remove old AIP Mirror architecture history and runtime test results.

### Step 7 — Replace research references

Remove FreeHand/Illustrator material and add references relevant to the new application.

### Step 8 — Define the new project vocabulary

Update:

```text
specializations
terminology.commit_scopes
terminology.project_terms
references.repositories
```

in `.ai/config.yaml`.

### Step 9 — Review the active command surface

Check `.ai/INDEX.md`.

Keep the infrastructure commands that are useful for the new project. Do not create new commands merely because the technology stack changed.

### Step 10 — Bootstrap the first real chapter

Use the canonical:

```text
.ai/AGENTS.md
    ↓
.ai/workflows/handoff/BOOTSTRAP.md
```

path.

Do not invent a special "new project initialization" command.

---

# 19. Final adaptation checklist

Before starting real development, verify:

- [ ] `.ai/config.yaml` contains the new repository identity.
- [ ] `references.repositories` contains only relevant external references.
- [ ] `specializations` describes the new project's work areas.
- [ ] `terminology.commit_scopes` uses the new project's vocabulary.
- [ ] `terminology.project_terms` uses the new project's vocabulary.
- [ ] `docs/PROJECT-INSTRUCTIONS.md` has been completely replaced.
- [ ] `docs/architecture/project-architecture.md` has been completely replaced.
- [ ] No active workflow contains the old repository URL.
- [ ] No active test scenario contains the old repository locator.
- [ ] Old handoffs have been removed.
- [ ] Old archive/history has been removed or deliberately retained with a reason.
- [ ] Old project references have been removed.
- [ ] Old runtime test results have been removed.
- [ ] `.ai/AGENTS.md` still points to the canonical bootstrap workflow.
- [ ] `.ai/INDEX.md` still points to valid canonical owners.
- [ ] Generic rules remain generic.
- [ ] Generic skills remain generic.
- [ ] Bootstrap still resolves repository identity from `.ai/config.yaml`.
- [ ] A first new chapter can be initialized without guessing any AIP Mirror-specific data.

---

# 20. The shortest mental model

When turning `aip-mirror` into another project, think in three layers:

```text
┌─────────────────────────────────────────────┐
│ GENERIC AI INFRASTRUCTURE                   │
│                                             │
│ AGENTS / INDEX / rules / skills / workflows │
│                                             │
│ Mostly keep                                 │
└─────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────┐
│ PROJECT IDENTITY + PROJECT CONTRACT         │
│                                             │
│ config.yaml                                 │
│ docs/PROJECT-INSTRUCTIONS.md                │
│ docs/architecture/                          │
│                                             │
│ Replace                                    │
└─────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────┐
│ PROJECT HISTORY + RESEARCH                  │
│                                             │
│ handoffs / archive / references / results   │
│                                             │
│ Reset, remove, or deliberately replace      │
└─────────────────────────────────────────────┘
```

The most dangerous state is the hybrid one: a new project with a correct `config.yaml` but old AIP Mirror assumptions still hiding in `docs/`, handoff transport, test scenarios, archives, or references.
