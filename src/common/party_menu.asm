.local
#define opt_exit 5

consolidated_menu:
.block mi_data_size * 5, 0

menu:
party_options:

party_option_0
.db 0
.db default_options_flags
party_label_0: .dw 0

party_option_1
.db 1
party_flags_1: .db 0
party_label_1: .dw 0

party_option_2
.db 2
party_flags_2: .db 0
party_label_2: .dw 0

party_option_3
.db 3
party_flags_3: .db 0
party_label_3: .dw 0

.db opt_exit
.db default_options_flags
.dw opt_exit_label

#define party_menu_options 5

party_menu::
    call setup_party_options

    call rom_clear_screen
    PRINT_COMPRESSED_AT_LOCATION 1, 1, party_menu_label

    ld a, party_menu_options
    ld hl, menu
    ld bc, consolidated_menu
    call consolidate_menu_hl_bc

    ld hl, consolidated_menu
    ld b, 1
    ld c, 2
    call menu_ui

    cp a, opt_exit
    jp z, menu_done

    ld hl, player_party
    ld b, a
    ld a, pl_data_size
    call get_array_item
    call character_sheet_ui

menu_done:
    ret

setup_party_options:
    ld a, 0
    ld (party_flags_1), a
    ld (party_flags_2), a
    ld (party_flags_3), a

    ld hl, party_member_0
    POINT_HL_TO_ATTR pl_offs_name
    ld (party_label_0), hl

    ld a, (party_size)
    cp a, 1
    jp z, setup_party_options_done

    ld hl, party_member_1
    POINT_HL_TO_ATTR pl_offs_name
    ld (party_label_1), hl
    ld a, default_options_flags
    ld (party_flags_1), a

    ld a, (party_size)
    cp a, 2
    jp z, setup_party_options_done

    ld hl, party_member_2
    POINT_HL_TO_ATTR pl_offs_name
    ld (party_label_2), hl
    ld a, default_options_flags
    ld (party_flags_2), a

    ld a, (party_size)
    cp a, 3
    jp z, setup_party_options_done

    ld hl, party_member_3
    POINT_HL_TO_ATTR pl_offs_name
    ld (party_label_3), hl
    ld a, default_options_flags
    ld (party_flags_3), a

setup_party_options_done:
    ret

.endlocal
