extends Node2D

@onready var camera = $Camera2D
@onready var option: = $ui_canvaslayer/option
@onready var question: = $ui_canvaslayer/mechanics
@onready var info: = $ui_canvaslayer/info

var current_level_index = 0	

var level_positions = [
	570,
	1723,
	2873,
	4026,
	5173
]

func _ready():
	camera.position.x = level_positions[0]

func go_to_next():
	if current_level_index < level_positions.size() - 1:
		current_level_index += 1
		move_camera()

func go_to_previous():
	if current_level_index > 0:
		current_level_index -= 1
		move_camera()

func move_camera():
	var tween = create_tween()
	tween.tween_property(camera, "position:x", level_positions[current_level_index], 0.5)

func _on_next_to_lvl_2_pressed() -> void:
	go_to_next()

func _on_next_to_lvl_3_pressed() -> void:
	go_to_next()


func _on_next_to_lvl_4_pressed() -> void:
	go_to_next()


func _on_next_to_lvl_5_pressed() -> void:
	go_to_next()


func _on_back_to_lvl_1_pressed() -> void:
	go_to_previous()


func _on_back_to_lvl_2_pressed() -> void:
	go_to_previous()


func _on_back_to_lvl_3_pressed() -> void:
	go_to_previous()


func _on_back_to_lvl_5_pressed() -> void:
	go_to_previous()

func _hide_all():
	question.visible = false
	option.visible = false
	info.visible = false
	get_tree().paused = false
	
	$Camera2D/button_manager/question.button_pressed = false
	$Camera2D/button_manager/info.button_pressed = false

func _on_option_pressed() -> void:
	if option.visible:
		option.visible = false
	elif !option.visible:
		_hide_all()
		option.visible = true


func _on_back_pressed() -> void:
		var loading = preload("res://scenes/loading_screen.tscn").instantiate()
		get_tree().root.add_child(loading)
		loading.start_loading("res://scenes/main_menu.tscn")


func _on_info_toggled(toggled_on: bool) -> void:
	if toggled_on:
		_hide_all()
		info.visible = true
	else:
		info.visible = false


func _on_question_toggled(toggled_on: bool) -> void:
	if toggled_on:
		_hide_all()
		question.visible = true
	else:
		question.visible = false
