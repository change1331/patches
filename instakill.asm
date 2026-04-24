; insta kill
lorom


;  periodic damage
org $90E9CE
periodic:
	PHP
	REP #$30
	LDA $0A78        ;\
	BEQ .not_frozen  ;} If time is frozen: clear periodic damage and return
	JMP $EA3D        ;/
.not_frozen
    LDA $0A4E
    BNE $03       ; if periodic damage isn't zero kill
    JMP $EA3D
    STZ $09D6     ; reserves = 0
	STZ $0A4C     ; Samus subhealth = 0
	STZ $09C2     ; Samus health = 0
	PLP
	RTS

; normal damage
org $91DF6B
    STZ $09D6     ; reserves = 0
	STZ $0A4C     ; Samus subhealth = 0
	STZ $09C2     ; Samus health = 0

; shine spark
org $90D000
    STZ $09D6     ; reserves = 0
	STZ $0A4C     ; Samus subhealth = 0
	STZ $09C2     ; Samus health = 0
    BRA END
org $90D065
END: