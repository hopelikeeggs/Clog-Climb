extends Control

@onready var game_complete = $game_complete

func _ready() -> void:
	hide()
	add_to_group("ui")

func show_completed():
	get_tree().paused = true
	game_complete.play()
	show()
	
func _on_next_level_pressed():
	get_tree().paused = false
	var loading = preload("res://scenes/loading_screen.tscn").instantiate()
	get_tree().root.add_child(loading)
	loading.start_loading("res://scenes/level_select.tscn")

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_back_menu_pressed() -> void:
	get_tree().paused = false
	var loading = preload("res://scenes/loading_screen.tscn").instantiate()
	get_tree().root.add_child(loading)
	loading.start_loading("res://scenes/main_menu.tscn")
