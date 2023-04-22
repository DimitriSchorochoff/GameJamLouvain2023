extends Sprite


export onready var kinematic = $PlayerKineteic 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	flip_h = kinematic.face_h == 1
