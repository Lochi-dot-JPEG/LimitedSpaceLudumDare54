extends Enemy

var velocity : Vector2
var acceleration = 70
var drag = 0.5
var shoot_timer : Timer
# Called when the node enters the scene tree for the first time.
func _on_ready() -> void:
	type = "e_orbit"
	shoot_timer = Timer.new()
	add_child(shoot_timer)
	shoot_timer.wait_time = 2
	shoot_timer.connect("timeout",Callable(self,"_shoot"))
	shoot_timer.start()

func _physics_process(delta: float) -> void:
	#if not move_tween or not move_tween.is_running():
		#var _inaccuracy_offset = Vector2(randi_range(-100,100),randi_range(-100,100))
		#var _extra = global_position.direction_to(player.global_position + _inaccuracy_offset) * randi_range(50,400)
		#_queue_move_to_point(player.global_position + _extra + _inaccuracy_offset)
	velocity += global_position.direction_to(player.global_position).rotated(deg_to_rad(70)) * delta * acceleration
	
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
