extends Area2D

func _trigger_ladder_climb():

	var level = get_tree().current_scene

	if not level.level_completed:
		return

	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return

	# Disable player movement
	player.can_move = false

	# Play climb animation
	player.get_node("AnimatedSprite2D").play("climb")

	# Move player upward smoothly
	var tween = create_tween()
	tween.tween_property(player, "position:y", player.position.y - 200, 2.0)

	await tween.finished

	get_tree().paused = true
	get_tree().call_group("ui", "show_completed")
