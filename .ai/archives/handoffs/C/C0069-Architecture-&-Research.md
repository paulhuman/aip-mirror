# Conversation Handoff

**Conversation:**
C0069 — Architecture & Research

**Specialization:**
C

**Chapter:**
0069

**Previous chapter:**
0068

## Starting objective

Continue the Agentic AI Compatibility Architecture research track from C0068 Phase 2 without repeating completed Phase 0 or Phase 1 work.

The immediate objective is a real, current survey of Agentic AI environments using official documentation and other verifiable sources, with clear separation between observed environment behavior and architectural inference.

## Known starting implementation state

- Repository: `paulhuman/aip-mirror`
- Canonical branch: `main`
- Current chapter: C0069
- Previous chapter: C0068
- Specialization: C
- Short name: Architecture & Research
- Derived chapter identifier: C0069
- Canonical bootstrap workflow: `.ai/workflows/handoff/BOOTSTRAP.md`
- Repository write capability is available through the connected GitHub interface.
- C0068 Phase 0 branch hygiene is complete; repository branch verification reports only `main`.
- C0068 Phase 1 capability audit is complete and recorded in `.ai/docs/architecture/agentic-ai-compatibility-capability-audit.md`.
- C0068 established the Agentic AI Compatibility Architecture research plan in `.ai/docs/architecture/agentic-ai-compatibility-architecture.md`.
- No active `.ai` redesign is authorized merely by starting this survey.

## C0068 durable checkpoint

Confirmed from the predecessor handoff:

- Phase 0 — repository branch hygiene: COMPLETE.
- Phase 1 — existing `.ai` architecture capability audit: COMPLETE.
- Gate 1 — existing architecture can support multiple transport interfaces without a second semantic source of truth: PASSED.
- Phase 2 is the next bounded task: survey actual Agentic environments and gather evidence before deciding whether a transport/interface layer is necessary.

## Phase 2 survey scope

The survey MUST investigate, for current Agentic environments:

1. repository-local instruction discovery;
2. reusable skill/capability mechanisms;
3. actual meanings of environment-specific command syntaxes such as `/` and `@`;
4. mapping environment commands to project semantic operations;
5. tool execution, repository writes, confirmation, and verification;
6. enforcement of the existing repository safety contract;
7. representation of activation evidence / TRACE outside the current chat response model;
8. whether a real transport/interface layer is actually necessary.

Initial targets:

- OpenAI Codex
- Claude Code
- DSH Desktop / DeepSeek-oriented Agentic environment
- at least one materially different Agentic environment

Evidence should prioritize official documentation, official repositories/specifications, and other directly verifiable sources. Survey findings MUST distinguish observed behavior from architectural inference.

## Relevant files and references

### Canonical research context

- `.ai/docs/architecture/agentic-ai-compatibility-architecture.md`
- `.ai/docs/architecture/agentic-ai-compatibility-capability-audit.md`
- `.ai/handoffs/C/C0068-Architecture-&-Research.md`

### Canonical infrastructure owners

- `.ai/config.yaml`
- `.ai/rules/repository.md`
- `.ai/rules/workflow.md`
- `.ai/rules/handoff/lifecycle.md`
- `.ai/rules/handoff/references.md`
- `.ai/skills/activation/SKILL.md`
- `.ai/skills/handoff/SKILL.md`
- `.ai/workflows/handoff/BOOTSTRAP.md`

## Confirmed / observed

- C0069 is the receiving chapter for C0068.
- The repository default branch is `main`.
- Branch hygiene is complete and MUST NOT be repeated as a substantive task.
- C0068 Phase 1 is complete and MUST NOT be repeated.
- The active research question is Agentic environment compatibility and transport independence.
- The current phase is evidence gathering, not active architecture redesign.

## Inferred

- The survey should be structured around comparable capabilities rather than around product marketing terminology.
- Official environment documentation is the primary basis for observed behavior; architectural conclusions should be stated separately.

## Assumed / unverified

- The final survey set may need adjustment if an environment lacks sufficient current public documentation or is not materially distinct.
- A transport/interface layer may or may not be necessary; this remains an open research conclusion.

## Open

