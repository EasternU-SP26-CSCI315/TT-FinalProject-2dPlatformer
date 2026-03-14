extends Node2D

@onready var anchor_point: Node2D = $"Static bodies/Anchor point"
@onready var damped_spring_joint_2d: DampedSpringJoint2D = $DampedSpringJoint2D
@onready var can_grapple: bool = false
@onready var player: CharacterBody2D = null
@onready var point: StaticBody2D = $Point

func _on_area_2d_body_entered(player: CharacterBody2D) -> void:
	can_grapple = true



func _on_area_2d_body_exited(player: CharacterBody2D) -> void:
	can_grapple = false
