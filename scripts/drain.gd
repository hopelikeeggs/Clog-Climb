extends Area2D

@onready var anim = $AnimatedSprite2D
var cleaned := false

func _on_body_entered(body):
	if body.is_in_group("player") and not cleaned:
		
		var level = get_tree().current_scene
		
		# Only allow cleaning if all trash collected
		if level.collected_trash >= level.total_trash:
			
			cleaned = true
			anim.play("drain_cleaning")   # drain animation
			
			# Tell player to play cleaning animation
			body.play_clean_animation()
			
			level.cleaned_drains += 1
			print("Drain:", level.cleaned_drains, "/", level.total_drains)
			
			level.check_level_complete()
		else:
			print("Collect all trash first!")
