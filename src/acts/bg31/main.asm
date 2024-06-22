; Dungeon Delver Engine Test Campaign
; This is a CRPG built on the Dungeon Delver Engine

#include "../../../build/generated/bg31/generated_header.asm"

; Keep this at the top; this is the entry point
    call main
    ret

#include "../../../build/generated/bg31/compressed_text.asm"
#include "../../common/common.asm"
#include "./global_data.asm"
#include "./dialog/dialog.asm"
#include "./screens/screen_table.asm"
#include "./encounters/encounter_table.asm"
#include "./new_game_menu.asm"

logo_uncompressed_3: .asciz "▌ ▐▌ ▐"
logo_uncompressed_4: .asciz "▌ ▐▌ ▐"
logo_uncompressed_5: .asciz "▘ ◥◤ ▝"

#define opt_new_game 0
#define opt_main_exit 1

main_menu:
.db opt_new_game
.db default_options_flags
.dw opt_new_game_label

.db opt_main_exit
.db default_options_flags
.dw opt_exit_label

main:
    ld a, 0
    ld (dde_should_exit), a

    call seed_random
    call register_campaign_extras
    call reset_game_state
    call reset_all_screens

    call rom_clear_screen
    BLOCK_PRINT logo_compressed, 17, 2
    PRINT_AT_LOCATION 4, 18, logo_uncompressed_3
    PRINT_AT_LOCATION 5, 18, logo_uncompressed_4
    PRINT_AT_LOCATION 6, 18, logo_uncompressed_5
    PRINT_COMPRESSED_AT_LOCATION 1, 1, act_1_text

    ld a, 2
    ld hl, main_menu
    ld b, 1
    ld c, 2
    call menu_ui

    cp a, opt_main_exit
    jp z, main_exit

    call new_game_menu

    ld hl, screen_table
    ld bc, encounter_table
    ld de, player_party
    ld a, (party_size)
    call configure_screen_controller

    ld a, screen_id_cs_opening
    ld (last_room), a
    ld b, a
    ld a, ec_door
    call set_screen_exit_conditions

    call run_screen_controller

main_exit:
    call rom_clear_screen
    ret
