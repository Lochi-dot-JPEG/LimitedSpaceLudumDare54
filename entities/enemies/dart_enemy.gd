extends Enemy

@export var acceleration = 0.2
var velocity : Vector2
var drag = 0.97
var direction : Vector2
@onready var view_size = Vector2(ProjectSettings.get_setting_with_override("display/window/size/viewport_width"),ProjectSettings.get_setting_with_override("display/window/size/viewport_height"))
var _check_direction_timer = 0.0
var _range = []
var just_appeared = true
func _physics_process(_delta: float) -> void:
	if not move_tween or not move_tween.is_running():
		if just_appeared:
			just_appeared = false
		else:
			_shoot()
		var pos = Vector2(randi_range(_range[0].x,_range[1].x),randi_range(_range[0].y,_range[1].y))
		while pos == global_position:
			pos = Vector2(randi_range(_range[0].x,_range[1].x),randi_range(_range[0].y,_range[1].y))
		print(pos)
		_queue_move_to_point(pos)


func _recheck_direction():
	direction = global_position.direction_to(player.global_position)
func _on_ready():
	_range = [-view_size/2,view_size/2]
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
