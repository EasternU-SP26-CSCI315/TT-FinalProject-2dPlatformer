extends Node2D

var can_grapple: bool = false
@onready var anchor_point: Node2D = $"."
@onready var point: StaticBody2D = $Point
var current_anchor: StaticBody2D = null

func _on_area_2d_body_entered(body) -> void:
	if body is CharacterBody2D:
		body.get_node("Grappler").current_anchor = self
		body.get_node("Grappler").can_grapple = true



func _on_area_2d_body_exited(body) -> void:
	if body is CharacterBody2D:
		body.get_node("Grappler").current_anchor = null
		body.get_node("Grappler").can_grapple = false
