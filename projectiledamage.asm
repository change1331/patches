; projectile damages
org $938431
	dw #$0014 ; Power
org $938447
	dw #$0028 ; Spazer
org $93845D
	dw #$003C ; Spazer + ice
org $938473
	dw #$0064 ; Spazer + ice + wave
org $938489
	dw #$012C ; Plasma + ice + wave
org $93849F
	dw #$001E ; Ice
org $9384B5
	dw #$0032 ; Wave
org $9384CB
	dw #$0096 ; Plasma
org $9384E1
	dw #$003C ; Ice + wave
org $9384F7
	dw #$0046 ; Spazer + wave
org $93850D
	dw #$00FA ; Plasma + wave
org $938523
	dw #$00C8 ; Plasma + ice

; Charged beams
org $938539
	dw #$003C ; Power
org $93854F
	dw #$0078 ; Spazer
org $938565
	dw #$00B4 ; Spazer + ice
org $93857B
	dw #$012C ; Spazer + ice + wave
org $938591
	dw #$0384 ; Plasma + ice + wave
org $9385A7
	dw #$005A ; Ice / ice SBA
org $9385BD
	dw #$01C2 ; Plasma
org $9385D3
	dw #$0096 ; Wave
org $9385E9
	dw #$00B4 ; Ice + wave
org $9385FF
	dw #$00D2 ; Spazer + wave
org $938615
	dw #$0258 ; Plasma + ice
org $93862B
	dw #$02EE ; Plasma + wave

; Non-beam projectiles
org $938641
	dw #$0064 ; Missile
org $938657
	dw #$012C ; Super missile
org $93866D
	dw #$012C ; Super missile link
org $938671
	dw #$00C8 ; Power bomb
org $938675
	dw #$001E ; Bomb
org $938679
	dw #$0008 ; Beam explosion. Damage is ignored
org $93867D
	dw #$0008 ; Missile explosion. Damage is ignored
org $938681
	dw #$0000 ; Bomb explosion. Damage is ignored
org $938685
	dw #$012C ; Plasma SBA
org $938689
	dw #$012C ; Wave SBA
org $93868D
	dw #$012C ; Spazer SBA
org $938691
	dw #$0008 ; Super missile explosion. Damage is ignored
org $938695
	dw #$F000 ; Unused projectile 25h
org $9386AB
	dw #$012C ; Spazer SBA trail
org $9386C1
	dw #$1000 ; Shinespark echo
org $9386D7
	dw #$0000 ; Unused projectile 27h (unused shinespark beam?)