extends Control

@onready var game_over = $gameover

func _ready():
	hide()
	add_to_group("ui")

func show_game_over():
	game_over.play()
	show()
	

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_back_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_back_level_select_pressed() -> void:
	get_tree().paused = false
	var loading = preload("res://scenes/loading_screen.tscn").instantiate()
	get_tree().root.add_child(loading)
	loading.start_loading("res://scenes/level_select.tscn")
