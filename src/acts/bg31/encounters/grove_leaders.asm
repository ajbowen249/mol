#define encounter_id_grove_leaders 6

.local

    DEFINE_PLAYER enemy_zevlor, 16, 14, 15, 10, 11, 17, race_tiefling, class_fighter, 4, "Zevlor"
.db 0
.db 0
.db 0
.db 0

    DEFINE_PLAYER enemy_kagha, 16, 16, 14, 14, 16, 14, race_elf, class_fighter, 5, "Kagha"
.db 0
.db 0
.db 0
.db 0
.db 0

encounter_grove_leaders::
    ld hl, enemy_zevlor
    ld bc, enemy_player_1
    ld a, pl_data_size
    call copy_hl_bc

    ld hl, enemy_kagha
    ld bc, enemy_player_2
    ld a, pl_data_size
    call copy_hl_bc

    ld a, 2
    ld (enemy_party_size), a

    call start_encounter
    cp a, 0
    jp z, end

    ld a, 1
    ld (defeated_grove), a

    ld a, grove_kill_xp
    call add_xp_and_notify_on_victory_screen

end:
    ret
.endlocal
