# T3 Code (`t3code`)

- **Upstream Repository**: `https://github.com/pingdotgg/t3code`
- **Fork Repository**: `https://github.com/Invictine/t3code`
- **Local Working Directory**: `C:\Users\aniru\Documents\Server\scratch\t3code`
- **Tooling**: Vite+ CLI (`vp`) with Node 24.20.0 and pnpm 11.10.0.

---

## 1. Pull Requests & Contributions

### PR #10174: Keybinding Digit Shortcut Symbol Capture Fix
- **URL**: [pingdotgg/t3code#10174](https://github.com/pingdotgg/t3code/pull/10174)
- **Branch**: `fix/keybinding-digit-symbols`
- **Problem**: In Settings > Keyboard Shortcuts, recording a shortcut with Shift pressed (e.g. `Mod+Shift+1` or `Shift+6`) evaluated `event.key`, capturing shifted symbols (`!` or `^`) instead of numbers (`1` or `6`).
- **Fix**:
  - `normalizeShortcutKeyToken(key, code?)` in `apps/web/src/components/settings/KeybindingsSettings.logic.ts` inspects `code` against `/^Digit(\d)$/` and normalizes to digits `0`..`9`. Bracket keys (`BracketLeft` -> `[`, `BracketRight` -> `]`) are also preserved.
  - Numpad aliases were excluded from `EVENT_CODE_KEY_ALIASES` in `apps/web/src/keybindings.ts` to ensure NumLock-off navigation (`End`, arrow keys) is never hijacked by digit shortcuts.
  - Screenshots hosted at immutable commit `Invictine/t3code@587bf9545313bdddf4237c62bb782eeb654b107d` (`before.png` and `after.png`).

---

## 2. Usage Section Architecture & OpenCode/Antigravity Integration

### Why OpenCode and Antigravity Were Excluded
1. **Contract Schema**: `UsageProviderKind` in `packages/contracts/src/usage.ts` was a closed union strictly limited to `Schema.Literals(["claude", "codex", "grok"])`.
2. **Offline Transcript Model (`ccusage` style)**:
   - T3 Code's historical token/cost charts do **not** query SQLite persistence (`projection_turns` only stores orchestration lifecycle, no token counts or costs).
   - Instead, `UsageService.ts` scans provider CLI session files on disk (`~/.claude/projects/**/*.jsonl`, `~/.codex/sessions/**/*.jsonl`, `~/.grok/sessions/**/updates.jsonl`) and caches summaries in `usage-scan-cache.json`.
3. **Subscription Limits View**:
   - `packages/shared/src/usageLimits.ts` filters `providersWithLimits` where `provider.usageLimits !== undefined`.
   - Neither `OpenCodeProvider.ts` nor `AntigravityProvider.ts` probes or populates `usageLimits`.

### OpenCode Telemetry & Retroactive Ingestion
- **Real-Time**: OpenCode streams `message.part.updated` with `step-finish` parts containing token metrics (`input`, `output`, `reasoning`, `cache: { read, write }`, `cost`). `OpenCodeAdapter.ts` accumulates these and emits `turn.completed.tokenUsage`.
- **Retroactive Ingestion**: OpenCode persists full conversation history and step tokens in an on-disk SQLite database at `~/.local/share/opencode/opencode.db`.
  - Schema contains `session`, `message`, and `part` tables (`part.type = "step-finish"` holds exact token usage JSON).
  - Can be queried via Node 22's built-in `node:sqlite` in read-only mode to backfill all past OpenCode usage.

### Antigravity Telemetry & Retroactive Ingestion
- **Real-Time**: Connects via stdio Agent Client Protocol (ACP) to `agy_acp_server`. The ACP binary currently only returns `{"result": {"stopReason": "end_turn"}}` without token usage payloads.
- **Retroactive Ingestion**: Conversations are stored in SQLite files at `<stateDir>/providers/antigravity/*/antigravity-acp/conversations/*.db` and `~/.gemini/antigravity/conversations/*.db`, and transcripts in `<appDataDir>/brain/<conversation-id>/.system_generated/logs/transcript.jsonl`.
  - Retroactive calculation requires token estimation from prompt/response text in the transcript logs or extracting metrics once ACP exposes token usage in `PromptResponse`.

### Fork Test Branch
- **Branch**: `feat/usage-opencode-antigravity` on `https://github.com/Invictine/t3code/tree/feat/usage-opencode-antigravity`
- Contains contract extensions, Web and Mobile presentation registries, and transcript reader scaffolding for testing.
