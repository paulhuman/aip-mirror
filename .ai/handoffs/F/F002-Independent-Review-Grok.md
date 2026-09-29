# Conversation Handoff

**Conversation:**
F002 — Independent Review (Grok)

**Specialization:**
F

**Chapter:**
002

**Previous chapter:**
001

**Status:**
DRAFT

## Current objective

Continue independent external review work from the coherent state handed off by F001. Priority candidates identified by F001: validate/draft minimal AGENTS.md contract (entry-path experiment) or align with current C-series frontier (C027+).

## Completed

1. Bootstrap continuity from F001:
   - Created `.ai/handoffs/F/F002-Independent-Review-Grok.md` as DRAFT.
   - Transitioned F001 READY_FOR_HANDOFF → HANDED_OFF.
   - Post-bootstrap consistency verification passed.

## Current implementation state

No implementation work authorized by this specialization.
Specialization C owns architecture construction.
Paul remains final decision-maker.
Grok is independent external AI architecture reviewer only.
Repository mutations in this specialization follow READ-ONLY path unless human applies proposed content.

## Decisions / research findings (independent review only — not ADs)

Inherited from F001 (do not re-open closed analyses without new evidence):

### Bootstrap kernel

- Permanent semantic kernel (Model A): **FALSIFIED**.
- Initial-condition only + functional property of sufficient active context (Models B+C): **SUPPORTED**.
- Working characterization: necessary non-empty initial context = ordinary knowledge that happens to be active at t₀ and is sufficient to start discovery.

### P-02 / dynamic activation

- Non-empty bootstrap context required.
- Bounded discovery needs accessible information about dormant knowledge.
- That information need not form a separate semantic routing layer.
- MEC remains activation boundary at a reasoning moment.

### Entry layer (Iteration 2)

- INDEX = routing/discovery only: holds.
- Canonical owners retain procedure/normative authority: holds.
- BOOTSTRAP as ordered workflow: justified.
- AGENTS.md empty while architecture claims always-on contract: **critical gap** (primary candidate for F002).
- Soft dual source of command phrases in lifecycle.md vs INDEX: moderate.

### AGENTS.md responsibility

- Smallest correct role: always-on entry-layer operating contract and guardrail.
- Must point to INDEX for command/capability routing.
- Must not contain command tables, capability maps, lifecycle, handoff procedures, commit policy, or path-resolution algorithms.
- Next step: draft minimal AGENTS content and validate with entry-path experiment.

## Open questions

1. Precise minimum ordinary-knowledge set sufficient at t₀ for typical task classes (project-agnostic vs project-specific).
2. Whether AGENTS needs a one-line pointer to `config.yaml` / `repository.md` before INDEX, or INDEX-first is enough.
3. Whether write-capability self-check belongs in AGENTS as universal guardrail or only in mutation skills/workflows.
4. Minimum information a capability description and local applicability surface must each expose without duplication (carried from F000).
5. How far deferred activation can be pushed before rediscovery cost dominates.
6. Controlled Grok↔Qwen comparison (still deferred unless requested).
7. INDEX table scalability beyond ~10–15 entries (presentation pressure, not ownership confusion).

## Current files / relevant references

### Repository identity

- `paulhuman/aip-mirror@main` via `.ai/config.yaml`

### Active infrastructure (must use current paths)

- `.ai/INDEX.md`
- `.ai/AGENTS.md` (empty — design pending)
- `.ai/architecture/ai-infrastructure-restructuring.md`
- `.ai/rules/repository.md`
- `.ai/rules/workflow.md`
- `.ai/rules/commits.md`
- `.ai/rules/handoff/lifecycle.md`
- `.ai/rules/handoff/references.md`
- `.ai/skills/handoff/SKILL.md`
- `.ai/skills/commits/SKILL.md`
- `.ai/workflows/handoff/BOOTSTRAP.md`
- `.ai/handoffs/F/F000-Independent-Review-Grok.md` (HANDED_OFF)
- `.ai/handoffs/F/F001-Independent-Review-Grok.md` (HANDED_OFF)
- `.ai/handoffs/C/C027-Architecture-Research.md` (AGENTS/INDEX frontier on C side)

### Do not use as active owners

- Old paths: `docs/handoffs/`, `.ai/skills/conversation-handoff/`, `.ai/rules/conversation-lifecycle.md`
- Old chapter IDs (`06AA`, `06AB`, `[0-9]{2}[A-Z]{2}`)

## Important constraints

- Independent external reviewer only; not architect, not decision-maker.
- Do not promote review findings to Architecture Decisions.
- Do not invent registry/router/manifest/capability-ID systems.
- Preserve evidence discipline.
- Lifecycle: DRAFT → READY_FOR_HANDOFF → HANDED_OFF.
- Chapter ID format: `[A-Z][0-9]{3}` (this specialization: F).
- Do not restore old handoff structure from conversation memory; repository state is authoritative.

## Evidence / confidence

### Confirmed / observed

- F001 Status was READY_FOR_HANDOFF at bootstrap start; now HANDED_OFF.
- F002 handoff did not exist prior to this bootstrap; now DRAFT.
- AGENTS.md remains empty (title only).
- INDEX is functional router after C027 metadata trim.
- Post-bootstrap consistency verification: passed (F002 DRAFT + Previous=001; F001 HANDED_OFF; consistent pair).

### Inferred

- Minimal AGENTS contract is sufficient to close the progressive-disclosure gap.
- Bootstrap kernel work can stay closed unless new MEC evidence from C reopens it.

### Open

- See Open questions.

## Last completed task

Bootstrap of F002 complete (DRAFT created, F001 HANDED_OFF, post-bootstrap verification passed).

## Immediate next task

Await human direction for substantive review priority:
- validate/draft minimal AGENTS.md contract (entry-path experiment); or
- align with current C-series frontier (C027+).

Do not redo F000/F001 closed analyses unless new evidence requires it.

## Things not to redo

- F000 baseline, dependency stress test, bottleneck audit, Post A/B/C, dynamic context activation.
- Full bootstrap-kernel permanent-component falsification (closed).
- Full Iteration 2 physical restructuring.
- Redesign of INDEX, lifecycle, or BOOTSTRAP without new contradictory evidence.
- Treating Qwen conclusions as premises unless comparison is requested.

## Recommended starting context

1. This handoff
2. `.ai/INDEX.md`, `.ai/AGENTS.md`, `.ai/architecture/ai-infrastructure-restructuring.md`
3. `.ai/rules/handoff/lifecycle.md`, `.ai/skills/handoff/SKILL.md`, `.ai/workflows/handoff/BOOTSTRAP.md`
4. `.ai/handoffs/C/C027-Architecture-Research.md` (or successor)
5. F001 / F000 only if historical baseline detail is needed

## Research references

Internal only; no external research references required for current tasks.
