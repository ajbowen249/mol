#define screen_id_goblin_camp 8

.local
nautiloid_data:
nautiloid_background:
.asciz "┌──────────────────┐"
.asciz "│                  │"
.asciz "│                  │"
.asciz "│                  │"
.asciz "│                  │"
.asciz "│                  │"
.asciz "│                  │"
.asciz "└──────── ─────────┘"
nautiloid_title: .asciz "Goblin Camp"
.db 0
.db 0
.db 0
.db 0
.db 0
.db 0
.db 0
.db 0
.db 0
nautiloid_start_x: .db 10 ; 1-indexed since it's screen coordinates!
nautiloid_start_y: .db 7
nautiloid_interactables:
    DEFINE_INTERACTABLE to_goblin_camp_entrance, in_door, $01, 8, 10
    DEFINE_INTERACTABLE blank_2, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_3, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_4, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_5, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_6, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_7, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_8, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_9, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_0, 0, 0, 0, 0
nautiloid_get_interaction_prompt: .dw get_interaction_prompt
nautiloid_interact_callback: .dw on_interact

goblin_camp::
    ld hl, player_party
    ld a, (party_size)
    ld bc, nautiloid_data
    call exploration_ui
    ret

get_interaction_prompt:
    ld hl, empty_prompt
    ret

on_interact:
    cp a, 0
    jp z, door_interact
    ret

door_interact:
    ld a, ec_door
    ld b, screen_id_goblin_camp_entrance
    call set_screen_exit_conditions
    ld a, 1
    ret

.endlocal
