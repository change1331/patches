; 50 per ammo in hex
!hp = 0032
; min hp is always 30*hp per ammo +1
!minhp = !hp*30+1
; ammo reach always +1 so 8 means 1/10 works 9 means 0/10 works etc
!ammo = 0008

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
    BNE .return ; ONCE PER 8 FRAMES
    LDA #$0001
    JSL $91DF80 ; MISSILES
    LDA #$!hp
    JSL $91DF51 ; TAKE 50 ENERGY
    DEC $0DEC
    BEQ $02 ; DONE CFING
    BPL .return ; ANOTHER ROUND
    LDA #$000A
    STA $0DEC
    INC $0DEA
.return
    RTS
reverse2:
    LDA $05B6
    BIT #$0007
    BNE .return ; ONCE PER 8 FRAMES
    LDA #$0001
    JSL $91DFD3 ; SUPERS
    LDA #$!hp
    JSL $91DF51 ; TAKE 50 ENERGY
    DEC $0DEC
    BEQ $02 ; DONE CFING
    BPL .return ; ANOTHER ROUND
    LDA #$000A
    STA $0DEC
    INC $0DEA
.return
    RTS
reverse3:
    LDA $05B6
    BIT #$0007
    BNE .return ; ONCE PER 8 FRAMES
    LDA #$0001
    JSL $91DFF0 ; PBS
    LDA #$!hp
    JSL $91DF51 ; TAKE 50 ENERGY
    DEC $0DEC
    BEQ $02 ; DONE CFING
    BPL .return ; ANOTHER ROUND
    LDA #$D75B
    STA $0A58
    LDA #$EB52
    STA $0A5C
    LDA #$0003
    STA $0A94
    LDA #$000C
    STA $0A96
.return
    RTS
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
    CMP #$!minhp
    BMI .return ; energy < 1501
    LDA $09C6
    CLC
    ADC #$!ammo
    CMP $09C8
    BCS .return ; MISSILES + x >= MAX 
    LDA $09CA
    CLC
    ADC #$!ammo
    CMP $09CC
    BCS .return ; SUPERS + x >= MAX 
    LDA $09CE
    CLC
    ADC #$!ammo
    CMP $09D0
    BCS .return ; PBS + x >= MAX
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
