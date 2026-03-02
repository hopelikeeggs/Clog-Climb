extends Area2D

@onready var sprite := $AnimatedSprite2D

func _ready():
	pass

func play_pickup():
	get_tree().current_scene.trash_collected()
	
	if sprite.sprite_frames.has_animation("trash_cleaning"):
		sprite.play("trash_cleaning")
	else:
		queue_free()
		
func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "trash_cleaning":
		queue_free()
