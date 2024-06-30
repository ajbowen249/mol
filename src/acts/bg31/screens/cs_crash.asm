cs_crash::
    call clear_screen
    BLOCK_PRINT crash_text_1, 1, 1
    call await_any_keypress

    ld a, ec_door
    ld (last_screen_exit_code), a
    ld a, screen_id_crash_site
    ld (last_screen_exit_argument), a
    ret
