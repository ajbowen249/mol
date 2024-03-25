#define encounter_id_nautiloid_zhalk 1

.local
encounter_commander_zhalk::
    ld hl, monster_class_cambion
    ld bc, enemy_player_1
    ld a, pl_data_size
    call copy_hl_bc

    ld hl, zhalk_combat_name
    ld bc, enemy_player_1_name
    ld a, 10
    call copy_hl_bc

    ld a, 8
    ld (enemy_player_1_level), a

    ld hl, monster_class_cambion
    ld bc, enemy_player_2
    ld a, pl_data_size
    call copy_hl_bc

    ld a, 2
    ld (enemy_party_size), a

    call start_encounter
    cp a, 0
    jp z, end

    ld a, 1
    ld (killed_zhalk), a

end:
    ret
.endlocal
