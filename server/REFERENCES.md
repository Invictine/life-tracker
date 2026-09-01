# Server References

Last updated: 2026-09-01 (Asia/Kolkata)

## Access and endpoints

| Service | Address |
|---|---|
| Proxmox | `https://192.168.1.69:8006` |
| SSH | `ssh invictineserver` |
| FreshRSS | `http://192.168.1.70/` |
| Mass Apply | `http://192.168.1.70:8092/` |
| Minecraft | `drake-spinal.tun.ply.gg` |
| Homepage | `http://invictine.local/` |
| Homepage fallback | `http://192.168.1.73:3000/` |
| Pi-hole | `http://192.168.1.74/admin/` |

Expected SSH ED25519 fingerprint: `SHA256:cjBePBXRZXacsL9jX9pbwRnDT8FrOc2ma+ZQ/zmfi4E`.

## Local project paths

- Server workspace: `C:\Users\aniru\Documents\Server`
- Brand kit: `C:\Users\aniru\Documents\Server\brand\README.md`
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
```

Run `pct exec <id> -- systemctl --failed --no-pager` for the guest being inspected.

## Sensitive paths

- `/opt/rss-leads-stack/.env`
- `/etc/rss-leads-discord-notifier.env`

Never print their values. Inspect variable names only, with values redacted, when absolutely necessary.

## Change validation baseline

After authorized work, verify guest inventory, cluster state, failed units, affected workload state, relevant listeners, recent logs, and the user-facing endpoint. For networking, additionally confirm ports 22 and 8006 are still reachable from the management client.
