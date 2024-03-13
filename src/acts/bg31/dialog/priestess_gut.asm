.local
#define dgut_opt_allow_brand 1
#define dgut_opt_attack 2
#define dgut_opt_turn_away 0

#define ask_question_wisdom_req 10

dialog_intro_1_line_1: .asciz "'Now, here's someone"
dialog_intro_1_line_2: .asciz "special. The"
dialog_intro_1_line_3: .asciz "Absolute has touched"
dialog_intro_1_line_4: .asciz "you, hasn't she?'"
dialog_intro_1_line_5: .asciz "asks Gut, the"
dialog_intro_1_line_6: .asciz "Goblin Priestess."

dialog_intro_2_line_1: .asciz "She means to mark"
dialog_intro_2_line_2: .asciz "your flesh as a sign"
dialog_intro_2_line_3: .asciz "of devotion."

label_allow_brand: .asciz "Allow it"

dialog_brand_result_1: .asciz "She brands your arm,"
dialog_brand_result_2: .asciz "and in the pain, you"
dialog_brand_result_3: .asciz "feel her tadpole"
dialog_brand_result_4: .asciz "commune with yours."

priestess_gut_root:
.db dgut_opt_allow_brand
.db default_options_flags
.dw label_allow_brand

.db dgut_opt_attack
.db default_options_flags
.dw str_attack

.db dgut_opt_turn_away
.db default_options_flags
.dw str_turn_away

interact_choice: .db 0

; returns non-zero in A if the player should start battle
dialog_priestess_gut::
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

    ld a, 3
    ld hl, priestess_gut_root
    ld b, 21
    ld c, 5
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
    PRINT_AT_LOCATION 2, 21, dialog_brand_result_1
    PRINT_AT_LOCATION 3, 21, dialog_brand_result_2
    PRINT_AT_LOCATION 4, 21, dialog_brand_result_3
    PRINT_AT_LOCATION 5, 21, dialog_brand_result_4

    call await_any_keypress
    call clear_exploration_message_area
    ld a, 0
    ret

.endlocal
