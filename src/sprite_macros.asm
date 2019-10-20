.include "../generated_sprites/sprite_data.asm"

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
