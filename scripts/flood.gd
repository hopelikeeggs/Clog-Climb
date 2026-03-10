extends Area2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	add_to_group("flood")

func start_flood():
	anim.play("flood_up")
	anim_player.play("up")
