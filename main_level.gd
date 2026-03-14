extends Node

@onready var anchor_point: Node2D = $"Static bodies/Anchor point"
@onready var hero: CharacterBody2D = $Hero

func _ready() -> void:
	anchor_point.player = hero
	anchor_point.damped_spring_joint_2d.node_a = anchor_point.player.get_path()

func grapple() -> void:
	if Input.is_action_just_pressed("grapple") and anchor_point.can_grapple == true:
		anchor_point.damped_spring_joint_2d.node_b = anchor_point.point.get_path()
		
func _physics_process(delta: float) -> void:
	grapple()
