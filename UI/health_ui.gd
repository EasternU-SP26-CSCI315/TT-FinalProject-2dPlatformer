extends Control
@onready var label: Label = $VBoxContainer/Label
@onready var label_text: String = "Health: 100"

func _process(delta: float) -> void:
	label.text = label_text
