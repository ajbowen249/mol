#define encounter_id_dror_ragzlin 2

.local
name_override: .asciz "D. Ragzlin"

encounter_dror_ragzlin::
    ld hl, name_override
    ld bc, monster_hobgoblin_name
    ld a, 10
    call copy_hl_bc

    ld a, 5
    ld (monster_hobgoblin_level), a

    ld hl, (screen_controller_party)
    ld a, (screen_controller_party_size)
    ld bc, monster_hobgoblin
    ld d, 1
    call battle_ui
    cp a, 0
    jp z, end

    ld a, 1
    ld (killed_dror_ragzlin), a

end:
    ret
.endlocal
