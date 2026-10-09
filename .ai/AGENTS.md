# AI agent instructions

1. Treat `.ai/` as AI working infrastructure and `docs/` as project
   knowledge. Establish repository identity and path context from
   `.ai/config.yaml`; DO NOT infer conventions from memory.

2. For AI-infrastructure operations, use `.ai/INDEX.md` as the operational
   router and capability map. INDEX routes to canonical owners; it does not
   replace them.

3. Before mutating repository state, read the current source files from the
   repository. DO NOT reconstruct existing content from memory. Preserve
   unrelated content and make only the intended change.

4. After a mutation, read the resulting file back and independently verify
   its content. Before treating the change as ready, inspect the diff and
   verify the changed-file scope. A successful API write or valid commit is
   not proof of correct content; do not claim success without evidence.

5. For project work, read `docs/PROJECT-INSTRUCTIONS.md` and follow its
   routing to canonical project sources.

6. Re-read the canonical skill, workflow, or project source that owns the
   operation before executing it. Follow its mutation and verification
   requirements when repository state will change.
