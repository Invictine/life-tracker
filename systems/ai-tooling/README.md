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

## Preferred pattern

Third-party harness (e.g. OpenCode or another provider-agnostic agent) -> Google Vertex AI -> Gemini model.

Use Google Cloud application-default credentials or a service account rather than reusing Gemini/Antigravity OAuth tokens.
