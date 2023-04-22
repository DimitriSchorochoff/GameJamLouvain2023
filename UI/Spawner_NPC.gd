extends Node2D

const NPC_1 = preload("res://NPC/NPC.tscn")

var loop_time = 1.0
var loop_time_incr = 0.01

var spawn_pr_1 = 0.25
var spawn_pr_inc_1 = 0.0001
var N_npc1_spawn = 0

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
	if randf() < spawn_pr_1 :
		print("Spawn new npc 1")
		N_npc1_spawn+=1

	var npc2spawn = N_npc1_spawn > 0

	if fully_closed and npc2spawn:
		fully_closed = false
		anim.play("Open")
		
	if fully_opened:
		if not npc2spawn:
			fully_opened = false
			anim.play("Close")	
			
		if N_npc1_spawn > 0:
			var npc1 = NPC_1.instance()
			get_parent().add_child(npc1)
			var num = int(floor(rand_range(1, 5.99999)))
			print(num)
			npc1.get_node("AnimationPlayer").play("NPC"+String(num))
			npc1.position = position
			N_npc1_spawn -= 1 

	loop_time += loop_time_incr
	spawn_pr_1 += spawn_pr_inc_1


func _on_AnimationPlayer_animation_finished(anim_name):
	print("Finished")
	if anim_name == "Open":
		print("Finished open")
		fully_opened = true
	if anim_name == "Close":
		fully_closed = true
