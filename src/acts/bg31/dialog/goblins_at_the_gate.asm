.local
#define gag_opt_attack 1
#define gag_opt_turn_away 2

dialog_intro_1:
.asciz "A cadre of Goblins"
.asciz "is attacking a group"
.asciz "of Tieflings and"
.asciz "Druids."

dialog_intro_2: .asciz "Will you intervene?"

goblins_at_the_gate_menu:
.db gag_opt_attack
.db default_options_flags
.dw str_attack

.db gag_opt_turn_away
.db default_options_flags
.dw str_turn_away

; returns non-zero in A if the player should start battle
dialog_goblins_at_the_gate::
    BLOCK_PRINT dialog_intro_1, 4, 21, 2
    call stub_menu

    call clear_exploration_message_area

    PRINT_AT_LOCATION 2, 21, dialog_intro_2

    ld a, 2
    ld hl, goblins_at_the_gate_menu
    ld b, 21
    ld c, 3
    call menu_ui

    cp a, gag_opt_attack
    jp z, attack

    call clear_exploration_message_area
    ld a, 0
    ret

attack:
    ld a, 1
    ret

.endlocal
