# Conversation Handoff

**Conversation:**
C0090 — Architecture & Research

**Specialization:**
C

**Chapter:**
0090

**Previous chapter:**
0089

## Bootstrap and repository state

- Repository: `paulhuman/aip-mirror`.
- Canonical branch: `main`, from `.ai/config.yaml`.
- Bootstrap inputs: `PREVIOUS_CHAPTER = 0089`, `CURRENT_CHAPTER = 0090`, `SPECIALIZATION = C`, supplied `SHORT_NAME = Architecture & Research`.
- Canonical receiving handoff: `.ai/handoffs/C/C0090-Architecture-&-Research.md`.
- Repository write capability is available through the connected GitHub tools; this chapter follows the WRITE-CAPABLE bootstrap branch.
- The predecessor handoff `.ai/handoffs/C/C0089-Architecture-&-Research.md` was read. It was not modified.
- The current `main` head at bootstrap was verified through the recent commit list as `2a2bfec821d2fd616e3d15389310b405f3a6a395`, commit `ai-docs(handoff): update C0089`, created 2026-10-11T13:48:39Z.

## Current project objective

Continue Architecture & Research work on separating AI-infrastructure instructions by host execution mechanism. The user has confirmed that remote API and local Git instructions must live in separate files, including separate host-specific workflow files, because a host reads the entire skill and labels inside one file do not prevent irrelevant instructions from entering context. Duplication is acceptable when it prevents cross-host context contamination.

Do not integrate the review branch or modify canonical owners yet. The next chapter must read and compare the two additional DSH audits listed below before proposing a target architecture.

## Confirmed starting state

- .ai/memory/dsh-todo-skill-metadata-runtime.md now has the title “ЗАКРЫТО: runtime-семантика skill metadata в DSH” and records version-scoped results for DSH Desktop 0.11.0 and Harness 0.2.0-rc.2. Do not carry forward the former OPEN status from the initial C0090 handoff snapshot.
- The tested findings distinguish whenToUse, disable-model-invocation, and user-invocable; they are DSH-specific and version-dependent, not universal guarantees for other hosts.
- Two earlier audits are available: .ai/memory/dsh-report-repository-skill.md and .ai/memory/dsh-report-workflow-skill.md.
- Two additional audits are now present on main: .ai/memory/dsh-audit-repository-skill.md and .ai/memory/dsh-audit-workflow-skill.md. Their contents were intentionally not read in C0090 at the user's request. C0091 MUST read both before architecture decisions.
- .ai/docs/skill-authoring-reference.md documents the investigated DSH front matter/runtime behavior. .ai/docs/agentic-ai-dsh-observations.md and .ai/docs/agentic-ai-skill-discovery-verification.md provide supporting context and version-dependent discovery evidence.
- ai-infra/host-mechanics-review contains proposed revisions to repository/SKILL.md and workflow/SKILL.md, but these revisions are not integrated into main and do not fully implement the user's requirement to split host-specific guidance into separate files.

## Immediate next task

1. Verify the current main HEAD and reread applicable canonical owners.
2. Read both new DSH audits in full: .ai/memory/dsh-audit-repository-skill.md and .ai/memory/dsh-audit-workflow-skill.md.
3. Compare them with .ai/memory/dsh-report-repository-skill.md and .ai/memory/dsh-report-workflow-skill.md; distinguish new evidence, repeated findings, and recommendations.
4. Reassess the current owners and review branch. Design separate files for shared contract, remote API operations, local Git operations, and host-specific workflows as appropriate. Exact names and boundaries remain undecided.
5. Do not integrate or modify canonical owners until the audit comparison and target architecture have been evaluated. Do not merge or cherry-pick ai-infra/host-mechanics-review automatically.
6. Keep DSH-specific runtime observations separate from AIP Mirror's own integration decisions.

## Important constraints

- Preserve repository history; do not rewrite commits.
- Do not delete or move the former working branch `c0086/ai-docs-audit-translation`.
- Follow the repository mutation sequence: READ CURRENT FILE → MAKE MINIMAL CHANGE → WRITE COMPLETE FILE → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT.
- A successful API write or valid Git commit is not proof that content is correct.
- Keep DSH-specific observations separate from confirmed AIP Mirror integration decisions.
- Preserve uncertainty; do not present unverified runtime semantics as facts.
- New documents in `.ai/docs/` and `.ai/memory/` are written in Russian, retaining technical terms, identifiers, paths, field names, and exact technical designations in their original form.

## Relevant files

