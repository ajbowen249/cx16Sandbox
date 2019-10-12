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

    ; Increment 1 per data write, start at the first sprite register
    #set_vera_addr #$1F, #$50, #$00

    ; Our sprite will be store in vram, starting at address 10000
    lda #$00
    sta VERA_DATA0 ; Address 12:5
    lda #$08
    sta VERA_DATA0 ; Mode 0, some junk, and address 16:13

    lda #$ff ; X 255
    sta VERA_DATA0
    lda #$0 ; Zero for X second byte
    sta VERA_DATA0

    lda #$ff ; Y 255
    sta VERA_DATA0
    lda #$0 ; Zero for Y second byte
    sta VERA_DATA0

    lda #$0C ; blank collision mask, z-depth 3, zero flip
    sta VERA_DATA0

    lda #$00 ; 8x8, palette offset 0
    sta VERA_DATA0

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
    lda #$01
    sta VERA_DATA0

wait
    bra wait ; block forever
    rts ; done - return to basic (if we ever got here)

mytext .text 'HELLO', $6c, $60, 'WORLD', $61, 0

.include "subroutines.asm"
