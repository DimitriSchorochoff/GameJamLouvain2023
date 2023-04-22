extends KinematicBody2D

const UP_DIRECTION := Vector2.UP

export var speed = 200
export var jump_strenght := 100.0
export var gravity := 450.0

var _jumps_made := 0
var _velocity := Vector2.ZERO

export var face_h := 1.0

func _physics_process(delta: float) -> void:
	var _horizontal_direction = 0
	
	if _horizontal_direction != 0.0:
		face_h = _horizontal_direction/abs(_horizontal_direction)

	_velocity.x = _horizontal_direction * speed
	_velocity.y += gravity * delta

	var is_falling := _velocity.y > 0.0 and not is_on_floor()
	var is_jumping := Input.is_action_just_pressed("jump") and is_on_floor()
	var is_jump_cancelled := Input.is_action_just_released("jump") and _velocity.y < 0.0
	var is_idling := is_zero_approx(_velocity.x) and is_on_floor()
	var is_running := is_on_floor() and not is_zero_approx(_velocity.x)
	
		
	_velocity = move_and_slide(_velocity, UP_DIRECTION)


func _on_Area2D_area_entered(area):
	if area.is_in_group("Player"):
		print("NPC collide player")
		self.queue_free()
