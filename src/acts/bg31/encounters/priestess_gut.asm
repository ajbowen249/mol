#define encounter_id_priestess_gut 3

.local
name_override: .asciz "Gut"

encounter_priestess_gut::
    ld hl, name_override
    ld bc, monster_goblin_name
    ld a, 10
    call copy_hl_bc

    ld a, 5
    ld (monster_goblin_level), a

    ld hl, (screen_controller_party)
    ld a, (screen_controller_party_size)
    ld bc, monster_goblin
    ld d, 1
    call battle_ui
    cp a, 0
    jp z, end

    ld a, 1
    ld (killed_priestess_gut), a

end:
    ret
.endlocal
