extends Node2D

onready var sound = preload("res://SFX/GameOver.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	sound.instance()
	#get_tree().current_scene.add_child(sound)
	$AnimationPlayer.play("Anim")
	$RichTextLabel.bbcode_text = "[center]" + String(GameManager.GET_TIME_ELAPSED())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	GameManager.try_again()
