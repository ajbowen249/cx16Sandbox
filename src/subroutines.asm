; Clears the screen in 80x60 mode 0.
; Pass the fg/bg color in A.
; Consumes A, X, and Y.
clear_screen_80_60
    pha ; save A to the stack to use later
    ; Start at the beginning of vera memory with 1 increment
    #set_vera_addr #$10, #$00, #$00

    ldy #$3c ; 60 lines to fill
fill_outer
    ldx #$80 ; 1 line is a total of 256 bytes.
             ; 80 column mode actually has a row width of 128
             ; (80 columns + 48 extra). Each character is 2 bytes
             ; (character value then color). We're writing both
             ; the space chacater and the color in each iteration.
fill_inner
    lda #$60 ; space
    sta VERA_DATA0
    pla ; pop A for the color byte
    sta VERA_DATA0
    pha ; save A for next iteration
    dex
    bne fill_inner

    dey
    bne fill_outer

    pla ; drop A from the stack so return address is correct.

    rts
