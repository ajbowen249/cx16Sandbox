VERA_ADDR_HI = $9f20
VERA_ADDR_MID = $9f21
VERA_ADDR_LO = $9f22

VERA_DATA0 = $9f23
VERA_DATA1 = $9f24

set_vera_addr .macro high, mid, low
    lda \low
    sta VERA_ADDR_HI
    lda \mid
    sta VERA_ADDR_MID
    lda \high
    sta VERA_ADDR_LO
    .endm

; Loads argument into A, then stores A to VERA_DATA0
a_to_vera_0 .macro value
    lda \value
    sta VERA_DATA0
    .endm
