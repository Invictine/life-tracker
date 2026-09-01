# AGENTS.md — Invictine Server Operations

Last updated: 2026-09-02 (Asia/Kolkata)

## Purpose and sources

This folder is the durable operating context for the Proxmox host named `invictineserver` and its guests.

- The live server is the source of truth. Re-check current state before making decisions.
- The local source/documentation mirror is `C:\Users\aniru\Documents\Server`.
- Read this file first, then `STATUS.md`, and only the workload sections relevant to the task in `INVENTORY.md`, `DECISIONS.md`, `OPEN_ITEMS.md`, and `REFERENCES.md`.
- The snapshot in this folder was live-verified on 2026-09-02. Earlier facts may be explicitly dated.

## Mandatory dashboard synchronization

Every server update must include the relevant dashboard update in the same
change. Treat this as part of completion, not an optional follow-up.

- Before changing a host, guest, service, endpoint, address, capacity,
  backup/monitoring state, or other user-visible behavior, identify the
  affected Homepage card, telemetry field, link, monitor, or dashboard status.
- Update the corresponding CT 104 Homepage/Telemetry source when the change
  affects dashboard-visible state. If the dashboard has no suitable
  representation, add the smallest relevant one using the canonical Invictine
  brand kit rather than leaving the change invisible.
- Verify both sides after the change: the authoritative server state and the
  rendered dashboard. Check that labels, values, links, and health indicators
  reflect the new state and that no stale address or status remains.
- For availability checks, prefer the service's HTTP/API health or Homepage
  `siteMonitor`; do not rely on container ICMP alone. For telemetry changes,
  verify the live endpoint and the rendered value.
- If an update is genuinely not dashboard-visible, record that rationale in
  the change notes instead of making an unrelated dashboard alteration.

## Access

- Proxmox UI/API: `https://192.168.1.30:8006`
- SSH: `root@192.168.1.30:22` through the passwordless alias `ssh invictineserver`.
- Dedicated key: `C:\Users\aniru\.ssh\id_ed25519_invictineserver`; never copy or commit it.
- Proxmox realm: `root@pam`.
- Expected ED25519 host-key fingerprint: `SHA256:cjBePBXRZXacsL9jX9pbwRnDT8FrOc2ma+ZQ/zmfi4E`.
- Obtain passwords/tokens only from the user or session secret source. Never store credentials, tickets, CSRF tokens, webhook URLs, API keys, or environment-file contents here.

## Mandatory safety rules

1. Start with read-only inspection. Diagnose/inspect requests do not authorize changes.
2. Never delete or recreate guests, disks, storage, backups, bridges, firewall rules, or cluster configuration without explicit authorization.
3. Before networking, firewall, storage, boot, kernel, DKMS, cluster, or guest-resource changes, explain impact and establish rollback. Preserve an out-of-band recovery path for networking.
4. Before stopping or restarting a guest/workload, confirm scope and inspect active tasks and service state.
5. Host configuration backups run daily via `pve-config-backup.timer`, but there are no scheduled guest disk backups or replication jobs. Only one manual CT 103 backup was present on 2026-09-01; arrange and verify relevant guest backups before destructive or migration work.
6. Never read or print `/opt/rss-leads-stack/.env`, `/etc/rss-leads-discord-notifier.env`, or CT 105's root-only `/root/.pihole-admin-password`. If needed, inspect environment variable names only and redact values.
7. Use `Asia/Kolkata` for schedules and timestamps.
8. Verify the SSH host key before trusting a new or changed key.

## Network-specific warning

`/etc/network/interfaces` assigns nonexistent or unobserved `enp7s0` to `vmbr1`. Do not edit or reload host networking until this stale mapping is understood and recovery access is available. After an authorized network change, verify addresses, routes, bridges, listeners, cluster state, and reachability of ports 22 and 8006 from the management client.

## Workload rules

- CT 102 live stack changes must begin in `/opt/rss-leads-stack`; read its live `AGENTS.md` first, preserve `.env`, inspect the Compose diff, and use Docker Compose v1 (`docker-compose`). Do not pull `latest`, rebuild, recreate, or restart unless required.
- The CT 102 live directory had no Git metadata when inventoried; do not assume edits are versioned or trivially reversible.
- Do not force-install or remove the failed Realtek DKMS module as incidental cleanup. Establish which hardware/driver needs it and plan for network loss first.
- Treat Docker as guest-local: it runs inside CTs 101, 102, and 104, not on the Proxmox host.

## Product brand system

For Invictine Leads dashboard, Android, notification, or product-copy changes, read the local canonical brand kit at `C:\Users\aniru\Documents\Server\brand\README.md`. Reuse `brand/tokens.json` and `brand/tokens.css`. The UI should be a compact, calm, structured funnel/workbench; avoid neon gradients, glassmorphism, glowing cards, excessive pills, ornamental copy, and gratuitous animation.

## Validation after authorized changes

Run checks proportional to the change and report commands plus results. Every
update must also verify the affected Homepage/Telemetry card or status in the
rendered dashboard, not just its YAML, API response, or source files.

General minimum:

```bash
pct list
qm list
pvesh get /cluster/status --output-format json-pretty
systemctl --failed --no-pager
pct exec 102 -- docker-compose -f /opt/rss-leads-stack/docker-compose.yml ps
```

Also verify relevant HTTP endpoints/listeners, inspect recent service logs, and confirm no new failed units appeared. Never claim success only from a command exit code when a user-facing service can be tested directly.
