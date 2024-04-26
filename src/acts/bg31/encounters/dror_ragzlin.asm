#define encounter_id_dror_ragzlin 2

.local
encounter_dror_ragzlin::
    ld hl, monster_hobgoblin
    ld bc, enemy_player_1
    ld a, pl_data_size
    call copy_hl_bc

    ld hl, dror_combat_name
    ld bc, enemy_player_1_name
    ld a, 10
    call copy_hl_bc

    ld a, 5
    ld (enemy_player_1_level), a

    ld hl, monster_goblin
    ld bc, enemy_player_2
    ld a, pl_data_size
    call copy_hl_bc

    ld hl, monster_goblin
    ld bc, enemy_player_3
    ld a, pl_data_size
    call copy_hl_bc

    ld hl, monster_goblin
    ld bc, enemy_player_4
    ld a, pl_data_size
    call copy_hl_bc

    ld a, 4
    ld (enemy_party_size), a

    call start_encounter
    cp a, 0
    jp z, end

    ld a, 1
    ld (killed_dror_ragzlin), a

    call award_goblin_general_kill_xp

end:
    ret
.endlocal
