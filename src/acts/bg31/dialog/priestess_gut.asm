.local
#define dgut_opt_allow_brand 1
#define dgut_opt_attack 2
#define dgut_opt_turn_away 0

priestess_gut_root:
.db dgut_opt_allow_brand
.db default_options_flags
.dw gut_label_allow_brand

.db dgut_opt_attack
.db default_options_flags
.dw str_attack

.db dgut_opt_turn_away
.db default_options_flags
.dw str_turn_away

interact_choice: .db 0

; returns non-zero in A if the player should start battle
dialog_priestess_gut::
    BLOCK_PRINT_EXPLORATION_MESSAGE gut_dialog_intro_1
    call stub_menu

    call clear_exploration_message_area

    BLOCK_PRINT_EXPLORATION_MESSAGE gut_dialog_intro_2

    ld a, 3
    ld hl, priestess_gut_root
    ld b, ex_message_col
    ld c, ex_message_row + 4
    call menu_ui

    cp a, dgut_opt_attack
    jp z, attack_gut

    cp a, dgut_opt_allow_brand
    jp z, allow_brand

    call clear_exploration_message_area
    ld a, 0
    ret

attack_gut:
    ld a, 1
    ret

allow_brand:
    ld a, 1
    ld (have_brand_of_the_absolute), a

    call clear_exploration_message_area
    BLOCK_PRINT_EXPLORATION_MESSAGE gut_dialog_brand_result

    call await_any_keypress
    call clear_exploration_message_area

    call award_goblin_general_help_xp
    call clear_exploration_message_area

    ld a, 0
    ret

.endlocal
