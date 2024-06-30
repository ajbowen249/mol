on_recruit_karlach:
    call dialog_recruit_karlach
    cp a, 0
    jp z, recruit_karlach_done

    ld a, 11
    ld (screen_start_x), a

    ld a, 3
    ld (screen_start_y), a
    EXIT_EXPLORATION ec_door, screen_id_blighted_village
    ret

recruit_karlach_done:
    ret

on_recruit_laezel:
    call dialog_recruit_laezel
    cp a, 0
    jp z, recruit_laezel_done

    ld a, 19
    ld (screen_start_x), a

    ld a, 5
    ld (screen_start_y), a
    EXIT_EXPLORATION ec_door, screen_id_blighted_village
    ret

recruit_laezel_done:
    ret

init_screen:
    call check_karlach
    call check_laezel
    ret

check_karlach:
    ld a, opt_oc_karlach
    call does_party_contain_origin_character_a
    jp nz, have_karlach
    ret

have_karlach:
    CLEAR_INTERACTABLE recruit_karlach, screen_background
    ret

check_laezel:
    ld a, opt_oc_laezel
    call does_party_contain_origin_character_a
    jp nz, have_laezel
    ret

have_laezel:
    CLEAR_INTERACTABLE recruit_laezel, screen_background
    ret

reset_blighted_village::
    RESET_SCREEN screen_data, 19, 4
    ld a, "옷"
    ld (screen_background + 51), a
    ld (screen_background + 123), a
    ret
