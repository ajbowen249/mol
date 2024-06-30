on_recruit_gale:
    call dialog_recruit_gale
    cp a, 0
    jp z, recruit_gale_done

    ld a, 16
    ld (screen_start_x), a

    ld a, 3
    ld (screen_start_y), a
    EXIT_EXPLORATION ec_door, screen_id_crash_site
    ret

recruit_gale_done:
    ret

init_screen:
    call check_shadowheart
    call check_pc_shadowheart
    call check_gale
    ret

; note, not quite the normal pattern bc it's an auto-trigger next to her instead of a proper NPC spot
check_shadowheart:
    ld a, (recruited_shadowheart)
    cp a, 0
    jp nz, have_shadowheart

    ld a, opt_oc_shadowheart
    call is_player_using_origin_character_a
    cp a, 0
    jp z, dont_have_shadowheart

have_shadowheart:
    CLEAR_INTERACTABLE recruit_shadowheart, screen_background

    ld hl, screen_data + 71
    ld a, " "
    ld (hl), a

dont_have_shadowheart:
    ret

check_pc_shadowheart:
    ld a, opt_oc_shadowheart
    call is_player_using_origin_character_a
    cp a, 0

    jp nz, player_is_using_shadowheart
    CLEAR_INTERACTABLE shadowheart_cut_scene, screen_background
    ret

player_is_using_shadowheart:
    CLEAR_INTERACTABLE recruit_shadowheart, screen_background
    ret

check_gale:
    ld a, opt_oc_gale
    call does_party_contain_origin_character_a
    jp nz, have_gale
    ret

have_gale:
    CLEAR_INTERACTABLE recruit_gale, screen_background
    ret

reset_crash_site::
    RESET_SCREEN screen_data, 2, 2
    ld a, "옷"
    ld (screen_background + 71), a
    ld (screen_background + 58), a
    ret
