extends Node
@onready var hero: CharacterBody2D = $Hero
@onready var camera: Camera2D = $Camera
@onready var grappler: Node2D = $Hero/Grappler
@onready var door_open: Area2D = $"Static bodies/Door_open"
@onready var level_change: AudioStreamPlayer2D = $"Static bodies/Door_open/level change"
@onready var player_death: AudioStreamPlayer = $"Static bodies/Death Plane/player_death"
var start_x = -527.0
var start_y = 234.995
@onready var door_bool = false
var playing = false

func _ready() -> void:
	hero.position.x = start_x
	hero.position.y = start_y
	camera.position.x = hero.position.x
	camera.position.y = 0
	#health_bar.position.x = camera.position.x
	#health_bar.position.y = 0
	
		
func _physics_process(_delta: float) -> void:
	camera.position.x = hero.position.x
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


func _on_door_open_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		door_bool = true
		hero.speed = 0
		play()
		await simple_transition_manager.fade_out()
		

func play() -> void:
	level_change.playing = true
	
	
func change_lvl() -> void:
		get_tree().change_scene_to_file("res://Levels/level_1_2.tscn")
		simple_transition_manager.fade_in()


func _on_level_change_finished() -> void:
	change_lvl()

func player_die() -> void:
	await simple_transition_manager.fade_out()
	hero.position.x = start_x
	hero.position.y = start_y
	player_lives.lives -= 1
	simple_transition_manager.fade_in()

func _on_player_death_finished() -> void:
	player_die()
