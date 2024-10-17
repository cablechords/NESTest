reset:
    sei     ; disable IRQs
    cld     ; disable decimal mode
    ldx #$40
    stx $4017   ; disable APU frame IRQ
    ldx #$FF
    txs     ; set up the stack
    inx     ; X = 0
    stx $2000   ; disable NMI
    stx $2001   ; disable rendering
    stx $3010   ; disable DMC IRQs

vblankwait1:    ; wait until first vblank to make sure PPU is ready
    bit $2002
    bpl vblankwait1

clear_memory:
    lda #$00
    sta $0000, x
    sta $0100, x
    sta $0200, x
    sta $0300, x
    sta $0400, x
    sta $0500, x
    sta $0600, x
    sta $0700, x
    lda #$FE
    sta $0300, X
    inx
    bne clear_memory

vblankwait2:    ; wait until first vblank to make sure PPU is ready
    bit $2002
    bpl vblankwait2

;; SPRITE SETUP ;;
LoadPalettes:
    lda $2002   ; read PPU status to reset the high/low latch to hgih
    lda #$3F
    sta $2006   ; write the high byte of the $3F10 address
    lda #$00
    sta $2006   ; write the low byte of $3F10 address

    ldx #$00
LoadPalettesLoop:
    lda PaletteData, x
    sta $2007
    inx
    cpx #$20
    bne LoadPalettesLoop

setup_sprite_data:

    lda #%10000000  ; enable NMI, sprites from pattern table 0
    sta $2000

    lda #%00010000
    sta $2001

setup_background:
    lda #$12
    sta $2007