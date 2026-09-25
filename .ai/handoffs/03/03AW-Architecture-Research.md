# Conversation Handoff

Conversation:
AIP Mirror — 03AW — Architecture & Research

Specialization:
03 — Architecture & Research

Chapter:
03AW

Previous chapter:
03AV — Architecture & Research

Status:
HANDED_OFF

## Bootstrap state

03AW was received from the canonical repository state and continued the Iteration 2 restructuring.

The repository has now moved beyond the original pre-physical-restructuring plan.

Important current sources:
- docs/PROJECT-INSTRUCTIONS.md
- .ai/architecture/ai-infrastructure-restructuring.md
- .ai/architecture/ai-project-instruction-architecture.md
- .ai/architecture/decomposition-map.md
- .ai/rules/repository.md
- .ai/rules/handoff/lifecycle.md
- .ai/rules/commits.md
- .ai/skills/commits/SKILL.md
- .ai/workflows/handoff-bootstrap/BOOTSTRAP.md
- relevant .ai/handoffs/03/ handoff history.

Do not reconstruct the current state from older chat history. The architecture files above were updated specifically to preserve the migration decisions that matter.

## Current frontier

Iteration 2 is now in the:

> PHYSICAL RESTRUCTURING + POST-EDIT CONSISTENCY REPAIR

stage.

The original semantic-comparison / v2-target-tree planning stage has already been passed for the areas physically changed so far.

The key new architectural lesson is:

> A canonical-owner change must be followed by a repository-wide semantic search for stale dependencies.

This is now a required procedure, not an optional cleanup step.

## Accepted semantic model

### Semantic levels

- LOCATION — coherent semantic kind is in the wrong place → MOVE.
- CONTENT BOUNDARY — one file contains multiple semantic responsibilities → DECOMPOSE.
- LIFECYCLE — useful evidence is no longer active infrastructure → ARCHIVE.

Also use REMOVE when content is already canonically represented elsewhere or is no longer needed.

### Semantic kinds

- RULE = what must be true
- SKILL = reusable capability
- WORKFLOW = ordered procedure
- README = orientation/navigation
- PROJECT DOC = AIP Mirror project knowledge

Do not create a file merely because a semantic unit can be named.

## Central ownership boundary

> If the primary subject is how AI should work with the project, it belongs in .ai/. If the primary subject is what AIP Mirror is or how it works, it belongs in docs/.

This remains the central Iteration 2 boundary.

## Workstream meaning

A workstream is a project work area represented by one or more separate AI conversations.

It is NOT:
- an autonomous agent;
- a service;
- a process that can communicate with another workstream directly.

The user coordinates work between conversations and AI services. Durable repository files carry information between them when the user asks a conversation to read or update those files.

Do not restore the old interpretation of workstreams as communicating agents.

## Handoff lifecycle

The lifecycle is exactly:

    DRAFT
      |
      v
    READY_FOR_HANDOFF
      |
      v
    HANDED_OFF

Do not use SUPERSEDED as a lifecycle state.

Keep three dimensions separate:

    HANDOFF LIFECYCLE
        = state

    HANDOFF OPERATION
        = action

    HANDOFF COMMIT
        = durable Git record

An operation does not necessarily change state, and a handoff commit does not itself define a lifecycle transition.

## Physical restructuring already completed

The following major moves/renames have been completed:

    docs/architecture/ai-project-instruction-architecture.md
        -> .ai/architecture/ai-project-instruction-architecture.md

    docs/architecture/independent-review-{grok,qwen,deepseek}-onboarding.md
        -> .ai/workflows/independent-review/

    .ai/rules/conversation-lifecycle.md
        -> .ai/rules/handoff/lifecycle.md

    .ai/rules/handoff-references.md
        -> .ai/rules/handoff/handoff-references.md

    .ai/skills/conversation-handoff/SKILL.md
        -> .ai/skills/handoff/conversation-handoff/SKILL.md

    .ai/skills/conversation-handoff/BOOTSTRAP.md
        -> .ai/workflows/handoff-bootstrap/BOOTSTRAP.md

    .ai/skills/handoff-reference-preservation/SKILL.md
        -> .ai/skills/handoff/handoff-reference-preservation/SKILL.md

    docs/handoffs/
        -> .ai/handoffs/<specialization>/

