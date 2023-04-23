extends Node2D

const POWER1 = preload("res://PowerUp/PowerUp1.tscn")
const POWER2 = preload("res://PowerUp/PowerUp2.tscn")
const POWER3 = preload("res://PowerUp/PowerUp3.tscn")

const ceil_pr_power1 = 0.7
const ceil_pr_power2 = 0.9

var loop_time = 1.0
var loop_time_incr = 0.00

var spawn_pr_1 = 0.015
var spawn_pr_inc_1 = 0.0007

var spawned = null

var _timer = null

func _ready():
	_timer = Timer.new()
	add_child(_timer)

	_timer.connect("timeout", self, "onLoop")
	_timer.set_wait_time(loop_time)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()
	
func onLoop():
	if not GameManager.GAME_STARTED: return
	
	if not contain_powerup() && randf() < spawn_pr_1 : 
		var pr = randf()
		if pr < ceil_pr_power1:
			spawned = POWER1.instance()
		elif pr < ceil_pr_power2:
			spawned = POWER2.instance()
		else:
			spawned = POWER3.instance()
			
		get_parent().add_child(spawned)
		spawned.position = position

	loop_time += loop_time_incr
	spawn_pr_1 += spawn_pr_inc_1

func contain_powerup()->bool:
	return is_instance_valid(spawned)
