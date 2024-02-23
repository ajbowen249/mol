#define screen_id_nautiloid_bridge 2

.local
screen_data:
screen_background:
.asciz "███████████████████ "
.asciz "███◤      \     /◥█ "
.asciz "██◤        \───/  ◥ "
.asciz "█◤∩                 "
.asciz "█◣    αα            "
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
    DEFINE_INTERACTABLE door_1, in_door, $01, 4, 19
    DEFINE_INTERACTABLE door_2, in_door, $01, 5, 19
    DEFINE_INTERACTABLE navigation_button, in_button, 0, 4, 3
    DEFINE_INTERACTABLE trigger_mf_convo_1, in_door, $01, 4, 12
    DEFINE_INTERACTABLE trigger_mf_convo_2, in_door, $01, 5, 12
    DEFINE_INTERACTABLE int_zhalk_fight, in_npc, 0, 5, 7
    DEFINE_INTERACTABLE blank_7, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_8, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_9, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_0, 0, 0, 0, 0
screen_get_interaction_prompt: .dw get_interaction_prompt
screen_interact_callback: .dw on_interact

navigation_prompt: .asciz "Transponder"

nautiloid_bridge::
    ld a, (killed_zhalk)
    cp a, 0
    jp z, run_ui

    ld a, 0
    ld (int_zhalk_fight_row), a
    ld (int_zhalk_fight_col), a

    ld hl, screen_background
    ld bc, 91
    add hl, bc
    ld a, " "
    ld (hl), a

    ld a, 4
    ld (screen_start_y), a
    ld a, 7
    ld (screen_start_x), a

run_ui:
    ld hl, player_party
    ld a, (party_size)
    ld bc, screen_data
    call exploration_ui

    ret

get_interaction_prompt:
    cp a, 2
    jp z, nav_prompt

    cp a, 5
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
    jp z, exit_door

    cp a, 1
    jp z, exit_door

    cp a, 2
    jp z, navigate

    cp a, 3
    jp z, mindflayer_dialog

    cp a, 4
    jp z, mindflayer_dialog

    cp a, 5
    jp z, zhalk_fight

    ret

exit_door:
    ld a, ec_door
    ld b, screen_id_nautiloid
    call set_screen_exit_conditions
    ld a, 1
    ret

navigate:
    EXIT_EXPLORATION ec_door, screen_id_crash_site
    ret

mindflayer_dialog:
    call dialog_mindflayer_captain
    ret

zhalk_fight:
    EXIT_EXPLORATION ec_encounter, encounter_id_nautiloid_zhalk
    ret

.endlocal
