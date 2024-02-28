; assuming screen_controller_party, enemy_party_size, screen_controller_party_size, and are set, start up the encounter.
start_encounter:
    ld hl, (screen_controller_party)
    ld a, (enemy_party_size)
    ld d, a
    ld a, (screen_controller_party_size)
    ld bc, enemy_party
    call battle_ui
    ret
