extends HSlider

@export var audio_bus_name: String

var audio_bus_id: int

func _ready():
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name)
	
	# Restore slider value, 0 if muted
	if AudioServer.is_bus_mute(audio_bus_id):
		value = 0
	else:
		value = GlobalAutoLoad.slider_values.get(audio_bus_name, 1.0)
	

func _on_value_changed(new_value: float) -> void:
	GlobalAutoLoad.slider_values[audio_bus_name] = new_value
	
	# Update last active only if not muted
	if not AudioServer.is_bus_mute(audio_bus_id):
		GlobalAutoLoad.last_active_values[audio_bus_name] = new_value
	
	# Update audio bus volume
	var db = linear_to_db(new_value)
	AudioServer.set_bus_volume_db(audio_bus_id, db)
