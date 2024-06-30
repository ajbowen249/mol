init_screen:
    ld a, (killed_goblins_at_the_gate)
    cp a, 0
    jp nz, clear_goblins

    ld a, (minthara_started_attack)
    cp a, 0
    jp nz, clear_goblins

    ret

clear_goblins:
    ld a, (fight_1_flags)
    and a, $7f
    ld (fight_1_flags), a
    ld (fight_2_flags), a
    ld (fight_3_flags), a
    ld (fight_4_flags), a
    ld (fight_5_flags), a
    ld (fight_6_flags), a

    ld a, " "
    ld hl, screen_background
    ld bc, 23
    add hl, bc
    ld (hl), a
    inc hl
    ld (hl), a
    inc hl
    ld (hl), a

    ld hl, screen_background
    ld bc, 3
    add hl, bc
    ld (hl), a

    ret

on_fight_1:
on_fight_2:
on_fight_3:
on_fight_4:
on_fight_5:
on_fight_6:
    ld a, 4
    ld (screen_start_x), a

    ld a, 4
    ld (screen_start_y), a

    call dialog_goblins_at_the_gate
    cp a, 0
    jp z, goblins_done

    EXIT_EXPLORATION ec_encounter, encounter_id_goblins_at_the_gate

goblins_done:
    ret


reset_emerald_grove_environs::
    RESET_SCREEN screen_data, 13, 7
    ld a, "왓"
    ld (screen_background + 23), a
    ld (screen_background + 24), a
    ld (screen_background + 25), a
    ret
