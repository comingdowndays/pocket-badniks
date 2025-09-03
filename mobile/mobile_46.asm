Function118440:
	push af
	ld a, BANK(s5_bfff)
	call OpenSRAM
	ld a, [s5_bfff]
	inc a
	ld [s5_bfff], a
	call CloseSRAM
	pop af
	ret

BattleTowerRoomMenu_Cleanup:
	di
	xor a
	ldh [hMobileReceive], a
	ldh [hMobile], a
	ldh [hVBlank], a
	call NormalSpeed
	xor a
	ldh [rIF], a
	ld a, [wcd32]
	ldh [rIE], a
	ei
	ld a, [wcd7f]
	ld [wStateFlags], a
	ld a, [wMobileErrorCodeBuffer]
	ld [wScriptVar], a
	ret

Function118473:
	ld a, [wcd65]
	and a
	ret z
	ld a, [wcd66]
	inc a
	ld [wcd66], a
	cp 60
	ret nz
	xor a
	ld [wcd66], a
	ld a, [wcd67]
	inc a
	ld [wcd67], a
	cp 60
	ret nz
	ld a, [wcd68]
	inc a
	ld [wcd68], a
	cp 99
	jr z, .ninety_nine
	xor a
	ld [wcd67], a
	ret

.ninety_nine
	xor a
	ld [wcd65], a
	ret

Function11878d:
	ld a, [wc821]
	bit 1, a
	jr nz, .asm_1187af
	bit 2, a
	jr nz, .asm_1187d1
	bit 0, a
	jr nz, .asm_1187aa
	ld a, [wcd89]
	and $1
	jr z, .asm_1187a7
	ld a, $3
	ldh [rWBK], a
.asm_1187a7
	jp BattleTowerRoomMenu_IncrementJumptable
.asm_1187aa
	call Function118821
	ret c
	ret
.asm_1187af
	ld a, MOBILEAPI_00
	call MobileAPI
	ld [wMobileErrorCodeBuffer], a
	ld a, l
	ld [wMobileErrorCodeBuffer + 1], a
	ld a, h
	ld [wMobileErrorCodeBuffer + 2], a
	ld a, MOBILEAPI_05
	call MobileAPI
	ld a, [wc3f0]
	ld [wc319], a
	ld a, [wcd34]
	ld [wBattleTowerRoomMenuJumptableIndex], a
	ret
.asm_1187d1
	ld hl, wcd89
	bit 0, [hl]
	jr nz, .asm_118803
	set 0, [hl]
	ld a, BANK(w6_d000)
	ldh [rWBK], a
	ld de, w6_d000
	ld bc, $1000
	ld a, [hl]
	sla a
	jr c, .asm_1187f9
	sla a
	jr c, .asm_1187fd
	sla a
	jr c, .asm_1187f5
	ld a, MOBILEAPI_12
	jr .asm_1187ff
.asm_1187f5
	ld a, MOBILEAPI_14
	jr .asm_1187ff
.asm_1187f9
	ld a, MOBILEAPI_15
	jr .asm_1187ff
.asm_1187fd
	ld a, MOBILEAPI_16
.asm_1187ff
	call MobileAPI
	ret
.asm_118803
	ld a, $d3

SetMobileErrorCode:
	ld [wMobileErrorCodeBuffer], a
	xor a
	ld [wMobileErrorCodeBuffer + 1], a
	ld [wMobileErrorCodeBuffer + 2], a
	ld a, MOBILEAPI_05
	call MobileAPI
	ld a, [wc3f0]
	ld [wc319], a
	ld a, [wcd34]
	ld [wBattleTowerRoomMenuJumptableIndex], a
	ret

Function118821:
	ld a, [wc319]
	cp $3
	jr c, .asm_11884a
	cp $4
	jr z, .asm_11884a
	ldh a, [hJoyDown]
	cp $5
	jr nz, .asm_11884a
	ld a, MOBILEAPI_05
	call MobileAPI
	ld a, $a
	ld [wMobileErrorCodeBuffer], a
	ld a, [wc3f0]
	ld [wc319], a
	ld a, [wcd34]
	ld [wBattleTowerRoomMenuJumptableIndex], a
	scf
	ret
.asm_11884a
	and a
	ret

Function11884c:
	ldh a, [hJoyDown]
	cp $5
	jr nz, .asm_118864
	ld a, MOBILEAPI_05
	call MobileAPI
	ld a, $a
	ld [wMobileErrorCodeBuffer], a
	ld a, [wcd34]
	ld [wBattleTowerRoomMenuJumptableIndex], a
	scf
	ret

.asm_118864
	and a
	ret

Function11886e:
	xor a

Function1188b0:
	ld de, wc346
	ld a, MOBILEAPI_06
	jp Function119e2b

Function1188b8:
	ld de, wc3ac
	ld a, MOBILEAPI_07
	jp Function119e2b

Function1188c0:
	ld de, wEmailAddress
	ld a, MOBILEAPI_08
	jp Function119e2b

Function1188c8:
	ld a, $1
	ld [wcd65], a
	call Function1188e7
	ld hl, wc708
.asm_1188d3
	ld a, [de]
	inc de
	ld [hli], a
	and a
	jr nz, .asm_1188d3
	call Function119eb4
	call Function119ec2
	ld hl, wc708
	ld a, MOBILEAPI_03
	jp Function119e2b

Function1188e7:
	ld de, wc346
	ld a, BANK(s5_aa4a)
	call OpenSRAM
	ld a, [s5_aa4a]
	call CloseSRAM
	and a
	ret z
	sla a
	ld c, a
.asm_1188fa
	ld a, [de]
	inc de
	and a
	jr nz, .asm_1188fa
	dec c
	jr nz, .asm_1188fa
	ret

Function11891c:
	call Function118b42
	jp BattleTowerRoomMenu_IncrementJumptable

BattleTowerRoomMenu_PickLevelMessage:
	ld a, [wcd38]
	and a
	jr nz, .asm_11892d
	ld hl, Text_WhatLevelDoYouWantToChallenge
	jr .asm_118930

.asm_11892d
	ld hl, Text_CheckBattleRoomListByMaxLevel

.asm_118930
	call BattleTowerRoomMenu_SetMessage
	call BattleTowerRoomMenu_IncrementJumptable

Function118b24:
	ld hl, wc346
	ld a, LOW(wc708)
	ld [hli], a
	ld a, HIGH(wc708)
	ld [hli], a
	ld a, LOW(wcc60)
	ld [hli], a
	ld a, HIGH(wcc60)
	ld [hli], a
	call Function119eb4
	call Function119ec2
	ld a, $80
	ld [wcd89], a
	ld hl, wc346
	ret

Function118b42:
	ld hl, wd002
	ld a, l
	ld [wcd51], a
	ld a, h
	ld [wcd52], a
	call Function118b8c
	ld a, l
	ld [wcd55], a
	ld [wcd59], a
	ld a, h
	ld [wcd56], a
	ld [wcd5a], a
	call Function118b8c
	ld a, l
	ld [wcd53], a
	ld [wcd5d], a
	ld a, h
	ld [wcd54], a
	ld [wcd5e], a
	call Function118b8c
	ld a, l
	ld [wcd57], a
	ld [wcd5b], a
	ld a, h
	ld [wcd58], a
	ld [wcd5c], a
	call Function118b8c
	ld a, l
	ld [wcd5f], a
	ld a, h
	ld [wcd60], a
	ret

Function118b8c:
.asm_118b8c
	call Function118b9a
	ret nc
	ld a, [hli]
	cp $d
	jr nz, .asm_118b8c
	dec hl
	xor a
	ld [hli], a
	ld [hli], a
	ret

Function118b9a:
	ld a, h
	cp $e0
	ret c
	ld a, $d3
	call SetMobileErrorCode
	and a
	ret

pushc ascii

ExchangeDownloadURL:
	db "http://gameboy.datacenter.ne.jp/cgb/download?name=/01/CGB-BXTJ/exchange/index.txt", 0

BattleDownloadURL:
	db "http://gameboy.datacenter.ne.jp/cgb/download?name=/01/CGB-BXTJ/battle/index.txt", 0

NewsDownloadURL:
	db "http://gameboy.datacenter.ne.jp/cgb/download?name=/01/CGB-BXTJ/news/index.txt", 0

StadiumDownloadURL:
	db "http://gameboy.datacenter.ne.jp/cgb/download?name=/01/CGB-BXTJ/POKESTA/menu.cgb", 0

OddEggDownloadURL:
	db "http://gameboy.datacenter.ne.jp/cgb/download?name=/01/CGB-BXTJ/tamago/index.txt", 0

popc

Function118e39:
	ld a, [hli]
	and a
	jr nz, Function118e39
	dec hl

asm_118e3e:
	ld a, [hld]
	cp $2f
	jr nz, asm_118e3e
	inc hl
	inc hl
	ld de, wcd85
	ld c, $4
.asm_118e4a
	ld a, [hli]
	cp $2e
	jr z, .asm_118e63
	cp $30
	jr c, .asm_118e67
	cp $3a
	jr nc, .asm_118e67
	sub $30
	add $f6
	ld [de], a
	inc de
	dec c
	jr nz, .asm_118e4a
	ld de, wcd85
.asm_118e63
	ld a, $50
	ld [de], a
	ret
.asm_118e67
	ld a, $f3
	ld [de], a
	inc de
	jr .asm_118e63

Function118e6d:
	xor a
	ld [wcd65], a
	ld a, MOBILEAPI_05
	jp Function119e2b

Function118f68:
	call Function119223
	ret c
	call Function118440
	ld a, [wcd51]
	ld l, a
	ld a, [wcd52]
	ld h, a
	ld de, wcc60
	call Function1191ad
	ret c
	ld a, [wcc60]
	and a
	jr z, .asm_118fba
	ld hl, wc346
	ld a, LOW(wc608)
	ld [hli], a
	ld a, HIGH(wc608)
	ld [hli], a
	ld a, [wcd4b]
	ld [hli], a
	ld a, [wcd4c]
	ld [hli], a
	ld a, LOW(wc708)
	ld [hli], a
	ld a, HIGH(wc708)
	ld [hli], a
	ld a, LOW(wcc60)
	ld [hli], a
	ld a, HIGH(wcc60)
	ld [hli], a
	call Function119eb4
	call Function119ec2
	ld a, $40
	ld [wcd89], a
	ld hl, wc346
	ld de, w3_de00
	ld bc, $200
	ld a, MOBILEAPI_16
	jp Function119e2b

.asm_118fba
	call BattleTowerRoomMenu_IncrementJumptable
	jp BattleTowerRoomMenu_IncrementJumptable

Function118fc0:
	call Function118440
	ld a, [wcd55]
	ld l, a
	ld a, [wcd56]
	ld h, a
	ld de, wcc60
	call Function1191ad
	ret c
	ld a, [wcc60]
	and a
	jr z, .asm_118ffa
	ld a, [wcd51]
	ld l, a
	ld a, [wcd52]
	ld h, a
	ld de, wcc60
	call Function1191ad
	ret c
	ld a, [wcc60]
	and a
	jr z, .asm_118ff2
	ld hl, Text_SentSaveFileReadingNews
	jr .asm_118ff5

.asm_118ff2
	ld hl, Text_ReadingNews

.asm_118ff5
	call BattleTowerRoomMenu_SetMessage
	jr Function119009

