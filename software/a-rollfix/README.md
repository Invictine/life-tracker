# A-Rollfix

Last reviewed: 2026-09-05

## Purpose and source

Local Premiere Pro CEP panel for cleaning raw A-roll by detecting silences, filler words, repetitions, and retakes. Source workspace: `C:\Users\aniru\Documents\A-Rollfix`. Source repository URL not verified.

Architecture: HTML/CSS/JavaScript panel, ExtendScript host bridge, Python localhost backend on port 5011, faster-whisper transcription. Keep source code in the source workspace.

## Current state

Static source inspection only; this session did not run Premiere or validate editing behavior live. Existing code includes presets, persisted settings, cut selection/filtering, clickable transcript, marker preview, sequence duplication/cut application, and export buttons. Backend startup helpers exist.

## Known gaps from source review

- Analysis submits only the first clip's source media path; collected timeline clip offsets are not sent to the analyzer or used to map cuts.
- Cut checkboxes render checked regardless of saved enabled state; summary and exports include disabled cuts. Play buttons seek without playing a preview.
- The UI labels tightening as cut-edge seconds, but the backend treats the value as a ratio for removing whole low-density transcript segments.
- Panel SRT/VTT exports contain cut labels/text, not captions for retained speech.
- Cancellation aborts the browser request; no backend job cancellation protocol exists. The server handles requests synchronously.
- Duplicate-sequence failure does not prevent the panel from calling Apply; the target sequence is not explicitly verified before applying.
- Jump/zoom and crossfade settings are sent to analysis but are not connected to their host helpers in the panel's apply flow.

## Proposed next work

Recommendations, not user-approved implementation decisions:

1. Reliable review and safe application: preserved selection, accurate selected-cut totals, verified duplicate target, timeline source mapping and track scope.
2. Before/after audition with adjustable cut boundaries and contextual transcript review.
3. Smarter retake comparison and contextual filler detection with confidence/review controls.
4. Cached transcription, real progress, and backend cancellation.
5. Captions retimed to the cleaned sequence and validated interchange exports.

No application files changed during this advisory session.