Architecture filenames were simplified by removing historical chapter suffixes/prefixes where they no longer carried semantic meaning.

## Rule decomposition completed

### workflow / commits

.ai/rules/workflow.md was reduced to generic AI workflow principles.

Commit policy now has canonical owners:
- .ai/rules/commits.md
- .ai/skills/commits/SKILL.md

Do not recreate detailed commit policy inside workflow.md.

### repository

.ai/rules/repository.md is the canonical owner for:
- repository identity;
- external repository boundaries;
- repository path resolution;
- repository taxonomy/hygiene;
- repository-facing durable knowledge;
- repository write safety.

Canonical write sequence:

    READ CURRENT FILE
        ↓
    minimal intended change
        ↓
    WRITE COMPLETE FILE
        ↓
    READ BACK
        ↓
    VERIFY CONTENT
        ↓
    INSPECT DIFF
        ↓
    VERIFY SCOPE
        ↓
    COMMIT
        ↓
    VERIFY RESULT

### PROJECT-INSTRUCTIONS

docs/PROJECT-INSTRUCTIONS.md is now a thin AIP Mirror project-specific instruction layer.

It retains:
- project orientation;
- project operating model;
- native implementation target;
- behavioral target;
- cross-workstream coordination;
- project-source routing.

It no longer owns generic repository path resolution, generic commit policy, or handoff lifecycle mechanics.

## Critical Iteration 2 discovery: post-edit consistency sweep

A structural change can leave stale dependencies in files that were not edited.

Observed real case:

    PROJECT-INSTRUCTIONS.md
          |
          | old canonical owner
          v
    repository path resolution

After path resolution moved to .ai/rules/repository.md, .ai/rules/handoff/lifecycle.md still contained the old owner twice.

This was caught only by searching for stale ownership after the structural change.

Required procedure:

    STRUCTURAL CHANGE
          |
          v
    READ BACK EDITED FILE
          |
          v
    SEARCH FOR OLD PATHS / OWNERS / TERMS
          |
          v
    CLASSIFY EVERY RELEVANT HIT
       /       |        |        \
    valid    stale   duplicate  historical
              |
              v
          REPAIR / REMOVE
              |
              v
       READ BACK CHANGED FILES
              |
              v
         DIFF + SCOPE CHECK
              |
              v
            COMMIT
              |
              v
        VERIFY RESULT

Minimum search targets:
- old paths;
- old filenames;
- old canonical-owner references;
- duplicated normative wording;
- removed lifecycle states/concepts;
- stale chapter/specialization identifiers;
- bootstrap references to moved files;
- routing/link targets.

The sweep is semantic. It does not mean blindly rereading the entire repository.

This procedure must be used after future MOVE, RENAME, DECOMPOSE, or canonical-owner changes.

## Why this matters

Without the sweep, the repository can contain:

    new canonical source
          +
    stale old source
          |
          v
    contradictory active context

That forces the next conversation to resolve a contradiction that the restructuring was supposed to eliminate.

Therefore:

    canonical-owner change
              |
              v
    stale-dependency search
              |
              v
    repository coherence
              |
              v
    smaller / cleaner active context

This is now durable Iteration 2 knowledge.

## Architecture files updated in 03AW

The following files were explicitly updated to preserve this discovery and remove stale planning:

1. .ai/architecture/ai-infrastructure-restructuring.md
   - rewritten as current durable Iteration 2 migration context;
   - records completed physical restructuring;
   - records canonical-owner change protocol;
   - records the consistency-sweep procedure;
   - removes obsolete pre-restructuring assumptions.

