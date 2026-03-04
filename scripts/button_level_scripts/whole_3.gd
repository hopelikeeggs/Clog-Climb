extends TextureButton

@export var level_number: int = 3

@onready var hole = $"."
@onready var door_anim = $"../man_whole_door/AnimationPlayer"

func _ready() -> void:
	update_state()

func update_state():

	if level_number < Progress.unlocked_level:
		hole.disabled = false
		door_anim.play("opened")

	elif level_number == Progress.unlocked_level:
		hole.disabled = false
		door_anim.play("unlock")

	else:
		hole.disabled = true
		door_anim.play("locked")

func _on_pressed() -> void:
		get_tree().change_scene_to_file("res://scenes/level_" + str(level_number) + ".tscn")
