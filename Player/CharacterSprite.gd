extends Sprite


var kinematic 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	kinematic = get_parent().PlayerKineteic
	kinematic.flip_h = kinematic.face_h == 1
