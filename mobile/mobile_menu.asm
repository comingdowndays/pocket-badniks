MobileString1:
	db   "めいしフォルダー"
	next "あいさつ"
	next "プロフィール"
	next "せ<TTE>い"
	next "もどる"
	db   "@"

MobileStrings2:
; string 0
String_0x49fe9:
	db   "めいし<WO>つくったり"
	next "ほぞんしておける　フォルダーです@"
; string 1
	db   "モバイルたいせんや　じぶんのめいしで"
	next "つかう　あいさつ<WO>つくります@"
; string 2
	db   "あなた<NO>じゅうしょや　ねんれいの"
	next "せ<TTE>い<WO>かえられます@"
; string 3
	db  "モバイルセンター<NI>せつぞくするとき"
	next "ひつような　こと<WO>きめます@"
; string 4
	db   "まえ<NO>がめん　<NI>もどります"
	next "@"

MobileMenu_InitMenuBuffers:
	ld hl, w2DMenuCursorInitY
	ld a, 2
	ld [hli], a
	ld a, 5 ; w2DMenuCursorInitX
	ld [hli], a
	ld a, 5 ; w2DMenuNumRows
	ld [hli], a
	ld a, 1 ; w2DMenuNumCols
	ld [hli], a
	ld [hl], $0 ; w2DMenuFlags1
	set 5, [hl]
	inc hl
	xor a ; w2DMenuFlags2
	ld [hli], a
	ld a, $20 ; w2DMenuCursorOffsets
	ld [hli], a
	; could have done "ld a, PAD_A | PAD_UP | PAD_DOWN | PAD_B" instead
	ld a, PAD_A
	add PAD_UP
	add PAD_DOWN
	add PAD_B
	ld [hli], a ; wMenuJoypadFilter
	ld a, 1
	ld [hli], a ; wMenuCursorY, wMenuCursorX
	ld [hli], a ; wMenuCursorY, wMenuCursorX
	ret

Function4a100:
	ld a, 2
	call MenuClickSound
	call ClearBGPalettes
	call Function4a13b
	call ClearBGPalettes
	call ClearTilemap

Function4a118:
	ld hl, w2DMenuCursorInitY
	ld a, $1
	ld [hli], a
	ld a, $d
	ld [hli], a
	ld a, $3
	ld [hli], a
	ld a, $1
	ld [hli], a
	ld [hl], $0
	set 5, [hl]
	inc hl
	xor a
	ld [hli], a
	ld a, $20
	ld [hli], a
	ld a, $1
	add $2
	ld [hli], a
	ld a, $1
	ld [hli], a
	ld [hli], a
	ret

Function4a13b:
	call Function4a3a7
	call Function4a492
	call Function4a373
	ld c, 10
	call DelayFrames

Function4a195:
	call ScrollingMenuJoypad
	ld hl, wMenuCursorY
	ld b, [hl]
	push bc

String_4a1ef:
	db   "モバイルセンター<WO>えらぶ"
	next "ログインパスワード<WO>いれる"
	next "もどる@"

Function4a239:
	pop bc
	jp Function4a13b

Strings_4a23d:
	db   "いつも　せつぞく<WO>する"
	next "モバイルセンター<WO>えらびます@"

	db   "モバイルセンター<NI>せつぞくするとき"
	next "つかうパスワード<WO>ほぞんできます@"

	db   "まえ<NO>がめん　<NI>もどります@"

	db   "@"

String_4a34b:
	db   "いれなおす"
	next "けす"
	next "もどる@"

DeleteSavedLoginPasswordText:
	text_far _DeleteSavedLoginPasswordText
	text_end

DeletedTheLoginPasswordText:
	text_far _DeletedTheLoginPasswordText
	text_end

DeletePassword_YesNo_MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 14, 7, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw MenuData_0x4a36a
	db 2 ; default option

MenuData_0x4a36a:
	db STATICMENU_CURSOR | STATICMENU_NO_TOP_SPACING | STATICMENU_WRAP ; flags
	db 2 ; items
	db "はい@"
	db "いいえ@"

Function4a373:
	ld hl, w2DMenuCursorInitY
	ld a, $4
	ld [hli], a
	ld a, $2
	ld [hli], a
	ld a, $3
	ld [hli], a
	ld a, $1
	ld [hli], a
	ld [hl], $0
	set 5, [hl]
	inc hl
	xor a
	ld [hli], a
	ld a, $20
	ld [hli], a
	ld a, $1
	add $40
	add $80
	add $2
	ld [hli], a
	ld a, $1
	ld [hli], a
	ld [hli], a
	ret

