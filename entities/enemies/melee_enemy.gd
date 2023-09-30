extends Enemy

@export var acceleration = 0.5
var velocity : Vector2
var drag = 0.97
var direction : Vector2

var _check_direction_timer = 0.0
func _physics_process(delta: float) -> void:
	if not move_tween or not move_tween.is_running():
		var _inaccuracy_offset = Vector2(randi_range(-100,100),randi_range(-100,100))
		var _extra = global_position.direction_to(player.global_position + _inaccuracy_offset) * randi_range(50,400)
		_queue_move_to_point(player.global_position + _extra + _inaccuracy_offset)


func _recheck_direction():
	direction = global_position.direction_to(player.global_position)

func _on_ready():
	type = "e_melee"
	
	$AttackPlayer.connect("body_entered",Callable(self,"_body_entered"))


func _body_entered(body):
	if body.is_in_group("player"):
		Stats._take_player_health(Stats.damage[type])
