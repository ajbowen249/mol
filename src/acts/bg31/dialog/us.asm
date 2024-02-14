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

    call clear_exploration_message_area

    ret
.endlocal
