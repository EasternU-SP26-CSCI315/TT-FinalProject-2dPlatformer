extends Node

@onready var anchor_point: Node2D = $"Static bodies/Anchor point"
@onready var hero: CharacterBody2D = $Hero
@onready var camera: Camera2D = $Camera
@onready var grappler: Node2D = $Hero/Grappler
var start_x = -527.0
var start_y = 234.995


func _ready() -> void:
	hero.position.x = start_x
	hero.position.y = start_y
	camera.position.x = hero.position.x
	camera.position.y = 0
	
		
func _physics_process(delta: float) -> void:
	camera.position.x = hero.position.x


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		hero.position.x = start_x
		hero.position.y = start_y
		
		
