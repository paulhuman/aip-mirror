# Conversation Handoff

**Conversation:**
C0093 — Architecture & Research

**Specialization:**
C

**Chapter:**
0093

**Previous chapter:**
0092

## Starting objective

Recover the interrupted migration from C0092 and continue the host-separated AI-infrastructure architecture work. Keep host-neutral semantics and methodology separate from host-specific remote GitHub API / Contents API mechanics and local Git / working-copy mechanics.

## Bootstrap and repository state

- Repository: `paulhuman/aip-mirror`.
- Canonical default branch from `.ai/config.yaml`: `main`.
- Active working branch for this chapter: `main`.
- This handoff belongs on `main`. The separate branch `ai-infra/six-skill-host-separation` contains candidate architecture changes and is not being integrated as part of this correction.
- Bootstrap inputs: `PREVIOUS_CHAPTER = 0092`, `CURRENT_CHAPTER = 0093`, `SPECIALIZATION = C`, resolved `SHORT_NAME = Architecture & Research`.
- Receiving handoff path: `.ai/handoffs/C/C0093-Architecture-&-Research.md`.
- Repository write capability is available through connected GitHub tools; this bootstrap follows the WRITE-CAPABLE branch.
- The predecessor handoff `.ai/handoffs/C/C0092-Architecture-&-Research.md` was read from `main`.
- The current bootstrap workflow, repository configuration, required canonical owners, commit policy, and orientation READMEs were read from `main` before creating this handoff.
- The receiving handoff did not exist on `main` at the start of this chapter.

## Confirmed state inherited from C0092

- The approved architecture consists of six skills:
  ```text
  .ai/skills/
  ├── repository/SKILL.md
  ├── workflow/SKILL.md
  ├── github-api-repository/SKILL.md
  ├── github-api-workflow/SKILL.md
  ├── git-cli-repository/SKILL.md
  └── git-cli-workflow/SKILL.md
  ```
- Shared `repository` owns host-neutral repository semantics, taxonomy, boundaries, durability, and universal safety invariants. Shared `workflow` owns common research/implementation/testing/verification methodology.
- `github-api-repository` and `github-api-workflow` own remote API mechanics. `git-cli-repository` and `git-cli-workflow` own local Git mechanics.
- All six skills explicitly declare both `disable-model-invocation` and `user-invocable`. Shared and `git-cli-*` skills use `false` / `true`; `github-api-*` skills use `true` / `false`. This decision is settled and grounded in version-scoped runtime evidence recorded in `.ai/docs/skill-authoring-reference.md`.
- The user explicitly assigned ownership: the assistant refines/audits `github-api-*`; DSH self-checks and refines `git-cli-*` against its own local environment. Do not spend effort trying to outperform DSH on local Git operational specifics.
- The user accepts intentional duplication when needed to keep different host execution contexts physically separate. Labels inside a fully loaded skill are not a substitute for physical file separation.
- `prototypes/` is project-agnostic and may contain executable experiments in different languages/technologies. The local `prototypes/jsx/MultipleRotate.jsx` is outside the remote review branch and is not confirmed tested.
- `.ai/captures/` is an inbox for raw unprocessed material, not a knowledge base or semantic owner. `.ai/memory/` stores temporary but important working context. `.ai/docs/` stores durable explanation and rationale. Supporting/contextual layers must not become hidden dependencies for active semantic owners.
- Do not merge or cherry-pick `ai-infra/host-mechanics-review` automatically. Preserve history and do not rewrite commits.
- Repository mutation safety remains: READ CURRENT FILE → MAKE MINIMAL CHANGE → WRITE COMPLETE FILE → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT.

## Candidate architecture work from C0092 — separate review branch only

- The six-skill architecture and INDEX routing were audited for host-specific operational leakage into shared skills.
- Candidate edits on `ai-infra/six-skill-host-separation` refined `github-api-repository/SKILL.md` and `github-api-workflow/SKILL.md`, including pinned revisions, blob-SHA preconditions, read-back at immutable commits, stale-SHA handling, tree completeness, pagination, and explicit coverage gaps. These candidate versions are **not present on `main`**.
- Local fixture-safety text and the two `git-cli-*` skills were also edited on the review branch. DSH owns its independent self-check/refinement of the `git-cli-*` skills.
- The C0092 predecessor handoff was updated on the review branch; that does not replace the existing C0092 handoff on `main`.

## Separate review-branch state

- Review branch: `ai-infra/six-skill-host-separation`.
- The latest comparison before this correction reported the branch as diverged from `main`: 27 commits ahead, 2 behind, with 10 changed paths:
  1. `.ai/INDEX.md`
  2. `.ai/handoffs/C/C0092-Architecture-&-Research.md`
  3. `.ai/handoffs/C/C0093-Architecture-&-Research.md`
  4. `.ai/memory/github-api-wrapper-research.md`
  5. `.ai/skills/git-cli-repository/SKILL.md`
  6. `.ai/skills/git-cli-workflow/SKILL.md`
  7. `.ai/skills/github-api-repository/SKILL.md`
  8. `.ai/skills/github-api-workflow/SKILL.md`
  9. `.ai/skills/repository/SKILL.md`
  10. `.ai/skills/workflow/SKILL.md`
