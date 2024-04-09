.local
; returns non-zero in A if laezel was recruited
dialog_recruit_laezel::
    ld a, opt_oc_laezel
    ld hl, recruit_laezel_text_1
    ld bc, recruit_ask_she
    ld d, recruit_laezel_text_1_lines
    call show_basic_recruit_dialog
    ret

.endlocal