2. .ai/architecture/ai-project-instruction-architecture.md
   - updated from initial planning to current Iteration 2 architecture;
   - records the same consistency procedure as an architectural reliability mechanism;
   - records current dependency direction and execution state;
   - removes obsolete claims that restructuring had not yet begun.

3. .ai/architecture/decomposition-map.md
   - updated from pre-decomposition next steps to a live post-decomposition map;
   - adds the consistency-sweep procedure;
   - records the stale path-resolution discovery;
   - warns against repeating already completed physical operations.

These three files are now the durable architectural record for this stage. Do not let the handoff become the only place where these decisions survive.

## Current repository-state principle

The next chapter must treat the current repository as authoritative.

Do not use the old target tree as if it were still a future proposal.

Before the next physical change:

1. inspect the current relevant file;
2. identify its current canonical owner;
3. make the minimal change;
4. read back;
5. run the post-edit consistency sweep;
6. repair stale dependencies;
7. inspect diff and scope;
8. commit;
9. verify result.

## Remaining open questions

Do not silently resolve:
- exact .ai/INDEX.md contents;
- exact AGENTS.md contents;
- whether a distinct ENTRY.md is ever justified;
- exact command syntax and operation IDs;
- fragment/section ID conventions;
- complete handoff operation vocabulary;
- exact operation-to-commit mapping;
- whether every handoff operation requires a commit;
- long-term handoff retention/archive policy;
- whether TODO should eventually become an independent durable artifact;
- exact long-term .ai/architecture taxonomy;
- whether remaining mixed rule files need another decomposition pass.

ENTRY currently appears unnecessary and is deferred to Iteration 3.

## Historical terms not to reintroduce

- bootstrap kernel as an architecture term;
- SUPERSEDED as a handoff lifecycle state;
- permanent specialization ownership of knowledge;
- autonomous workstream/agent semantics.

MEC/dynamic-context research remains historical context, not current filesystem authority.

## Immediate next chapter task

Start by bootstrapping from the current repository state.

Then continue Iteration 2 only where there is a real unresolved semantic or consistency issue.

The first check should be:

> Are there stale references or duplicated normative instructions left by the restructuring already performed?

Use the post-edit consistency procedure before any new decomposition.

Do not restart the old semantic-comparison stage.

## Migration status

03AW is READY_FOR_HANDOFF.

The receiving chapter should be:

03AX — Architecture & Research

The receiving bootstrap should:
- read this handoff from .ai/handoffs/03/;
- read the updated three architecture files;
- read the current repository rules/lifecycle/workflow as needed;
- verify that 03AW is READY_FOR_HANDOFF;
- transition 03AW to HANDED_OFF;
- create 03AX as DRAFT;
- continue from the current repository state rather than reconstructing 03AU/03AV history.

## Things not to redo

- Do not reconstruct the old 03AU reasoning from chat history.
- Do not restart MEC theory.
- Do not redo the blind Grok/Qwen reviews.
- Do not treat the original v2 target tree as an unexecuted plan.
- Do not restore old docs/ paths that have already moved to .ai/.
- Do not reintroduce PROJECT-INSTRUCTIONS.md as repository path-resolution owner.
- Do not reintroduce SUPERSEDED as a lifecycle state.
- Do not treat workstreams as communicating autonomous agents.
- Do not create a separate ENTRY.md without new evidence.
- Do not create a separate TODO file without a demonstrated ownership need.
- Do not skip the post-edit consistency sweep after structural changes.

## Verification expectation

Before considering the migration complete, verify:
- 03AW status is READY_FOR_HANDOFF;
- the updated architecture files are present at their current .ai/ paths;
- the stale lifecycle path-resolution dependency has been removed;
- the new repository path-resolution ownership is present;
- the consistency procedure is preserved in the architecture record;
- changed-file scope contains only the intended migration-context updates.

