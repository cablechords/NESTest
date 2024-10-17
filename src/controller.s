latch_controllers:
    lda #$01
    sta $4016
    lda #$00
    sta $4016

    lda #$00
    sta $4017
    lda #$01
    sta $4017

    ; skip controller readings
    lda $4016   ; A
    lda $4016   ; B
    lda $4016   ; SELECT
    lda $4016   ; START

read_up:
    check_controller
    beq read_up_done

    dec Player1::y_pos

read_up_done:

read_down:
    check_controller
    beq read_down_done

    inc Player1::y_pos

read_down_done:

read_left:

    check_controller
    beq read_left_done

    dec Player1::x_pos

read_left_done:

read_right:

    check_controller
    beq read_right_done

    inc Player1::x_pos

read_right_done:

latch_controller2:

    ; skip controller readings
    lda $4017   ; A
    lda $4017   ; B
    lda $4017   ; SELECT
    lda $4017   ; START

read_up_2:
    check_controller2
    beq read_up_done_2

    dec Player2::y_pos

read_up_done_2:

read_down_2:
    check_controller2
    beq read_down_done_2

    inc Player2::y_pos

read_down_done_2:

read_left_2:
    check_controller2
    beq read_left_done_2
    dec Player2::x_pos

read_left_done_2:

read_right_2:
    check_controller2
    beq read_right_done_2
    inc Player2::x_pos

read_right_done_2: