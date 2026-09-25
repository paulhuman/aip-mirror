# Handoff reference preservation rules

## Repository path resolution

This rule inherits repository identity and path resolution from `.ai/rules/repository.md`.

Repository-relative paths resolve using the project repository configuration in `.ai/config.yaml`:

- `project.repository` identifies the repository.
- `project.default_branch` identifies the default branch.
- `project.hosting.base_url` provides the hosting base URL.

When a reference MUST remain reproducible against a specific branch, tag, or commit, use:

    <repository>@<ref>:/path

---

These rules define which research references MUST survive a conversation handoff.

## 1. Handoffs preserve material research context

A handoff MUST preserve not only conclusions and decisions, but also the **references materially required to understand, validate, or continue the work** represented by those conclusions and decisions.

The governing principle is:

> **Repository handoff state MUST outlive the conversation that created it.**

Therefore, a later chapter MUST NOT be forced to reconstruct a material research reference from the old conversation merely because the earlier chapter recorded the resulting conclusion.

## 2. Material references versus incidental browsing

A handoff MUST NOT become a dump of everything ever opened on the internet.

A reference is material when losing it would make a later chapter materially more likely to:

- misunderstand an important decision or its rationale;
- be unable to validate a recorded conclusion;
- repeat research that has already been performed;
- lose a known external implementation, specification, repository, document, or other evidence used as a meaningful research point;
- incorrectly infer why a repository, fork, document, or other source was part of the research.

Incidental browsing, generic search results, temporary exploratory pages, and sources that have no continuing value do not need to be preserved in the handoff.

## 3. Record role, not only location

Every preserved external research reference MUST include its Role: a concise explanation of why the reference matters to the current chapter's work.

A URL without a role is insufficient when the purpose of the reference would otherwise be ambiguous later.

For repositories, record the repository identity and, when relevant, its upstream/parent relationship.

Recommended structure:

```text
## Research references

### External repositories

- <owner>/<repository>
  - Fork of: <upstream repository, if applicable>
  - Role: <why this reference matters>
  - URL: <canonical URL>
```

## 4. References are evidence, not authority

Preserving a reference in a handoff does not grant it authority over project rules or decisions.

References remain evidence/source material. Their presence in a handoff means that they are materially relevant to understanding or validating the recorded project state.

## 5. Handoff completeness check

Before a handoff is considered ready for the next chapter, ask:

1. Which external references materially support the decisions or conclusions being transferred?
2. Could the next chapter understand why those references mattered without the old conversation?
3. Does each preserved reference have enough identity to locate it again?
4. Does each preserved reference have a concise Role?
5. Have incidental links been deliberately excluded rather than copied indiscriminately?

If a material reference is missing, the handoff is incomplete until the reference is preserved or the reason for its exclusion is explicitly documented.

## 6. Project-agnosticity

The rule itself is project-agnostic. Concrete references remain project-specific or research-specific and belong in the applicable handoff or project documentation, not in this reusable rule.
