extends Node2D

export var timer = 1.0
var destroyNow = 0.0

func _ready():
	destroyNow = OS.get_ticks_msec() + timer*1000 #en millisecond

func _process(delta):
	if (OS.get_ticks_msec() >= destroyNow):
		self.queue_free()
