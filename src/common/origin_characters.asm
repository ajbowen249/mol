    DEFINE_PLAYER origin_character_laezel, 17, 13, 14, 11, 12, 8, race_githyanki, class_fighter, 1, "Lae'zel"
.db 0
.db 0
.db 0

    DEFINE_PLAYER origin_character_shadowheart, 12, 14, 14, 10, 16, 10, race_half_elf, class_cleric, 1, "Shadwheart"

    DEFINE_PLAYER origin_character_gale, 9, 14, 15, 16, 11, 13, race_human, class_wizard, 1, "Gale"
.db 0
.db 0
.db 0
.db 0
.db 0
.db 0

    DEFINE_PLAYER origin_character_karlach, 17, 13, 14, 11, 12, 8, race_tiefling, class_barbarian, 1, "Karlach"
.db 0
.db 0
.db 0

#define opt_oc_laezel 0
#define opt_oc_shadowheart 1
#define opt_oc_gale 2
#define opt_oc_karlach 3

#define opt_oc_invalid 255

origin_character_table:
.dw origin_character_laezel
.dw origin_character_shadowheart
.dw origin_character_gale
.dw origin_character_karlach

.macro EMPTY_CHARACTER &LABEL
    DEFINE_PLAYER &LABEL, 0, 0, 0, 0, 0, 0, race_human, class_fighter, 1, "          "
.endm

choose_origin_character_menu:
.db opt_oc_laezel
opt_oc_laezel_flags: .db default_options_flags
.dw name_laezel

.db opt_oc_shadowheart
opt_oc_shadowheart_flags: .db default_options_flags
.dw name_shadowheart

.db opt_oc_gale
opt_oc_gale_flags: .db default_options_flags
.dw name_gale

.db opt_oc_karlach
opt_oc_karlach_flags: .db default_options_flags
.dw name_karlach

.db opt_oc_invalid
opt_oc_done_flags: .db default_options_flags
.dw str_done

#define choose_origin_character_menu_options 5

.local
enable_default_origin_character_menu::
    ld a, default_options_flags
    ld (opt_oc_laezel_flags), a
    ld (opt_oc_shadowheart_flags), a
    ld (opt_oc_gale_flags), a
    ld (opt_oc_karlach_flags), a

    ld a, 0
    ld (opt_oc_done_flags), a
    ret
.endlocal

.local
; "recruits" the origin character in a
; returns early if the party is full
recruit_origin_character::
    ld b, a

    ld a, (party_size)
    cp a, 4
    jp z, recruit_origin_character_end

    ld hl, origin_character_table
    ld a, 2
    call get_array_item
    ld bc, (hl)
    push bc

    ld a, (party_size)
    ld b, a
    ld a, pl_data_size
    ld hl, player_party
    call get_array_item

    ld bc, hl
    pop hl
    ld a, pl_data_size
    call copy_hl_bc

    ld a, (party_size)
    inc a
    ld (party_size), a
    ld (screen_controller_party_size), a

recruit_origin_character_end:
    ld a, (party_member_0_level)
    ld (party_member_1_level), a
    ld (party_member_2_level), a
    ld (party_member_3_level), a
    ret
.endlocal

.local
is_player_using_origin_character_a::
    ld b, a

    ld a, (is_using_origin_character)
    cp a, 0
    jp z, not_using_character

    ld a, (selected_origin_character_index)
    cp a, b
    jp nz, not_using_character

    ld a, 1
    ret

not_using_character:
    ld a, 0
    ret
.endlocal

.local
does_party_contain_origin_character_a::
    ld b, 0
    ld c, a

    push bc
    call is_player_using_origin_character_a
    pop bc

    cp a, 0
    jp nz, is_using_character

    ld hl, recruited_characters
    add hl, bc
    ld a, (hl)
    cp a, 0
    jp nz, is_using_character

    ld a, 0
    ret

is_using_character:
    ld a, 1
    ret
.endlocal
