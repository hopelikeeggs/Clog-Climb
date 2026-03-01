extends Node2D

@onready var anim_container = $Character_animation_selected
@onready var next_button = $next

var selected_character = ""

@onready var option: = $CanvasLayer/option
@onready var question: = $CanvasLayer/mechanics
@onready var info: = $CanvasLayer/info

func _ready():
	next_button.disabled = true
	
	# Hide all animations at start
	for child in anim_container.get_children():
		child.visible = false


func show_selected_character(character_name: String):
	# Hide all animations first
	for child in anim_container.get_children():
		child.visible = false
	
	# Show selected animation
	var selected_anim = anim_container.get_node(character_name)
	selected_anim.visible = true
	selected_anim.play("player_selected")
	
	# Store selection locally
	selected_character = character_name
	
	# Store in Global (PackedScene)
	PlayerData.selected_character_scene = load("res://scene/characters/" + character_name + ".tscn")
	PlayerData.selected_character_name = character_name
	
	next_button.disabled = false



# BUTTON SIGNALS
func _on_mang_juan_pressed():
	show_selected_character("mang_juan")

func _on_aling_chona_pressed():
	show_selected_character("aling_chona")

func _on_princess_pressed():
	show_selected_character("princess")

func _on_jobert_pressed():
	show_selected_character("jobert")

func _hide_all():
	question.visible = false
	option.visible = false
	info.visible = false
	get_tree().paused = false
	
	$Button_manager/question.button_pressed = false
	$Button_manager/info.button_pressed = false

func _on_back_pressed() -> void:
	var loading = preload("res://scenes/loading_screen.tscn").instantiate()
	get_tree().root.add_child(loading)
	loading.start_loading("res://scenes/main_menu.tscn")

func _on_option_pressed() -> void:
	if option.visible:
		option.visible = false
	elif !option.visible:
		option.visible = true
	else:
		_hide_all()
		option.visible = true
		
func _on_question_toggled(toggled_on: bool) -> void:
	if toggled_on:
		_hide_all()
		question.visible = true
	else:
		question.visible = false
		

func _on_info_toggled(toggled_on: bool) -> void:
	if toggled_on:
		_hide_all()
		info.visible = true
	else:
		info.visible = false


func _on_next_pressed() -> void:
		var loading = preload("res://scenes/loading_screen.tscn").instantiate()
		get_tree().root.add_child(loading)
		loading.start_loading("res://scenes/level_select.tscn")
