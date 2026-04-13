extends Node

@onready var hero: CharacterBody2D = $Hero
@onready var camera: Camera2D = $Camera
@onready var grappler: Node2D = $Hero/Grappler
@onready var flag_pole: Area2D = $"static bodies/flag pole"
@onready var level_change: AudioStreamPlayer2D = $"static bodies/flag pole/level change"
@onready var player_death: AudioStreamPlayer = $"static bodies/Death Plane/player_death"
var start_x = -527.0
var start_y = 234.995
@onready var door_bool = false
var camera_y = false

func _ready() -> void:
	hero.position.x = start_x
	hero.position.y = start_y
	camera.position.x = hero.position.x
	camera.position.y = 0
	
		
func _physics_process(_delta: float) -> void:
	
	if camera_y:
		camera_position(hero.position.x, hero.position.y-100)
	else:
		camera_position(hero.position.x, 0)
	if !alive():
		get_tree().change_scene_to_file("res://Menus/game_over.tscn")
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_death.playing = true
		
func alive() -> bool:
	if player_lives.lives == 0:
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

func _on_flag_pole_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		door_bool = true
		hero.speed = 0
		play()
		
func play() -> void:
	level_change.playing = true

func change_lvl() -> void:
	await simple_transition_manager.fade_out()
	get_tree().change_scene_to_file("res://Menus/end_screen.tscn")
	simple_transition_manager.fade_in()


func _on_level_change_finished() -> void:
	change_lvl()

func player_die() -> void:
	await simple_transition_manager.fade_out()
	get_tree().change_scene_to_file("res://Levels/level_1_1.tscn")
	player_lives.lives -= 1
	simple_transition_manager.fade_in()
	
func _on_player_death_finished() -> void:
	player_die()
