# Conversation Handoff

**Conversation:**
C0100 — Architecture & Research

**Specialization:**
C

**Chapter:**
0100

**Previous chapter:**
0099

## Starting objective

Continue TODO 1 in `.ai/memory/github-api-wrapper-research.md`: seek authoritative evidence about the implementation of the connected `mcp__GitHub__fetch_file` and `mcp__GitHub__fetch_blob` wrappers. If no authoritative implementation source is available, identify a concrete reproducible experiment that narrows the observed behavior without repeating completed fixture-size tests or mutating protected laboratory branches.

## Bootstrap and repository state

- Canonical repository: `paulhuman/aip-mirror`.
- Canonical branch: `main`, configured in `.ai/config.yaml`.
- Current chapter: `C0100`; predecessor: `C0099`.
- Initial handoff path: `.ai/handoffs/C/C0100-Architecture-&-Research.md`.
- Repository writes and commits are available through connected GitHub tools; this initial handoff is an explicitly authorized bootstrap mutation.
- Bootstrap discovery was performed in the required order: `.ai/config.yaml` → `.ai/AGENTS.md` → `.ai/INDEX.md` → `.ai/skills/repository/SKILL.md` → applicable canonical owners.
- The active repository mechanism is GitHub remote API / Contents API; no local working copy is assumed.

## Completed in C0099

### Bootstrap discovery and activation audit (TODO 7)

The audit found no demonstrated normative gap in the current discovery → activation contract:

- BOOTSTRAP orders discovery as configuration → `.ai/AGENTS.md` → `.ai/INDEX.md` → `.ai/skills/repository/SKILL.md` as the first semantic owner → other applicable canonical owners.
- INDEX selects applicable owners; it does not require indiscriminate reading of every listed skill.
- INDEX is a discovery/router file, not an ACTIVATE owner merely because bootstrap reads it. If read during an operation, it belongs in `OPERATION READS`, not duplicated among ACTIVATE owners.
- The C0096 TRACE does not prove whether INDEX was skipped or omitted from the trace. The historical evidence is incomplete, not proof of a current normative violation.
- No canonical skills were changed for TODO 7. The conclusion is recorded in `.ai/memory/github-api-wrapper-research.md`; TODO 7 is CLOSED.

### Git tree retrieval procedure (TODO 8)

TODO 8 is CLOSED. `.ai/skills/github-api-workflow/SKILL.md` documents the retrieval sequence through `mcp__GitHub__fetch`: resolve a ref to a commit SHA, obtain the root tree SHA, fetch the recursive tree, verify the SHA and `truncated`, fall back to bounded non-recursive subtree traversal when needed, and pin later file reads to the same commit.

Relevant commits:
- `a55ed27fd319eceac94d897b2fe11fa43093a67b` — `ai-skills(github-api-workflow): document tree fetch sequence`.
- `77e1d6ab7ed7e7b071d1ab862d0c76730fbdd7d1` — `ai-skills(github-api-workflow): tidy tree procedure spacing`.
- `6f0433f9164edaf1096c4e629b80c19602d8422b` — `ai-memory(github-api): close Git tree fetch TODO`.

At that pinned snapshot, a tree check returned 294 entries with `truncated: false`; the returned tree SHA matched the requested root tree SHA. This verifies that snapshot, not the contents of every file.

## Confirmed wrapper observations

For the tested wrapper/tool configuration:

- `fetch_file` returned expected content for tested fixtures up to 1,048,575 bytes.
- For tested fixtures from 1,048,576 bytes through 5,242,880 bytes, `fetch_file` returned empty content while reporting the expected blob SHA.
- `fetch_blob` returned complete content for tested fixtures through 5 MiB.
- The 5 MiB content matched the independently recorded Git blob SHA-1 and SHA-256.
- These are observations for the tested configuration, not a universal API guarantee. The exact wrapper implementation, endpoint/media type, decoding path, and cause remain unknown. The Free-plan hypothesis is unverified.

Canonical lab evidence:
- Summary: https://github.com/paulhuman/github-api-lab/blob/main/docs/fetch-completeness-2026-10-12.md
- Chronological report: https://github.com/paulhuman/github-api-lab/blob/main/results/fetch-completeness-2026-10-12.md

