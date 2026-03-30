extends Node

@onready var anchor_point: Node2D = $"Static bodies/Anchor point"
@onready var hero: CharacterBody2D = $Hero
@onready var camera: Camera2D = $Camera
@onready var grappler: Node2D = $Hero/Grappler
@onready var door_open: Area2D = $"Static bodies/Door_open"
var start_x = -527.0
var start_y = 234.995
@onready var door_bool = false


func _ready() -> void:
	hero.position.x = start_x
	hero.position.y = start_y
	camera.position.x = hero.position.x
	camera.position.y = 0
	#health_bar.position.x = camera.position.x
	#health_bar.position.y = 0
	
		
func _physics_process(delta: float) -> void:
	print(door_bool)
	camera.position.x = hero.position.x
	#health_bar.position.x = camera.position.x
	if !alive():
		get_tree().quit()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		await simple_transition_manager.fade_out()
		hero.position.x = start_x
		hero.position.y = start_y
		hero.health -= 10
		simple_transition_manager.fade_in()
		
func alive() -> bool:
	if hero.health == 0:
		return false
	else:
		return true


func _on_door_open_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		door_bool = true
	if  door_bool:
		change_lvl()
		


func change_lvl() -> void:
	await simple_transition_manager.fade_out()
	get_tree().change_scene_to_file("res://level_1_2.tscn")
	simple_transition_manager.fade_in()
