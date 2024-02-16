#define screen_id_nautiloid 1

.local
nautiloid_data:
nautiloid_background:
.asciz "██◤   ◥█████◤   ◥██ "
.asciz "█◤     ◥███◤     ◥█ "
.asciz "◤       ◥█◤       ◥ "
.asciz "                  ▐ "
.asciz "                  ▐ "
.asciz "◣  ╔╗   ◢█◣       ◢ "
.asciz "█◣     ◢███◣     ◢█ "
.asciz "██◣   ◢█████◣   ◢██ "
nautiloid_title: .asciz "Nautiloid"
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
nautiloid_start_x: .db 16 ; 1-indexed since it's screen coordinates!
nautiloid_start_y: .db 4
nautiloid_interactables:
    DEFINE_INTERACTABLE door_1, in_door, $01, 4, 1
    DEFINE_INTERACTABLE door_2, in_door, $01, 5, 1
    DEFINE_INTERACTABLE us, in_dialog, $00, 6, 4
    DEFINE_INTERACTABLE blank_4, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_5, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_6, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_7, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_8, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_9, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_10, 0, 0, 0, 0
nautiloid_get_interaction_prompt: .dw get_interaction_prompt
nautiloid_interact_callback: .dw on_interact

interactable_us_loc:: .dw us

nautiloid::
    ld hl, player_party
    ld a, (party_size)
    ld bc, nautiloid_data
    call exploration_ui
    ret

get_interaction_prompt:
    cp a, 2
    jp z, us_prompt
    ld hl, empty_prompt
    ret

us_prompt:
    ld hl, str_investigate
    ret

on_interact:
    cp a, 0
    jp z, door_interact

    cp a, 1
    jp z, door_interact

    cp a, 2
    jp z, us_interact
    ret

door_interact:
    EXIT_EXPLORATION ec_door, screen_id_nautiloid_bridge
    ret

us_interact:
    call dialog_us
    ld a, 0
    ret
.endlocal
