# Pick the Right Door!

A Roblox multiplayer survival game prototype inspired by the concept you described. Players spawn in a lobby, wait for the next round, then choose the single safe door from a themed challenge room. Survivors earn coins, unlock progression, and survive longer into harder rounds.

## Included systems

- lobby builder
- challenge room generation
- round and intermission flow
- safe door and elimination logic
- themed trap system
- coin and leaderstats tracking
- high-level world progression and unlock structure
- client HUD and round state feedback
- admin system scaffolding for owner controls and special events

## Directory overview

- `src/ServerScriptService/GameConfig.lua` — gameplay settings and world config
- `src/ServerScriptService/RoomBuilder.lua` — lobby and room building tools
- `src/ServerScriptService/PrizeSystem.lua` — coin, round, and win tracking
- `src/ServerScriptService/RoundManager.lua` — gameplay loop and elimination logic
- `src/ServerScriptService/AdminSystem.lua` — owner/admin controls and event hooks
- `src/ServerScriptService/Bootstrap.server.lua` — bootstrap entry point
- `src/StarterPlayer/StarterPlayerScripts/GameClient.client.lua` — HUD and client feedback
- `docs/GAME_DESIGN.md` — full design doc for the game vision

## How to use in Roblox Studio

1. Create a new Roblox place.
2. Add the scripts in `src/ServerScriptService` to `ServerScriptService`.
3. Add `src/StarterPlayer/StarterPlayerScripts/GameClient.client.lua` to `StarterPlayer > StarterPlayerScripts`.
4. Press Play.
5. Observe the lobby, the countdown, the challenge room, and the round progression.

## Current prototype features

- round-based survival flow
- 3–10 door scaling by round
- time-limited choices
- room themes and door generation
- winner/loser flow and reward distribution
- lobby spawns and room teleportation
- server/client communication for HUD updates
- admin/event foundation for future gameplay controls

## Planned next upgrades

- improved lobby with actual shop, leaderboard, and NPC UI panels
- animated trap effects per wrong door
- cosmetic store and door skin selection
- VIP/gamepass integration
- admin panel in-game
- special events such as Chaos Mode and Double Coin Weekend
- double-or-nothing risk mode

This repo now acts as a working prototype foundation for the full game concept you requested.
