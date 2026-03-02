extends Control

signal next_pressed

func _on_next_level_pressed():
	next_pressed.emit()
	queue_free()

func _on_restart_pressed() -> void:
		get_tree().paused = false
		get_tree().reload_current_scene()


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
