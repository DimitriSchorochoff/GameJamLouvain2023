extends Node2D

const POWER1 = preload("res://PowerUp/PowerUp1.tscn")
const POWER2 = preload("res://PowerUp/PowerUp2.tscn")
const POWER3 = preload("res://PowerUp/PowerUp3.tscn")

const ceil_pr_power1 = 0.1
const ceil_pr_power2 = 0.2

var loop_time = 1.0
var loop_time_incr = 0.00

var spawn_pr_1 = 0.05
var spawn_pr_inc_1 = 0.00001

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
	if not contain_powerup() && randf() < spawn_pr_1 : 
		var pr = randf()
		if pr < ceil_pr_power1:
			spawned = POWER1.instance()
			print("Spawn power 1")
		elif pr < ceil_pr_power2:
			print("Spawn power 2")
			spawned = POWER2.instance()
		else:
			print("Spawn power 3")
			spawned = POWER3.instance()
			
		get_parent().add_child(spawned)
		spawned.position = position

	loop_time += loop_time_incr
	spawn_pr_1 += spawn_pr_inc_1

func contain_powerup()->bool:
	return is_instance_valid(spawned)