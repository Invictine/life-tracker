# AI Tooling

Last updated: 2026-09-01

## Current preference

- Prefer third-party / provider-agnostic AI harnesses over Google Antigravity for day-to-day agent work.
- Avoid unofficial Gemini/Antigravity OAuth piggyback plugins because Google explicitly treats third-party reuse of those product-login credentials as a policy violation and has suspended accounts for it.
- When using a Google AI Pro/Ultra subscription outside Google-native agent surfaces, prefer the supported Google Cloud / Vertex AI route.

## Google subscription leverage

- Google AI Pro includes Google Developer Program premium benefits with **$10/month Google Cloud credit**.
- Google AI Ultra tiers include higher monthly Cloud credits (currently $40 or $100 depending on tier).
- These credits can be applied to Google Cloud usage including **Vertex AI**, making Vertex AI the preferred supported backend for Gemini models in third-party harnesses.
- Consumer Gemini CLI / Gemini Code Assist Google-account access was sunset for Google AI Pro/Ultra on 2026-06-18; Google directs consumer users toward Antigravity, while supported third-party access is via Gemini API / AI Studio or Vertex AI credentials.
- Vertex AI / Google Cloud model usage is billed separately from consumer Gemini app subscription usage and does **not** consume the normal Gemini app quota.

## Gemini API / Vertex AI credit cushion

- **Status: NOT ACTIVATED YET.** Do not assume the Google Cloud trial has already been redeemed or that billing is configured.
- If still eligible as a new Google Cloud customer when needed, there is a **$300 Google Cloud free-trial credit for 90 days** that can be used as a substantial fallback pool for Gemini models through **Vertex AI**.
- Treat this as a useful reserve for projects that need paid AI API capacity, especially prototypes, agents, automation, coding systems, batch processing, or workloads that would otherwise require purchasing API credit immediately.
- This reserve is particularly valuable because it is separate from the user's normal Gemini subscription/model usage limits.
- The $300 Google Cloud welcome credit applies to eligible Google Cloud / Vertex AI usage; do **not** assume it applies to separately billed Gemini Developer API / Google AI Studio usage.
- When an upcoming project needs an AI API, consider **Gemini via Vertex AI** as a high-capacity fallback before assuming a new paid API budget is required.
- Do not activate the trial pre-emptively. Preserve the 90-day window until there is a project that can make meaningful use of it.

### Rough capacity reference

At current indicative Vertex AI pricing discussed on 2026-09-01, the $300 pool is large enough for substantial experimentation. Exact model pricing should always be rechecked before activation or heavy use, but the practical conclusion is that the trial provides a significant AI-compute cushion rather than a trivial promotional credit.

For cost control once activated:

- Prefer Gemini Flash-class models for routine agent/tool loops, repo exploration, batch work, and repetitive tasks.
- Reserve Gemini Pro-class models for difficult reasoning, architecture, debugging, and final review.
- Avoid repeatedly sending unnecessarily huge contexts, especially >200k-token requests where long-context pricing can rise sharply.
- Use provider/model context caching where supported.

## Preferred pattern

Third-party harness (e.g. OpenCode or another provider-agnostic agent) -> Google Vertex AI -> Gemini model.

Use Google Cloud application-default credentials or a service account rather than reusing Gemini/Antigravity OAuth tokens.
