on_zevlor_auto_dialog:
    ld a, (minthara_started_attack)
    cp a, 0
    jp nz, attack_grove

    call dialog_zevlor_after_gag
    call init_screen
    ret

attack_grove:
    call dialog_grove_attack
    EXIT_EXPLORATION ec_encounter, encounter_id_grove_leaders

    ret

init_screen:
    CLEAR_INTERACTABLE_IF_FLAG spoke_with_zevlor_after_gag, zevlor_auto_dialog, screen_background

    CLEAR_INTERACTABLE_IF_FLAG defeated_grove, zevlor_auto_dialog, screen_background
    CLEAR_INTERACTABLE_IF_FLAG defeated_grove, kagha, screen_background

    ld a, (defeated_grove)
    cp a, 0
    jp z, check_game_state_done

    ld a, " "
    ld (screen_background + 24), a
    ld (screen_background + 33), a
    ld (screen_background + 36), a
    ld (screen_background + 86), a
    ld (screen_background + 110), a

check_game_state_done:
    ret

reset_emerald_grove::
    RESET_SCREEN screen_data, 4, 7
    ld a, "왓"
    ld (screen_background + 86), a
    ld (screen_background + 110), a

    ld a, "옷"
    ld (screen_background + 24), a
    ld (screen_background + 33), a
    ld (screen_background + 36), a
    ret