- Complete the Phase 2 Agentic environment survey.
- Determine whether common transport semantics can be mapped onto the existing `.ai` semantic owners without duplication.
- Determine whether any environment-specific constraints justify a thin transport/interface layer.
- Produce durable research evidence and, after review, update the architecture plan/results accordingly.

## Immediate next task

Conduct the Phase 2 survey using current official/verifiable sources, beginning with OpenAI Codex and Claude Code, then covering DSH Desktop / DeepSeek-oriented tooling and at least one materially different Agentic environment.

Do not redesign active `.ai` infrastructure during this research pass.

## Recommended starting context

Start with this handoff, C0068's handoff, and the two Agentic architecture research artifacts. Treat C0068 Phase 0 and Phase 1 as completed baseline state.

## Phase 2 checkpoint — initial environment survey

A first evidence pass has been completed and recorded in:

- `.ai/docs/architecture/agentic-ai-environment-survey.md`

The initial survey covers:

- OpenAI Codex;
- Claude Code;
- DeepSeek Harness / DSH Desktop;
- Gemini CLI.

Confirmed research findings so far:

- repository-local instruction discovery is common, but instruction filenames and precedence models differ;
- reusable skills are a strong cross-environment capability pattern;
- `/` is environment transport syntax rather than a universal semantic operation primitive;
- `@` is environment-specific reference/context syntax and should not receive project-wide meaning;
- execution safety is a cross-environment capability category expressed through approvals, sandboxing, policies, and permission modes;
- verification evidence exists outside ordinary chat text, including diffs, tool results, session logs, plans, approval decisions, and structured output;
- the evidence currently supports the transport → semantic operation → canonical owner boundary;
- Gate 2 is provisionally PASS with bounded uncertainty;
- no evidence yet justifies creating `.ai/interfaces/`.

This is an initial survey checkpoint, not the final Phase 2 decision. Remaining work is listed in the survey artifact and includes deeper source verification, the final cross-environment matrix, and an explicit semantic-ownership boundary test.

## Phase 2 checkpoint — owner-by-seam audit

The initial environment survey was validated against the active `.ai` canonical owners and recorded in:

- `.ai/docs/architecture/agentic-ai-owner-seam-audit.md`

The audit confirms semantic coverage for every surveyed capability seam:

- routing → `.ai/INDEX.md`;
- rules → `.ai/rules/`;
- reusable capabilities → `.ai/skills/`;
- ordered procedures → `.ai/workflows/`;
- repository mutation safety → `.ai/rules/repository.md`;
- lifecycle/session continuity → `.ai/rules/handoff/lifecycle.md` + `.ai/handoffs/`;
- verification/evidence → operation owners + activation/TRACE + `.ai/tests/results/`;
- durable architecture evidence → `.ai/docs/architecture/`.

No second semantic owner was identified. In particular, the audit does NOT justify creating `.ai/interfaces/`.

Two bounded compatibility concerns remain:

1. environment invocation/context mapping;
2. TRACE/evidence presentation outside the current `>>` transport.

Skill discovery/packaging portability is a third compatibility question, but the existing `.ai/skills/` structure is already semantically sufficient; any required adaptation would be packaging/discovery metadata rather than duplicated skill semantics.

Current Phase 2 conclusion candidate: **PASS — semantic coverage confirmed; adapter boundaries remain to be validated.**

Immediate next research step SHOULD be a concrete portability test against one existing AIP Mirror skill and a minimal evidence/TRACE model for a non-`>>` transport. Do not redesign active `.ai` infrastructure until such evidence requires it.

## Phase 2 checkpoint — compatibility boundaries and final Gate 2

The concrete compatibility tests are complete.

Durable evidence is recorded in:

- `.ai/docs/architecture/agentic-ai-compatibility-boundaries.md`

### Skill portability test

The existing `.ai/skills/activation/SKILL.md` was tested against the current Agent Skills package shape.

Result:

- **PASS** — YAML `name` / `description` front matter plus Markdown instruction body is compatible with the common Agent Skills shape;
- semantic ownership remains in `.ai/skills/` and its referenced canonical owners;
- environment-specific discovery roots, repository context, and invocation remain adapter responsibilities;
- no second skill registry, duplicate skill copies, or `.ai/interfaces/` layer is justified.

