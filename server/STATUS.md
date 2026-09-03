# Server Status

Last live verification: **2026-09-03 (Asia/Kolkata)**

## Current state

- Proxmox node `invictineserver` is online and single-node.
- Version: Proxmox VE 9.0.11 on Debian 13 (`trixie`); running kernel `6.14.11-4-pve`.
- CTs 100–106 are running. No QEMU VMs are configured.
- Proxmox services `pveproxy`, `pvedaemon`, `pvestatd`, and `pve-cluster` are active. `corosync` is inactive as expected for this single-node setup.
- Root filesystem: 94 GiB usable, 25 GiB used (28%).
- `local-lvm`: 349.17 GiB thin pool, 5.02% data and 0.64% metadata used.
- NVMe SMART overall-health result: `PASSED`.
- Host management link: 1 Gbit/s, full duplex, link detected; Wake-on-LAN remains `g` (magic packet).
- Live host check at 05:21 IST: uptime 8 days 16 hours, load average `0.21 / 0.21 / 0.19`.

## Host health finding

`dkms.service` is the only failed host unit. The established cause is Realtek `realtek-r8125/9.016.01` attempting to install over an existing same-version module. The active onboard management NIC uses in-kernel `r8169` and networking is working. Do not treat this as incidental cleanup.

## Guest/workload verification

| Guest | Verified state |
|---|---|
| CT 100 | Notifier timer active; oneshot service inactive between runs as expected. Static address `192.168.1.31`. Five generic Debian-in-LXC units are failed: `logrotate`, `man-db`, `systemd-logind`, `systemd-networkd`, and `systemd-networkd.socket`. |
| CT 101 | Docker active; `hermes-agent` container up; static address `192.168.1.32`; no failed systemd units. |
| CT 102 | `freshrss`, `rss-leads-ai-filter`, and `rss-leads-mass-apply` containers are up. Scam-check timer runs every 30 seconds. Static address `192.168.1.33`. No failed systemd units. |
| CT 103 | `minecraft` and `playit` services active; LazyMC listening on TCP 25565. Public address `drake-spinal.tun.ply.gg`. At 06:25 IST the gateway reported Paper sleeping, 0 players online, and version 26.2. Static address `192.168.1.34`. The same five generic Debian-in-LXC units as CT 100 are failed. |
| CT 104 | Nginx serves the lightweight telemetry workbench directly at `invictine.local`; Homepage remains healthy and available as the port-3000 fallback. Avahi, Docker, and `invictine-telemetry.service` are active; static address `192.168.1.35`; no failed systemd units. On 2026-09-03 the friendly URL was changed to bypass Homepage's large client bootstrap, use cached local CSS/JS, and defer the printer camera until the initial dashboard has rendered. Chrome `DOMContentLoaded` improved from about 614 ms to 88 ms; the prior custom workbench did not become useful until roughly 1.7 s. The printer and Minecraft detail panels remain live. |
| CT 105 | Pi-hole active with 704,701 unique blocking domains loaded (HaGeZi Multi PRO, OISD Big, Firebog AdGuard/EasyPrivacy, Anudeep Adservers, d3ward suite). FTL optimized with dual upstream parallel queries (`all-servers`), cache size 20,000, 300s min TTL, and 3600s optimistic caching. Avahi mDNS active (`invictinepihole.local`). Note: Client devices must point exclusively to `192.168.1.36` (disabling router IPv6 DNS and browser DoH) to prevent ad-traffic leaks. |
| CT 106 | Home Assistant container active via Docker Compose (`host` network mode); persistent storage at `/opt/homeassistant/config`; static address `192.168.1.37`. No failed systemd units. |

## User-facing checks

All verified functional from the management PC on 2026-09-03:

- Proxmox: `https://192.168.1.30:8006/`
- FreshRSS: `http://192.168.1.33/`
- Mass Apply: `http://192.168.1.33:8092/`
- Minecraft: `192.168.1.34:25565` (LazyMC) / `drake-spinal.tun.ply.gg` (Playit)
- Homepage direct: `http://192.168.1.35:3000/`
- Homepage Nginx / friendly: `http://invictine.local/` (`http://192.168.1.35/`)
- Unified Telemetry API: `http://invictine.local/api/telemetry/overview`
- 3D Printer Webcam proxy: `http://invictine.local/printer-camera/`
- Pi-hole: `http://invictinepihole.local/admin/` (`http://192.168.1.36/admin/`)
- Home Assistant: `http://192.168.1.37:8123/`

## Backups and replication

- Automated host configuration backup is active via `pve-config-backup.timer` (daily at 03:00 IST, `Persistent=true`).
- The latest backup completed successfully at 03:09 IST on 2026-09-02; the next scheduled run is 2026-09-03 at 03:08 IST.
- Captured assets: `/var/lib/pve-cluster/config.db` (atomic SQLite vacuum), `/etc/pve` (all container/VM definitions, storage configs, certificates), `/etc/network/interfaces*`, custom systemd units (including `wol-enp4s0.service`), crontabs, storage/boot configs, and security files into `/var/backups/pve-config/`.
- Retention policy: 30 days retention with guaranteed minimum 7 archives.
- Restore utility: `/usr/local/sbin/pve-config-restore` (supports `list`, `inspect`, `diff`, `extract`, and selective/full `restore` with automatic pre-restore safety snapshots).
- Workstation off-host pull script: `scripts/pull-pve-backup.ps1` (downloads to local `backups/` directory, protected by `.gitignore`).
- Guest disk image backups: No automated `vzdump` cluster jobs configured; one manual CT 103 backup exists (`vzdump-lxc-103-2026_08_24-13_18_45.tar.zst`).

## Firewall

Cluster and node firewall option objects contained only empty digests; no effective cluster/node firewall options were configured in the checked state.
