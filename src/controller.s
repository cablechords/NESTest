latch_controller:
    lda #$01
    sta $4016
    lda #$00
    sta $4016

    lda #$00
    sta $4017
    lda #$01
    sta $4017

.proc Controller1

    ; skip controller readings
    lda $4016   ; A
    lda $4016   ; B
    lda $4016   ; SELECT
    lda $4016   ; START
    lda $4016   ; UP
    lda $4016   ; DOWN
    lda $4016   ; LEFT

read_right:

    check_controller $4016
    beq read_right_done

    inc Player1::x_speed

read_right_done:
.endproc