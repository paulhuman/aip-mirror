# AI infrastructure vNext — multi-host architecture proposal

**Status:** design proposal, not an implementation decision
**Current-state note (2026-10-09):** This proposal predates the approved rules-to-skills migration. References below to `.ai/rules/`, first-level handoff skills, and `.ai/workflows/handoff/BOOTSTRAP.md` describe the proposal-time repository state and are not current routing. Use `.ai/INDEX.md` and `.ai/README.md` for current owner paths.
**Supersedes:** the `agentic-ai-*` research series (2026-10-07…08), which is now
evidence, not a plan
**Scope:** how `.ai/` serves two incompatible classes of AI consumers from one
canonical source

---

## 1. Purpose

This note proposes the next version of the `.ai/` infrastructure for AIP Mirror
and, more importantly, as a **portable template** for other projects.

The driving requirement is unchanged: one project, two AI consumers.

```text
                    .ai/  (one canonical source)
                            |
            +---------------+---------------+
            |                               |
     Chat AI + Connector            Agentic AI (DSH)
     no working copy                real working copy
     API read / full-content PUT    shell, git, local tools
     cannot follow symlinks         scans fixed discovery roots
```

The previous research series established that these two classes differ in
discovery, packaging, activation, and execution. It did **not** produce a
concrete adapter design. This note does.

This document is supporting/contextual material. It does not replace
`.ai/rules/`, `.ai/skills/`, `.ai/workflows/`, or `.ai/INDEX.md`.

---

## 2. Evidence base

Everything below rests on facts verified in this work session. Two categories
are kept strictly apart.

### 2.1 Verified against source or by experiment

| # | Finding | How verified |
|---|---|---|
| V1 | DSH discovers skills in six ranked roots; lower rank wins | DSH `dsh-skill-filesystem` source |
| V2 | `.ai/skills` is **not** a DSH discovery root | zero `.ai/skills` occurrences in DSH bundle |
| V3 | Skill discovery scans **one level only**; nested `**/SKILL.md` is invisible | source: `join(entry.path, "SKILL.md")` |
| V4 | DSH auto-loads `AGENTS.md` / `CLAUDE.md` / `*.local.md` by walking from the `.git` root down to cwd **and** to touched directories | `dsh-agent-instructions` source |
| V5 | `.ai/AGENTS.md` is **not** found from the project root unless the agent touches files inside `.ai/` | same source: discovery is directory-chain based |
| V6 | Committed symlink on Windows with `core.symlinks=false` materializes as a **plain text file** holding the target string — 12 bytes for `../.ai/rules`, 13 for `../.ai/skills`; `readdir` then fails `ENOTDIR` | experiment: clone round-trip, re-confirmed on `adobe/spectrum-web-components` |
| V7 | DSH treats `ENOTDIR` as "root absent" and **silently** skips it — no error | source: `isAbsentSkillPathError` |
| V8 | Directory **junction** works as a skill root and needs no admin rights | experiment |
| V9 | Git does **not** track a junction as a link — it indexes the files behind it, duplicating content | experiment: two identical blobs |
| V10 | GitHub API and `raw.githubusercontent` return **404** through a symlink; the symlink blob itself is readable as text | experiment against a live repo |
| V11 | The Connector reads `.ai/skills/<name>/SKILL.md` **directly**, with no symlink needed | API fetch of `explain-code/SKILL.md` |
| V12 | DSH ignores unknown front matter keys | experiment with `license`, `allowed-tools`, `metadata`, `paths` |
| V13 | DSH has no audience/agent-only field, and no user-facing prompt-editing API | DSH source |
| V14 | Directory junction may be created without elevation; symbolic link creation succeeded in this shell but Developer Mode is off, so it is **not** guaranteed for the user | registry + experiment |
| V15 | Symlink creation needs `SeCreateSymbolicLinkPrivilege`, **not** Developer Mode specifically. With `core.symlinks=true` a Windows clone materializes real `SymbolicLink` entries whose targets resolve to the same inode as the canonical directory; the privilege was enabled via `S-1-5-32-544` while Developer Mode stayed off | re-clone of `adobe/spectrum-web-components` + `whoami /priv` + `AppModelUnlock` probe |
| V16 | A checkout broken by `core.symlinks=false` is repaired in place; a re-clone is not required. `git restore -- .claude .cursor` rewrites the paths as real symlinks and leaves `git status` clean | experiment on a deliberately broken clone |
| V17 | `readlinkSync` returns **backslash-separated** targets on Windows, so the upstream `validate-symlinks.js` strict `!==` against `'../.ai/rules'` reports 3 false failures on a healthy Windows clone. Its CI runs `yarn lint:ai` on `ubuntu-latest`, where separators match | faithful replay of the upstream check |

