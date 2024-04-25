#define encounter_id_nere 7

.local
encounter_nere::
    ld hl, monster_drow_elf
    ld bc, enemy_player_1
    ld a, pl_data_size
    call copy_hl_bc

    ld hl, nere_name
    ld bc, enemy_player_1_name
    ld a, 10
    call copy_hl_bc

    ld a, 19
    ld (enemy_player_1_level), a

    ld hl, monster_duergar
    ld bc, enemy_player_2
    ld a, pl_data_size
    call copy_hl_bc

    ld a, 2
    ld (enemy_party_size), a

    call start_encounter
    cp a, 0
    jp z, end

    ld a, 1
    ld (killed_nere), a

end:
    ret
.endlocal
