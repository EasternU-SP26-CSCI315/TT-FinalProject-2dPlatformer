extends Control

func _on_start_game_pressed() -> void:
	await simple_transition_manager.fade_out()
	
	if simple_transition_manager._is_faded_out == true:
		get_tree().change_scene_to_file("res://Levels/level_1_1.tscn")
	
	simple_transition_manager.fade_in()


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_how_to_play_pressed() -> void:
	await simple_transition_manager.fade_out()
	
	get_tree().change_scene_to_file("res://Levels/tutorial.tscn")
	
	simple_transition_manager.fade_in()
