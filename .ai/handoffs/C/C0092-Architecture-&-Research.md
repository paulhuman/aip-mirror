# Conversation Handoff

**Conversation:**
C0092 — Architecture & Research

**Specialization:**
C

**Chapter:**
0092

**Previous chapter:**
0091

## Starting objective

Continue the host-separated AI-infrastructure architecture investigation. Keep host-neutral semantic contracts separate from remote GitHub API / Contents API mechanics and local Git / working-copy mechanics. Also split host-specific workflow procedures into separate files where necessary so a host loading one skill does not receive unrelated instructions. The user explicitly accepts some duplication to avoid context contamination between remote and local AI execution environments.

## Bootstrap and repository state

- Repository: `paulhuman/aip-mirror`.
- Canonical branch: `main`, configured in `.ai/config.yaml`.
- Canonical receiving handoff: `.ai/handoffs/C/C0092-Architecture-&-Research.md`.
- Bootstrap inputs: `PREVIOUS_CHAPTER = 0091`, `CURRENT_CHAPTER = 0092`, `SPECIALIZATION = C`, supplied `SHORT_NAME = Architecture & Research`.
- Repository write capability is available through connected GitHub tools; this bootstrap follows the WRITE-CAPABLE branch.
- The predecessor handoff `.ai/handoffs/C/C0091-Architecture-&-Research.md` was read and remains unchanged.
- The current `.ai/conversation-management/handoff/BOOTSTRAP.md`, repository identity in `.ai/config.yaml`, and applicable canonical owners were read from `main` before creating this handoff.

## Confirmed state inherited from C0091

- The two newer audit reports were read in C0091: `.ai/memory/dsh-audit-repository-skill.md` and `.ai/memory/dsh-audit-workflow-skill.md`.
- The reports identify host-specific instructions embedded in the shared `.ai/skills/repository/SKILL.md` and `.ai/skills/workflow/SKILL.md`. Because the tested DSH runtime loads the complete body of an invoked skill, section labels inside one file do not prevent unrelated host instructions from entering context.
- The DSH evidence is version-scoped to DSH Desktop 0.11.0 and Harness `@deepseek-ai/dsh` 0.2.0-rc.2; do not generalize it to untested hosts or versions.
- The shared skills still contain both host-neutral guidance and host-specific operational mechanics on `main`. The audit recommendations and review-branch edits are not proof of an integrated architecture.
- `.ai/memory/dsh-report-repository-skill.md` and `.ai/memory/dsh-report-workflow-skill.md` are earlier audit reports that must be read and compared with the newer audits.
- `.ai/memory/dsh-skill-host-separation-working-context.md` contains accumulated rationale, metadata evidence, branch notes, and open questions; read it before making architectural changes.
- Review branch `ai-infra/host-mechanics-review` is research material only. It is not approved for automatic merge or cherry-pick and does not fully implement the user's required physical separation of host-specific instructions.
- No canonical-owner edits or review-branch integration were authorized merely by the audits.

## Recent discussion carried forward

The user clarified that `user-invocable: false` is not redundant merely because it does not block model invocation: it serves a distinct user-interface cleanliness purpose and prevents explicit user invocation. The user does not want the skill to be invocable/readable by the user through that path. Keep metadata fields' distinct runtime effects separate; do not claim one field substitutes for another. Confirm exact semantics against the existing version-scoped runtime evidence before proposing changes.

## Important constraints

- Remote and local operational guidance MUST be physically separated into different files where each host would otherwise load irrelevant instructions.
- A subsection label such as “for remote host” or “for local host” inside a fully loaded skill is not sufficient context isolation.
- Duplicating guidance is acceptable when it keeps each host's context coherent.
- Do not assume plans for additional Agentic AI hosts; current local-host evidence concerns DSH.
- Preserve repository history; do not rewrite commits.
- Do not delete, merge, or cherry-pick `ai-infra/host-mechanics-review` automatically.
- Do not modify canonical owners until the evidence set and target architecture have been compared and the intended boundaries are clear.
- Follow repository mutation safety: READ CURRENT FILE → MAKE MINIMAL CHANGE → WRITE COMPLETE FILE → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT.
- A successful API write or valid commit is not proof that content is correct.
- New documents in `.ai/docs/` and `.ai/memory/` are written in Russian, preserving technical terms, identifiers, paths, field names, and exact technical designations in their original form.

## Relevant files

