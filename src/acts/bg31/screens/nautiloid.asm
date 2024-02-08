#define screen_id_nautiloid 1

.local
screen_1_data:
screen_1_background:
.asciz "┌──────────────────┐"
.asciz "│                   "
.asciz "│                  │"
.asciz "│                  │"
.asciz "│                  │"
.asciz "│                  │"
.asciz "│                  │"
.asciz "└──────────────────┘"
screen_1_title: .asciz "Nautiloid"
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
.db 0
screen_1_start_x: .db 2 ; 1-indexed since it's screen coordinates!
screen_1_start_y: .db 2
screen_1_interactables:
    DEFINE_INTERACTABLE door_1, in_door, $01, 2, 20
    DEFINE_INTERACTABLE blank_2, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_3, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_4, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_5, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_6, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_7, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_8, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_9, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_0, 0, 0, 0, 0
screen_1_get_interaction_prompt: .dw get_interaction_prompt
screen_1_interact_callback: .dw on_interact

empty_prompt: .db 0

test_npc_prompt .asciz "Test Fight"

nautiloid::
    ld hl, player_party
    ld a, (party_size)
    ld bc, screen_1_data
    call exploration_ui
    ret

get_interaction_prompt:
    ld hl, empty_prompt
    ret

on_interact:
    cp a, 0
    jp z, door_interact

door_interact:
    ld a, ec_door
    ld (last_screen_exit_code), a
    ld a, screen_id_nautiloid_bridge
    ld (last_screen_exit_argument), a

    ld a, 1
    ret

.endlocal
