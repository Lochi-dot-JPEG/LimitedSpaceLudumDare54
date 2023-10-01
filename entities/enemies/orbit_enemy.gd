extends Enemy

var velocity : Vector2
const acceleration = 20
const drag = 0.9
var shoot_timer : Timer

var orbit_direction = 1
var orbit_countdown = 0.0
# Called when the node enters the scene tree for the first time.
func _on_ready() -> void:
	type = "e_orbit"
	shoot_timer = Timer.new()
	add_child(shoot_timer)
	shoot_timer.wait_time = 5
	shoot_timer.connect("timeout",Callable(self,"_shoot"))
	shoot_timer.start()

func _physics_process(delta: float) -> void:
	orbit_countdown -= delta
	if orbit_countdown < 0:
		orbit_countdown += randf_range(1,10)
		orbit_direction = -orbit_direction
	#if not move_tween or not move_tween.is_running():
		#var _inaccuracy_offset = Vector2(randi_range(-100,100),randi_range(-100,100))
		#var _extra = global_position.direction_to(player.global_position + _inaccuracy_offset) * randi_range(50,400)
		#_queue_move_to_point(player.global_position + _extra + _inaccuracy_offset)
	var _inaccuracy_offset = Vector2(randi_range(-100,100),randi_range(-100,100))

	var p_pos = player.global_position + _inaccuracy_offset
	if global_position.distance_squared_to(p_pos) > 62500:
		velocity += global_position.direction_to(p_pos) * delta * acceleration
	else:
		velocity += global_position.direction_to(p_pos).rotated(deg_to_rad(70 * orbit_direction)) * delta * acceleration
	position += velocity 
	velocity *= drag
	rotation = velocity.angle()

func _shoot():
	_create_bullet(
			global_position.direction_to(player.global_position),
			Stats.speed[type],
			Stats.damage[type],
			Stats.lifetime[type]
	)
	print("orbit shoots")
