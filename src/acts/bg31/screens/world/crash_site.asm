#define screen_id_crash_site 3

.local
screen_data:
screen_background:
.asciz "┌─────┐£~~¶~ ~~£~~£~"
.asciz "│     \         ~   "
.asciz "│      \        옷▛  "
.asciz "│      │옷       ▐¶  "
.asciz "└─\               ▄ "
.asciz "  └────            £"
.asciz "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓"
.asciz "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓"
screen_title: .asciz "Crash Site"
.db 0
.db 0
.db 0
.db 0
.db 0
.db 0
.db 0
.db 0
.db 0
.db 0
screen_start_x: .db 2 ; 1-indexed since it's screen coordinates!
screen_start_y: .db 2
screen_interactables:
    DEFINE_INTERACTABLE int_to_grove, in_door, iflags_door, 1, 13
    DEFINE_INTERACTABLE int_recruit_shadowheart, in_door, iflags_door, 5, 8
    DEFINE_INTERACTABLE int_recruit_gale, in_npc, iflags_normal, 3, 17
    DEFINE_INTERACTABLE int_shadowheart_cut_scene, in_door, iflags_door, 5, 8
    DEFINE_INTERACTABLE blank_5, 0, iflags_normal, 0, 0
    DEFINE_INTERACTABLE blank_6, 0, iflags_normal, 0, 0
    DEFINE_INTERACTABLE blank_7, 0, iflags_normal, 0, 0
    DEFINE_INTERACTABLE blank_8, 0, iflags_normal, 0, 0
    DEFINE_INTERACTABLE blank_9, 0, iflags_normal, 0, 0
    DEFINE_INTERACTABLE blank_10, 0, iflags_normal, 0, 0
screen_get_interaction_prompt: .dw get_interaction_prompt
screen_interact_callback: .dw on_interact
screen_menu_callback: .dw pause_menu

crash_site::
    call check_game_state

    ld hl, player_party
    ld a, (party_size)
    ld bc, screen_data
    call exploration_ui

    ret

get_interaction_prompt:
    cp a, 2
    jp nz, ret_blank_prompt

    ld hl, str_talk
    ret

ret_blank_prompt:
    ld hl, empty_prompt
    ret

on_interact:
    cp a, 0
    jp z, exit_to_grove

    cp a, 1
    jp z, recruit_shadowheart

    cp a, 2
    jp z, recruit_gale

    cp a, 3
    jp z, shadowheart_cut_scene

    ret

exit_to_grove:
    ld a, 13
    ld (screen_start_x), a

    ld a, 2
    ld (screen_start_y), a

    EXIT_EXPLORATION ec_door, screen_id_emerald_grove_environs
    ret

recruit_shadowheart:
    ld a, 9
    ld (screen_start_x), a

    ld a, 5
    ld (screen_start_y), a

    EXIT_EXPLORATION ec_door, screen_id_cs_recruit_shadowheart
    ret

recruit_gale:
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

shadowheart_cut_scene:
    ld a, 9
    ld (screen_start_x), a

    ld a, 5
    ld (screen_start_y), a

    EXIT_EXPLORATION ec_door, screen_id_cs_shadowheart_intro
    ret

check_game_state:
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
    ld a, 0
    ld (int_recruit_shadowheart_row), a
    ld (int_recruit_shadowheart_col), a

    ld hl, screen_data + 71
    ld a, " "
    ld (hl), a

dont_have_shadowheart:
    ret

check_pc_shadowheart:
    ld a, opt_oc_shadowheart
    call is_player_using_origin_character_a
    cp a, 0

    jp nz, check_pc_shadowheart_done
    CLEAR_INTERACTABLE int_shadowheart_cut_scene, screen_background

check_pc_shadowheart_done:
    ret

check_gale:
    ld a, opt_oc_gale
    call does_party_contain_origin_character_a
    jp nz, have_gale
    ret

have_gale:
    CLEAR_INTERACTABLE int_recruit_gale, screen_background
    ret

.endlocal