.asm_118ffa
	ld hl, Text_ReadingNews
	call BattleTowerRoomMenu_SetMessage
	call BattleTowerRoomMenu_IncrementJumptable
	call BattleTowerRoomMenu_IncrementJumptable
	jp BattleTowerRoomMenu_IncrementJumptable

Function119009:
	call Function118440
	call Function119300
	ld a, [wcd55]
	ld l, a
	ld a, [wcd56]
	ld h, a
	ld de, wcc60
	call Function1191ad
	ret c
	ld hl, wc346
	ld a, LOW(wc608)
	ld [hli], a
	ld a, HIGH(wc608)
	ld [hli], a
	ld a, [wcd4b]
	ld [hli], a
	ld a, [wcd4c]
	ld [hli], a
	ld a, LOW(wc708)
	ld [hli], a
	ld a, HIGH(wc708)
	ld [hli], a
	ld a, LOW(wcc60)
	ld [hli], a
	ld a, HIGH(wcc60)
	ld [hli], a
	call Function119eb4
	call Function119ec2
	ld a, $40
	ld [wcd89], a
	ld hl, wc346
	ld de, w3_d000
	ld bc, $1000
	ld a, MOBILEAPI_16
	jp Function119e2b

Function119054:
	ld a, $6
	call OpenSRAM
	ld hl, wd002
	ld a, [wcd4f]
	ld e, a
	ld a, [wcd50]
	ld d, a
	ld a, [w3_d000]
	ld c, a
	ld a, [w3_d000 + 1]
	ld b, a
	call Function119192
	ret c
	ld a, [wcd89]
	and $1
	jr z, .asm_11908a
	ld a, $6
	ldh [rWBK], a
	ld hl, wd002
	ld a, [w3_d000]
	ld c, a
	ld a, [w3_d000 + 1]
	ld b, a
	call Function119192
	ret c

.asm_11908a
	call CloseSRAM
	ld a, $3 ; ???
	ldh [rWBK], a
	ld a, BANK(s5_b1b3) ; aka BANK(s5_b1b4) and BANK(s5_aa7f) and BANK(s5_b2f3) and BANK(s5_b2f4)
	call OpenSRAM
	ld a, [wcd4f]
	ld [s5_b1b3], a
	ld a, [wcd50]
	ld [s5_b1b4], a
	ld hl, wcd20
	ld de, s5_aa7f
	ld bc, 12
	call CopyBytes
	ldh a, [rWBK]
	push af
	ld a, BANK(wPlayerPrefecture) ; aka BANK(wPlayerPostalCode)
	ldh [rWBK], a
	ld a, [wPlayerPrefecture]
	ld [s5_b2f3], a
	ld hl, wPlayerPostalCode
	ld de, s5_b2f4
	ld bc, 4
	call CopyBytes
	pop af
	ldh [rWBK], a
	call CloseSRAM
	jp BattleTowerRoomMenu_IncrementJumptable

Function1190ec:
	ld a, BANK(s5_aa73)
	call OpenSRAM
	ld hl, wBGMapBuffer
	ld de, s5_aa73
	ld bc, 12
	call CopyBytes
	call CloseSRAM
	ld a, BANK(s5_aa72)
	call OpenSRAM
	ld a, $1
	ld [s5_aa72], a
	call CloseSRAM
	ld a, BANK(s6_a000)
	call OpenSRAM
	ld a, [w3_d000]
	ld c, a
	ld a, [w3_d000 + 1]
	ld b, a
	ld hl, wd002
	ld de, s6_a000
	call Function119192
	ret c
	ld a, [wcd89]
	and $1
	jr z, .asm_11913e
	ld a, BANK(w6_d000)
	ldh [rWBK], a
	ld a, [w6_d000]
	ld c, a
	ld a, [w6_d000 + 1]
	ld b, a
	ld hl, w6_d000 + 2
	call Function119192
	ret c

.asm_11913e
	ld a, BANK("Battle Tower RAM")
	ldh [rWBK], a
	call CloseSRAM
	ld hl, Text_ReceivedNews
	call BattleTowerRoomMenu_SetMessage
	jp BattleTowerRoomMenu_IncrementJumptable

Function11915d:
	ld hl, w3_d802
	ld de, wcd20
	ld bc, 12
	call CopyBytes
	ld a, BANK(s5_aa7f)
	call OpenSRAM
	ld hl, wBGMapBuffer
	ld de, s5_aa7f
	ld c, 12
.asm_119176
	ld a, [de]
	inc de
	cp [hl]
	jr nz, .asm_119184
	inc hl
	dec c
	jr nz, .asm_119176
	call BattleTowerRoomMenu_IncrementJumptable
	jr .asm_11918e

.asm_119184
	ld a, $16
	ld [wBattleTowerRoomMenuJumptableIndex], a
	ld a, $b
	ld [wMobileErrorCodeBuffer], a

.asm_11918e
	call CloseSRAM
	ret

Function119192:
	inc b
	inc c
	jr .asm_11919e

.asm_119196
	ld a, [hli]
	ld [de], a
	inc de
	ld a, $bf
	cp d
	jr c, .asm_1191a6

.asm_11919e
	dec c
	jr nz, .asm_119196
	dec b
	jr nz, .asm_119196
	and a
	ret

.asm_1191a6
	ld a, $d3
	call SetMobileErrorCode
	scf
	ret

Function1191ad:
	push bc
	ld c, $0
	ld a, $5
	ldh [rWBK], a
.asm_1191b4
	ld a, [hli]
	ld [de], a
	inc de
	and a
	jr z, .asm_1191cc
	inc c
	ld a, c
	cp $a6
	jr c, .asm_1191b4
	ld a, $da
	call SetMobileErrorCode
	ld a, BANK("Battle Tower RAM")
	ldh [rWBK], a
	pop bc
	scf
	ret

.asm_1191cc
	ld a, BANK("Battle Tower RAM")
	ldh [rWBK], a
	pop bc
	and a
	ret

Function1191d3:
	ld hl, w3_d100 + 2
	ld a, l
	ld [wcd53], a
	ld a, h
	ld [wcd54], a
	call Function11920f
	ld a, l
	ld [wcd51], a
	ld a, [wcd4a]
	ld a, h
	ld [wcd52], a
	call Function11920f
	ld a, l
	ld [wcd55], a
	ld a, [wcd4a]
	ld a, h
	ld [wcd56], a
	call Function11920f
	ld a, [wcd49]
	ld a, l
	ld [wcd57], a
	ld a, [wcd4a]
	ld a, h
	ld [wcd58], a
	call Function11920f
	ret

Function11920f:
.asm_11920f
	call Function118b9a
	ret nc
	ld a, [hli]
	cp $d
	jr nz, .asm_11920f
	ld a, [hli]
	cp $a
	jr nz, .asm_11920f
	dec hl
	xor a
	ld [hld], a
	ld [hli], a
	inc hl
	ret

Function119223:
	xor a
	ld [wcd4b], a
	ld [wcd4c], a
	ld a, BANK(s5_b092) ; aka BANK(s5_b1b1) and BANK(s5_b1b2) and BANK(s5_b1d3)
	call OpenSRAM
	ld hl, wEmailAddress
	ld de, s5_b092
	ld bc, 31
	call CopyBytes
	dec de
	xor a
	ld [de], a
	ld hl, w3_d810
.asm_119241
	ld a, [hli]
	cp $50
	jr nz, .asm_119241
	ld a, [hli]
	ld [wcd4f], a
	ld a, [hli]
	ld [wcd50], a
	ld a, [hli]
	ld [s5_b1b1], a
	ld c, a
	ld a, [hli]
	ld [s5_b1b2], a
	ld b, a
	ld de, s5_b1d3
	call CopyBytes
	call CloseSRAM
	ld e, l
	ld d, h
	ld hl, wc608
.asm_119266
	ld a, [de]
	inc de
	cp $ff
	jr z, .asm_1192c2
	cp $fe
	jr z, .asm_1192a5
	call OpenSRAM
	ld a, [de]
	inc de
	ld c, a
	ld a, [de]
	inc de
	ld b, a
	ld a, [de]
	inc de
	push de
	push af
	ld a, [wcd4b]
	ld e, a
	ld a, [wcd4c]
	ld d, a
	pop af
.asm_119286
	push af
	ld a, [bc]
	inc bc
	ld [hli], a
	inc de
	pop af
	dec a
	jr nz, .asm_119286
	call CloseSRAM
	ld a, e
	ld [wcd4b], a
	ld a, d
	ld [wcd4c], a
	pop de
.asm_11929b
	and a
	jr z, .asm_119266
	ld a, $d3
	call SetMobileErrorCode
	scf
	ret

.asm_1192a5
	ld a, [wcd4b]
	ld c, a
	ld a, [wcd4c]
	ld b, a
	ld a, [de]
	inc de
.asm_1192af
	push af
	ld a, [de]
	inc de
	ld [hli], a
	inc bc
	pop af
	dec a
	jr nz, .asm_1192af
	ld a, c
	ld [wcd4b], a
	ld a, b
	ld [wcd4c], a
	jr .asm_11929b

.asm_1192c2
	ld a, e
	ld [wcd4d], a
	ld a, d
	ld [wcd4e], a
	and a
	ret

Function119300:
	xor a
	ld [wcd4b], a
	ld [wcd4c], a
	ld a, [wcd4d]
	ld e, a
	ld a, [wcd4e]
	ld d, a
	ld hl, wc608
	ld a, [wcd4b]
	ld c, a
	ld a, [wcd4c]
	ld b, a
.asm_11931a
	ld a, [de]
	inc de
	cp $50
	jr z, .asm_119324
	ld [hli], a
	inc bc
	jr .asm_11931a

.asm_119324
	ld a, $3d
	ld [hli], a
	inc bc
	ld a, c
	ld [wcd4b], a
	ld a, b
	ld [wcd4c], a
	ld a, [de]
	inc de
	call OpenSRAM
	ld a, [de]
	inc de
	ld c, a
	ld a, [de]
	inc de
	ld b, a
	ld a, [de]
	inc de
	push de
	push af
	ld a, [wcd4b]
	ld e, a
	ld a, [wcd4c]
	ld d, a
	pop af
.asm_119348
	push af
	ld a, [bc]
	and $f0
	swap a
	call Function1197bf
	ld [hli], a
	inc de
	ld a, [bc]
	inc bc
	and $f
	call Function1197bf
	ld [hli], a
	inc de
	pop af
	dec a
	jr nz, .asm_119348
	call CloseSRAM
	ld a, e
	ld [wcd4b], a
	ld a, d
	ld [wcd4c], a
	pop de
	ld a, [de]
	cp $50
	jr z, .asm_11937f
	ld a, [wcd4b]
	ld c, a
	ld a, [wcd4c]
	ld b, a
	ld a, $26
	ld [hli], a
	inc bc
	jr .asm_11931a

.asm_11937f
	ret

Function119380:
	ld a, $80
	ld [wcd49], a
	jp BattleTowerRoomMenu_IncrementJumptable

Function119413:
	ld a, $6 ; ???
	call OpenSRAM
	ld a, [w3_d000]
	ld c, a
	ld a, [w3_d000 + 1]
	ld b, a
	dec bc
	dec bc
	ld hl, wd002
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	call Function119192
	ret c
	ld a, [wcd89]
	and $1
	jr z, .asm_119447
	ld a, BANK(w6_d000)
	ldh [rWBK], a
	ld a, [w6_d000]
	ld c, a
	ld a, [w6_d000 + 1]
	ld b, a
	ld hl, w6_d000 + 2
	call Function119192
	ret c