- .ai/memory/dsh-skill-host-separation-working-context.md — detailed C0090 working record, decisions, findings, and links.
- .ai/memory/dsh-report-repository-skill.md — first DSH audit of the repository skill.
- .ai/memory/dsh-report-workflow-skill.md — first DSH audit of the workflow skill.
- .ai/memory/dsh-audit-repository-skill.md — additional audit; MUST be read in C0091.
- .ai/memory/dsh-audit-workflow-skill.md — additional audit; MUST be read in C0091.
- .ai/memory/dsh-todo-skill-metadata-runtime.md — closed, version-scoped runtime investigation.
- .ai/docs/skill-authoring-reference.md — investigated skill front matter and DSH behavior.
- .ai/docs/agentic-ai-dsh-observations.md — supporting, version-dependent DSH observations.
- .ai/docs/agentic-ai-skill-discovery-verification.md — discovery verification record and historical observations.
- .ai/memory/README.md — working-memory purpose and language policy.
- .ai/docs/README.md — documentation inventory and ownership boundaries.
- .ai/skills/repository/SKILL.md and .ai/skills/workflow/SKILL.md — current main owners to reassess.
- ai-infra/host-mechanics-review — review branch containing a partial proposed adaptation, not approved for integration.

## Research references

### AIP Mirror repository

- Repository: https://github.com/paulhuman/aip-mirror
  - Role: Canonical source for current AIP Mirror AI-infrastructure integration rules, working records, and supporting documentation.

### DSH research references

- .ai/memory/dsh-todo-skill-metadata-runtime.md
- .ai/docs/skill-authoring-reference.md
- .ai/docs/agentic-ai-dsh-observations.md
- .ai/docs/agentic-ai-skill-discovery-verification.md
  - Role: Version-scoped DSH runtime/discovery evidence and supporting records. Consult the detailed working-context memory for exact GitHub links and findings.

## Confirmed / inferred / open

- **Confirmed:** The user requires host-specific instructions to be physically separated into different files, including workflow guidance; duplication is acceptable if it prevents cross-host context contamination.
- **Confirmed as version-scoped DSH findings:** The metadata runtime record is marked closed and reports tested behavior for DSH Desktop 0.11.0 / Harness 0.2.0-rc.2.
- **Confirmed:** The two new audit files exist on main; their contents were not read in C0090 and must be read in C0091.
- **Confirmed:** The review branch and main have diverged. The review branch is material for comparison, not an approved integration target.
- **Open:** Exact target file names/boundaries and the minimal set of changes to implement the user's host-separation decision.
- **Not assumed:** That recommendations in any audit are already integrated, that a branch's current skill edits fully satisfy the agreed architecture, or that DSH observations generalize to other hosts.

## Migration checkpoint — C0090 → C0091 (2026-10-11)

### Migration validation

- Command: >>migrate 0091.
- Current chapter context: C0090, established by the active chapter and canonical handoff header.
- Expected target: C0091; the supplied assertion 0091 matches exactly one sequential increment.
- Repository: paulhuman/aip-mirror; default branch: main, confirmed by .ai/config.yaml.
- main HEAD before this migration checkpoint update: ea14fab6f56935eee3a4c85569dd16519c56ae23, which created .ai/memory/dsh-skill-host-separation-working-context.md.
- The current C0090 handoff was reread from main before editing. Only this handoff is being updated by the migration checkpoint.

### Work completed in C0090

- Read the two initial DSH audits for repository/SKILL.md and workflow/SKILL.md, the DSH metadata runtime report, the skill-authoring reference, the DSH observations and discovery verification documents, and current main versions of relevant canonical owners.
- Confirmed that the DSH metadata runtime record is now closed and contains version-scoped findings for DSH Desktop 0.11.0 and Harness 0.2.0-rc.2.
- Reviewed the review branch ai-infra/host-mechanics-review as a source of candidate improvements, not as an approved integration.
- Recorded the user's architectural decision: physically separate remote API and local Git guidance into different files; split workflow guidance too; duplication is acceptable where it reduces context contamination.
- Created .ai/memory/dsh-skill-host-separation-working-context.md with accumulated findings, relevant links, branch state, constraints, and the next-step plan.
- The two new audits .ai/memory/dsh-audit-repository-skill.md and .ai/memory/dsh-audit-workflow-skill.md are present on main, but their contents were intentionally not read in C0090 per the user's instruction to read them in the new chat.

### Immediate next task for C0091

1. Read both .ai/memory/dsh-audit-repository-skill.md and .ai/memory/dsh-audit-workflow-skill.md before making architecture decisions.
2. Read .ai/memory/dsh-skill-host-separation-working-context.md for detailed findings and links.
3. Compare all four audit reports and current canonical owners; separate new evidence from repeated findings and proposals.
4. Decide the target file structure before editing. Do not merge/cherry-pick the review branch or integrate its changes automatically.
5. If implementation is then authorized by the agreed task, follow the full repository mutation verification protocol.

### Migration constraints

- Preserve repository history; do not rebase or rewrite commits.
- Do not delete or move ai-infra/host-mechanics-review as part of this migration.
- Do not modify canonical owners before reading the two additional audits and assessing the full evidence set.
- Keep DSH runtime findings and AIP Mirror integration decisions clearly distinguished.
