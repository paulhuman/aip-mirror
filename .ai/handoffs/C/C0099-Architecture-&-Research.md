# Conversation Handoff

**Conversation:**
C0099 — Architecture & Research

**Specialization:**
C

**Chapter:**
0099

**Previous chapter:**
0098


## Starting objective

Continue the AI-infrastructure bootstrap and activation audit from C0098. Determine whether the current canonical owners define an unambiguous sequence for bootstrap discovery, ACTIVATE owner selection, and additional operation reads. Establish the normative gap, if any, before proposing a minimal change. If a gap is confirmed, correct the canonical owner and validate the behavior with a controlled bootstrap pass; if not, record the evidence and close TODO 7 without speculative edits.

After this audit, resume the GitHub API wrapper investigation by seeking authoritative implementation details before deciding whether any further safeguard is warranted.

## Bootstrap and repository state

- Canonical repository: `paulhuman/aip-mirror`.
- Canonical branch: `main`, configured in `.ai/config.yaml`.
- Current chapter: `C0099`; predecessor: `C0098`.
- The receiving handoff was created at `.ai/handoffs/C/C0099-Architecture-&-Research.md`.
- Repository write and commit capability was available through connected GitHub tools; the initial handoff is part of the explicitly authorized bootstrap workflow.
- Bootstrap discovery followed `.ai/config.yaml` → `.ai/AGENTS.md` → `.ai/INDEX.md` → `.ai/skills/repository/SKILL.md` → other applicable owners.
- INDEX was used as a discovery map, not as a requirement to read every listed file.
- The host-specific mechanism for this chapter is the GitHub API / Contents API, not a local working copy.

## Active task: bootstrap discovery and activation (TODO 7)

The working record is `.ai/memory/github-api-wrapper-research.md`, TODO 7.

C0098 describes the issue as follows:

- The C0096 TRACE did not show `.ai/INDEX.md` among operation reads.
- `.ai/skills/github-api-repository/SKILL.md` was listed as an operation read rather than an ACTIVATE owner, and `.ai/skills/github-api-workflow/SKILL.md` was not listed.
- The absence of INDEX from a TRACE does not alone prove a normative violation: the existing BOOTSTRAP minimum ACTIVATE list does not explicitly name INDEX as an activation owner.
- The unresolved question is how bootstrap is required to discover additional applicable host-specific canonical owners and distinguish “read” from “activated.”

Next steps:

1. Pin a single repository revision and compare the current `.ai/INDEX.md`, `.ai/conversation-management/handoff/BOOTSTRAP.md`, `.ai/skills/activation/SKILL.md`, and applicable host-specific skills.
2. Establish which files are required ACTIVATE owners and which are contextual/operation reads. Do not treat a read as proof of activation.
3. Identify the canonical owner for any missing discovery requirement; avoid duplicating procedural ownership in INDEX.
4. If a concrete gap is confirmed, make the smallest justified edit and perform a controlled bootstrap validation. Verify TRACE against the actual owner/read sets.
5. If no gap is confirmed, document the evidence and close TODO 7 without changing canonical files.

## Confirmed GitHub API wrapper research

Detailed evidence and outstanding TODOs are recorded in `.ai/memory/github-api-wrapper-research.md`.

For the tested wrapper/tool configuration:

- `fetch_file` returned expected content for tested fixtures up to 1,048,575 bytes.
- For tested fixtures from 1,048,576 bytes through 5,242,880 bytes, `fetch_file` returned empty content while reporting the expected blob SHA.
- `fetch_blob` returned complete content for tested fixtures through 5 MiB.
- The 5 MiB content matched the independently recorded Git blob SHA-1 and SHA-256.
- These are observations for the tested configuration, not a universal API guarantee. The exact wrapper implementation, endpoint/media type, and cause remain unknown; the Free-plan hypothesis is unverified.

Canonical lab evidence:

- Summary: https://github.com/paulhuman/github-api-lab/blob/main/docs/fetch-completeness-2026-10-12.md
- Chronological report: https://github.com/paulhuman/github-api-lab/blob/main/results/fetch-completeness-2026-10-12.md

Do not repeat completed fixture-size experiments without a specific reason. Preserve these laboratory branches; do not delete or rewrite them without separate inventory/preservation review and explicit owner authorization:

- `experiment/control-read-completeness-20261012`
- `experiment/fixture-5m-c0095-38260305834`

## Completed in C0098: shared fixture-isolation wording

