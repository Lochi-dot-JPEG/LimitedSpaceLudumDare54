extends Control

func _on_button_pressed() -> void:
	Stats.player_position_save = Vector2.ZERO
	Stats.enemy_position_save = []
	Stats.score = 0
	Stats.player_parts = Stats.default_layout
	Stats.player_health = 10
	Stats.enemy_spawn_rate = Stats.base_spawn_rate
	get_tree().change_scene_to_file("res://locations/ShipEditor/ShipEditor.tscn")

func _ready():
	if Stats.high_score > 0:
		$High.show()
		$High.text = "HISCORE : " + str(int(Stats.high_score))
		$Last.text = "SCORE : " + str(int(Stats.score))