.asm_119447
	ld a, BANK("Battle Tower RAM")
	ldh [rWBK], a
	call CloseSRAM
	jp BattleTowerRoomMenu_IncrementJumptable

Function119451:
	ld a, [wcd89]
	and $1
	jr z, .asm_11945d
	ld a, $d3
	jp SetMobileErrorCode
.asm_11945d
	xor a
	ld [wcd50], a
	call Function119694
	ld a, b
	ld [wcd49], a
	call Function1196cd
	ld a, [wd002]
	ld hl, wd003

Function119471:
	push af
	ld a, [hli]
	ld [wc608], a
	ld a, [hli]
	ld [wc608 + 3], a
	ld a, [hli]
	ld [wc608 + 1], a
	ld a, [hli]
	ld [wc608 + 2], a
	ld a, [hli]
	ld [wc608 + 4], a
	ld a, [hli]
	ld [wc608 + 5], a
	push hl
	ld a, [wc608]
	cp $ff
	jr z, .asm_1194a7
	ld a, [wc608 + 2]
	cp $ff
	jr z, .asm_1194a7
	ld a, [wc608 + 1]
	cp $ff
	jr nz, .asm_1194a7
	call Function119584
	jr c, .asm_11950c
	jr .asm_1194f0
.asm_1194a7
	ld hl, wc608
	ld de, wc608 + 3
	ld c, $3
.asm_1194af
	ld a, [de]
	inc de
	cp [hl]
	inc hl
	jr c, .asm_1194f3
	jr z, .asm_1194b9
	jr nc, .asm_1194bc
.asm_1194b9
	dec c
	jr nz, .asm_1194af
.asm_1194bc
	ld c, $3
	ld hl, wcd49
	ld de, wc608
.asm_1194c4
	ld a, [de]
	inc de
	cp $ff
	jr z, .asm_1194d1
	cp [hl]
	jr z, .asm_1194d1
	jr c, .asm_1194d5
	jr nc, .asm_1194f0
.asm_1194d1
	inc hl
	dec c
	jr nz, .asm_1194c4
.asm_1194d5
	ld c, $3
	ld hl, wcd49
	ld de, wc608 + 3
.asm_1194dd
	ld a, [de]
	inc de
	cp $ff
	jr z, .asm_1194ea
	cp [hl]
	jr c, .asm_1194f0
	jr z, .asm_1194ea
	jr nc, .asm_11950c
.asm_1194ea
	inc hl
	dec c
	jr nz, .asm_1194dd
	jr .asm_11950c
.asm_1194f0
	pop hl
	jr .asm_119557
.asm_1194f3
	ld c, $3
	ld hl, wcd49
	ld de, wc608
.asm_1194fb
	ld a, [de]
	inc de
	cp $ff
	jr z, .asm_119508
	cp [hl]
	jr c, .asm_11950c
	jr z, .asm_119508
	jr nc, .asm_1194d5
.asm_119508
	inc hl
	dec c
	jr nz, .asm_1194fb
.asm_11950c
	pop hl
	ld a, $1
	ld [wcd50], a
	ld a, l
	ld [wc608], a
	ld a, h
	ld [wc608 + 1], a
	ld de, wcd69
	ld c, $10
	ld b, $0
.asm_119521
	ld a, [de]
	inc de
	cp [hl]
	inc hl
	jr nz, .asm_119528
	inc b
.asm_119528
	dec c
	jr nz, .asm_119521
	ld a, $10
	cp b
	jr z, .asm_119536
rept 4
	inc hl
endr
	jr .asm_11957a
.asm_119536
	ld a, [hli]
	cp $50
	jr nz, .asm_119552
	ld a, [hli]
	cp $33
	jr nz, .asm_119553
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [wcd83]
	cp c
	jr nz, .asm_119576
	ld a, [wcd84]
	cp b
	jr nz, .asm_119576
	jr .asm_11955b
.asm_119552
	inc hl
.asm_119553
	inc hl
	inc hl
	jr .asm_11955b
.asm_119557
	ld de, $14
	add hl, de
.asm_11955b
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	add hl, de
	pop af
	dec a
	jp nz, Function119471
	ld a, [wcd50]
	and a
	jr z, .asm_119571
	ld a, $1a
	ld [wBattleTowerRoomMenuJumptableIndex], a
	ret
.asm_119571
	ld a, $d8
	jp SetMobileErrorCode
.asm_119576
	ld a, $10
	jr .asm_11957c
.asm_11957a
	ld a, $f
.asm_11957c
	ld [wBattleTowerRoomMenuJumptableIndex], a
	pop af
	call Function1195c4
	ret

Function119584:
	ld a, [wc608]
	ld b, a
	ld a, [wc608 + 3]
	ld c, a
	cp b
	jr c, .asm_11959c
	ld a, [wcd49]
	cp b
	jr c, .asm_1195c2
.asm_119595
	cp c
	jr c, .asm_1195a2
	jr z, .asm_1195a2
	jr .asm_1195c2
.asm_11959c
	ld a, [wcd49]
	cp b
	jr c, .asm_119595
.asm_1195a2
	ld a, [wc608 + 2]
	ld b, a
	ld a, [wc608 + 5]
	ld c, a
	cp b
	jr c, .asm_1195ba
	ld a, [wcd4b]
	cp b
	jr c, .asm_1195c2
.asm_1195b3
	cp c
	jr c, .asm_1195c0
	jr z, .asm_1195c0
	jr .asm_1195c2
.asm_1195ba
	ld a, [wcd4b]
	cp b
	jr c, .asm_1195b3
.asm_1195c0
	scf
	ret
.asm_1195c2
	and a
	ret

Function1195c4:
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld de, $a5
	ld a, b
	cp d
	jr c, .asm_1195d9
	jr z, .asm_1195d3
	jr nc, .asm_1195f3
.asm_1195d3
	ld a, c
	cp e
	jr z, .asm_1195d9
	jr nc, .asm_1195f3
.asm_1195d9
	ld de, wcc60
	call CopyBytes
	xor a
	ld [de], a
	ld a, [wc608]
	ld l, a
	ld a, [wc608 + 1]
	ld h, a
	ld de, wcd69
	ld bc, $10
	call CopyBytes
	ret
.asm_1195f3
	ld a, $d8
	jp SetMobileErrorCode

Function119694:
	ld b, 0
	ld hl, Unknown_1196b8
.asm_119699
	ld de, wc708
	ld a, [de]
	inc de
	cp [hl]
	inc hl
	jr nz, .asm_1196af
	ld a, [de]
	inc de
	cp [hl]
	inc hl
	jr nz, .asm_1196b0
	ld a, [de]
	inc de
	cp [hl]
	inc hl
	jr nz, .asm_1196b1
	ret
.asm_1196af
	inc hl
.asm_1196b0
	inc hl
.asm_1196b1
	inc b
	ld a, b
	cp $7
	jr nz, .asm_119699
	ret

pushc ascii

Unknown_1196b8:
	db "Mon"
	db "Tue"
	db "Wed"
	db "Thu"
	db "Fri"
	db "Sat"
	db "Sun"

popc

Function1196cd:
	ld de, wc719
	call Function1196de
	ld [wcd4a], a
	inc de
	call Function1196de
	ld [wcd4b], a
	ret

Function1196de:
	ld a, [de]
	inc de
	; b = ([de] - 48) * 2
	; c = ([de] - 48) * 10
	sub $30
	sla a
	ld b, a
	sla a
	sla a
	add b
	ld c, a
	add hl, bc
	ld a, [de]
	inc de
	sub $30
	add c
	ret

Function1196f2:
	ld hl, wd002
.asm_1196f5
	call Function118b9a
	ret nc
	ld a, [hli]
	cp $d
	jr nz, .asm_1196f5
	ld a, [hl]
	cp $a
	jr nz, .asm_1196f5
	xor a
	ld [hld], a
	ld [hli], a
	ld a, l
	ld [wcd5b], a
	ld a, h
	ld [wcd5c], a
	inc hl
	ld e, l
	ld d, h
	ld a, [de]
	inc de
	cp $d
	jr nz, .asm_119722
	ld a, [de]
	inc de
	cp $a
	jr nz, .asm_119722
	ld a, $b
	jp SetMobileErrorCode

.asm_119722
	call Random
	ld c, $0
	ld b, c
.asm_119728
	call Function119798
	ld a, d
	cp $ff
	jr nz, .asm_119735
	ld a, e
	cp $ff
	jr z, .asm_11974c

.asm_119735
	ldh a, [hRandomSub]
	cp d
	jr c, .asm_11974c
	jr z, .asm_11973e
	jr .asm_119745

.asm_11973e
	ldh a, [hRandomAdd]
	cp e
	jr c, .asm_11974c
	jr z, .asm_11974c

.asm_119745
	inc bc
	ld a, c
	or b
	jr z, .asm_119770
	jr .asm_119728

.asm_11974c
	ld a, [wcd5b]
	ld l, a
	ld a, [wcd5c]
	ld h, a
.asm_119754
	ld a, [hld]
	cp $58
	jr nz, .asm_119754
	ld d, $0
.asm_11975b
	inc d
	ld a, [hld]
	cp $58
	jr z, .asm_11975b
	inc hl
	inc hl
	ld a, d
	dec a
	jr z, .asm_11978e
	dec a
	jr z, .asm_119785
	dec a
	jr z, .asm_11977e
	dec a
	jr z, .asm_119775

.asm_119770
	ld a, $d3
	jp SetMobileErrorCode

.asm_119775
	ld a, b
	and $f0
	swap a
	call Function1197bf
	ld [hli], a

.asm_11977e
	ld a, b
	and $f
	call Function1197bf
	ld [hli], a

.asm_119785
	ld a, c
	and $f0
	swap a
	call Function1197bf
	ld [hli], a

.asm_11978e
	ld a, c
	and $f
	call Function1197bf
	ld [hli], a
	jp BattleTowerRoomMenu_IncrementJumptable

Function119798:
	ld d, $0
	ld e, d
	call Function1197b4
	swap a
	or d
	ld d, a
	call Function1197b4
	or d
	ld d, a
	call Function1197b4
	swap a
	or e
	ld e, a
	call Function1197b4
	or e
	ld e, a
	ret

Function1197b4:
	ld a, [hli]
	cp $61
	jr nc, .asm_1197bc
	sub $30
	ret

.asm_1197bc
	sub $57
	ret

Function1197bf:
	cp $a
	jr nc, .asm_1197c6
	add $30
	ret

.asm_1197c6
	add $57
	ret

Function119940:
	ld de, wEmailAddress
	ld c, MOBILE_EMAIL_LENGTH
.asm_119945
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr z, .asm_119953
	and a
	jr nz, .asm_119945
	xor a
.asm_11994f
	ld [hli], a
	dec c
	jr nz, .asm_11994f

.asm_119953
	ret

Function119973:
	ld a, $1
	ld [wcf64], a
	xor a
	ld [wcf65], a
	ld [w3_d090], a
	ld de, w3_d000
	ld a, MOBILEAPI_10
	jp Function119e2b

Function1199b4:
	ld a, [w3_d081 + 1]
	and a
	jr nz, .asm_1199c7
	ld a, [w3_d081]
	cp $7
	jr nc, .asm_1199c7
	call BattleTowerRoomMenu_IncrementJumptable
	jp Function1199ca

.asm_1199c7
	jp Function119ac9

