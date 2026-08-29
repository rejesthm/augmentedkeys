# Real-Time Safety Baseline

## Status

This is a baseline constraint and future review checklist. It is not a selected engine design, proof of real-time safety, benchmark result, or approval to implement an audio engine.

## Scope and severity

These constraints apply to any future hard real-time audio callback and to code it invokes directly or indirectly. A violation is high severity because missed callback deadlines can create audible clicks, gaps, instability, or loss of performance continuity. A path that is usually fast is not sufficient: deadline-sensitive work must remain bounded under the supported workload and lifecycle states.

Until evidence establishes a narrower boundary, treat unknown library, platform, plugin, language-runtime, and host behavior reached from the callback as unsafe.

## Prohibited callback operations

The future audio callback must not perform:

- Blocking file, device, database, or other I/O.
- Network access or a wait on network-dependent work.
- User-interface operations or communication that can block on the UI thread.
- Database access.
- JSON or other unbounded parsing.
- Plugin discovery, loading, initialization, or teardown.
- Unbounded or avoidable memory allocation, deallocation, or garbage-collection pressure.
- Arbitrary mutex, monitor, semaphore, condition-variable, or other potentially unbounded lock waiting.
- Logging that allocates, performs I/O, takes an unbounded lock, or can otherwise block.

The prohibition includes hidden work in helpers, framework calls, destructors/finalizers, callbacks, and plugin code.

## Required design properties

- Bound callback work by explicit limits that are connected to supported configurations.
- Preallocate and prepare resources outside the callback where evidence justifies doing so.
- Choose lock-free or demonstrably bounded synchronization from evidence; do not assume that “lock-free” is automatically correct or sufficient.
- Keep configuration, discovery, loading, persistence, telemetry, and user-interface coordination on a non-real-time control plane.
- Prepare samples, patches, plugins, graphs, and other resources asynchronously before they can become callback-visible.
- Define ownership and lifecycle rules so callback-visible memory cannot disappear, mutate unsafely, or trigger cleanup on the callback.
- Degrade safely when work or data is unavailable rather than waiting past the callback deadline.

## Review questions

### Allocation and object lifetime

- Can this path allocate, resize, copy an unbounded collection, release the final reference, invoke a destructor/finalizer, or trigger garbage collection?
- Which buffers and objects are preallocated, what bounds size them, and how is exhaustion handled?
- Can ownership transfer or teardown make callback-visible memory invalid?

### Locking and synchronization

- Can the callback wait for a lock, condition, task, future, thread, process, or platform service?
- Is synchronization lock-free or bounded for a documented reason, and what are its worst-case retries or wait time?
- Are priority inversion, cache contention, and producer overrun behavior measured under load?

### Logging, parsing, and I/O

- Can diagnostics format text, allocate, lock, write, flush, or call operating-system services?
- Can any path reach file, database, device, network, JSON, asset, or plugin-discovery work?
- Are callback diagnostics limited to bounded counters or preallocated event records drained elsewhere?

### Lifecycle and shutdown

- What happens during interruption, route change, backgrounding, controller disconnect, engine restart, resource replacement, and app shutdown?
- Can shutdown or error handling block the callback or free a resource it still uses?
- Is start/stop ordering deterministic and tested for repeated and partial initialization?

### Numerics and workload

- How are denormals/subnormal floating-point values detected or avoided, and is the behavior supported on each target?
- What is the bounded work for silence, maximum polyphony, effects, routing, and worst supported buffer configuration?
- Are overload, starvation, underrun, and recovery behaviors explicit and audible failure modes recorded?

### Plugins and external code

- Which plugin or third-party calls can execute on the callback, and what evidence covers their allocation, locking, timing, and lifecycle behavior?
- How are plugin crashes, stalls, excessive work, state changes, and shutdown isolated or reported?
- Does each platform require a distinct hosting and safety assessment?

## Required evidence

A real-time-safety claim requires evidence appropriate to the risk, including:

- Focused code review tracing the complete callback call graph and lifecycle paths.
- Deterministic tests for bounded queues, resource swaps, overload, interruption, restart, and shutdown behavior.
- Profiling that can expose allocation, blocking, deadline, CPU, and scheduling behavior without treating profiler overhead as production behavior.
- Bounded callback-duration, deadline-miss, and underrun counters that can be captured outside the callback.
- Reproducible physical-device runs on relevant Apple and Android categories, with device, OS, commit, sample rate, buffer, workload, duration, procedure, artifacts, and reviewer recorded.

Static analysis, simulation, unit tests, or a single successful run cannot substitute for required physical-device and long-run evidence. Measurement methods and acceptance budgets must be approved before results are used to select an architecture or declare a milestone complete.