The skill is intentionally repository-local rather than standalone. Portability means that an environment can discover and load the package without moving its semantic ownership out of AIP Mirror.

### Transport-neutral evidence model

The TRACE question was resolved by separating evidence from presentation.

The reusable evidence record consists of:

- operation identity/status;
- activation owners/status;
- repository reads;
- relevant execution/tool actions;
- verification result and scope/diff evidence;
- authorization state when applicable;
- durable artifact references when applicable.

Current chat TRACE is one presentation of this evidence. Future environments MAY present equivalent evidence through CLI output, event streams, structured results, session records, or test artifacts.

Repository mutation evidence remains governed by the existing repository safety contract and is not replaced by environment-native approval or sandbox records.

### Final Gate 2 decision

**PASS — semantic coverage confirmed and adapter boundaries validated.**

Final dependency direction:

`environment transport → invocation/context adapter → existing AIP Mirror semantic owner → environment execution capability → transport-neutral evidence → environment-native presentation`

No new semantic seam was discovered. `.ai/interfaces/` remains unjustified.

### Phase 3 starting point

Phase 3 SHOULD specify the minimal adapter/conformance contract only:

1. invocation/context mapping;
2. skill discovery/packaging mapping;
3. transport-neutral evidence fields;
4. repository mutation verification mapping;
5. one conformance test proving that a future environment preserves existing semantic owners and the repository safety contract.

No universal transport layer implementation is required by current evidence.


## Phase 2 — complete research preservation

Phase 2 is COMPLETE.

**Final Gate 2: PASS — semantic coverage confirmed and adapter boundaries validated.**

The complete durable research set is:

- .ai/docs/architecture/agentic-ai-compatibility-architecture.md — research plan and architectural hypothesis; points back to this handoff.
- .ai/docs/architecture/agentic-ai-compatibility-capability-audit.md — Phase 1 capability baseline; points back to this handoff.
- .ai/docs/architecture/agentic-ai-environment-survey.md — official-source survey of OpenAI Codex, Claude Code, DeepSeek Harness / DSH Desktop, and Gemini CLI; includes the external source list and final Phase 2 completion checkpoint; points back to this handoff.
- .ai/docs/architecture/agentic-ai-owner-seam-audit.md — mapping of surveyed capability seams to existing canonical AIP Mirror owners; points back to this handoff.
- .ai/docs/architecture/agentic-ai-compatibility-boundaries.md — concrete skill portability test, transport-neutral evidence model, final adapter boundary, and Phase 3 input; points back to this handoff.

### External research references

These references materially support the Phase 2 findings and are preserved here so a future chapter does not depend on the old conversation.

#### OpenAI Codex / Agents

- OpenAI developer documentation
  - Role: current evidence for Codex instruction discovery, Agent Skills, Agents, sessions/environments, and self-hosted execution.
  - URLs: https://developers.openai.com/api/docs/guides/latest-model ; https://developers.openai.com/api/docs/guides/tools-skills ; https://developers.openai.com/api/docs/guides/agents ; https://developers.openai.com/api/docs/guides/agents-api/overview ; https://developers.openai.com/api/docs/guides/agents-api/environments/self-hosted

#### Claude Code

- Claude Code documentation
  - Role: current evidence for project memory, Skills, @ context references, commands, permissions, and sandbox/policy controls.
  - URLs: https://code.claude.com/docs/llms.txt ; https://code.claude.com/docs/en/memory.md ; https://code.claude.com/docs/en/skills.md ; https://code.claude.com/docs/en/permissions.md ; https://code.claude.com/docs/en/commands.md ; https://code.claude.com/docs/en/desktop.md

#### DeepSeek Harness / DSH

- deepseek-ai/deepseek-harness
  - Role: primary source for DeepSeek Harness capability seams, skills, interaction, approval, sandbox, sessions, and ACP automation boundaries.
  - URLs: https://github.com/deepseek-ai/deepseek-harness ; https://github.com/deepseek-ai/deepseek-harness/blob/master/AGENTS.md ; https://github.com/deepseek-ai/deepseek-harness/blob/master/docs/capability-seams.md ; https://github.com/deepseek-ai/deepseek-harness/blob/master/packages/skill/README.md ; https://github.com/deepseek-ai/deepseek-harness/blob/master/packages/skill/tool-skill/README.md ; https://github.com/deepseek-ai/deepseek-harness/blob/master/packages/interaction/README.md ; https://github.com/deepseek-ai/deepseek-harness/blob/master/docs/subsystems/approval.md ; https://github.com/deepseek-ai/deepseek-harness/blob/master/packages/acp/acp/README.md
