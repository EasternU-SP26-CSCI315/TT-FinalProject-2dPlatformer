extends Node2D
@export var rest_length = 200.0
@export var stiffness = 15.0
@export var damping = 1.0

@onready var hero: CharacterBody2D = $".."
@onready var ray: RayCast2D = $ray
@onready var rope: Line2D = $rope


var launched = false
var target: Vector2
var can_grapple: bool = false
var grapple_toggle: bool = true
@onready var current_anchor: Node2D

func _ready() -> void:
	rope.hide()
	
func _process(delta):
	if current_anchor != null:
		ray.look_at(current_anchor.global_position)
		ray.target_position = ray.to_local(current_anchor.global_position)
	else:
		can_grapple = false
	
	if Input.is_action_just_pressed("grapple") and can_grapple:
		if grapple_toggle == true:
			launch()
			grapple_toggle = false
		else:
			retract()
			grapple_toggle = true
	if !can_grapple:
		retract()
	if launched:
		handle_grapple(delta)

func launch():
	if ray.is_colliding():
		launched = true
		target = ray.get_collision_point()
		rope.show()

func retract():
	launched = false
	rope.hide()

func handle_grapple(delta):
	var target_dir = hero.global_position.direction_to(target)
	var target_dist = hero.global_position.distance_to(target)
	
	var displacement = target_dist - rest_length
	
	var force = Vector2.ZERO
	
	if displacement > 0:
		var spring_force_magnitude = stiffness * displacement
		var spring_force = target_dir * spring_force_magnitude
		
		var vel_dot = hero.velocity.dot(target_dir)
		var damping_force = -damping * vel_dot * target_dir
		force = spring_force + damping_force
	
	hero.velocity += force * delta 
	update_rope()

func update_rope():
	rope.set_point_position(1, to_local(target))
