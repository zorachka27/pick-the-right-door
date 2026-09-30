# Pick the Right Door!

A Roblox multiplayer survival game prototype based on the game concept you described. Players spawn in a lobby, wait for the round to start, then choose the single safe door from a set of themed challenge rooms. Survivors earn coins, unlock progression, and keep pushing into harder rounds.

## What is included

- lobby creation scaffolding
- round/intermission system
- theme-based challenge rooms
- door generation and safe-door logic
- trap triggers for wrong doors
- coin rewards and leaderstats
- world unlock system
- a client HUD for round timer and announcements
- game design documentation for future expansion

## Roblox Studio usage

1. Create a new Roblox place.
2. Insert the scripts from the repo into your Roblox place using the same folder structure.
3. Put `src/ServerScriptService` contents into `ServerScriptService`.
4. Put `src/StarterPlayer/StarterPlayerScripts/GameClient.client.lua` into `StarterPlayer > StarterPlayerScripts`.
5. Start Play mode and test the lobby, round cycle, and door flow.

## Core game loop

- Players spawn in the main lobby.
- Intermission countdown begins.
- The server selects a random room theme and safe door.
- Doors appear in a challenge room.
- Players have a limited time to choose before the timer expires.
- Safe door survivors continue.
- Wrong door picks trigger traps and elimination.
- Survivors earn coins and advance to the next round.
- Difficulty scales up by adding more doors and reducing timer length.

## Included files

- `src/ServerScriptService/GameConfig.lua` — gameplay balancing, world progression, themes, rewards
- `src/ServerScriptService/PrizeSystem.lua` — coins, wins, round progression, leaderstats
- `src/ServerScriptService/RoomBuilder.lua` — lobby and challenge room construction
- `src/ServerScriptService/RoundManager.lua` — round flow and elimination logic
- `src/ServerScriptService/Bootstrap.server.lua` — bootstraps the game
- `src/StarterPlayer/StarterPlayerScripts/GameClient.client.lua` — round HUD and announcements
- `docs/GAME_DESIGN.md` — full game design overview for the project

## Future expansion areas

- cosmetic shop
- door skins and effects
- VIP/gamepass hooks
- admin panel
- daily rewards
- special events
- double-or-nothing risk mode
- world-specific trap variants

## Notes

This repository is meant to be a practical Roblox prototype foundation. It is designed to be expanded step-by-step into a more polished game with a richer lobby, UI, and monetization system.
