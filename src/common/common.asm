#include "../../dungeon-delver-engine/src/engine/dde.asm"
#include "./constants.asm"
#include "./origin_characters.asm"
#include "./game_state.asm"
#include "./game_state_helpers.asm"
#include "./monsters.asm"
#include "./pause_menu.asm"

.local
register_campaign_extras::
    call register_races
    call register_monsters
    ret

register_races:
    ld hl, opt_campaign_race
    ld a, race_githyanki
    ld (hl), a
    ld a, default_options_flags
    inc hl
    ld (hl), a
    inc hl
    ld bc, race_githyanki_label
    ld (hl), bc

    ret
.endlocal

; Note: The SRD does actually have an XP scale and a way to calculate the reward for an encounter.
; Keeping it custom to make balance simpler, and also to keep XP in 1 byte for simple compares.

#define level_2_xp 34
#define level_3_xp 55
#define level_4_xp 89
#define level_5_xp 144
#define level_6_xp 255

#define goblin_general_xp level_4_xp / 3 + 1

#define complete_goblin_kills_xp goblin_general_xp * 3 + level_2_xp
#define grove_party_xp level_5_xp - complete_goblin_kills_xp

.local
award_goblin_general_xp::
    ld a, goblin_general_xp
    call add_xp_and_notify_on_victory_screen
    ret
.endlocal

.local
xp_scale:
.db level_2_xp
.db level_3_xp
.db level_4_xp
.db level_5_xp
.db level_6_xp

#define defined_levels 5

; Adds A experience points to the party, increasing the level if needed.
; Returns non-zero in A if the level was changed.
add_experience_points::
    ld b, a
    ld a, (party_xp)
    add a, b
    ld (party_xp), a

    ld e, a

    ld d, 0
find_level_loop:
    ld hl, xp_scale
    ld b, 0
    ld c, d
    add hl, bc
    ld a, (hl)
    ld b, a
    ld a, e

    cp a, b
    jp c, found_level

    inc d
    jp find_level_loop

found_level:
    inc d
    ld b, d

    ld a, (party_member_0_level)
    cp a, b
    jp nz, set_level
    ld a, 0
    ret

set_level:
    ld a, b
    ld (party_member_0_level), a
    ld (party_member_1_level), a
    ld (party_member_2_level), a
    ld (party_member_3_level), a

    ld a, 1
    ret
.endlocal

.local
; Adds A experience points, and if the party advances a level, notifies at position HL
add_xp_and_notify::
    ; hacky, but this late it's better than adding the check everywhere we call this
    ld b, a
    ld a, (dde_should_exit)
    cp a, 0
    jp nz, add_xp_and_notify_done
    ld a, b

    push hl
    call add_experience_points
    pop hl
    cp a, 0
    jp nz, notify_level
    ret

notify_level:
    call rom_set_cursor

    ld hl, level_up_notification
    call print_compressed_string

    ld a, (party_member_0_level)
    ld d, 0
    ld e, a
    call de_to_decimal_string

    ld hl, bc
    call print_string
    call await_any_keypress
add_xp_and_notify_done:
    ret
.endlocal

.local
add_xp_and_notify_on_victory_screen::
    ld h, 10
    ld l, 5
    call add_xp_and_notify
    ret
.endlocal
