# Semantic Source & Authority Audit — 03AP

Chapter:
03AP — Architecture & Research

Status:
BOUNDED ARCHITECTURAL AUDIT — CLOSED

## Purpose

This audit examines a more fundamental question exposed by C-14:

> What is allowed to establish what a semantic concept means within the project?

The audit does not define a universal source hierarchy and does not introduce a new ontology of authority.

Its purpose is narrower:

1. identify source categories already distinguished by the project;
2. determine what each category can legitimately establish;
3. distinguish evidence about an external subject from normative project semantics;
4. determine whether the repository already defines a transition from research/evidence to project specification;
5. identify whether C-14 was correct to treat missing current OVERRIDE semantics as an evidence boundary, while accounting for historical OVERRIDE research.

## Scope

Included:

- repository rules;
- project architecture rules;
- workflow rules;
- the canonical agnostic AI-project-instruction architecture;
- historical OVERRIDE research recorded in legacy 03D/03E handoffs;
- the current C-14 evidence boundary.

Excluded:

- designing a universal epistemology;
- assigning a total precedence ranking to all source types;
- redefining authority semantics;
- resolving OVERRIDE behavior;
- reopening C-13 or C-12;
- defining Resolution or Result ontology;
- implementation architecture.

## 1. Existing source categories

The current architecture already distinguishes several semantic roles.

### RULE

A Rule expresses a constraint, invariant, policy, or authority-bearing instruction.

A Rule is therefore capable of functioning as project-normative input.

### REFERENCE

A Reference is evidence or source material.

Examples include SDK documentation, external repositories, manuals, research material, and test data.

The architecture explicitly states that reading a Reference does not automatically grant it authority over project rules.

### MEMORY

Memory is durable knowledge, lessons, context, or project state.

Memory is not automatically an instruction.

### HANDOFF

A Handoff is durable conversation-state transfer.

It preserves research/workflow state for continuation but is not thereby an independent authority source for application semantics.

### TRACE

TRACE is an observability layer.

It can expose what was discovered, applied, checked, or performed, but it is explicitly not an authority source.

### RESEARCH / FINDING

The project architecture and workflow distinguish research from specification.

Research records what was discovered.

A finding may classify an observation or inference, but research status alone does not automatically make the finding a project requirement.

### SPECIFICATION

A specification defines what AIP Mirror should do.

The project workflow explicitly requires intentional acceptance before a finding is promoted to specification.

This is the first direct evidence of a project-controlled semantic transition.

## 2. External evidence versus project semantics

The audit identifies a critical distinction.

An external source may be authoritative **about the external subject it documents** without thereby becoming authoritative **over AIP Mirror's own project semantics**.

For example:

    Adobe SDK
        ↓
    evidence about Illustrator AIP/API behavior

does not imply:

    Adobe SDK
        ↓
    automatic AIP Mirror requirement

Likewise:

    FreeHand manual / observation
        ↓
    evidence about FreeHand behavior

does not imply:

    FreeHand behavior
        ↓
    automatic AIP Mirror specification

The project must still decide whether and how the external behavior is adopted, adapted, or rejected for AIP Mirror.

This preserves the existing project distinction between evidence and specification.

## 3. Existing evidence-to-specification transition

The repository already contains an explicit workflow boundary:

    observation
        ↓
    documented finding
        ↓
    specification
        ↓
    implementation

The workflow rules additionally state that a behavior discovered during reverse engineering is not automatically a project requirement, and that a finding should be promoted to specification only when the project has intentionally accepted it.

Therefore the repository does NOT support the following automatic transition:

    evidence
        ↓
    authoritative project semantics

Instead, the current architecture supports a controlled transition:

    evidence / observation
        ↓
    research / finding
        ↓
    intentional project acceptance
        ↓
    specification / project decision
        ↓
    implementation

The exact mechanism of "intentional acceptance" is not yet formalized as a separate semantic primitive. The existence of the transition itself, however, is established by the project rules.

## 4. Historical OVERRIDE evidence

C-14 correctly observed that the current inspected architecture document did not contain a sufficiently explicit OVERRIDE semantic specification for a non-circular behavioral test.

The audit additionally inspected historical 03D/03E research state.

Those historical artifacts contain substantial OVERRIDE working decisions, including:

- explicit authorization as the baseline;
- declaration not being authorization;
- TRACE not being authority;
- bounded authorization;
- externally established authority consumed by Core;
- separation between external authority establishment and Core evaluation;
- authority standing distinct from precedence;
- precedence as explicit policy input;
- specificity not independently creating authority or precedence.

These artifacts are valuable evidence of prior project reasoning.

However, their existence does not by itself answer the normative-status question for every current architectural statement.

In particular, a historical handoff is:

    durable historical project state

but is not automatically equivalent to:

    current canonical specification

unless the project lifecycle/documentation establishes that status.

This distinction is important because historical handoffs are intentionally preserved even after supersession.

## 5. No total source hierarchy is established

The audit finds no basis for a universal ordering such as:

    RULE > SPEC > REFERENCE > MEMORY

Such a ranking would collapse different dimensions.

For example:

- a Reference can be authoritative about an external API fact;
- a Rule can be authoritative within project operation;
- a Handoff can be authoritative about historical chapter state;
- a Memory can preserve durable knowledge without becoming a constraint.

These are different authority questions.

Therefore the current evidence supports **typed source roles and controlled semantic transitions**, not a single total ordering of all sources.

