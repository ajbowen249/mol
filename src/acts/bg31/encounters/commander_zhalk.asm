#define encounter_id_nautiloid_zhalk 1

.local
name_override: .asciz "Cmdr Zhalk"

encounter_commander_zhalk::
    ld hl, name_override
    ld bc, monster_class_cambion_name
    ld a, 10
    call copy_hl_bc

    ld a, 8
    ld (monster_class_cambion_level), a

    ld hl, (screen_controller_party)
    ld a, (screen_controller_party_size)
    ld bc, monster_class_cambion
    ld d, 1
    call battle_ui
    cp a, 0
    jp z, end

    ld a, 1
    ld (killed_zhalk), a

end:
    ret
.endlocal
