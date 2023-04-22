extends Node2D

var speed = 100

# Called when the node enters the scene tree for the first time.
func _process(delta):
	global_position.x += delta * speed
	

		

