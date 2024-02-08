; Dungeon Delver Engine Test Campaign
; This is a CRPG built on the Dungeon Delver Engine

.org $C000

; Keep this at the top; this is the entry point
    call main
    ret

#include "../../common/common.asm"
#include "./constants.asm"
#include "./global_data.asm"
#include "./screen_1.asm"
#include "./screen_2.asm"

main:
    call seed_random

    ld hl, player_party
    call party_wizard
    cp a, 0
    jp nz, show_sheets
    ld a, 4

show_sheets:
    ld (party_size), a

    ld hl, test_character1
    call character_sheet_ui

    ld a, (party_size)
    cp a, 2
    jp m, sheets_done

    ld hl, test_character2
    call character_sheet_ui

    ld a, (party_size)
    cp a, 3
    jp m, sheets_done

    ld hl, test_character3
    call character_sheet_ui

    ld a, (party_size)
    cp a, 4
    jp m, sheets_done

    ld hl, test_character4
    call character_sheet_ui

sheets_done:

screen_loop:
    call screen_1

    ld a, (last_screen_exit_code)

    cp a, ec_npc
    jp z, test_npc_battle

    call screen_2
    ; screen 2 only has a door at the moment
    jp screen_loop

test_npc_battle:
    ld hl, player_party
    ld a, (party_size)
    ld bc, monster_badger
    ld d, 1
    call battle_ui
    jp screen_loop
    ret
