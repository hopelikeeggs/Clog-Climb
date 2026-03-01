extends Control

var target_scene := ""


func start_loading(scene_path: String):
	target_scene = scene_path
	ResourceLoader.load_threaded_request(scene_path)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	var status = ResourceLoader.load_threaded_get_status(target_scene)
	
	if status == ResourceLoader.THREAD_LOAD_LOADED:
		var packed_scene = ResourceLoader.load_threaded_get(target_scene)
		get_tree().change_scene_to_packed(packed_scene)
		
		queue_free()
		
func change_scene():
	var loading = preload("res://scenes/loading_screen.tscn").instantiate()
	get_tree().root.add_child(loading)
	loading.start_loading("res://scenes/character_selet_scene.tscn")
