# Server Status

Last live verification: **2026-09-02 05:31 IST**

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
| CT 103 | `minecraft` and `playit` services active; LazyMC listening on TCP 25565. Static address `192.168.1.34`. The same five generic Debian-in-LXC units as CT 100 are failed. |
| CT 104 | Homepage container healthy; Nginx, Avahi, Docker, and `invictine-telemetry.service` active; static address `192.168.1.35`; no failed systemd units. The custom telemetry UI was repaired on 2026-09-02: refreshes no longer overlap, loading/error states are explicit, dense stats no longer wrap incorrectly, and desktop/mobile rendered views were verified. |
| CT 105 | Pi-hole installation complete. FTL active; DNS forwarding and blocking verified; 78,609 blocking domains loaded; dashboard HTTP/HTTPS verified. Static address `192.168.1.36`. Three generic Debian-in-LXC units are failed: `systemd-logind`, `systemd-networkd`, and `systemd-networkd.socket`; Pi-hole components are not among them. Router/client DNS was not changed, so filtering is not network-wide yet. |
| CT 106 | Home Assistant container active via Docker Compose (`host` network mode); persistent storage at `/opt/homeassistant/config`; static address `192.168.1.37`. No failed systemd units. |

## User-facing checks

All verified functional from the management PC on 2026-09-02:

- Proxmox: `https://192.168.1.30:8006/`
- FreshRSS: `http://192.168.1.33/`
- Mass Apply: `http://192.168.1.33:8092/`
- Minecraft: `192.168.1.34:25565` (LazyMC) / `drake-spinal.tun.ply.gg` (Playit)
- Homepage direct: `http://192.168.1.35:3000/`
- Homepage Nginx / friendly: `http://invictine.local/` (`http://192.168.1.35/`)
- Unified Telemetry API: `http://invictine.local/api/telemetry/overview`
- 3D Printer Webcam proxy: `http://invictine.local/printer-camera/`
- Pi-hole: `http://192.168.1.36/admin/`
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
