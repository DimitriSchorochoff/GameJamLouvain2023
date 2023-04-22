extends KinematicBody2D

const UP_DIRECTION := Vector2.UP

export var speed = 220.0
export var acc = 1500.0
export var fric = 1500.0
export var jump_strenght := 600.0
export var gravity := 1700.0

var _jumps_made := 0
var _velocity := Vector2.ZERO

export var face_h := 1.0

var landing = false
var finishLanding = 0.0


var animationIndex = "2"

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer
onready var particleRun = $Particles2D

func _process(delta):
	sprite.flip_h = face_h == 1

func _physics_process(delta: float) -> void:
	var _horizontal_direction = (
		Input.get_action_strength("move_right") - 
		Input.get_action_strength("move_left")
	)
	
	if _horizontal_direction != 0.0:
		face_h = _horizontal_direction/abs(_horizontal_direction)

		_velocity.x = move_toward(_velocity.x,_horizontal_direction *speed,  acc * delta)
		
	else:
		_velocity.x = move_toward(_velocity.x, 0,  fric * delta)
	_velocity.y += gravity * delta

	var is_falling := _velocity.y > 0.0 and not is_on_floor()
	var is_jumping := Input.is_action_just_pressed("jump") and is_on_floor()
	var is_jump_cancelled := Input.is_action_just_released("jump") and _velocity.y < 0.0 and !is_on_floor()
	var is_idling := is_zero_approx(_velocity.x) and is_on_floor()
	var is_running := is_on_floor() and not is_zero_approx(_velocity.x)
	

	if is_on_floor():
		if landing:
			land()
			landing = false
	else:
		if !landing:
			landing = true

	if (OS.get_ticks_msec() < finishLanding):
		return
		
	if is_idling:
		animationPlayer.play("Idle"+animationIndex)
		particleRun.emitting = false
	elif is_running:
		animationPlayer.play("Run"+animationIndex)
		particleRun.emitting = true
		

	if is_jumping:
		_jumps_made += 1
		_velocity.y -= jump_strenght
	
	if is_jump_cancelled:
		_velocity.y /= 3
		
	elif is_idling or is_running:
		_jumps_made = 0
		
	_velocity = move_and_slide(_velocity, UP_DIRECTION)


func land():
	animationPlayer.play("Land"+animationIndex)
	finishLanding = OS.get_ticks_msec()+200
	

func _on_Area2D_area_entered(area):		
	if area.is_in_group("NPC"):
		GameManager.NPC_KILL_COUNT += 1
		print("Player collide NPC")
