# Normative language rules

This rule defines how normative meaning is expressed in active project-controlled AI infrastructure and project documentation.

## 1. Scope

This rule applies to:

- active `.ai/**`, except `.ai/archives/**`;
- `.ai/handoffs/README.md`;
- the entire `docs/**` tree.

Other handoff files are conversation-state artifacts and are outside this language-normalization scope.

## 2. BCP 14 normative keywords

When a statement establishes a requirement, prohibition, recommendation, or normative permission, use these uppercase keywords:

- `MUST` — requirement;
- `MUST NOT` — prohibition;
- `SHOULD` — recommendation;
- `SHOULD NOT` — recommendation against;
- `MAY` — normative permission.

These keywords follow the normative keyword convention established by RFC 2119 and RFC 8174.

DO NOT introduce alternative normative keywords such as `SHALL`, `SHALL NOT`, `REQUIRED`, `RECOMMENDED`, or `OPTIONAL`.

## 3. Procedural vocabulary

`DO` and `DO NOT` are the project's local procedural vocabulary.

Use `DO` or `DO NOT` for direct procedural instructions when the text tells an AI what action to perform or avoid.

`DO` and `DO NOT` are not BCP 14 normative keywords.

DO NOT treat every procedural instruction as a `MUST` or `MUST NOT` merely because it is important.

## 4. Semantic classification

Classify the meaning of an occurrence before changing its capitalization.

### NORMATIVE

Use a BCP 14 keyword when the statement establishes a requirement, prohibition, recommendation, or permission.

Examples:

- `A handoff MUST record enough information for the next chapter to continue without guessing.`
- `The previous chapter MUST NOT mark its own handoff HANDED_OFF.`
- `Important state SHOULD be documented during long-running work when a meaningful milestone is reached.`
- `Only the receiving chapter MAY create and own its own initial DRAFT handoff.`

### PROCEDURAL

Use `DO` or `DO NOT` for a direct procedure.

Example:

- `DO NOT skip states.`

### ORDINARY_ENGLISH

Keep the keyword lowercase when it expresses ordinary English rather than a normative rule.

Examples:

- `A chapter may need to continue in a new conversation.`
- `What should happen next?`
- `A future ENTRY.md may be justified if evidence shows that the repository needs it.`

### AMBIGUOUS

If the same word could be normative or ordinary English, inspect the surrounding context manually. Historical statements, research conclusions, questions, and descriptive prose are not automatically normative.

## 5. Case and emphasis

Uppercase is part of the project's normative syntax.

DO NOT capitalize a keyword merely because the word appears in a rule, heading, quotation, historical statement, question, or example.

DO NOT use Markdown emphasis as an alternative normative syntax. Forms such as `must **not**` or `**do not**` MUST be classified by meaning and normalized when they express normative or procedural meaning.

Lowercase `must`, `should`, `may`, and `do not` remain valid ordinary English when they are not expressing normative or procedural meaning.

## 6. Express prohibitions explicitly

Express normative prohibitions with `MUST NOT`.

DO NOT introduce `MUST NEVER`, `SHOULD NEVER`, or `MAY NOT` as alternative normative forms.

When an existing prohibition uses `must never`, normalize it to `MUST NOT` when the sentence is normative.

For example:

- `An AI MUST NOT claim a repository operation occurred unless it actually performed and verified it.`

The goal is one clear canonical form for normative prohibition, not a ban on the ordinary English word `never`.

## 7. Semantic test

For any occurrence of `must`, `should`, `may`, or `do not`, ask:

1. Is this statement establishing a rule, requirement, restriction, recommendation, or permission?
2. Is it instead giving a direct procedure?
3. Is it ordinary English, a question, historical narration, research material, or descriptive text?
4. If ambiguous, does the surrounding context establish current normative force?

Only after this classification SHOULD capitalization or wording be changed.

## 8. Consistency

DO NOT perform blind search-and-replace.

A cleanup is correct only when the resulting wording preserves the original semantic intent while using the canonical vocabulary above.

This rule itself follows the same convention it defines.
