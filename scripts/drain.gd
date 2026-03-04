extends Area2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	add_to_group("drain_trash")

func clean_drain():
	# Play animation if exists
	if anim.sprite_frames.has_animation("drain_cleaning_up"):
		anim.play("drain_cleaning_up")
	else:
		queue_free()

func _on_animated_sprite_2d_animation_finished():
	if anim.animation == "drain_cleaning_up":
		queue_free()
