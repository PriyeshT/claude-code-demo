# PRD Writer Agent Memory

## Project: krysha-snack-planner

### Architecture constraints (confirmed from source)
- localStorage-only: keys `krysha_snacks_v1` and `krysha_fairy_name_v1`. No DB planned.
- Single API route `/api/recommend` (POST) handles all 4 rec types. No additional routes desired without strong justification.
- AI model: `claude-haiku-4-5-20251001` with `max_tokens: 2048`.
- Nut-free rule enforced at two layers: `containsNut()` client-side + `NUT_FREE_PROMPT_RULE` injected into every system prompt.
- `FoodItem` schema: id, name, emoji, rating (0-5, 0=unrated), category (7 values), inPantry, dateAdded.
- All pages are `'use client'` components; no server components used for pages.
- No global state manager — each page calls `getFoods()` from localStorage on mount.

### Singapore context (confirmed from source)
- `suggest-favorites` prompt explicitly references FairPrice, Cold Storage, Giant, hawker centres.
- `NUT_KEYWORDS` includes satay and gado gado (Singapore-relevant peanut dishes).
- Singapore-specific foods (dragon fruit, rambutan, kai lan, tau kwa, edamame, cincau) appear in prompts.

### UX patterns confirmed
- Minimum touch target: `min-h-[44px]` enforced on all interactive elements.
- Mobile: fixed bottom nav bar (56px tall). Desktop: sticky top nav.
- Animations: sparkle, shimmer, float, starBurst, fadeInUp, wiggle, bounce_magic.
- Design tokens: `castle-purple`, `castle-gold`, `castle-pink`, `castle-teal`, `castle-cream`, `castle-sparkle`.
- Fonts: Fredoka One (`font-magic`) for headings, Nunito (`font-body`) for body.

### Known gaps identified during PRD (Feb 2026)
- No data export/backup — localStorage loss = all data gone.
- No snack history / "used this combo" tracking.
- No recipe shopping list generation from cook-together results.
- No weekly meal planner view.
- Emoji picker has a fixed hardcoded set of 40 emojis — not all food emojis covered.
- No offline fallback if API is unavailable (beyond the error card).
- Fairy name max length 20 chars in UI, 30 chars server-side — minor mismatch.
- `suggest-favorites` adds foods with `inPantry: false` always (intentional design).
- `try-new` also adds with `inPantry: false` (consistent).
- Gap suggestions from snack-pack add with `inPantry: true` (different — makes sense contextually).

### User preferences
- Concise responses preferred.
- No extra comments/docstrings beyond what is necessary.
- Priyesh = Daddy (co-user alongside Krysha).

## See also
- `krysha-dino-game` notes: pure client-only `useReducer`, no persistence desired.
