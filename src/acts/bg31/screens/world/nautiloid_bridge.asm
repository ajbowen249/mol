#define screen_id_nautiloid_bridge 2

.local
screen_data:
screen_background:
.asciz "███████████████████ "
.asciz "███◤      \     /◥█ "
.asciz "██◤        \───/  ◥ "
.asciz "█◤∩               ▐ "
.asciz "█◣    왓왓          ▐ "
.asciz "██◣        /───\  ◢ "
.asciz "███◣      /     \◢█ "
.asciz "███████████████████ "
screen_title: .asciz "Nautiloid Bridge"
.db 0
.db 0
.db 0
.db 0
screen_start_x: .db 18 ; 1-indexed since it's screen coordinates!
screen_start_y: .db 4
screen_interactables:
    DEFINE_INTERACTABLE navigation_button, in_button, iflags_normal, 4, 3
    DEFINE_INTERACTABLE trigger_mf_convo_1, in_door, iflags_door, 4, 12
    DEFINE_INTERACTABLE trigger_mf_convo_2, in_door, iflags_door, 5, 12
    DEFINE_INTERACTABLE int_zhalk_fight, in_npc, iflags_normal, 5, 7
    DEFINE_INTERACTABLE blank_5, 0, iflags_normal, 0, 0
    DEFINE_INTERACTABLE blank_6, 0, iflags_normal, 0, 0
    DEFINE_INTERACTABLE blank_7, 0, iflags_normal, 0, 0
    DEFINE_INTERACTABLE blank_8, 0, iflags_normal, 0, 0
    DEFINE_INTERACTABLE blank_9, 0, iflags_normal, 0, 0
    DEFINE_INTERACTABLE blank_10, 0, iflags_normal, 0, 0
screen_get_interaction_prompt: .dw get_interaction_prompt
screen_interact_callback: .dw on_interact
screen_menu_callback: .dw pause_menu

navigation_prompt: .asciz "Transponder"

nautiloid_bridge::
    CLEAR_INTERACTABLE_IF_FLAG killed_zhalk, int_zhalk_fight, screen_background

    ld hl, player_party
    ld a, (party_size)
    ld bc, screen_data
    call exploration_ui

    ret

get_interaction_prompt:
    cp a, 0
    jp z, nav_prompt

    cp a, 3
    jp z, zhalk_prompt

    ld hl, empty_prompt
    ret

nav_prompt:
    ld hl, navigation_prompt
    ret

zhalk_prompt:
    ld hl, str_fight
    ret

on_interact:
    cp a, 0
    jp z, navigate

    cp a, 1
    jp z, mindflayer_dialog

    cp a, 2
    jp z, mindflayer_dialog

    cp a, 3
    jp z, zhalk_fight

    ret

navigate:
    EXIT_EXPLORATION ec_door, screen_id_cs_crash
    ret

mindflayer_dialog:
    call dialog_mindflayer_captain
    ret

zhalk_fight:
    ld a, 4
    ld (screen_start_y), a
    ld a, 7
    ld (screen_start_x), a

    EXIT_EXPLORATION ec_encounter, encounter_id_nautiloid_zhalk
    ret

.endlocal
