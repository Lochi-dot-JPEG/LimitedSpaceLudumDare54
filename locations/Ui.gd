extends CanvasLayer


func _update():
	
	$Control/Label.text = "HP : " + str(Stats.player_health)
