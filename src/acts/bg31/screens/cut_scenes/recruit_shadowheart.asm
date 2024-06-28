#define screen_id_cs_recruit_shadowheart 6

.local

#if dde_platform == platform_trs80_m100
#define SH_RECRUIT_ARTEFACT_SPRITE_ROW 5
#define SH_RECRUIT_ARTEFACT_SPRITE_COL 7
#elif dde_platform == platform_zx_spectrum
#define SH_RECRUIT_ARTEFACT_SPRITE_ROW 6
#define SH_RECRUIT_ARTEFACT_SPRITE_COL 14
#endif

#if dde_platform == platform_trs80_m100
#define SH_RECRUIT_TEXT_PART_2_ROW 5
#define SH_RECRUIT_TEXT_PART_2_COL 12
#elif dde_platform == platform_zx_spectrum
#define SH_RECRUIT_TEXT_PART_2_ROW 10
#define SH_RECRUIT_TEXT_PART_2_COL 1
#endif

cs_recruit_shadowheart::
    call clear_screen
    BLOCK_PRINT recruit_shadowheart_text_1, 1, 1
    call await_any_keypress

    PRINT_AT_LOCATION SH_RECRUIT_ARTEFACT_SPRITE_ROW, SH_RECRUIT_ARTEFACT_SPRITE_COL, artefact_sprite_1
    PRINT_AT_LOCATION SH_RECRUIT_ARTEFACT_SPRITE_ROW + 1, SH_RECRUIT_ARTEFACT_SPRITE_COL, artefact_sprite_2
    PRINT_AT_LOCATION SH_RECRUIT_ARTEFACT_SPRITE_ROW + 2, SH_RECRUIT_ARTEFACT_SPRITE_COL, artefact_sprite_3

    call await_any_keypress

    BLOCK_PRINT recruit_shadowheart_text_2, SH_RECRUIT_TEXT_PART_2_COL, SH_RECRUIT_TEXT_PART_2_ROW
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
