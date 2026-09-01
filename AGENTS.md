# AGENTS.md

## Purpose
This repository is a durable personal project knowledge base. Treat the Markdown files in each project folder as the source of truth for project state, decisions, inventory, and next actions.

## General agent rules
1. Read the nearest project `AGENTS.md`, `README.md`, `BUILD_SPEC.md`, `INVENTORY.md`, `OPEN_ITEMS.md`, and `DECISIONS.md` before making project-specific recommendations.
2. Do not silently overwrite a previously locked decision. If a new recommendation conflicts with a recorded decision, call out the conflict and update `DECISIONS.md` only after the user agrees.
3. Distinguish clearly between:
   - **Owned / verified** hardware
   - **Ordered** hardware
   - **Planned / pending purchase** hardware
   - **Assumed / unverified** hardware
4. Never mark an item as owned just because it was recommended.
5. Record measurements with units and keep the original measurement if a later value supersedes it.
6. For hardware changes, prefer reversible steps and bench testing before dismantling a working machine.
7. For 3D-printer work, do not invent pin assignments, thermistor types, motor currents, or mechanical dimensions. Verify them from the actual hardware/config or authoritative documentation first.
8. Preserve safety-critical notes around heaters, thermistors, wiring, mains power, moving axes, and Klipper limits.
9. When the user reports a purchase, measurement, completed step, or changed decision, update the relevant Markdown file(s) so future sessions have the new state.
10. Keep `OPEN_ITEMS.md` short and actionable. Completed items should be moved into the appropriate permanent reference file rather than left as stale checkboxes.

## Repository structure
- `3d-printer/` — 3D printer projects and reference material.
- Project subfolders should contain their own `README.md` and project-specific `AGENTS.md` when enough context exists.

## Update style
Prefer concise Markdown, tables for inventories/specifications, and explicit status labels such as `OWNED`, `ORDERED`, `PENDING`, `TBD`, and `LOCKED`.
