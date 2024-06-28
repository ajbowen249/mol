#define screen_id_cs_act_1_end 13

.local
cs_act_1_end::
    call clear_screen
    BLOCK_PRINT end_text_1, 1, 1
    call await_any_keypress

    call clear_screen
#if dde_platform == platform_trs80_m100
    BLOCK_PRINT end_text_2, 14, 4
#elif dde_platform == platform_zx_spectrum
    BLOCK_PRINT end_text_2, 10, 12
#endif
    call await_any_keypress

    ld a, 1
    ld (dde_should_exit), a

    ld a, ec_door
    ld (last_screen_exit_code), a
    ld a, screen_id_underdark
    ld (last_screen_exit_argument), a
    ret
.endlocal
