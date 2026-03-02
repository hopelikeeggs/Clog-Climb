func _trigger_ladder_climb():

	var level = get_tree().current_scene

	if not level.level_completed:
		return

	# Hide playable character
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.visible = false

	# Spawn ladder climb scene
	var climb_instance = ladder_climb_scene.instantiate()
	level.add_child(climb_instance)
	climb_instance.position = position

	# Hide ALL AnimatedSprite2D characters first
	for child in climb_instance.get_children():
		if child is AnimatedSprite2D:
			child.visible = false

	# Show only selected character
	var selected_name = PlayerData.selected_character_name
	var selected_character = climb_instance.get_node(selected_name)

	if selected_character:
		selected_character.visible = true

		# Play climb animation if your AnimatedSprite has one
		selected_character.play("climb")

	# Play AnimationPlayer if you're using position animation
	var anim_player = climb_instance.get_node("AnimationPlayer")
	anim_player.play("up")

	await anim_player.animation_finished

	get_tree().paused = true
	get_tree().call_group("ui", "show_completed")
