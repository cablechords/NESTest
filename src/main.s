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
    .org    $0000
    x_pos   .byte
    y_pos   .byte
.endstruct

.struct Player2
    .org    $0002
    x_pos   .byte
    y_pos   .byte
.endstruct

    lda #$08
    sta Player1::x_pos
    sta Player1::y_pos

    lda #$80
    sta Player2::x_pos
    sta Player2::y_pos

forever:
    jmp forever

nmi:
    lda #$00
    sta $2003   ; set the low byte (00) of the RAM address
    lda #$02
    sta $4014   ; set the high byte (02) of the RAM address, start the transfer

    draw_sprite #$00, Player1::x_pos, Player1::y_pos, #$00, $0200
    draw_sprite #$00, Player2::x_pos, Player2::y_pos, #$00, $0204

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