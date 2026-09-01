# Invictine Server

Last updated: 2026-09-01 (Asia/Kolkata)

## Overview

`invictineserver` is a single-node Proxmox VE home server on the LAN. It hosts isolated LXC workloads for the Invictine leads system, Hermes Agent, Minecraft, the home-server dashboard, and Pi-hole.

The live host is canonical. This Life Tracker folder preserves durable architecture, safety constraints, current status, and references; source code remains in its normal repositories/mirrors.

## Canonical locations

- Live host: `root@192.168.1.69` through `ssh invictineserver`
- Proxmox UI: `https://192.168.1.69:8006`
- Local source/documentation mirror: `C:\Users\aniru\Documents\Server`
- Live Invictine Leads stack: CT 102 at `/opt/rss-leads-stack`
- FreshRSS: `http://192.168.1.70/`
- Mass Apply: `http://192.168.1.70:8092/`
- Minecraft: `drake-spinal.tun.ply.gg`
- Homepage: `http://invictine.local/` (fallback `http://192.168.1.73:3000/`)
- Pi-hole: `http://192.168.1.74/admin/`

## Architecture

| ID | Name | Address | Role |
|---:|---|---|---|
| Host | `invictineserver` | `192.168.1.69` | Proxmox VE 9 single node |
| CT 100 | `rss-leads-discord` | DHCP; `192.168.1.12` observed 2026-09-01 | Discord lead notifier |
| CT 101 | `hermes-agent` | `192.168.1.71` | Isolated Hermes Agent gateway |
| CT 102 | `invictinefeed` | `192.168.1.70` | FreshRSS leads, AI filter, scam review, Mass Apply |
| CT 103 | `minecraft` | `192.168.1.72` | On-demand Paper Minecraft through LazyMC/Playit |
| CT 104 | `homepage` | `192.168.1.73` | Homepage dashboard with Nginx and mDNS |
| CT 105 | `pihole` | `192.168.1.74` | Dedicated Pi-hole DNS sinkhole |

All six guests are unprivileged Debian 12 LXCs, configured to start with the host. No QEMU VMs were present on 2026-09-01.

## File map

- `AGENTS.md` — mandatory operating and safety rules
- `STATUS.md` — live-verified present state
- `INVENTORY.md` — host, network, guest, and workload details
- `DECISIONS.md` — durable architecture and product decisions
- `OPEN_ITEMS.md` — unresolved risks, maintenance, and next actions
- `REFERENCES.md` — endpoints, paths, and common read-only checks
