extends KinematicBody2D

const UP_DIRECTION := Vector2.UP

export var speed = 40
var direction := Vector2(sign(rand_range(-1, 1)), 0)
export var gravity := 450.0
export var face_h := 1.0

onready var _velocity = direction*speed
onready var sprite = $Sprite
onready var shadow = $Shadow

var BloodEffect = preload("res://BloodParticleEffect.tscn")

func _ready():
	pass
	#direction.x = int(rand_range(-1, 1))

func _process(delta):
	sprite.flip_h = (face_h == 1)
	
func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	_velocity = move_and_slide(_velocity, UP_DIRECTION)

	if direction.x != 0.0:
		face_h = direction.x/abs(direction.x)
		
	var is_falling = _velocity.y > 0.0 and not is_on_floor()
	var is_jumping = Input.is_action_just_pressed("jump") and is_on_floor()
	var is_jump_cancelled = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var is_idling = is_zero_approx(_velocity.x) and is_on_floor()
	var is_running = is_on_floor() and not is_zero_approx(_velocity.x)
	
	shadow.visible = is_on_floor()
		
	if is_on_wall():
		direction.x *= -1
		_velocity.x = direction.x * speed


func _on_Area2D_area_entered(area):
	if area.is_in_group("Player"):
		var bloodEffect = BloodEffect.instance()
		get_tree().current_scene.add_child(bloodEffect)
		bloodEffect.global_position = global_position
		GameManager.NPC_KILL_COUNT += 1
		self.queue_free()
