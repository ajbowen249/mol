#define screen_id_nautiloid_bridge 2

.local
screen_data:
screen_background:
.asciz "┌──────────────────┐"
.asciz "│                  │"
.asciz "│                  │"
.asciz "                 ∩ │"
.asciz "│                  │"
.asciz "│                  │"
.asciz "│                  │"
.asciz "└──────────────────┘"
screen_title: .asciz "Nautiloid Bridge"
.db 0
.db 0
.db 0
.db 0
screen_start_x: .db 2 ; 1-indexed since it's screen coordinates!
screen_start_y: .db 4
screen_interactables:
    DEFINE_INTERACTABLE door_1, in_door, $01, 4, 1
    DEFINE_INTERACTABLE navigation_button, in_button, 0, 4, 18
    DEFINE_INTERACTABLE blank_3, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_4, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_5, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_6, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_7, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_8, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_9, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_0, 0, 0, 0, 0
screen_get_interaction_prompt: .dw get_interaction_prompt
screen_interact_callback: .dw on_interact

navigation_prompt: .asciz "Navigation Console"

nautiloid_bridge::
    ld hl, player_party
    ld a, (party_size)
    ld bc, screen_data
    call exploration_ui

    ret

get_interaction_prompt:
    cp a, 1
    jp z, nav_prompt
    ld hl, empty_prompt
    ret

nav_prompt:
    ld hl, navigation_prompt
    ret

on_interact:
    cp a, 0
    jp z, exit_door

    cp a, 1
    jp z, navigate

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

.endlocal
