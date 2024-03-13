.local
intro:
.asciz "You see a mindflayer"
.asciz "locked in combat"
.asciz "with a Cambion."
.asciz "'Get to the"
.asciz "transponder! I'll"
.asciz "hold them off.'"

dialog_mindflayer_captain::
    BLOCK_PRINT intro, 6, 21, 2

    call await_any_keypress
    call clear_exploration_message_area
    ret
.endlocal
