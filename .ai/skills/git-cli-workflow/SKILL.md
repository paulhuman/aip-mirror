---
name: git-cli-workflow
description: Use when pinning, inspecting, or testing repository state through a local Git working copy.
disable-model-invocation: false
user-invocable: true
---

# Local Git inspection workflow

This skill owns local Git procedures for repository-wide inspection, revision pinning, and isolated fixture testing.

## 1. Establish an authoritative commit tree

For a pinned committed snapshot, record:

    git rev-parse HEAD
    git rev-parse 'HEAD^{tree}'
    git ls-tree -r HEAD --name-only

The commit SHA identifies the revision; the tree SHA identifies its committed root tree; `git ls-tree -r` lists tracked paths in that tree. The command has no API-style `truncated` field, but it describes the committed tree only, not every file on disk.

When inspecting a named revision, DO substitute that revision consistently for `HEAD` and record it before reading files.

DO quote the revision expression. `HEAD^{tree}` is a shell metacharacter sequence: with quoting it yields the tree SHA, and without it a shell may parse or break the argument. The quoting style depends on the shell, and a wrong style fails silently into an ambiguous-argument error:

- POSIX shells and PowerShell: `'HEAD^{tree}'` (single quotes) works.
- `cmd.exe`: single quotes are not special and the argument breaks; DO use `"HEAD^{tree}"` (double quotes).

After running the command, DO confirm that the output is a tree object SHA rather than treating a zero exit status as sufficient.

## 2. Inspect the working copy separately

The committed tree and the working copy are different scopes. DO inspect the local state separately:

    git status --porcelain
    git status --porcelain --ignored
    git diff
    git diff --cached
    git ls-files --others --exclude-standard

DO use the relevant combination to account for staged, unstaged, untracked, and ignored paths. DO NOT conclude that a path is absent from disk merely because it is absent from the committed tree or tracked-file listing.

DO record which paths were actually inspected. DO keep conclusions bounded to the revision, working-copy state, and scope covered by the evidence.

## 3. Isolated repository fixtures

When a test requires synthetic or destructive repository state, SHOULD prefer a separate worktree at the pinned baseline revision:

    # DO run worktree-management commands from the primary working copy.
    git worktree add --detach <fixture-path> <known-commit-sha>
    # DO run the test operation inside <fixture-path> and verify its resulting state.
    git -C <fixture-path> status --short --ignored --untracked-files=all
    # DO inspect ALL remaining files, including ignored ones, before cleanup.
    # Normal removal silently discards ignored files, so DO NOT treat it as safe by default.
    git worktree remove <fixture-path>
    # DO use --force only after confirming that everything it would discard is disposable.

The fixture worktree has its own checked-out files and HEAD while sharing the repository object store and refs. DO run destructive fixture operations only inside the disposable fixture, never in the primary working copy holding unrelated user state.

DO use `--detach` and an absolute `<fixture-path>`:

- Without `--detach`, adding a worktree with `-b` creates or moves a branch ref, which is shared with the primary repository. A detached fixture does not move any shared ref; this was verified by comparing `git show-ref` before and after a destructive operation inside the fixture.
- A relative `<fixture-path>` resolves against the repository root, not the current directory, so the fixture can land outside the intended location.
- `git worktree add` refuses a target path that already exists and is not empty.
- DO run worktree-management commands from the primary working copy, not from inside the fixture. `git worktree remove` executed from inside its own target fails while the directory is in use.

### Inspecting and removing a fixture safely

Removal behavior differs by file category, and the differences are not symmetric:

- A modified or untracked file makes normal removal refuse with a non-zero exit. Nothing is lost.
- An **ignored** file alone does **not** make removal refuse. Normal `git worktree remove` exits successfully and **silently discards ignored files**. This was verified directly: an ignored file with content was destroyed by a non-forced removal that reported no message and returned exit code 0.
- Forced removal discards everything the fixture contains.

Therefore, DO inspect ignored content before removing a fixture, not only modified and untracked content:

    git -C <fixture-path> status --short --ignored --untracked-files=all

DO preserve any fixture content that is still needed as test evidence before deleting it. DO NOT rely on normal removal being safe by default: it is safe for modified and untracked files, and unsafe for ignored ones.

`git clean` does not follow the same rule as worktree removal:

- `git clean -f` removes untracked files but leaves ignored files in place;
- `git clean -fdx` removes ignored files as well.

DO NOT use `git clean -fdx` unless every ignored path in the fixture is confirmed disposable. Note also that `git reset --hard` does not remove untracked files; treating it as a full cleanup is incorrect.

### Fixture lifecycle

If the fixture directory is deleted manually instead of through `git worktree remove`, Git keeps a stale registration. The path is then reported as `prunable`, and `git worktree add` at the same path fails with `is a missing but already registered worktree`. DO run `git worktree prune` to clear stale registrations before reusing a path. DO detect stale entries with:

    git worktree list --porcelain

If a separate worktree is unavailable, DO use a separate temporary clone or DO NOT run the destructive fixture test. DO NOT fall back to a disposable branch in the primary working copy. DO NOT use destructive cleanup as a substitute for restoring user work.

Fixture branches and worktrees MUST remain isolated from canonical branches such as `main`. DO verify the actual fixture state instead of inferring it from the intended command. DO remove disposable state when the test completes.

## 4. Boundary

This skill owns local revision pinning, complete tracked-tree listing, working-copy coverage checks, and local fixture workflow. It does not own:

- shared repository semantics — `.ai/skills/repository/SKILL.md`;
- shared development methodology — `.ai/skills/workflow/SKILL.md`;
- local mutation and working-copy protection rules — `.ai/skills/git-cli-repository/SKILL.md`;
- remote GitHub API inspection or mutation — `.ai/skills/github-api-workflow/SKILL.md` and `.ai/skills/github-api-repository/SKILL.md`.
