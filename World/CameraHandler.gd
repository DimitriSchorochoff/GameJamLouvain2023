extends Sprite

const CENTER_Y = 190

export var speed = 200.0
var _velocity = Vector2.ZERO
onready var remoteTr = $RemoteTransform2D

func loadGame():
	GameManager.GAME_STARTING = true
	
func _process(delta: float) -> void:
	if GameManager.GAME_STARTING:
		position = position.move_toward(Vector2(0,0), delta * speed)
		
	if position.is_equal_approx(Vector2.ZERO) && GameManager.GAME_STARTED != true:
		GameManager.GAME_STARTED = true
		remoteTr.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
func _on_Button_pressed():
	print("Hoho")
	loadGame()
