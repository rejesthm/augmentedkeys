# M0 Test and Evidence Strategy

This strategy defines how future AugmentedKeys claims must be supported. It does not record that any listed test has run. Each task or milestone must select the levels required by its risks and acceptance criteria before implementation or evaluation begins.

## Evidence ladder

| Level | Purpose and expected evidence |
| --- | --- |
| Static analysis | Repeatable analyzers, linters, format checks, compiler diagnostics, and configuration checks with command output tied to a commit. |
| Unit tests | Deterministic evidence for isolated logic, boundaries, invalid inputs, lifecycle transitions, and failure paths. |
| Widget/component tests | Deterministic evidence for an isolated UI or other component, including semantics and relevant layout states. |
| Integration tests | Evidence that approved components cooperate across real interfaces and lifecycle events in a defined environment. |
| Audio engine tests | Objective tests of signal behavior, callback health, continuity, configuration, overload, lifecycle, and failure recovery using approved measurement methods. |
| MIDI tests | Timestamped evidence for parsing, routing, timing, mapping, connection lifecycle, error handling, and explicitly supported protocol/controller behavior. |
| UI tests | Evidence for complete user workflows, accessibility, orientation, screen-size behavior, error states, and live-performance interaction requirements. |
| Simulator/emulator tests | Platform-integration evidence in a named simulated environment, explicitly labeled non-physical and limited to what that environment can establish. |
| Physical-device tests | Reproducible evidence on named hardware and OS versions, including relevant audio interfaces and MIDI controllers. |
| Long-run performance tests | Duration-based evidence for stability, callback/underrun health, latency continuity, CPU, memory, battery, thermal behavior, recovery, and regression under a declared workload. |

A lower level cannot substitute for a required higher level. In particular, static, unit, widget, integration, or simulator/emulator results cannot satisfy a physical-device or long-run requirement.

## Required evidence fields

Every evidence record must include:

- **Command/procedure:** exact command or numbered reproducible procedure, including the measurement method.
- **Date:** date and, when timing matters, timestamp with timezone.
- **Commit:** full Git commit SHA of the tested state.
- **Environment:** toolchain, relevant dependency versions, and host conditions.
- **Device:** exact hardware model or `Not applicable`, never an inferred model.
- **OS:** exact operating-system name and version.
- **Simulator/physical status:** `Simulator`, `Emulator`, `Physical device`, or `Not applicable`.
- **Configuration:** build mode plus relevant sample rate, buffer size, workload, connections, permissions, and feature flags.
- **Result:** pass, fail, blocked, or inconclusive against predeclared criteria; include measured values where required.
- **Artifact/log location:** repository path or durable link to raw output, logs, traces, recordings, screenshots, or reports.
- **Reviewer:** named person responsible for checking that the evidence supports the stated claim.

Omitted or unknown fields must be marked explicitly; they must not be guessed.

## Measurement-method rule

Before making a responsiveness, MIDI timing, audio latency, continuity, patch-switch, CPU, memory, battery, thermal, or long-duration stability claim, the task must define:

1. The exact quantity and boundary being measured.
2. The instrument, counter, trace, capture method, or repeatable observation procedure.
3. Calibration, clock alignment, and known measurement error where relevant.
4. Workload, warm-up, run duration, repetitions, and environmental controls.
5. A numeric budget or objective acceptance condition approved for that scope.
6. Required device categories and the reason they are representative.
7. Raw artifact retention and reviewer responsibilities.

Results without an approved method and acceptance condition may identify a question, but they cannot establish completion or architecture suitability.

## Evidence review

The reviewer must confirm that the command or procedure was actually run, the commit and environment match the artifact, failures and exclusions are visible, simulator evidence is not presented as physical-device evidence, and the conclusion is no broader than the tested scope. Re-running a check produces a new evidence record; it does not rewrite history.
