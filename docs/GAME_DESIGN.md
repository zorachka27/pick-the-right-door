# Pick the Right Door! Game Design

## Overview

Pick the Right Door! is a Roblox multiplayer survival challenge game where players repeatedly enter themed challenge rooms and must choose a single safe door from several options. If they pick the wrong door, a trap, hazard, or comedic surprise eliminates them or removes them from the round. Survivors earn coins and progress further into harder rounds.

## Core loop

1. Intermission countdown
2. Teleport players to a challenge room
3. Doors appear in a random layout
4. Players choose before the timer ends
5. Doors lock
6. Safe door is revealed
7. Wrong doors trigger unique traps
8. Survivors collect coins
9. New room and new safe door are generated

## Difficulty curve

The game use a simple scaling formula.

- Early rounds: 3–4 doors, 10 second timer
- Midgame: 5–7 doors, 7–8 second timer
- Late rounds: 8–10 doors, 5–6 second timer

The round progression increases with a modest timer reduction per round and extra doors as players survive longer.

## Lobby design

The lobby is a central social space with:

- giant sign reading “PICK THE RIGHT DOOR!”
- round leaderboard
- global wins leaderboard
- coin counter
- shop and cosmetics area
- gamepass shop
- daily reward booth
- spectator area
- NPC helper explaining the rules
- portal/teleport options to worlds and rooms

## Room themes

### Castle

Stone walls, torches, medieval decorations, giant wooden doors.

Possible traps:
- falling rocks
- spikes
- fire blast
- collapsing floor
- fake treasure room

### Volcano

Lava pits, volcanic rock, heat vents, and dangerous ceiling hazards.

Possible traps:
- lava explosion
- falling rocks
- fire burst
- lava floor
- volcano eruption

### Laboratory

Futuristic lab with glowing machines and hazards.

Possible traps:
- electric shock
- laser beam
- exploding experiment
- poison gas
- robot attack

### Underwater

Underwater facility with flooded halls and sea hazards.

Possible traps:
- rising water
- shark attack
- broken glass
- whirlpool
- electric eel

### Carnival

Bright carnival layout with noisy objects and moving platforms.

Possible traps:
- giant hammer
- falling objects
- spinning platforms
- fake prize room
- cannon launch

## Trap variety

Each wrong door can trigger a different effect:

- explosion
- fire blast
- rock drop
- floor collapse
- shark attack
- monster appear
- lightning strike
- launch upward
- freeze
- wall crush
- chicken attack
- portal drop

Some traps are comedic and non-fatal, while others eliminate the player completely.

## Rewards and progression

### Coins

Players earn coins for surviving rounds and winning games.

- survive round: +10
- survive 5 rounds: +50
- survive 10 rounds: +150
- win a game: +500
- daily reward: +100 to +1000

### Cosmetics

- door skins
- player trails
- elimination effects
- titles
- emotes
- names colors
- victory effects

### Monetization

Optional monetization is supported through:

- game passes
- developer products
- VIP perks
- double coin boost
- lucky choice hint
- extra life
- faster vote/time bonus

## Leaderboards

The game includes several tracking systems:

- most wins
- highest round survived
- most coins
- doors survived

## World progression

The game can unlock worlds gradually as players gain wins.

- World 1: The Beginning
- World 2: Medieval
- World 3: Volcano
- World 4: Laboratory
- World 5: Alien Planet
- World 6: Space

## Admin features

Owner or authorized developers can manage:

- start round
- end round
- skip round
- choose map
- spawn trap
- give/remove coins
- announce messages
- kick/ban players
- apply temporary events
- activate special mode events

## Special events

Possible events include:

- double coin weekend
- chaos mode
- 10-door challenge
- admin mayhem

## Extra mode: Double or Nothing

After surviving a round, players can choose to:

- leave with their coins
- risk them for a 2x reward on the next round

If they survive, they earn the doubled reward. If they lose, they lose the risked amount.

## Development notes

This prototype is structured so future content can be added without rewriting the core systems.

Additions planned for later:

- world-specific door layouts
- new cosmetics
- challenge badges
- new leaderboards
- daily quests
- weekly challenges
- trading system
- alternate game modes

## Implementation status

The repository currently contains a working base prototype with:

- lobby scaffolding
- random room creation
- door placement and safe door logic
- trap system
- coin reward flow
- progression tracking
- client HUD

This is intended as a building block for a larger, more polished Roblox game.
