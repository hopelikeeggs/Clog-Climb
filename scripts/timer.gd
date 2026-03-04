extends Node2D

@onready var timer = $Timer
@onready var label = $Label

var time_left = 30

func _ready():
	timer.start()
	label.text = str(time_left)

func _on_timer_timeout():
	time_left -= 1
	label.text = str(time_left)

	if time_left <= 0:
		get_tree().paused = true
		get_tree().call_group("ui", "show_game_over")