Function1199ca:
	ld a, $20
	ld [wcd89], a
	ld a, [wcf64]
	ld l, a
	ld a, [wcf65]
	ld h, a
	ld de, w3_d100
	ld bc, $0700
	ld a, MOBILEAPI_14
	jp Function119e2b

Function1199e2:
	ld c, $c
	ld de, XGameCodePrefix
	call Function119e4f
	jp c, Function119ac9
	ld a, c
	cp $1
	jp nz, Function119ac9
	ld hl, w3_d880
	ld bc, XGameCode
.loop
	ld a, [bc]
	and a
	jr z, .game_result_prefix
	cp [hl]
	jp nz, Function119ac9
	inc bc
	inc hl
	jr .loop

.game_result_prefix
	ld c, $17
	ld de, XGameResultPrefix
	call Function119e4f
	jp c, .asm_119aa7
	ld a, c
	cp $1
	jp nz, .asm_119aa7
	ld a, [w3_d880]
	cp $31
	jp nz, .asm_119aa7
	ld a, [w3_d881]
	cp $20
	jp nz, .asm_119aa7
	ld a, [w3_d88a]
	cp $20
	jp nz, .asm_119aa7
	ld a, [w3_d894]
	cp $20
	jp nz, .asm_119aa7
	xor a
	ld [w3_d8a0], a
	ld [w3_d8a1], a
	ld [w3_d8a2], a
	ld [w3_d8a3], a
	ld hl, w3_d8a0
	ld bc, w3_d889
	call Function119e98
	call Function119e98
	ld hl, w3_d8a0
	ld a, [wcd2d]
	cp [hl]
	jr nz, Function119ac9
	inc hl
	ld a, [wcd2c]
	cp [hl]
	jr nz, Function119ac9
	inc hl
	ld a, [wcd2b]
	cp [hl]
	jr nz, Function119ac9
	inc hl
	ld a, [wcd2a]
	cp [hl]
	jr nz, Function119ac9
	xor a
	ld [w3_d8a0], a
	ld [w3_d8a1], a
	ld [w3_d8a2], a
	ld [w3_d8a3], a
	ld hl, w3_d8a0
	ld bc, w3_d88e
	call Function119e98
	ld bc, w3_d893
	call Function119e98
	ld hl, w3_d8a0
	ld a, [wcd2f]
	cp [hl]
	jr nz, .asm_119aa7
	inc hl
	ld a, [wcd2e]
	cp [hl]
	jr nz, .asm_119aa7
	inc hl
	ld a, [wcd31]
	cp [hl]
	jr nz, .asm_119aa7
	inc hl
	ld a, [wcd30]
	cp [hl]
	jr z, .asm_119aaf

.asm_119aa7
	ld a, $25
	ld [wBattleTowerRoomMenuJumptableIndex], a
	jp Function119b45

.asm_119aaf
	ld a, [w3_d090]
	and a
	jr nz, .asm_119aa7
	ld a, [w3_d895]
	sub $30
	ld [w3_d090], a
	ld a, [wcf64]
	ld [w3_d090 + 1], a
	ld a, [wcf65]
	ld [w3_d090 + 2], a

Function119ac9:
	ld a, [w3_d000]
	ld l, a
	ld a, [w3_d000 + 1]
	ld h, a
	dec hl
	ld a, l
	ld [w3_d000], a
	ld a, h
	ld [w3_d000 + 1], a
	ld a, [wcf64]
	ld l, a
	ld a, [wcf65]
	ld h, a
	inc hl
	ld a, l
	ld [wcf64], a
	ld a, h
	ld [wcf65], a
	ld a, $10
	ld [wBattleTowerRoomMenuJumptableIndex], a
	ret

pushc ascii

XGameCode:
	db "CGB-BXTJ-00", $0

popc

Function119b3b:
	ld a, [w3_d090 + 1]
	ld l, a
	ld a, [w3_d090 + 2]
	ld h, a
	jr asm_119b4d

Function119b45:
	ld a, [wcf64]
	ld l, a
	ld a, [wcf65]
	ld h, a

asm_119b4d:
	ld a, MOBILEAPI_13
	jp Function119e2b

Function119b52:
	ld a, [w3_d090]
	cp $1
	jr nz, .asm_119b66
	ld a, BANK(s5_a800)
	call OpenSRAM
	ld a, $4
	ld [s5_a800], a
	call CloseSRAM

.asm_119b66
	ld a, MOBILEAPI_0E
	jp Function119e2b

Function119b6b:
	ld a, [w3_d090]
	cp $1
	jr z, .asm_119b75
	jp BattleTowerRoomMenu_IncrementJumptable

.asm_119b75
	ld a, [w3_d100]
	ld b, a
	ld a, [w3_d100 + 1]
	or b
	jr z, .asm_119be3
	ld hl, w3_d800
	ld de, w3_d100 + 2
.asm_119b85
	ld a, [de]
	inc de
	cp $d
	jr nz, .asm_119b85
	inc de
	ld a, [de]
	cp $d
	jr nz, .asm_119b85
	inc de
	inc de
.asm_119b93
	ld a, [de]
	inc de
	cp $d
	jr z, .asm_119bfa
	call .decodeBase64Character
	ret c
	ld [hli], a
	ld a, [de]
	inc de
	call .decodeBase64Character
	ret c
	ld [hli], a
	ld a, [de]
	inc de
	call .decodeBase64Character
	ret c
	ld [hli], a
	ld a, [de]
	inc de
	call .decodeBase64Character
	ret c
	ld [hl], a
	push de
	ld d, [hl]
	dec hl
	ld c, [hl]
	dec hl
	ld b, [hl]
	dec hl
	ld a, [hl]
	sla b
	sla b
	sla b
	rla
	sla b
	rla
	ld [hli], a
	ld [hl], b
	inc hl
	rrc c
	rrc c
	ld [hl], c
	dec hl
	ld a, $f
	and c
	or [hl]
	ld [hli], a
	ld a, [hli]
	and $c0
	or [hl]
	dec hl
	ld [hld], a
	dec hl
	pop de
	inc hl
	inc hl
	inc hl
	ld a, h
	cp $e0
	jr c, .asm_119b93

.asm_119be3
	ld a, $19
	ld [wBattleTowerRoomMenuJumptableIndex], a
	ld a, BANK(s5_a800)
	call OpenSRAM
	ld a, $1
	ld [s5_a800], a
	call CloseSRAM
	xor a
	ld [w3_d090], a
	ret

.asm_119bfa
	inc de
	ld a, [de]
	cp $d
	jr nz, .asm_119b93
	ld a, l
	cp LOW(w3_d869)
	jr nz, .asm_119be3
	ld a, h
	cp HIGH(w3_d869)
	jr nz, .asm_119be3
	ld a, BANK(s5_b090) ; aka BANK(s5_b091) and BANK(s5_b023)
	call OpenSRAM
	ld a, [wcf64]
	ld [s5_b090], a
	ld a, [wcf65]
	ld [s5_b091], a
	ld hl, w3_d800
	ld de, s5_b023
	ld bc, 105
	call CopyBytes
	ld a, $3
	ld [s5_a800], a
	call CloseSRAM
	ld hl, w3_d800
	ld de, wc608
	ld bc, 105
	call CopyBytes
	jp BattleTowerRoomMenu_IncrementJumptable

pushc ascii

.decodeBase64Character
	cp "+"
	jr c, .asm_119c68
	jr z, .asm_119c80
	cp "/"
	jr c, .asm_119c68
	jr z, .asm_119c84
	cp "0"
	jr c, .asm_119c68
	cp "9" + 1
	jr c, .asm_119c88
	cp "="
	jr c, .asm_119c68
	jr z, .asm_119c8c
	cp "A"
	jr c, .asm_119c68
	cp "Z" + 1
	jr c, .asm_119c8f
	cp "a"
	jr c, .asm_119c68
	cp "z" + 1
	jr c, .asm_119c93

popc

.asm_119c68
	ld a, $19
	ld [wBattleTowerRoomMenuJumptableIndex], a
	ld a, BANK(s5_a800)
	call OpenSRAM
	ld a, $1
	ld [s5_a800], a
	call CloseSRAM
	xor a
	ld [w3_d090], a
	scf
	ret

.asm_119c80
	ld a, $3e
	and a
	ret

.asm_119c84
	ld a, $3f
	and a
	ret

.asm_119c88
	add $4
	and a
	ret

.asm_119c8c
	xor a
	and a
	ret

.asm_119c8f
	sub $41
	and a
	ret

.asm_119c93
	sub $47
	and a
	ret

BattleTowerRoomMenu_UberRestrictionMessage:
	ld hl, Text_UberRestriction
	call BattleTowerRoomMenu_SetMessage
	call BattleTowerRoomMenu_IncrementJumptable
	jr BattleTowerRoomMenu_WaitForMessage

BattleTowerRoomMenu_PartyMonTopsThisLevelMessage:
	ld hl, Text_PartyMonTopsThisLevel
	call BattleTowerRoomMenu_SetMessage
	call BattleTowerRoomMenu_IncrementJumptable

BattleTowerRoomMenu_WaitForMessage:
	ld a, [wc31a]
	and a
	ret nz
	ld a, $80
	ld [wcd50], a
	call BattleTowerRoomMenu_IncrementJumptable

BattleTowerRoomMenu_DelayRestartMenu:
	; Loops while (--[wcd50] != 0),
	;   to create some sort of "delay" after the message is written on the screen,
	;   before starting the menu again.
	ld hl, wcd50
	dec [hl]
	ret nz
	ld a, $0
	ld [wBattleTowerRoomMenuJumptableIndex], a
	ret

BattleTowerRoomMenu_QuitMessage:
	ld a, [wcd38]
	and a
	jr z, .asm_119cd1
	dec a
	jr z, .asm_119cd6
	ld hl, Text_QuitReadingNews
	jr .asm_119cd9

.asm_119cd1
	ld hl, Text_CancelBattleRoomChallenge
	jr .asm_119cd9

.asm_119cd6
	ld hl, Text_ExitGymLeaderHonorRoll

.asm_119cd9
	call BattleTowerRoomMenu_SetMessage
	call BattleTowerRoomMenu_IncrementJumptable

MenuHeader_119cf7:
	db MENU_BACKUP_TILES ; flags
	menu_coords 12, 7, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw NULL
	db 0 ; default option

String_119d07:
	db "   ▼@"

Strings_L10ToL100:
	db " L:10 @@"
	db " L:20 @@"
	db " L:30 @@"
	db " L:40 @@"
	db " L:50 @@"
	db " L:60 @@"
	db " L:70 @@"
	db " L:80 @@"
	db " L:90 @@"
	db " L:100@@"
	db "CANCEL@@"

Strings_Ll0ToL40:
	db " L:10 @@"
	db " L:20 @@"
	db " L:30 @@"
	db " L:40 @@"
	db "CANCEL@@"

BattleTower_LevelCheck:
	ldh a, [rWBK]
	push af
	ld a, BANK(wPartyMons)
	ldh [rWBK], a
	ld a, [wcd4f]
	ld c, 10
	call SimpleMultiply
	ld hl, wcd50
	ld [hl], a
	ld bc, PARTYMON_STRUCT_LENGTH
	ld de, wPartyMon1Level
	ld a, [wPartyCount]
.party_loop
	push af
	ld a, [de]
	push hl
	push de
	pop hl
	add hl, bc
	push hl
	pop de
	pop hl
	cp [hl]
	jr z, .equal
	jr nc, .exceeds
