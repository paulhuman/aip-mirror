# Agentic AI environment survey — Phase 2

## Purpose

This document records the initial Phase 2 evidence survey for C0069 — Architecture & Research.

The purpose is to compare real Agentic environments without changing the active `.ai` architecture, separating observed behavior, environment-specific transport syntax, reusable capability mechanisms, and architectural inference.

Primary evidence is current official documentation or official source repositories where available. DSH Desktop is treated separately from DeepSeek Harness because DSH Desktop is a third-party desktop carrier rather than the upstream agent runtime.

## Survey baseline

- Repository: `paulhuman/aip-mirror`
- Branch: `main`
- Chapter: C0069
- Research plan: `.ai/docs/architecture/agentic-ai-compatibility-architecture.md`
- Phase 1 audit: `.ai/docs/architecture/agentic-ai-compatibility-capability-audit.md`
- Phase 0 and Phase 1 are complete and are not repeated here.

## Initial evidence matrix

| Environment | Local instruction discovery | Skills / reusable capability | Command surface | Resource/reference syntax | Execution / safety | State / verification |
|---|---|---|---|---|---|---|
| OpenAI Codex | `AGENTS.md` discovered from `~/.codex` and repo root through current directory; layered root-to-leaf | `SKILL.md` skills; repo/user scope; plugins can package skills | Slash-command surface is environment-owned | `@` appears in some Codex workflows; no universal project meaning established | Explicit sandbox and approval policies | Sessions, compaction, controlled tool execution |
| Claude Code | `CLAUDE.md` and supported `AGENTS.md`; nested project guidance | Skills, plugins, subagents, hooks, MCP | Slash commands and skills | `@` file mentions add files to context | Fine-grained permissions, modes, sandbox and managed policies | Sessions, worktrees, transcripts, plans, hooks |
| DeepSeek Harness / DSH | Upstream Harness uses repository `AGENTS.md`; plugin-based context | Skill registry/providers, local filesystem discovery, model-facing loader | Slash commands are a dedicated human-command plane | `@` not promoted to project semantics by current evidence | Sandbox, approval and permission capability families; ACP differs from UI commands | Durable session logs; direct commands can stay outside model history |
| Gemini CLI | Hierarchical/JIT `GEMINI.md` project context | Agent Skills; `.gemini/skills/` and `.agents/skills/` | Slash commands plus `!` shell mode | `@` directly includes files/directories in prompt context | Approval modes, sandbox and policy engine | Sessions, plans, diffs, JSON/stream output |

## OpenAI Codex

### Observed

Codex CLI automatically discovers `AGENTS.md` from `~/.codex` and directories from repository root to current working directory. Instructions are layered root-to-leaf, with later/deeper instructions overriding earlier ones. Source: https://developers.openai.com/api/docs/guides/latest-model

Codex skills use `SKILL.md` plus optional references, scripts, templates and assets. OpenAI documents skills as reusable workflow instructions, including repository-scoped and user-scoped forms. Sources: https://developers.openai.com/plugins/concepts/skills and https://developers.openai.com/blog/eval-skills

Codex execution has explicit sandbox and approval boundaries. Current OpenAI examples use `workspace-write` with an explicit approval policy for controlled automation. Source: https://developers.openai.com/cookbook/examples/codex/build_iterative_repair_loops_with_codex

### Architectural significance

Codex demonstrates a separation between repository instructions, reusable skills, semantic agent instructions, tool execution, and sandbox/approval policy. This maps naturally onto the existing `.ai` separation between semantic owners and execution capabilities.

Codex-specific filenames and command syntax should therefore be treated as transport/context mechanisms, not as new AIP Mirror semantic owners.

## Claude Code

### Observed

Claude Code documentation explicitly separates project memory (`CLAUDE.md` and supported `AGENTS.md`), Skills, subagents, hooks, MCP and plugins. CLI and Desktop share project memory and configuration. Source: https://code.claude.com/docs/llms.txt

Claude Code Desktop documents `@` as file mention syntax that adds a file to conversation context. It also exposes slash-command/skill invocation and permission modes. Source: https://code.claude.com/docs/en/desktop.md

