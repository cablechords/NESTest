.macro  draw_sprite spr_id, spr_x, spr_y, spr_attributes, spr_location
    lda spr_id
    ldx #$01
    sta spr_location, x
    lda spr_x
    ldx #$03
    sta spr_location, x
    lda spr_y
    sta spr_location
    lda spr_attributes
    ldx #$02
    sta spr_location, x
.endmacro

.macro check_controller
    lda $4016
    and #%00000001
.endmacro

.macro check_controller2
    lda $4017
    and #%00000001
.endmacro