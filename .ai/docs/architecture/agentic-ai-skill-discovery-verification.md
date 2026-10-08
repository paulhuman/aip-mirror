# Agentic AI skill discovery — verification record and open tasks

**Status:** working record. Supersedes the DSH-specific claims in the
`agentic-ai-*` series where they disagree.
**Purpose:** preserve enough verified state that a fresh session can continue
this verification work without reconstructing it from conversation history.

Read this file first, then `.ai/docs/architecture/ai-infrastructure-vnext-proposal.md`
for the design that these findings feed.

---

## 1. How to use this file

This is a **state + task** record, not an architecture rationale. It holds:

- what was verified, and by what evidence;
- what turned out to be wrong;
- the exact next steps, with commands.

It is supporting material. It does not own any semantic rule.

---

## 2. Environment baseline

| Fact | Value |
|---|---|
| DSH Desktop | `0.11.0` |
| Harness / `@deepseek-ai/dsh` | `0.2.0-rc.2` (read from `app.asar`) |
| `DSH_HOME` | `C:\Users\Paul\AppData\Roaming\dsh-desktop\harness` |
| Profile | `web` |
| Active agent preset | `standard` |
| `dsh` on `PATH` | **no** — use `npx --yes @deepseek-ai/dsh@0.2.0-rc.2` with `DSH_HOME` set |
| OS | Windows 10 |

`dsh` is not installed globally. Every CLI check must be:

```powershell
$env:DSH_HOME = "$env:APPDATA\dsh-desktop\harness"
npx --yes @deepseek-ai/dsh@0.2.0-rc.2 <args>
```

---

## 3. Verified findings

Each finding is tied to its evidence. Do not restate these as speculation.

### V1 — Skill discovery lives in agent presets, not on the host plane

The `dsh-web-app` bundle patch **disables** the host-plane row:

```yaml
# from @deepseek-ai/dsh-web-app/cordis.patch.yml
# Only the per-agent rows move behind presets: the base host `skill-filesystem`
# row is disabled here (presets own local discovery)
- id: skill-filesystem
  disabled: true
```

Evidence: `--dump-config` shows the host row with `disabled: true`, and each
preset (`standard`, `ptc`, `cordis`) carries its own enabled `skill-filesystem`
row with no config.

**Consequence:** the effective `dshHome` for skill discovery is the default
`$DSH_HOME`, because the preset row passes no `dshHome`.

### V2 — `$DSH_HOME/skills` is read with no configuration

The preset row resolves `resolveDshHome(undefined)` → `$DSH_HOME` → root
`join($DSH_HOME, "skills")` = `...\harness\skills` (rank 400, `user-dsh`).

**Empirically confirmed this session.** After a skill named `explain-code` was
placed in `harness\skills` with only `name` and `description` in its front
matter, DSH added it to the live available-skills catalog without a restart.
Likewise `review-agent` became visible once its
`disable-model-invocation` flipped to `false`.

This closes the gap noted in the previous session, where `review-agent` was
absent from the catalog and the root could not be proven.

### V3 — A `customSkillDirs` override on the host row id is dead

The override was added to the profile patch layer:

```yaml
# WRONG — merged onto a disabled row
- id: skill-filesystem
  config:
    customSkillDirs:
      - 'C:\Users\Paul\.dsh\skills'
```

`--dump-config` showed it merged into the **disabled** host row:

```yaml
- id: skill-filesystem
  name: '@deepseek-ai/dsh-skill-filesystem'
  disabled: true                        # row is dropped
  config:
    customSkillDirs:                    # never read
      - C:\Users\Paul\.dsh\skills
```

**Consequence:** the override never worked. Desktop never read
`~/.dsh/skills` from it. The override has been **removed** from
`cordis.patch.yml`, replaced by a comment recording why it must not return.

> **Important:** `--dump-config` prints the **merged** result, not what is
> loaded. A row can appear in the dump with its config and still be dropped by
> `disabled: true`. Never conclude that a patch works from the dump alone.
> Confirm it against the live available-skills catalog.

### V4 — `.agents/skills` junction is correct, and git needs to ignore it

In `E:\Projects\repos\aip-mirror`:

```
.agents\skills  →  Junction  →  E:\Projects\repos\aip-mirror\.ai\skills
```

Verified: `LinkType = Junction`; the canonical and adapter listings are
identical (8 skills); `activation/SKILL.md` has the same length (4505) and the
same SHA-256 through both paths. No content copy exists.

But git does **not** track a junction as a link. `git add --dry-run --all -- .agents`
lists **9 files**, i.e. `.agents/skills/<name>/SKILL.md` for every skill. Without
an ignore entry, the first `git add` would commit duplicate skill content into
the repository — exactly the duplication the architecture forbids.

### V5 — `.ai/skills` is still not a native discovery root

None of the six roots names `.ai/skills`. The junction in V4 is what makes the
content discoverable to DSH; the canonical path is not itself a root.

### V6 — Presets differ in whether skills load at all

| UI name | preset id | `skill-filesystem` | Skills load |
|---|---|---|---|
| Standard mode | `standard` | yes | **yes** |
| PTC mode | `ptc` | yes | **yes** |
| Minimal mode | `minimal` | **no** | **NO** |
| Creator mode | `cordis` | yes | yes |

PTC differs from `standard` by exactly one row:
`@deepseek-ai/dsh-agent-tool-presentation` with `mode: ptc`. That changes the
**tool-call form** (the agent writes a TypeScript program via `run_code`), not
skill discovery. Minimal mode loads no skills by design.

**Stay on `standard`.**

### V7 — Per-agent-row ranking is unchanged

