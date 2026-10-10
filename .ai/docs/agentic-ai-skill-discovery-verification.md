# Проверка обнаружения skills в Agentic AI — журнал результатов

**Статус:** рабочая запись. При расхождениях заменяет DSH-specific утверждения из серии
`agentic-ai-*`.
**Назначение:** сохранить достаточно подтверждённого состояния, чтобы новый сеанс мог
продолжить проверку без реконструкции контекста из истории переписки.
**Редакция:** второй проход. Обнаружение в контексте проекта подтверждено (V8),
задача A закрыта, задача B выполнена; список открытых вопросов теперь короткий и
содержит только действительно нерешённые пункты.

Сначала прочитайте этот файл, затем `.ai/docs/ai-infrastructure-vnext-proposal.md`,
где описана архитектура, для которой нужны эти результаты.

---

## 1. Как пользоваться этим файлом

Это запись о **состоянии и задачах**, а не архитектурное обоснование. В ней
сохранены:

- что проверено и какими свидетельствами это подтверждается;
- какие прежние выводы оказались неверными;
- точные следующие шаги и команды.

Это вспомогательный материал. Он не является владельцем каких-либо семантических правил.

---

## 2. Исходное состояние среды

| Факт | Значение |
|---|---|
| DSH Desktop | `0.11.0` |
| Harness / `@deepseek-ai/dsh` | `0.2.0-rc.2` (версия прочитана из `app.asar`) |
| `DSH_HOME` | `C:\\Users\\Paul\\AppData\\Roaming\\dsh-desktop\\harness` |
| Profile | `web` |
| Активный agent preset | `standard` |
| `dsh` в `PATH` | **нет** — используйте `npx --yes @deepseek-ai/dsh@0.2.0-rc.2`, предварительно задав `DSH_HOME` |
| ОС | Windows 10 |

`dsh` глобально не установлен. Каждую проверку CLI следует выполнять так:

```powershell
$env:DSH_HOME = "$env:APPDATA\dsh-desktop\harness"
npx --yes @deepseek-ai/dsh@0.2.0-rc.2 <args>
```

---

## 3. Verified findings

Each finding is tied to its evidence. Do not restate these as speculation.

