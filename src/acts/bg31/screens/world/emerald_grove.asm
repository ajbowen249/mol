#define screen_id_emerald_grove 9

.local
screen_data:
screen_background:
.asciz "~££~~~£~~£~~~~~~¶~~¶"
.asciz "~  옷        옷  옷   ~"
.asciz "£    ~~¶~~£~~~~~£~~~"
.asciz "~                  ~"
.asciz "~ 왓 ▗▂▂▂     ▓▓   ㅑ~"
.asciz "£ ▚ ▞왓 ▐     ▓▓    ~"
.asciz "~ ▞ ▚              £"
.asciz "~¶~ ~~¶~£~~¶~~£££~~~"
screen_title: .asciz "Emerald Grove"
.db 0
.db 0
.db 0
.db 0
.db 0
.db 0
.db 0
screen_start_x: .db 4 ; 1-indexed since it's screen coordinates!
screen_start_y: .db 7
screen_interactables:
    DEFINE_INTERACTABLE to_environs, in_door, $01, 8, 4
    DEFINE_INTERACTABLE int_zevlor_auto_dialog, in_npc, $01, 5, 4
    DEFINE_INTERACTABLE int_kagha, in_npc, 0, 6, 6
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

emerald_grove::
    call check_game_state

    ld hl, player_party
    ld a, (party_size)
    ld bc, screen_data
    call exploration_ui

    ret

get_interaction_prompt:
    cp a, 2
    jp z, talk_prompt

    ld hl, empty_prompt
    ret

talk_prompt:
    ld hl, str_talk
    ret

on_interact:
    cp a, 0
    jp z, exit_to_environs

    cp a, 1
    jp z, auto_talk_zevlor

    cp a, 2
    jp z, talk_kahga

    ret

exit_to_environs:
    EXIT_EXPLORATION ec_door, screen_id_emerald_grove_environs
    ret

auto_talk_zevlor:
    ld a, (minthara_started_attack)
    cp a, 0
    jp nz, attack_grove

    call dialog_zevlor_after_gag
    call check_game_state
    ret

attack_grove:
    call dialog_grove_attack
    EXIT_EXPLORATION ec_encounter, encounter_id_grove_leaders

    ret

talk_kahga:
    call dialog_kagha
    ret

check_game_state:
    CLEAR_INTERACTABLE_IF_FLAG spoke_with_zevlor_after_gag, int_zevlor_auto_dialog, screen_background

    CLEAR_INTERACTABLE_IF_FLAG defeated_grove, int_zevlor_auto_dialog, screen_background
    CLEAR_INTERACTABLE_IF_FLAG defeated_grove, int_kagha, screen_background

    ld a, (defeated_grove)
    cp a, 0
    jp z, check_game_state_done

    ld a, " "
    ld (screen_background + 24), a
    ld (screen_background + 33), a
    ld (screen_background + 36), a
    ld (screen_background + 86), a
    ld (screen_background + 102), a

check_game_state_done:
    ret

.endlocal
