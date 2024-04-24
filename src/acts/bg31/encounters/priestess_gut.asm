#define encounter_id_priestess_gut 3

.local
encounter_priestess_gut::
    ld hl, monster_goblin
    ld bc, enemy_player_1
    ld a, pl_data_size
    call copy_hl_bc

    ld hl, gut_name
    ld bc, enemy_player_1_name
    ld a, 10
    call copy_hl_bc

    ld a, 5
    ld (enemy_player_1_level), a

    ld hl, monster_goblin
    ld bc, enemy_player_2
    ld a, pl_data_size
    call copy_hl_bc

    ld a, 2
    ld (enemy_party_size), a

    call start_encounter
    cp a, 0
    jp z, end

    ld a, 1
    ld (killed_priestess_gut), a

    call award_goblin_general_xp

end:
    ret
.endlocal
