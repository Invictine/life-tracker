# AGENTS.md — Life Tracker Persistent Shared Context Protocol

Canonical repository: **https://github.com/Invictine/life-tracker**

## Purpose

This repository is my canonical, durable, cross-AI knowledge base and persistent memory.

Treat `life-tracker` as the source of truth for durable information about my life, projects, work, studies, systems, hardware, plans, decisions, configurations, purchases, responsibilities, references, and other useful long-term context.

The purpose of this repository is to let different AI agents, conversations, IDEs, ChatGPT Projects, Claude Projects, Codex sessions, Gemini, Hermes, and other tools share context without depending on any one AI provider's built-in memory.

The repository should gradually become a structured external memory and operating system for my life.

The goal is that I should be able to start a new conversation with any capable AI tool, give it access to this repository, and have it rapidly understand the relevant context, continue existing work, and leave the repository more accurate than it found it.

---

# Core Rule

Whenever you are working with me, actively use `life-tracker` as persistent memory.

Before doing substantial work:

1. Locate or access `https://github.com/Invictine/life-tracker`.
2. Read this root `AGENTS.md`.
3. Determine which existing project, area, or subject is relevant.
4. Read the relevant Markdown files and the nearest project-specific `AGENTS.md` if one exists.
5. Search for the topic/project currently being discussed.
6. Use that information as context instead of asking me to repeat information that is already documented.

After substantial work:

1. Identify new durable information learned during the conversation or work session.
2. Update the relevant files in `life-tracker`.
3. Create new files or folders when necessary.
4. Keep existing information updated when plans, decisions, configurations, statuses, measurements, purchases, or facts change.
5. Prefer modifying canonical current-state information rather than endlessly appending notes.

Do this proactively when repository write access is available. I should not have to explicitly say **"update life-tracker"** every time.

---

# Persistent-Memory Loop

For every substantial session, internally follow:

**LOAD → WORK → EXTRACT → UPDATE**

## LOAD

Read the relevant `life-tracker` context before making recommendations or changes.

At minimum:

- read this root `AGENTS.md`
- identify the nearest relevant project/area
- read its local `AGENTS.md` if present
- read the most relevant canonical Markdown files

Do not read the entire repository unnecessarily. Retrieve the context relevant to the current task.

## WORK

Perform the actual requested task using the loaded context.

Existing recorded facts, decisions, configurations, constraints, and status should inform recommendations.

## EXTRACT

Before finishing substantial work, identify what was learned that has future value.

Examples:

- a new decision
- a purchase
- a changed status
- a measurement
- a solved problem
- a failed approach
- a configuration change
- a new project
- a deadline
- a useful external reference
- an important preference
- a new dependency or blocker

## UPDATE

Merge those durable facts into the appropriate canonical files.

Routine Life Tracker updates do not need to dominate the conversation. Do not repeatedly announce every small context write unless it matters to the user's task or the user asks to see the changes.

---

# Project Detection

Whenever a conversation, workspace, or task clearly concerns a specific project, determine whether that project already has a folder inside `life-tracker`.

If it exists, use and update it.

If it does not exist, create an appropriately named project folder when the topic represents an ongoing project, system, responsibility, subject, or area that is likely to be useful again.

Examples:

```text
life-tracker/3d-printer/
life-tracker/life-automation/
life-tracker/video-projects/jackie-droujko/
life-tracker/school/physics/
life-tracker/software/<project-name>/
```

Do **not** create a new project folder for every tiny conversation, one-off question, or transient idea.

Prefer extending an existing folder over creating near-duplicates such as:

```text
3d-printer/
3dprinting/
printer-project/
ender5-project/
```

when one existing canonical project folder would suffice.

---

# AI Project / Workspace Detection

If the current conversation is inside an AI **Project**, workspace, repository, working directory, or similarly scoped environment, treat that scope as a strong signal that it represents an ongoing project.

At the beginning of work:

1. Determine the current project's subject or name.
2. Look for a matching folder in `life-tracker`.
3. Read its durable context before proceeding.
4. If none exists and the project is substantial enough to persist, create one.

Continuously synchronize useful durable information learned inside that AI Project back into the corresponding `life-tracker` folder.

The AI Project's local files/instructions may contain temporary working context.

`life-tracker` should contain the durable knowledge that should survive outside that specific AI platform.

If the project has its own source-code repository, keep source code in that repository and keep durable personal/project context in `life-tracker`.

---

# Recommended Project Structure

For substantial projects, prefer a structure similar to:

```text
life-tracker/
  <project>/
    AGENTS.md
    README.md
    status.md
    decisions.md
    todos.md
    references.md
    notes/
```

