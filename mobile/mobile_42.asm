Function108201:
	push de
	push af
	predef GetUnownLetter
	pop af
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	call GetBaseData
	pop de
	predef GetAnimatedFrontpic
	ret

Function108229:
	ld [wCurPartySpecies], a
	hlcoord 7, 2
	ld d, $0
	ld e, ANIM_MON_TRADE
	predef LoadMonAnimation
	ret

WaitMobileTradeSpriteAnims:
.loop
	push bc
	farcall PlaySpriteAnimations
	pop bc
	call DelayFrame
	dec c
	jr nz, .loop
	ret

Function1082db:
.loop
	farcall PlaySpriteAnimations
	farcall SetUpPokeAnim
	farcall HDMATransferTilemapToWRAMBank3
	jr nc, .loop
	ret

Function1082f0:
.loop
	call Function108b78
	call DelayFrame
	dec c
	jr nz, .loop
	ret

Function1082fa:
.loop
	call Function108b78
	push hl
	push bc
	farcall PlaySpriteAnimations
	pop bc
	pop hl
	call DelayFrame
	dec c
	jr nz, .loop
	ret

Function108ad4:
	and a
	jr z, .asm_108adc
	ld de, MobileCable2GFX
	jr .asm_108adf

.asm_108adc
	ld de, MobileCable1GFX
.asm_108adf
	ld a, $1
	ldh [rVBK], a
	ld hl, vTiles2 tile $4a
	lb bc, BANK(MobileCable1GFX), 16 ; aka BANK(MobileCable2GFX)
	call Get2bppViaHDMA
	call DelayFrame
	ld a, $0
	ldh [rVBK], a
	ret

Function108af4:
	ldh a, [rWBK]
	push af
	ld a, $5
	ldh [rWBK], a
	ld a, [wcf65]
	and $1
	jr z, .copy_MobileTradeOB1Palettes
	ld hl, MobileTradeOB2Palettes
	ld de, wOBPals1
	ld bc, 8 palettes
	call CopyBytes
	ld hl, MobileTradeOB2Palettes
	ld de, wOBPals2
	ld bc, 8 palettes
	call CopyBytes
	jr .done_copy

.copy_MobileTradeOB1Palettes
	ld hl, MobileTradeOB1Palettes
	ld de, wOBPals1
	ld bc, 8 palettes
	call CopyBytes
	ld hl, MobileTradeOB1Palettes
	ld de, wOBPals2
	ld bc, 8 palettes
	call CopyBytes

.done_copy
	pop af
	ldh [rWBK], a
	ld a, %11100100 ; 3,2,1,0
	call DmgToCgbObjPal0
	ld a, %11100100 ; 3,2,1,0
	call DmgToCgbBGPals
	call DelayFrame
	ret

Function108b45:
	ldh a, [rWBK]
	push af
	ld a, $5
	ldh [rWBK], a
	ld de, PALRGB_WHITE
	ld hl, wBGPals1
	ld a, e
	ld [hli], a
	ld d, a
	ld [hli], a
	pop af
	ldh [rWBK], a
	ret

Function108b5a:
	ldh a, [rWBK]
	push af
	ld a, $5
	ldh [rWBK], a
	ld de, palred 18 + palgreen 31 + palblue 15
	ld hl, wBGPals2 palette 4
	ld c, 2 palettes
.loop
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	dec c
	jr nz, .loop
	pop af
	ldh [rWBK], a
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	ret

Function108b78:
	ldh a, [rWBK]
	push af
	ld a, $5
	ldh [rWBK], a
	ld a, c
	and $2
	jr z, .Orange
	ld de, PALRGB_WHITE
	jr .load_pal

.Orange:
	ld de, palred 31 + palgreen 15 + palblue 1
.load_pal
	ld a, e
	ld [hli], a
	ld a, d
	ld [hld], a
	pop af
	ldh [rWBK], a
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	ret

Palette_108b98:
; removed

Function108b98:
	ld d, a
	ldh a, [rWBK]
	push af
	ld a, $5
	ldh [rWBK], a
	ld a, [wcf65]
	and $1
	xor d
	jr z, .asm_108bad
	ld hl, Palette_108b98 palette 1
	jr .asm_108bb0

.asm_108bad
	ld hl, Palette_108b98
.asm_108bb0
	ld de, wBGPals1 palette 7
	ld bc, 8 palettes
	call CopyBytes
	pop af
	ldh [rWBK], a
	ret

Function108bec:
	ld a, $90
	ldh [hWY], a
	ld hl, .MobilePlayerWillTradeMonText
	call PrintText
	ld c, 80
	call DelayFrames
	ld hl, .MobileForPartnersMonText
	call PrintText
	ld c, 80
	call DelayFrames
	ret

.MobilePlayerWillTradeMonText:
	text_far _MobilePlayerWillTradeMonText
	text_end

.MobileForPartnersMonText:
	text_far _MobileForPartnersMonText
	text_end

Function108c16:
	ld a, $90
	ldh [hWY], a
	ld hl, .MobileTakeGoodCareOfMonText
	call PrintText
	ld c, 80
	call DelayFrames
	ret

.MobileTakeGoodCareOfMonText:
	text_far _MobileTakeGoodCareOfMonText
	text_end

Function108c2b:
	ld a, $90
	ldh [hWY], a
	ld hl, .MobilePlayersMonTrade2Text
	call PrintText
	ld c, 80
	call DelayFrames
	ret

.MobilePlayersMonTrade2Text:
	text_far _MobilePlayersMonTrade2Text
	text_end

Function108c40:
	ld a, $90
	ldh [hWY], a
	ld a, [wcf65]
	and %10000000
	jr z, .Getmon
	ld hl, .MobileTradeCameBackText
	call PrintText
	ld c, 80
	call DelayFrames
	ret

.Getmon:
	ld hl, .MobileTakeGoodCareOfText
	call PrintText
	ld c, 80
	call DelayFrames
	ret

.MobileTakeGoodCareOfText:
	text_far _MobileTakeGoodCareOfText
	text_end

.MobileTradeCameBackText:
	text_far _MobileTradeCameBackText
	text_end

Function108c6d:
	ld hl, MobileTradeTilemapLZ
	debgcoord 0, 0
	call Decompress
	ld hl, MobileTradeTilemapLZ
	debgcoord 0, 0, vBGMap1
	call Decompress
	ret

Function108c80:
	ld a, $1
	ldh [rVBK], a
	ld hl, MobileTradeAttrmapLZ
	debgcoord 0, 0
	call Decompress
	ld hl, MobileTradeAttrmapLZ
	debgcoord 0, 0, vBGMap1
	call Decompress
	ld a, $0
	ldh [rVBK], a
	ret

LoadMobileAdapterPalette:
	ld a, [wc74e]
	and $7f
	cp $8 ; CONST: Amount of mobile adapters
	jr c, .asm_108d12
	ld a, $7

.asm_108d12
	ld bc, 1 palettes
	ld hl, MobileAdapterPalettes
	call AddNTimes
	ld a, BANK(wBGPals1)
	ld de, wBGPals1 palette 4
	ld bc, 1 palettes
	call FarCopyWRAM
	ret

MobileTradeSpritesGFX:
MobileTradeGFX:
MobileTradeTilemapLZ:
MobileTradeAttrmapLZ:
MobileTradeBGPalettes:
MobileTradeOB1Palettes:
MobileTradeOB2Palettes:
MobileCable1GFX:
MobileCable2GFX:
MobileAdapterPalettes:
