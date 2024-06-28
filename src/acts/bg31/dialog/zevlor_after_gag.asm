.local

dialog_zevlor_after_gag::
    ld a, 1
    ld (spoke_with_zevlor_after_gag), a

    call clear_exploration_message_area
    BLOCK_PRINT_EXPLORATION_MESSAGE zevlor_dialog_1
    call stub_menu

    call clear_exploration_message_area
    BLOCK_PRINT_EXPLORATION_MESSAGE zevlor_dialog_2
    call stub_menu

    call clear_exploration_message_area
    BLOCK_PRINT_EXPLORATION_MESSAGE zevlor_dialog_3
    call stub_menu

    call clear_exploration_message_area

    call killed_all_goblin_leaders
    cp a, 0
    jp z, leaders_alive

    BLOCK_PRINT_EXPLORATION_MESSAGE zevlor_dialog_leaders_dead
    call stub_menu
    call clear_exploration_message_area

    ret

leaders_alive:
    BLOCK_PRINT_EXPLORATION_MESSAGE zevlor_dialog_leaders_alive
    call stub_menu
    call clear_exploration_message_area
    ret

.endlocal
