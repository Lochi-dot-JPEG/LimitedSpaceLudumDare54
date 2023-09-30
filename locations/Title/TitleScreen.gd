extends Control

func _on_button_pressed() -> void:
	Stats.enemy_spawn_rate = Stats.base_spawn_rate
	get_tree().change_scene_to_file("res://locations/battlefield.tscn")
