extends Node

const SAVE_FILE: String = "user://save_file.json"
const DEFAULT_LEVEL: int = 1


func save_game(level: int) -> void:
	var file: FileAccess = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	if file == null:
		push_error("Error opening file")
		return
	
	file.store_line(str(level))
	file.close()


func load_game() -> int:
	if FileAccess.file_exists(SAVE_FILE):
		var file: FileAccess = FileAccess.open(SAVE_FILE, FileAccess.READ)
		if file == null:
			push_error("Error reading file")
			return DEFAULT_LEVEL
		
		var level_text: String = file.get_line()
		file.close()
		
		return int(level_text)
	
	return DEFAULT_LEVEL