### 2.2 From the reference implementation, read directly

The `paulhuman/spectrum-web-components` fork is the working precedent this
infrastructure was modelled on. Its relevant, observed choices:

- canonical content in `.ai/`; tool directories are **thin adapters**;
- exactly **three** tracked symlinks, all mode `120000`: `.claude/rules` →
  `../.ai/rules`, `.claude/skills` → `../.ai/skills`, `.cursor/skills` →
  `../.ai/skills`. The two identical targets share one blob;
- `.github/instructions/*.instructions.md` and `.cursor/rules/*.mdc` are
  **generated** by `.ai/scripts/sync.js`, never hand-edited. The `.mdc` files
  were per-file symlinks until commit `4c97b0dd34`; they became generated files
  because Cursor reads `globs:` where Claude reads `paths:`, and one `.ai/`
  source must serve both;
- `AGENTS.md` at the repository root is a **thin router table**, not a
  knowledge dump;
- rules carry `paths:` front matter (path-scoped); skills are task-scoped;
- a validator enforces that **skills are exactly one level deep**, that `name`
  equals the directory, and that `description` fits the host limits;
- `yarn lint:ai` plus a pre-commit hook keep generated copies from drifting.

Two cautions learned from re-observing that repository on Windows (V15–V17):
its symlink model needs a privilege to *create* the links, and its own link
validator gives three false failures on a healthy Windows clone because it
compares targets separator-sensitively.

### 2.3 Explicitly not verified here

- Upstream DeepSeek Harness documentation URLs cited by the older survey.
- Whether Gemini CLI, Codex, or Claude Code still read `.agents/skills` as the
  older survey claimed. Treat as unconfirmed.

---

## 3. The core problem

The infrastructure has **one semantic source and two incompatible access
mechanisms**. Every previous document treated this as a portability question.
It is really a **discovery** question, and discovery is host-local.

```text
                     .ai/skills/<name>/SKILL.md
                              |
              +---------------+---------------+
              |                               |
      Connector can read it            DSH cannot find it
      (by explicit path)               (not in any scanned root)
```

Two hard constraints collide:

1. **DSH only scans fixed roots.** `.ai/skills` is not one of them (V2).
2. **The obvious fix — a committed symlink — is fragile exactly where this user
   works.** On a Windows clone the link becomes a text file (V6) and DSH skips
   the root silently (V7). Nothing reports the failure.

A third constraint removes the naive workaround: a junction solves Windows but
breaks git, because git duplicates the linked content into the index (V9).

So there is no single mechanism that is simultaneously link-free, tracked,
cross-OS, and DSH-discoverable — except generating real files.

---

## 4. Design principles

1. **One semantic owner.** `.ai/` stays canonical. No second registry, no
   per-host copies of rules or procedures.
2. **Adapters are disposable.** Any host-specific artifact must be
   regenerable from `.ai/` and must be safe to delete.
3. **Discovery is host-local; semantics are not.** Never let a host's packaging
   shape leak into the canonical artifact.
4. **Failures must be loud.** The current silent-skip behaviour (V7) is the
   worst property of the status quo. Anything that can silently disappear needs
   a check.
5. **Applicability follows capability, not labels.** There is no audience field
   (V13), so a skill that requires a tool-using agent should say so by naming
   the tool.
6. **Zero-adapter first.** Prefer the mechanism that works everywhere with no
   setup; add adapters only where the ergonomic gain justifies the fragility.

