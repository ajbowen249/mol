.local

dialog_kagha::
    call clear_exploration_message_area
    BLOCK_PRINT kagha_dialog_1, 21, 2
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

    BLOCK_PRINT kagha_dialog_leaders_dead, 21, 2
    call stub_menu

kagha_done:
    call clear_exploration_message_area
    ret

leaders_alive:
    BLOCK_PRINT kagha_dialog_leaders_alive_1, 21, 2
    call stub_menu

    call clear_exploration_message_area
    BLOCK_PRINT kagha_dialog_leaders_alive_2, 21, 2
    call stub_menu

    jp kagha_done

.endlocal