Do not repeat completed fixture-size experiments without a specific reason. Preserve these laboratory branches; do not delete or rewrite them without separate inventory/preservation review and explicit owner authorization:
- `experiment/control-read-completeness-20261012`
- `experiment/fixture-5m-c0095-38260305834`

## C0099 research result: wrapper implementation source

Searching the exact names `mcp__GitHub__fetch_file` and `mcp__GitHub__fetch_blob` did not identify public source code or authoritative documentation tying these specific tools to an internal endpoint, headers, media type, or decoding algorithm.

The public official GitHub MCP Server repository documents a different tool contract, including `get_file_contents`. Do not treat it as the implementation of these connected wrappers without evidence that this integration actually uses that server and code path.

Confirmed for the current environment:
- Tool metadata exposes available arguments and result fields, but not the wrappers' internal implementation.
- `mcp__GitHub__fetch` successfully executed a Git Data API request and returned a complete recursive tree for the C0099 snapshot.
- This success validates that method for that tree request; it does not establish the internal path used by `fetch_file`.

Conclusion: no authoritative implementation source has been found. Do not attribute an endpoint or media type to the wrappers by analogy with unrelated public MCP servers. Do not change canonical skills based only on the unsuccessful source search. TODO 1 remains OPEN.

## Important constraints

- Keep shared host-neutral repository/workflow semantics separate from host-specific mechanics. Some duplication is intentional to avoid loading irrelevant host-specific instructions.
- For repository changes: READ CURRENT STATE → MINIMAL CHANGE → WRITE COMPLETE CONTENT → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT.
- Do not reconstruct existing repository files from memory when they can be fetched.
- Distinguish observed facts, inferences, assumptions, and open questions.
- Do not restore the removed sixth item in `.ai/AGENTS.md`.
- Do not revive the completed §9 fixture-isolation review or the cancelled DSH control review.
- Do not repeat completed fixture-size tests without a specific reason.
- Do not delete or rewrite either protected laboratory branch.

## Confirmed / inferred / assumed / open

**Confirmed**
- TODO 7 and TODO 8 are CLOSED.
- No normative discovery → activation gap was demonstrated in C0099.
- The pinned tree retrieval sequence is documented in `.ai/skills/github-api-workflow/SKILL.md`.
- The tested `fetch_file` calls returned empty content for tested fixtures from 1 MiB through 5 MiB while reporting the expected blob SHA; tested `fetch_blob` returned complete 5 MiB content matching independent digests.
- Both laboratory experiment branches contain unique fixture paths and must be preserved.

**Inferred**
- Empty `fetch_file.content` is a practical completeness risk in the tested configuration, but the underlying cause and any universal limit are not established.

**Assumed / unverified**
- The user's Free plan might relate to wrapper behavior; no evidence establishes this.
- The exact wrapper endpoint, media type, and decoding path remain unknown.

**Open**
- Whether authoritative implementation details can be obtained for the connected wrappers.
- If no source is available, what specific reproducible experiment can narrow the cause without repeating completed size tests or changing protected branches.

## Immediate next task

Continue TODO 1 in `.ai/memory/github-api-wrapper-research.md`:

1. Inspect the available integration/tool metadata and search for an authoritative source that explicitly identifies these exact wrapper implementations.
2. Keep evidence about these connected tools separate from documentation for unrelated GitHub MCP servers.
3. If no authoritative source exists, propose a concrete experiment that changes one meaningful variable while preserving existing lab evidence and avoiding repeated fixture-size tests.
4. Update canonical memory or skills only if new evidence justifies a durable change; otherwise record the limitation and next evidence-producing step.

## Recommended starting context

1. `.ai/memory/github-api-wrapper-research.md` — open TODO 1 and prior evidence.
2. `.ai/skills/github-api-repository/SKILL.md` — remote read/write safety and content-completeness requirements.
3. `.ai/skills/github-api-workflow/SKILL.md` — pinned remote tree inspection and coverage procedure.
4. `.ai/skills/workflow/SKILL.md` — research-first workflow and evidence classification.
5. `.ai/INDEX.md` — operational routing and capability discovery.

Do not reopen completed TODO 7 or TODO 8, repeat completed fixture-size experiments without a specific reason, or delete/rewrite either protected laboratory branch.
