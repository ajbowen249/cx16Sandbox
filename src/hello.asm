    * = $0801 ; RUN command jumps here

VERA_ADDR_LO = $9f20
VERA_ADDR_MID = $9f21
VERA_ADDR_HI = $9f22

VERA_DATA0 = $9f23
VERA_DATA1 = $9f24

init          ; No idea what this is doing. Got it from the Facebook group.
    asl $0a08 ; Nothing works without it.
    brk
    stz $2820,x
    and ($30)
    rol $34,x
    and #$00
    brk
    brk

    * = $0810

main
    ; VERA screen memory is a $00000
    lda #$10; Increment 1 per data write
    sta VERA_ADDR_LO
    lda #$00
    sta VERA_ADDR_MID
    lda #$00
    sta VERA_ADDR_HI

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Fill the screen with blank black
; Uses y to track the line and x
; to track the row.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
    lda #$05 ; green on black
    sta VERA_DATA0
    dex
    bne fill_inner

    dey
    bne fill_outer

    lda #$20; Increment 2 per data write (skip color)
    sta VERA_ADDR_LO
    lda #$00
    sta VERA_ADDR_MID
    lda #$00
    sta VERA_ADDR_HI

    ; print hello world to data1 port
    ldx #0 ; simple counter
loop
    lda mytext,x ; get character x
    beq done ; zero signals end of string
    sec ; subtract '@' from text to convert ASCII to PETSCII
    sbc #'@' ; This is not always required, but here for simplicity
    sta VERA_DATA0 ; store character in vera data1 port
    inx ; inx to next character
    bra loop ; goto loop

done

wait
    bra wait ; block forever
    rts ; done - return to basic (if we ever got here)

mytext .text 'HELLO', $6c, $60, 'WORLD', $61, 0
