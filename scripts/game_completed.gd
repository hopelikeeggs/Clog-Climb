extends Control

func _ready() -> void:
	hide()
	add_to_group("ui")

func show_completed():
	show()
	
func _on_next_level_pressed():
	var loading = preload("res://scenes/loading_screen.tscn").instantiate()
	get_tree().root.add_child(loading)
	loading.start_loading("res://scenes/level_select.tscn")

func _on_restart_pressed() -> void:
		get_tree().paused = false
		get_tree().reload_current_scene()

func _on_back_menu_pressed() -> void:
	var loading = preload("res://scenes/loading_screen.tscn").instantiate()
	get_tree().root.add_child(loading)
	loading.start_loading("res://scenes/main_menu.tscn")
