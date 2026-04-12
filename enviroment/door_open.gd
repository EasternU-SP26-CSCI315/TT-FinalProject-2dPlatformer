extends Area2D
@onready var level_change: AudioStreamPlayer2D = $"level change"

func play() -> void:
	level_change.playing = true
