.local
; returns non-zero in A if gale was recruited
dialog_recruit_gale::
    ld a, opt_oc_gale
    ld hl, recruit_gale_text_1
    ld bc, recruit_ask_he
    ld d, recruit_gale_text_1_lines
    call show_basic_recruit_dialog
    ret

.endlocal
