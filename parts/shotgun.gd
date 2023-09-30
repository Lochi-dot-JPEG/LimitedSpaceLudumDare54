extends Part

const spread = 70
func _ready():
	type = "shotgun"

func _use():
	for i in 9:
		var rot = deg_to_rad(spread / 9 * i - spread/2) + global_rotation
		var dir = Vector2(cos(rot),sin(rot))
		_create_bullet(dir,Stats.speed[type],Stats.damage[type],Stats.lifetime[type])
# Called every frame. 'delta' is the elapsed time since the previous frame.
