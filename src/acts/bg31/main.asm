; Dungeon Delver Engine Test Campaign
; This is a CRPG built on the Dungeon Delver Engine

; Keep this at the top; this is the entry point
    call main
    ret

    INCLUDE_GENERATED_TEXT
#include "../../common/common.asm"
#include "./global_data.asm"
#include "./dialog/dialog.asm"
    INCLUDE_SCREEN_TABLE
#include "./screens/screen_helpers.asm"
#include "./encounters/encounter_table.asm"
#include "./new_game_menu.asm"

logo_uncompressed_3: .asciz "▌ ▐▌ ▐"
logo_uncompressed_4: .asciz "▌ ▐▌ ▐"
logo_uncompressed_5: .asciz "▘ ◥◤ ▝"

#define opt_new_game 0
#define opt_main_exit 1

#if dde_platform == platform_trs80_m100
#define MM_LOGO_ROW 2
#define MM_LOGO_COL 17
#define MM_MENU_ROW 2
#elif dde_platform == platform_zx_spectrum
#define MM_LOGO_ROW 4
#define MM_LOGO_COL 12
#define MM_MENU_ROW 10
#endif

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

    call clear_screen
    BLOCK_PRINT logo_compressed, MM_LOGO_COL, MM_LOGO_ROW
    PRINT_AT_LOCATION MM_LOGO_ROW + 2, MM_LOGO_COL + 1, logo_uncompressed_3
    PRINT_AT_LOCATION MM_LOGO_ROW + 3, MM_LOGO_COL + 1, logo_uncompressed_4
    PRINT_AT_LOCATION MM_LOGO_ROW + 4, MM_LOGO_COL + 1, logo_uncompressed_5
    PRINT_COMPRESSED_AT_LOCATION 1, 1, act_1_text

    ld a, 2
    ld hl, main_menu
    ld b, 1
    ld c, MM_MENU_ROW
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
    call clear_screen
    ret
