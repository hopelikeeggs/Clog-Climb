extends Node

var intro_played := false
var timer = Timer.new()

# Current slider values
var slider_values := {
	"Master": 1.0,
	"Music": 1.0,
	"SFX": 1.0
}

# Store last non-muted values
var last_active_values := {
	"Master": 1.0,
	"Music": 1.0,
	"SFX": 1.0
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("globalAutoLoad ready")

	add_child(timer)
	timer.one_shot = true
	timer.start(3)
	
func _on_global_timer_timeout():
	print("global timeout in player.gd")