.equal
	pop af
	dec a
	jr nz, .party_loop
	pop af
	ldh [rWBK], a
	and a
	ret

.exceeds
	pop af
	ld a, $4
	ld [wBattleTowerRoomMenuJumptableIndex], a
	pop af
	ldh [rWBK], a
	scf
	ret

BattleTower_UbersCheck:
	ldh a, [rWBK]
	push af
	ld a, [wcd4f]
	cp 70 / 10
	jr nc, .level_70_or_more
	ld a, BANK(wPartyMons)
	ldh [rWBK], a
	ld hl, wPartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	ld de, wPartySpecies
	ld a, [wPartyCount]
.loop
	push af
	ld a, [de]
	cp MEWTWO
	jr z, .uber
	cp MEW
	jr z, .uber
	cp LUGIA
	jr c, .next
	cp NUM_POKEMON + 1
	jr nc, .next
.uber
	ld a, [hl]
	cp 70
	jr c, .uber_under_70
.next
	add hl, bc
	inc de
	pop af
	dec a
	jr nz, .loop
.level_70_or_more
	pop af
	ldh [rWBK], a
	and a
	ret

.uber_under_70
	pop af
	ld a, [de]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld hl, wStringBuffer1
	ld de, wcd49
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	ld a, $a
	ld [wBattleTowerRoomMenuJumptableIndex], a
	pop af
	ldh [rWBK], a
	scf
	ret

Function119e2b:
	call MobileAPI

BattleTowerRoomMenu_IncrementJumptable:
	ld hl, wBattleTowerRoomMenuJumptableIndex
	inc [hl]
	ret

pushc ascii

XGameCodePrefix:
	db "X-Game-code:\n"

XGameResultPrefix:
	db "X-Game-result:\n"

popc

Function119e4f:
	push bc
	ld hl, w3_d100
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
.loop
	ld a, [de]
	cp [hl]
	jr z, .found_equality
.next
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .loop
.return_carry
	pop bc
	scf
	ret

.found_equality
	push de
.loop2
	ld a, [de]
	inc de
pushc ascii
	cp "\n"
popc
	jr z, .newline
	cp [hl]
	jr nz, .unequal
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .loop2
	pop de
	jr .return_carry

.unequal
	pop de
	jr .next

.newline
	pop de
	pop bc
	inc hl
	ld de, w3_d880
.loop3
	ld a, [hli]
	ld [de], a
	inc de
pushc ascii
	cp "\r"
popc
	jr z, .finish
	dec c
	jr nz, .loop3
	scf
	ret

.finish
	and a
	ret

Function119e8e:
	cp $60
	jr c, .less_than_0x60
	sub $57
	ret

.less_than_0x60
	sub $30
	ret

Function119e98:
	ld a, $2
.loop
	push af
	ld a, [bc]
	dec bc
	call Function119e8e
	or [hl]
	ld [hl], a
	ld a, [bc]
	dec bc
	call Function119e8e
	rlca
	rlca
	rlca
	rlca
	or [hl]
	ld [hl], a
	inc hl
	pop af
	dec a
	and a
	jr nz, .loop
	ret

Function119eb4:
	xor a
	ld [wc3cc], a
	ld de, wc3ac
.loop
	ld a, [de]
	inc de
	ld [hli], a
	and a
	jr nz, .loop
	ret

Function119ec2:
	ld a, BANK(sMobileLoginPassword)
	call OpenSRAM
	xor a
	ld [sMobileLoginPassword + MOBILE_LOGIN_PASSWORD_LENGTH], a
	ld de, sMobileLoginPassword + 1
.loop
	ld a, [de]
	inc de
	ld [hli], a
	and a
	jr nz, .loop
	call CloseSRAM
	ret

Function11a113:
	call Function11a63c
	ld c, $1
	farcall Function115e18
	hlcoord 4, 2
	ld de, String_11a6c8
	call PlaceString
	and a
	ret

Function11a13d:
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a6d2
	call PlaceString
	and a
	ret

Function11a1d6:
	ld a, [wcd85]
	cp $50
	jr nz, .asm_11a1e4
	ld a, $d3
	call SetMobileErrorCode
	scf
	ret

.asm_11a1e4
	and a
	ret

Function11a1e6:
	ld hl, String_11a706
	ld de, wc346
	call Function11a1ff
	ld hl, wcd85
	call Function11a1ff
	ld hl, String_11a70b
	call Function11a1ff
	ld a, $50
	ld [de], a
	ret

Function11a1ff:
.asm_11a1ff
	ld a, [hli]
	cp $50
	ret z
	ld [de], a
	inc de
	jr .asm_11a1ff

String_11a2cf:
	db "YES@"

String_11a2d3:
	db "NO@"

MenuHeader_11a2de:
	db MENU_BACKUP_TILES ; flags
	menu_coords 14, 7, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw NULL
	db 0 ; default option

Function11a33a:
	ld a, [wMobileInactivityTimerMinutes]
	and a
	jr z, .asm_11a346
	dec a
	ld [wMobileInactivityTimerMinutes], a
	scf
	ret

.asm_11a346
	call ExitMenu
	farcall HDMATransferTilemapAndAttrmap_Overworld
	farcall Function115dc3
	and a
	ret

Function11a47a:
	ld a, [wMobileInactivityTimerMinutes]
	and a
	jr z, .asm_11a486
	dec a
	ld [wMobileInactivityTimerMinutes], a
	scf
	ret

.asm_11a486
	and a
	ret

Function11a4db:
	call Function11a63c
	ld de, String_11a6db
	hlcoord 4, 2
	call PlaceString
	ret

Function11a5b9:
	xor a
	ld [wMenuBorderLeftCoord], a
	ld [wMenuBorderTopCoord], a
	ld a, $13
	ld [wMenuBorderRightCoord], a
	ld a, $5
	ld [wMenuBorderBottomCoord], a
	call PushWindow
	hlcoord 0, 0, wAttrmap
	ld b, $6
	ld c, $14
	hlcoord 0, 0
	ld b, $4
	ld c, $12
	call Function3eea
	farcall HDMATransferTilemapAndAttrmap_Overworld
	call UpdateSprites
	ld c, $0
	farcall Function115e18
	ld a, $1
	ld [wc305], a
	ret

Function11a5f5:
	ld a, $e
	ld [wMenuBorderLeftCoord], a
	ld a, $13
	ld [wMenuBorderRightCoord], a
	ld a, $6
	ld [wMenuBorderTopCoord], a
	ld a, $a
	ld [wMenuBorderBottomCoord], a
	call PushWindow
	hlcoord 14, 6, wAttrmap
	ld b, $5
	ld c, $6
	hlcoord 14, 6
	ld b, $3
	ld c, $4
	call Function3eea
	hlcoord 16, 7
	ld de, String_11a2cf
	call PlaceString
	hlcoord 16, 9
	ld de, String_11a2d3
	call PlaceString
	hlcoord 15, 7
	ld a, $ed
	ld [hl], a
	farcall HDMATransferTilemapAndAttrmap_Overworld
	ret

Function11a63c:
	hlcoord 4, 1
	ld de, String_11a7f4
	call PlaceString
	hlcoord 4, 2
	ld de, String_11a7f4
	call PlaceString
	hlcoord 4, 3
	ld de, String_11a7f4
	call PlaceString
	hlcoord 4, 4
	ld de, String_11a7f4
	call PlaceString
	ret

String_11a661:
	db   "これから　モバイルセンターに"
	next "でんわ<WO>かけます@"

String_11a679:
	db   "モバイルアダプタ<NO>じゅんびは"
	next "できて　いますか？@"

String_11a692:
	db   "でんわ<WO>かけています"
	next "しばらく　おまちください@"

String_11a6aa:
	db   "でんわをかけると　つうわりょう"
	next "せつぞくりょう<GA>かかります@"

String_11a6c8:
	db   "せつぞく　しました@"

String_11a6d2:
	db   "つうしん　ちゅう@"

String_11a6db:
	db   "つうしん　ちゅう"
	next "セレクト　エーでちゅうし@"

String_11a6f1:
	db   "この　サービスには"
	next "つうわりょう<NO>ほかに@"

String_11a706:
	db   "おかね<GA>@"

String_11a70b:
	db   "えん"
	next "かかります　よろしい　ですか？@"

String_11a71e:
	db   "つうしん　しゅうりょう@"

String_11a72a:
	db   "つないだ　じかん"
	next "　　やく　　　ふん　　　びょう@"

String_11a743:
	db   "もっていない　データが"
	next "あります！@"

String_11a755:
	db   "データ<WO>よみこみますか？@"

String_11a762:
	db   "おなじ　データ<WO>よみこんだ"
	next "こと<GA>ありますが@"

String_11a779:
	db   "そのデータ<WA>なくなっているか"
	next "こわれて　います@"

String_11a791:
	db   "もっている　データと"
	next "おなじデータしか　ありません！@"

String_11a7ac:
	db   "データ<NO>よみこみを"
	next "ちゅうし　しますか？@"

String_11a7c1:
	db   "あたらしい　ニュースは"
	next "ありません　でした@"

String_11a7d7:
	db   "あたらしいニュース<GA>あります"
	next "ニュース<WO>よみこみますか？@"

String_11a7f4:
	db   "　　　　　　　　　　　　　　　@"

Function11a80c:
	ld de, hDivisor
	ld bc, hDividend
	ld hl, Unknown_11a89a
	call Function11a88c
	ld bc, hQuotient + 1
	ld hl, Unknown_11a8ba
	call Function11a88c
	ld bc, hPrintNumBuffer + 2
	ld hl, Unknown_11a8da
	call Function11a88c
	xor a
	ld b, a
	ldh a, [hDivisor]
	and $f
	ld e, a
	ldh a, [hPrintNumBuffer + 6]
	and $f
	call Function11a884
	ld e, a
	ldh a, [hPrintNumBuffer + 8]
	and $f
	call Function11a884
	ld [wcd62], a
	ld e, b
	xor a
	ld b, a
	ldh a, [hDivisor]
	and $f0
	swap a
	call Function11a884
	ld e, a
	ldh a, [hPrintNumBuffer + 6]
	and $f0
	swap a
	call Function11a884
	ld e, a
	ldh a, [hPrintNumBuffer + 8]
	and $f0
	swap a
	call Function11a884
	ld [wcd63], a
	ld e, b
	xor a
	ld b, a
	ldh a, [hMathBuffer]
	and $f
	call Function11a884
	ld e, a
	ldh a, [hPrintNumBuffer + 7]
	and $f
	call Function11a884
	ld e, a
	ldh a, [hPrintNumBuffer + 9]
	and $f
	call Function11a884
	ld [wcd64], a
	ret

Function11a884:
	add e
	cp $a
	ret c
	sub $a
	inc b
	ret

Function11a88c:
	ld a, [bc]
	sla a
	ld c, a
	xor a
	ld b, a
	add hl, bc
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	ret

Unknown_11a89a:
for x, 16
	bcd x % 100, x / 100
endr

Unknown_11a8ba:
for x, 0, 16**2, 16
	bcd x % 100, x / 100
endr

Unknown_11a8da:
for x, 0, 16**3, 16**2
	bcd x % 100, x / 100
endr

BattleTowerRoomMenu_WriteMessage:
	jumptable .Jumptable, wc31a

.Jumptable:
	dw BattleTowerRoomMenu_WriteMessage_DoNothing
	dw Function11a90f
	dw Function11a971

