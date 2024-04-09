.local
prompt_text_location: .dw 0
origin_character_index: .db 0

; a should contain the index of the origin character
; HL should contain the pointer to the intro text
; BC should contain the join prompt text pointer (1 line!)
; D should contain the line count for the intro text
; returns non-zero in A if the character was recruited
show_basic_recruit_dialog::
    ld (origin_character_index), a
    push hl
    ld hl, bc
    ld (prompt_text_location), hl

    pop hl
    ld a, d
    ld b, 21
    ld c, 2
    call block_print
    call await_any_keypress
    call clear_exploration_message_area

    ld a, (party_size)
    cp a, 4
    jp z, recruit_party_full

    ld hl, (prompt_text_location)
    ld bc, hl
    PRINT_COMPRESSED_AT_LOCATION 2, 21, bc

    ld a, 2
    ld hl, opt_yes_no
    ld b, 21
    ld c, 3
    call menu_ui

    cp a, 1
    jp z, dont_recruit

    ld a, (origin_character_index)
    call recruit_origin_character

    ld hl, recruited_characters
    ld a, (origin_character_index)
    ld b, 0
    ld c, a
    add hl, bc
    ld a, 1
    ld (hl), a

    call clear_exploration_message_area
    ld a, 1
    ret

recruit_party_full:
    BLOCK_PRINT str_recruit_party_full, 21, 2
    call await_any_keypress

dont_recruit:
    call clear_exploration_message_area
    ld a, 0
    ret
.endlocal

#include "./recruit_gale.asm"
#include "./recruit_karlach.asm"
#include "./recruit_laezel.asm"
