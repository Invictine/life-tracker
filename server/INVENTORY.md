# Server Inventory

Last updated: 2026-09-01 (Asia/Kolkata)

## Proxmox host

- Node/hostname: `invictineserver`
- Platform: single-node Proxmox VE 9.0.11 on Debian 13 (`trixie`)
- Kernel: `6.14.11-4-pve`
- Motherboard: ASUS PRIME A520M-K
- CPU: AMD Ryzen 5 5600, 6 cores / 12 threads
- RAM: 7.6 GiB
- Storage device: ADATA SX8200PNP 476.9 GB NVMe; SMART health `PASSED`
- Root: 96 GB ext4 LV (94 GiB filesystem visible)
- Swap: 7.64 GB LV
- Guest storage: `local-lvm`, 349.17 GiB LVM-thin pool
- `local` storage: `/var/lib/vz` for ISOs, templates, and backups

## Networking

- Management bridge `vmbr0`: `192.168.1.69/24`
- Default gateway: `192.168.1.1`
- Physical management NIC: `enp4s0`, onboard Realtek RTL8111/8168 using `r8169`
- Management MAC: `A0:AD:9F:B9:2B:B5`
- Link observed: 1000 Mbit/s, full duplex
- Wake-on-LAN: magic-packet mode enabled by `/etc/systemd/system/wol-enp4s0.service`; `Wake-on: g` verified 2026-09-01
- Secondary bridge `vmbr1`: `10.10.10.2/24`
- Warning: `vmbr1` declares `bridge-ports enp7s0`, but no `enp7s0` or second Ethernet controller was visible during inventory

Firmware recovery settings cannot be remotely verified. Desired local ASUS BIOS settings:

- Advanced Mode → Advanced → APM Configuration → Restore AC Power Loss: `Power On`
- Power On By PCI-E: `Enabled` for Wake-on-LAN from soft-off
- ErP Ready: disabled

## Guests

All are unprivileged Debian 12 LXCs with host-boot enabled.

| ID | Hostname | CPU | RAM / swap | Root disk | Address |
|---:|---|---:|---:|---:|---|
| 100 | `rss-leads-discord` | 1 vCPU | 256 MiB / 256 MiB | 2 GB | DHCP; `192.168.1.12` observed 2026-09-01 |
| 101 | `hermes-agent` | 2 vCPU | 2 GiB / 512 MiB | 16 GB | `192.168.1.71/24` |
| 102 | `invictinefeed` | 2 vCPU | 2 GiB / 512 MiB | 12 GB | `192.168.1.70/24` |
| 103 | `minecraft` | 2 vCPU | 2304 MiB / 512 MiB | 12 GB | `192.168.1.72/24` |
| 104 | `homepage` | 1 vCPU | 512 MiB / 256 MiB | 6 GB | `192.168.1.73/24` |
| 105 | `pihole` | 1 vCPU | 512 MiB / 256 MiB | 8 GB | `192.168.1.74/24` |

CTs 101, 102, and 104 enable `nesting=1,keyctl=1` for Docker-in-LXC. CT 105 has Proxmox protection enabled.

## CT 100 — Discord lead notifier

- Purpose: poll the FreshRSS low-plus feed and notify a Discord webhook
- Live code: `/opt/rss-leads-discord/notifier.py`
- Live documentation: `/opt/rss-leads-discord/README.md`
- Local mirror/tests: `C:\Users\aniru\Documents\Server\ct100\rss-leads-discord`
- Secret environment: `/etc/rss-leads-discord-notifier.env` (never print values)
- State: `/var/lib/rss-leads-discord-notifier/sent-low-plus-guids.json`
- Unit: `rss-leads-discord-notifier.service`
- Timer: `rss-leads-discord-notifier.timer`, 10 seconds after boot and every 20 seconds
- Notification text includes role mention, priority, likely monthly/hourly compensation, and AI summary so previews are useful; the detailed embed remains below

CT 100 uses DHCP. Its previously observed address was `192.168.1.3`; `192.168.1.12` is the newer observation and should be treated as current but not fixed.

## CT 101 — Hermes Agent

- Purpose: isolated Nous Research Hermes Agent gateway
- Docker runs only inside this guest
- Container: `hermes-agent`, restart policy `unless-stopped`
- Persistent volume: `hermes-data` mounted at `/opt/data`
- Official version recorded: Hermes Agent v0.19.1 (2026.7.30)
- Recorded pinned image digest: `sha256:fc18fcaa234141c9d59e52fb2c4c36cee2171f66a770489377cc660a586fb739`
- Container limits: 1.5 CPUs, 1536 MiB RAM, 2048 MiB memory+swap
- No container ports are published to the LAN
- Convenience wrapper `/usr/local/bin/hermes`; `/usr/bin/hermes` links to it for the reduced `pct enter` PATH
- Gateway and s6 supervision were verified; config schema version 33 validated
- OpenAI Codex OAuth was logged in with `gpt-5.6-terra` selected; a one-shot request returned `HERMES_OK` on 2026-08-03
- No messaging platform is configured; unknown messaging users are denied by default

## CT 102 — Invictine Leads / FreshRSS

- Live directory: `/opt/rss-leads-stack`
- FreshRSS is the system of record
- Docker Compose v1 (`docker-compose` 1.29.2), not the `docker compose` subcommand
- Live directory had no `.git` metadata when inventoried
- Main endpoints: FreshRSS `http://192.168.1.70/`; Mass Apply `http://192.168.1.70:8092/`

