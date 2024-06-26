.local

dialog_kagha::
    call clear_exploration_message_area
    BLOCK_PRINT_EXPLORATION_MESSAGE kagha_dialog_1
    call stub_menu

    ld a, (kagha_interaction_complete)
    cp a, 0
    jp nz, kagha_done

    call clear_exploration_message_area
    call killed_all_goblin_leaders
    cp a, 0
    jp z, leaders_alive

    ld a, 1
    ld (kagha_interaction_complete), a

    BLOCK_PRINT_EXPLORATION_MESSAGE kagha_dialog_leaders_dead
    call stub_menu

    ; If you killed the leaders AND the goblins at the gate AND came all the way back here,
    ; this will total you up to level 5.
    call clear_exploration_message_area
    ld a, grove_party_xp
    call add_xp_and_notify_on_dialog_screen

kagha_done:
    call clear_exploration_message_area
    ret

leaders_alive:
    BLOCK_PRINT_EXPLORATION_MESSAGE kagha_dialog_leaders_alive_1
    call stub_menu

    call clear_exploration_message_area
    BLOCK_PRINT_EXPLORATION_MESSAGE kagha_dialog_leaders_alive_2
    call stub_menu

    jp kagha_done

.endlocal
