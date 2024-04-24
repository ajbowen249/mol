; Unit tests

.org $B200

#include "../../../build/generated/bg31/compressed_text.asm"
#include "../../common/common.asm"

rom_file_end:

#target ram
#test TESTS, rom_file_end

.local
    jp test_entry

xp_tests:
    ld a, 1
    ld (party_member_0_level), a
    ld (party_member_1_level), a
    ld (party_member_2_level), a
    ld (party_member_3_level), a

    ld a, 0
    ld (party_xp), a

    call add_experience_points
.expect a = 0
    ld a, (party_member_0_level)
.expect a = 1

    ld a, 34
    call add_experience_points
.expect a = 1
    ld a, (party_member_0_level)
.expect a = 2

    ld a, 30
    call add_experience_points
.expect a = 1
    ld a, (party_member_0_level)
.expect a = 3

    ld a, 10
    call add_experience_points
.expect a = 0
    ld a, (party_member_0_level)
.expect a = 3

    ld a, 15
    call add_experience_points
.expect a = 1
    ld a, (party_member_0_level)
.expect a = 4

    ld a, 100
    call add_experience_points
.expect a = 1
    ld a, (party_member_0_level)
.expect a = 5
    ld a, (party_member_1_level)
.expect a = 5
    ld a, (party_member_2_level)
.expect a = 5
    ld a, (party_member_3_level)
.expect a = 5

    ; these are #define constants, but you can't use parentheses in expressions,
    ; so this makes sure I get what I think they should be.
    ld a, goblin_general_kill_xp
.expect a = 30

    ld a, complete_goblin_kills_xp
.expect a = 124

    ld a, grove_party_xp
.expect a = 20

    ld a, grove_kill_xp
.expect a = 32

    ret

game_state_tests:
    ld a, 123
    ; not comprehensive, just a sampling
    ld (party_size), a
    ld (killed_dror_ragzlin), a
    ld (helped_dror_question), a
    ld (killed_minthara), a
    ld (party_xp), a

.MACRO RESET_GAME_STATE_TEST_EXPECT &VAL
    ld a, (party_size)
.expect a = &VAL
    ld a, (killed_dror_ragzlin)
.expect a = &VAL
    ld a, (helped_dror_question)
.expect a = &VAL
    ld a, (killed_minthara)
.expect a = &VAL
    ld a, (party_xp)
.expect a = &VAL
.ENDM

    RESET_GAME_STATE_TEST_EXPECT 123
    call reset_game_state
    RESET_GAME_STATE_TEST_EXPECT 0

    ret

test_start:
    call xp_tests
    call game_state_tests
    ret

test_entry:
    call test_start
.endlocal