Claude Code has explicit permission modes, sandboxing and managed policy controls. Source: https://code.claude.com/docs/en/permissions.md

### Architectural significance

`@file` is a context/reference operation, while `/skill-or-command` is an environment command surface. Neither should become a project-wide semantic primitive.

Claude Code therefore provides direct evidence for keeping resource-reference syntax and semantic operation names separate.

## DeepSeek Harness and DSH Desktop

### Observed

DeepSeek Harness is an open-source Agent harness with an everything-is-a-plugin architecture. Its package map separates agent/session core, filesystem, skills, context, subagents, sandboxing and human interaction. Sources: https://github.com/deepseek-ai/deepseek-harness and https://github.com/deepseek-ai/deepseek-harness/blob/master/packages/README.md

The upstream repository contains `AGENTS.md`, demonstrating repository-local agent instructions. Source: https://github.com/deepseek-ai/deepseek-harness/blob/master/AGENTS.md

The skill subsystem discovers skills from project, custom and user directories; the model-facing loader publishes a session catalog and loads full instructions on demand. Sources: https://github.com/deepseek-ai/deepseek-harness/blob/master/packages/skill/skill-filesystem/README.md and https://github.com/deepseek-ai/deepseek-harness/blob/master/packages/skill/tool-skill/README.md

The human command subsystem is a separate slash-command plane. Recognized commands execute directly against an agent without creating a model message; UI-less ACP automation does not provide this human command surface. Source: https://github.com/deepseek-ai/deepseek-harness/blob/master/packages/interaction/commands/README.md

DSH Desktop is a third-party desktop carrier around DeepSeek Harness, not the upstream agent runtime. Source: https://github.com/bruc3van/dsh-desktop/blob/main/README_EN.md

### Architectural significance

DeepSeek provides strong evidence for a layered model in which Desktop/Web/CLI/ACP are transport surfaces above shared agent capabilities. Its direct distinction between human commands and ACP automation is particularly relevant to the AIP Mirror distinction between transport invocation and semantic operation.

## Gemini CLI

### Observed

Gemini CLI uses hierarchical `GEMINI.md` project context and just-in-time discovery when tools access directories. Source: https://github.com/google-gemini/gemini-cli/blob/main/docs/cli/gemini-md.md

Gemini Agent Skills are discovered from built-in, extension, user and workspace locations. Workspace skills can live in `.gemini/skills/` or the interoperable `.agents/skills/` alias. Source: https://github.com/google-gemini/gemini-cli/blob/main/docs/cli/skills.md

Gemini distinguishes several syntaxes: slash commands control the CLI, `!` executes shell commands, and `@` directly includes files/directories in prompt context. Sources: https://github.com/google-gemini/gemini-cli/blob/main/docs/reference/commands.md and https://github.com/google-gemini/gemini-cli/blob/main/docs/cli/tutorials/file-management.md

Gemini tool execution is guarded by approval policies, diffs, sandboxing and a policy engine; plan mode is read-only. Sources: https://github.com/google-gemini/gemini-cli/blob/main/docs/reference/tools.md and https://github.com/google-gemini/gemini-cli/blob/main/docs/reference/policy-engine.md

### Architectural significance

Gemini is a strong counterexample to any assumption that punctuation has universal semantics. `/`, `@` and `!` are distinct transport/control mechanisms, while the underlying capabilities remain separable.

## Cross-environment findings

### Finding A — repository-local instruction discovery is common, but filenames differ

Observed mechanisms include Codex `AGENTS.md`, Claude Code `CLAUDE.md`/`AGENTS.md`, DeepSeek Harness `AGENTS.md`, and Gemini `GEMINI.md`.

Inference: AIP Mirror should not make an environment-specific instruction filename the semantic owner. Environment-specific instruction files, if introduced later, should be transport/context adapters.

### Finding B — reusable skills are converging on a common capability shape

Codex, Claude Code, DeepSeek Harness and Gemini CLI all expose reusable task-specific capability concepts. Their discovery and activation details differ, but `SKILL.md`-style instruction packages are a strong cross-environment commonality.

