# FocusLock (Anti-Doomscrolling Android App)

Canonical project path: `C:\Users\aniru\.gemini\antigravity\scratch\focuslock`

## Overview

**FocusLock** is an Android application engineered to eliminate mindless doomscrolling (specifically targeting addictive algorithms in apps like Instagram, YouTube, TikTok, Reddit, and X/Twitter).

Unlike standard screen-time limiters that are easily dismissed, FocusLock binds screen time directly to real-world productivity: **you must earn your leisure screen time by completing and logging work in TickTick**.

## Core Architecture & Mechanism

```
  +-------------------------------------------------------------+
  |                   Doomscroll Interception                   |
  |  AppMonitorAccessibilityService (real-time window watcher)  |
  +------------------------------+------------------------------+
                                 |
         +-----------------------v-----------------------+
         |      Remaining Earned Screen Time <= 0 ?     |
         +---------------+-------------------------------+
                         |
           YES           |           NO
     +-------------------+-------------------+
     |                                       |
+----v--------------------+            +-----v-------------------+
|     BlockerActivity     |            | Decrement Credit Bank   |
| Fullscreen Lockout      |            | (Active session ticker) |
| - Shows work needed     |            +-------------------------+
| - Quick launch TickTick |
| - Verify & Sync work    |
+-------------------------+
```

### Key Components

1. **Accessibility Watchdog (`AppMonitorAccessibilityService`)**:
   - Monitors `TYPE_WINDOW_STATE_CHANGED` events.
   - Detects when blocked apps (Instagram, YouTube, etc.) appear in the foreground.
   - If user has no remaining screen time credits, immediately launches `BlockerActivity` with `FLAG_ACTIVITY_NEW_TASK | FLAG_ACTIVITY_CLEAR_TOP`.
   - If credits exist, actively decrements the balance in real-time while the user is inside the target app.
   - Also detects active focus in TickTick (`com.ticktick.task`) and credits focused time.

2. **TickTick Work Verification (Hybrid Engine)**:
   - **On-Device Notification Listener (`TickTickNotificationListener`)**: Zero-configuration mode. Intercepts local notifications from `com.ticktick.task` (e.g. Pomodoro timer completions, task checkoffs) and instantly credits screen time.
   - **TickTick REST OpenAPI (`TickTickApiClient`)**: Connects to `https://api.ticktick.com/open/v1` using OAuth / Personal Access Token to verify completed tasks and daily logged tasks.
   - **Active Focus Tracking**: Credits active time spent inside TickTick directly.

3. **Credit Bank & Ratio Engine (`CreditBankRepository`)**:
   - **Work-to-Scroll Ratio**: Configurable (default 4:1 — 60 mins of TickTick work unlocks 15 mins of doomscrolling).
   - **Task Checkoff Bonus**: Configurable bonus (default +5 minutes) per completed task.
   - **Midnight Reset**: Automatically refreshes daily consumption metrics while preserving or rolling over earned credits.

4. **UI & Control Center (Jetpack Compose + Material 3)**:
   - **Dashboard**: High-visibility OLED balance circle, today's work vs. scroll metrics, recent TickTick work timeline.
   - **Target App Selector**: Pre-configured with Instagram, YouTube, TikTok, Reddit, Twitter/X; supports toggling any installed app on the device.
   - **Settings & Permission Wizard**: Guided activation for Accessibility, Usage Stats, Notification Listener, and Overlay permissions.
