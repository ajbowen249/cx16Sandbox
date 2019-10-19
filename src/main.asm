    * = $0801 ; RUN command jumps here

.include "boilerplate.asm"
.include "vera.asm"

    #init

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

    ; Increment 1 per data write, start at the first sprite register
    #set_vera_addr #$1F, #$50, #$00

    ; Our sprite will be stored in vram, starting at address 10000
    #a_to_vera_0 #$00 ; Address 12:5
    #a_to_vera_0 #$08 ; Mode 0, some junk, and address 16:13

    #a_to_vera_0 #$ff ; X 255
    #a_to_vera_0 #$00 ; Zero for X second byte

    #a_to_vera_0 #$ff ; Y 255
    #a_to_vera_0 #$00 ; Zero for Y second byte

    #a_to_vera_0 #$0C ; blank collision mask, z-depth 3, zero flip

    #a_to_vera_0 #$00 ; 8x8, palette offset 0

    ; We said the sprite started at 0, so write something there
    #set_vera_addr #$11, #$00, #$00
    lda #$ff
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0
    sta VERA_DATA0

    ; Enable sprite 0
    #set_vera_addr #$1F, #$40, #$00
    #a_to_vera_0 #$01

wait
    bra wait ; block forever
    rts ; done - return to basic (if we ever got here)

mytext .text 'HELLO', $6c, $60, 'WORLD', $61, 0

.include "subroutines.asm"
