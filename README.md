# TimestampedMarkers

> **AI disclosure:** this mod was written with substantial AI assistance
> (Claude, Anthropic) - design and implementation, working from the mod
> author's requirements and in-game testing. Disclosed per the
> [FAF Vault meta requirements](https://wiki.faforever.com/en/Development/Vault/Rules).

A UI-only mod for [Forged Alliance Forever](https://faforever.com) (Supreme
Commander: Forged Alliance) that adds the game time to the text of every
map marker you place.

```
expand here (05:07)        <- under an hour: (MM:SS)
watch nukes (01:05:12)     <- after an hour: (HH:MM:SS)
```

- The time is the game time at the moment you confirm the marker text.
- It becomes part of the marker text itself, so it shows both on the map
  and in the chat message to your allies - and **allies see it even if
  they don't have this mod**.
- Markers with empty text are left as they are.
- Markers can't be renamed in the game (only moved or deleted), so the
  time is added exactly once.

## Install

Easiest: find **TimestampedMarkers** in the FAF client's mod vault and
install it.

Manual: drop the mod folder into:

```
Documents\My Games\Gas Powered Games\Supreme Commander Forged Alliance\mods\
```

Then enable it from the FAF client's mod manager.

## Safe for ranked

This is a `ui_only` mod - it never touches simulation Lua, so it doesn't
unrank games.

## How it works

One hook, `hook/lua/ui/game/ping.lua`, wraps the game's `NamePing`
function - the "Enter Marker Name" dialog. When you confirm the dialog,
the time is appended to the text before the game sends the marker and the
chat message. Nothing else in the game is touched.

## License

MIT - see [LICENSE](LICENSE).