- The wrapper-research document and C0093 handoff have now been recreated on `main` with corrected branch context and commit messages. This does **not** integrate the candidate skill edits.
- DSH runtime validation/linting of candidate skills has not been run. Do not infer runtime behavior from static checks.

## Immediate next task

1. Continue the assistant's audit of `github-api-repository/SKILL.md` and `github-api-workflow/SKILL.md`, looking only for concrete gaps grounded in actual GitHub REST/Contents API behavior and the available wrapper capabilities.
2. Distinguish GitHub platform limitations from limitations of the connected GitHub tool wrappers. Do not add generic precautions without an identified failure mode or verification benefit.
3. Leave the two `git-cli-*` skills to DSH for its independent local-environment self-check/refinement; preserve its findings.
4. If the intended DSH runtime is available, validate discovery/front matter/invocation behavior. Otherwise record runtime validation as untested.
5. Continue the wrapper-read-completeness research on `main`. Do not merge/cherry-pick `ai-infra/six-skill-host-separation` or `ai-infra/host-mechanics-review` as part of this correction; the user will handle deletion of the former review branch.
6. Keep the local `prototypes/jsx/MultipleRotate.jsx` status separate from remote repository state; it is not established as committed or tested on this branch.

## Confirmed / inferred / open

- **Confirmed:** Six-skill architecture, metadata values, and split of responsibility described above are approved.
- **Confirmed:** The two `github-api-*` skills were refined and their blob SHAs were read back in the review branch during C0092; those candidate versions are not on `main`.
- **Confirmed:** The user wants the assistant to focus on GitHub API skills while DSH owns the local Git skill self-review.
- **Confirmed:** Runtime validation/linting of candidate skills remains unperformed.
- **Confirmed:** `main` is the canonical branch for the current wrapper research. The separate review branch remains unintegrated candidate work.
- **Open:** Identify and validate concrete remote API gaps before making further edits.
- **Open:** DSH's independent review and runtime validation.
- **Open:** Final integration decision after the candidate diff is inspected.

## Relevant files

- `.ai/conversation-management/handoff/BOOTSTRAP.md` — canonical receiving-chapter bootstrap procedure.
- `.ai/conversation-management/handoff/SKILL.md` — handoff structure and migration semantics.
- `.ai/skills/repository/SKILL.md` — shared repository semantics and safety invariants.
- `.ai/skills/workflow/SKILL.md` — shared workflow methodology.
- `.ai/skills/activation/SKILL.md` — ACTIVATE and visible TRACE contract.
- `.ai/skills/commits/SKILL.md` — commit policy and handoff commit convention.
- `.ai/skills/github-api-repository/SKILL.md` — remote file reads/writes and Contents API mechanics.
- `.ai/skills/github-api-workflow/SKILL.md` — pinned remote tree inspection and coverage.
- `.ai/skills/git-cli-repository/SKILL.md` and `.ai/skills/git-cli-workflow/SKILL.md` — local Git mechanics, assigned to DSH for independent refinement.
- `.ai/docs/skill-authoring-reference.md` — tested DSH skill metadata reference.
- `.ai/memory/dsh-skill-host-separation-working-context.md` — accumulated host-separation research.
- `.ai/handoffs/C/C0092-Architecture-&-Research.md` — predecessor state snapshot.

## Research references

- `paulhuman/aip-mirror`
  - Role: Canonical source for AI-infrastructure owners, decisions, and working records.
  - URL: https://github.com/paulhuman/aip-mirror
- `paulhuman/skills`
  - Role: Reference repository for reusable skill structure, discovery, and capability conventions.
  - URL: https://github.com/paulhuman/skills
- `ai-infra/host-mechanics-review`
  - Role: Unmerged candidate changes for comparison only; not an approved integration target.
  - URL: https://github.com/paulhuman/aip-mirror/tree/ai-infra/host-mechanics-review

## GitHub API wrapper read-completeness research (2026-10-12)

- Created working-memory record: `.ai/memory/github-api-wrapper-research.md`.
- Canonical `main` commit: `13cd0ba9e1a1ad4685c6d76fdfcd3f3f002d94d0`; read back at that immutable commit. The returned file blob SHA was `a6b5dc5f7ab5679d3c948a715a5450f39a54cf74`. The original candidate-branch copy is separate and is not the canonical reference.
- Current evidence: the visible `fetch_file` contract returns content, encoding, blob SHA, display URL/title and supports optional line ranges; it does not expose size, truncation flag, or a media-type selector. `fetch_blob` returns content only and also lacks visible size/truncation metadata.
- GitHub Contents API and Git Blobs API have documented size/media-type constraints, but the wrapper's underlying endpoint and headers remain unknown. Do not treat platform limits as proven wrapper limits.
- A test against `facebook/react` failed with `InvalidInputException: GitHub path did not return readable file content`; cause unknown, so the test is inconclusive and does not establish a size-related failure.
- Conclusion: completeness for large files remains unproven; a 1 MB wrapper limit is also unproven. Next: inspect the adapter implementation if accessible, otherwise run controlled tests on known-size disposable fixtures, compare `fetch_file` and `fetch_blob`, and only then decide whether canonical `github-api-*` skills need a change.
- Responsibility remains unchanged: ChatGPT audits `github-api-*`; DSH independently owns `git-cli-*`. Do not integrate the candidate into `main` without separate approval.

