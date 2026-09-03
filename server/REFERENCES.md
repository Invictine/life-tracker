# Server References

Last updated: 2026-09-02 (Asia/Kolkata)

## Access and endpoints

| Service | Address |
|---|---|
| Proxmox | `https://192.168.1.30:8006` |
| SSH | `ssh invictineserver` |
| FreshRSS | `http://192.168.1.33/` |
| Mass Apply | `http://192.168.1.33:8092/` |
| Minecraft | `drake-spinal.tun.ply.gg` |
| Homepage | `http://invictine.local/` |
| Homepage fallback | `http://192.168.1.35:3000/` |
| Pi-hole | `http://192.168.1.36/admin/` |
| Uptime Kuma | `http://192.168.1.38:3001/` |
| n8n | `http://192.168.1.39:5678/` |
| Obsidian Sync (Syncthing) | CT 109 `192.168.1.40`, GUI `127.0.0.1:8384` (localhost-only until password set) |

Expected SSH ED25519 fingerprint: `SHA256:cjBePBXRZXacsL9jX9pbwRnDT8FrOc2ma+ZQ/zmfi4E`.

## Local project paths

- Server workspace: `C:\Users\aniru\Documents\Server`
- Android app styles: `android/rss-leads/app/src/main/java/com/invictine/leads/ui/` (Heritage Paper, Ember Glass, Factory Terminal, Noir Expressive)
- CT 100 mirror/tests: `C:\Users\aniru\Documents\Server\ct100\rss-leads-discord`
- CT 102 mirror/tests: `C:\Users\aniru\Documents\Server\ct102\rss-leads-stack`
- CT 103 mirror: `C:\Users\aniru\Documents\Server\ct103\minecraft-server`
- CT 104 mirror: `C:\Users\aniru\Documents\Server\ct104\homepage`

## Host read-only checks

```bash
pveversion -v
pvesh get /cluster/status --output-format json-pretty
pvesh get /cluster/resources --output-format json-pretty
pct list
qm list
systemctl --failed --no-pager
lvs -a -o lv_name,vg_name,lv_size,data_percent,metadata_percent,lv_attr
ip -br addr
ip route
bridge link
ethtool enp4s0
pvesh get /cluster/backup --output-format json-pretty
pvesh get /cluster/replication --output-format json-pretty
```

## Guest read-only checks

```bash
pct config 100
pct exec 100 -- systemctl status rss-leads-discord-notifier.timer --no-pager
pct exec 100 -- systemctl status rss-leads-discord-notifier.service --no-pager

pct config 101
pct exec 101 -- systemctl status docker --no-pager
pct exec 101 -- docker ps --filter name=hermes-agent
pct exec 101 -- docker logs --tail 100 hermes-agent

pct config 102
pct exec 102 -- docker-compose -f /opt/rss-leads-stack/docker-compose.yml ps
pct exec 102 -- systemctl list-timers rss-leads-scam-check.timer --no-pager

pct config 103
pct exec 103 -- systemctl status minecraft --no-pager
pct exec 103 -- journalctl -u minecraft -n 100 --no-pager
pct exec 103 -- systemctl status playit --no-pager
pct exec 103 -- ss -lntp

pct config 104
pct exec 104 -- docker-compose -f /opt/homepage/docker-compose.yml ps
pct exec 104 -- docker logs --tail 100 homepage

pct config 105
pct exec 105 -- systemctl status pihole-FTL --no-pager
pct exec 105 -- ss -lntup

pct config 109
pct exec 109 -- systemctl is-active syncthing@obsidian life-tracker-autocommit.timer
pct exec 109 -- su -s /bin/bash obsidian -c 'syncthing --device-id'
pct exec 109 -- journalctl -u syncthing@obsidian --since '30 minutes ago' --no-pager
```

Run `pct exec <id> -- systemctl --failed --no-pager` for the guest being inspected.

## Sensitive paths

- `/opt/rss-leads-stack/.env`
- `/etc/rss-leads-discord-notifier.env`
- CT 105: `/root/.pihole-admin-password`

Never print their values. Inspect variable names only, with values redacted, when absolutely necessary.

## Change validation baseline

After authorized work, verify guest inventory, cluster state, failed units, affected workload state, relevant listeners, recent logs, and the user-facing endpoint. For networking, additionally confirm ports 22 and 8006 are still reachable from the management client.

## Host configuration backup and restore

```bash
# Check timer and scheduled execution
systemctl status pve-config-backup.timer --no-pager
systemctl list-timers | grep pve-config

# Run manual backup
/usr/local/sbin/pve-config-backup

# List and inspect backups
pve-config-restore list
pve-config-restore inspect latest

# Diff backup against live host
pve-config-restore diff latest [network|pve|systemd|cron|all]

# Safe staging extraction
pve-config-restore extract latest /tmp/stage

# Restore subsystem (creates pre-restore safety snapshot automatically)
pve-config-restore restore latest --component=[pve|network|systemd|cron|all]

# Off-host pull from Windows workstation
.\scripts\pull-pve-backup.ps1
```
# Remote connectivity

- Tailscale Debian packages (stable): https://pkgs.tailscale.com/stable/
- Cloudflare Tunnel downloads and connector setup: https://developers.cloudflare.com/cloudflare-one/networks/connectors/cloudflare-tunnel/
