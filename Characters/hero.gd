extends CharacterBody2D
@export var speed = 450
@export var climb_speed = -500
@export var jump_speed = -1000
@export var gravity = 3355
@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0 , 1.0) var acceleration = 0.25
@onready var grappler: Node2D = $Grappler
@onready var sprite: AnimatedSprite2D = $CollisionShape2D/AnimatedSprite2D
@onready var jump: AudioStreamPlayer2D = $Jump

	
func _physics_process(delta):
	if grappler.launched:
		#var climb_dir = Input.get_axis('climb_up', 'climb_down')
		#if climb_dir != 0:
			#velocity.y = lerp(velocity.y, -climb_dir * climb_speed, acceleration)
		#else:
		velocity.y += gravity * 0.5 * delta
	else:
		velocity.y += gravity * delta
	var dir = Input.get_axis("move_left", "move_right")
	if dir != 0:
		sprite.play("walk")
		if dir < 0 and !grappler.launched:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
		if speed == 0:
			sprite.play("idle")
	else:
		sprite.play("idle")
		velocity.x = lerp(velocity.x, 0.0, friction)

	move_and_slide()
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump.playing = true
		velocity.y = jump_speed
	if !is_on_floor() and !grappler.launched:
		sprite.play("jump")
	if !is_on_floor() and grappler.launched:
		sprite.play("swing")	
	if Input.is_action_just_pressed("menu"):
		await simple_transition_manager.fade_out()
		get_tree().change_scene_to_file("res://Menus/main menu.tscn")
		simple_transition_manager.fade_in()
		
