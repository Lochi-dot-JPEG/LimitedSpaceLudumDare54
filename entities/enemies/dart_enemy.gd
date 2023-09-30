extends Enemy

@export var acceleration = 0.2
var velocity : Vector2
var drag = 0.97
var direction : Vector2
@onready var view_size = Vector2(ProjectSettings.get_setting_with_override("display/window/size/viewport_width"),ProjectSettings.get_setting_with_override("display/window/size/viewport_height"))
var _check_direction_timer = 0.0
func _physics_process(_delta: float) -> void:
	if not move_tween or not move_tween.is_running():
		_shoot()
		var pos = Vector2(randi_range(0,view_size.x),randi_range(0,view_size.y))
		while pos == global_position:
			pos = Vector2(randi_range(0,view_size.x),randi_range(0,view_size.y))
		print(pos)
		_queue_move_to_point(pos)


func _recheck_direction():
	direction = global_position.direction_to(player.global_position)
func _on_ready():
	type = "e_dart"

func _body_entered(body):
	if body.is_in_group("player"):
		Stats._take_player_health(Stats.damage[type])

func _shoot():
	_create_bullet(
			global_position.direction_to(player.global_position),
			Stats.speed[type],
			Stats.damage[type],
			Stats.lifetime[type]
	)
