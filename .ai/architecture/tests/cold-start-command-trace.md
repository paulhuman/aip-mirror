# Test: cold-start command TRACE

## Purpose

This file is a reproducible test instruction for validating the observable repository-read and ACTIVATE behavior of the active `>>` command surface.

The test is intentionally stored as an input scenario rather than as an architectural rule. It can be reused after changes to `.ai/` infrastructure to check whether command routing, activation, and bootstrap behavior still match the intended architecture.

## Scenario

Simulate execution of every currently documented `>>` command from `.ai/INDEX.md`.

For each command, perform a **cold-start simulation**:

1. Assume a completely new chat with no prior chapter context.
2. Start from the repository locator and `.ai/AGENTS.md`.
3. Treat the chat as requiring new-chapter bootstrap initialization.
4. Supply arbitrary valid runtime values for the simulation:
   - `PREVIOUS_CHAPTER`
   - `CURRENT_CHAPTER`
   - `SPECIALIZATION`
   - `SHORT_NAME`
5. Complete the simulated bootstrap initialization.
6. Then execute exactly one selected `>>` command.
7. Show the TRACE for bootstrap and for the selected command.
8. In each TRACE, distinguish:
   - canonical owners reread by ACTIVATE;
   - additional unique repository files actually read during the operation.
9. Do not expose hidden reasoning. Report only observable file reads and activation status.
10. Repeat the entire cold-start simulation independently for every active `>>` command in `.ai/INDEX.md`.

## Commands under test

At the time this test was created, the active command surface is:

- `>>handoff`
- `>>migrate <chapter>`
- `>>generate-bootstrap <chapter>`
- `>>explain-code`

The test MUST derive the command list from the current `.ai/INDEX.md` when it is rerun. Historical command phrases MUST NOT be treated as active commands merely because they appear in architecture history.

## Expected focus

The primary question is:

> Which repository files are read by default when a completely new chat is initialized through BOOTSTRAP and then asks to execute each individual `>>` command?

The test should make the bootstrap read set visible separately from the command read set. Files already read during bootstrap SHOULD NOT be redundantly listed again in the command's `OPERATION READS` section.

Conditional reads should be identified as conditional rather than presented as mandatory defaults.

## Non-goals

This test does not:

- change the command surface;
- introduce a command registry;
- introduce a dependency graph;
- define a new tracing subsystem;
- change ACTIVATE, REFRESH, or TRACE semantics;
- execute repository mutations merely because a command under simulation would normally mutate the repository.

The simulation is a behavioral audit of the current architecture, not a real execution of every command.

## Result recording

The scenario itself SHOULD remain stable so it can be rerun unchanged.

If historical results need to be preserved, store them separately from the scenario under a dedicated results location, for example:

`.ai/architecture/tests/results/<test-name>/<run-id>.md`

A result record should capture the date, repository revision tested, runtime simulation values, observed TRACE, deviations from the expected architecture, and the conclusion.

Do not overwrite the scenario file with test results.

## Pass criteria

A run passes when:

1. every active `>>` command in the current INDEX is tested;
2. each test starts from a fresh bootstrap simulation;
3. bootstrap TRACE is visible;
4. ACTIVATE owners are canonical owners actually reread;
5. `OPERATION READS` contains only additional unique repository files actually read;
6. repeated reads are not duplicated;
7. conditional reads are clearly distinguished from default reads;
8. historical commands are excluded;
9. no new infrastructure is invented merely to perform the test.
