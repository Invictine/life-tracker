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

---

## 2026-09-02 — Material 3 Pixel Style UI (Material You Expressive)

**Status:** ACTIVE

**Decision:** Adopt native Google Pixel Material You (Material 3 Expressive) design language across all activities and composables.

**Reason:**
- Supports Android 12+ dynamic theming (`dynamicDarkColorScheme` / Monet) so the app automatically harmonizes with the user's Pixel wallpaper and system palette.
- Replaced rigid bordered cards with tonal surface elevation hierarchy (`surfaceContainer`, `surfaceContainerHigh`, `surfaceContainerHighest`).
- Implemented signature Pixel elements: At-a-Glance date/status header, large circular progress dial, generous pill-shaped buttons (`RoundedCornerShape(28.dp)`), filter chips, and a minimalist focus-mode lockout screen.

## 2026-09-05 - Restrained native UI refinement

**Status:** ACTIVE

**Decision:** Keep Android Material 3 and dynamic colors, with a simpler typographic balance display, neutral summary rows, consistent shared shapes, and system light/dark mode. Apply Apple accessibility/hierarchy principles and Taste redesign guidance without adopting iOS components.

**Reason:** User requested a more tasteful UI and explicitly supplied all three design skill sources. This refines the earlier expressive Pixel direction; the locked hybrid TickTick integration remains unchanged.
