#define screen_id_wilderness 5

; TODO: This was originally the wilderness that lead to the Goblin Camp Entrance and the Risen Road, with the original
; plan being to populate it with the blighted village, etc.
; That was cut for space, so make this an abridged version of the wilderness and camp entrance.

.local
screen_data:
screen_background:
.asciz "~~~ ~~~~~~~~~~~~~~~~"
.asciz "~                  ~"
.asciz "~                  ~"
.asciz "~                   "
.asciz "~                  ~"
.asciz "                   ~"
.asciz "~                  ~"
.asciz "~~~~~~~~~~~~~~~~~~~~"
screen_title: .asciz "Wilderness"
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
screen_start_x: .db 19 ; 1-indexed since it's screen coordinates!
screen_start_y: .db 4
screen_interactables:
    DEFINE_INTERACTABLE to_environs, in_door, $01, 4, 20
    DEFINE_INTERACTABLE to_goblin_camp_entrance, in_door, $01, 6, 1
    DEFINE_INTERACTABLE blank_3, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_4, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_5, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_6, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_7, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_8, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_9, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_10, 0, 0, 0, 0
screen_get_interaction_prompt: .dw get_interaction_prompt
screen_interact_callback: .dw on_interact
screen_menu_callback: .dw pause_menu

wilderness::
    ld hl, player_party
    ld a, (party_size)
    ld bc, screen_data
    call exploration_ui

    ret

get_interaction_prompt:
    ld hl, empty_prompt
    ret

on_interact:
    cp a, 0
    jp z, exit_to_environs

    cp a, 1
    jp z, exit_to_goblin_camp

    ret

exit_to_environs:
    EXIT_EXPLORATION ec_door, screen_id_emerald_grove_environs
    ret

exit_to_goblin_camp:
    EXIT_EXPLORATION ec_door, screen_id_goblin_camp
    ret

.endlocal
