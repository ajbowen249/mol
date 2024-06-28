.local

#define opt_minthara_attack 1
#define opt_minthara_turn_away 2
#define opt_minthara_show_grove 3

dialog_minthara::
    BLOCK_PRINT_EXPLORATION_MESSAGE minthara_intro
    call stub_menu

    call clear_exploration_message_area

    ld a, (helped_dror_question)
    cp a, 0
    jp z, minthara_distrust

    ld a, (have_brand_of_the_absolute)
    cp a, 0
    jp z, minthara_distrust

    jp minthara_trust

    ret

distrust_menu:
.db opt_minthara_attack
.db default_options_flags
.dw str_attack

.db opt_minthara_turn_away
.db default_options_flags
.dw str_turn_away

minthara_distrust:
    BLOCK_PRINT_EXPLORATION_MESSAGE minthara_distrust_line

    ld a, 2
    ld hl, distrust_menu
    ld b, ex_message_col
    ld c, ex_message_row + 2
    call menu_ui

    cp a, opt_minthara_attack
    jp z, attack

    call clear_exploration_message_area

    ld a, 0
    ret

trust_menu:
.db opt_minthara_show_grove
.db default_options_flags
.dw minthara_show_grove_label

.db opt_minthara_attack
.db default_options_flags
.dw str_attack

.db opt_minthara_turn_away
.db default_options_flags
.dw str_turn_away

minthara_trust:
    BLOCK_PRINT_EXPLORATION_MESSAGE minthara_trust_dialog

    ld a, 3
    ld hl, trust_menu
    ld b, ex_message_col
    ld c, ex_message_row + 4
    call menu_ui

    cp a, opt_minthara_attack
    jp z, attack

    cp a, opt_minthara_show_grove
    jp z, show_grove

    call clear_exploration_message_area

    ld a, 0
    ret

attack:
    ld a, 1
    ret

show_grove:
    ld a, 1
    ld (minthara_started_attack), a
    call clear_exploration_message_area
    BLOCK_PRINT_EXPLORATION_MESSAGE minthara_show_grove_response

    call await_any_keypress
    call clear_exploration_message_area
    call award_goblin_general_help_xp
    call clear_exploration_message_area

    ld a, 0
    ret

.endlocal
