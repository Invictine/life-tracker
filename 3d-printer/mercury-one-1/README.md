# Ender 5 Pro → Mercury One.1

## Objective
Convert the existing enclosed Ender 5 Pro from stock Cartesian XY motion to ZeroG Mercury One.1 CoreXY while retaining as much existing hardware as practical.

The target is **reliable PLA/ABS printing with a moderate speed increase**, not an extreme high-acceleration benchmark build.

## Current direction
- Mercury One.1 CoreXY
- Klipper + Mainsail
- Creality 4.2.2 mainboard retained
- Stock single-Z retained and mechanically braced
- E34M1 modular toolhead concept
- Superfly extruder using existing BMG internals
- V6-style 24 V ceramic all-metal hotend
- Dual 5015 part cooling
- BLTouch
- ADXL345 input shaping
- Existing enclosure retained

## Reference files
- [`BUILD_SPEC.md`](./BUILD_SPEC.md) — locked target configuration
- [`INVENTORY.md`](./INVENTORY.md) — owned / ordered / pending parts
- [`PRINT_PLAN.md`](./PRINT_PLAN.md) — Mercury, E34M1, Superfly print plan
- [`BUILD_ORDER.md`](./BUILD_ORDER.md) — staged conversion sequence
- [`KLIPPER_NOTES.md`](./KLIPPER_NOTES.md) — firmware/tuning considerations
- [`DECISIONS.md`](./DECISIONS.md) — why major choices were made
- [`OPEN_ITEMS.md`](./OPEN_ITEMS.md) — unresolved items and next actions

## Important hold point
**Do not dismantle the current printer or cut rails/extrusion yet.** First obtain/print the structural parts, verify the custom Superfly/E34M1 fit, receive and measure the toothed idlers, and bench-build the toolhead.
