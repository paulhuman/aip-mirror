# Developer knowledge rules

These rules define the active AI-infrastructure constraints for capturing durable knowledge into the configured external developer knowledge repository.

## 1. Scope

This rule applies to knowledge entries created or updated by `.ai/skills/knowledge-capture/SKILL.md`.

The external developer knowledge repository remains project-independent. This rule governs the AI capture process; it does not become part of the external repository's semantic content.

## 2. Educational language policy

The knowledge repository uses a deliberate two-layer language model:

> **Russian is the explanatory language; English is the canonical vocabulary of professional terminology.**

Knowledge entries MUST use Russian for explanatory prose.

The following SHOULD remain in their canonical English form:

- names of entities;
- professional terminology;
- technology and product names;
- command names;
- API names;
- parameter and option names;
- identifiers from source code;
- stable technical expressions.

A professional term SHOULD NOT be translated merely for the sake of translation. When a term benefits from explanation, introduce it in its canonical English form and explain its meaning in Russian.

This policy does not require English everywhere. Natural Russian phrasing remains appropriate when describing an operation or concept in ordinary explanatory language.

## 3. Educational quality

Knowledge capture MUST optimize for durable understanding rather than snippet preservation.

Entries SHOULD explain, where applicable:

- the problem being solved;
- the simplest useful solution;
- the meaning of important parts;
- the underlying mechanism;
- why the solution works;
- assumptions and limitations;
- gotchas and safety considerations;
- verification;
- alternatives;
- version-sensitive behavior;
- related concepts.

The exact structure MUST follow the educational needs of the entry. Empty headings MUST NOT be created merely to satisfy a template.

## 4. Source material is not authority

AI-generated or externally supplied material MUST NOT be treated as verified merely because it is useful or plausible.

Knowledge capture MUST distinguish confirmed facts, inferences, version-sensitive claims, and unverified material.

## 5. Canonical relationship

`.ai/docs/architecture/developer-knowledge-archive.md` preserves the architectural rationale and history for this policy.

This rule is the active semantic owner used during knowledge capture. The architecture note MUST NOT be treated as a second execution owner.
