.local
dialog_1:
.asciz "The goblins and the"
.asciz "Generals have begun"
.asciz "their attack. As"
.asciz "they kill and raze,"
.asciz "Zevlor and Kagha"
.asciz "stand against you."

dialog_grove_attack::
    call clear_exploration_message_area
    BLOCK_PRINT dialog_1, 6, 21, 2
    call stub_menu
    call clear_exploration_message_area

    ret

.endlocal
