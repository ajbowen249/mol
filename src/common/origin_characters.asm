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
