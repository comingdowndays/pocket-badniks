UnusedFindItemInPCOrBag: ; could be useful
	ld a, [wScriptVar]
	ld [wCurItem], a
	ld hl, wNumPCItems
	call CheckItem
	jr c, .found

	ld a, [wScriptVar]
	ld [wCurItem], a
	ld hl, wNumItems
	call CheckItem
	jr c, .found

	xor a
	ld [wScriptVar], a
	ret

.found
	ld a, 1
	ld [wScriptVar], a
	ret
