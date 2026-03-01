extends VideoStreamPlayer

func _on_finished() -> void:
	var loading = preload("res://scenes/loading_screen.tscn").instantiate()
	get_tree().root.add_child(loading)
	loading.start_loading("res://scenes/main_menu.tscn")
