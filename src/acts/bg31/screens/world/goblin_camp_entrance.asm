#define screen_id_goblin_camp_entrance 7

.local
screen_data:
screen_background:
.asciz "~~~~~~~~│ │~~~~~~~~~"
.asciz "▓▓▓▓▓▓▓▓│ │▓▓▓▓▓▓▓▓▓"
.asciz "▓▓▓▓▓▓▓▓│ │▓▓▓▓▓▓▓▓▓"
.asciz "~~~~~~~~│ │~~~~~~~~~"
.asciz "~                  ~"
.asciz "~                   "
.asciz "~                  ~"
.asciz "~~~~~~~~~~~~~~~~~~~~"
screen_title: .asciz "Goblin Camp Entrance"
screen_start_x: .db 19 ; 1-indexed since it's screen coordinates!
screen_start_y: .db 6
screen_interactables:
    DEFINE_INTERACTABLE to_wilderness, in_door, $01, 6, 20
    DEFINE_INTERACTABLE to_goblin_camp, in_door, $01, 1, 10
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

goblin_camp_entrance::
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
    jp z, exit_to_wilderness

    cp a, 1
    jp z, exit_to_goblin_camp

    ret

exit_to_wilderness:
    EXIT_EXPLORATION ec_door, screen_id_wilderness
    ret

exit_to_goblin_camp:
    EXIT_EXPLORATION ec_door, screen_id_goblin_camp
    ret

.endlocal
