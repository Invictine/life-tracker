# Print Plan

## Material policy
Permanent Mercury/toolhead structural parts should be **ABS or ASA** because the printer is enclosed and intended to print ABS. PLA is acceptable for alignment jigs and temporary tools only.

Use the official ZeroG print orientation/settings for Mercury parts; do not auto-rotate structural STLs.

## Mercury One.1 — structural (ABS/ASA)
Use the official ZeroG Mercury One.1 configurator / current repository rather than random mirrors.

Baseline selections:
- Ender 5 / Ender 5 Pro stock-Z drop-bracket configuration.
- T-nut front tension-plate variant.
- Toothed-idler spacer variant: **TBD after receiving/measuring the 20T toothed idlers**.

Core structural files expected:
- `XJoint_left_bottom.stl`
- `XJoint_left_top.stl`
- `XJoint_right_bottom.stl`
- `XJoint_right_top.stl`
- Ender 5 Pro Z-drop bracket pair
- flange spacer pair
- front tower left/right
- stepper-mount top/bottom left/right
- T-nut tension plate pair
- Y-endstop mount
- rear split-loom arm
- idler spacer set selected after physical idler-height measurement

## Mercury assembly tools — PLA is fine
Print these on the current printer before dismantling:
- rail alignment tool
- left pulley alignment tool
- right pulley alignment tool
- front tower alignment/tooling jig

## E34M1 — ABS/ASA
Chosen concept:
- ADXL345 front
- 2× belt grabbers
- dual-5015 rear inlet, preferably Owl's Eyes/lower-profile variant
- standard lightweight bottom cooling horns
- BLTouch mount
- right-side physical X-endstop / cable-anchor arrangement
- E3D V6-compatible hotend module
- conventional cable guide / umbilical anchor

Exact filenames should be verified against the current E34M1 release before ordering prints because community-module names can change.

## Superfly — ABS/ASA
Using existing BMG internals and existing 35 mm NEMA17.

Expected parts:
- main housing
- back housing
- tensioner
- motor spacer around 5 mm for the ~20 mm shaft, **verify against current Superfly files before final print**
- optional extra-clearance main housing as a backup if printed on a machine with questionable dimensional accuracy

## Custom integration
**Superfly → E34M1 adapter is not currently treated as an official/native E34M1 part.**

Before paying for the full toolhead print batch:
1. Verify whether a maintained EVA3/E34M1-compatible Superfly adapter now exists.
2. If not, create a simple adapter from current E34M1 and Superfly STEP geometry.
3. Bench-test motor/body/hotend clearance before dismantling the printer.

## Suggested structural print settings
For Mercury parts, follow current ZeroG official settings. Current baseline discussed:
- 0.20 mm layer height
- 0.40 mm forced extrusion width
- 4 walls
- 40% infill
- 5 top layers
- 5 bottom layers
- rear seam where specified
- no automatic reorientation

If outsourcing, tell the service to preserve supplied STL orientation unless the official project explicitly instructs otherwise.