The shared/host-specific boundary in `.ai/skills/repository/SKILL.md` §9 was resolved by changing only the first paragraph. The wording requires isolating fixtures from canonical project state and unrelated user work, delegating the applicable mechanism to host-specific repository/workflow skills.

- Commit: `1e13fe0ca61b6a9476f54a2d17ca87d23a41e31b` — `ai-skills(repository): delegate fixture isolation mechanics`.
- The resulting content was read back from the immutable commit; content/blob SHA and parent were verified, and comparison showed exactly one changed file with one addition and one deletion.
- The two following delegation/invariant sentences were intentionally left unchanged.
- The user explicitly cancelled the proposed DSH control review. Do not revive it as a pending task.

## Other recent completed work

C0097 recorded these commits on `main`:

- `133e1f320dc62a3cbdf4ddf12ff0127ce0da6cff` — `ai-docs(normative-language): simplify procedural wording`
- `07ff5ed3125b21544f2f78ba54f7da01d124587a` — `ai-skills(git-cli-repository): simplify imperative wording`
- `a2b800fe6a018176a823518393a402a115344b39` — `ai-skills(git-cli-workflow): simplify imperative wording`
- `8f140d849b76f8a65b3808f1f107538e075b8bcf` — `ai-skills(activation): simplify imperative wording`
- `0bf217914a80aab536daefb523b6ad3e495fbd4f` — `ai-skills(git-cli-workflow): fix imperative capitalization`

A targeted regex audit found no remaining affirmative `DO + verb` constructions in the inspected SKILL files. The audit was targeted, not a complete semantic audit of every skill.

## Architecture and operating constraints

- Keep shared host-neutral repository/workflow semantics separate from host-specific mechanics. Some duplication is intentional to avoid loading irrelevant host-specific instructions.
- For repository changes: READ CURRENT STATE → MINIMAL CHANGE → WRITE COMPLETE CONTENT → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT.
- Do not reconstruct existing repository files from memory when they can be fetched.
- Distinguish observed facts, inferences, assumptions, and open questions.
- Do not restore the removed sixth item in `.ai/AGENTS.md`.
- Do not revive the completed §9 review or cancelled DSH control review.
- Do not repeat completed fixture-size tests without a specific reason.
- Do not delete or rewrite either protected lab branch.

## Confirmed / inferred / assumed / open

**Confirmed**

- Bootstrap discovery order in the current BOOTSTRAP is configuration → AGENTS → INDEX → repository skill → applicable canonical owners.
- `.ai/INDEX.md` is a routing/discovery map, not an instruction to read every listed file.
- The fixture-isolation clarification is committed on `main` in `1e13fe0ca61b6a9476f54a2d17ca87d23a41e31b`.
- Tested `fetch_file` calls returned empty content for tested fixtures from 1 MiB through 5 MiB while reporting the expected blob SHA; tested `fetch_blob` returned complete 5 MiB content matching independent digests.
- The two laboratory experiment branches are protected and their unique fixture paths must be preserved.

**Inferred**

- Empty `fetch_file.content` is a practical completeness risk in the tested configuration, but does not establish the underlying cause or a universal API limit.

**Assumed / unverified**

- The user's Free plan might relate to wrapper behavior; no evidence establishes this.
- The exact wrapper endpoint, media type, and decoding path remain unknown.

**Open**

- Whether the bootstrap discovery/activation contract has a concrete normative gap (TODO 7).
- Whether authoritative wrapper implementation details can be obtained and whether they justify an additional safeguard in `github-api-*` skills.

## Immediate next task

Audit bootstrap discovery and activation (TODO 7). Establish the exact normative contract from a pinned revision; distinguish required ACTIVATE owners from contextual and operation reads. If a concrete gap is confirmed, make a minimal change and validate it with a controlled bootstrap TRACE. If no gap exists, document the evidence and close the TODO without a speculative change.

## Recommended starting context

1. `.ai/INDEX.md` — command routing and capability discovery.
2. `.ai/conversation-management/handoff/BOOTSTRAP.md` — canonical bootstrap ordering and minimum activation set.
3. `.ai/skills/activation/SKILL.md` — ACTIVATE and operation-level TRACE contract.
4. `.ai/skills/repository/SKILL.md` — shared repository invariants.
5. `.ai/skills/github-api-repository/SKILL.md` and `.ai/skills/github-api-workflow/SKILL.md` — remote operation and inspection mechanics.
6. `.ai/memory/github-api-wrapper-research.md` — TODO 7 and wrapper evidence.

Do not revive completed/cancelled work, repeat completed fixture tests without a specific reason, or delete/rewrite either protected laboratory branch.