.local
intro_1_line_1: .asciz "You see a mindflayer"
intro_1_line_2: .asciz "locked in combat"
intro_1_line_3: .asciz "with a Cambion."
intro_1_line_4: .asciz "'Get to the"
intro_1_line_5: .asciz "transponder! I'll"
intro_1_line_6: .asciz "hold them off.'"

dialog_mindflayer_captain::
    PRINT_AT_LOCATION 2, 21, intro_1_line_1
    PRINT_AT_LOCATION 3, 21, intro_1_line_2
    PRINT_AT_LOCATION 4, 21, intro_1_line_3
    PRINT_AT_LOCATION 5, 21, intro_1_line_4
    PRINT_AT_LOCATION 6, 21, intro_1_line_5
    PRINT_AT_LOCATION 7, 21, intro_1_line_6

read_loop:
    call rom_kyread
    jp z, read_loop
    call clear_exploration_message_area
    ret
.endlocal
