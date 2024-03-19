.local
dialog_1:
.asciz "You are greeted by a"
.asciz "Tiefling named"
.asciz "Zevlor, who thanks"
.asciz "you for your help."
.asciz "He tells you of his"
.asciz "group's struggle."

dialog_2:
.asciz "They are refugees,"
.asciz "seeking temporary"
.asciz "shelter in the grove"
.asciz "as they escape the"
.asciz "destruction of their"
.asciz "home city, Elturel."

dialog_3:
.asciz "The grove is home to"
.asciz "the druids. Some of"
.asciz "them are kind, or at"
.asciz "least sympathetic."
.asciz "Others are less so."

dialog_leaders_alive:
.asciz "The goblins at the"
.asciz "gate came from a"
.asciz "camp to the west. If"
.asciz "their leaders aren't"
.asciz "killed, the Druids"
.asciz "will seal the Grove."

dialog_leaders_dead:
.asciz "You tell Zevlor of"
.asciz "the three generals"
.asciz "you defeated at the"
.asciz "Goblin camp. He asks"
.asciz "you to inform the"
.asciz "Druid leader, Kagha."

dialog_zevlor_after_gag::
    ld a, 1
    ld (spoke_with_zevlor_after_gag), a

    call clear_exploration_message_area
    BLOCK_PRINT dialog_1, 6, 21, 2
    call stub_menu

    call clear_exploration_message_area
    BLOCK_PRINT dialog_2, 6, 21, 2
    call stub_menu

    call clear_exploration_message_area
    BLOCK_PRINT dialog_3, 5, 21, 2
    call stub_menu

    call clear_exploration_message_area

    call killed_all_goblin_leaders
    cp a, 0
    jp z, leaders_alive

    BLOCK_PRINT dialog_leaders_dead, 6, 21, 2
    call stub_menu
    call clear_exploration_message_area

    ret

leaders_alive:
    BLOCK_PRINT dialog_leaders_alive, 6, 21, 2
    call stub_menu
    call clear_exploration_message_area
    ret

.endlocal
