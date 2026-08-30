# Task Plan: IELTS Word Bench

## Goal
Create a self-contained vocabulary tracker for recording unfamiliar IELTS words, marking mastery, and printing a focused subway study sheet.

## Phases
- [x] Phase 1: Plan and setup
- [x] Phase 2: Build interface and interactions
- [x] Phase 3: Verify core flows and print styling
- [x] Phase 4: Add Windows launcher and platform navigation
- [ ] Phase 5: Verify cross-platform entry points and publish documentation

## Decisions Made
- Use a standalone static app so it can be opened directly without installing dependencies.
- Store words in localStorage; ship with a small IELTS starter set as editable examples.

## Status
**Currently in Phase 5** - Windows launcher and operating-system navigation added; preparing cross-platform checks and GitHub update.

## Verification
- `node --check /Users/adele/ielts-vocab/app.js` passed.
- Print stylesheet hides editing controls and mastered cards, leaving a compact study sheet.
- No existing files outside `/Users/adele/ielts-vocab/` were changed.
