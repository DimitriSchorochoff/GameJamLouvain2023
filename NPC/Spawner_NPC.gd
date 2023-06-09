extends Node2D

const NPC_1 = preload("res://NPC/NPC.tscn")
const NPC_2 = preload("res://NPC/NPC_lvl2.tscn")

var loop_time = 1
var loop_time_incr = -0.0025

var spawn_pr_1 = 0.2
var spawn_pr_inc_1 = 0.009
var N_npc1_spawn = 0

var spawn_pr_2 = 0.07
var spawn_pr_inc_2 = 0.012
var N_npc2_spawn = 0

var npc_lst = []
export var N_NPC_CAP = 5.0
var BONUS_NPC_CAP = 0.0
var inc_NPC_CAP = 0.02
var MAX_CAP = 7.0

var _timer = null
var fully_opened = false
var fully_closed = true

onready var anim = $AnimationPlayer

func _ready():
	_timer = Timer.new()
	add_child(_timer)

	_timer.connect("timeout", self, "onLoop")
	_timer.set_wait_time(loop_time)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()
	
func onLoop():
	if not GameManager.GAME_STARTED: return
	clear_npc_lst()
	
	if len(npc_lst) < N_NPC_CAP + BONUS_NPC_CAP:
		if randf() < spawn_pr_1 :
			N_npc1_spawn+=1
			
		if randf() < spawn_pr_2 : 
			N_npc2_spawn += 1

	var npc2spawn = N_npc1_spawn > 0 || N_npc2_spawn > 0

		
	if fully_closed and can_spawn_npc():
		fully_closed = false
		anim.play("Open")
		
	if fully_opened:
		if not can_spawn_npc():
			fully_opened = false
			anim.play("Close")	
		
		else:
			if randf() < 0.5:
				if N_npc1_spawn > 0:
					spawn_npc1()
				elif N_npc2_spawn > 0:
					spawn_npc2()
			else:
				if N_npc2_spawn > 0:
					spawn_npc2()
				elif N_npc1_spawn > 0:
					spawn_npc1()

	#BONUS_NPC_CAP = min(MAX_CAP, BONUS_NPC_CAP+inc_NPC_CAP)
	BONUS_NPC_CAP += inc_NPC_CAP
	print(BONUS_NPC_CAP)
	loop_time += loop_time_incr
	spawn_pr_1 += spawn_pr_inc_1


func can_spawn_npc()->bool:
	return (N_npc1_spawn > 0 or N_npc2_spawn > 0) and len(npc_lst) < N_NPC_CAP + BONUS_NPC_CAP

func spawn_npc1():
	var num = int(floor(rand_range(1, 5.99999)))
	if num != 3:
		var npc1 = NPC_1.instance()
		get_parent().add_child(npc1)
		npc1.get_node("AnimationPlayer").play("NPC"+String(num))
		npc1.speed = GameManager.NPC_SPEED[num-1]
		npc1.position = position
		N_npc1_spawn -= 1 
		npc_lst.append(npc1)
		
func spawn_npc2():
	var npc2 = NPC_2.instance()
	get_parent().add_child(npc2)
	#var num = int(floor(rand_range(1, 5.99999)))
	npc2.get_node("AnimationPlayer").play("NPC3")
	npc2.speed = GameManager.NPC_SPEED[2]
	npc2.position = position
	N_npc2_spawn -= 1 
	npc_lst.append(npc2)

func clear_npc_lst():
	
	var toKeep = []
	for i in npc_lst:
		if is_instance_valid(i):
			toKeep.append(i)		
	npc_lst = toKeep

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Open":
		fully_opened = true
	if anim_name == "Close":
		fully_closed = true
