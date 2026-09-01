# Server Open Items

Last updated: 2026-09-01 (Asia/Kolkata)

## High-risk / safety

- **Understand `vmbr1` / `enp7s0`.** The bridge config references an interface that is not visible. Do not reload or edit networking until this is resolved and an out-of-band recovery path exists.
- **Establish backups.** Host configuration backup and restore is active via `pve-config-backup.timer` and `pve-config-restore`. Full guest container disk image backups (`vzdump`) remain unscheduled; decide if scheduled weekly container backups to `/var/lib/vz/dump` are needed.
- **Identify the Realtek DKMS requirement.** `dkms.service` fails on `realtek-r8125/9.016.01` while the active management NIC uses `r8169`. Do not force-install or remove the module without determining the intended hardware and planning for possible network loss.
- **Verify BIOS power recovery locally.** Linux cannot read the required ASUS firmware attributes. Confirm Restore AC Power Loss = Power On, Power On By PCI-E = Enabled, and ErP Ready = Disabled.

## Guest maintenance

- **CT 100:** diagnose current generic failed units (`logrotate`, `man-db`, `systemd-logind`, `systemd-networkd`, `systemd-networkd.socket`) separately from notifier health. (Static IP `192.168.1.31` resolved prior DHCP variance).
- **CT 101:** configure a messaging platform only when desired; unknown users remain denied.
- **CT 102:** `rssbridge` is defined but not running/created; decide whether it is still needed.
- **CT 103:** diagnose the same five generic Debian-in-LXC failed units separately from Minecraft/Playit health.
- **CT 104:** Cloudflare Tunnel and Access are deferred; `server.invictine.com` is not yet the active dashboard address.
- **CT 105:** reserve or exclude `192.168.1.36` in the router's DHCP settings, then configure the router's LAN DNS server as `192.168.1.36` when network-wide filtering is desired. Pi-hole forwarding/blocking is already verified; the router/client DNS cutover was intentionally not made during deployment.
- **CT 105:** three generic Debian-in-LXC namespace-related units are failed (`systemd-logind`, `systemd-networkd`, `systemd-networkd.socket`); do not change container plumbing as incidental Pi-hole cleanup.

## Operational hygiene

- Re-check the live host before relying on this snapshot, especially addresses, guest state, storage utilization, backups, and failed units.
- Preserve secret environment files and keep all credential values out of repositories, logs, and commands shown to the user.
