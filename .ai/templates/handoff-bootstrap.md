# Manual bootstrap templates

These templates are for **human users** who need to copy/paste a bootstrap instruction manually.

They are not AI-generated transport. AI-generated bootstrap transport is owned exclusively by `.ai/workflows/handoff/BOOTSTRAP.md`.

## Template A — first chapter

    Initialize a new conversation chapter for the repository:
    https://github.com/paulhuman/aip-mirror

    Follow the new-chapter initialization procedure specified by `.ai/AGENTS.md`, item 6, and use `.ai/workflows/handoff/BOOTSTRAP.md` as the canonical chat-initialization workflow.

    PREVIOUS_CHAPTER = N/A
    CURRENT_CHAPTER = <four-digit chapter>
    SPECIALIZATION = <single uppercase specialization letter>
    SHORT_NAME = <short conversation name>

## Template B — interrupted migration recovery

    Initialize a new conversation chapter as a recovery from an interrupted migration for the repository:
    https://github.com/paulhuman/aip-mirror

    Follow the new-chapter initialization procedure specified by `.ai/AGENTS.md`, item 6, and use `.ai/workflows/handoff/BOOTSTRAP.md` as the canonical chat-initialization workflow.

    PREVIOUS_CHAPTER = <four-digit previous chapter>
    CURRENT_CHAPTER = <four-digit current chapter>
    SPECIALIZATION = <single uppercase specialization letter>
    SHORT_NAME = <short conversation name>

If `SHORT_NAME` is omitted from a manual bootstrap message, BOOTSTRAP MUST resolve it from `.ai/config.yaml` through:

    SPECIALIZATION → specializations.<SPECIALIZATION>.short_name

If `SHORT_NAME` is supplied, BOOTSTRAP uses the supplied value unless it is malformed or unusable. If no supplied or configured short name is available, BOOTSTRAP MUST stop and report the unresolved value rather than guessing.

The canonical bootstrap runtime contract remains exactly:

    PREVIOUS_CHAPTER
    CURRENT_CHAPTER
    SPECIALIZATION

`SHORT_NAME` remains contextual data rather than a fourth canonical runtime input.
