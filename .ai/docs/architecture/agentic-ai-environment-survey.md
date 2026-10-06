# Agentic AI environment survey — Phase 2

## Purpose

This document records the Phase 2 evidence survey for C0069 — Architecture & Research.

The purpose is to compare real Agentic environments without changing the active `.ai` architecture, separating observed behavior, environment-specific transport syntax, reusable capability mechanisms, execution policy, state, and verification evidence.

Primary evidence is current official documentation or official source repositories where available. DSH Desktop is treated separately from DeepSeek Harness because DSH Desktop is a third-party desktop carrier rather than the upstream agent runtime.

## Survey baseline

- Repository: `paulhuman/aip-mirror`
- Branch: `main`
- Chapter: C0069
- Research plan: `.ai/docs/architecture/agentic-ai-compatibility-architecture.md`
- Phase 1 audit: `.ai/docs/architecture/agentic-ai-compatibility-capability-audit.md`
- Phase 0 and Phase 1 are complete and are not repeated here.

## Evidence matrix

| Capability seam | OpenAI Codex / Agents | Claude Code | DeepSeek Harness | Gemini CLI | AIP Mirror implication |
|---|---|---|---|---|---|
| Repository/project instructions | `AGENTS.md`; layered root-to-leaf discovery | `CLAUDE.md` and supported `AGENTS.md`; project memory | Repository `AGENTS.md`; plugin/context model | Hierarchical `GEMINI.md`; JIT context | Keep semantic ownership in `.ai`; environment filenames are adapters |
| Reusable task capability | `SKILL.md` skill packages | Skills/plugins/subagents | Skill registry + filesystem providers + loader | Agent Skills; workspace `.gemini/skills/` or `.agents/skills/` | Existing `.ai/skills/` is conceptually portable; activation transport varies |
| Direct command / invocation | Environment-owned slash surface | Slash commands and skills | Dedicated human command plane | Slash commands; `!` shell control | Never make punctuation the semantic API |
| Resource/context reference | Environment-specific; no universal project meaning established for `@` | `@file` adds file to context | No evidence that `@` is a project semantic | `@` includes files/directories in prompt context | Resource reference is a capability; syntax is transport-specific |
| Tool execution | Tools, sandbox, approval | Tools, permissions, modes, sandbox | Tool layer, sandbox, approval | Tool layer, policy engine, sandbox | Environment authorization wraps repository-safe operations |
| Approval / policy | Sandbox and approval policy | Permission modes and policy controls | One-shot approval + permission presets; fail-closed outcome | Approval modes + policy engine + sandbox expansion | Authorization is execution-layer state, not semantic ownership |
| Session/state | Sessions, compaction, recovery; Agents API separates Agent/Environment/Session/Events | Sessions, worktrees, transcripts, plans | Durable session/event model | Resumable sessions, plans, structured output | State/evidence should be represented independently from transport |
| Verification/evidence | Tool results, session events, sandbox effects | Diffs, plans, hooks, session artifacts | Session logs/events and explicit command-vs-model boundaries | Diffs, plans, JSON/stream output | TRACE should model evidence, not just chat text |
| Automation transport | Agents API / managed harness; self-hosted executor option | CLI/Desktop/shared configuration; MCP | ACP is explicitly an automation boundary | ACP mode and editor integrations | Transport boundary can be thin; do not duplicate canonical operations |

## OpenAI Codex / Agents

### Observed

Codex CLI automatically discovers `AGENTS.md` from `~/.codex` and directories from repository root to current working directory. Instructions are layered root-to-leaf, with later/deeper instructions overriding earlier ones.

Codex skills use `SKILL.md` plus optional references, scripts, templates and assets. OpenAI documents skills as reusable workflow instructions. Agents API sessions can discover skills from capability directories in their sandbox.

