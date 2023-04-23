extends Camera2D

var pos;

export var decreaseSpeed = 5.0;
export var strength = 2.0;

func _ready():
	pos = global_position

func _process(delta):
	pos = get_parent().global_position
	global_position.y = pos.y + rand_range(-strength,strength)
	strength = move_toward(strength, 0 , decreaseSpeed*delta)

func shake(_strength, _decrease):
	decreaseSpeed = _decrease
	strength = _strength
