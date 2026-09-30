# Pick the Right Door!

A Roblox multiplayer survival game concept and starter codebase for a round-based survival challenge where players must choose the single safe door before the clock runs out.

## Included in this repo

- Core server architecture for a round system
- Room and door generation logic
- Trap library and effects
- Coin and round progression foundation
- Lobby generation scaffold
- Design notes for worlds, monetization, leaderboards, and future expansion

## Roblox Studio setup

1. Create a new Roblox place.
2. In Roblox Studio, open the Explorer and keep the default `ServerScriptService` and `ReplicatedStorage`.
3. Copy the scripts from `src/ServerScriptService` into `ServerScriptService`.
4. Copy the `src/ReplicatedStorage` folder into `ReplicatedStorage`.
5. Press Play to test the lobby and the round system.

## Game loop

- Lobby spawns players in a common waiting area.
- Intermission countdown starts.
- The server chooses a random room theme and safe door.
- Players click a door before the timer expires.
- Safe door remains active while wrong doors trigger trap effects.
- Survivors earn coins and advance to the next round.
- Difficulty rises by increasing door counts and decreasing the timer.

## Suggested future expansion

- More worlds and themed rooms
- Cosmetic shop and reward system
- VIP and developer product hooks
- Dedicated admin panel and events
- Extra game modes like Double or Nothing

## Core files

- `src/ServerScriptService/Bootstrap.server.lua` — starts the game
- `src/ServerScriptService/RoundManager.lua` — handles rounds and room state
- `src/ServerScriptService/DoorFactory.lua` — creates doors and trap metadata
- `src/ServerScriptService/TrapLibrary.lua` — trap definitions and visuals
- `src/ServerScriptService/GameConfig.lua` — difficulty, rewards, and theme data

## Design summary

This repo gives you an expandable foundation for the game you described, including:

- 3–10 door rooms
- safe door logic
- elimination and survivor flow
- themed challenge rooms
- rounds scaling over time
- coin reward structure
- room/lobby placeholder setup

This is intentionally structured so you can continue building the full lobby, cosmetics, leaderboards, and monetization systems in Roblox Studio.
