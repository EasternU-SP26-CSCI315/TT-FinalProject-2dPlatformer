extends Control
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	audio_stream_player.playing = true
	
func _on_replay_pressed() -> void:
	await simple_transition_manager.fade_out()
	player_lives.lives = player_lives.START_LIVES
	get_tree().change_scene_to_file("res://Levels/level_1_1.tscn")
	simple_transition_manager.fade_in()

func _on_quit_pressed() -> void:
	get_tree().quit()
