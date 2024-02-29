.local
#define opt_resume 0

menu_label: .asciz "Pause"
opt_resume_label: .asciz "Resume"

menu:
.db opt_resume
.db default_options_flags
.dw opt_resume_label

pause_menu::
    call rom_clear_screen
    PRINT_AT_LOCATION 1, 1, menu_label

    ld a, 1
    ld hl, menu
    ld b, 1
    ld c, 2
    call menu_ui
    ret

.endlocal
