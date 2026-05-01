; lets you charge with any beam but damage is halved w/o charge.
lorom
; equipment change
org $91E6A0
    bit #$100F
; normal shot
org $90B8EF
    bit #$100F
; charge check
org $90B81E
    bit #$100F

org $A0A862
    jsr halvedamage
org $a0f7d3
halvedamage:
    LDA $0C18,y
    BIT #$0010
    BEQ .DONE ; NOT A CHARGE BEAM
    LDA $09A6
    BIT #$1000
    BEQ .HALF ; CHARGE BEAM BUT DON'T HAVE CHARGE BEAM EQUIPPED
    BRA .DONE
.HALF
    LDA $187A
    LSR
    STA $187A
.DONE
    LDA $0F8C,x
    RTS