Function11a90f:
	ld a, $1
	ldh [rWBK], a
	call SpeechTextbox
	ld a, $50
	ld hl, wc320
	ld bc, $008c
	call ByteFill
	ld a, [wc31b]
	ld l, a
	ld a, [wc31c]
	ld h, a
	ld de, wc320
.asm_11a92c
	ld a, [hli]
	cp $57
	jr z, .asm_11a94f
	cp $0
	jr z, .asm_11a92c
	cp $50
	jr z, .asm_11a92c
	cp $1
	jr z, .asm_11a941
	ld [de], a
	inc de
	jr .asm_11a92c

.asm_11a941
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
.asm_11a945
	ld a, [bc]
	inc bc
	cp $50
	jr z, .asm_11a92c
	ld [de], a
	inc de
	jr .asm_11a945

.asm_11a94f
	xor a
	ld [wc31f], a
	ld a, LOW(wc320)
	ld [wc31b], a
	ld a, HIGH(wc320)
	ld [wc31c], a
	hlcoord 1, 14
	ld a, l
	ld [wc31d], a
	ld a, h
	ld [wc31e], a
	ld hl, wc31a
	inc [hl]
	ld a, $3
	ldh [rWBK], a

BattleTowerRoomMenu_WriteMessage_DoNothing:
	ret

Function11a971:
	ld hl, wc31f
	ldh a, [hJoyDown]
	and a
	jr nz, .asm_11a97f
	ld a, [hl]
	and a
	jr z, .asm_11a97f
	dec [hl]
	ret

.asm_11a97f
	ld a, [wOptions]
	and $7
	ld [hl], a
	ld hl, wcd8d
	ld a, [wc31b]
	ld e, a
	ld a, [wc31c]
	ld d, a
	ld a, [de]
	inc de
	ld [hli], a
	ld a, e
	ld [wc31b], a
	ld a, d
	ld [wc31c], a
	ld a, $50
	ld [hl], a
	ld a, [wc31d]
	ld l, a
	ld a, [wc31e]
	ld h, a
	ld de, wcd8d
	call PlaceString
	ld a, c
	ld [wc31d], a
	ld a, b
	ld [wc31e], a
	ld a, [wcd8d]
	cp $50
	jr nz, .asm_11a9bf
	xor a
	ld [wc31a], a

.asm_11a9bf
	ret

BattleTowerRoomMenu_SetMessage:
	ld a, l
	ld [wc31b], a
	ld a, h
	ld [wc31c], a
	ld a, $1
	ld [wc31a], a
	ret

Function11a9f0:
	ld a, $1
	and a
	ret

Text_SaveFileWillBeSent:
	text "SAVE FILE will be"
	line "sent."
	done

Text_SentSaveFileReadingNews:
	text "Sent SAVE FILE."
	line "Reading NEWS…"
	done

Text_ReadingNews:
	text "Reading NEWS…"
	done

Text_ReceivedNews:
	text "Received NEWS!"
	done

Text_QuitReadingNews:
	text "Quit reading NEWS?"
	done

Text_RegisteringRecord:
	text "Registering your"
	line "record…"
	done

Text_PartyMonTopsThisLevel:
	text "A party #MON"
	line "tops this level."
	done

Text_UberRestriction:
	text_ram wcd49
	text " may go"
	line "only to BATTLE"

	para "ROOMS that are"
	line "Lv.70 or higher."
	done

Text_CancelBattleRoomChallenge:
	text "Cancel your BATTLE"
	line "ROOM challenge?"
	done

Text_ExitGymLeaderHonorRoll:
	text "Exit GYM LEADER"
	line "HONOR ROLL?"
	done

Text_WhatLevelDoYouWantToChallenge:
	text "What level do you"
	line "want to challenge?"
	done

Text_CheckBattleRoomListByMaxLevel:
	text "Check BATTLE ROOM"
	line "list by max level?"
	done

Function11ad6e:
	ld a, [wJumptableIndex]
	ld hl, Jumptable_11ad78
	call Function11b239
	jp hl

Jumptable_11ad78:
	dw Function11b082
	dw Function11b0ff
	dw Function11ad95
	dw Function11adc4
	dw Function11ae4e
	dw Function11ae98
	dw Function11ad8f
	dw Function11af04
	dw Function11af4e

MobileIncJumptableIndex:
	ld hl, wJumptableIndex
	inc [hl]
	ret

Function11ad8f:
	ld hl, wJumptableIndex
	set JUMPTABLE_EXIT_F, [hl]
	ret

Function11ad95:
	ld hl, MenuHeader_11ae38
	call LoadMenuHeader
	call MenuBox
	hlcoord 12, 12
	ld de, String_11ae40
	call PlaceString
	hlcoord 10, 10, wAttrmap
	lb bc, 8, 8
	call Function11afd6
	farcall HDMATransferTilemapAndAttrmap_Overworld
	call MobileIncJumptableIndex
	ld a, $1
	ld [wMenuCursorY], a
	ld hl, Unknown_11afcc
	call Function11afb7

Function11adc4:
	ld hl, hJoyPressed
	ld a, [hl]
	and a
	ret z
	ld a, [hl]
	and PAD_UP
	jr nz, .asm_11ade6
	ld a, [hl]
	and PAD_DOWN
	jr nz, .asm_11aded
	ld a, [hl]
	and PAD_A
	jr nz, .asm_11ae06
	ld a, [hl]
	and PAD_B
	ret z
	call PlayClickSFX
	xor a
	ld [wJumptableIndex], a
	jr .asm_11ae2e

.asm_11ade6
	ld a, [wMenuCursorY]
	dec a
	ret z
	jr .asm_11adf4

.asm_11aded
	ld a, [wMenuCursorY]
	inc a
	cp $4
	ret z

.asm_11adf4
	push af
	ld hl, Unknown_11afcc
	call Function11afbb
	pop af
	ld [wMenuCursorY], a
	ld hl, Unknown_11afcc
	call Function11afb7
	ret

.asm_11ae06
	call PlayClickSFX
	ld a, [wMenuCursorY]
	dec a
	ld hl, wcd30
	ld [hl], a
	and a
	jr z, .asm_11ae28
	hlcoord 2, 14
	ld a, [wMenuCursorY]
	cp $2
	jr z, .asm_11ae23
	call Function11b272
	jr .asm_11ae2b

.asm_11ae23
	call Function11b267
	jr .asm_11ae2b

.asm_11ae28
	ld a, $3
	ld [hl], a

.asm_11ae2b
	call MobileIncJumptableIndex

.asm_11ae2e
	call ExitMenu
	farcall HDMATransferTilemapAndAttrmap_Overworld
	ret

MenuHeader_11ae38:
	db MENU_BACKUP_TILES ; flags
	menu_coords 10, 10, 17, SCREEN_HEIGHT - 1
	dw NULL
	db 0 ; default option

String_11ae40:
	db   "どちらでも"
	next "♂オス"
	next "♀メス"
	db   "@"

Function11ae4e:
	ld hl, MenuHeader_11afe8
	call LoadMenuHeader
	call MenuBox
	hlcoord 10, 14
	ld de, String_11aff0
	call PlaceString
	ld hl, MenuHeader_11b013
	call LoadMenuHeader
	call MenuBox
	hlcoord 16, 8
	ld de, String_11b01b
	call PlaceString
	hlcoord 14, 7, wAttrmap
	lb bc, 5, 6
	call Function11afd6
	hlcoord 9, 12, wAttrmap
	lb bc, 6, 11
	call Function11afd6
	farcall HDMATransferTilemapAndAttrmap_Overworld
	call MobileIncJumptableIndex
	ld a, $1
	ld [wMenuCursorY], a
	ld hl, Unknown_11afd2
	call Function11afb7

Function11ae98:
	ld hl, hJoyPressed
	ld a, [hl]
	and a
	ret z
	ld a, [hl]
	and PAD_UP
	jr nz, .asm_11aec1
	ld a, [hl]
	and PAD_DOWN
	jr nz, .asm_11aec8
	ld a, [hl]
	and PAD_A
	jr nz, .asm_11aee1
	ld a, [hl]
	and PAD_B
	ret z
	call PlayClickSFX
.asm_11aeb4
	hlcoord 2, 14
	ld a, $7f
	ld [hl], a
	ld a, $1
	ld [wJumptableIndex], a
	jr .asm_11aef7

.asm_11aec1
	ld a, [wMenuCursorY]
	dec a
	ret z
	jr .asm_11aecf

.asm_11aec8
	ld a, [wMenuCursorY]
	inc a
	cp $3
	ret z

.asm_11aecf
	push af
	ld hl, Unknown_11afd2
	call Function11afbb
	pop af
	ld [wMenuCursorY], a
	ld hl, Unknown_11afd2
	call Function11afb7
	ret

.asm_11aee1
	call PlayClickSFX
	ld a, [wMenuCursorY]
	cp $2
	jr z, .asm_11aeb4
	ld a, [wcd4b]
	ld [wScriptVar], a
	call Function11b022
	call MobileIncJumptableIndex

.asm_11aef7
	call ExitMenu
	call ExitMenu
	farcall HDMATransferTilemapAndAttrmap_Overworld
	ret

Function11af04:
	ld hl, MenuHeader_11afe8
	call LoadMenuHeader
	call MenuBox
	hlcoord 10, 14
	ld de, String_11b003
	call PlaceString
	ld hl, MenuHeader_11b013
	call LoadMenuHeader
	call MenuBox
	hlcoord 16, 8
	ld de, String_11b01b
	call PlaceString
	hlcoord 14, 7, wAttrmap
	lb bc, 5, 6
	call Function11afd6
	hlcoord 9, 12, wAttrmap
	lb bc, 6, 11
	call Function11afd6
	farcall HDMATransferTilemapAndAttrmap_Overworld
	call MobileIncJumptableIndex
	ld a, $2
	ld [wMenuCursorY], a
	ld hl, Unknown_11afd2
	call Function11afb7

Function11af4e:
	ld hl, hJoyPressed
	ld a, [hl]
	and a
	ret z
	ld a, [hl]
	and PAD_UP
	jr nz, .asm_11af77
	ld a, [hl]
	and PAD_DOWN
	jr nz, .asm_11af7e
	ld a, [hl]
	and PAD_A
	jr nz, .asm_11af97
	ld a, [hl]
	and PAD_B
	ret z
	call PlayClickSFX
.asm_11af6a
	hlcoord 2, 14
	ld a, $7f
	ld [hl], a
	ld a, $1
	ld [wJumptableIndex], a
	jr .asm_11afaa

.asm_11af77
	ld a, [wMenuCursorY]
	dec a
	ret z
	jr .asm_11af85

.asm_11af7e
	ld a, [wMenuCursorY]
	inc a
	cp $3
	ret z

.asm_11af85
	push af
	ld hl, Unknown_11afd2
	call Function11afbb
	pop af
	ld [wMenuCursorY], a
	ld hl, Unknown_11afd2
	call Function11afb7
	ret

.asm_11af97
	call PlayClickSFX
	ld a, [wMenuCursorY]
	cp $2
	jr z, .asm_11af6a
	ld a, $6
	ld [wJumptableIndex], a
	xor a
	ld [wScriptVar], a

.asm_11afaa
	call ExitMenu
	call ExitMenu
	farcall HDMATransferTilemapAndAttrmap_Overworld
	ret

Function11afb7:
	ld e, $ed
	jr asm_11afbd

Function11afbb:
	ld e, $7f

