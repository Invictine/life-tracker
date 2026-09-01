# Decisions Log

## Locked decisions

### Build goal
**Decision:** Reliability-oriented Mercury One.1 conversion with a moderate (~50%) performance increase over stock, not a maximum-acceleration build.

### Mainboard
**Decision:** Keep the Creality 4.2.2 board.
**Reason:** Sufficient for CoreXY A/B + stock Z + extruder and avoids unnecessary electronics work.

### Z system
**Decision:** Keep stock single-Z and brace the bed carriage.
**Reason:** User does not want Hydra/triple-Z complexity.

### Toolhead architecture
**Decision:** Use E34M1 modular toolhead architecture.
**Reason:** Modular/serviceable and compatible with the Mercury ecosystem.

### Extruder
**Decision:** Use Superfly with existing BMG internals and existing 35 mm NEMA17 if fit can be solved cleanly.
**Reason:** Reuses owned hardware and reduces cost.
**Caveat:** Superfly → E34M1 is custom/non-native and must be verified or adapted.

### Hotend
**Decision:** Use purchased 24 V 50 W V6-style ceramic all-metal/bimetal hotend.
**Reason:** Already purchased and appropriate for PLA/ABS.

### Cooling
**Decision:** Dual 5015 part cooling.
**Reason:** Strong cooling for PLA while remaining usable at low/off settings for ABS.

### Probe
**Decision:** BLTouch remains baseline.
**Reason:** Already owned and functional enough; no need to buy another probe now.

### Input shaping
**Decision:** Use owned ADXL345.

### Wiring
**Decision:** Cheap/reliable conventional toolhead umbilical rather than CAN.

### Homing
**Decision:** Physical X/Y microswitches rather than sensorless homing.

### Frame
**Decision:** Add metal corner/gusset reinforcement and bed braces, but avoid overbuilding.

### Build volume
**Decision:** Preserve roughly stock Ender 5 Pro usable XY volume where practical rather than intentionally sacrificing travel.

### Nozzles
**Decision:** Keep nozzles interchangeable; 0.4 mm is already owned, 0.6 and 0.8 mm are useful optional additions.

### Structural print material
**Decision:** Permanent Mercury/toolhead parts should be ABS or ASA; PLA only for tools/jigs/temporary parts.

## Deferred decisions
- Exact toothed-idler spacer variant: waiting on physical idler height.
- Exact Superfly → E34M1 adapter geometry.
- Whether to replace or reuse the current 4010 hotend fan.
- Final tuned speeds/accelerations after ADXL/input-shaper data.
- Exact thermistor `sensor_type` for the purchased ceramic hotend.
