cs_opening::
    call clear_screen
    BLOCK_PRINT opening_text_1, 1, 1
    call await_any_keypress

    call clear_screen
    BLOCK_PRINT opening_text_2, 1, 1
    call await_any_keypress

    call clear_screen
    BLOCK_PRINT opening_text_3, 1, 1
    call await_any_keypress

    call clear_screen
    BLOCK_PRINT opening_text_4, 1, 1
    call await_any_keypress

    ld a, ec_door
    ld (last_screen_exit_code), a
    ld a, screen_id_nautiloid_bridge
    ld (last_screen_exit_argument), a
    ret