---

## 5. Proposed architecture

Three layers, with a strict rule: **only Layer 1 owns meaning.**

```text
LAYER 1 — canonical semantics (host-agnostic, the only owner)
    .ai/config.yaml        project identity + configured references
    .ai/rules/             constraints
    .ai/skills/            task-scoped capabilities
    .ai/workflows/         ordered procedures
    .ai/INDEX.md           operation routing + capability map

LAYER 2 — host adapters (thin, generated or linked, never authoritative)
    AGENTS.md              universal entry point (all AGENTS.md-aware hosts)
    .agents/skills/        DSH rank 200 + cross-host convention
    .github/instructions/  generated for Copilot
    .cursor/rules/         generated for Cursor

LAYER 3 — host runtime (outside the repository)
    $DSH_HOME/profiles/web/cordis.patch.yml   personal skill roots, plugin config
    $DSH_HOME/AGENTS.md                       personal always-on instructions
    ~/.dsh/skills                             personal global skills
```

### 5.1 Repository shape

```text
<project>/
├── AGENTS.md                     ← universal router (COMMITTED, hand-written)
├── .ai/
│   ├── config.yaml
│   ├── INDEX.md                  ← operation routing (unchanged role)
│   ├── AGENTS.md                 ← internal operating contract (see §6.3)
│   ├── README.md                 ← catalog + authoring guide
│   ├── rules/                    ← *.md, optional paths: front matter
│   ├── skills/                   ← <name>/SKILL.md, EXACTLY one level
│   ├── workflows/
│   ├── templates/
│   ├── handoffs/
│   ├── docs/
│   ├── tests/
│   ├── scripts/                  ← NEW: sync + validate (see §9)
│   └── archives/
├── .agents/
│   └── skills/                   ← adapter: link OR generated pointers (see §7)
├── .github/instructions/         ← adapter: generated (optional)
└── .cursor/rules/                ← adapter: generated (optional)
```

`.ai/scripts/` is the one genuinely new directory. It is what turns the
adapters from fragile hand-maintained links into a checked, regenerable
artefact.

---

## 6. `AGENTS.md` as the universal entry point

This is the single highest-value change, because it is the only file that
**every** host in scope reads automatically (V4), needs no adapter, and is
already an open cross-vendor standard.

### 6.1 Move it to the repository root

Today the operating contract lives at `.ai/AGENTS.md`. From the root it is
invisible to DSH unless the agent happens to touch a file inside `.ai/` (V5).

```text
today:  .ai/AGENTS.md        found only by accident
target: AGENTS.md            found always, by every host
```

### 6.2 Keep it thin

The root `AGENTS.md` must be a **router**, not a knowledge dump. Its job:

1. state that `.ai/` is canonical;
2. give the table of where things live and when they load;
3. name the always-relevant obligations (repository context, write safety);
4. point to `.ai/INDEX.md` for operations and `.ai/README.md` for the catalog.

The reference implementation does exactly this and it is the right model.
Long procedures belong in skills, not here — a rule of thumb worth enforcing:
warn when an instruction file exceeds ~12 KB.

### 6.3 What happens to `.ai/AGENTS.md`

Keep it as the **internal** operating contract for work performed *inside*
`.ai/`, and have the root file reference it. This is not duplication: the root
file routes, the internal file owns the detail. Both are Layer 1/2 boundary
artefacts, and the boundary should be stated in both.

---

## 7. Skills: making one source discoverable

This is the crux. Four options, evaluated against the constraints.

### 7.1 Options

**Option A — committed directory symlink**
`.agents/skills` → `../.ai/skills`, tracked as mode `120000`.

- (+) Zero duplication; the reference implementation's exact choice.
- (+) Verified working on this machine once `core.symlinks=true` and the
  creating user holds `SeCreateSymbolicLinkPrivilege` (V15); Developer Mode is
  not the deciding factor. A broken checkout is also repaired in place by
  `git restore` (V16), not only by re-cloning.
