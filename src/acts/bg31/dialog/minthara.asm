.local

#define opt_minthara_attack 1
#define opt_minthara_turn_away 2
#define opt_minthara_show_grove 3

minthara_intro_1: .asciz "Minthara, the Drow"
minthara_intro_2: .asciz "General, greets you"
minthara_intro_3: .asciz "as a True Soul."

dialog_minthara::
    PRINT_AT_LOCATION 2, 21, minthara_intro_1
    PRINT_AT_LOCATION 3, 21, minthara_intro_2
    PRINT_AT_LOCATION 4, 21, minthara_intro_3
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

minthara_distrust_1: .asciz "'I don't trust you.'"

distrust_menu:
.db opt_minthara_attack
.db default_options_flags
.dw str_attack

.db opt_minthara_turn_away
.db default_options_flags
.dw str_turn_away

minthara_distrust:
    PRINT_AT_LOCATION 2, 21, minthara_distrust_1

    ld a, 2
    ld hl, distrust_menu
    ld b, 21
    ld c, 3
    call menu_ui

    cp a, opt_minthara_attack
    jp z, attack

    call clear_exploration_message_area

    ld a, 0
    ret

minthara_trust_1: .asciz "'We're ready to"
minthara_trust_2: .asciz "destroy the Druids."
minthara_trust_3: .asciz "Where is the grove?'"

show_grove_label: .asciz "Show her on the map"

trust_menu:
.db opt_minthara_show_grove
.db default_options_flags
.dw show_grove_label

.db opt_minthara_attack
.db default_options_flags
.dw str_attack

.db opt_minthara_turn_away
.db default_options_flags
.dw str_turn_away

minthara_trust:
    PRINT_AT_LOCATION 2, 21, minthara_trust_1
    PRINT_AT_LOCATION 3, 21, minthara_trust_2
    PRINT_AT_LOCATION 4, 21, minthara_trust_3

    ld a, 3
    ld hl, trust_menu
    ld b, 21
    ld c, 5
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

show_grove_response_1: .asciz "'Thank you. Meet us"
show_grove_response_2: .asciz "there.'"

show_grove:
    call clear_exploration_message_area
    PRINT_AT_LOCATION 2, 21, show_grove_response_1
    PRINT_AT_LOCATION 3, 21, show_grove_response_2

    call await_any_keypress
    call clear_exploration_message_area

    ld a, 0
    ret

.endlocal
