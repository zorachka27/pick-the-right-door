# Pick the Right Door!

A Roblox multiplayer survival game prototype for the game concept you described. Players spawn in a lobby, wait for the challenge round to begin, then must choose the single safe door. Wrong doors trigger trap effects, and survivors earn coins, unlock progression, and keep climbing harder rounds.

## What is in this prototype

- lobby spawn area and round environment setup
- random challenge room generation
- door setup and safe door logic
- increasing difficulty as rounds progress
- coin rewards and player progression tracking
- world unlock progression
- themed trap trigger support
- admin/event foundation
- client HUD for timer and round updates

## Current feature set

- 3 to 10 doors depending on round
- round timer scaling downward over time
- room themes: Castle, Volcano, Laboratory, Carnival, Underwater, Alien, and Space
- safe-door survivor flow
- wrong-door elimination flow
- coin earning and leaderstats tracking
- world progression with unlock requirements
- admin commands for round control, message announcements, and player actions

## Included code files

- `src/ServerScriptService/GameConfig.lua` — gameplay settings, rewards, progression, and room themes
- `src/ServerScriptService/RoomBuilder.lua` — lobby and challenge room building logic
- `src/ServerScriptService/TrapEffects.lua` — wrong-door trap effects and hazard simulation
- `src/ServerScriptService/WorldManager.lua` — world availability, unlock requirements, and theme selection
- `src/ServerScriptService/PrizeSystem.lua` — coins, wins, highest round, and door survival tracking
- `src/ServerScriptService/AdminSystem.lua` — admin controls and announcement support
- `src/ServerScriptService/RoundManager.lua` — round loop, timer, and game progression
- `src/ServerScriptService/Bootstrap.server.lua` — bootstrap for the server
- `src/StarterPlayer/StarterPlayerScripts/GameClient.client.lua` — HUD and round state feedback
- `docs/GAME_DESIGN.md` — full design document for the full game concept

## How to use in Roblox Studio

1. Open a new Roblox place.
2. Place the contents of `src/ServerScriptService` into `ServerScriptService`.
3. Place the client script from `src/StarterPlayer/StarterPlayerScripts/GameClient.client.lua` into `StarterPlayer > StarterPlayerScripts`.
4. Press Play.
5. Test the lobby, intermission flow, challenge rooms, safe-door logic, and reward cycle.

## Notes

This repository is now a polished starter prototype for the full “Pick the Right Door!” game you described. It is structured for future expansion into a larger lobby, cosmetics shop, world maps, special events, VIP monetization, and owner/admin tooling.
