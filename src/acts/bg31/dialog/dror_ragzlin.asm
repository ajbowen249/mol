.local
#define ddror_opt_attack 1
#define ddror_opt_ask_question 2
#define ddror_opt_turn_away 0

#define ask_question_wisdom_req 10

label_ask_corpse: .asciz "[W] Ask a question"

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

; returns non-zero in A if the player should start battle
dialog_dror_ragzlin::
    BLOCK_PRINT dror_ragzlin_dialog_intro_1, 21, 2
    call stub_menu

    call clear_exploration_message_area

    BLOCK_PRINT dror_ragzlin_dialog_intro_2, 21, 2
    call stub_menu

    call clear_exploration_message_area

    BLOCK_PRINT dror_ragzlin_dialog_root_prompt, 21, 2

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
    BLOCK_PRINT dror_ragzlin_dialog_ask_fail, 21, 2

    call await_any_keypress
    ld a, 1
    ret

ask_success:
    call await_any_keypress
    BLOCK_PRINT dror_ragzlin_dialog_ask_success, 21, 2

    ld a, 1
    ld (helped_dror_question), a

    call await_any_keypress
    call clear_exploration_message_area
    ld a, 0
    ret
.endlocal
