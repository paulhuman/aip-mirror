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
- Previous handoff: .ai/handoffs/C/C0096-Architecture-&-Research.md, read successfully from main.
- This handoff was absent before initialization and is being created for C0097.
- Repository writes and commits are available through the connected GitHub tools; bootstrap follows the WRITE-CAPABLE branch.
- Bootstrap discovery sequence exercised: .ai/config.yaml → .ai/AGENTS.md → .ai/INDEX.md → applicable canonical owners. INDEX was used as a discovery map; unrelated entries were not read indiscriminately.
- Do not restore the removed sixth item in .ai/AGENTS.md. The intended correction is in .ai/conversation-management/handoff/BOOTSTRAP.md, committed as 77e5ae410b016f53ba8571c39f082e44c28acd05.

## Confirmed starting research state

The active working research record is .ai/memory/github-api-wrapper-research.md (read from main).

For the tested wrapper/tool configuration:
- fetch_file returned exact expected content for tested fixtures through 1,048,575 bytes.
- For tested fixtures from 1,048,576 bytes through 5,242,880 bytes, fetch_file returned empty content while reporting the expected blob SHA.
- fetch_blob returned full content for tested fixtures through 5 MiB.
- The 5 MiB returned content matched the independently recorded Git blob SHA-1 and SHA-256.
- These are observations scoped to the tested configuration. The exact wrapper implementation, endpoint/media type, and cause of empty fetch_file.content remain unknown. The Free-plan hypothesis is unverified.

Canonical lab evidence:
- Summary: https://github.com/paulhuman/github-api-lab/blob/main/docs/fetch-completeness-2026-10-12.md
- Chronological report: https://github.com/paulhuman/github-api-lab/blob/main/results/fetch-completeness-2026-10-12.md

## Branch preservation constraints

Two laboratory branches remain protected from deletion or history rewriting unless the owner separately authorizes it:
- experiment/control-read-completeness-20261012
- experiment/fixture-5m-c0095-38260305834

Their unique fixture artifacts and branch-only commits were inventoried against the lab's canonical main. Documentation of findings does not make the original fixture artifacts disposable.

## Bootstrap correction and current validation

C0096 committed the discovery-order correction in .ai/conversation-management/handoff/BOOTSTRAP.md:
- Commit: https://github.com/paulhuman/aip-mirror/commit/77e5ae410b016f53ba8571c39f082e44c28acd05
- Commit message: ai-docs(bootstrap): require INDEX-based owner discovery
- Changed-file scope: only .ai/conversation-management/handoff/BOOTSTRAP.md.

C0097's bootstrap reads .ai/AGENTS.md before .ai/INDEX.md, then selects relevant canonical owners based on the operation and GitHub API access mechanism. The host-specific github-api-repository and github-api-workflow skills were read as applicable owners, not treated merely as incidental references. The operation TRACE records the actual activation set and additional reads.

## Immediate next tasks

1. Continue investigating the wrapper implementation only if authoritative implementation or contract evidence is accessible; otherwise preserve the cause as unknown.
2. Recheck the relevant portion of .ai/memory/github-api-wrapper-research.md before making any research update.
3. Do not modify github-api-* skills unless a concrete failure mode or useful verifiable safeguard is established.
4. Preserve both lab experiment branches; no deletion or history rewrite is authorized.

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
- The bootstrap correction commit exists on main.
- The current wrapper/tool configuration showed size-dependent empty fetch_file.content results on tested fixtures, while tested fetch_blob reads matched expected content.
- Both lab experiment branches remain preserved.

**Inferred**
- Empty fetch_file.content with a matching blob SHA is a practical completeness risk in the tested configuration; it does not establish the cause.

**Assumed / unverified**
- The user's Free plan might be related; no evidence establishes this.

**Open**
- Which endpoint/media type and decoding behavior the wrapper uses.
- Whether authoritative wrapper implementation details are available.
- Whether a narrowly scoped additional safeguard is warranted beyond the existing completeness warning.

## Recommended starting context

Use .ai/memory/github-api-wrapper-research.md for the detailed chronology and TODOs. Do not repeat the completed fixture-size experiments without a specific reason. Keep all conclusions limited to the evidence available and do not delete or rewrite either lab branch.
