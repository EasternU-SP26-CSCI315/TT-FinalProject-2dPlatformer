extends Node2D
@onready var joint: DampedSpringJoint2D = $DampedSpringJoint2D
@onready var hero: CharacterBody2D = $Hero
@onready var static_body_2d: StaticBody2D = $StaticBody2D

func _ready():
	joint.node_a = hero.get_path()
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed('grapple'):
		grapple(static_body_2d)
	if Input.is_action_just_released("grapple"):
		release_grapple()
		
func grapple(anchor):
	hero.grappling = true
	joint.node_b = anchor.get_path()
	joint.rest_length = hero.global_position.distance_to(anchor.global_position)
	joint.stiffness = 200
	joint.damping = 10

func release_grapple():
	joint.node_b = NodePath("")
	hero.grappling = false	
