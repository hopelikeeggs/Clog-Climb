extends Node2D

@export var amount_to_show := 1
@export var level_number: int = 1

@onready var spawn_point = $mang_juan

var total_drains := 0
var cleaned_drains := 0
var total_trash := 0
var collected_trash := 0

func _ready():

	if PlayerData.selected_character_scene == null:
		PlayerData.selected_character_scene = load("res://scenes/characters/mang_juan.tscn")

	var player = PlayerData.selected_character_scene.instantiate()
	player.position = spawn_point.position
	add_child(player)

	spawn_point.hide()

	randomize()
	randomize_normal_trash()
	randomize_drains()

	get_tree().call_group("ui", "update_trash_count", 0, total_trash)
	get_tree().call_group("ui", "update_drain_count", 0, total_drains)

func randomize_drains():
	var drain_list = get_tree().get_nodes_in_group("drain_trash")

	for drain in drain_list:
		drain.visible = false

	drain_list.shuffle()

	for i in range(amount_to_show):
		if i < drain_list.size():
			drain_list[i].visible = true

	# Count only visible drains
	total_drains = 0
	for drain in drain_list:
		if drain.visible:
			total_drains += 1
			
func randomize_normal_trash():
	var trash_list = get_tree().get_nodes_in_group("trash")

	print("Trash found:", trash_list.size())

	for trash in trash_list:
		trash.visible = true

	total_trash = trash_list.size()
func count_trash():
	total_trash = get_tree().get_nodes_in_group("trash").size()

func trash_collected():
	collected_trash += 1
	get_tree().call_group("ui", "update_trash_count", collected_trash, total_trash)
	check_level_complete()


# -------------------------
# DRAIN SYSTEM
# -------------------------

func count_drains():
	total_drains = get_tree().get_nodes_in_group("drain_trash").size()

func drain_cleaned():
	cleaned_drains += 1
	get_tree().call_group("ui", "update_drain_count", cleaned_drains, total_drains)
	check_level_complete()


# -------------------------
# COMPLETE CHECK
# -------------------------

func check_level_complete():
	if collected_trash >= total_trash and cleaned_drains >= total_drains:
		level_completed()

func level_completed():
	Progress.unlock_level(level_number + 1)
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")
