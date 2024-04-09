#define screen_id_cs_recruit_shadowheart 6

.local

cs_recruit_shadowheart::
    call rom_clear_screen
    BLOCK_PRINT recruit_shadowheart_text_1, 1, 1
    call await_any_keypress

    PRINT_AT_LOCATION 5, 7, artefact_sprite_1
    PRINT_AT_LOCATION 6, 7, artefact_sprite_2
    PRINT_AT_LOCATION 7, 7, artefact_sprite_3

    call await_any_keypress

    BLOCK_PRINT recruit_shadowheart_text_2, 12, 5
    call await_any_keypress

    ld a, opt_oc_shadowheart
    call recruit_origin_character

    ld a, 1
    ld (recruited_shadowheart), a

    ld a, ec_door
    ld (last_screen_exit_code), a
    ld a, screen_id_crash_site
    ld (last_screen_exit_argument), a
    ret
.endlocal
