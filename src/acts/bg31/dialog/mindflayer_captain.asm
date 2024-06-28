.local
dialog_mindflayer_captain::
    BLOCK_PRINT_EXPLORATION_MESSAGE mindflayer_captain_intro

    call await_any_keypress
    call clear_exploration_message_area
    ret
.endlocal
