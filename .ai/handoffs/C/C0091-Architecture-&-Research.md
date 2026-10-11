# Conversation Handoff

**Conversation:**
C0091 — Architecture & Research

**Specialization:**
C

**Chapter:**
0091

**Previous chapter:**
0090

## Bootstrap and repository state

- Repository: `paulhuman/aip-mirror`.
- Canonical branch: `main`, configured in `.ai/config.yaml`.
- Bootstrap inputs: `PREVIOUS_CHAPTER = 0090`, `CURRENT_CHAPTER = 0091`, `SPECIALIZATION = C`, supplied `SHORT_NAME = Architecture & Research`.
- Canonical receiving handoff: `.ai/handoffs/C/C0091-Architecture-&-Research.md`.
- Repository write capability is available through the connected GitHub tools; this chapter follows the WRITE-CAPABLE bootstrap branch.
- The predecessor handoff `.ai/handoffs/C/C0090-Architecture-&-Research.md` was read and remains unchanged.
- The two DSH audit reports explicitly deferred to this chapter have now been read: `.ai/memory/dsh-audit-repository-skill.md` and `.ai/memory/dsh-audit-workflow-skill.md`.
- Repository recent-commit search returned `55a8f935c7e251019e6b83e45716b107016bc002` as its newest result at bootstrap. The connector response did not include enough branch-ref/tree metadata to independently prove this is the current `main` HEAD; do not overstate that verification.

## Current project objective

Design a safe host-separated architecture for AIP Mirror's AI infrastructure. Keep shared host-neutral semantics separate from remote GitHub API / Contents API mechanics and local Git / working-copy mechanics. Also separate host-specific workflow procedures where necessary so a host loading one skill does not receive unrelated operational instructions. The user explicitly accepts some duplication to prevent context contamination between different AI execution environments.

## Confirmed starting state

- Current `.ai/skills/repository/SKILL.md` and `.ai/skills/workflow/SKILL.md` on `main` contain both host-neutral guidance and host-specific operational instructions.
- The DSH audits report that DSH Desktop 0.11.0 / Harness `@deepseek-ai/dsh` 0.2.0-rc.2 loads the complete body of a skill when invoked, while adjacent files are not included by default. These are version-scoped audit findings, not universal guarantees for every host.
- `.ai/memory/dsh-audit-repository-skill.md` reports a potentially destructive mismatch: the disposable-fixture guidance includes a ref-movement procedure that the local DSH/Git environment interprets as unsafe and that was experimentally associated with loss of uncommitted work in a disposable test. It recommends isolating fixtures (for example, with a separate worktree), preserving existing user work, and separating GitHub Contents API mechanics from local Git procedures.
- `.ai/memory/dsh-audit-workflow-skill.md` reports that workflow §9 is written around remote tree/contents API inspection, includes the nonexistent path `.ai/docs/architecture/*`, and omits local working-copy/ignored-state considerations. It recommends retaining the host-neutral principle of verifying coverage while moving host-specific implementations out of shared loaded content.
- Both reports identify the same architecture direction: preserve host-neutral invariants in canonical shared owners; place host-specific procedures in physically separate files. A subsection label alone does not prevent the full skill body from entering context.
- DSH metadata findings are recorded in `.ai/memory/dsh-todo-skill-metadata-runtime.md` and apply only to the tested versions. `disable-model-invocation: true` controls visibility of an entire skill; it is not a substitute for splitting mixed-host instructions inside a file.
- The review branch `ai-infra/host-mechanics-review` is research material only. Its proposed changes are not approved for automatic merge/cherry-pick and do not fully implement the user's file-separation requirement.

## Immediate next task

1. Read the two earlier reports in full: `.ai/memory/dsh-report-repository-skill.md` and `.ai/memory/dsh-report-workflow-skill.md`.
2. Compare all four audits against the current canonical owners and the detailed working record `.ai/memory/dsh-skill-host-separation-working-context.md`. Separate independently supported evidence, repeated findings, recommendations, and unresolved questions.
3. Re-check the current `main` HEAD and relevant branch state using authoritative repository evidence before making repository-wide claims.
4. Propose a minimal target file structure distinguishing shared contract, remote API operations, local Git operations, and host-specific workflows. Decide which host-specific files belong inside versus outside `.ai/skills/` based on whether they should be discoverable/loaded by the other host.
5. Do not modify canonical owners or integrate the review branch until the audit comparison and target architecture have been evaluated and the implementation scope is clear.

## Important constraints

