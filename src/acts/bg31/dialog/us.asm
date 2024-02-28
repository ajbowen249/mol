.local
us_interaction_header: .asciz "Operating Table"

#define opt_us_root_extract_brain 1
#define opt_us_root_smash_skull 2
#define opt_us_root_leave_alone 0

dialog_us_intro_1_line_1: .asciz "You see an elf on"
dialog_us_intro_1_line_2: .asciz "the table with his"
dialog_us_intro_1_line_3: .asciz "brain exposed."

dialog_us_intro_2_line_1: .asciz "In your mind, you"
dialog_us_intro_2_line_2: .asciz "hear it cry, 'Free"
dialog_us_intro_2_line_3: .asciz "Us!'"

label_prise_free: .asciz "[D]Gently prise it"
label_smash_skull: .asciz "[S]Smash the skull"
label_leave_alone: .asciz "Leave it alone"

dialog_us_outro_fail_1: .asciz "'Aaahhhh!'"
dialog_us_outro_fail_2: .asciz "The creature's"
dialog_us_outro_fail_3: .asciz "thoughts fade away."

dialog_us_outro_success_1: .asciz "'Thank you!'"
dialog_us_outro_success_2: .asciz "A brain with legs"
dialog_us_outro_success_3: .asciz "emerges from the"
dialog_us_outro_success_4: .asciz "skull, and scampers"
dialog_us_outro_success_5: .asciz "ahead."

us_root:
.db opt_us_root_extract_brain
.db default_options_flags
.dw label_prise_free

.db opt_us_root_smash_skull
.db default_options_flags
.dw label_smash_skull

.db opt_us_root_leave_alone
.db default_options_flags
.dw label_leave_alone

interact_choice: .db 0

dialog_us::
    PRINT_AT_LOCATION 2, 21, dialog_us_intro_1_line_1
    PRINT_AT_LOCATION 3, 21, dialog_us_intro_1_line_2
    PRINT_AT_LOCATION 4, 21, dialog_us_intro_1_line_3

    ld a, 1
    ld hl, opt_stub
    ld b, 21
    ld c, 5
    call menu_ui

    call clear_exploration_message_area

    PRINT_AT_LOCATION 2, 21, dialog_us_intro_2_line_1
    PRINT_AT_LOCATION 3, 21, dialog_us_intro_2_line_2
    PRINT_AT_LOCATION 4, 21, dialog_us_intro_2_line_3

    ld a, 3
    ld hl, us_root
    ld b, 21
    ld c, 5
    call menu_ui

    ld (interact_choice), a

    call clear_exploration_message_area

    ld a, (interact_choice)

    cp a, opt_us_root_extract_brain
    jp z, try_extract_brain

    cp a, opt_us_root_smash_skull
    jp z, try_smash_skull

    call clear_exploration_message_area

    ret

try_extract_brain:
    ld a, skill_index_dex
    ld b, 18
    ld hl, player_party
    ld d, 21
    ld e, 2
    call skill_check_ui
    cp a, 0
    jp nz, free_success
    jp free_fail
    ret

try_smash_skull:
    ld a, skill_index_str
    ld b, 18
    ld hl, player_party
    ld d, 21
    ld e, 2
    call skill_check_ui
    cp a, 0
    jp nz, free_success
    jp free_fail
    ret

free_success:
    ld a, 1
    ld (freed_us), a
    call display_result
    PRINT_AT_LOCATION 2, 21, dialog_us_outro_success_1
    PRINT_AT_LOCATION 3, 21, dialog_us_outro_success_2
    PRINT_AT_LOCATION 4, 21, dialog_us_outro_success_3
    PRINT_AT_LOCATION 5, 21, dialog_us_outro_success_4
    PRINT_AT_LOCATION 6, 21, dialog_us_outro_success_5
    jp us_end

free_fail:
    call display_result
    PRINT_AT_LOCATION 2, 21, dialog_us_outro_fail_1
    PRINT_AT_LOCATION 3, 21, dialog_us_outro_fail_2
    PRINT_AT_LOCATION 4, 21, dialog_us_outro_fail_3

us_end:
    ; blank our the interactable
    ld hl, (interactable_us_loc)
    ld (hl), 0
    inc hl
    ld (hl), 0
    inc hl
    ld (hl), 0
    inc hl
    ld (hl), 0
    ret

display_result:
    call await_any_keypress
    call clear_exploration_message_area
    ret
.endlocal
