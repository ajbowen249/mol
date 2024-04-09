#define screen_id_cs_shadowheart_intro 7

.local

cs_shadowheart_intro::
    call rom_clear_screen
    BLOCK_PRINT shadowheart_cut_scene_1, 1, 1

    PRINT_AT_LOCATION 3, 18, artefact_sprite_1
    PRINT_AT_LOCATION 4, 18, artefact_sprite_2
    PRINT_AT_LOCATION 5, 18, artefact_sprite_3
    call await_any_keypress

    BLOCK_PRINT shadowheart_cut_scene_2, 1, 6
    call await_any_keypress

    ld a, ec_door
    ld (last_screen_exit_code), a
    ld a, screen_id_crash_site
    ld (last_screen_exit_argument), a
    ret
.endlocal
