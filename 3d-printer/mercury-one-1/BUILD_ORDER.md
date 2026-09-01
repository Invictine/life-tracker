# Build Order

## Phase 0 — Hold point
Do **not** dismantle the working Ender 5 Pro yet.
Do **not** cut the rails or X extrusion yet.

## Phase 1 — Prepare parts
1. Order/receive the remaining Mercury-specific hardware.
2. Receive the 20T toothed idlers and measure total flange-to-flange height.
3. Select the correct Mercury idler-spacer variant.
4. Print Mercury alignment/assembly tools in PLA.
5. Obtain permanent Mercury/E34M1/Superfly structural parts in ABS or ASA.
6. Verify the Superfly → E34M1 adapter solution.
7. Install heat-set inserts and dry-fit hardware off the printer.

## Phase 2 — Bench-build toolhead
1. Assemble Superfly with BMG internals.
2. Verify the ~20 mm motor shaft and required spacer geometry.
3. Confirm smooth filament grip/feed by hand.
4. Assemble E34M1 around the V6 ceramic hotend.
5. Fit dual 5015 cooling.
6. Fit BLTouch.
7. Fit ADXL345.
8. Verify nozzle/probe/duct clearances.
9. Plan and pre-build the toolhead umbilical.

## Phase 3 — Prepare machine
1. Record/export current Klipper configuration before modifications.
2. Photograph/label current 4.2.2 wiring and endstop connections.
3. Square the Ender 5 frame by checking diagonals.
4. Add/reposition metal corner gussets as appropriate without interfering with Mercury hardware.
5. Confirm enclosure clearance for towers, belts, and toolhead wiring.

## Phase 4 — Dismantle and cut
Only begin once all essential printed/custom parts are verified.

Planned cuts:
- MGN12H rail #1: 400 → **330 mm**
- MGN12H rail #2: 400 → **330 mm**
- MGN12H rail #3: 400 → **330 mm**
- stock 2020 X extrusion: 400 → **370 mm**

Rail-cut precautions:
- Remove/protect carriages.
- Prevent abrasive chips from entering blocks.
- Deburr carefully.
- Thoroughly clean and relubricate after cutting.

## Phase 5 — Mercury mechanical assembly
1. Install and align the two Y rails.
2. Build rear motor-tower assemblies.
3. Build front tensioner/idler towers.
4. Install X joints.
5. Assemble the 370 mm X beam.
6. Install/align the 330 mm X rail.
7. Mount E34M1/toolhead.
8. Route both CoreXY belts before trimming excess belt.
9. Verify the gantry moves freely by hand over the full usable area.

## Phase 6 — Z/frame reliability work
1. Keep stock single-Z drive.
2. Add bed-carriage braces without constraining Z travel.
3. Verify bed can traverse full Z range without contacting the enclosure or new XY system.

## Phase 7 — Wiring and first power-on
1. Keep Creality 4.2.2 board.
2. Wire A/B CoreXY motors, Z, and extruder.
3. Wire physical X/Y endstops.
4. Wire ceramic hotend heater and thermistor.
5. Wire BLTouch.
6. Wire hotend fan.
7. Wire dual 5015s correctly for their actual voltage; expected 12 V fans require proper conversion and common-ground/PWM arrangement.
8. Keep filament-runout sensor if practical.
9. Inspect all wiring before power-on.

## Phase 8 — Klipper conversion
1. Change kinematics from Cartesian to CoreXY.
2. Start with conservative motion limits.
3. Verify motor directions using tiny low-speed moves.
4. Verify X/Y endstop logic before homing.
5. Configure BLTouch and `probe:z_virtual_endstop` as appropriate.
6. Identify the new hotend thermistor type before setting `sensor_type`.
7. PID-calibrate hotend and bed.
8. Calibrate extruder rotation distance for Superfly/BMG gearing.
9. Calibrate pressure advance.
10. Run ADXL resonance testing and input-shaper calibration.
11. Increase speed/acceleration only after mechanical and thermal reliability are confirmed.

## Initial motion target
A conservative initial target discussed:
- max velocity ~200 mm/s
- max acceleration ~3000 mm/s²
- square corner velocity ~5 mm/s

These are commissioning values, not a promised final tune.
