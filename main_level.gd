extends Node

@onready var anchor_point: Node2D = $"Static bodies/Anchor point"
@onready var hero: CharacterBody2D = $Hero
@onready var camera: Camera2D = $Camera
@onready var grappler: Node2D = $Hero/Grappler



func _ready() -> void:
	hero.position.x = -527.0
	hero.position.y = 234.995
	camera.position.x = hero.position.x
	camera.position.y = 0
	
		
func _physics_process(delta: float) -> void:
	camera.position.x = hero.position.x
