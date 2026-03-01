extends CanvasLayer

@onready var heart_container = $"../ui/HBoxContainer"

func update_hearts(current_health: int):
	var hearts = heart_container.get_children()
	
	for i in range(hearts.size()):
		if i < current_health:
			hearts[i].visible = true
		else:
			hearts[i].visible = false
