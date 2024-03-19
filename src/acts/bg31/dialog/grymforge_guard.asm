.local
#define gguard_opt_help 1
#define gguard_opt_turn_away 0

dialog_intro_1:
.asciz "A Duergar dwarf"
.asciz "stands at the path"
.asciz "to the Shadow-Cursed"
.asciz "Lands. 'You'll need"
.asciz "protection to go any"
.asciz "farther,' he says."

dialog_intro_2:
.asciz "'Some of our miners"
.asciz "and a True Soul were"
.asciz "trapped in an"
.asciz "accident. Free them,"
.asciz "and we'll give you a"
.asciz "Moon Lantern.'"

dialog_help_1:
.asciz "You follow the guard"
.asciz "into this fortress,"
.asciz "the Grymforge. Once"
.asciz "inside, and with the"
.asciz "help of explosives,"
.asciz "everyone is freed."

dialog_help_2:
.asciz "The True Soul, Nere,"
.asciz "berates the enslaved"
.asciz "gnomes, killing some"
.asciz "in his rage. He then"
.asciz "orders an attack on"
.asciz "your party."

grymforge_guard_menu:
.db gguard_opt_help
.db default_options_flags
.dw str_help

.db gguard_opt_turn_away
.db default_options_flags
.dw str_turn_away

interact_choice: .db 0

; returns non-zero in A if the player should start battle
dialog_grymforge_guard::
    BLOCK_PRINT dialog_intro_1, 6, 21, 2
    call stub_menu

    call clear_exploration_message_area
    BLOCK_PRINT dialog_intro_2, 6, 21, 2
    call stub_menu

    call clear_exploration_message_area

    ld a, 2
    ld hl, grymforge_guard_menu
    ld b, 21
    ld c, 5
    call menu_ui

    cp a, gguard_opt_help
    jp z, help_grymforge

    call clear_exploration_message_area
    ld a, 0
    ret

help_grymforge:
    call clear_exploration_message_area
    BLOCK_PRINT dialog_help_1, 6, 21, 2
    call stub_menu

    call clear_exploration_message_area
    BLOCK_PRINT dialog_help_2, 6, 21, 2
    call stub_menu

    ld a, 1
    ret
.endlocal
