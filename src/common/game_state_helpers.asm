.local
; return non-zero if all three goblin generals are dead
killed_all_goblin_leaders::
    ld a, (killed_dror_ragzlin)
    cp a, 0
    jp z, not_all_dead

    ld a, (killed_priestess_gut)
    cp a, 0
    jp z, not_all_dead

    ld a, (killed_minthara)
    cp a, 0
    jp z, not_all_dead

    ld a, 1
    ret

not_all_dead:
    ld a, 0
    ret
.endlocal
