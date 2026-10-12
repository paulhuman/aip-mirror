---
name: github-api-repository
description: Use when repository operations are performed through GitHub's remote API or Contents API without relying on a local working copy.
disable-model-invocation: true
user-invocable: false
---

# GitHub API repository operations

This skill owns repository-access and mutation mechanics specific to the GitHub API / Contents API path. Shared repository semantics and safety invariants remain owned by `.ai/skills/repository/SKILL.md`.

## 1. Scope and assumptions

Use this skill when the operation reads or mutates repository state through GitHub's remote API and does not depend on a local working copy.

Do not assume a local filesystem, local index, local working-tree status, or locally available Git commands. For local repository operations, use `.ai/skills/git-cli-repository/SKILL.md`.

## 2. Read-before-write and complete-file replacement

Before changing an existing file:

1. identify the exact repository and intended target branch/ref; do not rely on an implicit default branch;
2. inspect the target path's entry in the pinned tree and confirm it is an ordinary file blob with the expected mode before treating its Contents API response as the file itself; the Contents API can return the target content when a symlink points to a normal repository file, and a submodule entry is not an ordinary file;
3. resolve and record the target ref's current commit SHA;
4. fetch the complete file from that same target ref and record its blob SHA; do not use line-range retrieval for a read-before-write operation, because a partial response is not a safe basis for full-file replacement even if the returned blob SHA identifies the underlying file;
5. make the minimal intended change against the fetched content;
6. submit the complete intended file content, not only a patch fragment;
7. use the current blob SHA as the update precondition when the API supports it;
8. capture the resulting commit SHA and read the file back from that immutable revision;
9. verify the intended content and preservation of unrelated content;
10. inspect the resulting commit's parent, diff, and changed-file scope before treating the change as complete.

For a new file, first verify that the intended path does not already exist at the target revision. Do not replace an existing file merely because a create operation failed.

Never reconstruct an existing file from memory when it can be fetched. A successful API write or commit does not establish that the content is correct.

If an update fails because the target branch or blob changed, stop and re-read the current ref and file. Re-evaluate the intended change against the new content; do not blindly retry with a stale blob SHA or overwrite concurrent work.

The Contents API's `sha` precondition identifies the file blob being replaced; it is not a precondition that the branch still points to the commit previously inspected. An unrelated commit can advance the target branch without changing that file's blob. Therefore, a successful Contents API write does not by itself prove that the new commit has the previously observed commit as its parent or that it was based on an unchanged branch head. Verify the resulting commit's actual parent and diff.

Use the Contents API for ordinary individual-file changes when a per-file blob precondition plus post-write verification is sufficient. When the operation requires one atomic multi-file commit or must publish only if the branch head is still the exact inspected commit, use the Git Database flow instead: build a tree from the pinned base tree, create a commit with the inspected commit as its parent, then update the branch ref. Use an expected-head/lease precondition if the available ref-update tool explicitly supports it; if it does not, do not claim compare-and-swap protection. If the ref update loses a race or its outcome is uncertain, re-read the ref and verify state before deciding whether to rebuild or stop. Do not force-update a canonical branch to bypass a concurrent change.

Pin reads to an immutable commit SHA when a consistent multi-file snapshot is required. Avoid mixing reads from a moving branch name with claims about one coherent repository state.

## 3. Remote repository state, scope, and fixtures

A remote commit tree represents committed repository state. It does not reveal uncommitted files that exist only in someone's local working copy.

When checking mutation scope, inspect the actual resulting commit/tree and its diff. Verify the commit's parent and confirm that the changed paths are exactly within the authorized scope. Do not treat a successful write response as proof that only the intended files changed.

For a disposable remote fixture:

1. pin a known baseline commit SHA;
2. create a uniquely named disposable branch from that exact baseline, without reusing or overwriting an existing branch;
3. read the new branch ref back and verify that it points to the baseline before making fixture changes;
4. perform fixture mutations only against that explicit branch;
5. verify every resulting commit, its parent, the fixture contents, and the changed-path scope;
6. keep the fixture branch separate from canonical branches such as `main`;
7. before deleting the fixture ref, read it again and verify that it still points to the expected disposable tip. Delete only that fixture ref, never a canonical ref.

If branch creation, ref inspection, or cleanup cannot be verified, stop and report the limitation rather than approximating the fixture state. A conflict or failed mutation is a reason to re-read and reassess, not to retry blindly.

## 4. Boundary

This skill owns the mechanics of remote repository reads and writes. It does not own:

- universal repository semantics or mutation-safety invariants — `.ai/skills/repository/SKILL.md`;
- shared development methodology — `.ai/skills/workflow/SKILL.md`;
- remote tree completeness and repository-wide inspection procedures — `.ai/skills/github-api-workflow/SKILL.md`;
- local working-copy operations — `.ai/skills/git-cli-repository/SKILL.md` and `.ai/skills/git-cli-workflow/SKILL.md`.
