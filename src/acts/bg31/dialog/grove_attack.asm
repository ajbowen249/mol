.local

dialog_grove_attack::
    call clear_exploration_message_area
    BLOCK_PRINT grove_attack_dialog, 21, 2
    call stub_menu
    call clear_exploration_message_area

    ret

.endlocal
