.local

dialog_grove_attack::
    call clear_exploration_message_area
    BLOCK_PRINT_EXPLORATION_MESSAGE grove_attack_dialog
    call stub_menu
    call clear_exploration_message_area

    ret

.endlocal
