extends Sprite

const CENTER_Y = 190

export var speed = 200.0
var _velocity = Vector2.ZERO

func loadGame():
	GameManager.GAME_STARTING = true
	
func _process(delta: float) -> void:
	if Input.is_action_just_released("jump"):
		loadGame()
	if GameManager.GAME_STARTED:
		position = Vector2.ZERO
	elif GameManager.GAME_STARTING:
		position = position.move_toward(Vector2(0,0), delta * speed)	
	
	if not GameManager.GAME_STARTED and position.is_equal_approx(Vector2.ZERO):
		GameManager.TIME = 0.0
		GameManager.GAME_STARTED = true

	
	
func _on_TextureButton_pressed():
	loadGame()
