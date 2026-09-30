local docsText = [[
# Pick the Right Door!

## Overview

Pick the Right Door! is a Roblox multiplayer survival challenge. Players enter a lobby, wait for the next round, and then choose one safe door from a set of several challenge rooms. Only one door is safe; the rest contain different traps, hazards, or random surprises. Survivors continue to the next round, earn coins, and fight to make it as far as possible.

## Core game loop

1. Players spawn in the lobby.
2. The server starts an intermission countdown.
3. Players are teleported into a challenge room.
4. Doors appear with a single safe option.
5. Players choose a door before the round timer ends.
6. The safe door is revealed and surviving players continue.
7. Wrong doors trigger unique hazards or funny surprises.
8. Surviving players earn coins and increase their progression.
9. Difficulty increases with more doors and less time.

## Rooms and themes

- Castle
- Volcano
- Laboratory
- Underwater
- Carnival
- Alien Planet
- Space

## Progression

- rounds scale upward in difficulty
- players gain coins per survival
- wins, highest round, and doors survived are tracked
- world unlocks open as players reach specific win thresholds

## Monetization

The project also includes optional monetization ideas for later implementation:

- VIP game pass
- doubled coin pass
- lucky choice hint pass
- extra life pass
- faster vote pass
- developer products for coin packs
- random cosmetic purchases

## Admin and special events

The admin system is included as a framework for future owner features like:

- round control
- player announcements
- player kick actions
- special events like chaos mode and double coin weekends

## Prototype status

This repository currently contains a polished starter prototype with a working round system, lobby structure, themed challenge rooms, trap effects, progression, and a HUD. It is designed to be expanded into a larger finished game with cosmetics, world maps, shop systems, and leaderboards.
]]

return docsText
