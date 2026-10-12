# Conversation Handoff

**Conversation:**
C0094 — Architecture & Research

**Specialization:**
C

**Chapter:**
0094

**Previous chapter:**
0093

## Starting objective

Recover from the interrupted migration after C0093 and continue the host-separated AI-infrastructure architecture work. Preserve the verified repository state, continue the assistant-owned audit of `github-api-*` skills, and investigate GitHub API wrapper read completeness without conflating platform limits with wrapper behavior.

## Bootstrap and repository state

- Repository: `paulhuman/aip-mirror`.
- Canonical default branch from `.ai/config.yaml`: `main`.
- Active working branch for this chapter: `main`.
- Resolved `SHORT_NAME`: `Architecture & Research`.
- Receiving handoff path: `.ai/handoffs/C/C0094-Architecture-&-Research.md`.
- Bootstrap inputs: `PREVIOUS_CHAPTER = 0093`, `CURRENT_CHAPTER = 0094`, `SPECIALIZATION = C`.
- Repository write capability was verified through connected GitHub tools; this bootstrap follows the WRITE-CAPABLE branch.
- The C0093 handoff was read from `main`. Its repository-state notes predate the final transfer described below; where they conflict with the later verified state in this handoff, use this handoff's later evidence.
- The new receiving handoff did not exist on `main` before this bootstrap.
- The previous handoff was not modified. The handoff lifecycle procedure says not to modify a predecessor merely to record that it has been consumed.

## Confirmed state recovered from C0093

### Canonical work now present on main

The following research document and handoff were committed to `main` before the six-skill transfer:

- `.ai/memory/github-api-wrapper-research.md`
  - Commit: `13cd0ba9e1a1ad4685c6d76fdfcd3f3f002d94d0`
  - Blob SHA: `a6b5dc5f7ab5679d3c948a715a5450f39a54cf74`
  - URL: https://github.com/paulhuman/aip-mirror/blob/13cd0ba9e1a1ad4685c6d76fdfcd3f3f002d94d0/.ai/memory/github-api-wrapper-research.md
- `.ai/handoffs/C/C0093-Architecture-&-Research.md`
  - Commit: `51d75433ee96f6f7555f68da8a1324a698e74fa8`
  - URL: https://github.com/paulhuman/aip-mirror/blob/51d75433ee96f6f7555f68da8a1324a698e74fa8/.ai/handoffs/C/C0093-Architecture-%26-Research.md

The following seven paths were subsequently transferred from `ai-infra/six-skill-host-separation` to `main`:

1. `.ai/INDEX.md`
2. `.ai/skills/repository/SKILL.md`
3. `.ai/skills/workflow/SKILL.md`
4. `.ai/skills/github-api-repository/SKILL.md`
5. `.ai/skills/github-api-workflow/SKILL.md`
6. `.ai/skills/git-cli-repository/SKILL.md`
7. `.ai/skills/git-cli-workflow/SKILL.md`

Read-back verification compared each path on `main` with the review branch: all 7/7 pairs had identical blob SHAs and contents. The transfer was scoped to those seven paths. The final transfer commit is `ea951e32c5dcd1c030ad2ae6468e3e7f366e8dba`, message `ai-skills(git-cli-workflow): add local workflow skill`. The compare against the preceding C0093 handoff commit showed seven commits ahead, zero behind, and exactly the seven intended paths changed in that transfer series.

- Main HEAD recorded at the end of C0093: `ea951e32c5dcd1c030ad2ae6468e3e7f366e8dba`.
- Skills directory: https://github.com/paulhuman/aip-mirror/tree/main/.ai/skills
- Compare evidence: https://github.com/paulhuman/aip-mirror/compare/51d75433ee96f6f7555f68da8a1324a698e74fa8...ea951e32c5dcd1c030ad2ae6468e3e7f366e8dba

These skills are now preserved on `main` independently of the review branch. This transfer is not evidence that the new skills passed runtime validation or linting.

### Separate review branch

- Review branch: `ai-infra/six-skill-host-separation`.
- The user said they would delete this branch after reviewing the safe transfer. Do not delete it or assume it has already been deleted.
- Do not merge/cherry-pick remaining branch history wholesale, and do not rewrite history.
- The changed C0092 handoff on the review branch was not transferred by the seven-path operation. Do not overwrite the canonical C0092 handoff on `main` without explicit review and authorization.
- The earlier accidental branch-local commits remain historical branch state; no history rewriting was performed.

## Architecture and ownership decisions

- The approved architecture has six skills:
  ```text
  .ai/skills/
  ├── repository/SKILL.md
  ├── workflow/SKILL.md
  ├── github-api-repository/SKILL.md
  ├── github-api-workflow/SKILL.md
  ├── git-cli-repository/SKILL.md
  └── git-cli-workflow/SKILL.md
  ```
- Shared `repository` owns host-neutral repository semantics, boundaries, taxonomy, durability, and universal safety invariants. Shared `workflow` owns common research/implementation/testing/verification methodology.
- `github-api-repository` and `github-api-workflow` own remote API mechanics. `git-cli-repository` and `git-cli-workflow` own local Git mechanics.
- The assistant audits and refines `github-api-*`; DSH owns the independent self-check and refinement of `git-cli-*`. Do not spend effort trying to replace DSH's local-environment judgment.
- The user accepts intentional duplication when it keeps remote and local execution contexts physically separate. Labels inside a fully loaded skill do not provide equivalent context isolation.
- The skills' front-matter metadata decisions are recorded in C0093 and grounded in version-scoped runtime evidence in `.ai/docs/skill-authoring-reference.md`. Do not generalize those observations beyond tested runtimes.
- Runtime validation/linting of the transferred candidate skills has not been confirmed.

