.local
dialog_1:
.asciz "Kagha, self-named"
.asciz "First Druid, regards"
.asciz "you coldly."

dialog_leaders_alive_1:
.asciz "We're about to enact"
.asciz "the Rite of Thorns"
.asciz "and seal the grove,"
.asciz "so these followers"
.asciz "of the Absolute can"
.asciz "not harm us."

dialog_leaders_alive_2:
.asciz "If you defeat their"
.asciz "three generals, we"
.asciz "will stop. Else, I"
.asciz "suggest you leave."

dialog_leaders_dead:
.asciz "Kagha calls off the"
.asciz "rite. That evening,"
.asciz "a group of Teiflings"
.asciz "and Druids join your"
.asciz "camp to revel in the"
.asciz "goblins' defeat."

dialog_kagha::
    call clear_exploration_message_area
    BLOCK_PRINT dialog_1, 3, 21, 2
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

    BLOCK_PRINT dialog_leaders_dead, 6, 21, 2
    call stub_menu

kagha_done:
    call clear_exploration_message_area
    ret

leaders_alive:
    BLOCK_PRINT dialog_leaders_alive_1, 6, 21, 2
    call stub_menu

    call clear_exploration_message_area
    BLOCK_PRINT dialog_leaders_alive_2, 4, 21, 2
    call stub_menu

    jp kagha_done

.endlocal
