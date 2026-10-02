# Test: cold-start command TRACE

## Purpose

This file defines a reproducible test scenario for validating the observable repository-read and ACTIVATE behavior of the active `>>` command surface.

The scenario MUST remain an input artifact. Test results MUST be recorded separately.

## Scenario

The test MUST simulate execution of every currently documented `>>` command from `.ai/INDEX.md`.

For each command, the test MUST perform an independent **cold-start simulation**:

1. The simulation MUST start from the explicit repository locator and `paulhuman/aip-mirror@main:/.ai/AGENTS.md`.
2. The simulation MUST treat the conversation as a new conversation that has requested new-chapter bootstrap initialization.
3. The simulation MUST supply valid runtime values for:
   - `PREVIOUS_CHAPTER`;
   - `CURRENT_CHAPTER`;
   - `SPECIALIZATION`;
   - `SHORT_NAME`.
4. The simulation MUST execute the applicable BOOTSTRAP procedure.
5. The simulation MUST then execute exactly one selected `>>` command.
6. The simulation MUST show a visible TRACE for bootstrap initialization.
7. The simulation MUST show a TRACE for the selected command.
8. Each TRACE MUST distinguish:
   - canonical owners reread by ACTIVATE;
   - additional unique repository files actually read during the operation.
9. `OPERATION READS` MUST contain only additional unique repository files actually read during that operation and MUST NOT duplicate ACTIVATE owners.
10. Repeated reads MUST be represented once.
11. Conditional reads MUST be identified as conditional and MUST NOT be presented as mandatory default reads.
12. The simulation MUST report observable activation and repository-read evidence only. It MUST NOT expose hidden reasoning.
13. The complete cold-start simulation MUST be repeated independently for every active `>>` command.

### Bootstrap ordering

The simulation MUST preserve the distinction between the chat entry boundary and the BOOTSTRAP workflow:

1. The repository locator MUST establish repository identity.
2. `paulhuman/aip-mirror@main:/.ai/AGENTS.md` MUST be read as the always-on AI entry contract.
3. When new-chapter initialization is requested, BOOTSTRAP MUST apply its canonical repository-identity/path-resolution ordering, including reading `.ai/config.yaml` before resolving further repository-relative paths.
4. The simulation MUST NOT infer repository identity or repository-relative paths from memory, local paths, attachments, or implicit project context.

## Commands under test

The test MUST derive the command list from the current `.ai/INDEX.md` when it is executed.

At the time this scenario was last updated, the active command surface was:

- `>>handoff`;
- `>>migrate <chapter>`;
- `>>generate-bootstrap <chapter>`;
- `>>explain-code`;
- `>><fifth active command>`.

The exact command names and count MUST be obtained from the current `.ai/INDEX.md` at test execution time. The fifth command listed above is a placeholder indicating that the current active surface contains five commands; it MUST NOT be treated as a literal command.

Historical command phrases MUST NOT be treated as active commands merely because they appear in architecture history.

## Expected focus

The test MUST answer:

> Which repository files are read by default when a completely new chat is initialized through BOOTSTRAP and then asks to execute each individual `>>` command?

The result MUST present the bootstrap read set separately from the command read set.

Files already read during bootstrap MUST NOT be redundantly listed again in the command's `OPERATION READS` section.

The result MUST distinguish:

- default reads;
- conditional reads;
- reads required only for verification;
- files read solely to report a completed result.

A repository read made only to report an already-completed result MUST NOT be counted as an operation read.

## Non-goals

The test MUST NOT:

- change the command surface;
- introduce a command registry;
- introduce a dependency graph;
- define a tracing subsystem;
- change ACTIVATE, REFRESH, or TRACE semantics;
- execute repository mutations merely because a command under simulation would normally mutate the repository.

The simulation MUST remain a behavioral audit of the current architecture, not a real execution of every command.

## Result recording

The scenario MUST remain unchanged between test runs unless the test definition itself is intentionally revised.

Historical results MUST be stored separately under:

`.ai/architecture/tests/results/<test-name>/<run-id>.md`

Each result record MUST contain:

- test name;
- run identifier;
- execution date;
- repository revision tested;
- runtime simulation values;
- commands tested;
- bootstrap TRACE;
- command TRACE for each command;
- default reads;
- conditional reads;
- deviations from the expected architecture;
- pass/fail conclusion;
- notes required to reproduce the run.

A result record MUST NOT replace or modify the scenario file.

## Pass criteria

A run PASSES only when:

1. every active `>>` command in the current INDEX is tested;
2. every command test starts from an independent cold-start bootstrap simulation;
3. bootstrap TRACE is visible;
4. ACTIVATE owners are canonical owners actually reread;
5. `OPERATION READS` contains only additional unique repository files actually read;
6. repeated reads are not duplicated;
7. conditional reads are clearly distinguished from default reads;
8. historical commands are excluded;
9. no new infrastructure is introduced merely to perform the test.

If any pass criterion is not satisfied, the result MUST be recorded as FAIL and the deviation MUST be stated explicitly.
