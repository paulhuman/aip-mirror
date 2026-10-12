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

Continue the controlled bootstrap and AI-infrastructure architecture work. First, receive and evaluate the pending DSH review of the fixture-isolation wording in the shared repository skill; make no change unless the review establishes a concrete ambiguity and supports a minimal host-neutral correction.

## Bootstrap and repository state

- Canonical repository: `paulhuman/aip-mirror`.
- Canonical branch: `main`, configured in `.ai/config.yaml`.
- Repository write/commit capability is available through the connected GitHub tools.
- Initialization order followed: `.ai/config.yaml` → `.ai/AGENTS.md` → `.ai/INDEX.md` → `.ai/skills/repository/SKILL.md` → applicable canonical owners.
- INDEX was used as a discovery map; unrelated indexed skills were not loaded indiscriminately.
- New handoff path: `.ai/handoffs/C/C0098-Architecture-&-Research.md`.

## Immediate pending review: shared fixture-isolation wording

The predecessor C0097 handoff records this open question:

- `.ai/skills/repository/SKILL.md` §9 says an isolated repository test should prefer a disposable branch or isolated working copy.
- `.ai/skills/git-cli-workflow/SKILL.md` requires a separate Git worktree and prohibits returning to a disposable branch in the primary working copy.
- The concern is whether the shared wording delegates host-specific isolation mechanics precisely enough. This is not yet established as a cross-host contradiction.

**Next action:** receive the user's DSH response; reread the current full versions of both canonical skills; compare the evidence and proposed diff. Do not edit either file unless a concrete ambiguity is demonstrated and the minimal correction remains host-neutral.

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
- Bootstrap discovery order requires reading `.ai/config.yaml`, then `.ai/AGENTS.md`, then `.ai/INDEX.md`; INDEX selects applicable owners rather than requiring every indexed file to be read.
- The tested GitHub wrapper configuration exhibits size-dependent empty `fetch_file.content` responses while `fetch_blob` succeeded on the tested large fixtures.
- The two lab experiment branches listed above remain preserved.
- The C0097 targeted procedural-language audit and listed commits are recorded in the predecessor handoff.

**Inferred**
- The shared fixture-isolation wording may be too vague about delegating host-specific mechanisms; DSH review is pending.

**Assumed / unverified**
- The user's Free plan might relate to wrapper behavior; no evidence establishes this.

**Open**
- Whether `.ai/skills/repository/SKILL.md` §9 needs a minimal clarification after DSH reviews it alongside `.ai/skills/git-cli-workflow/SKILL.md`.
- The exact endpoint/media type and decoding behavior behind `fetch_file` responses.

## Immediate next task

Receive and review the user's DSH response about fixture-isolation wording. Compare it with the current full canonical files and make no changes until the evidence warrants a minimal correction.

## Recommended starting context

1. `.ai/skills/repository/SKILL.md` §9.
2. `.ai/skills/git-cli-workflow/SKILL.md` fixture-isolation requirements.
3. `.ai/memory/github-api-wrapper-research.md` only if resuming wrapper-completeness research.

Do not repeat completed fixture-size tests without a specific reason, and do not delete or rewrite either protected lab branch.
