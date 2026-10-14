# Conversation Handoff

**Conversation:**
C0098 — Architecture & Research

**Specialization:**
C

**Chapter:**
0098

**Previous chapter:**
0097


## Starting objective

Continue the controlled bootstrap and AI-infrastructure architecture work. The next chapter should audit the bootstrap discovery and skill-activation contract (TODO 7 in `.ai/memory/github-api-wrapper-research.md`), establish whether the current canonical owners define an unambiguous `discovery → activation → operation reads` sequence, and make a minimal correction only if a concrete normative gap is confirmed. After that, resume the GitHub API wrapper investigation by looking for authoritative implementation details before deciding whether any further safeguards are warranted.

## Bootstrap and repository state

- Canonical repository: `paulhuman/aip-mirror`.
- Canonical branch: `main`, configured in `.ai/config.yaml`.
- Repository write/commit capability is available through the connected GitHub tools.
- Initialization order followed: `.ai/config.yaml` → `.ai/AGENTS.md` → `.ai/INDEX.md` → `.ai/skills/repository/SKILL.md` → applicable canonical owners.
- INDEX was used as a discovery map; unrelated indexed skills were not loaded indiscriminately.
- New handoff path: `.ai/handoffs/C/C0098-Architecture-&-Research.md`.


## Completed in C0098: shared fixture-isolation wording

The shared/host-specific boundary issue in `.ai/skills/repository/SKILL.md` §9 was resolved with a local edit to the first paragraph only. The agreed wording requires isolating the fixture from canonical project state and unrelated user work, and delegates the applicable isolation mechanism to the host-specific repository and workflow skills.

- Commit: `1e13fe0ca61b6a9476f54a2d17ca87d23a41e31b` — `ai-skills(repository): delegate fixture isolation mechanics`.
- The update was read back from the resulting immutable commit; the content/blob SHA matched, the commit parent was verified, and comparison showed exactly one changed file with one addition and one deletion.
- The two following delegation/invariant sentences in §9 were intentionally left unchanged.
- The user explicitly cancelled the proposed DSH control review; do not revive it as a pending task.


## Next planned work: bootstrap discovery and activation

The active open task is TODO 7 in `.ai/memory/github-api-wrapper-research.md`. The C0096 TRACE listed files read but did not establish that `.ai/INDEX.md` had been read, and specialized GitHub API skills may have been read as operation context rather than activated owners. The existing normative text does not yet make the exact gap certain, so investigate before editing.

1. Re-read `.ai/INDEX.md`, `.ai/conversation-management/handoff/BOOTSTRAP.md`, `.ai/skills/activation/SKILL.md`, and the applicable host-specific skills from one pinned revision.
2. Establish which skills are required activation owners for bootstrap and which are additional operation reads. Keep “read” and “activated” distinct.
3. Identify the canonical owner that should define any missing discovery step; avoid duplicating procedure in INDEX.
4. If a concrete gap is confirmed, make a minimal change and run a controlled bootstrap pass. Verify that TRACE reports the actual activation owners and distinct operation reads.
5. If the current contract is already sufficient, document the evidence and close the TODO without changing files.

## Confirmed research state: GitHub API wrapper completeness

Detailed working record: `.ai/memory/github-api-wrapper-research.md`.

For the tested wrapper/tool configuration:
- `fetch_file` returned exact expected content for tested fixtures up to 1,048,575 bytes.
- For tested fixtures from 1,048,576 bytes through 5,242,880 bytes, `fetch_file` returned empty content while reporting the expected blob SHA.
- `fetch_blob` returned complete content for tested fixtures through 5 MiB.
- The 5 MiB returned content matched the independently recorded Git blob SHA-1 and SHA-256.
- These observations are scoped to the tested configuration. The exact wrapper implementation, endpoint/media type, and cause of empty `fetch_file.content` remain unknown. The Free-plan hypothesis is unverified.

Canonical lab evidence:
- Summary: https://github.com/paulhuman/github-api-lab/blob/main/docs/fetch-completeness-2026-10-12.md
- Chronological report: https://github.com/paulhuman/github-api-lab/blob/main/results/fetch-completeness-2026-10-12.md

Do not repeat completed fixture-size experiments without a specific reason. Two laboratory branches remain protected from deletion/history rewriting unless separately authorized:
- `experiment/control-read-completeness-20261012`
- `experiment/fixture-5m-c0095-38260305834`


