# ABS Printing — Reliability and Tolerance Plan

Last updated: 2026-09-01

## Goal
Tune the enclosed Ender 5 Pro / Mercury One.1 workflow for:
- low or no warping
- strong inter-layer adhesion with no layer splitting
- repeatable, tight dimensional tolerances for structural/mechanical parts

This is a **tuning plan**, not a locked filament profile. Exact nozzle/bed temperatures must be matched to the specific ABS brand and the installed hotend.

## Current-machine constraints
- Existing wood/acrylic enclosure is available and should be used for ABS.
- PEI spring-steel build surface is installed.
- Current uploaded Klipper configuration uses `max_temp: 260` for the old hotend. Do not use a 260 °C target because normal PID overshoot can exceed the configured maximum and shut Klipper down.
- The purchased V6-style 24 V 50 W ceramic hotend has a bimetal/all-metal heatbreak, but its thermistor type must be identified before installing/configuring it. Re-run PID after installation.
- If the currently installed hotend is still PTFE-lined, do not assume it is suitable for sustained high-temperature ABS printing. Verify the filament path/hotend before increasing temperatures.

## Thermal strategy — highest priority
1. Keep the enclosure fully closed during the print and avoid drafts.
2. Heat-soak the bed/enclosure before probing and printing. Baseline: bring the bed to ABS temperature and allow roughly 15–20 minutes for the machine/chamber to stabilize before final mesh/probing.
3. Measure chamber temperature near print height if possible. A passively heated chamber around 40–50 °C is a useful starting region for conventional ABS; exact needs vary with filament and part size.
4. Do not actively heat the wood/acrylic enclosure without a properly engineered, independently protected chamber-heater system.
5. Ensure the mainboard/PSU are not unintentionally being heat-soaked beyond their safe operating conditions; isolate/move electronics or provide room-air cooling if needed.
6. Keep the enclosure closed after the print and let the part cool gradually before removal.

## ABS filament-profile starting approach
Follow the filament manufacturer's range. For conventional ABS, commonly published manufacturer ranges are roughly:
- nozzle: 245–265 °C
- bed: 90–100 °C (some materials/large parts may benefit from higher within manufacturer guidance)
- part cooling: off for ordinary walls; use only minimal fan where bridges/overhangs actually require it

On the **current old-hotend Klipper configuration**, do not target 260 °C because `max_temp` is also 260 °C. Use a safely lower target compatible with the actual installed hotend and filament, or install/configure the verified all-metal hotend first.

For layer adhesion, prefer the hotter end of the filament's *safe/approved* range and a conservative volumetric flow rather than compensating with heavy part cooling.

## Structural Mercury parts
Follow ZeroG's official geometry-dependent settings:
- first layer height: 0.25 mm
- layer height: 0.20 mm
- extrusion width: 0.40 mm forced
- 4 walls/perimeters
- 40% infill
- 5 top layers
- 5 bottom layers
- seam: rear
- preserve supplied STL orientation; do not auto-rotate
- supports: none unless a specific official part requires otherwise

## Bed adhesion / anti-warping
- Heat-soak before Z offset/mesh and print start.
- Clean PEI thoroughly and avoid touching the print area after cleaning.
- Use a brim or corner ears for long, sharp-cornered ABS parts when needed.
- If adhesion is marginal, use an ABS-compatible build-plate adhesive. On PEI, glue can also act as a release/interface layer depending on surface and filament.
- Do not use strong part-cooling airflow over the first layers.
- Let parts cool inside the closed enclosure rather than opening the door immediately after the print.

## Calibration order for dimensional accuracy
Do not tune X/Y belt `rotation_distance` to compensate for ABS shrinkage. The X/Y motion geometry should remain mechanically correct; material shrinkage belongs in filament/process compensation.

Recommended order:
1. Verify mechanical condition: belts, wheels/rails, frame, bed tramming, Z stability.
2. Calibrate extruder `rotation_distance` using measured commanded extrusion.
3. Temperature calibration for the specific ABS.
4. OrcaSlicer flow-ratio calibration.
5. Klipper pressure-advance calibration for that filament/nozzle/temperature.
6. Establish a conservative max volumetric flow that the hotend can sustain without under-extrusion.
7. Run dimensional/tolerance calibration only after thermal and extrusion behavior is repeatable.
8. In OrcaSlicer use filament XY/Z shrinkage compensation for bulk material shrinkage, then process-level X-Y hole/contour compensation for fit. Use elephant-foot compensation when only the first few layers are oversized.

## Klipper / Orca print-start improvement
For ABS, the current print-start flow should eventually support a deliberate enclosure/bed heat soak **before** the final mesh/probing step. The exact macro change should be made once the desired soak time/chamber-temperature strategy is chosen.

## Diagnostics
### If corners lift / part bows
- increase heat-soak time
- eliminate drafts
- verify bed temperature at the actual surface
- improve first-layer adhesion / brim
- reduce part cooling
- reduce thermal gradients by slowing the print if necessary

### If layers split or the part snaps cleanly along layer lines
- increase nozzle temperature within safe filament/hotend limits
- reduce/disable part cooling
- increase chamber temperature / reduce drafts
- reduce speed or max volumetric flow
- check for intermittent under-extrusion
- dry filament if there are moisture symptoms such as popping/bubbles/rough extrusion

### If outer dimensions are consistently wrong but repeatable
- use Orca filament shrinkage compensation / X-Y contour compensation rather than altering X/Y motion calibration

### If holes are consistently too tight or loose
- use Orca X-Y hole compensation after bulk shrinkage and flow are calibrated

## References
- ZeroG official print settings: https://docs.zerog.one/standard/print/settings
- Klipper pressure advance: https://www.klipper3d.org/Pressure_Advance.html
- OrcaSlicer filament tolerance calibration: https://www.orcaslicer.com/wiki/calibration/tolerance-calib/
- OrcaSlicer precision / XY compensation: https://www.orcaslicer.com/wiki/print_settings/quality/quality_settings_precision
