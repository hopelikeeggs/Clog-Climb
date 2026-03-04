extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	add_to_group("trash")

func play_pickup():
	# Play animation if exists
	if sprite.sprite_frames.has_animation("trash_cleaning"):
		sprite.play("trash_cleaning")
	else:
		queue_free()

func _on_animated_sprite_2d_animation_finished():
	if sprite.animation == "trash_cleaning":
		queue_free()
