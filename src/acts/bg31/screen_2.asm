.local
screen_2_data:
screen_2_background:
.asciz "┌──────────────────┐"
.asciz "                   │"
.asciz "│                  │"
.asciz "│            α     │"
.asciz "│                  │"
.asciz "│               ∩∩ │"
.asciz "│     α            │"
.asciz "└──────────────────┘"
screen_2_title: .asciz "Test Room 2"
.db 0
.db 0
.db 0
.db 0
.db 0
.db 0
.db 0
.db 0
.db 0
screen_2_start_x: .db 2 ; 1-indexed since it's screen coordinates!
screen_2_start_y: .db 2
screen_2_interactables:
    DEFINE_INTERACTABLE door_1, in_door, $01, 2, 1
    DEFINE_INTERACTABLE blank_1, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_3, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_4, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_5, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_6, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_7, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_8, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_9, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_0, 0, 0, 0, 0
screen_2_get_interaction_prompt: .dw get_interaction_prompt
screen_2_interact_callback: .dw on_interact

empty_prompt: .db 0

screen_2::
    ld hl, player_party
    ld a, (party_size)
    ld bc, screen_2_data
    call exploration_ui

    ret

get_interaction_prompt:
    ld hl, empty_prompt
    ret

on_interact:
    ld a, ec_door
    ld (last_screen_exit_code), a
    ld a, 0
    ld (last_screen_exit_argument), a

    ld a, 1
    ret

.endlocal
