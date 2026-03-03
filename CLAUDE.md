# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository overview

Monorepo of small apps and scripts built with Claude Code. Each subdirectory is an independent project:

| Directory | Description |
|-----------|-------------|
| `krysha-snack-planner/` | Next.js app — AI-powered snack planner for a 5-year-old |
| `krysha-dino-game/` | Next.js app — Snakes & Ladders (dinosaur-themed) board game |
| `organize_downloads.sh` | Bash script — sorts `~/Downloads` into category folders (macOS only) |

---

## krysha-snack-planner

### Commands
```bash
cd krysha-snack-planner
npm run dev      # dev server at localhost:3000
npm run build    # production build
npm run lint     # ESLint
```

Requires `ANTHROPIC_API_KEY` in `.env.local` for the AI route.

### Architecture

- **Stack**: Next.js 14 App Router, TypeScript, Tailwind CSS with custom Disney-inspired design tokens, Anthropic SDK
- **AI**: `src/app/api/recommend/route.ts` — single POST endpoint handling four recommendation types (`snack-pack`, `cook-together`, `try-new`, `suggest-favorites`). Calls `claude-haiku-4-5-20251001` and expects raw JSON back. The fairy persona name is user-configurable and injected into every prompt.
- **Storage**: `src/lib/storage.ts` — all food data and the fairy name persist in `localStorage` (keys: `krysha_snacks_v1`, `krysha_fairy_name_v1`). No database or server-side state.
- **Types**: `src/lib/types.ts` defines `FoodItem`, `RecommendationType`, and a typed response shape for each recommendation type.
- **Nut-free rule**: `src/lib/nuts.ts` exports `NUT_FREE_PROMPT_RULE`, which is appended to every AI system prompt.

### Routes

| Route | Purpose |
|-------|---------|
| `/` | Home dashboard with fairy name editor |
| `/favorites` | Add/edit/delete food items, star ratings, pantry toggle |
| `/snack-pack` | AI-generated school snack box combos |
| `/cook-together` | AI-generated recipes to cook with Daddy |
| `/try-new` | AI suggestions for new foods to discover |

---

## krysha-dino-game

### Commands
```bash
cd krysha-dino-game
npm run dev      # dev server at localhost:3000
npm run build    # production build
npm run lint     # ESLint
```

### Architecture

- **Stack**: Next.js 14 App Router, TypeScript, Tailwind CSS with custom dino tokens, Fredoka One + Nunito fonts
- **No server, no storage** — pure client-side game state via `useReducer` in `src/app/page.tsx`
- **Game logic**: `src/lib/gameLogic.ts` — `buildBoard()` generates the 10×10 grid (odd rows reversed for boustrophedon layout); `calculateMove()` applies dice roll, overshoot bounce, staircase climbs, and dinosaur slides
- **Constants**: `src/lib/constants.ts` — `STAIRCASES` and `DINOSAURS` lookup tables, `PLAYER_CONFIGS` (4 players), `DEFAULT_NAMES`
- **State flow**: `page.tsx` owns the `useReducer` and passes handlers down; `SetupScreen → GameScreen → WinScreen` phases are driven by `GameState.phase`
