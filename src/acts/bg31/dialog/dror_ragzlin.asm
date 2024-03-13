.local
#define ddror_opt_attack 1
#define ddror_opt_ask_question 2
#define ddror_opt_turn_away 0

#define ask_question_wisdom_req 10

dialog_intro_1_line_1: .asciz "Dror Ragzlin, the"
dialog_intro_1_line_2: .asciz "Hobgoblin leader of"
dialog_intro_1_line_3: .asciz "this camp, glares at"
dialog_intro_1_line_4: .asciz "the corpse of a Mind"
dialog_intro_1_line_5: .asciz "flayer. 'True Soul,'"
dialog_intro_1_line_6: .asciz "he regards you."

dialog_intro_2_line_1: .asciz "He nods toward the"
dialog_intro_2_line_2: .asciz "corpse, and asks,"
dialog_intro_2_line_3: .asciz "telepathically, 'You"
dialog_intro_2_line_4: .asciz "ever talk to a dead"
dialog_intro_2_line_5: .asciz "squid? Now's your"
dialog_intro_2_line_6: .asciz "chance.'"

dialog_root_prompt_1: .asciz "You regognize the"
dialog_root_prompt_2: .asciz "Mindflayer from the"
dialog_root_prompt_3: .asciz "ship you escaped."

label_ask_corpse: .asciz "[W] Ask a question"

dialog_ask_success_1: .asciz "You and Dror speak"
dialog_ask_success_2: .asciz "until the spell"
dialog_ask_success_3: .asciz "wears off, but learn"
dialog_ask_success_4: .asciz "nothing useful."

dialog_ask_fail_1: .asciz "Your questions raise"
dialog_ask_fail_2: .asciz "suspicion in Dror's"
dialog_ask_fail_3: .asciz "mind, and he orders"
dialog_ask_fail_4: .asciz "an attack!"

dror_ragzlin_root:
.db ddror_opt_attack
.db default_options_flags
.dw str_attack

.db ddror_opt_ask_question
.db default_options_flags
.dw label_ask_corpse

.db ddror_opt_turn_away
.db default_options_flags
.dw str_turn_away

interact_choice: .db 0

stub_menu:
    ld a, 1
    ld hl, opt_stub
    ld b, 21
    ld c, 8
    call menu_ui
    ret

; returns non-zero in A if the player should start battle
dialog_dror_ragzlin::
    PRINT_AT_LOCATION 2, 21, dialog_intro_1_line_1
    PRINT_AT_LOCATION 3, 21, dialog_intro_1_line_2
    PRINT_AT_LOCATION 4, 21, dialog_intro_1_line_3
    PRINT_AT_LOCATION 5, 21, dialog_intro_1_line_4
    PRINT_AT_LOCATION 6, 21, dialog_intro_1_line_5
    PRINT_AT_LOCATION 7, 21, dialog_intro_1_line_6
    call stub_menu

    call clear_exploration_message_area

    PRINT_AT_LOCATION 2, 21, dialog_intro_2_line_1
    PRINT_AT_LOCATION 3, 21, dialog_intro_2_line_2
    PRINT_AT_LOCATION 4, 21, dialog_intro_2_line_3
    PRINT_AT_LOCATION 5, 21, dialog_intro_2_line_4
    PRINT_AT_LOCATION 6, 21, dialog_intro_2_line_5
    PRINT_AT_LOCATION 7, 21, dialog_intro_2_line_6
    call stub_menu

    call clear_exploration_message_area

    PRINT_AT_LOCATION 2, 21, dialog_root_prompt_1
    PRINT_AT_LOCATION 3, 21, dialog_root_prompt_2
    PRINT_AT_LOCATION 4, 21, dialog_root_prompt_3

    ld a, 3
    ld hl, dror_ragzlin_root
    ld b, 21
    ld c, 5
    call menu_ui

    cp a, ddror_opt_attack
    jp z, attack_dror

    cp a, ddror_opt_ask_question
    jp z, try_ask_question

    call clear_exploration_message_area
    ld a, 0
    ret

attack_dror:
    ld a, 1
    ret

try_ask_question:
    call clear_exploration_message_area
    ld a, skill_index_wis
    ld b, ask_question_wisdom_req
    ld hl, player_party
    ld d, 21
    ld e, 2
    call skill_check_ui
    cp a, 0
    jp nz, ask_success

    call await_any_keypress
    PRINT_AT_LOCATION 2, 21, dialog_ask_fail_1
    PRINT_AT_LOCATION 3, 21, dialog_ask_fail_2
    PRINT_AT_LOCATION 4, 21, dialog_ask_fail_3
    PRINT_AT_LOCATION 5, 21, dialog_ask_fail_4

    call await_any_keypress
    ld a, 1
    ret

ask_success:
    call await_any_keypress
    PRINT_AT_LOCATION 2, 21, dialog_ask_success_1
    PRINT_AT_LOCATION 3, 21, dialog_ask_success_2
    PRINT_AT_LOCATION 4, 21, dialog_ask_success_3
    PRINT_AT_LOCATION 5, 21, dialog_ask_success_4

    call await_any_keypress
    call clear_exploration_message_area
    ld a, 0
    ret
.endlocal
