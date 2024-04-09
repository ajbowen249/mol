.local
; returns non-zero in A if karlach was recruited
dialog_recruit_karlach::
    ld a, opt_oc_karlach
    ld hl, recruit_karlach_text_1
    ld bc, recruit_ask_she
    ld d, recruit_karlach_text_1_lines
    call show_basic_recruit_dialog
    ret

.endlocal
