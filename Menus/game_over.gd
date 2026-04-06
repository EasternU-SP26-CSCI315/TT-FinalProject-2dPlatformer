extends Control

func _on_replay_pressed() -> void:
	await simple_transition_manager.fade_out()
	get_tree().change_scene_to_file("res://level_1_1.tscn")
	simple_transition_manager.fade_in()

func _on_quit_pressed() -> void:
	get_tree().quit()
