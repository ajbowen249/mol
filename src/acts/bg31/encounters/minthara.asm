#define encounter_id_minthara 4

.local
name_override: .asciz "Minthara"

encounter_minthara::
    ld hl, name_override
    ld bc, monster_drow_elf_name
    ld a, 10
    call copy_hl_bc

    ld a, 6
    ld (monster_drow_elf_level), a

    ld hl, (screen_controller_party)
    ld a, (screen_controller_party_size)
    ld bc, monster_drow_elf
    ld d, 1
    call battle_ui
    cp a, 0
    jp z, end

    ld a, 1
    ld (killed_minthara), a

end:
    ret
.endlocal
