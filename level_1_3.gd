extends Node

@onready var anchor_point: Node2D = $"Static bodies/Anchor point"
@onready var hero: CharacterBody2D = $Hero
@onready var camera: Camera2D = $Camera
@onready var grappler: Node2D = $Hero/Grappler
@onready var door_open: Area2D = $"Static bodies/Door_open"
var start_x = -527.0
var start_y = 234.995
@onready var door_bool = false
var camera_y = false

func _ready() -> void:
	hero.position.x = start_x
	hero.position.y = start_y
	camera.position.x = hero.position.x
	camera.position.y = 0
	
		
func _physics_process(delta: float) -> void:
	if camera_y:
		camera_position(hero.position.x, hero.position.y-100)
	else:
		camera_position(hero.position.x, 0)
	if !alive():
		get_tree().change_scene_to_file("res://Menus/game_over.tscn")
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		await simple_transition_manager.fade_out()
		get_tree().change_scene_to_file("res://Levels/level_1_1.tscn")
		hero.lives -= 1
		simple_transition_manager.fade_in()
		
func alive() -> bool:
	if hero.lives == 0:
		return false
	else:
		return true
		
func _on_camera_y_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera_y = true
func _on_camera_y_area_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera_y = false	
	
func camera_position(x: float, y: float) -> void:
	camera.position.x = lerp(camera.position.x, x, 0.5)
	camera.position.y = lerp(camera.position.y, y, 0.5)

func _on_door_open_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		door_bool = true
	if  door_bool:
		change_lvl()
		


func change_lvl() -> void:
	await simple_transition_manager.fade_out()
	get_tree().change_scene_to_file("res://Menus/end_screen.tscn")
	simple_transition_manager.fade_in()