## GitHub API wrapper read-completeness research

Working record: `.ai/memory/github-api-wrapper-research.md`.

Confirmed from the visible tool contracts:

- `fetch_file` returns content, encoding, blob SHA, display URL/title, and accepts an optional ref and optional line range.
- Its visible contract does not expose original file size, a truncation indicator, or a media-type selector.
- `fetch_blob` returns content but does not visibly expose size or truncation metadata.
- The adapter implementation, underlying endpoint, and HTTP headers are not visible through the available tool descriptions.

Current conclusion:

- It is **not proven** that `fetch_file` always returns complete contents for arbitrary file sizes.
- It is also **not proven** that the wrapper truncates at 1 MB or uses a specific GitHub endpoint/media type.
- A test against `facebook/react` failed with `InvalidInputException: GitHub path did not return readable file content`; the cause was unknown, so that result is inconclusive and does not establish a size-related failure.
- Official GitHub documentation describes size/media-type constraints for the Contents API, but these platform limits must not be represented as confirmed wrapper limits. See https://docs.github.com/en/rest/repos/contents.
- No controlled `github-api-lab` test has been confirmed completed. The proposed private fixture repository and tests at approximately 100 KB, 900 KB, 1.1 MB, and 5 MB, including UTF-8, long/empty files, and exact SHA/size comparisons, remain pending.

## Important repository constraints

- For existing files, follow: READ CURRENT FILE → MAKE MINIMAL CHANGE → WRITE COMPLETE FILE → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT.
- A successful API write or valid commit does not itself prove that content is correct.
- Do not reconstruct existing file contents from memory when the repository version can be fetched.
- Do not modify the local `E:\Projects\repos\aip-mirror\prototypes\jsx\MultipleRotate.jsx` as part of this remote repository task.
- Keep the local prototype's status separate from remote repository state; it is not established as committed or tested.
- New `.ai/memory/` and `.ai/docs/` documents are written in Russian, retaining technical terms, identifiers, paths, field names, and exact technical designations in their original form.

## Confirmed / inferred / open

- **Confirmed:** `main` contains the wrapper research record, C0093 handoff, and all seven transferred INDEX/shared/host-specific skill paths listed above.
- **Confirmed:** All seven transferred paths were read back and had identical blob SHAs to the review-branch copies.
- **Confirmed:** The user intends to handle deletion of the review branch after checking; branch deletion has not been performed by the assistant.
- **Confirmed:** DSH runtime validation/linting of the skills remains unverified.
- **Confirmed:** Assistant responsibility is the remote `github-api-*` skills; DSH owns the local `git-cli-*` skills.
- **Open:** Determine wrapper completeness empirically or by inspecting the actual adapter implementation if accessible.
- **Open:** Run controlled tests in a private `github-api-lab` repository if the user creates it and provides the repository identity.
- **Open:** Continue a concrete, evidence-based audit of `github-api-repository/SKILL.md` and `github-api-workflow/SKILL.md`; avoid generic precautions without an identified failure mode or verification benefit.
- **Open:** Review the review-branch diff separately before any future integration decision.

## Immediate next task

1. Continue the audit of `main@ea951e32c5dcd1c030ad2ae6468e3e7f366e8dba`'s `github-api-repository/SKILL.md` and `github-api-workflow/SKILL.md`, looking only for concrete gaps grounded in GitHub REST/Contents API behavior and the actual available wrapper contracts.
2. Continue wrapper-read-completeness research without asserting a 1 MB wrapper limit absent evidence. If the user has created `github-api-lab`, use controlled fixtures and compare exact expected contents, byte counts, and Git blob SHAs; otherwise continue investigating what evidence is accessible without inventing test results.
3. Leave `git-cli-*` refinement to DSH and do not claim runtime validation unless evidence is obtained.
4. Keep the review branch intact until the user handles its deletion. Do not integrate remaining branch changes without a separate explicit decision.

## Recommended starting context

Read the current versions on `main` of `.ai/skills/github-api-repository/SKILL.md`, `.ai/skills/github-api-workflow/SKILL.md`, and `.ai/memory/github-api-wrapper-research.md` before proposing changes. Treat this handoff as the recovery snapshot for the interrupted migration, while using the repository's current files and immutable refs as the authority for any subsequent operation.

## Research references

- `paulhuman/aip-mirror`
  - Role: Canonical source for current AI-infrastructure owners, decisions, and working records.
  - URL: https://github.com/paulhuman/aip-mirror
- `paulhuman/skills`
  - Role: Reference repository for reusable skill structure, discovery, and capability conventions.
  - URL: https://github.com/paulhuman/skills
- GitHub REST API — Repository contents
  - Role: Official documentation for Contents API size/media-type behavior; platform constraints only, not proof of wrapper behavior.
  - URL: https://docs.github.com/en/rest/repos/contents
- `ai-infra/six-skill-host-separation`
  - Role: Review branch used to source the seven transferred files and compare candidate architecture changes; not an approved wholesale integration target.
  - URL: https://github.com/paulhuman/aip-mirror/tree/ai-infra/six-skill-host-separation
