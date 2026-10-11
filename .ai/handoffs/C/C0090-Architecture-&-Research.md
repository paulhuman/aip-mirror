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

Continue Architecture & Research work from the current repository state. Unless the user assigns another task, carry forward the only open task identified by C0089: obtain primary-source and reproducible, version-scoped evidence for DSH skill metadata runtime semantics.

## Confirmed starting state

- The current `.ai/memory/dsh-todo-skill-metadata-runtime.md` was read on `main`; its status is **OPEN**.
- The task concerns `whenToUse`, `disable-model-invocation`, and `user-invocable`, and requires exact tested version/environment, primary-source references, reproducible test setups and outcomes, and explicit separation of guarantees, observations, hypotheses, and unresolved questions.
- `.ai/docs/agentic-ai-dsh-observations.md` cautions that its findings are version-dependent observations rather than a timeless DSH specification. It notes that documenting a metadata field alone does not establish runtime behavior.
- `.ai/docs/agentic-ai-skill-discovery-verification.md` contains a longer working verification record and historical DSH-specific observations. Its current relevance and version scope must be evaluated before relying on individual claims.
- No new DSH-produced primary sources or reproducible runtime evidence have been established by this bootstrap.

## Immediate next task

1. Before substantive repository work, verify the current `main` HEAD again.
2. Investigate DSH primary sources and reproducible, version-scoped evidence relevant to the open TODO.
3. Assess whether the evidence satisfies the TODO's completion criteria before proposing AIP Mirror integration changes.
4. Keep the DSH TODO OPEN until its evidence requirements are met.
5. If no new evidence or user-assigned task is available, ask the user what to work on next instead of inventing additional scope.

## Important constraints

- Preserve repository history; do not rewrite commits.
- Do not delete or move the former working branch `c0086/ai-docs-audit-translation`.
- Follow the repository mutation sequence: READ CURRENT FILE → MAKE MINIMAL CHANGE → WRITE COMPLETE FILE → READ BACK → VERIFY CONTENT → INSPECT DIFF → VERIFY SCOPE → COMMIT → VERIFY RESULT.
- A successful API write or valid Git commit is not proof that content is correct.
- Keep DSH-specific observations separate from confirmed AIP Mirror integration decisions.
- Preserve uncertainty; do not present unverified runtime semantics as facts.
- New documents in `.ai/docs/` and `.ai/memory/` are written in Russian, retaining technical terms, identifiers, paths, field names, and exact technical designations in their original form.

## Relevant files

- `.ai/memory/dsh-todo-skill-metadata-runtime.md` — open task and completion criteria.
- `.ai/docs/agentic-ai-dsh-observations.md` — supporting, version-dependent DSH observations.
- `.ai/docs/agentic-ai-skill-discovery-verification.md` — working verification record and historical observations.
- `.ai/memory/README.md` — working-memory purpose and language policy.
- `.ai/docs/README.md` — documentation inventory, language policy, and ownership boundaries.
- `.ai/skills/repository/SKILL.md` — repository identity, safe mutation, and verification.
- `.ai/skills/workflow/SKILL.md` — research-first workflow.
- `.ai/skills/commits/SKILL.md` — commit policy and message conventions.
- `.ai/conversation-management/handoff/BOOTSTRAP.md` — receiving-chapter bootstrap procedure.

## Research references

### AIP Mirror repository

- Repository: https://github.com/paulhuman/aip-mirror
  - Role: Canonical source for current AIP Mirror AI-infrastructure integration rules, working records, and supporting documentation.

### DSH primary sources

- Exact source URLs and tested DSH revision remain to be identified or revalidated.
  - Role: Required evidence for the external runtime-semantics task; unversioned assumptions and incidental browsing are not substitutes.

## Confirmed / inferred / open

- **Confirmed:** Repository identity, configured default branch, current main head from recent commit evidence, bootstrap inputs, predecessor handoff, and OPEN status/content of the DSH TODO were read from repository sources.
- **Confirmed as recorded observations, not universal guarantees:** The DSH documents contain version-dependent observations and explicitly call for checking primary sources or controlled experiments for the target version.
- **Open:** Runtime behavior and version-scoped guarantees for `whenToUse`, `disable-model-invocation`, and `user-invocable`; exact primary evidence and reproducible tests.
- **Not assumed:** That missing local evidence proves a mechanism does not exist, or that documentation of a field proves runtime behavior.