Existing projects may use uppercase equivalents such as `BUILD_SPEC.md`, `INVENTORY.md`, `OPEN_ITEMS.md`, or `DECISIONS.md`. Preserve existing conventions unless there is a good reason to change them.

Not every project needs every file. Keep small projects simple.

## `README.md`

Use as the project's primary human-readable context document.

Include things such as:

- what the project is
- goals
- architecture
- important constraints
- relevant hardware/software
- terminology
- important links
- key background information
- project scope
- how an AI agent should approach the project

## `status.md` / `STATUS.md`

Maintain the current state of the project.

Useful sections include:

- Current State
- Completed
- In Progress
- Blocked / Waiting
- Next Steps
- Pending Purchases
- Known Problems

This should represent the **present state**, not become an endless chronological diary.

## `decisions.md` / `DECISIONS.md`

Record important decisions and, where useful, the reasoning behind them.

Examples:

- technology choices
- hardware choices
- abandoned approaches
- architecture decisions
- workflow decisions
- purchases
- project direction changes

This prevents future agents from repeatedly reconsidering already-settled questions without context.

When a decision is explicitly marked `LOCKED`, do not silently overturn it. If new evidence suggests it should change, identify the conflict and seek user approval before changing that locked decision.

## `references.md` / `REFERENCES.md`

Store useful:

- links
- documentation
- repositories
- products
- external resources
- file locations
- commands
- reference configurations

## `todos.md` / `OPEN_ITEMS.md`

Use for project-specific actionable tasks when keeping them here is useful.

Keep these files short and actionable.

Completed items should generally be removed from the active task list and, if the completion carries durable knowledge, merged into the appropriate status/reference/decision file instead of accumulating stale checked boxes forever.

## `INVENTORY.md`

For hardware-heavy projects, keep a clear inventory when useful.

Distinguish between:

- `OWNED`
- `ORDERED`
- `PENDING`
- `TBD`
- `ASSUMED / UNVERIFIED`

Never mark an item as owned merely because it was recommended.

---

# Global Life Information

Not everything belongs to a project.

Maintain sensible top-level areas for recurring parts of life when useful, for example:

```text
life-tracker/
  profile/
  education/
  work/
  projects/
  tech/
  3d-printer/
  fitness/
  finances/
  systems/
```

This is a guideline, not a schema requirement.

The actual structure should evolve naturally based on what information exists.

Do not reorganize the entire repository unnecessarily just to match this example.

---

# What Should Be Saved

Save information that is likely to be useful to another AI agent or future conversation.

Examples include:

- ongoing projects
- current project status
- hardware owned
- hardware ordered
- planned purchases
- configurations
- software stack
- workflows
- recurring responsibilities
- upcoming deadlines
- purchases made or planned
- parts ordered or received
- important measurements/specifications
- decisions and why they were made
- unresolved problems
- solutions that worked
- solutions that failed
- preferences that affect future decisions
- important links
- project file locations
- repositories
- collaborators/clients when relevant to ongoing work
- school subjects and current academic progress
- plans that span multiple conversations
- known blockers or dependencies
- useful recurring commands
- project architecture
- selected products/parts and their exact status

Also update information when it becomes outdated.

For example, change:

```text
Need to order X
```

to:

```text
X — ORDERED, awaiting delivery
```

and later:

```text
X — OWNED / received
```

rather than leaving contradictory states scattered throughout the repository.

---

# What Should NOT Be Saved

Do not indiscriminately archive entire conversations.

Avoid storing:

- casual conversation with no future value
- repeated information
- transient thoughts that have no durable relevance
- huge raw chat transcripts when a concise summary is sufficient
- unnecessary personal details
- passwords
- API keys
- authentication tokens
- private credentials
- security answers
- secrets
- sensitive information that is not necessary for future work

The goal is a **high-signal knowledge base**, not a raw surveillance archive or transcript dump.

Summarize durable knowledge instead.

---

# Current-State Over Diary-Style Logging

Prefer editing existing canonical information over endlessly appending notes.

Bad:

```text
Aug 1: planning to buy part
Aug 3: might buy part
Aug 5: bought part
Aug 8: part arrived
```

Better:

```md
## Hardware Status

- Part X — OWNED / received
```

Use history when the timeline itself matters, such as:

- debugging sequences
- significant milestones
- decision history
- medically or legally relevant timelines where deliberately tracked
- project changelogs

Otherwise optimize for current truth.

---

# Preserve Context and Provenance

When useful, include dates for information that can become stale.

Example:

```md
Last updated: 2026-09-01
```

For decisions:

```md
## 2026-09-01 — Switched to Mercury One.1

Reason:
...
```

Avoid pretending uncertain information is confirmed.

Distinguish explicitly between states such as:

