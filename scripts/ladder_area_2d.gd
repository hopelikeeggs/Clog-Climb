extends Area2D

@export var ladder_climb_scene: PackedScene  # Reference to the ladder climb animation scene

# Flag to check if the player is inside the ladder area
var is_player_in_ladder_area := false

# Handle input detection (e.g., "E" key press)
func _input(event):
	if event.is_action_pressed("climb"):  # "ui_accept" is typically mapped to the "E" key by default
		if is_player_in_ladder_area:
			# Trigger the ladder climb when "E" is pressed
			_trigger_ladder_climb()

# The function that handles player entering the ladder area
func _on_body_entered(body):
	if body.is_in_group("player"):
		is_player_in_ladder_area = true  # Player is inside the ladder area

# Handle the player exiting the ladder area
func _on_body_exited(body):
	if body.is_in_group("player"):
		is_player_in_ladder_area = false  # Player has exited the ladder area

# Function to trigger the ladder climb animation
func _trigger_ladder_climb():
	var level = get_tree().current_scene

	if level.level_completedd:

		# Instantiate the ladder climb animation scene
		var ladder_climb_instance = ladder_climb_scene.instantiate()
		get_tree().current_scene.add_child(ladder_climb_instance)

		# Set the ladder climb animation scene's position to the ladder's position (optional)
		ladder_climb_instance.position = position  # Optional: match the animation position to the ladder

		# Play the ladder climb animation
		var animation_player = ladder_climb_instance.get_node("AnimationPlayer")
		animation_player.play("up")  # Replace with your actual animation name

		# Wait for the animation to finish
		await animation_player.animation_finished

		# Once the animation finishes, show the level complete popup
		get_tree().paused = true
		get_tree().call_group("ui", "show_completed")
