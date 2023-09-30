extends Part


func _ready():
	type = "basic"

func _use():
	var _dir = Vector2(cos(global_rotation),sin(global_rotation))
	_create_bullet(_dir,Stats.speed[type],Stats.damage[type],Stats.lifetime[type])
