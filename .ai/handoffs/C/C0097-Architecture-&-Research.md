# Conversation Handoff

**Conversation:**
C0097 — Architecture & Research

**Specialization:**
C

**Chapter:**
0097

**Previous chapter:**
0096

## Starting objective

Run a controlled receiving-chapter initialization to test the corrected bootstrap discovery and activation contract, then continue the GitHub API wrapper research without turning hypotheses into facts.

## Bootstrap and repository state

- Canonical repository: paulhuman/aip-mirror.
- Canonical branch: main, from .ai/config.yaml.
- Repository writes and commits are available through the connected GitHub tools.
- The bootstrap discovery contract is: read .ai/config.yaml to establish repository identity, then .ai/AGENTS.md, then .ai/INDEX.md; use INDEX to select applicable canonical owners rather than reading every indexed file.
- Do not restore the removed sixth item in .ai/AGENTS.md. The intended correction is in .ai/conversation-management/handoff/BOOTSTRAP.md, committed as 77e5ae410b016f53ba8571c39f082e44c28acd05.

## Confirmed GitHub API wrapper research state

The detailed research record is .ai/memory/github-api-wrapper-research.md.

For the tested wrapper/tool configuration:
- fetch_file returned exact expected content for tested fixtures through 1,048,575 bytes.
- For tested fixtures from 1,048,576 bytes through 5,242,880 bytes, fetch_file returned empty content while reporting the expected blob SHA.
- fetch_blob returned full content for tested fixtures through 5 MiB.
- The 5 MiB returned content matched the independently recorded Git blob SHA-1 and SHA-256.
- These observations are scoped to the tested configuration. The exact wrapper implementation, endpoint/media type, and cause of empty fetch_file.content remain unknown. The Free-plan hypothesis is unverified.

Canonical lab evidence:
- Summary: https://github.com/paulhuman/github-api-lab/blob/main/docs/fetch-completeness-2026-10-12.md
- Chronological report: https://github.com/paulhuman/github-api-lab/blob/main/results/fetch-completeness-2026-10-12.md

Two laboratory branches remain protected from deletion or history rewriting unless the owner separately authorizes it:
- experiment/control-read-completeness-20261012
- experiment/fixture-5m-c0095-38260305834

Their unique fixture artifacts and branch-only commits were inventoried against the lab's canonical main. Documentation of findings does not make the original fixture artifacts disposable.

## Recent completed work in this chapter

The recent work shifted to auditing procedural language and the shared/host-specific skill boundary.

Commits on main, each limited to the stated file and verified by read-back:
- 133e1f320dc62a3cbdf4ddf12ff0127ce0da6cff — ai-docs(normative-language): simplify procedural wording; updated .ai/skills/normative-language/SKILL.md to retain direct prohibitions using DO NOT without prefixing ordinary affirmative imperatives with DO.
- 07ff5ed3125b21544f2f78ba54f7da01d124587a — ai-skills(git-cli-repository): simplify imperative wording; removed unnecessary affirmative DO prefixes while preserving prohibitions.
- a2b800fe6a018176a823518393a402a115344b39 — ai-skills(git-cli-workflow): simplify imperative wording; removed unnecessary affirmative DO prefixes.
- 8f140d849b76f8a65b3808f1f107538e075b8bcf — ai-skills(activation): simplify imperative wording; removed unnecessary affirmative DO prefixes.
- 0bf217914a80aab536daefb523b6ad3e495fbd4f — ai-skills(git-cli-workflow): fix imperative capitalization; corrected capitalization left behind by the prior wording change.

A targeted audit covered:
- .ai/skills/normative-language/SKILL.md
- .ai/skills/git-cli-repository/SKILL.md
- .ai/skills/git-cli-workflow/SKILL.md
- .ai/skills/activation/SKILL.md
- .ai/skills/repository/SKILL.md
- .ai/skills/workflow/SKILL.md
- .ai/skills/github-api-repository/SKILL.md
- .ai/skills/github-api-workflow/SKILL.md
- .ai/skills/commits/SKILL.md
- other available active skills and relevant saved audit/context records.

The regex check for affirmative `DO + verb` constructions found no remaining matches in the inspected SKILL files; DO NOT remains. The audit was targeted to recently edited skills, normative wording, host separation, and retained findings; it was not a line-by-line semantic audit of every topic in every skill.

The current architecture remains: shared host-neutral repository/workflow guidance, with remote GitHub API and local Git mechanics delegated to separate host-specific skills. Some duplication is intentional to prevent a host from loading irrelevant operational detail.

## Open review: isolation invariant in repository §9

A question was identified about the wording of .ai/skills/repository/SKILL.md §9. The shared skill describes test fixtures as preferring a disposable branch or isolated working copy, while .ai/skills/git-cli-workflow/SKILL.md requires a separate git worktree and prohibits returning to a disposable branch in the primary working copy.

This is not necessarily a conflict across all hosts, but the shared wording may delegate the mechanism insufficiently precisely. The proposed next step is to ask DSH to review both current files in full, determine whether the issue is a real ambiguity or conflict, and propose a minimal host-neutral wording change only if warranted. No file changes or commits have been made for this question; await the user's DSH response before editing.

## Repository operation invariants

For existing files:
READ CURRENT STATE → MINIMAL CHANGE → WRITE COMPLETE CONTENT → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT

- Never reconstruct existing repository content from memory when it can be fetched.
- Pin reproducibility-sensitive reads to immutable commit SHAs.
- A successful write or commit is not proof that content and scope are correct.
- Do not infer local working-copy state from remote GitHub state.
- Keep observed facts, inferences, assumptions, and open questions distinct.

## Confirmed / inferred / assumed / open

**Confirmed**
- The bootstrap discovery correction commit exists on main.
- The tested wrapper/tool configuration showed size-dependent empty fetch_file.content results on tested fixtures, while tested fetch_blob reads matched expected content.
- Both lab experiment branches remain preserved.
- The five procedural-language commits listed above exist on main and were read back.
- The targeted audit found no remaining affirmative `DO + verb` constructions in the inspected SKILL files.

**Inferred**
- Empty fetch_file.content with a matching blob SHA is a practical completeness risk in the tested configuration; it does not establish the cause.
- The shared fixture-isolation wording may be too vague about delegating host-specific mechanisms; DSH review is pending.

**Assumed / unverified**
- The user's Free plan might be related to the wrapper behavior; no evidence establishes this.

**Open**
- Which endpoint/media type and decoding behavior the wrapper uses.
- Whether authoritative wrapper implementation details are available.
- Whether a narrowly scoped additional safeguard is warranted for wrapper completeness.
- Whether .ai/skills/repository/SKILL.md §9 needs a minimal clarification after DSH reviews it alongside .ai/skills/git-cli-workflow/SKILL.md.

## Immediate next task

Receive and review the user's DSH response about the fixture-isolation wording in repository §9. Compare its evidence and proposed diff against the current canonical files. Do not modify the skills unless the review establishes a concrete ambiguity and a minimal host-neutral correction.

## Recommended starting context

Read the current .ai/skills/repository/SKILL.md and .ai/skills/git-cli-workflow/SKILL.md before evaluating DSH's proposal. Use .ai/memory/github-api-wrapper-research.md only if resuming the wrapper investigation. Do not repeat the completed fixture-size experiments without a specific reason, and do not delete or rewrite either lab branch.
