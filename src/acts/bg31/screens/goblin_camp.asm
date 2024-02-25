#define screen_id_goblin_camp 8

.local
screen_data:
screen_background:
.asciz "┌──────────────────┐"
.asciz "│        α         │"
.asciz "│                  │"
.asciz "│H                 │"
.asciz "│                  │"
.asciz "│                  │"
.asciz "│                  │"
.asciz "└──────── ─────────┘"
screen_title: .asciz "Goblin Camp"
.db 0
.db 0
.db 0
.db 0
.db 0
.db 0
.db 0
.db 0
.db 0
screen_start_x: .db 10 ; 1-indexed since it's screen coordinates!
screen_start_y: .db 7
screen_interactables:
    DEFINE_INTERACTABLE to_goblin_camp_entrance, in_door, $01, 8, 10
    DEFINE_INTERACTABLE underdark_ladder, in_button, 0, 4, 2
    DEFINE_INTERACTABLE int_dror_ragzlin, in_npc, 0, 2, 10
    DEFINE_INTERACTABLE blank_4, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_5, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_6, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_7, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_8, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_9, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_0, 0, 0, 0, 0
screen_get_interaction_prompt: .dw get_interaction_prompt
screen_interact_callback: .dw on_interact

goblin_camp::
    ld a, (killed_dror_ragzlin)
    cp a, 0
    jp z, run_ui

    ld a, 0
    ld (int_dror_ragzlin_row), a
    ld (int_dror_ragzlin_col), a

    ld hl, screen_background
    ld bc, 30
    add hl, bc
    ld a, " "
    ld (hl), a

    ld a, 3
    ld (screen_start_y), a
    ld a, 10
    ld (screen_start_x), a

run_ui:
    ld hl, player_party
    ld a, (party_size)
    ld bc, screen_data
    call exploration_ui
    ret

underdark_ladder_prompt: .asciz "Ladder to Underdark"

get_interaction_prompt:
    cp a, 1
    jp z, ladder_prompt

    cp a, 2
    jp z, talk_prompt

    ld hl, empty_prompt
    ret

ladder_prompt:
    ld hl, underdark_ladder_prompt
    ret

talk_prompt:
    ld hl, str_talk
    ret

on_interact:
    cp a, 0
    jp z, exit_to_camp

    cp a, 1
    jp z, exit_to_underdark

    cp a, 2
    jp z, dror_interact
    ret

exit_to_camp:
    EXIT_EXPLORATION ec_door, screen_id_goblin_camp_entrance
    ret

exit_to_underdark:
    EXIT_EXPLORATION ec_door, screen_id_underdark
    ret

dror_interact:
    EXIT_EXPLORATION ec_encounter, encounter_id_dror_ragzlin
    ret

.endlocal
