extends Control

@onready var mech1: = $Panel/mechanics2
@onready var mech2: = $Panel/mechanics


func _on_next_pressed() -> void:
	if mech1.visible:
		mech2.visible = true
		mech1.visible = false


func _on_back_pressed() -> void:
	if mech2.visible:
		mech1.visible = true
		mech2.visible = false
