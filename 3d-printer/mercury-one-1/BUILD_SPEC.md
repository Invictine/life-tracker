# Build Specification

Status: **LOCKED baseline**, subject to explicit future changes.

| System | Selected configuration |
|---|---|
| Base printer | Creality Ender 5 Pro |
| Enclosure | Existing wood/acrylic enclosure |
| Kinematics | ZeroG Mercury One.1 CoreXY |
| Firmware/UI | Klipper + Mainsail |
| Mainboard | Creality 4.2.2 |
| X/Y rails | 3× MGN12H, currently 400 mm; planned 330 mm each |
| X beam | Reuse stock 2020 extrusion, currently 400 mm; planned 370 mm |
| XY motors | Existing 17HS4401-class NEMA17 motors |
| Belts | 6 mm GT2, ~5 m on hand |
| XY motor pulleys | 20T, 5 mm bore |
| Idler system | F695 bearing stacks + 2× 20T toothed GT2 idlers |
| X/Y homing | Physical microswitch endstops |
| Z | Stock single-Z retained |
| Bed | PEI spring steel, stock carriage with reinforcement braces |
| Probe | BLTouch baseline |
| Input shaping | ADXL345 |
| Toolhead | E34M1 modular architecture |
| Extruder | Superfly using BMG internals |
| Extruder motor | Existing 35 mm NEMA17, ~20 mm shaft |
| Hotend | 24 V 50 W V6-style ceramic hotend, bimetal/all-metal heatbreak |
| Nozzles | 0.4 mm owned; 0.6 / 0.8 mm desirable for larger/faster parts |
| Part cooling | Dual 5015 |
| Hotend cooling | 4010 axial fan |
| Wiring | Cheap/reliable conventional umbilical, no CAN required |
| Filament sensor | Keep existing runout sensor if practical |
| Spool | Outside enclosure |
| Main materials | PLA + ABS |
| Performance target | Reliability first; ~50% faster than stock, moderate acceleration |

## Intended operating philosophy
This build is not intended for 15k–20k mm/s² acceleration or speedboat-style tuning. Initial post-conversion limits should be conservative, then increased using measured resonance/input-shaping data and actual extrusion-flow capability.

A reasonable starting point after mechanical verification is approximately:
- `max_velocity`: 200 mm/s
- `max_accel`: 3000 mm/s²
- `square_corner_velocity`: 5 mm/s

These are starting values only, not final tuned values.
