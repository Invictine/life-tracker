# AGENTS.md — 3D Printer Cloud Context

## Canonical project context
For **any 3D-printer-related conversation**, treat the GitHub repository below as the durable source of truth:

- Repository: `Invictine/life-tracker`
- Project root: `3d-printer/`
- Current Mercury conversion project: `3d-printer/mercury-one-1/`

Before answering substantive questions about the printer, build state, purchases, measurements, wiring, Klipper configuration, printed parts, or next steps, first consult the relevant files under `life-tracker/3d-printer/` when repository access is available.

Do **not** rely on chat memory alone when the repository contains more specific or newer information.

## Continual synchronization rule
This repository is a **living project record** and should be kept synchronized with conversation progress.

Whenever a conversation establishes durable new information, update the appropriate Markdown file(s) in `life-tracker/3d-printer/` before or alongside the final response whenever repository write access is available.

Durable updates include, but are not limited to:

- A part is purchased, ordered, received, returned, replaced, or ruled out.
- A dimension or measurement is taken or corrected.
- A build choice becomes agreed/locked.
- A previous decision is changed.
- A hardware compatibility question is resolved.
- A printed part or STL variant is selected.
- A build step is completed.
- A wiring, pin, motor, thermistor, probe, fan, or Klipper setting is verified.
- A problem is discovered, solved, or becomes an open blocker.
- The user changes priorities such as reliability, speed, material support, budget, or reuse preferences.

Do not clutter the repo with casual speculation, temporary brainstorming, or facts that have not been verified or accepted.

## Files to consult and maintain
For the Mercury One.1 project, prefer these files where present:

- `3d-printer/mercury-one-1/README.md` — project overview and navigation
- `3d-printer/mercury-one-1/BUILD_SPEC.md` — current intended machine specification
- `3d-printer/mercury-one-1/INVENTORY.md` — owned, ordered, pending, and missing parts
- `3d-printer/mercury-one-1/PRINT_PLAN.md` — printed parts, materials, STL variants, print status
- `3d-printer/mercury-one-1/BUILD_ORDER.md` — build sequence and completed stages
- `3d-printer/mercury-one-1/KLIPPER_NOTES.md` — firmware/configuration facts and pending Klipper work
- `3d-printer/mercury-one-1/DECISIONS.md` — agreed design decisions and rationale
- `3d-printer/mercury-one-1/OPEN_ITEMS.md` — unresolved questions and next actions
- `3d-printer/mercury-one-1/AGENTS.md` — project-specific instructions

If a new durable category of information does not fit these files, create a clearly named Markdown reference file rather than overloading an unrelated one.

## State labels
When recording parts or decisions, distinguish explicitly between:

- `OWNED` — physically possessed/verified
- `ORDERED` — purchase placed but not yet received
- `RECEIVED` — delivered and physically present
- `PENDING` — intended purchase/action not yet completed
- `TBD` — unresolved choice or unknown measurement
- `LOCKED` — agreed design decision unless the user later changes it
- `DONE` — completed build/configuration step

Never convert a recommendation into `OWNED`, `ORDERED`, or `LOCKED` unless the conversation actually establishes that state.

## Conflict handling
If current conversation information conflicts with repository state:

1. Prefer the **new explicit user statement** when it is clearly a correction or update.
2. Update the repository to reflect the new state.
3. Preserve meaningful superseded decisions in `DECISIONS.md` when useful rather than silently erasing history.
4. If the conflict is ambiguous, ask before changing a locked or safety-critical fact.

## Safety and verification
For heaters, thermistors, stepper drivers, mains power, PSU wiring, endstops, probes, motor currents, pin assignments, maximum temperatures, and mechanical clearances:

- Never guess when the exact hardware/config can be checked.
- Verify against the actual printer configuration, measured hardware, or authoritative documentation.
- Record verified values in the relevant reference file.
- Treat model numbers, voltages, dimensions, and pin names as exact data, not approximate memory.

## Working style
- Prefer reuse where it matches the recorded build goals.
- Do not recommend performance upgrades merely for benchmark speed when the project files prioritize reliability.
- Bench-test assemblies before dismantling the working printer whenever practical.
- Do not instruct cutting rails/extrusions or permanently modifying hardware until the final dimensions and required printed parts are confirmed.
- Keep `OPEN_ITEMS.md` concise and current.
- Move completed facts out of `OPEN_ITEMS.md` into their durable reference files.

## If GitHub access is unavailable
If the repository cannot be read or updated in a session:

- Continue using conversation context where possible.
- Clearly state that the durable repo could not be synchronized.
- Do not claim that repository files were read or updated when they were not.
- Once access returns, reconcile any durable changes from the conversation into `life-tracker/3d-printer/`.

## Core instruction
**For 3D-printer work: read from `life-tracker/3d-printer/`, use it as canonical project memory, and continuously write durable conversation updates back into it.**