OpenAI's current Agents documentation separates Agent, Environment, Session, and Events/items. The managed harness provides sandbox execution, skills/instructions, external tools or MCP, steering, compaction, subtask delegation, and session resumption. Self-hosted environments place the executor inside the user's environment while the harness remains separate.

### Architectural significance

This is strong evidence for treating instruction discovery, reusable capability, execution environment, session state, and transport as distinct seams.

The especially important point is that OpenAI does not require the semantic skill itself to own the environment transport: the same skill concept is exposed through different harness mechanisms.

Sources:
- https://developers.openai.com/api/docs/guides/latest-model
- https://developers.openai.com/api/docs/guides/tools-skills
- https://developers.openai.com/api/docs/guides/agents
- https://developers.openai.com/api/docs/guides/agents-api/overview
- https://developers.openai.com/api/docs/guides/agents-api/environments/self-hosted

## Claude Code

### Observed

Claude Code documentation separates project memory (`CLAUDE.md` and supported `AGENTS.md`), Skills, subagents, hooks, MCP and plugins. CLI and Desktop share project memory and configuration.

Claude Code Desktop documents `@` as file-mention syntax that adds a file to conversation context. Slash-command and skill invocation are separate user-facing controls.

Claude Code exposes explicit permission modes and sandbox/policy controls.

### Architectural significance

`@file` is a context/reference operation, while `/skill-or-command` is an environment command surface. Neither should become a project-wide semantic primitive.

This provides direct evidence for keeping resource-reference syntax and semantic operation names separate.

Sources:
- https://code.claude.com/docs/llms.txt
- https://code.claude.com/docs/en/memory.md
- https://code.claude.com/docs/en/skills.md
- https://code.claude.com/docs/en/permissions.md
- https://code.claude.com/docs/en/commands.md
- https://code.claude.com/docs/en/desktop.md

## DeepSeek Harness / DSH

### Observed

DeepSeek Harness uses an everything-is-a-plugin architecture. Its capability seams explicitly separate skills, agents/subagents, shell, sandbox, filesystem, approval, permission presets, sessions and interaction.

The skill subsystem discovers reusable skills from project, custom and user directories. Its model-facing loader provides a session catalog and loads full instructions on demand.

The interaction subsystem separates human slash commands from one-shot approvals and user questions. DeepSeek's ACP package is an automation-only protocol: it can create/resume/close sessions, send prompts, receive semantic updates and answer permission requests, while several UI-oriented surfaces remain outside the ACP wire.

The harness also has an explicit distinction between sandbox policy and approval outcome. Approval requests carry a one-shot allow/reject outcome and fail closed when no valid answerer is available.

DSH Desktop is a third-party desktop carrier around DeepSeek Harness, not the upstream agent runtime.

### Architectural significance

DeepSeek gives the strongest current evidence for a seam-oriented architecture. In particular, `ctx.approval`, `ctx.sandbox`, `ctx.fs`, `ctx.skills`, `ctx.subagents`, and `ctx.commands` are separate capability boundaries.

This is very close to the AIP Mirror principle of one canonical semantic owner plus environment-specific execution/transport capabilities.

Sources:
- https://github.com/deepseek-ai/deepseek-harness
- https://github.com/deepseek-ai/deepseek-harness/blob/master/AGENTS.md
- https://github.com/deepseek-ai/deepseek-harness/blob/master/docs/capability-seams.md
- https://github.com/deepseek-ai/deepseek-harness/blob/master/packages/skill/README.md
- https://github.com/deepseek-ai/deepseek-harness/blob/master/packages/skill/tool-skill/README.md
- https://github.com/deepseek-ai/deepseek-harness/blob/master/packages/interaction/README.md
- https://github.com/deepseek-ai/deepseek-harness/blob/master/docs/subsystems/approval.md
- https://github.com/deepseek-ai/deepseek-harness/blob/master/packages/acp/acp/README.md
- https://github.com/bruc3van/dsh-desktop/blob/main/README_EN.md

## Gemini CLI

### Observed