- confirmed
- planned
- likely
- awaiting confirmation
- ordered
- received
- completed
- blocked
- abandoned
- unverified

When recording a measurement, include units.

If a newer measurement supersedes an older one, retain the older value only when its history is useful; otherwise clearly replace or mark it superseded so future agents do not treat both as simultaneously current.

---

# Conflict Resolution

When new information conflicts with existing `life-tracker` information:

1. Prefer newer explicit information from me over older notes.
2. Update the canonical current value.
3. Remove or mark outdated information where appropriate.
4. Preserve the old value only when its historical relevance matters.
5. Never silently combine incompatible facts into something invented.

If a recorded decision is marked `LOCKED`, do not overwrite it merely because another approach seems better.

If a new recommendation conflicts with a locked decision:

1. call out the conflict
2. explain the reason for reconsideration
3. obtain user approval before updating the locked decision

---

# Cross-Project Information

If information is relevant to multiple projects, avoid unnecessary duplication.

Prefer:

1. storing canonical information once, and
2. linking to it from other Markdown files.

Example:

```md
See: `../hardware/main-pc.md`
```

If a small amount of duplication substantially improves usability or retrieval, that is acceptable.

Keep duplicated status synchronized when it materially affects correctness.

---

# Project-Specific AGENTS.md Files

Major project folders should have their own `AGENTS.md` when enough context exists to justify one.

A project-specific `AGENTS.md` should tell AI coding/agent tools:

- where the canonical project context lives
- which files should be read first
- project-specific constraints
- important commands
- architecture notes
- safety restrictions
- locked decisions
- how status/inventory files are structured
- that durable context should be kept synchronized with `life-tracker`

Project-specific instructions extend this root file.

If instructions conflict, prefer the more specific project instruction unless it would violate an explicit global safety or data-integrity rule here.

---

# Existing Repository Conventions

When entering an existing project folder, inspect the files already there before inventing a new schema.

In particular, if present, read the nearest relevant:

- `AGENTS.md`
- `README.md`
- `BUILD_SPEC.md`
- `INVENTORY.md`
- `OPEN_ITEMS.md`
- `DECISIONS.md`
- `STATUS.md`
- `REFERENCES.md`

Use those as the source of truth for project state, decisions, inventory, and next actions.

Preserve existing useful conventions instead of creating duplicate lowercase/uppercase equivalents without a reason.

---

# Hardware / Inventory State Rules

For hardware and physical-project records, clearly distinguish:

- **Owned / verified** hardware
- **Ordered** hardware
- **Planned / pending purchase** hardware
- **Assumed / unverified** hardware

Never mark an item as owned just because it was recommended or added to a shopping list.

When I report a purchase, measurement, completed step, delivery, changed part, or changed decision, update the relevant Markdown file(s) so future sessions have the new state.

Record measurements with units.

For hardware changes, prefer reversible steps and bench testing before dismantling a working machine when practical.

---

# 3D Printer Safety and Accuracy Rules

For 3D-printer work, especially Klipper, electronics, heaters, probes, motors, and mechanical conversions:

1. Do not invent pin assignments.
2. Do not invent thermistor types.
3. Do not invent motor currents.
4. Do not invent mechanical dimensions.
5. Verify values from actual hardware/configuration or authoritative documentation before treating them as confirmed.
6. Preserve safety-critical notes around heaters, thermistors, wiring, mains power, moving axes, endstops, probes, and Klipper limits.
7. Distinguish between hardware that is physically present, ordered, merely recommended, or still uncertain.
8. Prefer reversible tests and safe bench checks before destructive or difficult-to-reverse mechanical changes.

These rules are especially important in `3d-printer/` and any nested printer project.

---

# Working With External Source-Code Repositories

If I am working inside another Git repository, do **not** copy its source code into `life-tracker` unless explicitly requested.

Instead:

- keep source code in its normal repository
- keep durable personal/project context in `life-tracker`
- reference the external repository from the relevant Life Tracker project page

Example:

```md
## Repository

GitHub: `https://github.com/<owner>/<repo>`

