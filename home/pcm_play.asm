def SAMPLE_SPEED equ 3
def BITS_PER_SAMPLE equ 2

PlayPCM::
	ldh a, [hROMBankBackup]
	push af
	ld a, b ; load PCM's bank
	call Bankswitch
	ld a, [hli]
	ld c, a ; lower byte of PCM length
	ld a, [hli]
	ld b, a ; high byte of PCM length
.loop
	ld a, [hli]
	ld d, a ; read sample byte
	ld a, SAMPLE_SPEED
.playSingleSample
	dec a
	jr nz, .playSingleSample

; transfer sound data
REPT 3
	call ExecutePCM
	call WaitSample
ENDR

	call ExecutePCM
; decrement sample length
	dec bc
	ld a, c
	or b ; if b and c are 0
	jr nz, .loop
; bankswitch back
	pop af
	call Bankswitch
	ret

ExecutePCM::
; sample player	
	ld a, d
	and $C0
	srl a
	ldh [rNR32], a ; manipulate the wave volume
	sla d
	sla d
	ret

WaitSample::
	ld a, SAMPLE_SPEED
.loop
	dec a
	jr nz, .loop
	ret
	