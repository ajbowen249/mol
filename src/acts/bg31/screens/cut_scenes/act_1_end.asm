#define screen_id_cs_act_1_end 13

.local
cs_act_1_end::
    call rom_clear_screen
    BLOCK_PRINT end_text_1, 1, 1
    call await_any_keypress

    call rom_clear_screen
    BLOCK_PRINT end_text_2, 14, 4
    call await_any_keypress

    ld a, 1
    ld (dde_should_exit), a

    ld a, ec_door
    ld (last_screen_exit_code), a
    ld a, screen_id_underdark
    ld (last_screen_exit_argument), a
    ret
.endlocal
