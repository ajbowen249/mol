.local
#define opt_us_root_extract_brain 1
#define opt_us_root_smash_skull 2
#define opt_us_root_leave_alone 0

us_root:
.db opt_us_root_extract_brain
.db default_options_flags
.dw us_label_prise_free

.db opt_us_root_smash_skull
.db default_options_flags
.dw us_label_smash_skull

.db opt_us_root_leave_alone
.db default_options_flags
.dw us_label_leave_alone

interact_choice: .db 0

dialog_us::
    BLOCK_PRINT us_dialog_intro_1, 21, 2

    ld a, 1
    ld hl, opt_stub
    ld b, 21
    ld c, 5
    call menu_ui

    call clear_exploration_message_area

    BLOCK_PRINT us_dialog_intro_2, 21, 2

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
    BLOCK_PRINT us_dialog_outro_success, 21, 2
    jp us_end

free_fail:
    call display_result
    BLOCK_PRINT us_dialog_outro_fail, 21, 2

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
