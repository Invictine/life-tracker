# Server Decisions

Last updated: 2026-09-03 (Asia/Kolkata)

## 2026-09-02 — Synchronize every server update with the dashboard

**Status:** LOCKED OPERATIONAL REQUIREMENT

Any server update that changes dashboard-visible state must update the relevant
Homepage/Telemetry representation in CT 104 as part of the same change. The
completion check is the authoritative server state plus the rendered dashboard,
including current labels, values, links, monitors, and health indicators.

When an update is not genuinely dashboard-visible, record that rationale rather
than creating unrelated dashboard UI. Use the canonical Invictine brand kit for
any new dashboard representation.

## 2026-09-03 — Serve the telemetry workbench directly at the friendly URL

**Status:** ACTIVE

`http://invictine.local/` is served by Nginx as a lightweight static shell using
the existing Invictine `custom.css` and `custom.js`. This removes Homepage's
large client bootstrap from the critical rendering path. The printer camera is
deferred until the initial workbench is visible, and third-party web fonts are
not required for first render. Homepage remains running and reachable at
`http://192.168.1.35:3000/` as a fallback and rollback path.

## 2026-07-30 — Single-node Proxmox architecture

**Status:** ACTIVE

Run the home server as one Proxmox node with isolated unprivileged LXCs and no QEMU VMs. `corosync` being inactive is expected. Docker belongs inside specifically configured guests rather than on the host.

## 2026-07-30 — Protect management networking

**Status:** LOCKED SAFETY CONSTRAINT

`vmbr0` on `enp4s0` is the management path. The unexplained `vmbr1` → `enp7s0` mapping must not be reloaded or edited until the missing interface is understood and out-of-band recovery is available.

## 2026-08-03 — Keep Wake-on-LAN persistent

**Status:** ACTIVE

Enable magic-packet Wake-on-LAN for `enp4s0` with a systemd oneshot service. Mains-outage recovery remains a local BIOS concern: Restore AC Power Loss should be Power On; Power On By PCI-E should be enabled; ErP should remain disabled.

## 2026-08-03 — Isolate Hermes in CT 101

**Status:** ACTIVE

Run Hermes Agent inside Docker within CT 101, keep its state in the `hermes-data` volume, pin the official image digest, publish no LAN ports, and deny unknown messaging users by default.

The custom `rss_leads_mcp.py` server is kept in the persistent `/opt/data/mcp/`
path so Hermes can use the leads context without exposing additional LAN ports.

## 2026-08-03 — FreshRSS is the leads system of record

**Status:** ACTIVE

Keep the Invictine Leads stack in CT 102 with FreshRSS as canonical storage and Docker Compose v1 as the deployment interface. The deterministic buyer-intent gate runs before AI scoring. Reddit leads must complete the public-account scam review before appearing in the public priority feed; risk logic may lower/cap priority but never raise it.

## 2026-08-03 — Five-minute Reddit feed cadence

**Status:** ACTIVE

Use a 300-second combined Reddit feed TTL and cap FreshRSS SimplePie `cache_duration_max` at 300 seconds so Reddit's one-hour cache header cannot override the desired cadence.

## 2026-08-24 — On-demand Minecraft through LazyMC and Playit

**Status:** ACTIVE

Keep LazyMC listening on 25565 and stop Paper after five idle minutes. Use Playit for public reachability because the Airtel WAN is behind CGNAT. Keep whitelist plus AuthMe controls for offline-mode access.

## 2026-08-24 — Credentialless home dashboard

**Status:** ACTIVE

Run Homepage in CT 104 behind local Nginx/mDNS. Do not mount the Docker socket or store service credentials in the dashboard. Cloudflare Tunnel/Access remains deferred; `server.invictine.com` is only the intended future hostname.

## 2026-09-01 — Dedicated Pi-hole LXC

**Status:** ACTIVE

Use CT 105 at `192.168.1.36` (migrated from initial `.74`) as a dedicated protected Pi-hole guest, with Cloudflare upstream DNS, LAN-only listening, query logging, the default blocklist, and no Pi-hole DHCP service.

## Product UI — Invictine Leads brand kit

**Status:** LOCKED UNTIL EXPLICIT DESIGN CHANGE

`C:\Users\aniru\Documents\Server\brand\README.md` and its tokens are the cross-platform source of truth. Maintain a compact, calm, human-built workbench/funnel aesthetic and avoid generic AI-product decoration.

## Risky changes require verified backups

**Status:** LOCKED SAFETY CONSTRAINT

Host configuration backups are now automated daily. A single CT 103 manual backup does not protect other guest root filesystems; before destructive, migration, storage, or high-risk configuration work, verify relevant backups.

## 2026-09-01 — Automated Proxmox Host Configuration Backup & Restore

**Status:** ACTIVE

