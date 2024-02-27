#define screen_id_goblin_camp 8

.local
screen_data:
screen_background:
.asciz "┌──────────────────┐"
.asciz "│        α       α │"
.asciz "│                  │"
.asciz "│H α               │"
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
    DEFINE_INTERACTABLE int_priestess_gut, in_npc, 0, 4, 4
    DEFINE_INTERACTABLE int_minthara, in_npc, 0, 2, 18
    DEFINE_INTERACTABLE blank_6, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_7, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_8, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_9, 0, 0, 0, 0
    DEFINE_INTERACTABLE blank_0, 0, 0, 0, 0
screen_get_interaction_prompt: .dw get_interaction_prompt
screen_interact_callback: .dw on_interact

goblin_camp::
    CLEAR_INTERACTABLE_IF_FLAG killed_dror_ragzlin, int_dror_ragzlin, screen_background
    CLEAR_INTERACTABLE_IF_FLAG killed_priestess_gut, int_priestess_gut, screen_background
    CLEAR_INTERACTABLE_IF_FLAG killed_minthara, int_minthara, screen_background

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

    cp a, 3
    jp z, talk_prompt

    cp a, 4
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

    cp a, 3
    jp z, gut_interact

    cp a, 4
    jp z, minthara_interact
    ret

exit_to_camp:
    EXIT_EXPLORATION ec_door, screen_id_goblin_camp_entrance
    ret

exit_to_underdark:
    EXIT_EXPLORATION ec_door, screen_id_underdark
    ret

dror_interact:
    ld a, 3
    ld (screen_start_y), a
    ld a, 10
    ld (screen_start_x), a

    EXIT_EXPLORATION ec_encounter, encounter_id_dror_ragzlin
    ret

gut_interact:
    ld a, 4
    ld (screen_start_y), a
    ld a, 5
    ld (screen_start_x), a

    EXIT_EXPLORATION ec_encounter, encounter_id_priestess_gut
    ret

minthara_interact:
    ld a, 3
    ld (screen_start_y), a
    ld a, 18
    ld (screen_start_x), a

    EXIT_EXPLORATION ec_encounter, encounter_id_minthara
    ret

.endlocal
