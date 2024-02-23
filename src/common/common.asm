#include "../../dungeon-delver-engine/src/engine/dde.asm"
#include "./constants.asm"
#include "./origin_characters.asm"
#include "./party.asm"
#include "./game_state.asm"
#include "./monsters.asm"

.local
register_campaign_extras::
    call register_races
    call register_monsters
    ret

register_races:
    ld hl, opt_campaign_race
    ld a, race_githyanki
    ld (hl), a
    ld a, default_options_flags
    inc hl
    ld (hl), a
    inc hl
    ld bc, race_githyanki_label
    ld (hl), bc

    ret
.endlocal
