extends CharacterBody2D
@export var speed = 450
@export var jump_speed = -1000
@export var gravity = 3355
@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0 , 1.0) var acceleration = 0.25
@export var grappling = false
var START_HEALTH = 100
var health

func _ready() -> void:
	health = START_HEALTH

	
func _physics_process(delta):
	if grappling:
		velocity.y += gravity * 0.5 * delta
	else:
		velocity.y += gravity * delta
	var dir = Input.get_axis("move_left", "move_right")
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)

	move_and_slide()
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
