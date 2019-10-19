; This should eventually be imported from a generated file
SPRITE_SHIP .byte 0, 0, 0, 2, 32, 0, 0, 0, 0, 0, 0, 2, 32, 0, 0, 0, 0, 0, 0, 2, 32, 0, 0, 0, 0, 0, 0, 2, 32, 0, 0, 0, 0, 0, 0, 2, 32, 0, 0, 0, 0, 0, 0, 2, 32, 0, 0, 0, 0, 0, 0, 2, 32, 0, 0, 0, 0, 0, 0, 2, 32, 0, 0, 0, 0, 0, 0, 2, 32, 0, 0, 0, 0, 0, 2, 34, 34, 32, 0, 0, 0, 2, 38, 98, 38, 98, 32, 0, 2, 38, 102, 98, 38, 102, 98, 32, 38, 102, 102, 98, 38, 102, 102, 98, 38, 102, 102, 98, 38, 102, 102, 98, 38, 102, 102, 98, 38, 102, 102, 98, 34, 34, 34, 34, 34, 34, 34, 34

copy_sprite_to_location .macro sprite, length, low, mid, high
    #set_vera_addr \low, \mid, \high
    ldx #$00
loop_copy_sprite_to_location
    lda \sprite, x
    sta VERA_DATA0
    inx
    cpx \length
    bne loop_copy_sprite_to_location
    .endm