## Recent completed work in C0097

C0097 performed the controlled receiving-chapter bootstrap and reviewed procedural language and host-specific skill boundaries. The following commits on `main` were recorded in its handoff as verified by read-back and limited to their stated files:

- `133e1f320dc62a3cbdf4ddf12ff0127ce0da6cff` — `ai-docs(normative-language): simplify procedural wording`
- `07ff5ed3125b21544f2f78ba54f7da01d124587a` — `ai-skills(git-cli-repository): simplify imperative wording`
- `a2b800fe6a018176a823518393a402a115344b39` — `ai-skills(git-cli-workflow): simplify imperative wording`
- `8f140d849b76f8a65b3808f1f107538e075b8bcf` — `ai-skills(activation): simplify imperative wording`
- `0bf217914a80aab536daefb523b6ad3e495fbd4f` — `ai-skills(git-cli-workflow): fix imperative capitalization`

A targeted regex audit found no remaining affirmative `DO + verb` constructions in the inspected SKILL files; prohibitions using `DO NOT` remain. The audit was targeted, not a complete line-by-line semantic audit of every skill.


## Architecture and operating constraints

- Current direction: shared host-neutral repository/workflow guidance, with separate GitHub API and local Git mechanics. Some duplication is intentional to avoid loading irrelevant host-specific instructions.
- For repository changes: READ CURRENT STATE → MINIMAL CHANGE → WRITE COMPLETE CONTENT → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT.
- Do not reconstruct existing repository files from memory when they can be fetched.
- Keep observed facts, inferences, assumptions, and open questions distinct.
- All branches except `main` in the project repository were previously deleted; do not rely on deleted branches for research state. Search current `.ai/docs/` and `.ai/memory/` when relevant.
- Do not restore the removed sixth item in `.ai/AGENTS.md`.


## Confirmed / inferred / assumed / open

**Confirmed**
- Bootstrap discovery begins with `.ai/config.yaml` → `.ai/AGENTS.md` → `.ai/INDEX.md`; INDEX is a discovery map, not a requirement to read every listed file.
- The §9 fixture-isolation clarification is committed on `main` in `1e13fe0ca61b6a9476f54a2d17ca87d23a41e31b`; the user cancelled DSH re-review.
- In the tested wrapper/tool configuration, `fetch_file` returned empty content for tested fixtures from 1 MiB through 5 MiB while reporting the expected blob SHA; `fetch_blob` returned complete tested 5 MiB content matching independently checked Git blob SHA-1 and SHA-256.
- The two protected lab branches remain preserved, and the fixture artifacts have unique paths.
- The targeted procedural-language audit and commits listed above remain recorded in this handoff.

**Inferred**
- The empty `fetch_file.content` behavior is a practical completeness risk in the tested configuration, but it does not establish the underlying cause or a universal API limit.

**Assumed / unverified**
- The user's Free plan might relate to wrapper behavior; no evidence establishes this.
- The exact wrapper endpoint, media type, and decoding path remain unknown.

**Open**
- Whether the bootstrap discovery/activation contract has a concrete normative gap (TODO 7).
- Whether authoritative wrapper implementation details can be obtained and whether they justify any additional safeguard in `github-api-*` skills.

## Immediate next task

Audit bootstrap discovery and activation (TODO 7). Establish the exact normative contract before proposing any edit. Use the current canonical files and one pinned repository revision; distinguish required ACTIVATE owners from contextual and operation reads. If a gap is confirmed, make a minimal change and validate it with a controlled bootstrap TRACE. If no gap exists, record the evidence and close the TODO without a speculative change.

## Recommended starting context

1. `.ai/INDEX.md` — command routing and capability discovery.
2. `.ai/conversation-management/handoff/BOOTSTRAP.md` — canonical bootstrap ordering and minimum activation set.
3. `.ai/skills/activation/SKILL.md` — ACTIVATE and operation-level TRACE contract.
4. `.ai/skills/github-api-repository/SKILL.md` and `.ai/skills/github-api-workflow/SKILL.md` — host-specific owners relevant to remote operations.
5. `.ai/memory/github-api-wrapper-research.md` — TODO 7 and evidence for the later wrapper investigation.

Do not revive the completed §9 review, repeat completed fixture-size tests without a specific reason, or delete/rewrite either protected laboratory branch.