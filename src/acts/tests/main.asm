; Unit tests

.org $B200

#include "../../../build/generated/bg31/compressed_text.asm"
#include "../../common/common.asm"

rom_file_end:

#target ram
#test TESTS, rom_file_end

.local
    jp test_entry

dummy_test:
    ld a, 1
.expect a = 1
    ret

test_start:
    call dummy_test
    ret

test_entry:
    call test_start
.endlocal
