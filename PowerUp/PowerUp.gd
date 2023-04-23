extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var sfx = preload("res://SFX/Tulu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	if area.is_in_group("Player"):
		get_tree().current_scene.add_child(sfx.instance())
		self.queue_free()
