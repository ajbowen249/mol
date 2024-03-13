; Dungeon Delver Engine Test Campaign
; This is a CRPG built on the Dungeon Delver Engine

.org $B200

; Keep this at the top; this is the entry point
    call main
    ret

#include "../../common/common.asm"
#include "./global_data.asm"
#include "./dialog/dialog.asm"
#include "./screens/screen_table.asm"
#include "./encounters/encounter_table.asm"

main:
    ld a, 0
    ld (dde_should_exit), a

    call seed_random
    call register_campaign_extras

    ld a, 4
    ld (party_size), a

    ld hl, screen_table
    ld bc, encounter_table
    ld de, player_party
    ld a, (party_size)
    call configure_screen_controller

    ld a, (last_room)
    ld b, a
    ld a, ec_door
    call set_screen_exit_conditions

    call run_screen_controller

    call rom_clear_screen
    ret
