extends CanvasLayer


func _update():
	$Control/Label2.text = "SCORE : " + str(int(Stats.score))
	$Control/Label3.text = "HISCORE : " + str(int(Stats.high_score))
	$Control/Label.text = "HP : " + str(Stats.player_health)
