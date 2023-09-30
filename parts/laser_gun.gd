extends Part


func _ready():
	type = "laser"

func _use():
	var bullet_tween = create_tween().set_loops(10)
	bullet_tween.tween_callback(Callable(self,"_shoot")).set_delay(0.05)

func _shoot():
	var _dir = Vector2(cos(global_rotation),sin(global_rotation))
	_create_bullet(_dir,Stats.speed[type],Stats.damage[type],Stats.lifetime[type],false,false)
