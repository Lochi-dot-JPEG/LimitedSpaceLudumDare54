extends Enemy

func _ready() -> void:
	_on_ready()
	# here to remove collision layer and mask change
	hp = Stats.hp[type]
	connect("area_entered",Callable(self,"_area_entered"))


func _on_ready() -> void:
	await get_tree().physics_frame
	type = "supply_crate"
	var _inaccuracy_offset = Vector2(randi_range(-100,100),randi_range(-100,100))
	_queue_move_to_point(Vector2(475,275) + _inaccuracy_offset)
	connect("body_entered",Callable(self,"_body_entered"))


func _area_entered(area):
	pass
	# this is here so that the crate cant take damage

#
func _body_entered(body):
	print(body)
	if body.is_in_group("player"):
		Stats.crate_reward = Stats.parts.keys().pick_random()
		get_tree().call_deferred("change_scene_to_file","res://locations/ShipEditor/ShipEditor.tscn")
