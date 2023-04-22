extends Node2D


export var speed = 100

	
export var timer = 1.0
var destroyNow = 0.0

export var dir = 1

func _ready():
	destroyNow = OS.get_ticks_msec() + timer*1000 #en millisecond

# Called when the node enters the scene tree for the first time.
func _process(delta):
	global_position.x += delta * speed * dir
	if (OS.get_ticks_msec() >= destroyNow):
		self.queue_free()


	
