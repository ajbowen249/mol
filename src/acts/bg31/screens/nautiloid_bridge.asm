navigation_prompt: .asciz "Transponder"

init_screen:
    CLEAR_INTERACTABLE_IF_FLAG killed_zhalk, zhalk_fight, screen_background
    ret

reset_nautiloid_bridge::
    RESET_SCREEN screen_data, 18, 4
    ld a, "왓"
    ld (screen_background + 90), a
    ret
