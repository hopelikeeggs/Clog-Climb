extends TextureButton

@export var audio_bus_name: String
@onready var slider := $"../Audio_control2"  # or get_node to your slider

var audio_bus_id: int

func _ready():
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name)

func _on_pressed() -> void:
	var is_muted = AudioServer.is_bus_mute(audio_bus_id)
	
	# Toggle mute
	AudioServer.set_bus_mute(audio_bus_id, not is_muted)
	
	if not is_muted:
		# We just muted → slider goes to 0 visually
		slider.value = 0
	else:
		# We just unmuted → restore last active value
		slider.value = GlobalAutoLoad.last_active_values.get(audio_bus_name, 1.0)
