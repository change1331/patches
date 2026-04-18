;alters beam doors to open to any beam.

org $84FF0E
check_shot:
    lda $1D77,x
    and #$001F
    bne .hit       ; check if projectile beam matches door type
    jsr $F900      ; check for hyper shot in escape (`escape_hyper_door_check` in escape.asm)
    bcs .hit

.no_hit:
    jmp $BD74      ; Queue sound 57h, sound library 2, max queued sounds allowed = 6 (shot door/gate with dud shot), clear PLM shot status, rts

.hit:
    jmp $BD14  