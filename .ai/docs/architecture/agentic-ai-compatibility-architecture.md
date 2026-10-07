# Agentic AI compatibility architecture research

## Research objective

Determine whether the existing `.ai` architecture can support multiple AI-environment transport interfaces without duplicating semantic ownership, and identify the minimal architecture required for Agentic AI compatibility.

The research MUST begin without changing the active `.ai` architecture.

The investigation SHOULD distinguish:

- semantic operations — what an operation means;
- operational ownership — which rules, skills, and workflows define the operation;
- transport interfaces — how an AI environment invokes or receives the operation;
- execution capabilities — how an environment reads files, invokes tools, mutates repositories, and verifies results.

The central hypothesis is:

```text
                         .ai/
                          |
                 semantic / operational core
                          |
              +-----------+-----------+
              |                       |
        Chat transport          Agent transport
              |                       |
            >>cmd                   /cmd
              |                       |
              +-----------+-----------+
                          |
                  same semantic owner
```

This diagram is a research hypothesis, not an architectural decision.

## Research principles

The research MUST:

1. use the current repository state as the source of truth for the existing `.ai` architecture;
2. use current primary documentation and direct environment evidence when evaluating external AI environments;
3. distinguish observed behavior from interpretation and proposed design;
4. avoid changing active `.ai` rules, skills, workflows, or routing merely to support the investigation;
5. avoid duplicating semantic procedures for individual transports;
6. record enough evidence that a later design chapter can make or reject the compatibility proposal without reconstructing the investigation from chat history.

The research SHOULD prefer the smallest common denominator that can support multiple environments.

The research MUST NOT assume that `/` and `@` have the same semantics across Agentic AI environments. Their meaning MUST be established separately for each environment.

## Phase 0 — Research baseline and repository hygiene

### Purpose

Establish a clean baseline before external-environment research begins.

### Tasks

- Confirm the current C0068 handoff and C0067 checkpoint.
- Confirm that the active architecture restructuring work from C0067 is complete.
- Confirm that this research document is the only new architecture artifact required to start the investigation.
- Inspect current branches and identify any non-`main` branches that are disposable, experimental, or otherwise safe to remove.
- Before deleting branches, verify that no required work exists only on those branches.
- Keep `main` as the canonical branch.

### Exit criteria

- The research baseline is recorded.
- Branch cleanup is either completed safely or recorded as a separate bounded task with the reason it was deferred.
- No active `.ai` architecture has been changed for research purposes.

## Phase 1 — Existing `.ai` architecture capability audit

### Purpose

Determine what the current architecture already provides before designing an Agentic AI route.

### Questions

- Where is semantic operation meaning defined?
- Where are rules, skills, and workflows discovered?
- Which files are canonical owners?
- How does `.ai/INDEX.md` route requests?
- Which parts of the current command surface are transport-specific?
- Which parts are transport-independent?
- Can the same operation already be expressed without relying on `>>` syntax?
- Which repository safety and verification procedures are reusable by a tool-executing agent?

### Required areas of inspection

- `.ai/INDEX.md`
- `.ai/AGENTS.md`
- `.ai/rules/`
- `.ai/skills/`
- `.ai/workflows/`
- `.ai/config.yaml`
- relevant architecture notes and runtime test results

### Output

Create an evidence table describing:

| Area | Current owner | Transport dependency | Reuse potential | Evidence |
|---|---|---|---|---|
| operation routing | current canonical owner | TBD | TBD | repository evidence |
| rules | current canonical owner | TBD | TBD | repository evidence |
| skills | current canonical owner | TBD | TBD | repository evidence |
| workflows | current canonical owner | TBD | TBD | repository evidence |
| repository mutation safety | current canonical owner | TBD | TBD | repository evidence |
| verification / TRACE | current canonical owner | TBD | TBD | repository evidence |

The table is research evidence, not a new semantic owner.

### Gate 1

Proceed only if the current architecture can be described without introducing a second semantic source of truth.

## Phase 2 — Agentic environment survey

### Purpose

Determine how real Agentic AI environments represent instructions, skills, commands, resources, tools, and repository context.

### Candidate environments

At minimum investigate:

- OpenAI Codex;
- Anthropic Claude Code;
- DSH Desktop / the user's current DeepSeek-oriented Agentic environment;
- at least one additional environment if it provides materially different architecture or interface semantics.

The exact product names, versions, capabilities, and command syntax MUST be verified from current evidence rather than inferred from memory.

### Questions for each environment

#### Instruction discovery

- Which repository-local instruction files are recognized?
- How are global and project-local instructions layered?
- Is instruction precedence documented?
- Can instructions refer to other files?
- Are instructions automatically discovered or explicitly selected?

