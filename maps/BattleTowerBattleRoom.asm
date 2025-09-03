	object_const_def
	const BATTLETOWERBATTLEROOM_YOUNGSTER
	const BATTLETOWERBATTLEROOM_RECEPTIONIST

BattleTowerBattleRoom_MapScripts:
	def_scene_scripts
	scene_script BattleTowerBattleRoomEnterScene, SCENE_BATTLETOWERBATTLEROOM_ENTER
	scene_script BattleTowerBattleRoomNoopScene,  SCENE_BATTLETOWERBATTLEROOM_NOOP

	def_callbacks

BattleTowerBattleRoomEnterScene:
	disappear BATTLETOWERBATTLEROOM_YOUNGSTER
	sdefer Script_BattleRoom
	setscene SCENE_BATTLETOWERBATTLEROOM_NOOP
	; fallthrough
BattleTowerBattleRoomNoopScene:
	end

Script_BattleRoom:
	end

Script_BeatenAllTrainers:
	pause 60
	special BattleTowerFade
	warpfacing UP, BATTLE_TOWER_1F, 7, 7
Script_BeatenAllTrainers2:
	opentext
	writetext Text_CongratulationsYouveBeatenAllTheTrainers
	sjump Script_GivePlayerHisPrize

BattleTowerBattleRoom_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, BATTLE_TOWER_HALLWAY, 4
	warp_event  4,  7, BATTLE_TOWER_HALLWAY, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4,  0, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_BATTLE_TOWER_BATTLE_ROOM_YOUNGSTER
	object_event  1,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
