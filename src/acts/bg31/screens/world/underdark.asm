#define screen_id_underdark 10

.local
screen_data:
screen_background:
.asciz " ▓▓  €           €  "
.asciz " ▓▓        ▓▓       "
.asciz " ▓▓   €       ▓  €  "
.asciz " ▓▓                 "
.asciz " ▓▓▓▓▓▓ ▓▓▓  ▓▓ ▓▓▓▓"
.asciz "▛ㅑ▔▜▓  €      ┌ ───┐"
.asciz "▌           €     H│"
.asciz "▙옷▂▟▓  €      └────┘"
screen_title: .asciz "Underdark"
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
screen_start_x: .db 17 ; 1-indexed since it's screen coordinates!
screen_start_y: .db 7
screen_interactables:
    DEFINE_INTERACTABLE int_duergar_guard, in_npc, iflags_normal, 8, 2
    DEFINE_INTERACTABLE int_camp_ladder, in_button, iflags_normal, 7, 19
    DEFINE_INTERACTABLE int_to_end, in_door, iflags_door, 8, 2
    DEFINE_INTERACTABLE blank_4, 0, iflags_normal, 0, 0
    DEFINE_INTERACTABLE blank_5, 0, iflags_normal, 0, 0
    DEFINE_INTERACTABLE blank_6, 0, iflags_normal, 0, 0
    DEFINE_INTERACTABLE blank_7, 0, iflags_normal, 0, 0
    DEFINE_INTERACTABLE blank_8, 0, iflags_normal, 0, 0
    DEFINE_INTERACTABLE blank_9, 0, iflags_normal, 0, 0
    DEFINE_INTERACTABLE blank_10, 0, iflags_normal, 0, 0
screen_get_interaction_prompt: .dw get_interaction_prompt
screen_interact_callback: .dw on_interact
screen_menu_callback: .dw pause_menu

underdark::
    call check_game_state

    ld hl, player_party
    ld a, (party_size)
    ld bc, screen_data
    call exploration_ui

    ret

label_ladder_up: .asciz "Ladder to camp"

get_interaction_prompt:
    cp a, 1
    jp z, ladder_prompt

    ld hl, str_talk
    ret

ladder_prompt:
    ld hl, label_ladder_up
    ret

on_interact:
    cp a, 0
    jp z, talk_to_guard

    cp a, 1
    jp z, take_ladder

    cp a, 2
    jp z, exit_to_outro

    ret

talk_to_guard:
    ld a, 7
    ld (screen_start_y), a
    ld a, 2
    ld (screen_start_x), a

    call dialog_grymforge_guard
    cp a, 0
    jp z, talk_guard_done

    EXIT_EXPLORATION ec_encounter, encounter_id_nere

talk_guard_done:
    ret

take_ladder:
    EXIT_EXPLORATION ec_door, screen_id_goblin_camp
    ret

exit_to_outro:
    EXIT_EXPLORATION ec_door, screen_id_cs_act_1_end
    ret

check_game_state:
    CLEAR_INTERACTABLE_IF_FLAG killed_nere, int_duergar_guard, screen_background
    ret

reset_underdark::
    RESET_SCREEN screen_data, 17, 7
    ld a, "옷"
    ld (screen_background + 148), a
    ret
.endlocal
