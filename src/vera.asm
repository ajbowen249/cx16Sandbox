VERA_ADDR_LO = $9f20
VERA_ADDR_MID = $9f21
VERA_ADDR_HI = $9f22

VERA_DATA0 = $9f23
VERA_DATA1 = $9f24

set_vera_addr .macro low, mid, high
    lda \low
    sta VERA_ADDR_LO
    lda \mid
    sta VERA_ADDR_MID
    lda \high
    sta VERA_ADDR_HI
    .endm
