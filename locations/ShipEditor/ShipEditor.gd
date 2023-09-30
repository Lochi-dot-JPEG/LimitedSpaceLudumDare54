extends Control
@onready var snap_points: Control = $Ship/Snap_Points

var part_node = preload("res://locations/ShipEditor/UIPART/part.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_load_parts()

func _load_parts():
	for i in get_children():
		if i.is_in_group("part"):
			i.queue_free()
	var index = 0
	var created_parts = []
	for i in Stats.player_parts:
		if i == null:
			index += 1
			continue
		var new_part = part_node.instantiate()
		new_part.type = i
		add_child(new_part)
		new_part.global_position = snap_points.get_node(str(index+1)).global_position
		new_part._scan_for_others()
		new_part._attach_to_part(index)
		created_parts.append(new_part)
		index += 1
	if Stats.crate_reward != "":
		var new_part = part_node.instantiate()
		new_part.type = Stats.crate_reward
		add_child(new_part)
		
		
		Stats.crate_reward = ""
		new_part.global_position = Vector2(856, 272)
		new_part._scan_for_others()
	for i in created_parts:
		i._scan_for_others()

func _on_button_pressed() -> void:
	var part_info = []
	part_info.resize(12)
	for i in get_tree().get_nodes_in_group("part"):
		if not i.attached_to == null:
			part_info[int(String(i.attached_to.name)) - 1] = i.type
	
	Stats.player_parts = part_info
	Stats._update_weight()
	Sound._play_sound("return")
	get_tree().change_scene_to_file("res://locations/battlefield.tscn")
	