- bruc3van/dsh-desktop
  - Role: third-party DSH Desktop carrier used only to distinguish the desktop carrier from upstream DeepSeek Harness.
  - URL: https://github.com/bruc3van/dsh-desktop/blob/main/README_EN.md

#### Gemini CLI

- Gemini CLI documentation
  - Role: materially different Agentic environment evidence for hierarchical context, Agent Skills, slash/at/shell transport syntax, approvals, sandboxing, policy, diffs, and structured output.
  - URLs: https://geminicli.com/docs/cli/skills/ ; https://geminicli.com/docs/reference/configuration/ ; https://geminicli.com/docs/cli/cli-reference/ ; https://geminicli.com/docs/cli/sandbox/

### Phase 2 architectural result

Validated dependency direction:

environment transport → invocation/context adapter → existing AIP Mirror semantic owner → environment execution capability → transport-neutral evidence → environment-native presentation

No second semantic owner was found. In particular:

- no .ai/interfaces/ directory is justified;
- no second skill registry is justified;
- no environment-specific copies of canonical skills/rules/workflows are justified;
- / and @ remain environment-specific transport/context syntax;
- environment authorization remains outside AIP Mirror semantic ownership;
- repository mutation safety remains governed by the existing repository contract.

### Phase 3 starting point

Phase 3 begins from the completed evidence above and SHOULD specify:

1. invocation/context adapter responsibilities;
2. skill discovery/packaging mapping;
3. transport-neutral evidence fields;
4. repository mutation verification mapping;
5. one minimal environment conformance test.

The architecture notes above explicitly point back to this handoff so future chapters can recover this research chain even if they do not independently read C0069.

## C0069 migration checkpoint — AI-infrastructure context mode

The chapter also established a second work track concerning the AI-infrastructure itself.

Durable proposal:

- `.ai/` is a portable, project-agnostic AI-infrastructure layer intended for applications, plugins, websites, libraries, services, tooling, and other software projects.
- `.ai/docs/` documents the AI-infrastructure; `docs/` documents the project itself.
- A root `.ai/README.md` is needed as the human- and AI-readable orientation document for the whole `.ai/` layer.
- `.ai/archive/` SHOULD be renamed to `.ai/archives/`; `archives` is the clearer plural taxonomy.
- `.ai/archives/` is historical/disposable storage, not active context and not an eternal museum of old files.
- `.ai/archives/README.md` SHOULD explain that lifecycle and SHOULD be read by the elevated infrastructure operation without loading archive contents.
- The proposed domain-switch operation is `>>ai-infrastructure`.
- `>>ai-infrastructure` is not merely a larger context load: it switches the AI's working domain from project-specific implementation to AI-infrastructure work.
- Its elevated context SHOULD include the root `README.md`, `docs/PROJECT-INSTRUCTIONS.md`, `.ai/README.md`, active `.ai/**/README.md`, `.ai/AGENTS.md`, `.ai/INDEX.md`, `.ai/config.yaml`, an orientation survey of `.ai/docs/`, and `.ai/archives/README.md`.
- `.ai/archives/**` contents SHOULD NOT be loaded by this operation unless explicitly required.
- The operation SHOULD remain a thin context-loading capability and MUST NOT introduce a second routing registry, semantic owner, skill registry, duplicated project instructions, or speculative `.ai/interfaces/` namespace.
- The full proposal is preserved in `.ai/docs/architecture/ai-infrastructure-context-mode.md`.

The two current work tracks are independent:

1. **Phase 3 — Agentic AI adaptation:** minimal adapter/conformance specification from the completed C0069 Phase 2 result.
2. **AI-infrastructure orientation:** define and test `>>ai-infrastructure`, add `.ai/README.md`, rename the archive taxonomy, add `.ai/archives/README.md`, and update affected active references.

No future chapter handoff is created by this checkpoint. C0069 remains the current chapter until a future conversation executes bootstrap.