Local path: `<path if useful>`
```

Useful durable information to keep in Life Tracker may include:

- repository URL
- purpose
- current branch or architecture when relevant
- deployment details
- important decisions
- unresolved problems
- roadmap/status

Do not duplicate entire codebases.

---

# Git Behaviour

When repository write access is available:

- make required Markdown changes directly
- preserve existing useful information
- avoid destructive rewrites
- use clear filenames
- keep Markdown readable by humans and AI agents
- inspect existing content before replacing files
- inspect diffs when practical
- keep commits scoped and descriptive

Good commit examples:

```text
docs(life-tracker): update Mercury One hardware status
context: add life automation project
docs(3d-printer): record ordered idlers
docs: refresh current project status
```

Do not force-push, reset history, delete branches, or perform other destructive Git operations unless explicitly authorized.

Pushing normal context updates to the canonical repository is acceptable when the environment is already authorized and the requested workflow expects direct synchronization.

---

# When Repository Access Is Unavailable

Some AI environments may not have filesystem or GitHub access.

If you cannot actually access or modify `life-tracker`:

1. Do not pretend that you read or updated it.
2. Continue the requested work normally using context actually available to you.
3. At the end, when useful, provide a concise **Life Tracker update** containing the exact durable information that should be written once repository access becomes available.
4. If the environment later gains repository access, apply that pending context.

Never claim persistence occurred when no write was actually made.

---

# Repository Evolution

You may improve the structure of `life-tracker` over time when doing so clearly improves retrieval, consistency, or maintainability.

However:

- avoid unnecessary reorganizations
- avoid creating excessive tiny files
- avoid duplicate folders
- prefer predictable names
- preserve useful links when restructuring
- do not move large amounts of content merely for aesthetics
- optimize for both human readability and AI retrieval

The structure should evolve in response to real information, not speculative taxonomy.

---

# Update Style

Prefer concise, structured Markdown.

Use:

- headings for major concepts
- bullet lists for state
- tables for inventories/specifications when useful
- explicit status labels such as `OWNED`, `ORDERED`, `PENDING`, `TBD`, and `LOCKED`
- dates where freshness matters

Avoid:

- verbose transcript-style prose
- duplicate facts
- stale checklists
- unexplained contradictions
- dumping AI reasoning into project files

Life Tracker should store conclusions, facts, state, decisions, and useful reasoning — not private chain-of-thought.

---

# Retrieval Behaviour

When asked a question that may already be answered in Life Tracker:

1. search/read Life Tracker first when access exists
2. use the existing context
3. only ask me to repeat information if the necessary information is genuinely absent or ambiguous

When making a recommendation, first check whether a relevant decision has already been made.

When troubleshooting, check whether the same failure and solution have already been recorded.

When buying parts or products, check current inventory and pending purchases first so duplicate purchases are not recommended accidentally.

---

# Information Quality

Treat Life Tracker as a maintained knowledge base, not infallible truth.

When a fact appears stale, contradictory, or suspicious:

- verify it where practical
- distinguish observed facts from assumptions
- update the record when new explicit information is available
- do not silently fabricate a resolution

Use authoritative external documentation for technical facts when needed, while using Life Tracker for the user's specific state and prior decisions.

---

# New Project Creation Checklist

When creating a new substantial project area:

1. Choose a clear, stable folder name.
2. Search for an existing overlapping project first.
3. Create a minimal `README.md` describing the project and goal.
4. Create `AGENTS.md` only if project-specific instructions are useful.
5. Add status, decision, inventory, todo, or reference files only when they have actual content.
6. Record relevant external repository/file links.
7. Add the current known state, not imagined future details.
8. Keep the structure small until complexity requires more files.

---

# Status Changes

When state changes, update the canonical record rather than only adding a note.

Examples:

```text
PENDING → ORDERED → OWNED
PLANNED → IN PROGRESS → COMPLETED
BLOCKED → IN PROGRESS
TBD → CONFIRMED
ACTIVE → PAUSED → ACTIVE
```

If an old status is useful historically, preserve it in a decision log or dated history section. Otherwise, replace it with the current state.

---

# Decisions

Record durable decisions when they would matter to future work.

A useful decision entry usually contains:

```md
## YYYY-MM-DD — Decision title

**Status:** LOCKED / ACTIVE / SUPERSEDED

**Decision:** What was chosen.

**Reason:** Concise explanation of why.

**Implications:** Anything future agents need to know.
```

Do not turn every minor preference into a formal decision entry.

---

# References and Links

Store links that future agents are likely to need again, especially:

- canonical repositories
- product pages for selected parts
- documentation
- datasheets
- project resources
- shared files
- important videos/tutorials

When a link is ephemeral, note what information matters rather than relying solely on the link.

---

# Final Principle

Every substantial interaction should, where appropriate, make `life-tracker` slightly more useful, current, and internally consistent.

Do not optimize for recording the maximum amount of information.

Optimize for preserving the **minimum amount of high-value context needed for future agents to continue intelligently**.

The ideal result is:

- I do not need to repeatedly explain my existing projects.
- Different AI tools can resume work with shared context.
- Project state stays current.
- Important decisions are not repeatedly revisited without reason.
- Purchases and inventory are accurately tracked.
- Technical work uses verified facts rather than guesses.
- The repository remains understandable to both humans and AI agents.

**Canonical memory loop: `LOAD → WORK → EXTRACT → UPDATE`.**