## 6. Authority appears attached to claims/decisions in context, not simply to source containers

The evidence supports a more precise working distinction:

    source
       ↓
    evidence / statement
       ↓
    interpretation / finding
       ↓
    project acceptance
       ↓
    normative project statement

This means the useful unit of analysis may be the accepted semantic statement rather than the source container itself.

This is an inference, not an established ontology.

The audit therefore does NOT introduce:

- an "authority-bearing claim" entity;
- a formal claim ontology;
- provenance as a semantic primitive;
- a universal evidence graph;
- a source-precedence engine.

## 7. What C-14 should retain

C-14's evidence boundary remains valid, with one refinement.

The original conclusion was:

    no sufficiently explicit current OVERRIDE semantics
        ↓
    behavioral C-14 cannot be executed without assumption

The audit refines this to:

    current canonical architecture does not provide sufficient explicit OVERRIDE semantics
        +
    historical research contains substantial OVERRIDE reasoning
        ↓
    historical evidence exists, but its current normative status must not be inferred automatically
        ↓
    behavioral C-14 remains non-executable without establishing the status of the relevant historical decisions or obtaining another accepted semantic source

This is a stronger and more accurate evidence boundary.

## 8. Architectural finding

The project already contains the beginnings of an epistemic/normative boundary:

    external/reference evidence
             ↓
       research finding
             ↓
     intentional acceptance
             ↓
       project specification
             ↓
        implementation

The architecture does not yet formally specify:

- what counts as "intentional acceptance";
- whether every accepted finding becomes a specification;
- how conflicting historical findings are retired;
- whether a handed-off handoff can contain still-valid decisions;
- how an architectural decision becomes canonical across documents;
- whether project specifications themselves have distinct authority scopes.

These are open questions.

They should not be solved merely to complete C-14.

## 9. Bounded conclusions

### Established

1. The project explicitly distinguishes Rules, References, Memory, Handoffs, TRACE, research, and specifications by role.
2. A Reference is evidence/source material and does not automatically acquire authority over project rules.
3. TRACE is not an authority source.
4. Memory is not automatically an instruction.
5. Research is distinct from specification.
6. Observed behavior is not automatically a project requirement.
7. The workflow explicitly requires intentional acceptance before promotion of a finding to specification.
8. Historical OVERRIDE research exists and contains substantial prior semantic decisions.
9. Historical existence alone does not establish that every statement remains current normative specification.
10. No total source hierarchy is established or required by the inspected evidence.

### Inferred

1. Project semantic authority is better modeled as a property of an accepted project statement/decision in context than as a blanket property of a source container.
2. The semantic transition from evidence to project norm may be a more fundamental architectural boundary than source ranking.
3. C-14's blockage is partly a status/acceptance problem, not simply an absence-of-information problem.

These remain inferences.

### Not established

The audit does NOT establish:

- a claim ontology;
- a provenance ontology;
- a universal source hierarchy;
- a formal acceptance mechanism;
- a mandatory Architecture Decision format for every accepted finding;
- a universal rule that only one document type can establish semantics;
- a final OVERRIDE semantic model.

## 10. Architectural significance

The research direction can now be represented without assuming a source hierarchy:

    SOURCE
      │
      ├── external fact
      ├── observation
      ├── reference material
      └── prior project research
             │
             ▼
         EVIDENCE
             │
             ▼
       RESEARCH / FINDING
             │
             │ intentional project acceptance
             ▼
       PROJECT SEMANTICS
             │
             ├── specification
             ├── architecture decision
             └── rule / invariant
             │
             ▼
       IMPLEMENTATION

The important boundary is therefore not necessarily:

    source A > source B

but potentially:

    evidence
       ≠
    accepted project semantics

That distinction directly addresses the original question:

> What is allowed to establish what X means?

Current answer:

> Evidence can establish what an external source, observation, or research record supports; project semantics require an intentional project-level acceptance transition. The exact formal mechanism of that transition remains open.

## Status

    SEMANTIC_SOURCE_AUDIT = CLOSED
    SOURCE_TOTAL_ORDER = NOT ESTABLISHED
    REFERENCE_EQUALS_PROJECT_AUTHORITY = FALSE
    TRACE_EQUALS_AUTHORITY = FALSE
    MEMORY_EQUALS_INSTRUCTION = FALSE
    RESEARCH_EQUALS_SPECIFICATION = FALSE
    EVIDENCE_TO_SPECIFICATION = CONTROLLED_TRANSITION_ESTABLISHED
    ACCEPTANCE_MECHANISM = NOT FORMALLY DEFINED
    HISTORICAL_OVERRIDE_EVIDENCE = PRESENT
    HISTORICAL_OVERRIDE_CURRENT_STATUS = NOT AUTOMATICALLY INFERRED
    C14_EVIDENCE_BOUNDARY = PRESERVED_AND_REFINED
    NEW_OVERRIDE_TEST = NOT AUTOMATICALLY SELECTED
    IMPLEMENTATION_AUTHORIZED = NO

## Next architectural question

The audit does not automatically create a new C-series experiment.

The next high-leverage question is narrower:

> **What project-level act or artifact constitutes intentional acceptance of a research finding as current normative project semantics, and how is that status preserved across document types and chapter migrations?**

This question should be investigated only after checking whether the existing architecture already answers it elsewhere.

Human remains the final architecture decision-maker.