- Preserve repository history; do not rewrite commits.
- Do not delete or move `ai-infra/host-mechanics-review`.
- Do not merge or cherry-pick that branch automatically.
- Do not modify canonical owners before comparing the full evidence set and evaluating the target architecture.
- Follow the repository mutation sequence: READ CURRENT FILE → MAKE MINIMAL CHANGE → WRITE COMPLETE FILE → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT.
- A successful API write or valid Git commit is not proof that content is correct.
- Preserve the distinction between DSH-specific runtime evidence and AIP Mirror's own architectural decisions.
- New documents in `.ai/docs/` and `.ai/memory/` are written in Russian, preserving technical terms, identifiers, paths, field names, and exact technical designations in their original form.

## Relevant files

- `.ai/conversation-management/handoff/BOOTSTRAP.md` — canonical receiving-chapter bootstrap procedure.
- `.ai/conversation-management/handoff/SKILL.md` — handoff structure and lifecycle.
- `.ai/skills/repository/SKILL.md` — current repository semantic owner to reassess.
- `.ai/skills/workflow/SKILL.md` — current workflow owner to reassess.
- `.ai/skills/commits/SKILL.md` — commit policy and handoff commit format.
- `.ai/memory/dsh-audit-repository-skill.md` — additional repository skill audit; read in bootstrap.
- `.ai/memory/dsh-audit-workflow-skill.md` — additional workflow skill audit; read in bootstrap.
- `.ai/memory/dsh-report-repository-skill.md` — earlier repository skill audit; next task is to read fully.
- `.ai/memory/dsh-report-workflow-skill.md` — earlier workflow skill audit; next task is to read fully.
- `.ai/memory/dsh-skill-host-separation-working-context.md` — detailed accumulated research, decisions, branch notes, and open questions.
- `.ai/memory/dsh-todo-skill-metadata-runtime.md` — closed, version-scoped DSH metadata runtime investigation.
- `.ai/docs/skill-authoring-reference.md` — DSH skill metadata/runtime reference.
- `.ai/docs/agentic-ai-dsh-observations.md` — supporting DSH observations.
- `.ai/docs/agentic-ai-skill-discovery-verification.md` — discovery verification and version-dependent evidence.
- `.ai/docs/README.md` and `.ai/memory/README.md` — documentation/memory purpose and language rules.

## Research references

### AIP Mirror repository

- `paulhuman/aip-mirror`
  - Role: Canonical source for current AI-infrastructure owners, working records, and project decisions.
  - URL: https://github.com/paulhuman/aip-mirror

### DSH research references

- `.ai/memory/dsh-audit-repository-skill.md`
  - Role: Independent DSH/local-Git audit of repository semantics and host-specific hazards.
  - URL: https://github.com/paulhuman/aip-mirror/blob/main/.ai/memory/dsh-audit-repository-skill.md
- `.ai/memory/dsh-audit-workflow-skill.md`
  - Role: Independent DSH/local-Git audit of workflow methodology and repository-wide inspection.
  - URL: https://github.com/paulhuman/aip-mirror/blob/main/.ai/memory/dsh-audit-workflow-skill.md
- `ai-infra/host-mechanics-review`
  - Role: Unmerged candidate changes for comparison only; not an approved integration target.
  - URL: https://github.com/paulhuman/aip-mirror/tree/ai-infra/host-mechanics-review

## Confirmed / inferred / open

- **Confirmed:** The user requires remote API and local Git instructions to live in different files; workflow guidance must also be separated where needed to avoid irrelevant host-specific context.
- **Confirmed as version-scoped DSH audit findings:** The two newly read audit reports identify host-mixed instructions in both canonical skills and recommend extracting host mechanics rather than relying on labels inside a loaded file.
- **Confirmed:** The additional reports do not authorize direct changes to canonical owners or automatic integration of the review branch.
- **Inferred:** A layered design will likely be needed: a shared semantic contract plus distinct host-specific operational procedures. Exact file placement and routing remain undecided.
- **Open:** Differences between the earlier and newer audit reports; the smallest coherent target file layout; which mechanics belong in adjacent skill resources versus outside `.ai/skills/`; exact changes needed in the canonical owners.
- **Not assumed:** That the audit recommendations are already integrated into `main`, that DSH behavior generalizes to other hosts, or that the review branch is safe to merge as-is.

## Recommended starting context

Start with the two earlier audit reports, then compare all four reports alongside the current `repository` and `workflow` skills. Read the working-context memory for the rationale and branch history. Formulate and evaluate the file-boundary proposal before changing canonical files.
