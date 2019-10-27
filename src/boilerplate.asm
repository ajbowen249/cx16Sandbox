init .macro    ; No idea what this is doing. Got it from the Facebook group.
    asl $0a08  ; Nothing works without it.
    brk
    stz $2820,x
    and ($30)
    rol $34,x
    and #$00
    brk
    brk
    .endm
