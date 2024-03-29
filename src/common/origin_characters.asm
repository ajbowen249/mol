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

origin_character_table:
.dw origin_character_laezel
.dw origin_character_shadowheart
.dw origin_character_gale
.dw origin_character_karlach

.macro EMPTY_CHARACTER &LABEL
    DEFINE_PLAYER &LABEL, 0, 0, 0, 0, 0, 0, race_human, class_fighter, 1, "          "
.endm
