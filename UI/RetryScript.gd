extends Node2D

onready var sound = preload("res://SFX/GameOver.tscn")

var inputEnabled = false


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var t = Timer.new()
	t.set_wait_time(0.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	t.connect("timeout", self, "enableInput")
	
	var sn = sound.instance()
	self.add_child(sn)
	#get_tree().current_scene.add_child(sound)
	$AnimationPlayer.play("Anim")
	$RichTextLabel.bbcode_text = "[center]" + String(GameManager.GET_TIME_ELAPSED())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	
	if inputEnabled and Input.is_action_just_released("jump"):
		GameManager.try_again()

func _on_TextureButton_pressed():
	GameManager.try_again()


func enableInput():
	inputEnabled = true
