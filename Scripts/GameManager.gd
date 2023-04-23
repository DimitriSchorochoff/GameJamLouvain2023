extends Node

var GAME_STARTING = false
var GAME_STARTED = false

const RAGE_CEIL_1 := 300
const RAGE_CEIL_2 := 695
const RAGE_PER_KILL = [50, 25, 12.5]

var NPC_KILL_COUNT := 0
var RAGE := 0


func SUBSTRACT_RAGE(var val):
	if GameManager.RAGE < GameManager.RAGE_CEIL_1:
		RAGE = clamp(RAGE-val, 0, RAGE-val)
	elif GameManager.RAGE < GameManager.RAGE_CEIL_2:
		RAGE = clamp(RAGE-val, RAGE_CEIL_1, RAGE-val)
	else:
		RAGE = clamp(RAGE-val, RAGE_CEIL_2, RAGE-val)
		
func SUBSTRACT_RAGE_WITHOUT_CEIL(var val):
	RAGE = clamp(RAGE-val, 0, RAGE-val)
