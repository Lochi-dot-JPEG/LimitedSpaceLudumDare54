extends Enemy


func _physics_process(delta: float) -> void:
	pass


func _on_ready():
	type = "e_melee"
	
	$AttackPlayer.connect("body_entered",Callable(self,"_body_entered"))


func _body_entered(body):
	if body.is_in_group("player"):
		Stats._take_player_health(Stats.damage[type])
