on_dror_ragzlin:
    ld a, 4
    ld (screen_start_y), a
    ld a, 10
    ld (screen_start_x), a

    call dialog_dror_ragzlin
    cp a, 0
    jp z, dror_done

    EXIT_EXPLORATION ec_encounter, encounter_id_dror_ragzlin

dror_done:
    ret

on_priestess_gut:
    ld a, 5
    ld (screen_start_y), a
    ld a, 3
    ld (screen_start_x), a

    call dialog_priestess_gut
    cp a, 0
    jp z, gut_done

    EXIT_EXPLORATION ec_encounter, encounter_id_priestess_gut
    ret

gut_done:
    call init_screen
    ret

on_minthara:
    ld a, 3
    ld (screen_start_y), a
    ld a, 18
    ld (screen_start_x), a

    call dialog_minthara
    cp a, 0
    jp z, minthara_done

    EXIT_EXPLORATION ec_encounter, encounter_id_minthara

minthara_done:
    ret

init_screen:
    CLEAR_INTERACTABLE_IF_FLAG killed_dror_ragzlin, dror_ragzlin, screen_background
    CLEAR_INTERACTABLE_IF_FLAG killed_priestess_gut, priestess_gut, screen_background
    CLEAR_INTERACTABLE_IF_FLAG killed_minthara, minthara, screen_background

    CLEAR_GRAPHIC_IF_FLAG killed_priestess_gut, 3, 3, screen_background
    CLEAR_GRAPHIC_IF_FLAG have_brand_of_the_absolute, 3, 3, screen_background
    ret

reset_goblin_camp::
    RESET_SCREEN screen_data, 10, 7
    ld a, "왓"
    ld (screen_background + 38), a
    ld (screen_background + 51), a
    ld (screen_background + 85), a

    ld a, "│"
    ld (screen_background + 44), a
    ret
