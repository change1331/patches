; only 50% damage reduction from varia
lorom

org $8DE379
	jsl check_heat_protection
	nop : nop
	bcs $2A

; hook heat damage calculation
org $8DE381
	jsl compute_heat_damage
	nop : nop : nop

; remove periodic damage reduction
org $90E9CE
	PHP
	REP #$30
	LDA $0A78        ;\
	BEQ .not_frozen  ;} If time is frozen: clear periodic damage and return
	JMP $EA3D        ;/
.not_frozen
	LDA $0A4C     ;\
	SEC           ;|
	SBC $0A4E     ;} Samus subhealth -= periodic subdamage
	STA $0A4C     ;/
	LDA $09C2     ;\
	SBC $0A50     ;} Samus health -= periodic damage
	STA $09C2     ;/
	STZ $0A4E     ; Periodic subdamage = 0
	STZ $0A50     ; Periodic damage = 0
	BPL .not_dead ; If Samus health < 0:
	STZ $0A4C     ; Samus subhealth = 0
	STZ $09C2     ; Samus health = 0
	PLP
	RTS
.not_dead
	PLP
	RTS

org $a0a463
	bit #$0001		; A contains equipped items
	beq nosuit
	lsr $12			; /2 if varia
nosuit:
    lda $12
    rtl
    
org $a3eed8
    lda #$C000
    sta $12
	lda $09A2		; equipped items
	bit #$0001
	beq novaria		; /2 if varia
	lsr $12
novaria:
    jmp $EEF2

    ; Patch lava check code to skip damage only if both Varia and Gravity are equipped:
org $9081DB 
	jsr check_gravity_and_varia
	beq $2f

;;; free space in bank $90:
org $90F680
check_gravity_and_varia:
	and #$0021
	cmp #$0021
	rts

check_heat_protection:
	lda $09A2
	and #$0001       ; check if varia suit equipped
	bne protected
	lda $0A44
	cmp #$E86A    	 ; check if samus is appearing (initial fanfare during new/loading game)
	beq protected   
	clc
	rtl
protected:
	sec
	rtl

compute_heat_damage:
	lda $0A4E
	clc
	adc #$4000       ; normal heat damage otherwise
	rtl

warnpc $90F700
