player_party:
    DEFINE_PLAYER test_character1, 15, 8, 5, 5, 4, 8, race_human, class_barbarian, 1, "Fronk"
.db 0
.db 0
.db 0
.db 0
.db 0
    DEFINE_PLAYER test_character2, 8, 10, 8, 6, 8, 7, race_elf, class_cleric, 1, "Elfo"
.db 0
.db 0
.db 0
.db 0
.db 0
.db 0
    DEFINE_PLAYER test_character3, 15, 8, 5, 5, 4, 8, race_dwarf, class_fighter, 1, "Grumble"
.db 0
.db 0
.db 0
    DEFINE_PLAYER test_character4, 4, 5, 6, 11, 12, 6, race_half_elf, class_wizard, 1, "McZappy"
.db 0
.db 0
.db 0

party_size: .db 0

    DEFINE_PLAYER test_npc_1, 15, 8, 5, 5, 4, 8, race_human, class_barbarian, 1, "Bossman"
.db 0
.db 0
.db 0

last_screen_exit_code: .db 0
last_screen_exit_argument: .db 0