Gemini CLI uses hierarchical `GEMINI.md` project context and just-in-time discovery when tools access directories.

Gemini Agent Skills are discovered from built-in, extension, user and workspace locations. Workspace skills can live in `.gemini/skills/` or the interoperable `.agents/skills/` alias.

Gemini distinguishes several syntaxes: slash commands control the CLI, `!` executes shell commands, and `@` directly includes files/directories in prompt context.

Gemini tool execution is guarded by approval policies, diffs, sandboxing and a policy engine. Current configuration supports default approval, automatic edit approval, YOLO, and plan/read-only modes; sandbox expansion can request additional directory or network permissions for a specific run.

### Architectural significance

Gemini is a strong counterexample to any assumption that punctuation has universal semantics. `/`, `@` and `!` are distinct transport/control mechanisms while the underlying capabilities remain separable.

The presence of `.agents/skills/` as an interoperable workspace location is also useful evidence that a transport-neutral skills convention can exist without becoming a new command language.

Sources:
- https://geminicli.com/docs/cli/skills/
- https://geminicli.com/docs/reference/configuration/
- https://geminicli.com/docs/cli/cli-reference/
- https://geminicli.com/docs/cli/sandbox/

## Cross-environment findings

### Finding A — instruction discovery is common, but filenames are transport/context conventions

Observed mechanisms include Codex `AGENTS.md`, Claude Code `CLAUDE.md`/`AGENTS.md`, DeepSeek Harness `AGENTS.md`, and Gemini `GEMINI.md`.

**Inference:** AIP Mirror should not make an environment-specific instruction filename the semantic owner. Environment-specific instruction files, if introduced later, should adapt an existing semantic owner.

### Finding B — reusable skills are converging on a common capability shape

All four surveyed environments expose reusable task-specific capability concepts. The details differ, but `SKILL.md`-style instruction packages are now a strong commonality.

**Inference:** the next compatibility question is not “which command syntax should AIP Mirror copy?” but “which existing AIP Mirror skill can each environment discover and invoke?”

### Finding C — `/` is transport syntax, not one semantic concept

Slash commands are used by Claude Code, DeepSeek Harness and Gemini CLI for environment control; Codex also has an environment-owned slash surface.

**Inference:** `/` must remain transport-specific.

### Finding D — `@` is environment-specific

Claude Code uses `@` for file mentions/context; Gemini uses it for direct file/directory inclusion. Current evidence does not establish a universal project-level `@` meaning.

**Inference:** `@` must remain environment-specific. Project resource/reference semantics should be expressed independently of punctuation.

### Finding E — execution safety is a cross-environment capability category

All four environments expose explicit mechanisms around approval, sandboxing, policy or controlled execution.

**Inference:** environment authorization can sit around the existing AIP Mirror repository mutation contract. The environment decides whether an execution is allowed; repository rules define the safe mutation and verification sequence.

### Finding F — verification evidence is not limited to chat text

Observed evidence surfaces include diffs, tool results, session logs, plans, transcripts, approval decisions, structured output, and explicit model-vs-command boundaries.

**Inference:** AIP Mirror TRACE should be understood as an evidence model first and a presentation format second.

### Finding G — the strongest common architecture is seam-oriented

Across the survey, the recurring boundaries are:

`transport / UI → context & invocation → semantic capability → execution/tool capability → authorization → state/evidence`

DeepSeek Harness makes these seams explicit in its architecture; OpenAI's Agents model separates Agent, Environment, Session and Events; Gemini and Claude expose comparable boundaries through configuration, skills, tools, permissions and sessions.

**Inference:** AIP Mirror should preserve the same direction of dependency: transport adapts into canonical semantic owners; canonical owners do not depend on transport syntax.

## Transport-boundary test

The proposed boundary was tested conceptually against representative operations:

| Environment input | What it really identifies | Canonical AIP Mirror target |
|---|---|---|
| `/some-command` | Environment command invocation | A semantic operation, skill, or workflow selected after transport parsing |
| `/skill-name` | Skill invocation syntax | Existing canonical skill |
| `@path/to/file` | Context/resource reference | Existing repository file/document resource |
| Tool call / shell call | Execution request | Existing repository operation subject to rules and authorization |
| Approval dialog / policy decision | Authorization state | Execution capability state, not semantic operation |
| Diff / session event / structured result | Evidence | Verification artifact / TRACE evidence |

The test does **not** require a new `.ai/interfaces/` directory.

The minimal adapter responsibility is currently:

1. recognize environment-specific invocation/context syntax;
2. resolve it to an existing AIP Mirror semantic owner;
3. expose the canonical operation through the environment's available capability mechanism;
4. preserve execution authorization and repository rules;
5. return or persist verification evidence.

## Phase 2 Gate 2 assessment

**PASS — with bounded uncertainty.**

The survey provides sufficient evidence that the existing semantic/operational core can remain distinct from environment transport syntax.

The evidence does **not** justify creating `.ai/interfaces/` yet.

The strongest current hypothesis is:

`environment transport → environment adapter / invocation → AIP Mirror semantic operation → existing canonical rule/skill/workflow → environment execution capability → verification evidence`

The adapter boundary concerns invocation, context/reference translation, capability discovery and evidence presentation. It should not contain a second implementation of the operation.

## Remaining Phase 2 work

1. Validate the matrix against the exact AIP Mirror canonical owners and identify any missing seam.
2. Inspect whether Agent Skills portability is sufficient for the existing `.ai/skills/` structure or requires only metadata/adapters.
3. Record evidence requirements for TRACE across transport, execution and verification surfaces.
4. Determine whether any environment creates a real requirement for a dedicated transport/interface artifact.
5. If no new semantic seam is discovered, close Phase 2 and use this matrix as the input to Phase 3.

## Non-conclusions

This survey does not conclude that `.ai/interfaces/` should be created, that `/` should be added to the project command surface, that `@` should receive project-wide meaning, or that any environment-specific instruction filename should replace the existing `.ai` semantic owners.

## Source list

### OpenAI
- https://developers.openai.com/api/docs/guides/latest-model
- https://developers.openai.com/api/docs/guides/tools-skills
- https://developers.openai.com/api/docs/guides/agents
- https://developers.openai.com/api/docs/guides/agents-api/overview
- https://developers.openai.com/api/docs/guides/agents-api/environments/self-hosted

### Claude Code
- https://code.claude.com/docs/llms.txt
- https://code.claude.com/docs/en/memory.md
- https://code.claude.com/docs/en/skills.md
- https://code.claude.com/docs/en/permissions.md
- https://code.claude.com/docs/en/commands.md
- https://code.claude.com/docs/en/desktop.md

### DeepSeek Harness / DSH
- https://github.com/deepseek-ai/deepseek-harness
- https://github.com/deepseek-ai/deepseek-harness/blob/master/AGENTS.md
- https://github.com/deepseek-ai/deepseek-harness/blob/master/docs/capability-seams.md
- https://github.com/deepseek-ai/deepseek-harness/blob/master/packages/skill/README.md
- https://github.com/deepseek-ai/deepseek-harness/blob/master/packages/skill/tool-skill/README.md
- https://github.com/deepseek-ai/deepseek-harness/blob/master/packages/interaction/README.md
- https://github.com/deepseek-ai/deepseek-harness/blob/master/docs/subsystems/approval.md
- https://github.com/deepseek-ai/deepseek-harness/blob/master/packages/acp/acp/README.md
- https://github.com/bruc3van/dsh-desktop/blob/main/README_EN.md

### Gemini CLI
- https://geminicli.com/docs/cli/skills/
- https://geminicli.com/docs/reference/configuration/
- https://geminicli.com/docs/cli/cli-reference/
- https://geminicli.com/docs/cli/sandbox/