Function4a3a7:
	call Function4a485
Function4a3aa:
	hlcoord 0, 0
	lb bc, 3, 1
	xor a
	call Function4a6d8
	lb bc, 1, 1
	ld a, $1
	call Function4a6d8
	lb bc, 1, 1
	xor a
	call Function4a6d8
	lb bc, 1, 1
	ld a, $1
	call Function4a6d8
	lb bc, 4, 1
	ld a, $2
	call Function4a6d8
	lb bc, 1, 1
	ld a, $3
	call Function4a6d8
	lb bc, 1, 1
	ld a, " "
	call Function4a6d8
	hlcoord 1, 0
	ld a, $1
	lb bc, 3, 18
	call Function4a6d8
	lb bc, 1, 18
	ld a, $0
	call Function4a6d8
	lb bc, 1, 18
	ld a, $1
	call Function4a6d8
	lb bc, 1, 18
	ld a, $2
	call Function4a6d8
	lb bc, 11, 18
	ld a, " "
	call Function4a6d8
	hlcoord 19, 0
	lb bc, 3, 1
	ld a, $0
	call Function4a6d8
	lb bc, 1, 1
	ld a, $1
	call Function4a6d8
	lb bc, 1, 1
	xor a
	call Function4a6d8
	lb bc, 1, 1
	ld a, $1
	call Function4a6d8
	lb bc, 4, 1
	ld a, $2
	call Function4a6d8
	lb bc, 1, 1
	ld a, $3
	call Function4a6d8
	lb bc, 1, 1
	ld a, " "
	call Function4a6d8
	ret

Function4a485:
	ld de, MobileMenuGFX
	ld hl, vTiles2 tile $00
	lb bc, BANK(MobileMenuGFX), 13
	call Get2bpp
	ret

Function4a492:
	call _CrystalCGB_MobileLayout0
	ret

Function4a545:
	call ScrollingMenuJoypad
	ld hl, wMenuCursorY
	ld b, [hl]
	push bc

Function4a5b0:
	call Function4a680
	pop bc
	ld hl, wMenuCursorY
	ld [hl], b
	ld b, $a
	ld c, $1
	hlcoord 3, 1
	call ClearBox
	jp Function4a545

String_4a5c5:
	db "じこしょうかい@"
String_4a5cd:
	db "たいせん　<GA>はじまるとき@"
String_4a5da:
	db "たいせん　<NI>かったとき@"
String_4a5e6:
	db "たいせん　<NI>まけたとき@"
String_4a5f2:
	db "もどる@"

Strings_4a5f6:
	db "めいし　や　ニュース　<NI>のせる@"
	db "あなた<NO>あいさつです@"
	db "モバイル　たいせん<GA>はじまるとき@"
	db "あいて<NI>みえる　あいさつです@"
	db "モバイル　たいせんで　かったとき@"
	db "あいて<NI>みえる　あいさつです@"
	db "モバイル　たいせんで　まけたとき@"
	db "あいて<NI>みえる　あいさつです@"
	db "まえ<NO>がめん　<NI>もどります@"
	db "@"

Function4a680:
	ld hl, w2DMenuCursorInitY
	ld a, $2
	ld [hli], a
	ld a, $3
	ld [hli], a
	ld a, $5
	ld [hli], a
	ld a, $1
	ld [hli], a
	ld [hl], $0
	set 5, [hl]
	inc hl
	xor a
	ld [hli], a
	ld a, $20
	ld [hli], a
	ld a, $1
	add $40
	add $80
	add $2
	ld [hli], a
	ld a, $1
	ld [hli], a
	ld [hli], a
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ret

Function4a6c5:
	ld a, $5
	ld [wMusicFade], a
	ld a, e
	ld [wMusicFadeID], a
	ld a, d
	ld [wMusicFadeID + 1], a
	ld c, 22
	call DelayFrames
	ret

Function4a6d8:
	push bc
	push hl
.asm_4a6da
	ld [hli], a
	dec c
	jr nz, .asm_4a6da
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, Function4a6d8
	ret

if DEF(_DEBUG)
MainMenu_DebugRoom:
	farcall _DebugRoom
	ret
endc
