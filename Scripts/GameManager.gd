extends Node

const world_preload = preload("res://World/MainMap.tscn")
var world_container

var GAME_STARTING = false
var GAME_STARTED = false

onready var Nyansfx = preload("res://SFX/Nyan.tscn")

const MAX_TIME = 200
var TIME = 0.0

const NPC_SPEED = [32, 40, 45, 38, 50]

const RAGE_CEIL_1 := 300
const RAGE_CEIL_2 := 695
const RAGE_MAX = 1000
const RAGE_PER_KILL = [75, 45, 35]
var NPC_KILL_COUNT := 0
var RAGE := 0

var hearth_timer
const HEARTH_MODE_DURATION = 7
const RAGE_PER_KILL_HEARTH = [-12.5, -7.5, -3.75]
var ON_HEARTH_MODE = false

func _process(delta):
	TIME += delta
	

func GET_BURST_STATE()->int:
	if GameManager.RAGE < GameManager.RAGE_CEIL_1:
		return 1
	elif GameManager.RAGE < GameManager.RAGE_CEIL_2:
		return 2
	else:
		return 3

func SUBSTRACT_RAGE(var val):
	var burst = GET_BURST_STATE()
	if burst == 1:
		RAGE = clamp(RAGE-val, 0, RAGE-val)
	elif burst == 2:
		RAGE = clamp(RAGE-val, RAGE_CEIL_1, RAGE-val)
	else:
		RAGE = clamp(RAGE-val, RAGE_CEIL_2, RAGE-val)
		
func SUBSTRACT_RAGE_WITHOUT_CEIL(var val):
	RAGE = clamp(RAGE-val, 0, RAGE-val)


func GET_RAGE_PER_KILL()->int:
	var burst = GET_BURST_STATE()
	
	if ON_HEARTH_MODE:
		return RAGE_PER_KILL_HEARTH[burst-1]
	else:
		return RAGE_PER_KILL[burst-1]

func ENABLE_HEARTH_MODE():
	get_tree().current_scene.add_child(Nyansfx.instance())
	ON_HEARTH_MODE = true
	print("HEART MODE ON")
	if hearth_timer != null:
		hearth_timer.disconnect("timeout",self,"_disable_hearth_mode")
	
	hearth_timer = Timer.new()
	hearth_timer.connect("timeout",self,"_disable_hearth_mode") 
	hearth_timer.set_wait_time( HEARTH_MODE_DURATION )
	add_child(hearth_timer) #to process
	hearth_timer.start() #to start
	
	
func _disable_hearth_mode():
	print("HEART MODE OFF")
	ON_HEARTH_MODE = false

func GET_TIME_ELAPSED()->int:
	return int(TIME)
	
func game_over():
	get_tree().change_scene("res://UI/RetryScene.tscn")
	
func try_again():
	get_tree().change_scene("res://World/MainMap.tscn")
	
	TIME = 0.0
	NPC_KILL_COUNT = 0
	RAGE = 0