> **V-numbers are local to this file.** The `agentic-ai-*` series and
> `.ai/docs/ai-infrastructure-vnext-proposal.md` each carry their
> own independent `V` numbering, and the numbers now collide (this file's `V10`
> is not the proposal's `V10`). When citing a finding, name the file. The
> cross-references below are written explicitly for that reason.

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

### V4 — `.agents/skills` junction is correct, discoverable, and gitignored

**Status: CONFIRMED behaviourally.** Structural correctness was checked earlier;
discovery through the junction is now observed (V8). In
`E:\Projects\repos\aip-mirror`:

```
.agents\skills  →  Junction  →  E:\Projects\repos\aip-mirror\.ai\skills
```

Verified structurally: `LinkType = Junction`; the canonical and adapter
listings are identical (8 skill directories); `activation/SKILL.md` and
`normative-language/SKILL.md` have identical SHA-256 through both paths. No
content copy exists.

But git does **not** track a junction as a link. `git add --dry-run --all -f -- .agents`
lists **9 files** — `.agents/skills/<name>/SKILL.md` for every skill, plus the
depth-2 `handoff/reference-preservation/SKILL.md`. Without an ignore entry the
first `git add` would commit duplicate skill content into the repository —
exactly the duplication the architecture forbids. That entry now exists
(`/.agents/`, committed in `5e5d380`), after which `git status` stays clean and
`git add --dry-run --all -- .agents` reports the path as ignored.

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

Ranks still come from `dsh-skill-filesystem`, lower wins. Read directly from the
installed package source
(`@deepseek-ai/dsh-skill-filesystem/lib/index.js`, `FileSystemSkillProvider.roots`):

```
100  <project>/.dsh/skills      source project-dsh    rank PROJECT_DSH_RANK
200  <project>/.agents/skills   source project-agents rank PROJECT_AGENTS_RANK
250  runtime provider           source runtime        rank RUNTIME_RANK (dsh-skill)
300  customSkillDirs            source custom         rank CUSTOM_RANK
400  $DSH_HOME/skills           source user-dsh       rank USER_DSH_RANK
500  $AGENTS_HOME/skills        source user-agents    rank USER_AGENTS_RANK
600  bundled                    source bundled        rank BUNDLED_SKILL_RANK
```

The 250 row is a separate provider registered through `ctx.skills`, not a
filesystem root; it is listed for completeness of the precedence order.

Two details the earlier listing did not record:

- the project root is found by walking up from `cwd` until a directory contains
  `.git` (`findProjectRoot`); if no `.git` is found it falls back to `cwd`
  itself, so project roots still resolve outside a git repository;
- `$AGENTS_HOME` defaults to `~/.agents` and can be overridden by the
  `DSH_AGENTS_HOME` environment variable. `C:\Users\Paul\.agents` does not
  exist on this machine, so rank 500 contributes nothing here.

### V8 — Project-scoped discovery through the junction is now CONFIRMED

This closes Task A. Evidence:

1. **Live catalog in the target session.** The available-skills catalog injected
   into the running DSH session whose working directory is
   `E:\Projects\repos\aip-mirror` (extracted from
   `$DSH_HOME\sessions\--E-Projects-repos-aip-mirror--\session-4b41fea6-…\session.v4.jsonl.zstd`)
   contains all eight `.ai/skills` names: `activation`, `ai-infrastructure`,
   `commits`, `deep-understanding`, `explain-code`, `handoff`,
   `knowledge-capture`, `normative-language`.

2. **The body loads, not just the metadata line.** Invoking the `skill` tool for
   `knowledge-capture`, `activation`, and `normative-language` returned skill
   bodies whose resource base is the junction path:

   ```
   Base directory for this skill: E:\Projects\repos\aip-mirror\.agents\skills\knowledge-capture
   Base directory for this skill: E:\Projects\repos\aip-mirror\.agents\skills\activation
   Base directory for this skill: E:\Projects\repos\aip-mirror\.agents\skills\normative-language
   ```

   `knowledge-capture`, `activation`, and `normative-language` exist **nowhere
   else** on this machine (not in `$DSH_HOME\skills`, not in the bundled preset
   skills, not in the market checkout), so rank 400 cannot explain them. Only
   `explain-code` is ambiguous — it is the one name present in both roots.

3. **Name-only, isolated replay.** A headless DSH run whose `cwd` was the
   repository listed the same eight names. A control run in a directory outside
   any git repository listed only `diagnose-windows-sandbox-acl`,
   `explain-code`, `review-agent`; `knowledge-capture` was `NOT PRESENT` there.
   A second control whose `cwd` was an empty directory containing only `.git`
   produced the same reduced catalog, proving it is the `.agents/skills` root
   and not the mere presence of `.git` that supplies them.

4. **A fresh clone reproduces the result only after the adapter exists.** A
   clean `git clone` has **no** `.agents/` (it is gitignored, V4) and therefore
   exposes only the personal and bundled skills. Creating the junction in that
   clone (`New-SkillAdapters.ps1`) made `knowledge-capture` appear again, with
   its resource base resolved inside the clone.

**Negative controls that were ruled out** (each examined, none can supply the
eight names): repository `.dsh/skills` (absent), `~/.dsh` (absent),
`C:\Users\Paul\.agents` (absent), `$DSH_HOME\skills` (only `explain-code` and
`review-agent`), the bundled `dsh-agent-preset/skills` (4 unrelated names), the
office runtime skill pack (3 unrelated names), and the skills-market checkout
(3818 `SKILL.md` files, only the name `handoff` collides — with a different,
Chinese description, and the rank-200 candidate wins on the name anyway).

**Consequence:** `.ai/skills` stays the single canonical source, `.agents/skills`
stays a gitignored local adapter, and the adapter is now a **documented,
scriptable setup step** rather than an undocumented manual one (Task B).

### V9 — The one-level rule is confirmed by the same evidence

`.ai/skills/handoff/reference-preservation/SKILL.md` exists and is tracked, but
`handoff-reference-preservation` appears in **neither** the live catalog nor any
headless run. `discoverRoot` reads only the immediate entries of each root, so a
skill nested under another skill is never discovered — the claim in §7.3 of the
vNext proposal now has direct evidence, and the catalogue count is 8 rather than
9 for exactly this reason.

### V10 — The upstream symlink model, re-observed on Windows

Re-verified against a live clone of `adobe/spectrum-web-components`
(`E:\Projects\repos\spectrum-web-components`, `main` @ `be922808`). This is the
reference implementation the vNext proposal is modelled on, so its failure modes
are directly relevant.

**What upstream actually commits:**

- Exactly **three** tracked symlinks, all mode `120000`: `.claude/rules` →
  `../.ai/rules`, `.claude/skills` → `../.ai/skills`, `.cursor/skills` →
  `../.ai/skills`. The last two share one blob (`6838a116…`), so the identical
  target costs nothing.
- `.cursor/rules/*.mdc` and `.github/instructions/*.instructions.md` are
  **generated files**, not links — Cursor needs `globs:`, Claude needs `paths:`,
  and one source serves both. They were per-file symlinks before commit
  `4c97b0dd34`.

**Windows behaviour, observed:**

- A clone whose config resolved `core.symlinks=false` materialized the three
  links as **12/13-byte text files** containing the target string — V6 of the
  vNext proposal, reproduced exactly. `git status` stayed clean throughout; the
  breakage is invisible to git.
- After `git config --global core.symlinks true` and a re-clone, all three are
  real `SymbolicLink` reparse points. Read-through resolves (35 skills, 8 rules),
  and `.claude/skills` shares an **inode** with `.ai/skills` — one object, not a
  copy.
- **Developer Mode is genuinely off.** `AllowDevelopmentWithoutDevLicense` is
  absent from `HKLM\...\AppModelUnlock`. Symlink creation nevertheless works
  because the token holds `SeCreateSymbolicLinkPrivilege` (assigned to
  `S-1-5-32-544`), **enabled** in this session. Creating a link needs the
  privilege; reading one does not.
- **A re-clone is not required to repair a broken checkout.** Once no
  clone-local override remains, `git restore -- .claude .cursor` rewrites the
  three paths as real symlinks and leaves `git status` clean. The upstream advice
  ("enable Developer Mode and re-clone") overstates the remedy.

**The upstream validator fails on Windows.** `validate-symlinks.js` compares
`readlinkSync()` with `!==` against the literal `'../.ai/skills'`. On Windows
`readlinkSync` returns `'..\\.ai\\skills'`, so all three checks report
`points to "..\.ai\rules", expected "../.ai/rules"`. The links work; the check is
separator-fragile. CI never sees it because `yarn lint:ai` runs on
`ubuntu-latest` (`lint.yml`).

**Consequence for this repository:** Option A (a committed symlink) is *viable*
on this machine — a flat "not an option on Windows" is too strong — but it still
depends on the creating user holding the privilege, and its failure mode stays
**silent** (vNext proposal `V6`/`V7`: a text file where a directory is expected,
and DSH skips the root without a message). The junction + gitignored adapter
remains the choice for a Windows-primary workflow precisely because its failure
is loud. If Option A is ever adopted, do **not** copy that separator-strict
comparison as a Windows check.

---

## 4. Current state of relevant paths

State re-verified at the start of the current session.

| Path | State |
|---|---|
| `...\harness\skills` | exists — `explain-code`, `review-agent` (personal, rank 400) |
| `...\harness\AGENTS.md` | exists — personal always-on instructions, Russian |
| `C:\Users\Paul\.dsh` | **removed** by the user (the `customSkillDirs` target, now moot) |
| `C:\Users\Paul\.agents` | **absent** — rank 500 contributes nothing |
| `E:\Projects\repos\aip-mirror\.dsh` | **absent** — rank 100 contributes nothing |
| `E:\Projects\repos\aip-mirror\.agents\skills` | exists — junction to `.ai\skills`, 8 skills, gitignored (V8) |
| `E:\Projects\repos\aip-mirror\.gitignore` | exists — 782 bytes, `/.agents/` ignored, junction recipe documented |
| `E:\Projects\repos\aip-mirror\.ai\scripts\adapters\New-SkillAdapters.ps1` | exists — creates the adapter, verifies it (Task B) |
| `...\profiles\web\cordis.patch.yml` | `skill-filesystem` override removed; comment added |

Repository state at the time of writing: branch `main` at `5e5d380`, working tree
clean before this session's edits, `.agents/` present but ignored.

---

## 5. Open tasks

### Task A — prove project-scoped discovery in `aip-mirror` — **CLOSED**

**Result: confirmed (V8).** Project-scoped discovery through the rank-200
`.agents/skills` junction is observed: the live catalog of a session whose `cwd`
is `E:\Projects\repos\aip-mirror` lists all eight `.ai/skills` names, the bodies
of `knowledge-capture`, `activation`, and `normative-language` load from the
junction path, and an out-of-repository control cannot see them. A fresh clone
reproduces them only after the adapter is created.

The one open sub-question — whether a fresh clone recovers the skills — is now
answered **no, not without the setup step**, and the step is scripted (Task B).

### Task B — the `.gitignore` entry and the adapter setup step — **APPLIED**

**Why:** V4 — 9 duplicate files would otherwise be committed; and a fresh clone
has no `.agents/` at all, so project skills would silently not be discovered.

**Applied:**

1. `/.agents/` is ignored in `E:\Projects\repos\aip-mirror\.gitignore`, with the
   rationale and the setup command recorded in the file itself. Committed as
   `5e5d380`.
2. `.ai/scripts/adapters/New-SkillAdapters.ps1` creates the adapter and — this is
   the part that matters — **verifies** it. A setup step that reports success
   while the host silently skips the root would just move the failure.

**Verified behaviour of the script** (all cases exercised against a real fresh
clone of this repository, and against this working copy):

| Case | Result |
|---|---|
| fresh clone, no adapter, run from an unrelated cwd | junction created to the clone's `.ai\skills`, 8 skills visible, `SKILL.md` readable, exit 0 |
| re-run when already correct | reports `already correct`, no change, exit 0 |
| link points somewhere else, no `-Force` | refuses, prints current and expected target, target unchanged, exit 1 |
| link points somewhere else, `-Force` | replaces the link, exit 0 |
| a **real directory** sits at the adapter path | refuses to delete it, exits 1, directory contents survive |

The script never deletes a non-link, and it resolves the repository from its own
location first so that it cannot be aimed at the wrong repository by the caller's
working directory.

**Deliberately not done:** no committed symlink (its failure mode is silent on a
clone without the privilege — V10 — and this workflow is Windows-primary), and no
generated pointer skills (the vNext Tier 2 fallback — unnecessary while the
adapter works and the failure mode is loud rather than silent).

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
git add --dry-run --all -- .agents      # must report the path as ignored
```

Recreate or repair the adapter (idempotent; safe to re-run):

```powershell
cd E:\Projects\repos\aip-mirror
pwsh -File .ai/scripts/adapters/New-SkillAdapters.ps1
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
scanning for the `28 B5 2F FD` magic:

```powershell
$h = "$env:APPDATA\dsh-desktop\harness"
$f = "$h\sessions\--E-Projects-repos-aip-mirror--\<session-id>\session.v4.jsonl.zstd"
$out = Join-Path $env:TEMP 'session.jsonl'
node -e "const fs=require('fs'),z=require('zlib');const buf=fs.readFileSync(process.argv[1]);const offs=[];for(let i=0;i<=buf.length-4;i++){if(buf[i]===0x28&&buf[i+1]===0xB5&&buf[i+2]===0x2F&&buf[i+3]===0xFD)offs.push(i);}const p=[];for(let k=0;k<offs.length;k++){const e=k+1<offs.length?offs[k+1]:buf.length;try{p.push(z.zstdDecompressSync(buf.subarray(offs[k],e)));}catch(x){}}fs.writeFileSync(process.argv[2],Buffer.concat(p));" $f $out
# then read the line containing 'A skill is a reusable'
```

Personal skills live in `$DSH_HOME\skills`; the catalog updates live, no
restart needed (V2).

**Name-only replay without touching the live session.** The `headless` profile
reads the same `skill-filesystem` provider (host-plane row, no preset) but has no
`llm-pi-ai` provider configured, so a repository patch overlay is required to
give it a model:

```powershell
$env:DSH_HOME = "$env:APPDATA\dsh-desktop\harness"
# patch file supplies llm-pi-ai (routerai) + agent-default-model; the ROUTERAI_API_KEY
# value is read from $DSH_HOME\.credentials.yaml by the credentials service
npx --yes @deepseek-ai/dsh@0.2.0-rc.2 headless --patch <patch.yml> "<task asking for the catalog + a skill load>"
```

Run it with `cwd` set to the repository, then repeat in a directory outside any
git repository as the negative control. The control must show a strictly smaller
catalog. Note that `headless` uses `deepseek-official` by default and fails with
`MISSING_CREDENTIAL` unless the overlay is applied.

---

## 7. What remains uncertain

1. **Whether `.agents/skills` is genuinely cross-host.** Earlier research
   claimed Gemini CLI reads it; that was never verified here. Until it is,
   treat `.agents/skills` as a DSH adapter, not a portability layer.
2. **Upstream DSH documentation URLs** cited by the older survey were never
   opened. All DSH facts here come from the installed bundle, from the installed
   package sources under the npx cache (`@deepseek-ai/dsh-skill-filesystem`), and
   from experiments.
3. **Duplication between the personal root and the project root.** `explain-code`
   exists in both roots and the two files are byte-identical (same length 771,
   same SHA-256), so rank 200 currently makes it harmless — but the copies can
   drift, and §10 of the vNext proposal says never to duplicate a skill between
   the two scopes. `review-agent`, by contrast, exists **only** in
   `$DSH_HOME\skills`; `git log --all` shows it was never in this repository's
   history. Either the personal `explain-code` should be removed, or the
   duplication should be a deliberate, documented exception.
4. **Notification of skill-catalog changes to an already-running session.** V8
   establishes discovery at session start; whether a newly created adapter
   appears in a **live** session without a restart (the way the personal root
   does, V2) was not tested.

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
| Discovery through `.agents/skills` is "structurally verified, behaviourally unproven" (root `AGENTS.md`) | **Now behaviourally confirmed** (V8). The root `AGENTS.md` sentence was updated in this session to say so and to name the setup command. |
| `.gitignore` is empty and the entry is still pending (Task B of the previous revision) | `/.agents/` was added and committed as `5e5d380`; the setup command is documented in the ignore file itself and scripted at `.ai/scripts/adapters/New-SkillAdapters.ps1`. |
| `@deepseek-ai/dsh-skill-filesystem` is only observable through experiments | The package source is readable in the npx cache and was read directly this session (V7, V9). Ranks, root order, the one-level scan, and the `.git`-walk project-root resolution are all source facts now, not inferences. |

### 8.1 A correction to the conversation, not to these documents

In the session that added V8/V9, the difference between the two adapter
mechanisms was summarised to the user as: *"a committed symlink is not an option
because git duplicates the content; only a junction does that."* **That summary
was wrong, and these documents did not say it.**

- This file's V4 and §7.1 of the vNext proposal correctly attribute git-side
  duplication to the **junction** (`git add` walks through it and indexes 9 real
  files), and correctly describe the symlink's own failure as "materializes as a
  text file" — the proposal's `V6`, re-confirmed in this file's V10.
- The two mechanisms fail differently and neither is a superset of the other:

  | | committed symlink (mode `120000`) | junction |
  |---|---|---|
  | content in git | none — the blob is the 12-byte target | none, but only because it is ignored |
  | `git add` behaviour | stores the link | walks through, indexes every real file |
  | needs a setup step per clone | no | yes |
  | needs a privilege to create | **yes** | no |
  | failure mode when unavailable | **silent** text file | loud, the script reports |

The rule that follows is narrower than "symlinks are bad": **do not rely on a
mechanism whose failure is silent.** The junction was chosen for its loud
failure, not because committing a symlink duplicates content.

---
