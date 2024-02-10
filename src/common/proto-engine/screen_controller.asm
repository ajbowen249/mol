last_screen_exit_code: .db 0
last_screen_exit_argument: .db 0

screen_controller_table_location: .dw 0

.local
; Points the screen controller to the screen table at HL
configure_screen_controller::
    ld (screen_controller_table_location), hl
    ret
.endlocal

.local
run_screen_controller::
screen_loop:
    ld a, (last_screen_exit_code)

    cp a, ec_door
    call z, run_room

    jp screen_loop

    ret

run_room:
    ld a, (last_screen_exit_argument)
    ld b, 2
    ld hl, (screen_controller_table_location)
    call get_array_item
    ld bc, (hl)
    ld hl, bc
    call call_hl

    ret

.endlocal

.local
; Stores exit code A with argument B
; Destroyes A
set_screen_exit_conditions::
    ld (last_screen_exit_code), a
    ld a, b
    ld (last_screen_exit_argument), a
    ret
.endlocal