- `.ai/conversation-management/handoff/BOOTSTRAP.md` — canonical new-chapter initialization procedure.
- `.ai/conversation-management/handoff/SKILL.md` — handoff structure and migration semantics.
- `.ai/skills/repository/SKILL.md` — canonical repository semantics and current host-mixed procedures.
- `.ai/skills/workflow/SKILL.md` — canonical workflow principles and current host-mixed procedures.
- `.ai/skills/activation/SKILL.md` — ACTIVATE and visible TRACE contract.
- `.ai/skills/commits/SKILL.md` — commit policy and handoff commit convention.
- `.ai/memory/dsh-audit-repository-skill.md` — newer repository-skill audit.
- `.ai/memory/dsh-audit-workflow-skill.md` — newer workflow-skill audit.
- `.ai/memory/dsh-report-repository-skill.md` — earlier repository-skill audit; read fully.
- `.ai/memory/dsh-report-workflow-skill.md` — earlier workflow-skill audit; read fully.
- `.ai/memory/dsh-skill-host-separation-working-context.md` — accumulated host-separation research and open questions.
- `.ai/memory/dsh-todo-skill-metadata-runtime.md` — version-scoped runtime evidence for DSH skill metadata.
- `.ai/docs/skill-authoring-reference.md` — reference for the tested DSH skill metadata/runtime behavior.
- `.ai/docs/agentic-ai-dsh-observations.md` — supporting observations about DSH and host boundaries.
- `.ai/docs/agentic-ai-skill-discovery-verification.md` — version-scoped discovery evidence.
- `.ai/docs/README.md` and `.ai/memory/README.md` — documentation and memory organization/language conventions.

## Research references

### AIP Mirror repository

- `paulhuman/aip-mirror`
  - Role: Canonical source for current AI-infrastructure owners, working records, and project decisions.
  - URL: https://github.com/paulhuman/aip-mirror

### DSH runtime evidence

- `.ai/memory/dsh-audit-repository-skill.md`
  - Role: Audit of repository semantics and host-specific hazards under the tested local DSH/Git environment.
  - URL: https://github.com/paulhuman/aip-mirror/blob/main/.ai/memory/dsh-audit-repository-skill.md
- `.ai/memory/dsh-audit-workflow-skill.md`
  - Role: Audit of workflow methodology and repository-wide inspection under the tested local DSH/Git environment.
  - URL: https://github.com/paulhuman/aip-mirror/blob/main/.ai/memory/dsh-audit-workflow-skill.md
- `paulhuman/skills`
  - Role: Declared reference repository for reusable skill structure, discovery, and capability conventions.
  - URL: https://github.com/paulhuman/skills
- `ai-infra/host-mechanics-review`
  - Role: Unmerged candidate changes for comparison only; not an approved integration target.
  - URL: https://github.com/paulhuman/aip-mirror/tree/ai-infra/host-mechanics-review

## Confirmed / inferred / open

- **Confirmed:** The user requires physically separate remote and local operational files to prevent unrelated host-specific context from being loaded.
- **Confirmed as version-scoped evidence:** In the tested DSH versions, invoked skill body content is loaded as a whole; adjacent resource files are not automatically included by default.
- **Confirmed:** The user accepts duplication when needed for context separation.
- **Confirmed:** The review branch is comparison material, not an authorized integration target.
- **Confirmed:** Metadata fields have distinct effects; `user-invocable: false` should not be treated as equivalent to `disable-model-invocation: true`.
- **Inferred:** A layered design with shared host-neutral semantics and physically separate remote/local procedures remains the likely direction.
- **Open:** Exact file boundaries and routing; differences between the four audit reports; how to separate host-specific workflow inspection while preserving one coherent shared contract; how metadata visibility/invocation controls should be assigned to each skill.
- **Not assumed:** That DSH runtime findings generalize beyond tested versions; that review-branch changes are safe to integrate as-is; or that the proposed architecture has already been accepted or implemented.

## Immediate next task

1. Read `.ai/memory/dsh-report-repository-skill.md`, `.ai/memory/dsh-report-workflow-skill.md`, and `.ai/memory/dsh-skill-host-separation-working-context.md` in full.
2. Compare all four audit reports against the current canonical `repository` and `workflow` skills on `main`.
3. Reconcile the metadata discussion with `.ai/memory/dsh-todo-skill-metadata-runtime.md` and `.ai/docs/skill-authoring-reference.md`, preserving the distinction between UI visibility, explicit user invocation, and model invocation.
4. Inspect the review branch as evidence only; do not merge or cherry-pick.
5. Present a concrete proposed file layout and routing model before changing canonical owners.

## Recommended starting context

Begin with the three unread working-context/audit files listed in the immediate next task. Then compare the current `main` versions of the canonical skills and the review branch, using the actual repository contents rather than reconstructing prior state from conversation memory.
