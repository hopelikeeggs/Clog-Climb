extends Node

var unlocked_level: int = 2

func unlock_level(level_number: int):
	if level_number > unlocked_level:
		unlocked_level = level_number
