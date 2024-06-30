on_duergar_guard:
    ld a, 7
    ld (screen_start_y), a
    ld a, 2
    ld (screen_start_x), a

    call dialog_grymforge_guard
    cp a, 0
    jp z, talk_guard_done

    EXIT_EXPLORATION ec_encounter, encounter_id_nere

talk_guard_done:
    ret

init_screen:
    CLEAR_INTERACTABLE_IF_FLAG killed_nere, duergar_guard, screen_background
    ret

reset_underdark::
    RESET_SCREEN screen_data, 17, 7
    ld a, "옷"
    ld (screen_background + 148), a
    ret
