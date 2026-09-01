# Server Status

Last live verification: **2026-09-01 19:05–19:12 IST**

## Current state

- Proxmox node `invictineserver` is online and single-node.
- Version: Proxmox VE 9.0.11 on Debian 13 (`trixie`); running kernel `6.14.11-4-pve`.
- CTs 100–105 are running. No QEMU VMs are configured.
- Proxmox services `pveproxy`, `pvedaemon`, `pvestatd`, and `pve-cluster` are active. `corosync` is inactive as expected for this single-node setup.
- Root filesystem: 94 GiB usable, 25 GiB used (28%).
- `local-lvm`: 349.17 GiB thin pool, 5.02% data and 0.64% metadata used.
- NVMe SMART overall-health result: `PASSED`.
- Host management link: 1 Gbit/s, full duplex, link detected; Wake-on-LAN remains `g` (magic packet).

## Host health finding

`dkms.service` is the only failed host unit. The established cause is Realtek `realtek-r8125/9.016.01` attempting to install over an existing same-version module. The active onboard management NIC uses in-kernel `r8169` and networking is working. Do not treat this as incidental cleanup.

## Guest/workload verification

| Guest | Verified state |
|---|---|
| CT 100 | Notifier timer active; oneshot service inactive between runs as expected. DHCP address observed as `192.168.1.12`. Five generic Debian-in-LXC units are failed: `logrotate`, `man-db`, `systemd-logind`, `systemd-networkd`, and `systemd-networkd.socket`. |
| CT 101 | Docker active; `hermes-agent` container up for eight days; no failed systemd units. |
| CT 102 | `freshrss`, `rss-leads-ai-filter`, and `rss-leads-mass-apply` containers are up. Scam-check timer runs every 30 seconds. No failed systemd units. |
| CT 103 | `minecraft` and `playit` services active; LazyMC listening on TCP 25565. The same five generic Debian-in-LXC units as CT 100 are failed. |
| CT 104 | Homepage container healthy; Nginx, Avahi, and Docker active; no failed systemd units. |
| CT 105 | Pi-hole installation complete. FTL active; DNS forwarding and blocking verified; 78,609 blocking domains loaded; dashboard HTTP/HTTPS verified. Three generic Debian-in-LXC units are failed: `systemd-logind`, `systemd-networkd`, and `systemd-networkd.socket`; Pi-hole components are not among them. Router/client DNS was not changed, so filtering is not network-wide yet. |

## User-facing checks

All returned HTTP 200 from the management PC on 2026-09-01:

- Proxmox: `https://192.168.1.69:8006/`
- FreshRSS: `http://192.168.1.70/`
- Mass Apply: `http://192.168.1.70:8092/`
- Homepage direct: `http://192.168.1.73:3000/`
- Homepage Nginx: `http://192.168.1.73/`
- Pi-hole: `http://192.168.1.74/admin/`

TCP `192.168.1.72:25565` was reachable.

## Backups and replication

- Automated host configuration backup is active via `pve-config-backup.timer` (daily at 03:00 IST, `Persistent=true`).
- Captured assets: `/var/lib/pve-cluster/config.db` (atomic SQLite vacuum), `/etc/pve` (all container/VM definitions, storage configs, certificates), `/etc/network/interfaces*`, custom systemd units (including `wol-enp4s0.service`), crontabs, storage/boot configs, and security files into `/var/backups/pve-config/`.
- Retention policy: 30 days retention with guaranteed minimum 7 archives.
- Restore utility: `/usr/local/sbin/pve-config-restore` (supports `list`, `inspect`, `diff`, `extract`, and selective/full `restore` with automatic pre-restore safety snapshots).
- Workstation off-host pull script: `scripts/pull-pve-backup.ps1` (downloads to local `backups/` directory, protected by `.gitignore`).
- Guest disk image backups: No automated `vzdump` cluster jobs configured; one manual CT 103 backup exists (`vzdump-lxc-103-2026_08_24-13_18_45.tar.zst`).

## Firewall

Cluster and node firewall option objects contained only empty digests; no effective cluster/node firewall options were configured in the checked state.
