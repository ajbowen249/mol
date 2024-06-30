#if dde_platform == platform_trs80_m100
#define SH_INTRO_ARTEFACT_SPRITE_ROW 3
#define SH_INTRO_ARTEFACT_SPRITE_COL 18
#elif dde_platform == platform_zx_spectrum
#define SH_INTRO_ARTEFACT_SPRITE_ROW 5
#define SH_INTRO_ARTEFACT_SPRITE_COL 14
#endif

#if dde_platform == platform_trs80_m100
#define SH_INTRO_TEXT_PART_2_ROW 6
#define SH_INTRO_TEXT_PART_2_COL 1
#elif dde_platform == platform_zx_spectrum
#define SH_INTRO_TEXT_PART_2_ROW 9
#define SH_INTRO_TEXT_PART_2_COL 1
#endif

cs_shadowheart_intro::
    call clear_screen
    BLOCK_PRINT shadowheart_cut_scene_1, 1, 1

    PRINT_AT_LOCATION SH_INTRO_ARTEFACT_SPRITE_ROW, SH_INTRO_ARTEFACT_SPRITE_COL, artefact_sprite_1
    PRINT_AT_LOCATION SH_INTRO_ARTEFACT_SPRITE_ROW + 1, SH_INTRO_ARTEFACT_SPRITE_COL, artefact_sprite_2
    PRINT_AT_LOCATION SH_INTRO_ARTEFACT_SPRITE_ROW + 2, SH_INTRO_ARTEFACT_SPRITE_COL, artefact_sprite_3
    call await_any_keypress

    BLOCK_PRINT shadowheart_cut_scene_2, SH_INTRO_TEXT_PART_2_COL, SH_INTRO_TEXT_PART_2_ROW
    call await_any_keypress

    ld a, ec_door
    ld (last_screen_exit_code), a
    ld a, screen_id_crash_site
    ld (last_screen_exit_argument), a
    ret
