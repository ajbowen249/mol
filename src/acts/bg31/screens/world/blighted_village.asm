#define screen_id_blighted_village 5

.local
screen_data:
screen_background:
.asciz " ◢⌂◣ ~~~£~   ~~~£~¶~"
.asciz " ▛ ▜ ~£~ £¶◢◣   ⌂  ¶"
.asciz " ┐ ┌ ▓▓~~옷 ██ ⌂    ~"
.asciz "▓│ │▓▓▓▓~~          "
.asciz " ┘ └  └─┘  ⌂ ◢◣    ~"
.asciz "~            ██⌂   ~"
.asciz "▓▓    ┌─┐       ~£¶~"
.asciz " ▓▓~~~ ▓ ~~£~¶~£    "
screen_title: .asciz "Blighted Village"
.db 0
.db 0
.db 0
.db 0
screen_start_x: .db 19 ; 1-indexed since it's screen coordinates!
screen_start_y: .db 4
screen_interactables:
    DEFINE_INTERACTABLE to_environs, in_door, iflags_door, 4, 20
    DEFINE_INTERACTABLE to_goblin_camp, in_door, iflags_door, 2, 3
    DEFINE_INTERACTABLE int_recruit_karlach, in_npc, iflags_normal, 3, 10
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

blighted_village::
    call check_game_state

    ld hl, player_party
    ld a, (party_size)
    ld bc, screen_data
    call exploration_ui

    ret

get_interaction_prompt:
    cp a, 0
    jp z, ret_blank_prompt

    cp a, 1
    jp z, ret_blank_prompt

    ld hl, str_talk
    ret

ret_blank_prompt:
    ld hl, empty_prompt
    ret

on_interact:
    cp a, 0
    jp z, exit_to_environs

    cp a, 1
    jp z, exit_to_goblin_camp

    cp a, 2
    jp z, recruit_karlach

    ret

exit_to_environs:
    ld a, 19
    ld (screen_start_x), a
    ld a, 4
    ld (screen_start_y), a

    EXIT_EXPLORATION ec_door, screen_id_emerald_grove_environs
    ret

exit_to_goblin_camp:
    ld a, 3
    ld (screen_start_x), a
    ld (screen_start_y), a

    EXIT_EXPLORATION ec_door, screen_id_goblin_camp
    ret

recruit_karlach:
    call dialog_recruit_karlach
    cp a, 0
    jp z, recruit_karlach_done

    ld a, 11
    ld (screen_start_x), a

    ld a, 3
    ld (screen_start_y), a
    EXIT_EXPLORATION ec_door, screen_id_blighted_village
    ret

recruit_karlach_done:
    ret

check_game_state:
    call check_karlach
    ret

check_karlach:
    ld a, opt_oc_karlach
    call does_party_contain_origin_character_a
    jp nz, have_karlach
    ret

have_karlach:
    CLEAR_INTERACTABLE int_recruit_karlach, screen_background
    ret

.endlocal
