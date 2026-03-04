extends Node2D

@onready var option: = $CanvasLayer/option
@onready var question: = $CanvasLayer/mechanics
@onready var info: = $CanvasLayer/info
@onready var quit: = $CanvasLayer/quit_validation

# This runs on scene load
func _ready() -> void:
	if GlobalAutoLoad.intro_played:
		# Show the main menu directly after intro completion
		$name.visible = true
		$Button_manager.visible = true
		$BG/Camera2D.make_current()
		$Istambay.playing = true
		$VideoStreamPlayer.visible = false
		$VideoStreamPlayer/Camera2D.enabled = false
	else:
		# If intro hasn't been played, play the intro video
		$name.visible = false
		$Button_manager.visible = false
		$Istambay.playing = false
		$VideoStreamPlayer.play()
		$VideoStreamPlayer/Camera2D.make_current()

# In the intro scene, once the intro video finishes
func _on_video_stream_player_finished():
	GlobalAutoLoad.intro_played = true
	
	# Hide intro video and transition to cutscene
	$VideoStreamPlayer.visible = false
	$VideoStreamPlayer/Camera2D.enabled = false
	
	# Load the cutscene scene
	get_tree().change_scene_to_file("res://scenes/cutscene.tscn")

func _hide_all():
	quit.visible = false
	question.visible = false
	option.visible = false
	info.visible = false
	get_tree().paused = false
	
	$Button_manager/Question.button_pressed = false
	$Button_manager/Info.button_pressed = false
	
func _on_quit_pressed() -> void:
	if quit.visible:
		quit.visible = false
	else:
		_hide_all()
		quit.visible = true

func _on_question_toggled(toggled_on: bool) -> void:
	if toggled_on:
		_hide_all()
		question.visible = true
	else:
		question.visible = false
		
func _on_option_pressed() -> void:
	if option.visible:
		option.visible = false
	else:
		_hide_all()
		option.visible = true
		
func _on_info_toggled(toggled_on: bool) -> void:
	if toggled_on:
		_hide_all()
		info.visible = true
	else:
		info.visible = false

func _on_start_pressed() -> void:
	var loading = preload("res://scenes/loading_screen.tscn").instantiate()
	get_tree().root.add_child(loading)
	loading.start_loading("res://scenes/characterselect.tscn")