asm_11afbd:
	ld a, [wMenuCursorY]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, e
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld [de], a
	ret

Unknown_11afcc:
	dwcoord 11, 12
	dwcoord 11, 14
	dwcoord 11, 16

Unknown_11afd2:
	dwcoord 15,  8
	dwcoord 15, 10

Function11afd6:
	ld de, SCREEN_WIDTH
	ld a, $3
.row
	push bc
	push hl
.col
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	add hl, de
	pop bc
	dec b
	jr nz, .row
	ret

MenuHeader_11afe8:
	db MENU_BACKUP_TILES ; flags
	menu_coords 9, 12, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw NULL
	db 0 ; default option

String_11aff0:
	db   "この　じょうけんで"
	next "よろしいですか?@"

String_11b003:
	db   "こうかんを"
	next "ちゅうししますか？@"

MenuHeader_11b013:
	db MENU_BACKUP_TILES ; flags
	menu_coords 14, 7, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw NULL
	db 1 ; default option

String_11b01b:
	db   "はい"
	next "いいえ@"

Function11b022:
	ld a, [wcd2e]
	and a
	jr z, .asm_11b02e
	ld hl, wStringBuffer3
	call Function11b03d

.asm_11b02e
	ld a, [wcd30]
	and a
	ret z
	cp $3
	ret z
	ld hl, wStringBuffer4
	call Function11b03d
	ret

Function11b03d:
	push hl
	push af
	ld c, $1
.loop
	ld a, [hli]
	cp "♂"
	jr z, .gender
	cp "♀"
	jr z, .gender
	cp "@"
	jr z, .done
	inc c
	jr .loop

.gender
	dec hl
	ld a, "@"
	ld [hli], a

.done
	dec hl
	push hl
	ld e, 4
	ld d, 0
	add hl, de
	ld e, l
	ld d, h
	pop hl
.loop2
	ld a, [hld]
	ld [de], a
	dec de
	dec c
	jr nz, .loop2
	pop af
	pop de
	cp $1
	jr nz, .female
	ld hl, .MaleString
	jr .got_string

.female
	ld hl, .FemaleString

.got_string
	ld bc, 4 ; string length
	call CopyBytes
	ret

.MaleString: db "オスの　"
.FemaleString: db "メスの　"

Function11b082:
	call Function11b242
	ld a, $7
	ld [wc7d3], a
	call Function11b099
	call Function11b295
	call Function11b275
	call SetDefaultBGPAndOBP
	jp MobileIncJumptableIndex

Function11b099:
	ld c, $6
	hlcoord 11, 1
	ld a, [wc7d3]
	add a
	ld b, a
	xor a
	call Function11b236
	ld a, [wc7d0]
	ld e, a
	ld d, 0
	ld hl, wPokedexOrder
	add hl, de
	ld e, l
	ld d, h
	hlcoord 11, 2
	ld a, [wc7d3]
.loop
	push af
	ld a, [de]
	ld [wTempSpecies], a
	push de
	push hl
	call .PlaceMonNameOrPlaceholderString
	pop hl
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	pop de
	inc de
	pop af
	dec a
	jr nz, .loop
	ret

.PlaceMonNameOrPlaceholderString:
	and a
	ret z

	call .CheckSeenFlag
	ret c

	call .SetCaughtFlag
	push hl
	call GetPokemonName
	pop hl
	call PlaceString
	ret

.SetCaughtFlag:
	call CheckCaughtMemMon
	jr nz, .okay
	inc hl
	ret

.okay
	ld a, $1
	ld [hli], a
	ret

.CheckSeenFlag:
	call CheckSeenMemMon
	ret nz

	inc hl
	ld de, .EmptySlot
	call PlaceString
	scf
	ret

.EmptySlot:
	db "ーーーーー@"

Function11b0ff:
	ld hl, hJoyPressed
	ld a, [hl]
	and PAD_B
	jr nz, .asm_11b141
	ld a, [hl]
	and PAD_A
	jr nz, .asm_11b131
	call Function11b175
	jr nc, .asm_11b125
	ld a, [wcd4c]
	inc a
	and $3
	ld [wcd4c], a
	xor a
	ldh [hBGMapMode], a
	call Function11b099
	ld a, $1
	ldh [hBGMapMode], a
	ret

.asm_11b125
	ld a, [wcd4c]
	and a
	ret z
	inc a
	and $3
	ld [wcd4c], a
	ret

.asm_11b131
	call Function11b20b
	call CheckSeenMemMon
	jr z, .asm_11b13d
	ld a, $1
	jr .asm_11b148

.asm_11b13d
	ld a, $2
	jr .asm_11b148

.asm_11b141
	ld hl, wJumptableIndex
	ld a, $7
	ld [hl], a
	ret

.asm_11b148
	call PlayClickSFX
	ld [wcd4b], a
	and a
	jr z, .asm_11b16c
	ld a, [wcf65]
	cp $0
	jr z, .asm_11b163
	cp $fe
	jr z, .asm_11b167
	cp $ff
	jr z, .asm_11b16b
	jp MobileIncJumptableIndex

.asm_11b163
	ld a, $1
	jr .asm_11b16c

.asm_11b167
	ld a, $2
	jr .asm_11b16c

.asm_11b16b
	xor a

.asm_11b16c
	ld [wcd30], a
	ld a, $4
	ld [wJumptableIndex], a
	ret

Function11b175:
	ld a, [wc7d3]
	ld d, a
	ld a, [wc7d2]
	ld e, a
	ld hl, hJoyLast
	ld a, [hl]
	and PAD_UP
	jr nz, .asm_11b19a
	ld a, [hl]
	and PAD_DOWN
	jr nz, .asm_11b1ae
	ld a, d
	cp e
	jr nc, .asm_11b1ed
	ld a, [hl]
	and PAD_LEFT
	jr nz, .asm_11b1c6
	ld a, [hl]
	and PAD_RIGHT
	jr nz, .asm_11b1d8
	jr .asm_11b1ed

.asm_11b19a
	ld hl, wc7d1
	ld a, [hl]
	and a
	jr z, .asm_11b1a4
	dec [hl]
	jr .asm_11b1ef

.asm_11b1a4
	ld hl, wc7d0
	ld a, [hl]
	and a
	jr z, .asm_11b1ed
	dec [hl]
	jr .asm_11b1ef

.asm_11b1ae
	ld hl, wc7d1
	ld a, [hl]
	inc a
	cp e
	jr nc, .asm_11b1ed
	cp d
	jr nc, .asm_11b1bc
	inc [hl]
	jr .asm_11b1ef

.asm_11b1bc
	ld hl, wc7d0
	add [hl]
	cp e
	jr nc, .asm_11b1ed
	inc [hl]
	jr .asm_11b1ef

.asm_11b1c6
	ld hl, wc7d0
	ld a, [hl]
	and a
	jr z, .asm_11b1ed
	cp d
	jr nc, .asm_11b1d4
	xor a
	ld [hl], a
	jr .asm_11b1ef

.asm_11b1d4
	sub d
	ld [hl], a
	jr .asm_11b1ef

.asm_11b1d8
	ld hl, wc7d0
	ld a, d
	add a
	add [hl]
	jr c, .asm_11b1e3
	cp e
	jr c, .asm_11b1e8

.asm_11b1e3
	ld a, e
	sub d
	ld [hl], a
	jr .asm_11b1ef

.asm_11b1e8
	ld a, [hl]
	add d
	ld [hl], a
	jr .asm_11b1ef

.asm_11b1ed
	and a
	ret

.asm_11b1ef
	call Function11b295
	call Function11b275
	scf
	ret

FillScreenWithTile32: ; could be useful
	hlcoord 0, 0
	ld a, $32
	ld bc, SCREEN_AREA
	call ByteFill
	ret

CopyDataUntilFF: ; could be useful
.loop
	ld a, [de]
	cp $ff
	ret z
	inc de
	ld [hli], a
	jr .loop

Function11b20b:
	ld a, [wc7d1]
	ld hl, wc7d0
	add [hl]
	ld e, a
	ld d, 0
	ld hl, wc6d0
	add hl, de
	ld a, [hl]
	ld [wTempSpecies], a
	ret

CheckCaughtMemMon:
	push de
	push hl
	ld a, [wTempSpecies]
	dec a
	call CheckCaughtMon
	pop hl
	pop de
	ret

CheckSeenMemMon:
	push de
	push hl
	ld a, [wTempSpecies]
	dec a
	call CheckSeenMon
	pop hl
	pop de
	ret

Function11b236:
	jp FillBoxWithByte

Function11b239:
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

Function11b242:
	hlcoord 3, 4
	ld de, wStringBuffer3
	call PlaceString
	xor a
	ld [wMonType], a
	farcall GetGender
	hlcoord 1, 4
	ld a, [wCurPartySpecies]
	ld bc, wcd2f
	ld [bc], a
	dec bc
	jr c, asm_11b26a
	jr z, asm_11b26f
	ld a, $1
	ld [bc], a

Function11b267:
	ld [hl], $ef
	ret

asm_11b26a:
	xor a
	ld [bc], a
	ld [hl], $7f
	ret

asm_11b26f:
	ld a, $2
	ld [bc], a

Function11b272:
	ld [hl], $f5
	ret

Function11b275:
	call Function11b279
	ret

Function11b279:
	ld a, [wTempSpecies]
	ld [wCurSpecies], a
	call CheckSeenMemMon
	jr z, .asm_11b28f
	call GetBaseData
	ld a, [wBaseGender]
	ld [wcf65], a
	jr .asm_11b294

.asm_11b28f
	ld a, $ff
	ld [wcf65], a

.asm_11b294
	ret

Function11b295:
	hlcoord 4, 13
	ld de, String_11b308
	call PlaceString
	hlcoord 4, 14
	ld de, String_11b308
	call PlaceString
	call Function11b20b
	call CheckSeenMemMon
	jr z, .asm_11b2d1
	ld a, [wc608]
	ld c, a
	ld a, [wc608 + 1]
	ld b, a
	ld hl, $0007
	add hl, bc
	xor a
	ld [hl], a
	ld hl, $0003
	add hl, bc
	ld e, [hl]
	farcall FlyFunction_GetMonIcon
	hlcoord 4, 14
	push hl
	call GetPokemonName
	jr .asm_11b2e7

.asm_11b2d1
	ld a, [wc608]
	ld c, a
	ld a, [wc608 + 1]
	ld b, a
	ld hl, $0007
	add hl, bc
	ld a, $50
	ld [hl], a
	hlcoord 4, 13
	push hl
	ld de, String_11b30e

.asm_11b2e7
	ld a, NAME_LENGTH_JAPANESE
	ld bc, wStringBuffer4
.asm_11b2ec
	push af
	ld a, [de]
	ld [bc], a
	inc de
	inc bc
	pop af
	dec a
	and a
	jr nz, .asm_11b2ec
	pop hl
	ld de, wStringBuffer4
	call PlaceString
	ret

String_11b308:
	db "　　　　　@"

String_11b30e:
	db "みはっけん@"

Function11b314:
	call Function11b31b
	call Function11b3d9
	ret

Function11b31b:
	ld hl, .Coords
	ld a, [wJumptableIndex]
	cp 2
	jr c, .tilemap_1
	ld a, [wc7d1]
	cp 4
	jr nc, .tilemap_3
	cp 3
	jr c, .tilemap_1
	ld a, [wJumptableIndex]
	cp 2
	jr z, .tilemap_1
	cp 3
	jr z, .tilemap_1
	cp 6
	jr z, .tilemap_1

	ld bc, .Tilemap2
	jr .load_sprites

