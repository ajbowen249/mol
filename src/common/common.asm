#include "../../dungeon-delver-engine/src/engine/dde.asm"
#include "./constants.asm"
#include "./origin_characters.asm"
#include "./party.asm"

.local
register_races::
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
