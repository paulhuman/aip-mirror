# Conversation Handoff

**Conversation:**
C0096 — Architecture & Research

**Specialization:**
C

**Chapter:**
0096

**Previous chapter:**
0095

## Starting objective

Continue the empirical investigation of GitHub repository read-wrapper completeness, preserve all unique laboratory evidence, and improve the reliability of repository operations without claiming an unverified cause for observed behavior.

## Bootstrap and repository state

- Canonical project repository: `paulhuman/aip-mirror`.
- Canonical branch from `.ai/config.yaml`: `main`.
- Laboratory repository from `.ai/config.yaml`: `paulhuman/github-api-lab`, default branch `main`.
- This receiving handoff path: `.ai/handoffs/C/C0096-Architecture-&-Research.md`.
- Predecessor handoff: `.ai/handoffs/C/C0095-Architecture-&-Research.md`, read from `main`.
- Repository writes and commits are available through connected GitHub tools; bootstrap follows the WRITE-CAPABLE branch.
- The receiving handoff did not exist on `main` when checked before creation.
- Bootstrap itself has not changed laboratory repository state.

## Confirmed research state at chapter start

The canonical laboratory report is:
https://github.com/paulhuman/github-api-lab/blob/main/docs/fetch-completeness-2026-10-12.md

The chronological research report is:
https://github.com/paulhuman/github-api-lab/blob/main/results/fetch-completeness-2026-10-12.md

Tested outcomes in the current wrapper/tool configuration:

- Small independent-oracle control: both `fetch_file` and `fetch_blob` returned the exact expected 101-byte content.
- Tested `fetch_file` fixtures through 1,048,575 bytes returned expected content.
- Tested `fetch_file` fixtures from 1,048,576 through 5,242,880 bytes returned empty content while reporting the expected blob SHA.
- `fetch_blob` returned full content for tested fixtures through 5,242,880 bytes.
- For the 5 MiB fixture, independently expected Git blob SHA-1 `5c1cb4d9f4cdaa984ecb4a42f9cdc8032fbcf339` matched the hash recalculated from `fetch_blob` output. The generator's expected SHA-256 is `01aa375d43dba8abfb1c996c495aae9a07e94c330ed01dda316aa5365fe66bd6`; recalculating SHA-256 over the returned bytes remains an optional additional cross-check.
- These results are observations for the tested tool configuration, not a universal API limit or proof of the wrapper's internal implementation.

## Canonical safeguard already committed

The current `.ai/skills/github-api-repository/SKILL.md` includes “Verify read completeness before full-file replacement.” It states that a successful `fetch_file` response and blob SHA do not prove the `content` field is complete; unexpected empty content or unverified completeness requires STOP before using it for full-file replacement.

- Commit: https://github.com/paulhuman/aip-mirror/commit/9fde083667554b22fa2139aeda002a2f0e1a6197
- Read-back at the immutable commit and at `main` matched blob SHA `ddcbe704b3c5722b4e5861473f3fc29e04fabec1`.
- The commit diff contained only `.ai/skills/github-api-repository/SKILL.md`.
- No cause is asserted. The Free-plan hypothesis, wrapper endpoint/media type/adapter behavior, and any universal size limit remain unverified.

## Laboratory branch preservation state

Two experiment branches must be preserved; neither may be deleted without a separate explicit owner authorization.

1. `experiment/control-read-completeness-20261012`
   - Previously inventoried as diverged from lab `main`, with 11 commits only on the experiment branch and 5 only on `main` at that checkpoint.
   - Merge base at that checkpoint: `203f1b7dab82b8a014ccbca074a9d192790f0502`.
   - The canonical report documents the 11 branch-only commit/path pairs: https://github.com/paulhuman/github-api-lab/commit/28c7e26f21784559f409870090b5dd24832bc381.
   - The exact current branch head and full inventory must be rechecked against the current pinned lab `main`.

2. `experiment/fixture-5m-c0095-38260305834`
   - Fixture commit: `0a55aeac7948e2dd9984795cbd968c134a731ad7`.
   - Unique path: `fixtures/size-5m-c0095.txt`.
   - Previously compared as diverged, with one branch-only commit/path; merge base at that checkpoint: `d471f0f73b73063eb2bc1fa04ba9aee885eec235`.
   - Verify the exact current branch head, commit metadata, parent, unique path, and canonical evidence before declaring its inventory complete.

Documentation of findings does not automatically make original fixture commits or blobs disposable. Do not delete either branch or rewrite history.

## Immediate next tasks

1. Run a controlled receiving-chapter initialization in C0097 to test the amended `.ai/conversation-management/handoff/BOOTSTRAP.md`: confirm the actual read order `.ai/config.yaml` → `.ai/AGENTS.md` → `.ai/INDEX.md` → applicable canonical owners, without indiscriminately reading every INDEX entry.
2. Verify the initialization TRACE against the files actually reread: list all required activation owners under `ACTIVATE`, and list only unique additional files under `OPERATION READS`. In particular, confirm that the applicable GitHub API repository/workflow skills are activated rather than merely mentioned as operation reads.
3. Verify that the C0097 receiving handoff is created and read back correctly, and that its header, predecessor linkage, and first real task match the migration transport.
4. Once the bootstrap test is complete, resume the remaining wrapper-cause investigation only if authoritative implementation or contract evidence is accessible. Keep the Free-plan hypothesis explicitly unverified unless evidence establishes it.
5. Preserve both lab experiment branches; no deletion or history rewrite is authorized.

