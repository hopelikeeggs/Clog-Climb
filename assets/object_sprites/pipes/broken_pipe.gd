extends Area2D

@onready var anim =$AnimatedSprite2D
var triggered := false

func _on_body_entered(body):
	if triggered:
		return              # stops repeat triggers
		
	if body is CharacterBody2D:
		triggered = true    # lock it
		anim.play("break")
		await anim.animation_finished
		body.start_pipe_fall()
