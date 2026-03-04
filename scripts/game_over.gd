extends Control

func _ready():
	hide()
	add_to_group("ui")

func show_game_over():
	show()
	

func _on_restart_pressed() -> void:
		get_tree().paused = false
		get_tree().reload_current_scene()


func _on_back_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
