# Project architecture rules

These rules define the architectural boundaries of AIP Mirror.

## 1. JSX prototype is not production code

The JSX prototype exists to discover, test, and validate behavior.

It is an executable reference implementation.

Do not assume that the JSX architecture should be directly translated into the native plugin architecture.

The native implementation should be designed from the validated behavior and specifications.

## 2. Native implementation is C++ + Illustrator AIP

The production plugin is a native Adobe Illustrator plugin implemented using C++ and the Illustrator AIP SDK.

The Illustrator SDK is the canonical API reference.

## 3. Keep core logic independent from Illustrator where practical

Project-owned geometry, reflection, transformation, and behavioral logic should remain as independent from Illustrator-specific SDK types as reasonably possible.

Illustrator-specific integration belongs at the plugin boundary.

## 4. Geometry is a first-class subsystem

Reflection and transformation mathematics should be treated as project-owned logic.

Geometry code should be deterministic, independently testable, documented, and usable without a running Illustrator instance where practical.

## 5. Behavior precedes implementation

When reproducing FreeHand MX or other reference behavior:

    observation
        ↓
    documented finding
        ↓
    specification
        ↓
    implementation

Do not silently turn an observed behavior into an undocumented architectural assumption.

## 6. Separate research from specification

Research documents record what was discovered.

Specification documents define what AIP Mirror should do.

Implementation documents explain how the current code achieves it.

Keep these concerns distinct.

## 7. Prefer incremental native implementation

The native plugin should initially prioritize plugin lifecycle, Illustrator integration, interactive mouse handling, mirror-axis interaction, live preview, geometry, path/object handling, undo/cancel behavior, and basic tool functionality.

UI polish and advanced presentation should not unnecessarily block the core interactive engine.

## 8. Do not introduce web technology without a requirement

CEP, UXP, embedded browser technology, or a custom web/native bridge must not be introduced merely because a web-based UI is available.

AIP Mirror can have a native C++/ADM implementation without CEP or UXP.

If a web UI becomes desirable later, treat it as a separate architectural decision.

## 9. Preserve the intended interaction model

The project aims to reproduce an interactive mirror workflow rather than merely provide a static mirror command.

The desired behavior includes an interactively positioned mirror axis, live reflected preview, flexible source-side behavior, and the ability to draw across the mirror axis when appropriate.

Exact behavior must be validated experimentally and documented before being considered final.

## 10. Avoid premature abstraction

Do not create abstractions solely because they might become useful later.

Introduce abstractions when a real duplication exists, a boundary is technically meaningful, testing benefits from the abstraction, or the architecture requires it.

## 11. Experiments are disposable

Experimental code may live under `experiments/` when that directory exists.

Experimental code is not automatically production-quality code.

When an experiment is validated, move or rewrite the useful result into the appropriate production location.

## 12. Tests should follow architectural boundaries

Where practical, maintain separate testing levels:

- pure geometry tests
- mirror behavior tests
- Illustrator integration tests

Do not require Illustrator to test mathematical operations that can be tested independently.

## 13. Preserve the conversation specialization boundaries

The project uses three complementary specializations:

- `AIP Mirror — 01 — JSX Prototype`
- `AIP Mirror — 02 — Native AIP Plugin`
- `AIP Mirror — 03 — Architecture & Research`

The current chapters use the `A` suffix, and later chapters advance alphabetically within the same specialization.

The roles are complementary, not competing.

Architecture decisions that affect multiple areas should be documented in the repository so they are not dependent on conversation history alone.