Compose services defined: `freshrss`, `ai-filter`, `mass-apply`, and `rssbridge`. Running services observed:

- `freshrss` from `freshrss/freshrss:latest`, exposed on port 80
- `rss-leads-ai-filter` from `rss-leads-ai-filter:latest`, internal port 80 only
- `rss-leads-mass-apply` from `rss-leads-mass-apply:latest`, exposed on port 8092
- `rssbridge` is defined but was not running/created

All three running containers use restart policy `unless-stopped`.

Lead-processing architecture:

- AI classifier entry point: `/opt/rss-leads-stack/scripts/gemini-ai-filter.php`
- Deterministic buyer-intent gate: `/opt/rss-leads-stack/scripts/lib/RssLeads/LeadIntent.php`
- The gate rejects service offers, job seekers, advice/discussion, and ambiguous posts before AI scoring
- Explicit `[Hiring]`, `[Paid]`, `[Task]`, and `[Job]` tags override incidental seller-like wording
- Regression tests mirrored at `C:\Users\aniru\Documents\Server\ct102\rss-leads-stack\tests\lead-intent-test.php`
- Reddit account-aware scam review: `/opt/rss-leads-stack/scripts/lib/reddit-scam-background-check.php`
- `rss-leads-scam-check.timer` runs every 30 seconds in the existing AI-filter container
- Scam review uses public account age/karma plus compensation, post length, and generic/templated wording
- High-risk leads are capped at low priority; medium-risk leads at medium; the checker never raises priority
- Tests mirrored at `C:\Users\aniru\Documents\Server\ct102\rss-leads-stack\tests\scam-risk-test.php`
- FreshRSS tables: `rss_leads_scam_meta`, `rss_leads_reddit_accounts`, and `rss_leads_scam_checks`
- The public priority feed holds newly AI-classified leads until a matching scam review completes
- No Reddit credentials are configured; only public-profile metadata is used
- Combined Reddit source feed TTL is 300 seconds; FreshRSS SimplePie `cache_duration_max` is capped at 300 seconds
- Persistent feed settings: `feeds/reddit-leads.yaml` and `scripts/apply-freshrss-reddit-leads.php`

## CT 103 — Minecraft

- Server: Paper 26.2 build 116 on Amazon Corretto 25
- Service: `minecraft.service` running LazyMC proxy with an on-demand Paper child
- Public/proxy port: TCP 25565; Paper backend `127.0.0.1:25566`
- World/configuration: `/opt/minecraft`
- Internet connectivity: Playit agent because Airtel WAN is behind carrier-grade NAT
- Public address: `drake-spinal.tun.ply.gg`
- Playit SRV endpoint observed at deployment: TCP 61279; clients normally use the hostname without a port
- Offline mode with AuthMe password registration and whitelist enabled
- Whitelisted player: `Invictine`; recorded offline UUID `2d35cf17-ee5f-3dbd-a05a-d043fdde707a`
- Plugins: AuthMe 6.0.0 Paper build and PacketEvents 2.13.0
- AuthMe: forced registration/login, BCRYPT2Y, minimum length 8, three registrations per source IP, sessions disabled
- Premium verification enabled; legitimate players can opt in with `/premium` after first registration
- LazyMC 0.2.11; recorded SHA-256 `9332F3D39FC030CC38E95F636D901404DC1C0CBF41DF809692F3951858D03606`
- Paper saves/stops after five idle minutes; LazyMC stays on 25565 and wakes Paper for a whitelisted join
- LazyMC config: `/opt/minecraft/lazymc.toml`
- Rollback copies: `/etc/systemd/system/minecraft.service.pre-lazymc-20260824` and `/opt/minecraft/server.properties.pre-lazymc-20260824`
- Custom `invictine-heart` datapack creates an animated heart/cherry/arrow/sparkle/infinity installation with `Invictine` and `Anaya` labels near `-105 110 -102`, active only within 128 blocks
- Local mirror: `C:\Users\aniru\Documents\Server\ct103\minecraft-server`

## CT 104 — Homepage dashboard

- Homepage v1.13.2 pinned to amd64 digest `sha256:c881120b024d6a8e2f3c9664efc568984e4352e47df459d6b32e225374c71955`
- Live config: `/opt/homepage/config`
- Direct URL: `http://192.168.1.73:3000/`
- Friendly mDNS/Nginx URL: `http://invictine.local/`
- Intended future hostname: `server.invictine.com`
- Avahi advertises `invictine.local`; Nginx port 80 proxies to `127.0.0.1:3000`
- Dashboard has no service credentials and does not mount the Docker socket
- Cloudflare Tunnel and Cloudflare Access are intentionally not configured yet
- Local mirror: `C:\Users\aniru\Documents\Server\ct104\homepage`

## CT 105 — Pi-hole

- Dedicated Pi-hole DNS sinkhole at `192.168.1.74`
- DNS listeners: TCP and UDP port 53
- Dashboard listeners: HTTP 80 and HTTPS 443
- Pi-hole FTL service active during 2026-09-01 deployment verification
- Unattended configuration selected Cloudflare upstream DNS, LAN-only listening, query logging, the default blocklist, and no DHCP service
- Dashboard: `http://192.168.1.74/admin/`
- Router/client DNS cutover and final blocking validation should be checked in current status before assuming network-wide use
