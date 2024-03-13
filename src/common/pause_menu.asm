#include "./party_menu.asm"

.local
#define opt_resume 0
#define opt_party 1

menu_label: .asciz "Pause"
opt_resume_label: .asciz "Resume"
opt_party_label: .asciz "Party"

menu:
.db opt_resume
.db default_options_flags
.dw opt_resume_label

.db opt_party
.db default_options_flags
.dw opt_party_label

#define pause_menu_options 2

pause_menu::
    call rom_clear_screen
    PRINT_AT_LOCATION 1, 1, menu_label

    ld a, pause_menu_options
    ld hl, menu
    ld b, 1
    ld c, 2
    call menu_ui

    cp a, opt_party
    jp z, show_party_menu
    ret

show_party_menu:
    call party_menu
    ret

.endlocal
