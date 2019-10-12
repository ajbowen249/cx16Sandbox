    * = $0801 ; RUN command jumps here

    .include "vera.asm"

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

    lda #$05 ; green on black
    jsr clear_screen_80_60

    ; Increment 2 per data write (skip color)
    #set_vera_addr #$20, #$00, #$00

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

    .include "subroutines.asm"