- (−) On a Windows clone whose config resolves `core.symlinks=false` it becomes
  a text file (V6) and DSH skips it **silently** (V7). This is the user's primary
  platform, and creation depends on a privilege that Developer Mode is off for
  (V14, V15). The failure is invisible to git and to the host.
- (−) A naive "does the target match" validator is separator-fragile on Windows
  (V17), so the failure can also go unnoticed by the check meant to catch it.

**Option B — local junction, gitignored, created by script**
`.agents/skills` is a junction on Windows (or symlink on POSIX), excluded from
git and recreated by `.ai/scripts/adapters`.

- (+) Works on Windows with no admin rights (V8); no git content duplication (V9).
- (+) No silent breakage: the script either succeeds or reports.
- (−) Not shared through git; each clone runs one setup command.

**Option C — generated pointer skills**
`.agents/skills/<name>/SKILL.md` is a real, committed, ~6-line file that
carries `name` + `description` and instructs the reader to load
`.ai/skills/<name>/SKILL.md`.

- (+) Fully cross-OS, tracked, Connector-readable, DSH-discoverable.
- (+) Degrades gracefully: the pointer is valid Markdown everywhere.
- (−) One extra read per activation, and a duplicated `description` that can
  drift — mitigated by a validator.

**Option D — no adapter; rely on `AGENTS.md`**
The root `AGENTS.md` carries a skill catalog with descriptions; the agent reads
the matching `.ai/skills/<name>/SKILL.md` on demand.

- (+) Zero setup, zero new files, all hosts, all OSes.
- (−) Skills are absent from the host's native skill listing, so automatic
  description-matching by the host registry does not happen. The agent must
  route through `AGENTS.md` first.

### 7.2 Recommendation

**Layer them. Start with D, add B, treat C as the portable fallback.**

```text
Tier 0  AGENTS.md catalog                    always on, zero setup   ← baseline
Tier 1  .agents/skills link (gitignored)     personal machine ergonomics
Tier 2  generated pointer files              when the repo must be self-sufficient
Tier 3  committed symlink                    POSIX-first teams only
```

Rationale: Tier 0 costs nothing and is the only tier that cannot silently
fail. Tier 1 is worth it for a Windows-primary single-machine workflow (B is
strictly better than A there). Tier 2 is the answer when the template must work
for someone else on an unknown OS without a setup step.

**Do not** commit a symlink as the primary mechanism for a Windows-primary
project. That is the specific trap this design exists to avoid.

### 7.3 The one-level rule

DSH scans a single level (V3), and the reference validator declares nesting an
**error**. The current tree violates this:

```text
.ai/skills/handoff/SKILL.md                        depth 1  OK
.ai/skills/handoff/reference-preservation/SKILL.md depth 2  INVISIBLE to DSH
```

Flatten to `handoff-reference-preservation/SKILL.md`, or adopt the reference
convention of sibling directories with prefixed names
(`migration-prep`, `migration-review`, …). This is a concrete, cheap fix and
should be enforced by the validator.

---

## 8. Rules, and what "two branches" should really mean

The user's framing was: some skills are for chat AI, some for the agent, some
for both. **Do not implement that as an audience split.** There is no audience
field (V13), and a split would create exactly the duplication the architecture
forbids.

Use these three orthogonal distinctions instead.

### 8.1 By loading trigger, not by reader

Borrowed from the reference and worth adopting verbatim:

| Guidance is about | Form | Loads |
|---|---|---|
| specific file paths | rule with `paths:` | deterministically, when a matching file is in context |
| a task or intent | skill | on demand, by description match |
| always-true obligations | root `AGENTS.md` | always |

Choosing wrong is costly in both directions: forcing task guidance into a rule
wastes context or never triggers; forcing file guidance into a skill loses the
deterministic trigger.

### 8.2 By required capability

This is the real answer to "for me or for chat AI". Make applicability follow
from the capability the instruction needs:

```markdown
## Agent-specific procedures

These procedures apply when working as a tool-using agent that can inspect and
modify repository files. They are not instructions for a chat-only assistant
and are not something a user performs manually.
```

