; Dungeon Delver Engine Test Campaign
; This is a CRPG built on the Dungeon Delver Engine

.org $C000

; Keep this at the top; this is the entry point
    call main
    ret

#include "../../common/common.asm"
#include "./global_data.asm"
#include "./screens/screen_table.asm"

main:
    call seed_random

    ld hl, player_party
    call party_wizard
    cp a, 0
    jp nz, show_sheets
    ld a, 4

show_sheets:
    ld (party_size), a

    ld hl, party_player_1
    call character_sheet_ui

    ld a, (party_size)
    cp a, 2
    jp m, sheets_done

    ld hl, party_player_2
    call character_sheet_ui

    ld a, (party_size)
    cp a, 3
    jp m, sheets_done

    ld hl, party_player_3
    call character_sheet_ui

    ld a, (party_size)
    cp a, 4
    jp m, sheets_done

    ld hl, party_player_4
    call character_sheet_ui

sheets_done:

    ld a, ec_door
    ld (last_screen_exit_code), a
    ld a, screen_id_nautiloid
    ld (last_screen_exit_argument), a

screen_loop:
    ld a, (last_screen_exit_code)

    cp a, ec_door
    call z, run_room

    jp screen_loop

    ret

run_room:
    ld a, (last_screen_exit_argument)
    ld b, 2
    ld hl, screen_table
    call get_array_item
    ld bc, (hl)
    ld hl, bc
    call call_hl

    ret
