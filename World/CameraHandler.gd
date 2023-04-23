extends Sprite

const CENTER_Y = 190

export var speed = 150.0
var _velocity = Vector2.ZERO

func _ready():
	loadGame()
	

func loadGame():
	GameManager.GAME_STARTING = true
	
func _process(delta: float) -> void:
	if GameManager.GAME_STARTING:
		position = position.move_toward(Vector2(0,0), delta * speed)
		
	print(position)
	if position.is_equal_approx(Vector2.ZERO):
		print("Yooo")
		GameManager.GAME_STARTED = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
