extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	var part_info = []
	part_info.resize(12)
	for i in get_tree().get_nodes_in_group("part"):
		if not i.attached_to == null:
			print(i.attached_to.name)
			part_info[int(String(i.attached_to.name)) - 1] = i.type
	
	Stats.player_parts = part_info
	
	
	get_tree().change_scene_to_file("res://locations/battlefield.tscn")

