extends Control

@onready var cutscene_video: VideoStreamPlayer = $CutsceneVideo
@onready var cutscene_camera: Camera2D = $CutsceneVideo/CutsceneCamera
@onready var main_camera: Camera2D = $MainCamera

var page = 0

func _ready() -> void:
	# Play the cutscene video
	$CutsceneVideo.play()
	$CutsceneVideo/CutsceneCamera.make_current()  # Make sure the correct camera is active
	
	# Optional: Set autoplay based on your needs
	$CutsceneVideo.autoplay = true  # This will automatically play the video

# Transition to main menu once the video ends
func _on_video_stream_player_finished():
	go_to_main_menu()

# Go to the main menu
func go_to_main_menu():
	# Stop the cutscene video
	cutscene_video.stop()

	# Optionally switch camera if you want to move to the main camera
	switch_to_main_camera()

	# Load loading screen if desired (before transitioning to main menu)
	var loading = preload("res://scenes/loading_screen.tscn").instantiate()
	get_tree().root.add_child(loading)
	loading.start_loading("res://scenes/main_menu.tscn")

# Switch to the main camera
func switch_to_main_camera():
	main_camera.make_current()

func go_to_loading():
	$CutsceneVideo.stop()
	switch_to_main_camera()
	
	var loading = preload("res://scenes/loading_screen.tscn").instantiate()
	get_tree().root.add_child(loading)
	loading.start_loading("res://scenes/main_menu.tscn")

func next_page():
	page += 1
		
	if page == 1:
		$Label.text = ("PRESS AGAIN")
	elif page == 2:
		go_to_loading()

func _on_texture_button_pressed() -> void:
	next_page()


func _on_cutscene_video_finished() -> void:
	pass # Replace with function body.
