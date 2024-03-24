.local
#define gguard_opt_help 1
#define gguard_opt_turn_away 0

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
    BLOCK_PRINT grymforge_guard_dialog_intro_1, 21, 2
    call stub_menu

    call clear_exploration_message_area
    BLOCK_PRINT grymforge_guard_dialog_intro_2, 21, 2
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
    BLOCK_PRINT grymforge_guard_dialog_help_1, 21, 2
    call stub_menu

    call clear_exploration_message_area
    BLOCK_PRINT grymforge_guard_dialog_help_2, 21, 2
    call stub_menu

    ld a, 1
    ret
.endlocal
