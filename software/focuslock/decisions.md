# FocusLock Decisions

## 2026-09-02 — Hybrid TickTick Verification Model

**Status:** LOCKED

**Decision:** Support both on-device notification interception (`NotificationListenerService`) and official TickTick OpenAPI REST client.

**Reason:**
- The TickTick OpenAPI requires developer portal registration and OAuth/token handling, which creates setup friction.
- The on-device `NotificationListenerService` requires zero external setup: users simply use TickTick on their phone normally, and when TickTick posts a Pomodoro or task completion notification, FocusLock credits screen time automatically.
- Offering both gives zero-setup convenience by default, with an optional OpenAPI token for background cloud sync.

---

## 2026-09-02 — Fullscreen Activity Interstitial vs. System Overlay

**Status:** ACTIVE

**Decision:** Use a dedicated `BlockerActivity` with `FLAG_ACTIVITY_NEW_TASK | FLAG_ACTIVITY_CLEAR_TOP | FLAG_ACTIVITY_REORDER_TO_FRONT`, complemented by `SYSTEM_ALERT_WINDOW`.

**Reason:**
- System alert overlays can sometimes be glitchy across vendor-specific Android skins (MIUI/OneUI/ColorOS) or Android 12+ overlay restrictions.
- An Activity launched by Accessibility Service is natively handled by the Android window manager, cannot be dismissed by back gesture without going home, and provides a full Jetpack Compose layout with direct intent dispatching to TickTick.

---

## 2026-09-02 — Credit Banking Math & Midnight Rollover

**Status:** ACTIVE

**Decision:** Track credits in seconds for sub-minute accuracy, expose to user in minutes. Default ratio is 4:1 (60 min work = 15 min scroll) plus a +5 min bonus per completed task. Daily usage stats reset at midnight, but earned balance is retained to reward accumulated productivity.
