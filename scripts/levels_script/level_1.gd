extends Node2D

@export var amount_to_show:= 1
@export var level_number: int = 1
@onready var spawn_point = $mang_juan

var total_drains := 1
var cleaned_drains := 0
var total_trash := 1
var collected_trash := 0

func _ready():
	if PlayerData.selected_character_scene == null:
		PlayerData.selected_character_scene = load("res://scenes/characters/mang_juan.tscn")

	var player = PlayerData.selected_character_scene.instantiate()
	player.position = spawn_point.position
	add_child(player)
# Called when the node enters the scene tree for the first time.

	randomize()
	randomize_normal_trash()
	count_drains()

func randomize_normal_trash():
	var trash_list = get_tree().get_nodes_in_group("trash")

	# Hide all first
	for trash in trash_list:
		trash.visible = false

	# Shuffle randomly
	trash_list.shuffle()

	# Show only selected amount
	for i in range(amount_to_show):
		if i < trash_list.size():
			trash_list[i].visible = true

func trash_collected():
	collected_trash += 1
	
	if collected_trash >= total_trash:
		level_completed()
		print("LEVEL COMPLETE")
	
func try_finish_level():
	if collected_trash >= total_trash:
		level_completed()
	else:
		print("Collect all trash first!")
		
func level_completed():
	Progress.unlock_level(level_number + 1)
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func count_drains():
	var drain_list = get_tree().get_nodes_in_group("drain")
	total_drains = drain_list.size()
	print("Total drains:", total_drains)
