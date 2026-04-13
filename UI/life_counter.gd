extends Node2D
@onready var count: Sprite2D = $Count
@onready var life_counter: Node2D = $"."

func _process(_delta: float) -> void:	
	if player_lives.lives == 5:
		count.texture = load("res://Assets/Life Counter/5.png")
	elif player_lives.lives == 4:
		count.texture = load("res://Assets/Life Counter/4.png")
	elif player_lives.lives == 3:
		count.texture = load("res://Assets/Life Counter/3.png")
	elif player_lives.lives == 2:
		count.texture = load("res://Assets/Life Counter/2.png")
	elif player_lives.lives == 1:
		count.texture = load("res://Assets/Life Counter/1.png")
	#else:
		#life_counter.visiible = false