Ranks still come from `dsh-skill-filesystem`, lower wins:

```
100  <project>/.dsh/skills
200  <project>/.agents/skills
300  customSkillDirs (unused here)
400  $DSH_HOME/skills          ← harness\skills, the personal root
500  ~/.agents/skills
600  bundled
```

---

## 4. Current state of relevant paths

| Path | State |
|---|---|
| `...\harness\skills` | exists — `explain-code`, `review-agent` |
| `...\harness\AGENTS.md` | exists — personal always-on instructions, Russian |
| `C:\Users\Paul\.dsh` | **removed** by the user (the `customSkillDirs` target, now moot) |
| `E:\Projects\repos\aip-mirror\.agents\skills` | exists — junction, untracked |
| `E:\Projects\repos\aip-mirror\.gitignore` | exists — **0 bytes, empty** |
| `...\profiles\web\cordis.patch.yml` | `skill-filesystem` override removed; comment added |

Repository state at the time of writing: `main`, clean except for the untracked
`.agents/` directory.

---

## 5. Open tasks

### Task A — prove project-scoped discovery in `aip-mirror` (the step-7 test)

**Why:** V4 proves the junction is structurally correct, but discovery through
it has **not** been observed. The previous session's live catalog was that of
`developer-knowledge`, whose project root is a different repository.

**Method:** start a fresh DSH session with the working directory set to
`E:\Projects\repos\aip-mirror`, then check the available-skills catalog for one
of the eight `.ai/skills` names — `activation`, `handoff`, `knowledge-capture`,
`explain-code`, `normative-language`, `ai-infrastructure`, `commits`,
`deep-understanding`.

**Expected outcome:** the skill appears via rank 200 (`<project>/.agents/skills`).

**Note:** `explain-code` also exists in `harness\skills` (V2). If it appears,
that is **not** proof of project discovery — it could be the rank-400 personal
skill winning. Use a name that exists **only** in `.ai/skills`, for example
`knowledge-capture` or `activation`.

**Also verify invocation, not only listing:** confirm the body loads, not just
the metadata line in the catalog.

### Task B — decide and apply the `.gitignore` entry

**Why:** V4 — 9 duplicate files would otherwise be committed.

**Pending decision:** add `.agents/` to `E:\Projects\repos\aip-mirror\.gitignore`.

**Constraint:** the file is currently empty (0 bytes), and the user asked that
nothing be added until the facts were established. The facts are now
established; the entry is still **not** added.

**Consider also:** whether the junction should be created by a documented setup
step, since a fresh clone will not have it. A committed junction is not an
option (git duplicating content, V4); a symlink is not an option on Windows
(it materializes as a text file and DSH skips the root silently).

### Task C — extend the verification to any second host, if one is ever used

Currently DSH is the only agentic host in use. The design in the vNext proposal
keeps host-specific mechanics in an adapter layer. Do not build adapters for
hypothetical hosts.

---

## 6. Commands for the next session

Repository and adapter state:

```powershell
cd E:\Projects\repos\aip-mirror
git status --short --branch
(Get-Item .agents\skills -Force) | Select-Object LinkType,Target
Get-ChildItem .agents\skills -Directory | Select-Object -ExpandProperty Name
git add --dry-run --all -- .agents      # shows what a commit would pull in
```

Effective composition (remember V3 — the dump shows merged, not loaded):

```powershell
$env:DSH_HOME = "$env:APPDATA\dsh-desktop\harness"
npx --yes @deepseek-ai/dsh@0.2.0-rc.2 --profile web --dump-config
```

Live catalog for a session (the ground truth, better than the dump):

```
<available_skills> ... </available_skills>
```

It appears in the session log, in the system-reminder user message. Extract it
from
`$DSH_HOME\sessions\--<cwd-with-dashes>--\<session-id>\session.v4.jsonl.zstd`,
which is written in multiple zstd frames — decompress frame by frame by
scanning for the `28 B5 2F FD` magic.

Personal skills live in `$DSH_HOME\skills`; the catalog updates live, no
restart needed (V2).

---

## 7. What remains uncertain

1. **Project-scoped discovery is unproven** (Task A). V2 proves the personal
   root; it says nothing about rank 200 through a junction.
2. **Whether a fresh clone should auto-create the junction.** Currently the
   setup is manual and undocumented. A script under `.ai/scripts/` would be the
   natural home, consistent with the vNext proposal.
3. **Whether `.agents/skills` is genuinely cross-host.** Earlier research
   claimed Gemini CLI reads it; that was never verified here. Until it is,
   treat `.agents/skills` as a DSH adapter, not a portability layer.
4. **Upstream DSH documentation URLs** cited by the older survey were never
   opened. All DSH facts here come from the installed bundle and from
   experiments.

---

## 8. Corrections to earlier documents

Apply these when the `agentic-ai-*` series is next revised.

| Earlier claim | Corrected state |
|---|---|
| `customSkillDirs` is the way to add a personal root | It is dead on the host row (V3). Use `$DSH_HOME/skills`, which needs no config (V2). |
| `~/.dsh/skills` is a usable personal root | Only for a standalone CLI, not for Desktop. The user removed the folder. |
| `.ai/skills` may be reused "without duplicating" via ranking | True only through a link or generated pointers; the canonical path is not a root (V5), and a committed junction duplicates content in git (V4). |
| Skill discovery roots and precedence | Roots and ranks unchanged (V7), but the **owning row moved into agent presets**, and Minimal mode loads no skills at all (V1, V6). |
| `review-agent` absence from the catalog was unexplained | It was `disable-model-invocation: true`; the catalog filters on model-invocability (V2). |