.tilemap_3
	ld bc, .Tilemap3
	jr .load_sprites

.tilemap_1
	ld bc, .Tilemap1

.load_sprites
	call Function11b397
	ret

.Coords:
	dbpixel 3, 11, 2, 6 ;  0
	dbpixel 3, 12, 2, 6 ;  1
	dbpixel 3, 13, 2, 6 ;  2
	dbpixel 3, 14, 2, 6 ;  3
	dbpixel 3, 15, 2, 6 ;  4
	dbpixel 3, 16, 2, 6 ;  5
	dbpixel 3, 17, 2, 6 ;  6
	dbpixel 4, 11, 2, 6 ;  7
	dbpixel 4, 12, 2, 6 ;  8
	dbpixel 4, 13, 2, 6 ;  9
	dbpixel 4, 14, 2, 6 ; 10
	dbpixel 4, 15, 2, 6 ; 11
	dbpixel 4, 16, 2, 6 ; 12
	dbpixel 4, 17, 2, 6 ; 13
	db -1

.Tilemap1: ; vtiles
	db $30 ;  0
	db $31 ;  1
	db $31 ;  2
	db $31 ;  3
	db $31 ;  4
	db $31 ;  5
	db $32 ;  6
	db $40 ;  7
	db $41 ;  8
	db $41 ;  9
	db $41 ; 10
	db $41 ; 11
	db $41 ; 12
	db $42 ; 13

.Tilemap2: ; vtiles
	db $30 ;  0
	db $31 ;  1
	db $31 ;  2
	db $39 ;  3
	db $39 ;  4
	db $39 ;  5
	db $39 ;  6
	db $40 ;  7
	db $41 ;  8
	db $41 ;  9
	db $39 ; 10
	db $39 ; 11
	db $39 ; 12
	db $39 ; 13

.Tilemap3: ; vtiles
	db $39 ;  0
	db $39 ;  1
	db $39 ;  2
	db $39 ;  3
	db $39 ;  4
	db $39 ;  5
	db $39 ;  6
	db $39 ;  7
	db $39 ;  8
	db $39 ;  9
	db $39 ; 10
	db $39 ; 11
	db $39 ; 12
	db $39 ; 13

Function11b397:
	ld de, wShadowOAMSprite00
.loop
	ld a, [hl]
	cp $ff
	ret z
	ld a, [wc7d1]
	and $7
	swap a
	add [hl]
	inc hl
	ld [de], a ; y
	inc de

	ld a, [hli]
	ld [de], a ; x
	inc de

	ld a, [bc]
	inc bc
	ld [de], a ; tile id
	inc de
	ld a, $5
	ld [de], a ; attributes
	inc de
	jr .loop

Function11b3d9:
	ld de, wShadowOAMSprite28
	push de
	ld a, [wc7d2]
	dec a
	ld e, a
	ld a, [wc7d1]
	ld hl, wc7d0
	add [hl]
	cp e
	jr z, .skip
	ld hl, 0
	ld bc, $70
	call AddNTimes
	ld e, l
	ld d, h
	ld b, 0
	ld a, d
	or e
	jr z, .load_sprites
	ld a, [wc7d2]
	ld c, a
.loop1
	ld a, e
	sub c
	ld e, a
	ld a, d
	sbc $0
	ld d, a
	jr c, .load_sprites
	inc b
	jr .loop1

.skip
	ld b, 14 * TILE_WIDTH

.load_sprites
	ld a, 2 * TILE_WIDTH + 5
	add b
	pop hl
	ld [hli], a
	cp $41
	jr c, .version1
	ld a, [wJumptableIndex]
	cp 4
	jr z, .version2
	cp 5
	jr z, .version2
	cp 7
	jr z, .version2
	cp 8
	jr z, .version2

.version1
	ld a, 19 * TILE_WIDTH + 3
	ld [hli], a
	ld a, [wcd4c]
	add $3c
	ld [hli], a
	ld a, [wcd4c]
	add $1
	ld [hl], a
	ret

.version2
	ld a, 19 * TILE_WIDTH + 3
	ld [hli], a
	ld a, $39
	ld [hli], a
	xor a
	ld [hl], a
	ret

TradeCornerHoldMon_RemoveFromParty:
	ld a, [wcd82]
	dec a
	ld [wCurPartyMon], a
	xor a ; REMOVE_PARTY
	ld [wPokemonWithdrawDepositParameter], a
	farcall RemoveMonFromPartyOrBox
	farcall BattleTowerAction_16
	farcall SaveAfterLinkTrade
	jp MobileIncJumptableIndex

TradeCornerHoldMon_Success:
	xor a
	ld [wScriptVar], a
	jp MobileIncJumptableIndex

TradeCornerHoldMon_Noop:
	ret

Function11b6b3:
	ret

Function11b6b4:
	ld a, $5
	call OpenSRAM
	ld a, [wcd30]
	ld [wc708], a
	ld a, [wcd31]
	ld [wc709], a

	ld a, LOW(wc708)
	ld [wMobileMonSpeciesPointer], a
	ld a, HIGH(wc708)
	ld [wMobileMonSpeciesPointer + 1], a

	ld a, LOW(wMobileMon)
	ld [wMobileMonStructPointer], a
	ld a, HIGH(wMobileMon)
	ld [wMobileMonStructPointer + 1], a

	ld a, LOW(wMobileMonOT)
	ld [wMobileMonOTPointer], a
	ld a, HIGH(wMobileMonOT)
	ld [wMobileMonOTPointer + 1], a

	ld a, LOW(wMobileMonNick)
	ld [wMobileMonNicknamePointer], a
	ld a, HIGH(wMobileMonNick)
	ld [wMobileMonNicknamePointer + 1], a

	ld a, LOW(wMobileMonMail)
	ld [wMobileMonMailPointer], a
	ld a, HIGH(wMobileMonMail)
	ld [wMobileMonMailPointer + 1], a

	ld a, BASE_HAPPINESS
	ld [wMobileMonHappiness], a

	ld de, wMobileMonOT
	ld c, NAME_LENGTH_JAPANESE - 1
	farcall CheckStringForErrors
	jr nc, .length_check_OT
	farcall Mobile_CopyDefaultOTName

.length_check_OT
	ld de, wMobileMonOT
	lb bc, 1, NAME_LENGTH_JAPANESE - 1
	farcall CheckStringContainsLessThanBNextCharacters
	jr nc, .error_check_nick
	farcall Mobile_CopyDefaultOTName

.error_check_nick
	ld de, wMobileMonNick
	ld c, NAME_LENGTH_JAPANESE - 1
	farcall CheckStringForErrors
	jr nc, .length_check_nick
	farcall Mobile_CopyDefaultNickname

.length_check_nick
	ld de, wMobileMonNick
	lb bc, 1, NAME_LENGTH_JAPANESE - 1
	farcall CheckStringContainsLessThanBNextCharacters
	jr nc, .error_check_mail
	farcall Mobile_CopyDefaultNickname

.error_check_mail
	ld de, wMobileMonMail
	ld c, MAIL_MSG_LENGTH + 1
	farcall CheckStringForErrors
	jr nc, .length_check_mail
	farcall Mobile_CopyDefaultMail

.length_check_mail
	ld de, wMobileMonMail
	lb bc, 2, MAIL_MSG_LENGTH + 1
	farcall CheckStringContainsLessThanBNextCharacters
	jr c, .fix_mail
	ld a, b
	cp $2
	jr nz, .mail_ok

.fix_mail
	farcall Mobile_CopyDefaultMail

.mail_ok
	ld de, wMobileMonMailAuthor
	ld c, NAME_LENGTH_JAPANESE - 1
	farcall CheckStringForErrors
	jr nc, .length_check_author
	farcall Mobile_CopyDefaultMailAuthor

.length_check_author
	ld de, wMobileMonMailAuthor
	lb bc, 1, NAME_LENGTH_JAPANESE - 1
	farcall CheckStringContainsLessThanBNextCharacters
	jr nc, .author_okay
	farcall Mobile_CopyDefaultMailAuthor

.author_okay
	ld a, [wMobileMonItem]
	cp -1
	jr nz, .item_okay
	xor a
	ld [wMobileMonItem], a

.item_okay
	ld a, [wcd31]
	ld [wMobileMonSpecies], a
	ld [wCurSpecies], a
	call GetBaseData

	ld hl, wMobileMonLevel
	ld a, [hl]
	cp MIN_LEVEL
	ld a, MIN_LEVEL
	jr c, .replace_level
	ld a, [hl]
	cp MAX_LEVEL
	jr c, .done_level
	ld a, MAX_LEVEL
.replace_level
	ld [hl], a
.done_level
	ld [wCurPartyLevel], a

	ld hl, wMobileMonExp + 2
	ld de, wMobileMonMaxHP
	ld b, TRUE
	predef CalcMonStats
	ld de, wMobileMonMaxHP
	ld hl, wMobileMonHP
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hl], a
	call AddMobileMonToParty
	ret

AddMobileMonToParty:
	ld hl, wPartyCount
	ld a, [hl]
	ld e, a
	inc [hl]

	ld a, [wMobileMonSpeciesPointer]
	ld l, a
	ld a, [wMobileMonSpeciesPointer + 1]
	ld h, a
	inc hl
	ld bc, wPartySpecies
	ld d, e
.loop1
	inc bc
	dec d
	jr nz, .loop1
	ld a, e
	ld [wCurPartyMon], a
	ld a, [hl]
	ld [bc], a
	inc bc
	ld a, -1
	ld [bc], a

	ld hl, wPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, e
	ld [wMobileMonIndex], a
.loop2
	add hl, bc
	dec a
	and a
	jr nz, .loop2
	ld e, l
	ld d, h
	ld a, [wMobileMonStructPointer]
	ld l, a
	ld a, [wMobileMonStructPointer + 1]
	ld h, a
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes

	ld hl, wPartyMonOTs
	ld bc, NAME_LENGTH
	ld a, [wMobileMonIndex]
.loop3
	add hl, bc
	dec a
	and a
	jr nz, .loop3
	ld e, l
	ld d, h
	ld a, [wMobileMonOTPointer]
	ld l, a
	ld a, [wMobileMonOTPointer + 1]
	ld h, a
	ld bc, MON_NAME_LENGTH - 1
	call CopyBytes
	ld a, "@"
	ld [de], a

	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	ld a, [wMobileMonIndex]
.loop4
	add hl, bc
	dec a
	and a
	jr nz, .loop4
	ld e, l
	ld d, h
	ld a, [wMobileMonNicknamePointer]
	ld l, a
	ld a, [wMobileMonNicknamePointer + 1]
	ld h, a
	ld bc, MON_NAME_LENGTH - 1
	call CopyBytes
	ld a, "@"
	ld [de], a

	ld hl, sPartyMail
	ld bc, MAIL_STRUCT_LENGTH
	ld a, [wMobileMonIndex]
.loop5
	add hl, bc
	dec a
	and a
	jr nz, .loop5
	ld a, BANK(sPartyMail)
	call OpenSRAM
	ld e, l
	ld d, h
	ld a, [wMobileMonMailPointer]
	ld l, a
	ld a, [wMobileMonMailPointer + 1]
	ld h, a
	ld bc, MAIL_STRUCT_LENGTH
	call CopyBytes

	call CloseSRAM
	ret
