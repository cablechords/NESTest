.segment "HEADER"
    ; .byte "NES", $1A      ; iNES header identifier
    .byte $4E, $45, $53, $1A
    .byte 2               ; 2x 16KB PRG code
    .byte 1               ; 1x  8KB CHR data
    .byte $01, $00        ; mapper 0, vertical mirroring

; "nes" linker config requires a STARTUP section, even if it's empty
.segment "STARTUP"

; Main code segment for the program
.segment "CODE"

; PALETTE
.include "palette.s"

; MACROS
.include "util.s"

; SETUP
.include "setup.s"

init_player:
.struct Player1
    .org    $0010
    x_pos   .byte
    y_pos   .byte
    x_speed .byte
    shifted_speed   .byte
.endstruct

    lda EIGHT
    sta Player1::x_pos

    lda ZERO
    sta Player1::x_speed

    lda #$80
    sta Player1::y_pos

forever:
    jmp forever

nmi:
    lda ZERO
    sta $2003   ; set the low byte (00) of the RAM address
    lda #$02
    sta $4014   ; set the high byte (02) of the RAM address, start the transfer

    lda Player1::x_speed
    and #%01110000
    sta Player1::shifted_speed
    ldx #$04
    ror Player1::shifted_speed, x
    ldx Player1::shifted_speed
    adc Player1::x_pos, x
    clc

    draw_sprite ZERO, Player1::x_pos, Player1::y_pos, ZERO, $0200

.include "controller.s"

    rti     ;; END NMI


.segment "VECTORS"
    ;; When an NMI happens (once per frame if enabled) the label nmi:
    .addr nmi
    ;; When the processor first turns on or is reset, it will jump to the label reset:
    .addr reset
    ;; External interrupt IRQ (unused)
    .addr 0

.segment "CHARS"
    .incbin "assets/main.chr"