Automate host configuration backups on a daily systemd timer (`pve-config-backup.timer`, 03:00 IST) using `/usr/local/sbin/pve-config-backup`.
- Atomically captures `/var/lib/pve-cluster/config.db` (SQLite `VACUUM INTO`), `/etc/pve` (all CT/VM definitions, `storage.cfg`, `datacenter.cfg`, `user.cfg`, certificates), networking (`/etc/network/interfaces*`), custom systemd units (including `wol-enp4s0.service`), crontabs, storage/boot, security, and metadata into `/var/backups/pve-config/`.
- Enforces a 30-day retention policy while retaining at least 7 archives.
- Maintains `/usr/local/sbin/pve-config-restore` supporting diffing against live state, archive inspection, safe staging extraction, and selective/full subsystem restoration with automated pre-restore safety snapshots.
- Off-host mirroring is supported via `scripts/pull-pve-backup.ps1` to the local workstation with gitignore protection.

## 2026-09-01 — Contiguous Static IP Consolidation

**Status:** ACTIVE

Standardize all homelab infrastructure onto a clean, sequential static IP scheme:
- Host: `192.168.1.30`
- CT 100 (`rss-leads-discord`): `192.168.1.31`
- CT 101 (`hermes-agent`): `192.168.1.32`
- CT 102 (`invictinefeed`): `192.168.1.33`
- CT 103 (`minecraft`): `192.168.1.34`
- CT 104 (`homepage`): `192.168.1.35`
- CT 105 (`pihole`): `192.168.1.36`
- CT 106 (`homeassistant`): `192.168.1.37`
- 3D Printer: `192.168.1.18`

## 2026-09-01 — Unified Telemetry API & Startpage Overlay

**Status:** ACTIVE

Run a Python 3 daemon (`invictine-telemetry.service`) inside CT 104 on port 8000, reverse-proxied via Nginx at `/api/telemetry/`.
- Polls Moonraker, Pi-hole v6, FreshRSS, Proxmox VE (via dedicated read-only audit token `dashboard-ro@pve!telemetry`), and Minecraft with in-memory 5s TTL caching and CORS.
- Proxies Moonraker MJPEG stream at `/webcam/` and HTML5 viewer at `/printer-camera/`.
- Inject a telemetry overlay into Homepage via `custom.js` and `custom.css` adhering to brand tokens.
- The responsive overlay uses a two-column workbench layout, and the Homepage container requires `CAP_NET_RAW` capability for accurate ICMP status pings.

## 2026-09-01 — Dedicated Home Assistant Container (CT 106)

**Status:** ACTIVE

Deploy Home Assistant in an unprivileged Debian 12 LXC container (CT 106) using Docker Compose with `host` network mode (`ghcr.io/home-assistant/home-assistant:stable`).
- Host network mode enables native local discovery (mDNS, UPnP, SSDP).
- Persistent state lives at `/opt/homeassistant/config`. Accessible at `http://192.168.1.37:8123/`.

## 2026-09-03 — Mobile Cache-First Architecture & Animated Onboarding Overhaul

**Status:** ACTIVE

Overhauled the Invictine Leads Android client (`com.invictine.leads`) for instant performance, offline resilience, and fluid motion:
- **Instant Cache-First Engine**: Leads and workspace stages load from local storage (`cached_leads_json` and `native_funnel_state_$userId`) in 0ms on launch, eliminating blocking load screens and connection wait times. Background sync updates data asynchronously.
- **Auto-Migration & Timeouts**: `AppPreferences.serverUrl()` automatically migrates stale LAN addresses (`192.168.1.33:8092`) to Convex (`https://little-monitor-195.convex.site`). Network timeouts shortened from 12-15s down to 4s connect / 6s read.
- **Convex HTTP Router**: `GET /workspace` and `POST /workspace` updated in `ct102/rss-leads-stack/convex/http.ts` to allow direct account access without premature 401 Unauthorized rejections during onboarding.
- **Animated Material 3 Onboarding**: 3-step setup with animated transitions, spring progress bar, interactive role preset chips with instant toggle, portfolio/pitch bento card with auto-fill templates, and visual priority alert selector.
- **Fluid Motion Design**: Spring-backed swipe cards (`SwipeDeck`), tactile button press interactions, and bounded container layouts preventing Compose infinite measurement exceptions.
- **Cold Launch Stability Fix**: Removed `verticalScroll` from `ModernAuthScreen` and migrated `OnboardingFlow` to `Crossfade`. This prevents Clerk's internal `AuthView` animations from measuring against unbounded constraints (`Constraints.Infinity`) which previously caused an immediate startup crash (`Size(870 x 2147483647) is out of range`).
- **Consumer Card & Touch-to-Expand Details**: Redesigned the lead deck card to consume the viewport naturally without empty dead space. Full post content is embedded directly into the card in an expandable container (`animateContentSize()`) that toggles on touch from a 3-line preview to complete body text, scam analysis, and an "Open on Reddit" action.
- **TopAppBar Filter Integration**: Removed the lone `[Threshold: High +]` filter chip row below the top app bar and converted it into an M3 dropdown menu action with an active indicator badge in the top bar.
- **Consumer-Grade Account Sheet**: Removed developer-facing Clerk user IDs, copy buttons, and Convex cloud sync badges from `M3AccountBottomSheet`, displaying only clean user profile info, lead criteria, preferences, and sign out.
- **Centered Stage Empty States**: Replaced off-center empty stage boxes with balanced full-viewport centered layouts containing contextual guidance and a quick "Return to Inbox" action.




