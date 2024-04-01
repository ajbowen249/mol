#include "../../dungeon-delver-engine/src/engine/dde.asm"
#include "./constants.asm"
#include "./origin_characters.asm"
#include "./game_state.asm"
#include "./game_state_helpers.asm"
#include "./monsters.asm"
#include "./pause_menu.asm"

common_consolidated_menu:
.block mi_data_size * 5, 0

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