This pattern already exists in `.ai/skills/knowledge-capture/SKILL.md` and it
works. The section is inert for a chat AI reading the file (it has no shell) and
load-bearing for an agent. No metadata, no filtering, no second copy.

A stronger variant is to name the tools outright: an instruction that mentions
`pptd_render` or a local `write` tool is self-evidently agent-scoped, because a
Connector-based chat AI cannot call it.

### 8.3 By host, at the adapter layer only

Host differences that cannot be expressed as a capability belong in Layer 2:

- the repository mutation rule keeps host-neutral invariants, and each host's
  *mechanics* stay out of it — GitHub API blob-SHA preconditions for the
  Connector, read-back-and-diff for the agent;
- `>>command` stays a **chat transport convention**. It must not become a
  project-wide semantic primitive, and INDEX must remain invocation-neutral.

---

## 9. Keeping adapters honest

The reference's strongest idea is that adapters are **generated and validated**,
so drift is a build failure rather than a silent regression. This toolkit is the
professional core of the proposal.

```text
.ai/scripts/
├── ai-files.js              shared: front matter parser, inventory, glob engine
├── adapters.js              generate Layer 2 from Layer 1
├── validate-frontmatter.js  contract checks (see below)
├── validate-links.js        every referenced .ai/ path resolves
└── validate.js              entry point
```

Checks worth implementing, all of which catch a real failure mode above:

| Check | Catches |
|---|---|
| skill depth == 1 | V3 — the invisible-skill trap |
| `name` == directory, kebab-case, ≤64 | host rejects mismatched skills |
| `description` present, ≤1024, says when to use | host rejects or ignores |
| adapters match `.ai/` sources | drift |
| adapter paths actually resolve as directories | V6/V7 — the silent-skip trap |
| every `.ai/...` reference in docs exists | broken routing after refactors |
| instruction file size warning >12 KB | context dilution |

The **adapter-resolves** check is the important new one: it turns "skills
silently vanished on this machine" into a failing check.

---

## 10. Personal versus project scope

Already decided and confirmed working:

```text
~/.dsh/skills                    personal, all projects  (DSH rank 300 via customSkillDirs)
$DSH_HOME/AGENTS.md              personal always-on instructions
<project>/.agents/skills         project-scoped         (DSH rank 200)
<project>/.dsh/skills            project-scoped, DSH-only (rank 100)
```

Recommended split:

- **Personal (`~/.dsh/skills`)** — cross-project habits: commit style,
  explanation style, review checklists, knowledge capture.
- **Project (`.ai/skills/`)** — anything referencing project paths, project
  rules, or project vocabulary.
- **Never duplicate** between the two; a personal skill that needs project
  context should read that context at runtime.

Note the asymmetry a project template must document: `customSkillDirs` is a
**global** setting (Layer 3) and cannot be project-relative, so a project
cannot grant itself a custom root. Project discovery must use one of the two
project-relative roots or Tier 0.

---

## 11. Migration sequence

Bounded, reversible, ordered by value.

```text
Step 1  Move the operating contract to the repository root AGENTS.md
        → makes the project legible to every host at once           (no risk)

Step 2  Flatten .ai/skills/handoff/reference-preservation
        → removes a skill that can never be discovered              (no risk)

Step 3  Add .ai/scripts/ with the depth, name, description and
        adapter-resolves checks; wire into the pre-commit path
        → makes silent failure impossible                           (low risk)

Step 4  Add Tier 0: a skill catalog inside the root AGENTS.md
        → agent can route to skills without any adapter              (low risk)

Step 5  Add Tier 1 on the local machine: .agents/skills as a
        gitignored link, created by .ai/scripts/adapters
        → native discovery, no git noise                            (reversible)

Step 6  Archive the superseded research series and record the
        decision (§13)                                              (documentation)
```

Steps 1–4 are the substance and are all host-neutral. Steps 5 is an ergonomic
upgrade, not an architectural requirement.

### Template extraction

Once Steps 1–4 hold, the template is exactly the `.ai/` tree plus a root
`AGENTS.md`, with `.ai/config.yaml` as the only project-specific file. The
portable unit is:

```text
AGENTS.md  +  .ai/{config.yaml,rules,skills,workflows,templates,scripts}
```

This is consistent with the existing rule that generic infrastructure is
project-agnostic and project specifics concentrate in `config.yaml`.

---

## 12. What to archive

The six `agentic-ai-*` documents are now evidence with a superseded frame. Per
the existing archive lifecycle, move them and keep three things in the active
tree.

| Document | Disposition |
|---|---|
| `agentic-ai-compatibility-architecture.md` | **Archive.** Its Phase 1–4 apparatus is closed; the chapter pinning (C0068) is stale by several chapters. Keep only the host-contract layering. |
| `agentic-ai-compatibility-boundaries.md` | **Keep the evidence model** (§ its transport-neutral record), archive the rest. Its "without duplicating" conclusion is unexecutable as written without a discovery mechanism. |
| `agentic-ai-compatibility-capability-audit.md` | **Archive.** Branch-hygiene section is factually wrong (39 branches vs 1), and its inventories predate two skills and one rule. |
| `agentic-ai-dsh-observations.md` | **Keep and upgrade.** The most accurate document in the set. Promote "was reported" to "verified (source)", add the `metadata` field, the hard rejection of legacy camelCase keys, the one-level rule, and the `.system` / `includeDefaultRoots` details. |
| `agentic-ai-environment-survey.md` | **Archive**, retaining the capability-seam matrix and the Finding set. Source URLs for upstream DSH were never verified here. |
| `agentic-ai-owner-seam-audit.md` | **Archive** after folding its gap list into this note. Its owner inventory is missing `ai-infrastructure`, `knowledge-capture`, and `developer-knowledge.md`. |

Three artefacts should remain active:

1. this proposal;
2. an upgraded DSH observations note (verified facts only);
3. the transport-neutral evidence model, relocated into this note or its own
   short file.

Consolidation is part of the value: the same mutation contract is currently
restated in four of the six documents.

---

## 13. Decision summary

| Question | Recommendation |
|---|---|
| Where does `AGENTS.md` live? | Repository root, thin router; keep `.ai/AGENTS.md` as the internal contract |
| Does `INDEX.md` survive? | Yes, unchanged role. Root `AGENTS.md` points to it; `>>` stays a chat convention |
| Split skills by audience? | No. Capability-gated sections inside one skill |
| Native DSH discovery of `.ai/skills`? | Via `.agents/skills` adapter; Tier 0 (`AGENTS.md` catalog) is the baseline |
| Committed symlink? | Not as primary on Windows — it fails silently. Use a gitignored link, or generated pointers |
| New `.ai/interfaces/` layer? | No. Not justified by the evidence, and not needed by this design |
| What is genuinely new? | `.ai/scripts/` (generate + validate) and a root `AGENTS.md` |
| Biggest single win? | Root `AGENTS.md` — one file that makes the project legible to every host at once |

---

## 14. Open questions

1. Which host, if any, other than DSH will actually be used as an agent here?
   The adapter set should follow real usage, not speculation.
2. Should the template ship Tier 1 setup, or stay Tier 0 and let each clone
   opt in?
3. Is `.agents/skills` genuinely cross-host (as the older survey claimed for
   Gemini), or is it effectively DSH-only? This changes whether it is a
   compatibility layer or a DSH adapter.
4. Do `.ai/rules/` need `paths:` front matter? It buys deterministic loading in
   path-aware hosts, but DSH has no rules concept, so the value is
   host-dependent.
5. Should the personal/global split be enforced by a validator, or remain a
   convention?

---

## 15. Relationship to active ownership

This is an architecture note, not an execution owner.

The rules, skills, and workflows that currently own behaviour remain
authoritative. Where this proposal implies new behaviour, the definition must be
placed in the appropriate canonical owner during an implementation phase — for
example, a skill-depth and adapter check belongs to the repository rules, and
the root `AGENTS.md` contract belongs to whatever owner the infrastructure
assigns to instruction discovery.

Nothing in this note authorizes a change to `main`.
