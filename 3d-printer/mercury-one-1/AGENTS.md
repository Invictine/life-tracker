# AGENTS.md — Mercury One.1

## Project goal
Convert an enclosed Creality Ender 5 Pro running Klipper into a ZeroG Mercury One.1 CoreXY printer optimized for reliability, PLA/ABS printing, easier maintenance, and a moderate performance increase (~50% faster than stock), not extreme acceleration benchmarks.

## Read first
Before advising or modifying this project, read:
1. `BUILD_SPEC.md`
2. `INVENTORY.md`
3. `PRINT_PLAN.md`
4. `BUILD_ORDER.md`
5. `KLIPPER_NOTES.md`
6. `DECISIONS.md`
7. `OPEN_ITEMS.md`

## Project-specific rules
- Keep the Creality 4.2.2 board unless the user explicitly changes that decision.
- Keep stock single-Z and brace the bed; do not plan Hydra unless explicitly revisited.
- Use physical X/Y endstops rather than assuming sensorless homing.
- BLTouch is currently the baseline probe; a future probe change is allowed but not required.
- Permanent Mercury/toolhead structural parts should be ABS or ASA because the printer is enclosed and will print ABS. PLA is acceptable for assembly/alignment tools only.
- Do not cut the 400 mm rails or stock X extrusion until the relevant Mercury parts are printed/verified and the idler spacer variant is known.
- The current rails are 3× MGN12H 400 mm and are planned to become 330 mm each. The stock X extrusion measures 400 mm and is planned to become 370 mm.
- The chosen extruder concept is Superfly using existing BMG internals and a 35 mm NEMA17 with ~20 mm shaft. Expect ~5 mm Superfly motor spacing, but verify against actual Superfly geometry before final print.
- Superfly → E34M1 integration is custom/non-native. Do not claim an official adapter exists unless verified. Treat this as a custom adapter task.
- Required Mercury toothed idlers are still a pending purchase until confirmed received; the user currently owns only smooth/toothless idlers plus F695-type bearings.
- The new hotend is a purchased 24 V 50 W V6-style ceramic assembly with bimetal/all-metal heatbreak and thermistor. Do not assume Klipper thermistor `sensor_type`; identify it before configuration.
- Dual 5015 part cooling is selected. Existing 5015s are believed to be 12 V; use proper voltage conversion and switching rather than blindly feeding 24 V.
- Primary UI is Mainsail.
- Keep filament runout sensor support if practical.

## Update policy
When new measurements, received parts, print completion, or configuration changes occur, update the relevant project Markdown immediately.
