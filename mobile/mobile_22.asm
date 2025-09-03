Function89185: ; could be useful
; strcmp(hl, de, c)
; Compares c bytes starting at de and hl and incrementing together until a mismatch is found.
; Preserves hl and de.
	push de
	push hl
.loop
	ld a, [de]
	inc de
	cp [hl]
	jr nz, .done
	inc hl
	dec c
	jr nz, .loop
.done
	pop hl
	pop de
	ret

Function89193: ; could be useful
; copy(hl, de, 4)
; Copies c bytes from hl to de.
; Preserves hl and de.
	push de
	push hl
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	pop hl
	pop de
	ret

Function8919e: ; could be useful
; Searches for the c'th string starting at de.  Returns the pointer in de.
	ld a, c
	and a
	ret z
.loop
	ld a, [de]
	inc de
	cp "@"
	jr nz, .loop
	dec c
	jr nz, .loop
	ret
