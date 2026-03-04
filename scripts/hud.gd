extends CanvasLayer

func _ready() -> void:
	add_to_group("ui")

# --------------------
# TRASH COUNTER
# --------------------
func update_trash_count(current_amount: int, goal_amount: int):
	$TrashCounter.text = str(current_amount) + " / " + str(goal_amount)

# --------------------
# DRAIN COUNTER
# --------------------
func update_drain_count(current_amount: int, goal_amount: int):
	$DrainCounter.text = str(current_amount) + " / " + str(goal_amount)

func update_hearts(health: int):
	print("Health UI updated to: ", health)

func show_victory_screen():
	var victory_label = Label.new()
	victory_label.text = "LEVEL COMPLETE! MANG JUAN SAVED THE DAY! <3 "
	victory_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	add_child(victory_label)
	victory_label.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
