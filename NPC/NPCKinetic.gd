extends KinematicBody2D

const UP_DIRECTION := Vector2.UP

export var speed = 40
export var direction := Vector2.LEFT
export var gravity := 450.0

onready var _velocity = direction*speed

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	_velocity = move_and_slide(_velocity, UP_DIRECTION)

	var is_falling = _velocity.y > 0.0 and not is_on_floor()
	var is_jumping = Input.is_action_just_pressed("jump") and is_on_floor()
	var is_jump_cancelled = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var is_idling = is_zero_approx(_velocity.x) and is_on_floor()
	var is_running = is_on_floor() and not is_zero_approx(_velocity.x)
	
		
	if is_on_wall():
		direction.x *= -1
		_velocity.x = direction.x * speed


func _on_Area2D_area_entered(area):
	if area.is_in_group("Player"):
		self.queue_free()
