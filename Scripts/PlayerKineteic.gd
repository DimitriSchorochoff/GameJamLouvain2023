extends KinematicBody2D

const UP_DIRECTION := Vector2.UP

export var speed = 220.0
export var acc = 1500.0
export var fric = 1500.0
export var jump_strenght := 1000.0
export var gravity := 1700.0



var _jumps_made := 0
var _velocity := Vector2.ZERO

export var face_h := 1.0

var landing = false
var finishLanding = 0.0


var animationIndex = "1"

export var laserCD = 5
var nextLaserNow = 0.0

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer
onready var particleRun = $Particles2D
onready var TititiSFX = $Tititi #sons
onready var ShootSFX = $Shoot #sons
onready var JumpSFX = $Jump #sons
onready var LandSFX = $Land #sons
onready var Burst1SFX = $Burst1 #sons
onready var Burst2SFX = $Burst2 #sons
onready var Burst3SFX = $Burst3 #sons

const SmallShockWave = preload("res://player/SmallShockWave.tscn")
const ShockWave = preload("res://player/ShockWave.tscn")
const Laser = preload("res://player/laser.tscn")

onready var GameManager = get_node("/root/GameManager")
onready var ScreenShake = get_tree().current_scene.get_node("Camera2D")

func _process(delta):
	sprite.flip_h = face_h == 1

func _physics_process(delta: float) -> void:
	
	
	if OS.get_ticks_msec() > nextLaserNow and animationIndex == "3":
		shoot()
	elif OS.get_ticks_msec() > nextLaserNow-800 and !TititiSFX.playing and animationIndex == "3":
		TititiSFX.play()

	if GameManager.RAGE < GameManager.RAGE_CEIL_1:
		 animationIndex = "1"
	elif GameManager.RAGE < GameManager.RAGE_CEIL_2:
		animationIndex = "2"
	else:
		animationIndex = "3"
	
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

	if (OS.get_ticks_msec() > finishLanding):
		if is_idling:
			animationPlayer.play("Idle"+animationIndex)
			particleRun.emitting = false
		elif is_running:
			animationPlayer.play("Run"+animationIndex)
			particleRun.emitting = true
		

	if is_jumping:
		var rand = rand_range(1,100)
		if (rand<45):
			Burst1SFX.play()
		elif (rand<90):
			Burst2SFX.play()
		else:
			Burst3SFX.play()
		JumpSFX.play()
		_jumps_made += 1
		var strength = jump_strenght
		if animationIndex == "1":
			strength *=0.75
		_velocity.y -= strength
	
	if is_jump_cancelled:
		_velocity.y /= 3
		
	elif is_idling or is_running:
		_jumps_made = 0
		
	_velocity = move_and_slide(_velocity, UP_DIRECTION)

func shoot():
	ShootSFX.play()
	var laser = Laser.instance()
	get_parent().add_child(laser)
	laser.global_position = global_position
	laser.dir = face_h
	nextLaserNow = OS.get_ticks_msec() + laserCD*1000 #millisecond

func _on_Area2D_area_entered(area):
	if area.is_in_group("PowerUp1"):
		GameManager.SUBSTRACT_RAGE(100)
	elif area.is_in_group("PowerUp2"):
		GameManager.SUBSTRACT_RAGE_WITHOUT_CEIL(300)
		
func land():

	
	animationPlayer.play("Land"+animationIndex)
	finishLanding = OS.get_ticks_msec()+200
	

	var shockWave
	if animationIndex == "1":
		ScreenShake.shake(1,10)
		shockWave = SmallShockWave.instance()
	else:
		LandSFX.play()
		ScreenShake.shake(6,20)
		shockWave = ShockWave.instance()
	get_parent().add_child(shockWave)
	shockWave.global_position = global_position
	
