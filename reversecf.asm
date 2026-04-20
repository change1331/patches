lorom

org $90D648
    NOP : NOP : NOP ; STZ $0DEA

org $90D5AD
start:
    JSR reversecf
    BCS activatecf
    CMP $12
    BNE .normdone ; lrdownshot
    LDA $0B2E
    BNE .normdone ; y subspeed
    LDA $0B2C
    BNE .normdone ; y speed
    LDA $09C2
    CMP #$0033
    BPL .normdone ; energy > 50
    LDA $09D6
    BNE .normdone ; reserve != 0
    LDA $09C6
    CMP #$000A
    BMI .normdone ; missiles < 10
    LDA $09CA
    CMP #$000A
    BMI .normdone ; supers < 10
    LDA $09CE
    CMP #$000A
    BMI .normdone ; pbs < 10
    STZ $0DEA
    bra activatecf
.normdone
    PLP
    SEC
    RTL
    
org $90D5EA
nocf:

org $90D5ED
activatecf:

org $90D6DD
    dw normal, $D706, $D729, reverse1, reverse2, reverse3

org $90FD00
print pc
normal:
    LDA $05B6
    BIT #$0007
    BNE .return ; ONCE PER 8 FRAMES
    DEC $09C6 ; MISSILES
    LDA #$0032
    JSL $91DF12 ; GIVE SAMUS 50 ENERGY
    DEC $0DEC
    BEQ $02 ; DONE CFING
    BPL .return ; ANOTHER ROUND
    LDA #$000A
    STA $0DEC
    INC $0DEA
.return
    RTS
reverse1:
    LDA $05B6
    BIT #$0007
    BNE .return1 ; ONCE PER 8 FRAMES
    INC $09C6 ; MISSILES
    LDA #$0032
    JSL $91DF51 ; TAKE 50 ENERGY
    DEC $0DEC
    BEQ $02 ; DONE CFING
    BPL .return1 ; ANOTHER ROUND
    LDA #$000A
    STA $0DEC
    INC $0DEA
.return1
    RTS
reverse2:
    LDA $05B6
    BIT #$0007
    BNE .return2 ; ONCE PER 8 FRAMES
    INC $09CA ; SUPERS
    LDA #$0032
    JSL $91DF51 ; TAKE 50 ENERGY
    DEC $0DEC
    BEQ $02 ; DONE CFING
    BPL .return2 ; ANOTHER ROUND
    LDA #$000A
    STA $0DEC
    INC $0DEA
.return2
    RTS
reverse3:
    LDA $05B6
    BIT #$0007
    BNE .return3 ; ONCE PER 8 FRAMES
    INC $09CE ; PBS
    LDA #$0032
    JSL $91DF51 ; TAKE 50 ENERGY
    DEC $0DEC
    BEQ $02 ; DONE CFING
    BPL .return3 ; ANOTHER ROUND
    LDA #$D75B
    STA $0A58
    LDA #$EB52
    STA $0A5C
    LDA #$0003
    STA $0A94
    LDA #$000C
    STA $0A96
.return3
    RTS
print pc
reversecf:
    LDA #$0430
    ORA $09B2
    STA $12
    LDA $8B
    CMP $12
    BNE .return ;not pressint l r down shoot
    LDA $0B2E
    BNE .return ; Y SUBSPEED
    LDA $0B2C
    BNE .return ; Y SPEED
    LDA $09C2
    CMP #$05DD
    BMI .return ; energy < 1501
    LDA $09C6
    CLC
    ADC #$0009
    CMP $09C8
    BCS .return ; MISSILES + 9 >= MAX 
    LDA $09CA
    CLC
    ADC #$0009
    CMP $09CC
    BCS .return ; SUPERS + 9 >= MAX 
    LDA $09CE
    CLC
    ADC #$0009
    CMP $09D0
    BCS .return ; TOO MANY 
    LDA #$0003
    STA $0DEA
    SEC
    RTS
.return
    LDA #$0430
    ORA $09B2
    STA $12
    LDA $8B
    CLC
    RTS
