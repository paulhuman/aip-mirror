---
name: git-cli-repository
description: Use when repository operations depend on a local Git working copy, index, refs, or filesystem state.
disable-model-invocation: false
user-invocable: true
---

# Local Git repository operations

This skill owns repository mechanics specific to a local Git working copy. Shared repository semantics and safety invariants remain owned by `.ai/skills/repository/SKILL.md`.

## 1. Resolve the local repository root

Resolve the actual working copy root with:

    git rev-parse --show-toplevel

A hosting URL is not a local filesystem path. Keep the local path used by Git separate from repository-relative paths written in project documentation.

## 2. Protect working-copy state

Before mutation or cleanup, inspect the local state and distinguish:

- committed files;
- staged changes in the index;
- unstaged tracked changes;
- untracked files;
- ignored files and generated artifacts.

Useful starting commands include:

    git status --short
    git status --short --ignored
    git diff
    git diff --cached
    git ls-files --others --exclude-standard

A normal status or tracked-file listing does not show every ignored or untracked path. DO NOT infer that the working copy is clean or unaffected from tracked paths or a diff alone. Machine-specific ignored paths, such as a locally created adapter link, appear only under `--ignored`.

Preserve all pre-existing user changes, whether staged, unstaged, untracked, or ignored. DO NOT overwrite or delete them as incidental cleanup.

Destructive operations such as `git reset --hard`, `git checkout --force`, `git clean -f`, or `git restore` over a dirty range MUST NOT be run in a working copy that contains unrelated user work.

The destructive commands are not interchangeable, and their scopes differ in ways that are easy to misjudge:

- `git reset --hard` restores tracked files to the target revision but does **not** remove untracked files. Treating it as a complete cleanup is incorrect.
- `git clean -f` removes untracked files but leaves ignored files in place; `git clean -fdx` removes ignored files as well.
- `git restore` over a path discards unstaged tracked changes in that path without a confirmation prompt.
- `git checkout --force` overwrites tracked files from the index or the given revision.

Because the scopes differ, determine which categories a command actually affects before running it, then verify the resulting state rather than assuming the intended removal happened. Removing ignored files is destructive to data that `--ignored` inspection is specifically needed to reveal.

## 3. Verify local mutations

After changing files:

1. Inspect the relevant file contents;
2. Inspect staged and unstaged diffs separately;
3. Check untracked and ignored paths where relevant;
4. Verify that the actual changed scope matches the intended scope;
5. Commit only under the authorization and policy defined by `.ai/skills/commits/SKILL.md`;
6. Verify the resulting commit and working-copy state.

A clean tracked diff does not prove that no ignored or untracked side effects occurred.

## 4. Boundary

This skill owns local path resolution, working-copy/index protection, and local mutation mechanics. It does not own:

- universal repository semantics or mutation-safety invariants — `.ai/skills/repository/SKILL.md`;
- shared development methodology — `.ai/skills/workflow/SKILL.md`;
- local tree pinning, repository-wide inspection, or fixture workflow — `.ai/skills/git-cli-workflow/SKILL.md`;
- remote GitHub API mechanics — `.ai/skills/github-api-repository/SKILL.md` and `.ai/skills/github-api-workflow/SKILL.md`.
