.local

#define opt_root_create_character 0
#define opt_root_choose_origin_character 1

new_game_root:
.db opt_root_create_character
.db default_options_flags
.dw opt_create_character_label

.db opt_root_choose_origin_character
.db default_options_flags
.dw opt_choose_origin_character_label

#define new_game_root_options 2

choose_origin_character_menu:
.db opt_oc_laezel
.db default_options_flags
.dw name_laezel

.db opt_oc_shadowheart
.db default_options_flags
.dw name_shadowheart

.db opt_oc_gale
.db default_options_flags
.dw name_gale

.db opt_oc_karlach
.db default_options_flags
.dw name_karlach

#define choose_origin_character_menu_options 4

new_game_menu::
    call rom_clear_screen
    PRINT_COMPRESSED_AT_LOCATION 1, 1, opt_new_game_label

    ld a, new_game_root_options
    ld b, 1
    ld c, 2
    ld hl, new_game_root
    call menu_ui

    cp a, opt_root_create_character
    jp z, create_character

    call rom_clear_screen
    PRINT_COMPRESSED_AT_LOCATION 1, 1, opt_choose_origin_character_label

    ld a, choose_origin_character_menu_options
    ld b, 1
    ld c, 2
    ld hl, choose_origin_character_menu
    call menu_ui

    ld hl, origin_character_table
    ld b, a
    ld a, 2
    call get_array_item
    ld bc, (hl)
    ld hl, bc

    ld bc, party_member_0
    ld a, pl_data_size
    call copy_hl_bc

    jp new_game_menu_done

create_character:
    ld hl, party_member_0
    call character_wizard

new_game_menu_done:

    ld a, 1
    ld (party_size), a

    ret
.endlocal
