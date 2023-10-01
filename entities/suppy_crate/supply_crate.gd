extends Enemy

func _ready() -> void:
	add_to_group("save_this")
	_on_ready()
	# here to remove collision layer and mask change
	hp = Stats.hp[type]
	connect("area_entered",Callable(self,"_area_entered"))


func _on_ready() -> void:
	await get_tree().physics_frame
	type = "supply_crate"
	var _inaccuracy_offset = Vector2(randi_range(-100,100),randi_range(-100,100))
	_queue_move_to_point(Vector2.ZERO + _inaccuracy_offset)
	connect("body_entered",Callable(self,"_body_entered"))


func _area_entered(_area):
	pass
	# this is here so that the crate cant take damage


func _body_entered(body):
	print(body)
	if body.is_in_group("player"):
		remove_from_group('save_this')
		Sound._play_sound("powerup")
		Stats.crate_reward = Stats.parts.keys().pick_random()
		if is_instance_valid(Stats.player):
			Stats.player_position_save = Stats.player.position
		get_node("../EnemySpawner")._save_enemies()
		get_tree().call_deferred("change_scene_to_file","res://locations/ShipEditor/ShipEditor.tscn")
