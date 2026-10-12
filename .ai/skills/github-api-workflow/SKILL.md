---
name: github-api-workflow
description: Use when performing repository-wide inspection or revision-pinned analysis through GitHub's remote API.
disable-model-invocation: true
user-invocable: false
---

# GitHub API repository inspection workflow

This skill owns the remote API procedure for establishing an authoritative, pinned repository snapshot and proving coverage of the declared inspection scope.

## 1. Establish a pinned tree snapshot

Before making repository-wide structural claims:

1. read the intended Git ref and record the exact commit SHA it references;
2. read that commit object and record its root tree SHA;
3. request the recursive tree for that exact tree SHA;
4. verify that the returned tree SHA matches the requested tree SHA;
5. record the returned entry count and inspect the `truncated` field;
6. treat the recursive result as complete only when `truncated` is explicitly `false`;
7. if it is `true`, do not assume the response identifies which paths or subtrees were omitted; restart coverage accounting from the requested root tree and traverse every required subtree using bounded, non-recursive tree requests, recursively descending as needed until every in-scope tree entry is accounted for;
8. pin subsequent file reads, commit comparisons, and reference checks to the recorded commit SHA rather than rereading a moving branch name.

Keep the branch/ref name, commit SHA, and root tree SHA distinct in notes and conclusions: the ref is a movable name, the commit identifies a revision, and the tree identifies its committed path structure.

A successful API response alone does not prove that a recursive tree is complete. If the ref, commit, tree, or completeness status cannot be verified, state the limitation and keep conclusions bounded to the files and revision actually inspected.

## 2. Retrieve the declared scope completely

Use this sequence:

    pinned repository tree
        ↓
    identify the exact paths in the declared scope
        ↓
    retrieve contents one directory or meaningful batch at a time
        ↓
    subdivide unusually large directories and follow API pagination where applicable
        ↓
    verify that every in-scope path was retrieved or explicitly accounted for
        ↓
    analyze the complete retrieved content
        ↓
    inspect historical/archive areas separately when they are not in scope

The tree establishes committed repository structure; direct file retrieval establishes file contents. A tree entry's type and mode matter: do not assume that every entry is an ordinary file or follow a submodule as though its contents were part of the parent repository. Do not infer completeness from search indexes or a successful subset of reads.

Maintain a simple coverage record for substantial sweeps: pinned commit SHA, declared scope, retrieved paths, paths not retrieved, and any known API limitations. A path that could not be fetched must remain an explicit coverage gap, not silently disappear from the scope.

For an active-infrastructure sweep, use the current repository structure and the scope declared for the task. README files can orient the inspection but do not replace canonical owners. Do not automatically load all historical handoffs or archive contents unless they are in scope.

## 3. Boundary

This skill owns remote revision pinning, remote tree completeness, and coverage verification. It does not own:

- remote file mutation mechanics — `.ai/skills/github-api-repository/SKILL.md`;
- local Git tree and working-copy inspection — `.ai/skills/git-cli-workflow/SKILL.md`;
- shared development methodology — `.ai/skills/workflow/SKILL.md`.
