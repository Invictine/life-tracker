# Klipper Notes

## Existing platform
- Klipper is already running on the Ender 5 Pro.
- Primary interface is Mainsail.
- Mainboard remains Creality 4.2.2.

## CoreXY conversion
The final printer section will change from Cartesian to CoreXY.

Baseline concept:
```ini
[printer]
kinematics: corexy
max_velocity: 200
max_accel: 3000
square_corner_velocity: 5
```
These values are commissioning limits only.

## Motor mapping
Do not assume old Cartesian X/Y direction settings are correct after the conversion.
- Verify A/B CoreXY motor direction with tiny moves.
- Verify both X and Y motion independently before homing.
- Keep physical X/Y endstops.

## Z / probe
- Stock single-Z remains.
- BLTouch remains the baseline probe.
- Z will likely continue using `probe:z_virtual_endstop`.
- Re-run probe offsets and safe-homing setup after toolhead geometry changes.

## Hotend
New hotend is a 24 V 50 W V6-style ceramic assembly with bimetal/all-metal heatbreak and an included thermistor.

Important:
- Do **not** copy the old thermistor `sensor_type` blindly.
- Identify/verify the supplied thermistor model before configuring it.
- Re-run PID tuning after installation.
- Do not set an unnecessarily high `max_temp`; PLA/ABS do not require the seller's claimed maximum temperature.

Example calibration command after correct sensor configuration:
```gcode
PID_CALIBRATE HEATER=extruder TARGET=245
SAVE_CONFIG
```

## Extruder
Superfly uses BMG internals and therefore a geared extrusion path.
- Do not copy the old Ender extruder rotation distance.
- Calculate/measure initial rotation distance for the actual drive gearing and then calibrate by commanded extrusion.
- Re-run pressure advance after final mechanical configuration.

## Cooling
Dual 5015 blowers are believed to be 12 V while the printer is 24 V.
- Verify fan labels before wiring.
- Use proper voltage conversion.
- Preserve PWM control through an appropriate low-side/common-ground arrangement rather than simply putting an unknown buck converter inline with a PWM output.

## ADXL345 / input shaping
- ADXL345 is owned.
- Mount it rigidly to the final toolhead.
- Run resonance testing only after belts, rails, frame, and toolhead are fully assembled and mechanically verified.
- Input shaping should inform final acceleration rather than being used to justify arbitrary high acceleration.

## Filament runout sensor
Keep support if practical. Re-verify its pin/config after wiring changes.

## Backups
Before changing the printer:
1. Save the complete current `printer.cfg` and included macros.
2. Save any KAMP, Mainsail, Obico, runout-sensor, BLTouch, and custom macro configuration.
3. Photograph the current board wiring.
4. Record known-good thermistor and heater settings for the old hotend as historical reference, but do not automatically transfer them to the new hotend.
