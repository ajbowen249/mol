#define encounter_id_goblins_at_the_gate 5

.local

encounter_goblins_at_the_gate::
    ld hl, monster_goblin
    ld bc, enemy_player_1
    ld a, pl_data_size
    call copy_hl_bc

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
    ld (killed_goblins_at_the_gate), a

    ld a, level_2_xp
    ld h, 1
    ld l, 1
    call add_xp_and_notify

end:
    ret
.endlocal
