extends Area2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

var cleaned := false

func _ready():
	add_to_group("drain_trash")

func clean_drain():
	if cleaned:
		return
		
	cleaned = true
	
	# Disable collision immediately
	collision.disabled = true
	
	# Play animation if exists
	if anim.sprite_frames.has_animation("drain_cleaning"):
		anim.play("drain_cleaning")
	else:
		queue_free()

func _on_animated_sprite_2d_animation_finished():
	if anim.animation == "drain_cleaning":
		queue_free()