#### Skills and reusable capabilities

- Does the environment support a skill concept?
- How are skills discovered?
- Are skills declarative, executable, or both?
- Can a skill invoke other instructions or tools?
- Can repository-local skills be shared across environments?

#### Command / transport surface

- Does the environment support `/` commands?
- What does `@` mean?
- Are these syntax forms built into the environment or configurable?
- Are commands aliases, prompts, tools, resources, agents, or another abstraction?
- Can a semantic operation be invoked without environment-specific command syntax?

#### Tools and execution

- How does the environment read repository files?
- How does it execute shell commands?
- How does it invoke external tools or APIs?
- Does it support structured tool calls?
- How does it observe tool results?
- Can it perform multi-step autonomous loops?

#### State and continuity

- How is session state represented?
- What persists between turns?
- What persists between sessions?
- How are plans, task state, or intermediate results retained?

#### Verification and safety

- How does the environment verify mutations?
- Does it expose diffs?
- Does it require confirmation for writes?
- Can it commit changes?
- Can it enforce repository-local safety instructions?

### Output

Produce one evidence record per environment containing:

- source / evidence;
- observed instruction mechanism;
- observed skill mechanism;
- observed command syntax;
- observed resource/reference syntax;
- tool execution model;
- state model;
- verification model;
- limitations;
- confidence level.

### Gate 2

DO NOT generalize an environment-specific feature into the common architecture unless evidence shows that the feature is shared or can be isolated behind a transport adapter.

## Phase 3 — Cross-environment capability matrix

### Purpose

Separate common capabilities from environment-specific transport syntax.

### Matrix

Build a comparison such as:

| Capability | Chat AI | Agentic environment A | Agentic environment B | Agentic environment C | Common abstraction? |
|---|---|---|---|---|---|
| repository instructions | | | | | |
| rules | | | | | |
| skills | | | | | |
| workflows | | | | | |
| command invocation | | | | | |
| resource references | | | | | |
| tool execution | | | | | |
| repository mutation | | | | | |
| verification | | | | | |
| persistent state | | | | | |

The matrix MUST distinguish:

- capability;
- syntax;
- ownership;
- execution mechanism.

A syntax difference alone MUST NOT be treated as an architectural incompatibility.

### Gate 3

Identify the minimum set of transport-neutral concepts shared by the investigated environments.

## Phase 4 — Semantic ownership and transport-boundary analysis

### Purpose

Test the core architectural hypothesis against the evidence.

The research MUST answer:

> Can `>>handoff`, `/handoff`, or another environment-specific invocation all resolve to one semantic `handoff` operation without creating separate handoff procedures?

Evaluate the following conceptual layers:

```text
Transport
    ↓
Invocation / parsing
    ↓
Semantic operation
    ↓
Canonical rules / skills / workflows
    ↓
Repository / external tools
    ↓
Verification
```

### Questions

- What belongs in a transport adapter?
- What MUST remain transport-neutral?
- Where should command parsing occur?
- Can `>>` remain a chat-only transport convention?
- Can `/` remain an Agentic transport convention?
- Should `@` remain environment-specific rather than become a project-wide semantic primitive?
- Can both routes produce the same operation context and verification obligations?
- Which parts of TRACE are transport-independent, and which parts are presentation-specific?

### Output

Produce a proposed boundary between:

1. transport interface;
2. semantic operation;
3. operational procedure;
4. execution capability;
5. verification evidence.

### Gate 4

Reject any design that requires duplicated semantic ownership merely because two AI environments use different invocation syntax.

## Phase 5 — Minimal compatibility architecture

### Purpose

Define the smallest architecture that enables Agentic AI compatibility while preserving the current ownership model.

The proposal SHOULD start with the minimum possible change:

```text
existing .ai semantic / operational core
              +
        transport boundary
              +
     Agentic environment adapter(s)
```

Potential architecture elements to evaluate:

- transport-specific entry adapters;
- a semantic operation vocabulary;
- environment capability descriptors;
- environment-specific command mappings;
- explicit resource/reference conventions;
- machine-readable execution contracts;
- shared verification contracts.

DO NOT add an element merely because an Agentic environment happens to expose a feature with a similar name.

### Required decision questions

- What is the minimum new file or directory structure?
- Can existing rules, skills, and workflows remain unchanged?
- Which existing files, if any, need only routing additions?
- Is a formal `.ai/interfaces/` layer actually necessary?
- Could an interface layer remain outside `.ai`?
- What should remain entirely environment-specific?
- What should be represented as a capability rather than a command?
- What is the minimum migration path from the current chat route?

### Output

A design proposal containing:

- proposed architecture;
- ownership map;
- transport map;
- required new artifacts;
- unchanged artifacts;
- migration sequence;
- rollback strategy;
- unresolved questions.

This proposal is still research output until explicitly approved for implementation.

## Phase 6 — Compatibility proof-of-concept design

### Purpose

Define a small, reversible experiment that can test the architecture without restructuring the repository.

The proof of concept SHOULD use one low-risk semantic operation, such as a read-only operation or an operation with an existing disposable test harness.

The proof of concept MUST NOT require broad restructuring of the active `.ai` infrastructure.

### Candidate proof

For example:

```text
Chat:
    >><operation>

Agent:
    /<operation>

Both:
    ↓
same semantic operation
    ↓
same canonical owner
    ↓
same verification contract
```

The exact operation MUST be selected only after the environment survey identifies a suitable common capability.

### Output

A reproducible experiment specification containing:

- environment;
- starting repository revision;
- transport invocation;
- expected semantic operation;
- expected canonical owner reads;
- expected repository effects;
- verification procedure;
- pass/fail criteria.

## Phase 7 — Decision record

### Purpose

Turn the research into a durable architectural conclusion.

One of three outcomes SHOULD be selected:

### Outcome A — Compatible without structural change

The current architecture already separates semantics sufficiently. Only environment-specific invocation guidance is needed.

### Outcome B — Compatible with a minimal transport layer

The current semantic core is reusable, but a small transport/interface layer is required.

### Outcome C — Incompatible without deeper restructuring

The current architecture contains assumptions that prevent clean Agentic integration. A larger redesign is justified.

The decision MUST cite the evidence that supports it.

## Phase 8 — Redesign branch preparation

### Purpose

Keep any global architecture change isolated from `main`.

If Phase 7 produces a design requiring repository restructuring:

1. verify the clean `main` baseline;
2. create a dedicated redesign branch from the exact approved `main` commit;
3. record the branch name and starting commit;
4. implement only the approved architectural scope on that branch;
5. verify every changed file and the complete diff;
6. DO NOT merge into `main` until the redesign has been reviewed.

The redesign branch is an implementation environment, not part of the research baseline.

## Phase 9 — Post-research cleanup

After the research and any redesign experiment:

- retain durable research evidence;
- keep reusable test scenarios separate from historical results;
- archive completed architecture investigations according to the existing archive rules when appropriate;
- update the C0068 handoff with the final decision and evidence locations;
- leave `main` in a known, verified state.

## Deliverables

The research SHOULD produce the following durable artifacts, as justified by evidence:

1. this phased research plan;
2. an existing-`.ai` capability audit;
3. environment evidence records;
4. a cross-environment capability matrix;
5. a semantic-ownership / transport-boundary analysis;
6. a minimal compatibility architecture proposal;
7. a proof-of-concept specification or result;
8. a final decision record;
9. a C0068 handoff checkpoint referencing the durable results.

Not every item requires a separate file. Small related artifacts MAY be combined when doing so does not obscure ownership or evidence.

## Non-goals

This research does NOT initially:

- redesign the active `.ai` architecture;
- introduce `.ai/interfaces/`;
- redefine `>>`;
- define project-wide semantics for `/` or `@`;
- copy external Agentic AI implementations into the repository;
- replace existing canonical rules, skills, or workflows;
- assume that all Agentic environments share one command model.

Those changes MAY become implementation work only after the research produces evidence and a bounded architectural decision.

## Success criteria

The research is complete when:

- the current `.ai` architecture's transport independence has been evaluated;
- the relevant Agentic environments have been compared using current evidence;
- environment-specific syntax has been separated from semantic capability;
- the semantic ownership boundary has been explicitly tested;
- the minimum compatibility architecture has been identified;
- a reproducible proof or counterexample has been defined or executed;
- the final architectural outcome is recorded;
- any implementation work is isolated to a dedicated redesign branch rather than silently modifying `main`.

## Relationship to active ownership

This document is an architecture/research plan.

It is NOT a replacement for:

- `.ai/rules/` — canonical semantic constraints;
- `.ai/skills/` — reusable capabilities;
- `.ai/workflows/` — ordered procedures;
- `.ai/INDEX.md` — routing and capability discovery.

If research produces an operational rule, skill, workflow, or routing requirement, that definition MUST be placed in its appropriate canonical owner during a later implementation phase.

The research document SHOULD preserve the reasoning, evidence, and decision history rather than becoming a second operational owner.


## Chapter continuity

The current durable chapter checkpoint is maintained in:

- `.ai/handoffs/C/C0069-Architecture-&-Research.md`

Future chapters continuing this research SHOULD read that handoff as the current chapter continuity snapshot before relying on this architecture note alone.