## Repository operation invariants

For existing files, follow:

`READ CURRENT STATE → MINIMAL CHANGE → WRITE COMPLETE CONTENT → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT`

- Never reconstruct an existing file from memory when it can be fetched.
- Establish expected fixture bytes and hashes independently before testing read methods.
- Keep byte length and character count distinct.
- Pin reproducibility-sensitive reads to immutable commit SHAs.
- A successful API write, tool response, or valid commit is not proof that content is correct.
- Do not change canonical `github-api-*` skills unless a concrete failure mode or useful verifiable safeguard is established.
- ChatGPT owns refinement of `github-api-*`; DSH independently validates and refines `git-cli-*`.
- Do not infer local working-copy state from remote GitHub state.

## Relevant files and references

### Project repository: `paulhuman/aip-mirror`

- `.ai/config.yaml` — canonical repository identity, default branch, and lab repository declaration.
- `.ai/skills/repository/SKILL.md` — shared repository safety and unique-work preservation.
- `.ai/skills/github-api-repository/SKILL.md` — remote API read/write mechanics and completeness safeguard.
- `.ai/skills/github-api-workflow/SKILL.md` — pinned remote tree and coverage workflow.
- `.ai/skills/workflow/SKILL.md` — research and verification methodology.
- `.ai/memory/github-api-wrapper-research.md` — working research record and active TODOs.
- `.ai/handoffs/C/C0095-Architecture-&-Research.md` — predecessor checkpoint.

### Laboratory repository: `paulhuman/github-api-lab`

- Repository: https://github.com/paulhuman/github-api-lab
- Canonical summary: https://github.com/paulhuman/github-api-lab/blob/main/docs/fetch-completeness-2026-10-12.md
- Chronological report: https://github.com/paulhuman/github-api-lab/blob/main/results/fetch-completeness-2026-10-12.md
- Branches to preserve: `experiment/control-read-completeness-20261012` and `experiment/fixture-5m-c0095-38260305834`.

## Confirmed / inferred / open

**Confirmed**
- The observed size-dependent `fetch_file` empty-content results and tested `fetch_blob` content results are documented in the lab report.
- The small independent-oracle control passed for both methods.
- The repository-level read-completeness safeguard is present on project `main`.
- The branch-only commit/parent/path inventory for both experiment branches has been checked against the current lab `main`; the 5 MiB fixture's independently recalculated SHA-256 matches the generator digest.
- Both experiment branches and their unique fixture artifacts remain preserved.
- The C0096 bootstrap discovery correction was committed in `77e5ae410b016f53ba8571c39f082e44c28acd05`; the corrected bootstrap has not yet been tested by a fresh receiving-chapter initialization.

**Inferred**
- The observed pattern indicates a practical risk when treating `fetch_file.content` as complete for large files in the tested configuration. It does not identify the cause.

**Assumed / unverified**
- The user's Free plan might be related; there is no evidence establishing that relationship.
- The wrapper's underlying endpoint, headers, media type, and adapter/decoding implementation have not been established.

**Open**
- Whether wrapper implementation or authoritative contracts are available to establish the cause.
- Whether the corrected bootstrap produces the expected discovery, activation, and TRACE in a fresh receiving chapter.
- Whether any unique fixture artifacts may eventually be discarded; no deletion is authorized.

## Immediate next task

Initialize C0097 using the generated migration instruction and run the first controlled test of the corrected bootstrap discovery/activation contract. Inspect the resulting TRACE against actual reads, then continue only after confirming the C0097 handoff and activation evidence. Do not delete or rewrite either laboratory experiment branch.

## C0096 bootstrap discovery correction

The prior C0096 initialization TRACE did not show `.ai/INDEX.md`, listed `.ai/skills/github-api-repository/SKILL.md` as an operation read rather than an activation owner, and omitted `.ai/skills/github-api-workflow/SKILL.md`. Do **not** restore the removed point 6 in `.ai/AGENTS.md`; it was removed intentionally to avoid loading conversation-management instructions as general agent guidance.

`.ai/conversation-management/handoff/BOOTSTRAP.md` was minimally corrected so that after `.ai/config.yaml` it requires `.ai/AGENTS.md`, then `.ai/INDEX.md`, then only the applicable canonical owners discovered through INDEX. INDEX is a discovery map, not a requirement to read every listed skill. `.ai/skills/repository/SKILL.md` remains the first semantic owner after the AGENTS/INDEX orientation reads.

- Commit: https://github.com/paulhuman/aip-mirror/commit/77e5ae410b016f53ba8571c39f082e44c28acd05
- Commit message: `ai-docs(bootstrap): require INDEX-based owner discovery`
- Changed-file scope verified: only `.ai/conversation-management/handoff/BOOTSTRAP.md`.
- The corrected bootstrap has **not** yet been exercised by a fresh receiving-chapter initialization. That is the first C0097 task.

## Recommended starting context

Read the current `.ai/memory/github-api-wrapper-research.md` for remaining wrapper research status, and use the C0096 bootstrap-correction section above to focus the C0097 initialization test. During bootstrap, read the current `.ai/config.yaml`, `.ai/AGENTS.md`, and `.ai/INDEX.md` in the required order, then only applicable owners; do not read every INDEX entry indiscriminately. Keep all conclusions scoped to observed evidence and preserve both laboratory experiment branches.