Inference: investigate a transport-neutral skill representation before inventing a new command abstraction.

### Finding C — `/` is transport syntax, not one semantic concept

Claude Code uses slash commands/skills, DeepSeek Harness uses a direct human-command plane, Gemini uses slash commands for CLI control, and Codex has its own slash-command surface.

Inference: `/` must remain transport-specific.

### Finding D — `@` is environment-specific

Claude Code uses `@` for file mentions/context; Gemini uses it for direct file/directory inclusion. Current Codex evidence does not establish a universal project-level `@` meaning.

Inference: `@` must remain environment-specific. Project resource/reference semantics should be expressed independently of punctuation.

### Finding E — execution safety is a cross-environment capability category

Codex, Claude Code, DeepSeek Harness and Gemini all expose explicit mechanisms around approval, sandboxing, policy or controlled execution.

Inference: the existing AIP Mirror repository mutation contract can sit above environment-specific authorization. The environment decides whether a tool call may execute; repository rules define the safe mutation/verification sequence.

### Finding F — verification evidence is not limited to chat text

Observed evidence surfaces include diffs, tool results, session logs, plans, transcripts, approval decisions, JSON/stream output, and in DeepSeek Harness a distinction between model-visible messages and direct command results.

Inference: AIP Mirror TRACE should be understood as an evidence model first and a presentation format second. The current activation TRACE response contract is therefore one rendering of a broader evidence concept.

## Initial Gate 2 assessment

**PASS — with bounded uncertainty.**

The survey provides sufficient evidence that the existing semantic/operational core can remain distinct from environment transport syntax.

The evidence does not yet justify creating `.ai/interfaces/`.

The strongest current hypothesis is:

environment transport → environment adapter / invocation → AIP Mirror semantic operation → existing canonical rule/skill/workflow → environment execution capability → verification evidence

The adapter boundary appears to concern invocation, context/reference translation, capability discovery and evidence presentation, rather than a second implementation of the operation.

## Remaining Phase 2 work

1. Verify precise Codex slash-command and `@` semantics from current command/reference documentation.
2. Inspect Claude Code skills, memory, permissions and command references in more detail.
3. Inspect DeepSeek Harness context and sandbox contracts, especially ACP/automation boundaries.
4. Inspect Gemini project-context hierarchy and skill precedence in more detail.
5. Build the final cross-environment capability matrix required by Phase 3.
6. Explicitly test the proposed transport → semantic operation → canonical owner boundary.
7. Determine whether any environment creates a real requirement for a dedicated transport/interface artifact.

## Non-conclusions

This survey does not conclude that `.ai/interfaces/` should be created, that `/` should be added to the project command surface, that `@` should receive project-wide meaning, or that any environment-specific instruction filename should replace the existing `.ai` semantic owners.

## Source list

### OpenAI Codex
- https://developers.openai.com/api/docs/guides/latest-model
- https://developers.openai.com/plugins/concepts/skills
- https://developers.openai.com/blog/eval-skills
- https://developers.openai.com/cookbook/examples/codex/build_iterative_repair_loops_with_codex
- https://github.com/openai/codex

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
- https://github.com/deepseek-ai/deepseek-harness/blob/master/packages/skill/skill-filesystem/README.md
- https://github.com/deepseek-ai/deepseek-harness/blob/master/packages/skill/tool-skill/README.md
- https://github.com/deepseek-ai/deepseek-harness/blob/master/packages/interaction/commands/README.md
- https://github.com/bruc3van/dsh-desktop/blob/main/README_EN.md

### Gemini CLI
- https://github.com/google-gemini/gemini-cli
- https://github.com/google-gemini/gemini-cli/blob/main/docs/cli/gemini-md.md
- https://github.com/google-gemini/gemini-cli/blob/main/docs/cli/skills.md
- https://github.com/google-gemini/gemini-cli/blob/main/docs/reference/commands.md
- https://github.com/google-gemini/gemini-cli/blob/main/docs/reference/tools.md
- https://github.com/google-gemini/gemini-cli/blob/main/docs/reference/policy-engine.md